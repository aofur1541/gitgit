<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/refreshMaintain.js"></script>
	</head>
	<body>
			<input id="radio1" type="radio" name="css-tabs" checked>
			<input id="radio2" type="radio" name="css-tabs">

		<div id="tabs">
			<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-grid5"></i><span class="tabs-title">가상머신 생성</span></label>
			<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-cube4"></i><span class="tabs-title">가상머신 관리</span></label>
		</div>
		<div id="content">
			<section id="content1">
				<iframe src="/data/applyVMCreate.do" width="100%" height="700" seamless></iframe>
			</section>
			<section id="content2">
				<iframe src="/data/vmDetailList.do" width="100%" height="700" seamless></iframe>
			</section>
		</div>
	</body>
</html>