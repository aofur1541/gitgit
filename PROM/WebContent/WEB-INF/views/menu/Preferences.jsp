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
		<input id="radio4" type="radio" name="css-tabs">
		
		<div id="tabs">
			<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-grid5"></i><span class="tabs-title">템플릿 사용 설정</span></label>
			<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-cup2"></i><span class="tabs-title">Flavor 설정</span></label>
			<label id="tab3" for="radio3" onclick="getContentTab(3)"><i class="icon-hammer"></i><span class="tabs-title">연동 서버 설정</span></label>
			<c:if test="${sessionAppEL != BANNUMBER && sessionAppEL != BANNUMBER2}">
				<label id="tab4" for="radio4" onclick="getContentTab(4)"><i class="icon-info22"></i><span class="tabs-title">기타 설정</span></label>
			</c:if>
		</div>
		
		<div id="content">
			<section id="content1">
				<iframe src="/data/templateSetting.do"  width="100%" height="700" seamless></iframe>
			</section>
			<section id="content2">
				<iframe src="/data/flavorSetting.do" width="100%" height="700" seamless></iframe>
			</section>
			<section id="content3">
				<iframe src="/data/serverSetting.do" width="100%" height="700" seamless></iframe>
			</section>
			<section id="content4">
				<iframe src="/data/otherSetting.do" width="100%" height="700" seamless></iframe>
			</section>
		</div>	
	</body>
</html>