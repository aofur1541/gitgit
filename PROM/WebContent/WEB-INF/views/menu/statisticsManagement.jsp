<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/refreshMaintain.js"></script>
		<script src="${path}/resources/PROM_JS/refreshGetParaDelete.js"></script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				if('${vn}' != null){
					document.vmUsageSt.location = '/data/vmUsageStatistics.do?ca=${ca}'+'&pa=${pa}'+'&ch=${ch}'+'&vn='+'${vn}'+'&ts='+'${ts}'+'&dt='+'${dt}'; 		
				}
				etcOpsCheck();
			})
		
			function etcOpsCheck() {
				var targetName = 'agentOnOff';
				var content = '';
				var label = '';
				$.ajax({
					url: "/config/selectBasic.do",
					data: {
						targetName: targetName
					},
					success: function(data) {
						if (data.value == 1) { // 체크됨
							$(".agentStatisticsLable").removeClass("displayNone");
						} else if (data.value == 0) { //체크 안됨
							$(".agentStatisticsLable").addClass("displayNone");
						}
					}
				})
			}
		</script>
	</head>
	<body>
		<input id="radio1" type="radio" name="css-tabs" checked>
		<c:if test="${sessionAppEL > ADMINCHECK}">
			<input id="radio2" type="radio" name="css-tabs">
			<input id="radio3" type="radio" name="css-tabs">
		</c:if>
		<c:if test="${sessionAppEL < ADMINCHECK}">
			<input id="radio2" type="radio" name="css-tabs">
		</c:if>
	
		<div id="tabs">
			<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-cube4"></i><span class="tabs-title">가상머신 성능 통계</span></label>
			<c:if test="${sessionAppEL > ADMINCHECK}">
				<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-server"></i><span class="tabs-title">호스트 성능 통계</span></label>
				<label id="tab3" for="radio3" onclick="getContentTab(3)" class="agentStatisticsLable displayNone"><i class="icon-cube4"></i><span class="tabs-title">가상머신 에이전트 통계</span></label>
			</c:if>
			<c:if test="${sessionAppEL < ADMINCHECK}">
				<label id="tab2" for="radio2" onclick="getContentTab(2)" class="agentStatisticsLable displayNone"><i class="icon-cube4"></i><span class="tabs-title">가상머신 에이전트 통계</span></label>
			</c:if>
		</div>
	
		<div id="content">
			<section id="content1">
				<iframe src="/data/vmUsageStatistics.do" width="100%" height="700" name="vmUsageSt" seamless></iframe>
			</section>
			<c:if test="${sessionAppEL > ADMINCHECK}">
				<section id="content2">
					<iframe src="/data/hostUsageStatistics.do" width="100%" height="700" seamless></iframe>
				</section>
				<section id="content3">
					<iframe src="/data/agentStatistics.do" width="100%" height="700" seamless></iframe>
				</section>
			</c:if>
			<c:if test="${sessionAppEL < ADMINCHECK}">
				<section id="content2">
					<iframe src="/data/agentStatistics.do" width="100%" height="700" seamless></iframe>
				</section>
			</c:if>
		</div>
	</body>
</html>