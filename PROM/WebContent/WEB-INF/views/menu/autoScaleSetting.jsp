<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/refreshMaintain.js"></script>
		<script src="${path}/resources/PROM_JS/adminCheck.js"></script>
	</head>
	<body>
		<input id="radio1" type="radio" name="css-tabs" checked>
		<input id="radio2" type="radio" name="css-tabs">
		<input id="radio3" type="radio" name="css-tabs">
		
		<div id="tabs">
			<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-cog3"></i><span class="tabs-title">Auto Scale UP</span></label>
			<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-touch"></i><span class="tabs-title">수동 Scale Out</span></label>
			<label id="tab3" for="radio3" onclick="getContentTab(3)"><i class="icon-cog3"></i><span class="tabs-title">Auto Scale Out</span></label>
		</div>
		
		<div id="content">
			<section id="content1">
				<iframe src="/data/autoScaleUP.do"  width="100%" height="700" seamless></iframe>
			</section>
			<section id="content2">
				<iframe src="/data/manualScaleOut.do" width="100%" height="700" seamless></iframe>
			</section>
			<section id="content3">
				<iframe src="/data/autoScaleOut.do" width="100%" height="700" seamless></iframe>
			</section>
		</div>	
	</body>
</html>