<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/refreshMaintain.js"></script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				if (sessionApproval > ADMINCHECK) {
					if( '${cn}' != null && '${hn}' != null ){
						document.hostMonitoring.location = '/data/hostMonitoring.do?cn='+'${cn}&hn=${hn}'; 	
					}
				}
				
				if('${vn}' != null){
					document.vmMonitoring.location = '/data/vmMonitoring.do?vn='+'${vn}'; 	
				}
				if('${vn}' != null && '${se}' != null && '${ten}' != null){
					document.vmMonitoring.location = '/data/vmMonitoring.do?vn='+'${vn}&ten=${ten}&se=${se}'; 	
				}
			})
		</script>
	</head>
	<body>
		<input id="radio1" type="radio" name="css-tabs" checked>
		<c:if test="${sessionAppEL > ADMINCHECK}">
			<input id="radio2" type="radio" name="css-tabs">
			<input id="radio3" type="radio" name="css-tabs">
			<input id="radio4" type="radio" name="css-tabs">
		</c:if>
		<c:if test="${sessionAppEL < ADMINCHECK}">
			<input id="radio2" type="radio" name="css-tabs">
		</c:if>
		
		<div id="tabs">
			<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-cube4"></i><span class="tabs-title">가상머신 성능</span></label>
			<c:if test="${sessionAppEL > ADMINCHECK}">
				<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-server"></i><span class="tabs-title">호스트 성능</span></label>
				<label id="tab3" for="radio3" onclick="getContentTab(3)"><i class="icon-alarm"></i><span class="tabs-title">vCenter 로그</span></label>
				<label id="tab4" for="radio4" onclick="getContentTab(4)"><i class="icon-stats-growth"></i><span class="tabs-title">가상머신 동향</span></label>
			</c:if>
			<c:if test="${sessionAppEL < ADMINCHECK}">
				<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-stats-growth"></i><span class="tabs-title">가상머신 동향</span></label>
			</c:if>
		</div>
		
		<div id="content">
			<section id="content1">
				<iframe src="/data/vmMonitoring.do" name="vmMonitoring" width="100%" height="700" seamless></iframe>
			</section>
			<c:if test="${sessionAppEL > ADMINCHECK}">
				<section id="content2">
					<iframe src="/data/hostMonitoring.do" name="hostMonitoring" width="100%" height="700" seamless></iframe>
				</section>
				<section id="content3">
					<iframe src="/data/MlogList.do" width="100%" height="700" seamless></iframe>
				</section>
				<section id="content4">
					<iframe src="/data/lateVMResource.do" width="100%" height="700" seamless></iframe>
				</section>
			</c:if>
			<c:if test="${sessionAppEL < ADMINCHECK}">
				<section id="content2">
					<iframe src="/data/lateVMResource.do" width="100%" height="700" seamless></iframe>
				</section>
			</c:if>
		</div>
	</body>
</html>