<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/refreshMaintain.js"></script>
	</head>
	<body>
		<c:if test="${sessionAppEL > ADMINCHECK}">
			<input id="radio1" type="radio" name="css-tabs" checked>
			<input id="radio2" type="radio" name="css-tabs">
			<input id="radio3" type="radio" name="css-tabs">
		</c:if>
		<c:if test="${sessionAppEL < ADMINCHECK}">
			<input id="radio1" type="radio" name="css-tabs" checked>
		</c:if>
		
		<div id="tabs">
			<c:if test="${sessionAppEL > ADMINCHECK}">
				<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-city"></i><span class="tabs-title">회사 정보 관리</span></label>
				<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-tree6"></i><span class="tabs-title">부서 정보 관리</span></label>
				<label id="tab3" for="radio3" onclick="getContentTab(3)"><i class="icon-user"></i><span class="tabs-title">사용자 정보 관리</span></label>
			</c:if>
			<c:if test="${sessionAppEL < ADMINCHECK}">
				<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-user"></i><span class="tabs-title">사용자 정보 관리</span></label>
			</c:if>
		</div>
		
		<div id="content">
			<c:if test="${sessionAppEL > ADMINCHECK}">
				<section id="content1">
					<iframe src="/data/manageCompany.do"  width="100%" height="700" seamless></iframe>
				</section>
				<section id="content2">
					<iframe src="/data/department.do" width="100%" height="700" seamless></iframe>
				</section>
				<section id="content3">
					<iframe src="/data/userCreate.do" width="100%" height="700" seamless></iframe>
				</section>
			</c:if>
			<c:if test="${sessionAppEL < ADMINCHECK}">
				<section id="content1">
					<iframe src="/data/userCreate.do" width="100%" height="700" seamless></iframe>
				</section>
			</c:if>
		</div>
	</body>
</html>