<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>

	<link href="${path}/resource/css/login.css" rel="stylesheet" type="text/css">
</head>

<body>
	<div class="content">

		<!-- 에러 폼 -->
		<form class="flex-fill">
			<div class="row-padding-0 h-100">
				<div class="col-sm-8 offset-sm-2 divWrapper">
					<div class="row">
						<div class="col-sm-6 imgDiv">
							<img src="/resource/images/login.svg" height="100%">
						</div>
						<div class="col-sm-6 loginDiv">
							<h1 class="form-title">로그인</h1>
							<div class="error-content">
								<h6>요청하신 페이지를 찾을 수 없습니다.</h6>
								<div>
									존재하지 않는 주소를 입력하셨거나,<br>
									요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.<br>
									입력하신 주소가 정확한지 다시 한번 확인해 주세요. 감사합니다.
								</div>
							</div>
							<div class="loginButtonGrouop">
								<button type="button" onclick="window.history.back()" class="btn goBackBtn">이전 페이지</button>
								<button type="button" onclick="location.href='/index.jsp'" class="btn goLoginBtn">로그인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<script type="text/javascript">
		var errorCode = ${requestScope['javax.servlet.error.status_code']};
		$('.form-title').html(errorCode);
	</script>
</body>

</html>