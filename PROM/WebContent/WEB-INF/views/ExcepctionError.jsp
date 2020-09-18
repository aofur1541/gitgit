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
							<h1 class="form-title">Java.lang.Throwable</h1>
							<div class="error-content">
								<h6>오류가 발생하였습니다.</h6>
								<div>페이지를 찾을 수 없습니다. 다시 로그인해 주세요.</div>
							</div>
							<div class="loginButtonGrouop">
								<button type="button" onclick="location.href='/index.jsp'" class="btn goLoginBtn">로그인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>

</html>