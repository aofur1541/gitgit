<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
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
		<c:if test="${sessionAppEL != BANNUMBER2}">
			<input id="radio3" type="radio" name="css-tabs">
		</c:if>
		
		<div id="tabs">
			<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-home2"></i><span class="tabs-title">테넌트 정보 관리</span></label>
			<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-folder"></i><span class="tabs-title">서비스 정보 관리</span></label>
			<c:if test="${sessionAppEL != BANNUMBER2}">
				<label id="tab3" for="radio3" onclick="getContentTab(3)"><i class="icon-fence"></i><span class="tabs-title">서비스 매핑 관리</span></label>
			</c:if>
		</div>
		
		<div id="content">
			<section id="content1">
				<iframe src="/data/tenantManage.do" width="100%" height="700" seamless></iframe>
			</section>
			<section id="content2">
				<iframe src="/data/serviceManage.do" width="100%" height="700" seamless></iframe>
			</section>
			<c:if test="${sessionAppEL != BANNUMBER2}">
				<section id="content3">
					<iframe src="/data/serviceMapping.do" width="100%" height="700" seamless></iframe>
				</section>
			</c:if>
		</div>
	</body>
</html>