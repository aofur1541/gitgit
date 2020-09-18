<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<%@ include file="/WEB-INF/views/commonFiles.jsp" %>
		<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
		<%@ include file="/WEB-INF/views/common/commonModal.jsp" %>
		
		<script type="text/javascript">
			var globalPreObj = null;
			var globalThis = null;
			$(document).ready(function() {
				$("#dataloading").hide();
			})
		</script>
	
		<style type="text/css">
			@font-face {
				font-family: 'SpoqaHanSans';
				font-style: normal;
				font-weight: 400;
				src: local('SpoqaHanSansLight'),
				url('${path}/resources/fonts/SpoqaHanSansLight.woff2') format('woff2'),
				url('${path}/resources/fonts/SpoqaHanSansLight.woff') format('woff'),
				url('${path}/resources/fonts/SpoqaHanSansLight.ttf') format('truetype');
			}
	
			@font-face {
				font-family: 'SpoqaHanSans';
				font-style: normal;
				font-weight: 700;
				src: local('Spoqa Han Sans Regular'),
				url('${path}/resources/fonts/SpoqaHanSansRegular.woff2') format('woff2'),
				url('${path}/resources/fonts/SpoqaHanSansRegular.woff') format('woff'),
				url('${path}/resources/fonts/SpoqaHanSansRegular.ttf') format('truetype');
			}
	
			@font-face {
				font-family: 'SpoqaHanSans';
				font-style: normal;
				font-weight: 900;
				src: local('Spoqa Han Sans Bold'),
				url('${path}/resources/fonts/SpoqaHanSansBold.woff2') format('woff2'),
				url('${path}/resources/fonts/SpoqaHanSansBold.woff') format('woff'),
				url('${path}/resources/fonts/SpoqaHanSansBold.ttf') format('truetype');
			}
		</style>
		<decorator:head />
		
		<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
		<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
		<c:set var="path" value="${pageContext.request.contextPath}" />
	</head>
	<decorator:title />
	<title>PROM</title>
	<body>
		<div id="dataloading">
			<div class="pace-demo">
				<div class="theme_tail theme_tail_circle theme_tail_with_text">
					<div class="pace_progress" data-progress-text="60%" data-progress="60"></div>
					<div class="pace_activity"></div>
					<span class="text-center">데이터를 가져오는중...</span>
				</div>
			</div>
			<div class="pace-back"></div>
		</div>
		<div>
			<decorator:body />
		</div>
	</body>
</html>