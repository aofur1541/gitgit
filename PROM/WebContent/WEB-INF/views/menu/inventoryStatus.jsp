<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/refreshMaintain.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				if (sessionApproval > ADMINCHECK) {
					if('${hn}' != null){
						document.vmsInHost.location = '/data/Mallvmlist.do?hn='+'${hn}'; 	
					}
				}
				
				if('${se}' != null && '${ten}' != null){
					document.vmsInService.location = '/data/serviceList.do?ten=${ten}&se=${se}'; 	
				}
			})
		</script>
	</head>
	<body>
		<input id="radio1" type="radio" name="css-tabs" checked>
		<input id="radio2" type="radio" name="css-tabs">
		<input id="radio3" type="radio" name="css-tabs">
		<input id="radio4" type="radio" name="css-tabs">
		
		<div id="tabs">
			<c:if test="${sessionAppEL > ADMINCHECK}">
				<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-lan"></i><span class="tabs-title">클러스터별 가상머신 현황</span></label>
				<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-folder"></i><span class="tabs-title">테넌트별 가상머신 현황</span></label>
				<label id="tab3" for="radio3" onclick="getContentTab(3)"><i class="icon-server"></i><span class="tabs-title">호스트 현황</span></label>
				<label id="tab4" for="radio4" onclick="getContentTab(4)"><i class="icon-database"></i><span class="tabs-title">데이터스토어 현황</span></label>
			</c:if>
			<c:if test="${sessionAppEL < ADMINCHECK}">
				<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-folder"></i><span class="tabs-title">테넌트별 가상머신 현황</span></label>
			</c:if>
		</div>
		
		<div id="content">
			<c:if test="${sessionAppEL > ADMINCHECK}">
				<section id="content1">
					<iframe src="/data/Mallvmlist.do" name="vmsInHost" width="100%" height="700" seamless></iframe>
				</section>
				<section id="content2">
					<iframe src="/data/serviceList.do" name="vmsInService" width="100%" height="700" seamless></iframe>
				</section>
				<section id="content3">
					<iframe src="/data/Mallhostlist.do" width="100%" height="700" seamless></iframe>
				</section>
				<section id="content4">
					<iframe src="/data/Mallstoragelist.do" width="100%" height="700" seamless></iframe>
				</section>
			</c:if>
			<c:if test="${sessionAppEL < ADMINCHECK}">
				<section id="content1">
					<iframe src="/data/serviceList.do" name="vmsInService" width="100%" height="700" seamless></iframe>
				</section>
			</c:if>
		</div>
	</body>
</html>