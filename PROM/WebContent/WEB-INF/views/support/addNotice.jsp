<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>

		<!-- 본문 시작 -->
		<div class="content">

			<!-- 타이틀 -->
			<div class="table-header"><h6>공지 등록</h6></div>

			<!-- 텍스트 에디터 카드 -->
			<div class="card textEditor-card">
				<div class="card-header">
					<label class="mb-0">제목 : </label>
					<input type="text" class="form-control mb-0" placeholder="제목을 입력해 주세요. (100자 이내)" autocomplete="off" maxlength="100" id="noticeTtile">
				</div>
				<div class="card-body">
					<div id="noticeSummernote"></div>
				</div>
			</div>

			<!-- 등록 버튼 -->
			<div class="textEditor-button">
				<button type="button" class="btn" onclick="insertNotice()">등록</button>
				<button type="button" class="btn cancelBtn" onclick="insertCancel()">취소</button>
				<input type="hidden" value="${sessionUserName}" id="hid">
			</div>
		</div>
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		var tempFilesName = new Array();
		var regex = new RegExp('(.*?)\.(exe|sh|zip|alz)$');
		var maxSize = 52428800;
		
		$(document).ready(function() {
			$('#noticeTtile').focus();
			
			// 공지 에디터 설정
			$('#noticeSummernote').summernote({
				height: 500,
				focus: false,
				lang: 'ko-KR',
				disableDragAndDrop: true,
				callbacks: {
					onImageUpload: function(files, editor, welEditable) {
						sendFile(files[0], editor, welEditable);
					},
					onMediaDelete: function(target) {
						var imageUrl = $(target[0]).attr('src');
						var image = imageUrl.split('/');
						
						deleteImage(image);
					}
				}
			});
			
			// 파일 체크
			function checkExtension(fileName, fileSize) {
				if (fileSize >= maxSize) {
					alert('업로드 가능한 파일 사이즈를 초과하였습니다.');
					return false;
				}
				
				if (regex.test(fileName)) {
					alert('exe, sh, zip, alz 등의 확장자는 업로드 할 수 없습니다.');
					return false;
				}
				
				return true;
			}
		});
		
		// 파일 보내기
		function sendFile(file) {
			var number = 0;
			var form_data = new FormData();
			
			form_data.append('file', file);
			form_data.append('number', number);
			
			$.ajax({
				url: '/support/uploadImageFile.do',
				type: 'POST',
				data: form_data,
				cache: false,
				contentType: false,
				enctype: 'multipart/form-data',
				processData: false,
				success: function(data) {
					
					// 성공
					if (data.result == 1) {
						$("#noticeSummernote").summernote('editor.insertImage', data.tempPath);
						tempFilesName.push(data.tempPath);
					
					// 실패
					} else if (data.result == 2) {
						alert('gif, jpg, png, jpeg 확장자만 업로드 할 수 있습니다.');
						return false;
					
					} else {
						alert('파일 업로드에 실패했습니다.');
						return false;
					}
				}
			});
		}
	
		function getPageName() {
			var pageName = '';
			var tempPageName = window.location.href;
			var strPageName = tempPageName.split('/data')[0];
			
			return strPageName;
		}
	
		// 공지 등록
		function insertNotice() {
			var title = $('#noticeTtile').val();
			var contents = $('#noticeSummernote').summernote('code');
			var encode = encodeURIComponent(contents);
			var hid = $('#hid').val();
			
			if (title.trim() == '') {
				alert('제목을 입력해 주세요.');
				$('#noticeTtile').focus();
				return false;
			}
			
			if (contents.trim() == '' || contents == '<p><br></p>') {
				alert('내용을 입력해 주세요.');
				return false;
			}
	
			function replaceAll(str, searchStr, replaceStr) {
				return str.split(searchStr).join(replaceStr);
			}
	
			if (contents.indexOf(getPageName()) != -1) {
				contents = replaceAll(contents, getPageName(), '');
			}
	
			$.ajax({
				url: '/support/insertNotice.do',
				type: 'POST',
				traditional: true,
				data: {
					title: title,
					contents: contents,
					writerID: hid,
					tempFilesName: tempFilesName
				},
				success: function(data) {
					alert('공지 등록이 완료되었습니다.');
					location.href = '/support/notice.prom';
				}
			});
		}
		
		// 등록 취소
		function insertCancel() {
			
			// 취소 확인
			if (confirm('공지 등록을 취소하시겠습니까?') == true) {
				if (tempFilesName.length > 0) {
					$.ajax({
						url: '/support/deleteImageFile.do',
						type: 'POST',
						traditional : true,
						data: {
							tempFilesName: tempFilesName,
						}
					});
				}
				location.href = '/support/notice.prom';
			
			} else {
				return false;
			}
		}
	
		// 이미지 삭제
		function deleteImage(image) {
			var imageUrl = '';
			var deleteFilesName = new Array();
			
			if (!image || image.length == 0) return;
			deleteFilesName.push(imageUrl);
	
			// image 배열의 첫번째는 값이 없어서 for문을 1로 시작한다
			for (var i = 1; i < image.length; i++) {
				imageUrl += "/" + image[i];
			}
	
			$.ajax({
				url: '/support/deleteImageFile.do',
				type: 'POST',
				traditional: true,
				data: {
					tempFilesName: deleteFilesName
				},
				success: function(data) {
					var idx = tempFilesName.indexOf(imageUrl);
					
					if (idx != -1) {
						tempFilesName.splice(idx, 1);
					}
					
					if (tempFilesName.length == 0) {
						$('#noticeSummernote').summernote('editor.insertText', ' ');
					}
				}
			});
		}
	</script>
</body>

</html>