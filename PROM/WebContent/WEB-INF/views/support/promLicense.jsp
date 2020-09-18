<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
	
	<link href="${path}/resource/css/license.css" rel="stylesheet" type="text/css">
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>
		
		<!-- 본문 시작 -->
		<div class="content">
			
			<!-- 라이선스 없을 때 - 등록  -->
			<div class="d-none" id="createLicense">
				<div class="row flex-fill">
					<div class="col-xl-6 offset-lg-3">
						<div class="contentLicense">
							<img src="${path}/resource/images/exclamation.svg"></img>
							<p><b>라이선스 없음</b></p>
							<p>라이선스가 없거나 만료되었습니다.</p>
							<p>라이선스가 없을 경우 일부 기능이 제한됩니다. 라이선스를 등록해 주세요.</p>
						</div>
						<div class="inputLicense">
							<input type="text" class="form-control" maxlength="8" id="inputLicense1">
							<input type="text" class="form-control" maxlength="4" id="inputLicense2">
							<input type="text" class="form-control" maxlength="4" id="inputLicense3">
							<input type="text" class="form-control" maxlength="4" id="inputLicense4">
							<input type="text" class="form-control" maxlength="12" id="inputLicense5">
							<button type="button" class="btn" onclick="createLicenseCheck()">등록하기</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 라이선스 있을 때 - 라이선스 보기  -->
			<div class="d-none" id="viewLicense">
				<div class="table-header"><h6><i class="fas fa-medal"></i>라이선스</h6></div>
				<div class="table-body" style="margin-bottom: 50px;">
					<table class="vertical-table">
						<tbody>
							<tr>
								<th width="20%"><br>등록된 라이선스<br><br></th>
								<td width="80%" id="licenseKey"></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="table-header"><h6><i class="fas fa-info-circle"></i>라이선스 정보</h6></div>
				<div class="table-body">
					<table class="vertical-table">
						<tbody>
							<tr>
								<th width="20%">이름</th>
								<td width="80%">PROM Cloud v.2.0.0</td>
							</tr>
							<tr>
								<th>수량</th>
								<td>엔진 2 식 / PROM For CPU License 30 COPY</td>
							</tr>
							<tr>
								<th>유형</th>
								<td>엔진 / CPU License</td>
							</tr>
							<tr>
								<th>연동</th>
								<td>vCenter</td>
							</tr>
							<tr>
								<th>만료 일자</th>
								<td id="effectiveDate"></td>
							</tr>
							<tr>
								<th>제작</th>
								<td>(주)케이디아이에스</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type = "text/javascript" >
		$(document).ready(function() {
			getPROMLicense();
		})
	
		function getPROMLicense() {
			$.ajax({
				url: "/support/selectLicense.do",
				success: function(data) {
					
					// 라이선스 없을 때
					if (data == null || data == '') {
						$('#createLicense').removeClass('d-none');
						$('#viewLicense').addClass('d-none');
						
						$('body').css('min-height', '100vh');
						$('.content').addClass('noLicense');
						
						$('#inputLicense1').focus();
		
					// 라이선스 있을 때
					} else {
						$('#createLicense').addClass('d-none');
						$('#viewLicense').removeClass('d-none');
						
						$('body').css('min-height', '');
						$('.content').removeClass('noLicense');
						
						$('#licenseKey').html(data.sSerialKey.substring(0, 8) + '-' + data.sSerialKey.substring(8, 12) + '-' + data.sSerialKey.substring(12, 16) + '-' + data.sSerialKey.substring(16, 20) + '-' + data.sSerialKey.substring(20, 32));
						$('#effectiveDate').html(data.dSerialStopTime);
					}
				}
			})
		}
		
		function createLicenseCheck() {
			var inputLicense1 = $('#inputLicense1').val();
			var inputLicense2 = $('#inputLicense2').val();
			var inputLicense3 = $('#inputLicense3').val();
			var inputLicense4 = $('#inputLicense4').val();
			var inputLicense5 = $('#inputLicense5').val();
			var license = inputLicense1 + inputLicense2 + inputLicense3 + inputLicense4 + inputLicense5;
			
			// 입력 체크
			if (!inputLicense1) {
				alert('라이선스를 입력해 주세요.');
				$('#inputLicense1').focus();
				return false;
			}
			
			if (!inputLicense2) {
				alert('라이선스를 입력해 주세요.');
				$('#inputLicense2').focus();
				return false;
			}
			
			if (!inputLicense3) {
				alert('라이선스를 입력해 주세요.');
				$('#inputLicense3').focus();
				return false;
			}
			
			if (!inputLicense4) {
				alert('라이선스를 입력해 주세요.');
				$('#inputLicense4').focus();
				return false;
			}
			
			if (!inputLicense5) {
				alert('라이선스를 입력해 주세요.');
				$('#inputLicense5').focus();
				return false;
			}
			
			$.ajax({
				url: "/support/selectUnusedLicense.do",
				data: {
					sSerialKey: license
				},
				success: function(data) {
					 if (data == null || data == '') {
						  alert('등록되지 않은 라이선스 입니다. 다시 입력해 주세요.');
						  $('#inputLicense1').focus();
						  return false;
						  
					 } else {
						 $.ajax({
							url: "/support/updateLicense.do",
							data: {
								sSerialCategory: data.sSerialCategory,
								nSerialNum: data.nSerialNum
							},
							success: function(data) {
								alert('라이선스 등록이 완료되었습니다.');
								location.reload();
							}
						})
					}
				}
			})
		}
	</script>
</body>

</html>