<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
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
				$("#questionsSummernote").summernote({
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
				$("#questionsTitle").focus();
			});
		</script>
	</head>
	<body>
		<c:if test="${null ne updateQuestions}">
			<div class="card bg-dark mb-0">
				<div class="helpDesk-header">
					<div class="row">
						<label class="col-xl-1 col-sm-2 mb-0 d-flex align-items-center">문의 제목:<span class="text-prom ml-2">(필수)</span></label>
						<div class="col-xl-11 col-sm-10">
							<input type="text" class="form-control" placeholder="제목을 입력하십시오. (100자 이내)" autocomplete="off" maxlength="100" id="questionsTitle" value="${updateQuestions.title}">
						</div>
					</div>
				</div>
				<div class="helpDesk-body">
					<div id="questionsSummernote">${updateQuestions.question}</div>
				</div>
				<div class="helpDesk-footer justify-content-end">
					<button type="button" class="btn btn-outline bg-prom text-prom border-prom border-2 rounded-round" onclick="updateCancel()">문의 취소</button>
					<button type="button" class="btn bg-prom rounded-round ml-2-5" onclick="updateQuestions()">문의 변경<i class="icon-checkmark2 ml-2"></i></button>
					<input type="hidden" value="${sessionUserNameEL}" id="hid">
					<input type="hidden" value="${updateQuestions.id}" id="id">
				</div>
			</div>
		</c:if>
		<script>
			var temp_FilesName = new Array();
			var temp_DeleteName = new Array();
	
			function updateCancel() {
				
				if(temp_FilesName.length > 0) {
					$.ajax({
						url: "/support/deleteImageFile.do",
						type: "POST",
						traditional : true,
						data: {
							tempFilesName: temp_FilesName
						}
					});
				}
				location.href = '/data/questions.do';
			}
	
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
					temp_DeleteName.push(imageUrl);
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
							var idx = temp_FilesName.indexOf(imageUrl);
							if (idx != -1) {
								temp_FilesName.splice(idx, 1);
							}
							if (temp_FilesName.length == 0) {
								$('#questionsSummernote').summernote(
									'editor.insertText', ' ');
							}
						}
					});
				}
			}
	
			function sendFile(file) {
				var number = 1;
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
							$("#questionsSummernote").summernote(
								'editor.insertImage', data.tempPath);
							temp_FilesName.push(data.tempPath);
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
	
			function updateQuestions() {
				var id = $("#id").val();
				var title = $("#questionsTitle").val();
				var contents = $('#questionsSummernote').summernote('code');
				var hid = $("#hid").val();
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
					url: "/support/updateQuestion.do",
					traditional : true,
					data: {
						id: id,
						title: title,
						question: contents,
						questionerID: hid,
						tempFilesName: temp_FilesName,
						tempDeleteName: temp_DeleteName
					},
					success: function(data) {
						window.location.href = '/data/viewQuestion.do?id=' + id;
					}
				});
			}
		</script>
	</body>
</html>