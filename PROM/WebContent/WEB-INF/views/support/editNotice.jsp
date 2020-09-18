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

	<c:if test="${null ne notice}">
		<div class="content-wrapper">
			<%@ include file="/WEB-INF/views/include/directory.jsp"%>

			<!-- 본문 시작 -->
			<div class="content">

				<!-- 타이틀 -->
				<div class="table-header"><h6>공지 변경</h6></div>

				<!-- 텍스트 에디터 카드 -->
				<div class="card textEditor-card">
					<div class="card-header">
						<label class="mb-0">제목 : </label>
						<input type="text" class="form-control mb-0" placeholder="제목을 입력해 주세요. (100자 이내)" autocomplete="off" maxlength="100" id="noticeTtile" value="${notice.title}">
					</div>
					<div class="card-body">
						<div id="noticeSummernote">${notice.contents}</div>
					</div>
				</div>

				<!-- 등록 버튼 -->
				<div class="textEditor-button">
					<button type="button" class="btn" onclick="updateNotice()">변경</button>
					<button type="button" class="btn cancelBtn" onclick="updateCancel()">취소</button>
					<input type="hidden" value="${sessionUserName}" id="hid">
				</div>

				<input type="hidden" value="${notice.id}" id="id">
			</div>
		</div>

		<script src="${path}/resource/js/sidebar.js"></script>
		<script type="text/javascript">
			var tempFilesName = new Array();
			var tempDeleteName = new Array();
			
			$(document).ready(function() {
				
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
				
				// 새로고침 금지
				document.onkeydown = function(e) {
					key = (e) ? e.keyCode : event.keyCode;
					ctrl = (e) ? e.ctrlKey : event.ctrlKey;

					if ((ctrl == true && (key == 78 || key == 82)) || key == 116) {
						if (e) {
							e.preventDefault();
							alert('이 페이지에서 새로 고침을 할 수 없습니다.');
						
						} else {
							event.keyCode = 0;
							event.returnValue = false;
						}
					}
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
					cache: false,
					contentType: false,
					enctype: 'multipart/form-data',
					processData: false,
					data: form_data,
					success: function(data) {
						if (data == null) {
							alert('gif, jpg, png, jpeg 확장자만 업로드 할 수 있습니다.');
							return false;
						
						} else {
							$('#noticeSummernote').summernote('editor.insertImage', data.tempPath);
							tempFilesName.push(data.tempPath);
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

			// 공지 변경
			function updateNotice() {
				var title = $('#noticeTtile').val();
				var contents = $('#noticeSummernote').summernote('code');
				var encode = encodeURIComponent(contents);
				var hid = $('#hid').val();
				var id = $('#id').val();
				
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
					url: '/support/updateNotice.do',
					type: 'POST',
					traditional: true,
					data: {
						title: title,
						contents: contents,
						writerID: hid,
						id: id,
						tempFilesName: tempFilesName,
						tempDeleteName: tempDeleteName
					},
					success: function(data) {
						
						// 성공
						if (data == 1) {
							alert('공지 변경이 완료되었습니다.');
							
							tempFilesName = new Array();
							location.href = '/support/viewNotice.prom?id=' + id;
						
						// 실패
						} else {
							alert('공지 변경에 실패했습니다.');
							return false;
						}
					}
				});
			}
			
			// 변경 취소
			function updateCancel() {
				
				// 취소 확인
				if (confirm('공지 변경을 취소하시겠습니까?') == true) {
					if (tempFilesName.length > 0) {
						$.ajax({
							url: '/support/deleteImageFile.do',
							type: 'POST',
							traditional: true,
							data: {
								tempFilesName: tempFilesName
							}
						});
					}
					var id = $('#id').val();
					location.href = '/support/viewNotice.prom?id=' + id;
					
				} else {
					return false;
				}
			}

			// 이미지 삭제
			function deleteImage(image) {
				var imageUrl = '';
				
				if (!image || image.length == 0) return;

				// image 배열의 첫번째는 값이 없어서 for문을 1로 시작한다
				for (var i = 1; i < image.length; i++) {
					imageUrl += "/" + image[i];
				}

				// 임시로 저장된 이미지(이번에 추가했다가 바로 삭제하는 경우)는 바로 지우고, 
				// 전에 저장했다가 이번에 삭제한 이미지는  [공지 변경] 버튼을 클릭했을 때 지운다.
				if (imageUrl.indexOf('/attachedFile/images/') > 0) {
					
					// 전에 저장했었던 이미지인 경우
					tempDeleteName.push(imageUrl);
				
				} else {
					
					// 임시 저장했었던 이미지인 경우
					// 바로 지운다.
					var deleteFilesName = new Array();
					
					deleteFilesName.push(imageUrl);

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
			}
		</script>
	</c:if>
</body>

</html>