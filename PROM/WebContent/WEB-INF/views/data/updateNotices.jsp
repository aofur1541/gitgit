<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
	</head>
	<body>
		<script type="text/javascript">
			var tempFilesName = new Array();
			var tempDeleteName = new Array();
			$(document).ready(function() {
				document.onkeydown = function(e) {
					key = (e) ? e.keyCode : event.keyCode;
					ctrl = (e) ? e.ctrlKey : event.ctrlKey;

					if ((ctrl == true && (key == 78 || key == 82)) || key == 116) {
						if (e) {
							e.preventDefault();
							alert("이 페이지에서 새로 고침을 할 수 없습니다.");
						} else {
							event.keyCode = 0;
							event.returnValue = false;
						}
					}
				}
			    window.onbeforeunload = function(){
			    	updateCancel();
			    }
				$("#noticesSummernote").summernote({
					height: 482,
					maxHeight: 482,
					focus: false,
					lang: "ko-KR",
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
			});
		</script>
	
		<c:if test="${null ne notice}">
			<div class="card bg-dark mb-0">
				<div class="helpDesk-header">
					<div class="row">
						<label class="col-xl-1 col-sm-2 mb-0 d-flex align-items-center">제목:<span class="text-prom ml-2">(필수)</span></label>
						<div class="col-xl-11 col-sm-10">
							<input type="text" class="form-control" placeholder="제목을 입력하십시오. (100자 이내)" autocomplete="off" maxlength="100" id="noticesTtile" value="${notice.title}">
						</div>
					</div>
				</div>
				<div class="helpDesk-body" id="contents">
					<div id="noticesSummernote">${notice.contents}</div>
				</div>
				<div class="helpDesk-footer justify-content-end">
					<button type="button" class="btn btn-outline bg-prom text-prom border-prom border-2 rounded-round" onclick="updateCancel()">변경 취소</button>
					<button type="button" class="btn bg-prom rounded-round ml-2-5" id="updateNotice" onclick="updateNotice()">공지 변경<i class="icon-checkmark2 ml-2 mr-0"></i></button>
					<input type="hidden" value="${sessionUserNameEL}" id="hid">
				</div>
			</div>
			<input type="hidden" value="${notice.id}" id="id">
	
			<script type="text/javascript">
				function sendFile(file) {
					var number = 0;
					var form_data = new FormData();
					form_data.append('file', file);
					form_data.append('number', number);
					$.ajax({
						data: form_data,
						type: "POST",
						url: '/support/uploadImageFile.do',
						cache: false,
						contentType: false,
						enctype: 'multipart/form-data',
						processData: false,
						success: function(data) {
							if (data == null) {
								alert("gif, jpg, png, jpeg 확장자만 업로드 가능합니다.");
							} else {
								$("#noticesSummernote").summernote(
									'editor.insertImage', data.tempPath);
								tempFilesName.push(data.tempPath);
							}
						}
					});
				}
	
				function getPageName() {
					var pageName = "";
					var tempPageName = window.location.href;
					var strPageName = tempPageName.split("/data")[0];
					return strPageName;
				}
	
				function updateNotice() {
					var title = $("#noticesTtile").val();
					var contents = $('#noticesSummernote').summernote('code');
					var encode = encodeURIComponent(contents);
					var hid = $("#hid").val();
					var id = $("#id").val();
					if (title.trim() == '') {
						alert("제목은 필수 기입 항목입니다.");
						return false;
					}
	
					if (contents.trim() == '' || contents == "<p><br></p>") {
						alert("내용은 필수 기입 항목입니다.");
						return false;
					}
	
					function replaceAll(str, searchStr, replaceStr) {
						return str.split(searchStr).join(replaceStr);
					}
					if (contents.indexOf(getPageName()) != -1) {
						contents = replaceAll(contents, getPageName(), '');
					}
					
					$.ajax({
						type: "POST",
						url: "/support/updateNotice.do",
						traditional : true,
						data: {
							title: title,
							contents: contents,
							writerID: hid,
							id: id,
							tempFilesName: tempFilesName,
							tempDeleteName: tempDeleteName
						},
						success: function(data) {
							if (data == 1) {
								tempFilesName = new Array();
								window.location.href = '/data/viewNotice.do?id=' + id;
							} else {
								alert("공지사항 변경에 실패하였습니다.");
								return;
							}
						}
					});
				};
	
				function deleteImage(image) {
					
					if(!image || image.length == 0) return;
					
					var imageUrl = '';
					
					// image 배열의 첫번째는 값이 없어서 for문을 1로 시작한다
					for(var i = 1; i < image.length; i++) {
						imageUrl += "/" + image[i];
					}
					
					// 임시로 저장된 이미지(이번에 추가했다가 바로 삭제하는 경우)는 바로 지우고, 
					// 전에 저장했다가 이번에 삭제한 이미지는  [공지 변경] 버튼을 클릭했을 때 지운다.
					if(imageUrl.indexOf('/attachedFile/images/') > 0) {
						// 전에 저장했었던 이미지인 경우
						tempDeleteName.push(imageUrl);
					} else {
						// 임시 저장했었던 이미지인 경우
						// 바로 지운다.
						var deleteFilesName = new Array();
						deleteFilesName.push(imageUrl);
						
						$.ajax({
							url: "/support/deleteImageFile.do",
							type: "POST",
							traditional : true,
							data: { tempFilesName: deleteFilesName },
							success: function(data) {
								
								var idx = tempFilesName.indexOf(imageUrl);
								if (idx != -1) {
									tempFilesName.splice(idx, 1);
								} 
								if (tempFilesName.length == 0) {
									$('#noticesSummernote').summernote(
										'editor.insertText', ' ');
								}
							}
						});
					}
										
				}
	
				function updateCancel() {
					
					if(tempFilesName.length > 0) {
						$.ajax({
							url: "/support/deleteImageFile.do",
							type: "POST",
							traditional : true,
							data: { tempFilesName: tempFilesName }
						});
					}
					location.href = '/data/notices.do';
				}
			</script>
		</c:if>
	</body>
</html>