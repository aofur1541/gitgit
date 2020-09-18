<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/favicon.jsp" %>
<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인</title>
		
		<link href="${path}/resources//global_assets/css/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
		<link href="${path}/resources//assets/css/bootstrap.css" rel="stylesheet" type="text/css">
		<link href="${path}/resources//assets/css/bootstrap_limitless.css" rel="stylesheet" type="text/css">
		<link href="${path}/resources//assets/css/layout.css" rel="stylesheet" type="text/css">
		<link href="${path}/resources//assets/css/components.css" rel="stylesheet" type="text/css">
		<link href="${path}/resources//assets/css/colors.css" rel="stylesheet" type="text/css">
		<!-- /global stylesheets -->
		
		<link href="${path}/resources/PROM_CSS/deco.css" rel="stylesheet" type="text/css">
		<link href="${path}/resources/PROM_CSS/promModal.css" rel="stylesheet" type="text/css">
		
		<!-- Core JS files -->
		<script src="${path}/resources//global_assets/js/main/jquery.min.js"></script>
		<script src="${path}/resources//global_assets/js/main/bootstrap.bundle.min.js"></script>
		<script src="${path}/resources//global_assets/js/plugins/loaders/blockui.min.js"></script>
		<script src="${path}/resources//global_assets/js/plugins/ui/ripple.min.js"></script>
		<!-- /core JS files -->
		
		<!-- Theme JS files -->
		<script src="${path}/resources//global_assets/js/plugins/visualization/d3/d3.min.js"></script>
		<script src="${path}/resources//global_assets/js/plugins/visualization/d3/d3_tooltip.js"></script>
		<script src="${path}/resources//global_assets/js/plugins/forms/styling/switchery.min.js"></script>
		<script src="${path}/resources//global_assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
		<script src="${path}/resources//global_assets/js/plugins/ui/moment/moment.min.js"></script>
		<script src="${path}/resources//global_assets/js/plugins/pickers/daterangepicker.js"></script>
		
		<script src="${path}/resources//assets/js/main/app.js"></script>
		<script src="${path}/resources//global_assets/js/demo_pages/dashboard.js"></script>
		<!-- Theme JS files -->
		<script src="${path}/resources/global_assets/js/plugins/forms/styling/uniform.min.js"></script>
		<script src="${path}/resources/global_assets/js/demo_pages/login.js"></script>
		<!-- /theme JS files -->
	
		<script type="text/javascript">
			
			$( document ).ready(function() {
				setTimeout(function(){
				    $("#loginform").find("#PWloginID").focus();
				}, 0);
			})
			
			function loginenterkey(){
				if (window.event.keyCode == 13) {
					PWNullCheck();
			   }
			}
			
			function PWNullCheck(){
				var PWloginID = $("#PWloginID").val();
				var PWloginCode = $("#PWloginCode").val();
				
				if(!PWloginID){
					alert("아이디를 입력 해주세요.")
					$('#PWloginID').focus();
					
					return false;
				} else if(!PWloginCode){
					alert("사원 코드를 입력 해주세요.")
					$('#PWloginCode').focus();
					
					return false;
				} else{
					PWCheck();
				} 
			}
			
			function PWCheck(){
				var PWloginID = $("#PWloginID").val();
				var PWloginCode = $("#PWloginCode").val();
				
				$.ajax({
					url : "/approval/applyPasswordReset.do",
					data : {
						sUserID : PWloginID,
						nNumber : PWloginCode,
					},
					success : function(data){
						if(data == 0){
							alert("아이디 혹은 사원 코드가 맞지 않습니다.");
						} else if(data == 1){
							alert("초기화 신청 완료\n담당자가 승인한 후에 초기화 비밀번호로 로그인 가능합니다.");
							location.href="index.jsp";
						} else if(data == 5){
			      		  alert("예외 발생");
			      	  	} else if(data == 6){
			      		  alert("사번 값이 올바르지 않습니다.");
			      	  	}
					}
				})
			}

		</script>	
		<style type="text/css">
			.content {
				background: url(${path}/resources/global_assets/images/indeximg.jpg) no-repeat center center fixed;
			}
		</style>
	</head>
	<body>
		<div class="content d-flex justify-content-center align-items-center">
			<form class="login-form" method="post" id="loginform" autocomplete="off">
				<div class="card bg-dark mb-0">
					<div class="card-body">
						<div class="text-center mt-5 mb-5">
							<img src="${path}/resources/global_assets/images/PROMPortal_logo_md.png" style="height:40px;">
						</div>
						<div class="form-group form-group-feedback form-group-feedback-left">
							<input type="text" class="form-control" placeholder="아이디" tabindex="1" id="PWloginID" onkeyup="loginenterkey()">
							<div class="form-control-feedback">
								<i class="icon-user text-prom"></i>
							</div>
						</div>
						<div class="form-group form-group-feedback form-group-feedback-left">
							<input type="password" class="form-control" placeholder="사원 코드" tabindex="2" id="PWloginCode" onkeyup="loginenterkey()">
							<div class="form-control-feedback">
								<i class="icon-vcard text-prom"></i>
							</div>
						</div>
						<div class="form-group mb-0">
							<button type="button"  tabindex="3" class="btn bg-prom btn-block" onclick="PWNullCheck()" onkeyup="loginenterkey()">초기화 신청</button>
						</div>
					</div>
					<div class="card-footer text-center">
						<a href="index.jsp" >로그인</a>
					</div>
				</div>
			</form>
		</div>
	</body>
</html>