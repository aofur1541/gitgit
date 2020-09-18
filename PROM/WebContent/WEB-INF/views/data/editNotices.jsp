<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			var temp_FilesName = new Array();
			$(document).ready(function() {
				var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
				var maxSize = 52428800;
	
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
				$("#noticesTtile").focus();
				/* $("#customFile").on("change", function(e) {
					var formData = new FormData();
					var inputFile = $("input[name='uploadFile']");
					var files = inputFile[0].files;
					for (var i = 0; i < files.length; i++) {
						if (!checkExtension(files[i].name, files[i].size)) {
							return false;
						}
						formData.append("uploadFile", files[i]);
					}
					$.ajax({
						url : 'sup/uploadFile.do',
						contentType : false,
						processData : false,
						data : formData,
						type : 'POST',
						success : function(data) {
						 	$.each(data, function(index, value) {
								console.log(index + " : " + data[index]);
								$('.notices-file').append("<div>"+data[index]+"</div>");
							}); 
						}
					});
				});
				*/
			});
	
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
						if (data.result == 1) {
							$("#noticesSummernote").summernote('editor.insertImage', data.tempPath);
							temp_FilesName.push(data.tempPath);
						} else if (data.result == 2) {
							alert("gif, jpg, png, jpeg 확장자만 업로드 가능합니다.");
						} else {
							alert("파일 업로드 중에 에러가 발생했습니다.");
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
	
			function setNotice() {
				var title = $("#noticesTtile").val();
				var contents = $('#noticesSummernote').summernote('code');
				var encode = encodeURIComponent(contents);
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
					url: "/support/insertNotice.do",
					traditional : true,
					data: {
						title: title,
						contents: contents,
						writerID: hid,
						tempFilesName: temp_FilesName
					},
					success: function() {
	
					}
				});
				//setNoticeLog();
				location.href = '/data/notices.do';
			}
	
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
					data: { tempFilesName: deleteFilesName },
					success: function(data) {
						var idx = temp_FilesName.indexOf(imageUrl);
						if (idx != -1) {
							temp_FilesName.splice(idx, 1);
						} 
						if (temp_FilesName.length == 0) {
							$('#noticesSummernote').summernote('editor.insertText', ' ');
						}
					}
				});
			}
	
			function setCancel() {
				
				if(temp_FilesName.length > 0) {
					$.ajax({
						url: "/support/deleteImageFile.do",
						type: "POST",
						traditional : true,
						data: { tempFilesName: temp_FilesName }
					});
				}
				
				location.href = 'notices.do';
			}
		</script>
	</head>
	<body>
		<div class="card bg-dark mb-0">
			<div class="helpDesk-header">
				<div class="row">
					<label class="col-xl-1 col-sm-2 mb-0 d-flex align-items-center">제목:<span class="text-prom ml-2">(필수)</span></label>
					<div class="col-xl-11 col-sm-10">
						<input type="text" class="form-control" placeholder="제목을 입력하십시오. (100자 이내)" autocomplete="off" maxlength="100" id="noticesTtile">
					</div>
				</div>
			</div>
			<!-- <div class="form-group notices-form-group row">
				<label class="col-xl-1 col-sm-2 col-form-label">첨부파일:</label>
				<div class="col-xl-11 col-sm-10">
					<div class="custom-file">
						<p>
							<input type="file" class="custom-file-input cpointer"
								id="customFile" name="uploadFile" multiple="multiple" /> <label
								class="custom-file-label text-muted" for="customFile">
								첨부할 파일을 선택하십시오.</label>
						</p>
					</div>
				</div>
			</div>
			<div class="notices-file">
			</div> -->
			<div class="helpDesk-body" id="contents">
				<div id="noticesSummernote"></div>
			</div>
			<div class="helpDesk-footer justify-content-end">
				<button type="button" class="btn btn-outline bg-prom text-prom border-prom border-2 rounded-round" onclick="setCancel()">등록 취소</button>
				<button type="button" class="btn bg-prom rounded-round ml-2-5" id="setNotice" onclick="setNotice()">
					공지 등록<i class="icon-checkmark2 ml-2 mr-0"></i>
				</button>
				<input type="hidden" value="${sessionUserNameEL}" id="hid">
			</div>
		</div>
	</body>
</html>