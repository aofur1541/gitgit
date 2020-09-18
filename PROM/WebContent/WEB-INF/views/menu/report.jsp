<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/refreshMaintain.js"></script>
	</head>
	<body>
		<input id="radio1" type="radio" name="css-tabs" checked>
		<input id="radio2" type="radio" name="css-tabs">
		<c:if test="${sessionAppEL > ADMINCHECK}">
		<input id="radio3" type="radio" name="css-tabs">
		<input id="radio4" type="radio" name="css-tabs">
		</c:if>
		
		<div id="tabs">
			<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-cube4"></i><span class="tabs-title">가상머신 보고서</span></label>
			<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-cube3"></i><span class="tabs-title">가상머신 보고서(주, 야간)</span></label>
			<c:if test="${sessionAppEL > ADMINCHECK}">
			<label id="tab3" for="radio3" onclick="getContentTab(3)"><i class="icon-server"></i><span class="tabs-title">호스트 보고서</span></label>
			<label id="tab4" for="radio4" onclick="getContentTab(4)"><i class="icon-server"></i><span class="tabs-title">호스트 보고서(주, 야간)</span></label>
			</c:if>
		</div>
		
		<div id="content">
			<section id="content1">
				<iframe src="/data/vmReportOriginal.do" width="100%" height="700" seamless></iframe>
			</section>
			<section id="content2">
				<iframe src="/data/vmReport.do" width="100%" height="700" seamless></iframe>
			</section>
			<c:if test="${sessionAppEL > ADMINCHECK}">
			<section id="content3">
				<iframe src="/data/hostReportOriginal.do" width="100%" height="700" seamless></iframe>
			</section>
			<section id="content4">
				<iframe src="/data/hostReport.do" width="100%" height="700" seamless></iframe>
			</section>
			</c:if>
		</div>
	</body>
</html>