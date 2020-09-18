<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			$(document).ready(function() {
				$("#AnswerSummernote").summernote({
					height: 233,
					maxHeight: 233,
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
				$("#answerTitle").focus();
			});
		</script>
	</head>
	<body>
		<c:if test="${null ne getQuestions}">
			<div class="card bg-dark mb-0">
				<div class="helpDesk-header d-flex justify-content-between align-items-center">
					<div class="header-title">
						<h4><b>${getQuestions.title}</b></h4>
						<h6 class="text-muted mb-0">등록 일시: ${getQuestions.createdOn}<span class="mr-2 ml-2">|</span>작성자: ${getQuestions.questionerID}</h6>
					</div>
				</div>
				<div class="helpDesk-body text-default helpDesk-type-3">${getQuestions.question}</div>
			</div>
			
			<div class="card bg-dark mb-0">
				<div class="helpDesk-header border-top-light">
					<div class="row">
						<label class="col-xl-1 col-sm-2 mb-0 d-flex align-items-center">답변 제목:<span class="text-prom ml-2">(필수)</span>
						</label>
						<div class="col-xl-11 col-sm-10">
							<input type="text" class="form-control" id="answerTitle" value="RE: ${getQuestions.title}" readonly="readonly">
						</div>
					</div>
				</div>
				<div class="helpDesk-body">
					<div id="AnswerSummernote"></div>
				</div>
				<div class="helpDesk-footer justify-content-end">
					<button type="button" class="btn btn-outline bg-prom text-prom border-prom border-2 rounded-round" onclick="setCancel()">등록 취소</button>
					<button type="button" class="btn bg-prom rounded-round ml-2-5" onclick="setAnswer()">답변 등록<i class="icon-checkmark2 ml-2"></i></button>
					<input type="hidden" value="${sessionUserNameEL}" id="hid"> 
					<input type="hidden" value="${getQuestions.title}" id="title"> 
					<input type="hidden" value="${getQuestions.id}" id="id">
				</div>
			</div>
			
			<script>
				var temp_FilesName = new Array();
				var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
				var maxSize = 52428800;
	
				function deleteImage(image) {
					
					if(!image || image.length == 0) return;
					
					var imageUrl = '';
					
					// image 배열의 첫번째는 값이 없어서 for문을 1로 시작한다
					for(var i = 1; i < image.length; i++) {
						imageUrl += "/" + image[i];
					}
					
					var deleteFilesName = new Array();
					deleteFilesName.push(imageUrl);
					
					$.ajax({
						url: "/support/deleteImageFile.do",
						type: "POST",
						traditional : true,
						data: {
							test: test
						},
						success: function(data) {
							var idx = temp_FilesName.indexOf(imageUrl);
							if (idx != -1) {
								temp_FilesName.splice(idx, 1);
							}
							if (temp_FilesName.length == 0) {
								$('#AnswerSummernote').summernote('editor.insertText', ' ');
							}
						}
					});
				}
	
				function sendFile(file) {
					var number = 1;
					var form_data = new FormData();
					form_data.append('file', file);
					form_data.append('number', number);
					$.ajax({
						data: form_data,
						type: "POST",
						url: "/support/uploadImageFile.do",
						cache: false,
						contentType: false,
						enctype: 'multipart/form-data',
						processData: false,
						success: function(data) {
							if (data.result == 1) {
								$("#AnswerSummernote").summernote(
										'editor.insertImage', data.tempPath);
									temp_FilesName.push(data.tempPath);
							} else if (data.result == 2) {
								alert("gif, jpg, png, jpeg 확장자만 업로드 가능합니다.");
							} else {
								alert("파일 업로드 중에 에러가 발생했습니다.");
							}
						}
					});
				}
	
				function checkExtension(fileName, fileSize) {
					if (fileSize >= maxSize) {
						alert("파일 사이즈 초과");
						return false;
					}
					if (regex.test(fileName)) {
						alert("exe,sh,zip,alz의 확장자는 업로드 할 수 없습니다.");
						return false;
					}
					return true;
				}
	
				function getPageName() {
					var pageName = "";
					var tempPageName = window.location.href;
					var strPageName = tempPageName.split("/data")[0];
					return strPageName;
				}
	
				function setAnswer() {
					var title = $("#answerTitle").val();
					var id = $("#id").val();
					var contents = $('#AnswerSummernote').summernote('code');
					var hid = $("#hid").val();
					if (title.trim() == '') {
						alert("제목은 필수 기입 항목입니다.");
						$("#noticesTtile").focus();
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
						url: "/support/insertAnswer.do",
						traditional : true,
						data: {
							id: id,
							answer: contents,
							answerID: hid,
							title : $("#title").val(),
							tempFilesName: temp_FilesName
						},
						success: function(data) {
							location.href = '/data/questions.do';
						}
					});
				}
	
				function setCancel() {
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
			</script>
		</c:if>
	</body>
</html>