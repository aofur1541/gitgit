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
		<input id="radio3" type="radio" name="css-tabs">
		
		<div id="tabs">
			<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-exclamation"></i><span class="tabs-title">공지사항</span></label>
			<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-help"></i><span class="tabs-title">문의사항</span></label>
			<label id="tab3" for="radio3" onclick="getContentTab(3)"><i class="icon-info22"></i><span class="tabs-title">PROM 정보</span></label>
		</div>
		
		<div id="content">
			<section id="content1">
				<iframe src="/data/notices.do" width="100%" height="700" seamless></iframe>
			</section>
			<section id="content2">
				<iframe src="/data/questions.do" width="100%" height="700" seamless></iframe>
			</section>
			<section id="content3">
				<iframe src="/data/informationPROM.do" width="100%" height="700" seamless></iframe>
			</section>
		</div>
	</body>
</html>