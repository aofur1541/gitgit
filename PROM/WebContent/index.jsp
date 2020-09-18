<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/jspHeader.jspf" %>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>


	<link href="${path}/resource/css/login.css" rel="stylesheet" type="text/css">
</head>

<body>





	<div class="content d-flex justify-content-center align-items-center">

		<!-- 비밀번호 변경 -->
		<%@ include file="/WEB-INF/views/include/updatePassword.jsp"%>
		
		<!-- 로그인 폼 -->
      <form class="flex-fill" action="login/loginSuccess.do" method="post" id="loginForm">
         <div class="row-padding-0 h-100">
            <div class="col-sm-8 offset-sm-2 divWrapper">
               <div class="row">
                  <div class="col-sm-6 imgDiv">
                     <img src="/resource/images/login.svg" height="100%">
                  </div>
                  <div class="col-sm-6 loginDiv">
                        <h4 class="form-title">로그인</h4>
                        <div class="input-group">
                           <div class="input-group-prepend"><span class="input-group-text"><i class="far fa-user"></i></span></div>
                           <input type="text" class="form-control" placeholder="아이디" autocomplete="off" id="adidmodal">
                        </div>
                        <div class="input-group">
                           <div class="input-group-prepend"><span class="input-group-text"><i class="fas fa-lock"></i></span></div>
                           <input type="password" class="form-control" placeholder="비밀번호" autocomplete="off" onkeypress="capsLock(event)" id="adpwmodal">
                        </div>
                        <div class="input-group">
                           <div class="input-group-prepend"><span class="input-group-text"><i class="far fa-user"></i></span></div>
                           <input type="text" class="form-control" placeholder="OTP" autocomplete="off" id="otpmodal">
                        </div>
                        <p id="capslock" style="display:none"><b>&lt;Caps Lock&gt;</b>이 켜져 있습니다.</p>
                        <button type="button" class="btn login-btn" onclick="adotpcheck()"> 로그인 </button>
                        <!-- <button type="button"  onclick="loginCheck()" > 관리자 로그인 </button>  -->
                     </div>
               </div>
            </div>
         </div>
      </form>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
		
			$('#loginId').focus();
			
			
			
			
			var agent = navigator.userAgent.toLowerCase();
			if ((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1)) {
				alert("인터넷 익스플로러는 권장하지 않습니다.\n※일부 페이지가 호환이 안될수 있습니다.\n권장 : 구글 크롬 , MS Edge , 모질라 파이어폭스");
			}
		})
		

		
		
		function adotpcheck(){
		//login 버튼 보여줘
		
			var userId=$('#adidmodal').val()
			var userPassword=$('#adpwmodal').val();
			
		if(AD()=="0" && OTP()=="0"){
			
			$.ajax({
				
				data: {
					sUserID: userId,
					sUserPW: userPassword
				},
				url: '/login/login.do',
				type: 'POST',
				beforeSend: function() {
					$('#loginBtn').text('로그인 중...');
				},
				complete: function() {
					$('#loginBtn').text('로그인');
				},
				
				success: function(data) {
					
					console.log(data);
					
					// 입력 체크
					if (!userId) {
						alert('아이디를 입력해 주세요.');
						$('#loginId').focus();
						return false;
					}

					if (!userPassword) {
						alert('비밀번호를 입력해 주세요.');
						$('#loginPassword').focus();
						return false;
					}

					// 로그인 실패
					if (data == 0 || data == 1 || data == 2) {
						
					alert("아이디,비밀번호가 틀렸습니다.")
						$('#loginPassword').focus();
						return false;
					}

					// 로그인 성공
					if (data == 3) {
						$('#loginForm').submit();
					}

					if (data == 5) {
						alert('시스템 예외가 발생 했습니다.\n로그를 확인해 주세요.');
						console.log('${errorMeg}');
					}

					if (data == 6) {
						alert('허용된 아이피가 아닙니다.');
					}

					if (data == 7) {
						alert('사용자 허용 네트워크 대역 설정값이 올바르지 않습니다.\n로그를 확인해 주세요.');
					}

					if (data == 8) {
						alert('중복 로그인을 할 수 없습니다.');
					}

					if (data == 9) {
						alert('초기 비밀번호 입니다.\n비밀번호 변경 후 로그인해 주세요.');
						updatePassword(userId);
					}

					if (data == 10) {
						alert('비밀번호가 만료되었습니다.\n비밀번호 변경 후 로그인해 주세요.');
						updatePassword(userId);
					}

					if (data == 11) {
						$('#loginForm').submit();
					}

					if (data == 12) {
						alert('OTP 인증에 실패 했습니다.');
					}

					if (data == 13) {
						alert('사용되지 않는 부서에 소속되어 있습니다.\n담당자에게 문의해 주세요.');
					}
				},
				error: function() {
					alert('통신 에러 : 네트워크 상태를 확인해 주세요.');
				}
			});
		
		
		
		
		}
		}

		function loginCheck() {
			
			var userId=$('#adidmodal').val()
			var userPassword=$('#adpwmodal').val();
			

			
			
			}
		
		function AD(){
			
			var sUserID=$('#adidmodal').val()
			var sUserPW=$('#adpwmodal').val();
			
			if(!sUserID){
				alert("아이디를 입력해 주세요.");
				$('#adidmodal').focus();
				return 1;
			}
			if(sUserID && !sUserPW){
				alert("비밀번호를 입력해 주세요.");
				$('#adpwmodal').focus();
				return 1;
			}
			
			//TODO "수정 필요"
			var url="LDAP://172.10.0.30";
			var result;
			
			/* if(sUserID && sUserPW){ */
			$.ajax({
				url: '/login/adLogin.do',
				type: 'POST',
				async: false,
				data: {
					sUserID: sUserID,
					sUserPW: sUserPW,
					url: url
				},
				type: 'POST',
				
				success: function(data) {
					// 인증 성공
					if (data.aCode == 0) {
						/* alert("AD 인증 성공") */
						result= "0";
					// 인증 실패
					} else {
						alert("AD 인증 실패 \n아이디, 비밀번호가 틀렸습니다.");
						return 1;
					}
				},
				error: function(xhr, status, error){
					alert('ajax error1'+ error);
				}
			});
			
			return result;
		/* } */
		}
		
		
			function OTP() {
			var result;
			var otp = $('#otpmodal').val();
			var userId = $('#adidmodal').val();
			var userPw = $('#adpwmodal').val();
			
			//아이디와 비밀번호 모두 입력하고
			if(userId && userPw){
				//접속시도하는 아이디가 admin이 아닐때
				if(userId != "admin@prom"){
					
					// OTP를 입력하지 않았을 때
					if (!otp) {
						alert('OTP를 입력해 주세요.');
						$('#loginOTP').focus();
						return 1;
					}
					
					// 숫자만
					var regexp = /^[0-9]*$/
					if(!regexp.test(otp)){
						alert('OTP는 숫자만입력');
						$('#loginOTP').focus();
						return 1;
					}
					
					// 자릿수 제한
					if (otp.length != 6) {
						alert('자릿수가 올바르지 않습니다. 다시 입력해 주세요.');
						$('#loginOTP').focus();
						return 1;
					}
				}
			}else{
				return 1;
			}
			
			$.ajax({
				url: '/login/otpLogin.do',
				type: 'POST',
				async: false,
				data: {
					sUserID: userId,
					otpNumber: otp
				},
				type: 'POST',
				beforeSend: function() {
					$('#otpBtn').text('OTP 인증 중...');
				},
				complete: function() {
					$('#otpBtn').text('OTP 인증');
				},
				success: function(data) {
					// 인증 성공
					if (data.rCode == 0) {
						/* alert("OTP 인증 성공") */ 
						result="0";
					// 인증 실패
					} else {
						alert("OTP 인증 실패");
						$('#loginOTP').focus();
						return 1;
					}
				}
			})//ajax 끝
			
			return result;
		}
		
			
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		// CapsLock 체크
		function capsLock(e) {
			var keyCode = 0;
			var shiftKey = false;

			keyCode = e.keyCode;
			shiftKey = e.shiftKey;

			if (((keyCode >= 65 && keyCode <= 90) && !shiftKey) || ((keyCode >= 97 && keyCode <= 122) && shiftKey)) {
				showCapsLock();
			} else {
				hideCapsLock();
			}
		}

		function showCapsLock() {
			$('#capslock').show();
		}

		function hideCapsLock() {
			$('#capslock').hide();
		}

 		// Enter 체크


/* 		function OTPEnterKey() {
			if (window.event.keyCode == 13) {
				useOTPCheck();
			}
		} */

		// 로그인 실행 체크
		

		// OTP 기능 사용
		function useOTP() {
			$('#otpForm').show();
			$('#otpBtn').show();
			$('#loginBtn').hide();

			$('#loginId').attr('disabled', true);
			$('#loginPassword').attr('disabled', true);

			$('#loginOTP').focus();
		}
		
		
		
	</script>
</body>

</html>