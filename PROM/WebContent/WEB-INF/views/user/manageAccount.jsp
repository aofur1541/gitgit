<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
	
	<style type="text/css">
		.table-body {
			margin-bottom: 50px;
		}
	</style>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		
		<!-- 본문 시작 -->
		<div class="content">
		
			<!-- 비밀번호 변경 -->
			<%@ include file="/WEB-INF/views/include/updatePassword.jsp"%>
			
			<!-- 정보 변경 -->
			<%@ include file="/WEB-INF/views/include/updateUser.jsp"%>

			<!-- 내 정보 페이지 -->
			<div class="row">
				<div class="col-xl-6 col-sm-12">
					<div class="table-header"><h6>사용자 정보</h6></div>
					<div class="table-body">
						<table class="vertical-table">
							<tbody>
								<tr>
									<th width="20%">이름</th>
									<td width="30%" id="name"></td>
									<th width="20%">영문 이름</th>
									<td width="30%" id="englishName"></td>
								</tr>
								<tr>
									<th>아이디</th>
									<td id="id"></td>
									<th>이메일</th>
									<td id="email"></td>
								</tr>
								<tr>
									<th>재직 여부</th>
									<td id="employment"></td>
									<th>전화번호</th>
									<td id="phoneNumber"></td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="table-header"><h6>소속</h6></div>
					<div class="table-body">
						<table class="vertical-table">
							<tbody>
								<tr>
									<th width="20%">회사</th>
									<td width="30%" id="company"></td>
									<th width="20%">부서</th>
									<td width="30%" id="department"></td>
								</tr>
								<tr>
									<th>직급</th>
									<td id="rank"></td>
									<th>사번</th>
									<td id="employeeNumber"></td>
								</tr>
								<tr>
									<th>입사일</th>
									<td id="startDate" colspan="3"></td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="table-header"><h6>권한</h6></div>
					<div class="table-body">
						<table class="vertical-table">
							<tbody>
								<tr>
									<th width="20%">권한</th>
									<td width="80%" id="authority"></td>
								</tr>
							</tbody>
						</table>
					</div>
					
					<div class="account-button">
						<button type="button" class="btn" id="updateUser" style="margin-right: 10px;">정보 변경</button>
						<button type="button" class="btn" id="updatePassword">비밀번호 변경</button>
					</div>
				</div>

				<div class="col-xl-6 col-sm-12">
					<div class="table-header"><h6>허용 IP</h6></div>
					<div class="table-body">
						<table class="vertical-table">
							<tbody>
								<tr>
									<th width="20%">IP 주소</th>
									<td width="80%" id="ipAddress"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- 본문 끝 -->
	</div>
	
	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			getUserInformation();
		});
	
		function getUserInformation() {
			var sessionId = '${sessionScope.loginUser.id}';
	
			$.ajax({
				url: "/user/selectUser.do",
				data: {
					id: sessionId
				},
				success: function(data) {
					$('#name').html(data.sName);
					$('#englishName').html(data.sNameEng);
					$('#id').html(data.sUserID);
					$('#email').html(data.sEmailAddress);
					$('#employment').html(userEmployment(data.sTenureCode));
					$('#phoneNumber').html(data.sPhoneNumber);
					$('#company').html(data.companyName);
					$('#department').html(data.sDepartmentName);
					$('#rank').html(data.sJobCode);
					$('#employeeNumber').html(data.nNumber);
					$('#startDate').html(data.dStartday);
					$('#authority').html(userAuthority(data.nApproval));
	
					var ipAddress = data.sUserIP;
					var ipAddress_result = ipAddress.replace(/\,/g, '<br>');
					
					$('#ipAddress').html(ipAddress_result);
					
					$('#updateUser').off('click').on('click', function() {
						updateUser(data);
					});
					
					$('#updatePassword').off('click').on('click', function() {
						updatePassword(data.sUserID);
					});
				}
			})
		}
	</script>
</body>

</html>