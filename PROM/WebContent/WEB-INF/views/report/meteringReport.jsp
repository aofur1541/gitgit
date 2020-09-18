<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp" %>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>

	<style type="text/css">
		@charset "UTF-8";

		/* ------------------------------------------------------------------------------
		 *
		 *  # section-card
		 *
		 * ---------------------------------------------------------------------------- */
		
		.section-card {
			border-top: 2px solid #004BAD;
			white-space: nowrap;
		}
		
		.section-card:first-child {
			margin-bottom: 15px;
		}
		
		.section-card>.card-header {
			font-size: 16px;
			background-color: #E3F3FE;
			border-bottom: 0;
		}
		
		.section-card>.card-body {
			padding: 0;
		}
		
		.section-card .card .card-header {
			border: 0;
		}
		
		.section-card .card {
			border: 0;
			height: 100%;
		}
		
		.section-card .card-header i {
			margin-right: 10px;
		}
		
		.section-card .row {
			margin: 0;
			height: 100%;
			position: relative;
		}
		
		.section-card div[class*=col-] {
			padding: 0;
		}
		
		.section-card>.card-body>.row>div[class*=col-]:not(:last-child) {
			border-right: 1px solid #E0E0E0;
		}
		
		/* ------------------------------------------------------------------------------
		 *
		 *  # section-card ul
		 *
		 * ---------------------------------------------------------------------------- */
		
		.section-card ul:not(.nav-tabs) {
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			padding: 0;
			margin: 0;
			height: 100%;
		}
		
		.section-card ul li:not(.nav-item){
			display: flex;
			align-items: center;
			margin-bottom: 5px;
		}
		
		.section-card ul li:last-child {
			margin-bottom: 0;
		}
		
		.section-card ul li span {
			font-size: 12px;
		}
		
		.section-card ul li h6 {
			margin: 0;
			font-weight: bold;
			color: #365280;
		}
		
		/* ------------------------------------------------------------------------------
		 *
		 *  # widget
		 *
		 * ---------------------------------------------------------------------------- */
		
		div[class*=widget-] {
			padding: 15px !important;
		}
		
		/* ------------------------------------------------------------------------------
		 *
		 *  # widget-1
		 *
		 * ---------------------------------------------------------------------------- */
		.widget-1 span {
			font-weight: bold;
			font-size: 12px;
			margin-bottom: 10px;
		}
		
		.widget-1 h4 {
			line-height: 1;
			color: #365280;
			margin: 0;
			text-align: right;
		}
		
		.widget-1>.row>div[class*=col-]:first-child {
			padding-right: 15px;
			border-right: 1px solid #E0E0E0;
		}
		
		.widget-1>.row>div[class*=col-]:last-child {
			padding-left: 15px;
		}
		
		.widget-1>.row>div[class*=col-]>.row:first-child {
			padding-bottom: 15px;
			border-bottom: 1px solid #E0E0E0;
			height: 50%;
		}
		
		.widget-1>.row>div[class*=col-]>.row:last-child {
			padding-top: 15px;
			height: 50%;
		}
		
		.widget-1>.row>div[class*=col-]>.row>div[class*=col-] {
			background-color: #FFFFFF;
			display: flex;
			flex-direction: column;
			justify-content: space-between;
		}
		
		.widget-1>.row>div[class*=col-]>.row>div[class*=col-]:first-child {
			padding: 15px 20px 7.5px 0;
			border-right: 1px solid #F5F5F5;
		}
		
		.widget-1>.row>div[class*=col-]>.row>div[class*=col-]:last-child {
			padding: 15px 5px 7.5px 15px;
		}
		
		/* ------------------------------------------------------------------------------
		 *
		 *  # widget-2
		 *
		 * ---------------------------------------------------------------------------- */
		.widget-2 ul li:before {
			content: '·';
			margin-right: 5px;
		}
		
		.widget-2 ul li h6 {
			margin-left: auto;
		}
		
		/* ------------------------------------------------------------------------------
		 *
		 *  # widget 3
		 *
		 * ---------------------------------------------------------------------------- */
		
		.widget-3 div[class*=col-]:first-child {
			padding-right: 15px;
			border-right: 1px solid #F5F5F5;
		}
		
		.widget-3 div[class*=col-]:last-child {
			padding-left: 15px;
		}
		
		.rows-card>.row:first-child .widget-3 {
			border-bottom: 1px solid #E0E0E0;
		}
		
		.rows-card>.row {
			height: auto;
		}
		
		.widget-3 ul li {
			justify-content: space-between;
		}
		
		.widget-3 ul li>:nth-child(1) {
			flex: 1;
		}
		
		.widget-3 ul li>:nth-child(2) {
			margin: 0 15px;
			flex: 2;
			height: 1px;
			border-bottom: 2px dashed #E0E0E0;
		}
		
		.widget-3 ul li>:nth-child(3) {
			display: flex;
			flex: 1;
			align-items: flex-end;
			justify-content: flex-end;
			font-size: 14px;
			color: #365280;
		}
		
		/* ------------------------------------------------------------------------------
		 *
		 *  # widget 4
		 *
		 * ---------------------------------------------------------------------------- */
		.widget-4 span {
			font-size: 12px;
		}
		
		.widget-4 span:before {
			content: '·';
			margin-right: 5px;
		}
		
		.widget-4 h6 {
			color: #365280;
			margin: 0 15px 0 0;
		}
		
		.widget-4 .card-body {
			padding: 0;
			display: flex;
			flex-direction: column;
		}
		
		.widget-4 .card-body>div {
			flex: 1;
		}
		
		.widget-4 .card-body>div:not(:last-child) {
			padding-bottom: 15px;
			border-bottom: 1px solid #F5F5F5;
		}
		
		.widget-4 .card-body>div:not(:first-child) {
			padding-top: 15px;
		}
		
		.widget-4 .card-body>div>div {
			padding: 15px;
		}
		
		.widget-4 .card-body>div>div>div {
			padding-top: 15px;
			display: flex;
			justify-content: flex-end;
			align-items: flex-end;
			font-size: 12px;
		}
		
		/* ------------------------------------------------------------------------------
		 *
		 *  # widget-5
		 *
		 * ---------------------------------------------------------------------------- */
		.widget-5 .card-body>.row:first-child {
			height: 50%;
			padding-bottom: 30px;
		}
		
		.widget-5 .card-body>.row:last-child {
			height: 50%;
			padding-top: 30px;
		}
		
		.widget-5 span {
			font-size: 14px;
		}
		
		.widget-5 span:before {
			content: '·';
			margin-right: 5px;
		}
		
		/* ------------------------------------------------------------------------------
		 *
		 *  # widget-6
		 *
		 * ---------------------------------------------------------------------------- */
		
		.widget-6 .row {
			height: auto;
		}
		
		.widget-6 .title-widget {
			padding-bottom: 15px;
			border-bottom: 1px solid #E0E0E0;
			font-weight: bold;
		}
		
		.widget-6 .title-widget i{
			margin-right: 10px;
			display: flex;
			align-items: center;
		}
		
		.widget-6 .content-widget {
			padding-top: 15px;
		}
		
		.widget-6 .content-widget div[class*=col-]:first-child{
			padding: 25px 30px 15px 15px;
			border-right: 1px solid #E0E0E0;
		}
		
		.widget-6 .content-widget div[class*=col-]:last-child {
			padding: 25px 15px 15px 30px;
		}
		
		.widget-6 .content-widget div[class*=col-] {
			display: flex;
			align-items: flex-end;
			justify-content: space-between;
			font-weight: bold;
			font-size: 12px;
		}
		
		.widget-6 .content-widget div[class*=col-] h4{
			color: #365280;
			margin: 0;
			font-weight: bold;
			font-size: 30px;
			margin-right: 10px;
			line-height: 1;
		}
		
		/* ------------------------------------------------------------------------------
		 *
		 *  # echart
		 *
		 * ---------------------------------------------------------------------------- */
		.btn-group-toggle .btn {
			font-size: 10px;
			color: #9E9E9E;
			border: 1px solid #9E9E9E;
			padding: 0px 15px;
			display: flex;
			align-items: center;
			border-radius: 0;
		}
		
		.btn-group-toggle .btn.active {
			background-color: #44A1EF;
			color: #FFFFFF;
			border: 1px solid #44A1EF;
		}
		
		.btn-group-toggle .btn.active.disabled {
			background-color: #BDBDBD;
			border: 1px solid #9E9E9E;
			border-right: 0;
		}
		
		#cpuUsage,
		#memoryUsage {
			min-height: 100px;
		}
		
		#vmRank,
		#hostRank {
			height: 150px;
			position: static !important;
		}
		
		#cpuRank,
		#memoryRank,
		#diskRank,
		#networkRank {
			height: 140px;
			position: static !important;
		}
		
		#serviceGroupName {
			font-size: 14px;
			margin-left: 15px;
			color: #365280;
		}
		
		/* ------------------------------------------------------------------------------
		 *
		 *  # 브라우저 크기 조정
		 *
		 * ---------------------------------------------------------------------------- */
		 
		 @media (max-width: 1200px) {
		 	.section-card>.card-body>.row>div[class*=col-]:not(:last-child) {
			    border-right: 0;
			}
			
			.widget-1, .widget-2, .widget-4, .rows-card .widget-3 {
				border-bottom: 1px solid #E0E0E0;
			}
			
			.widget-3 div[class*=col-]:first-child {
			    padding: 5px 0 0 0;
			    border-right: 0;
			    border-bottom: 1px solid #F5F5F5;
			}
			
			.widget-3 div[class*=col-]:last-child {
				padding: 0 0 0 5px;
			}
			
			.widget-5 .card-body {
				display: flex;
			}
			
			.widget-5 .row{
				width: 50%;
				height: 100% !important;
			}
			
			.widget-5 .row:first-child{
				padding: 0 15px 0 0 !important;
			}
			
			.widget-5 .row:last-child{
				padding: 0 0 0 15px !important;
			}
		 }
		 
		 /* ------------------------------------------------------------------------------
		 *
		 *  # 스크롤링 탭스
		 *
		 * ---------------------------------------------------------------------------- */
		 .scrtabs-tab-container {
		 	display: flex;
		 }
		 
		  .scrtabs-tabs-fixed-container {
		 	order: 1;
		 }
		 
		 .scrtabs-tab-scroll-arrow-left {
		 	order: 2;
		 }
		 
		  .scrtabs-tab-scroll-arrow-right {
		 	order: 3;
		 }
		 
		.glyphicon-chevron-left:before {
			font-family: 'Font Awesome 5 Free';
		    font-weight: 900;
			content: '\f053';
		}
		
		.glyphicon-chevron-right:before {
			font-family: 'Font Awesome 5 Free';
		    font-weight: 900;
			content: '\f054';
		}
	</style>

	<script type="text/javascript" src="${path}/resource/plugin/scrolling-tabs/scrolling-tabs.js"></script>
	<link href="${path}/resource/plugin/scrolling-tabs/scrolling-tabs.css" rel="stylesheet" type="text/css">
	
	<!-- 대시보드 새로고침 -->
	<meta http-equiv="Refresh" content="">
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		
		<!-- 본문 시작 -->
		<div class="content">
			<div class="card section-card">
				<div class="card-header">통합 데이터 센터 현황</div>
				<div class="card-body">
					<div class="row">
						<div class="col-xl-5 widget-1">
							<div class="row">
								<div class="col-6">
									<div class="row">
										<div class="col-6"><span>클러스터</span><h4 id="cluAll">0</h4></div>
										<div class="col-6"><span>호스트</span><h4 id="hostAll">0</h4></div>
									</div>
									<div class="row">
										<div class="col-6"><span>가상머신</span><h4 id="vmAll">0</h4></div>
										<div class="col-6"><span>템플릿</span><h4 id="templateAll">0</h4></div>
									</div>
								</div>
								<div class="col-6">
									<div class="row">
										<div class="col-6"><span>서비스 그룹</span><h4 id="tenAll">0</h4></div>
										<div class="col-6"><span>서비스</span><h4 id="serviceAll">0</h4></div>
									</div>
									<div class="row">
										<div class="col-6"><span>부서</span><h4 id="deptAll">0</h4></div>
										<div class="col-6"><span>사용자</span><h4 id="userAll">0</h4></div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-7 widget-3">
							<div class="row">
								<div class="col-xl-6 col-sm-6">
									<div class="card">
										<div class="card-header"><i class="fas fa-archive"></i>물리 자원 현황</div>
										<div class="card-body">
											<ul>
												<li><span>Core</span><div></div><div><h6 id="sumCPU">0</h6>개</div></li>
												<li><span>Memory</span><div></div><div><h6 id="sumMemory">0</h6>GB</div></li>
												<li><span>Storage</span><div></div><div><h6 id="all">0</h6>TB</div></li>
												<li><span>여유 Storage</span><div></div><div><h6 id="space">0</h6>TB</div></li>
											</ul>
										</div>
									</div>
								</div>
								<div class="col-xl-6 col-sm-6">
									<div class="card">
										<div class="card-header"><i class="fas fa-cube"></i>가상머신 할당 현황</div>
										<div class="card-body">
											<ul>
												<li><span>vCPU</span><div></div><div><h6 id="sumCPUVM">0</h6>EA</div></li>
												<li><span>Memory</span><div></div><div><h6 id="sumMemoryVM">0</h6>GB</div></li>
												<li><span>데이터스토어</span><div></div><div><h6 id="sumDiskVM">0</h6>TB</div></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="card section-card">
				<div class="card-header">클러스터별 현황</div>
				<div class="card-body">
					<ul class="nav nav-tabs" id="clusterTab">
						<li class="nav-item"><a href="#" class="nav-link" data-toggle="tab"><span class="spinner-border spinner-border-sm mr-2" role="status"></span>클러스터 로딩 중...</a></li>
					</ul>
					<div class="row">
						<div class="loading-background" id="clusterTab_loading">
							<div class="spinner-border" role="status"></div>
						</div>
						<div class="col-xl-7 rows-card">
							<div class="row">
								<div class="col-12 widget-3">
									<div class="row">
										<div class="col-xl-6 col-sm-6">
											<div class="card">
												<div class="card-header"><i class="fas fa-archive"></i>물리 자원 현황</div>
												<div class="card-body">
													<ul>
														<li><span>Core</span><div></div><div><h6 id="sumCPUCluster">0</h6>개</div></li>
														<li><span>Memory</span><div></div><div><h6 id="sumMemoryCluster">0</h6>GB</div></li>
													</ul>
												</div>
											</div>
										</div>
										<div class="col-xl-6 col-sm-6">
											<div class="card">
												<div class="card-header"><i class="fas fa-cube"></i>가상머신 할당 현황</div>
												<div class="card-body">
													<ul>
														<li><span>vCPU</span><div></div><div><h6 id="sumCPUVMCluster">0</h6>개</div></li>
														<li><span>Memory</span><div></div><div><h6 id="sumMemoryVMCluster">0</h6>GB</div></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-12 widget-3">
									<div class="row">
										<div class="col-xl-6 col-sm-12">
											<div class="card">
												<div class="card-header d-flex justify-content-between">
													<div><i class="fas fa-chart-bar"></i>호스트 TOP 5</div>
													<div class="btn-group btn-group-toggle" data-toggle="buttons">
														<label class="btn"><input type="radio" name="hostRankBtn" value="cpu" checked>CPU</label>
														<label class="btn"><input type="radio" name="hostRankBtn" value="memory">Memory</label>
													</div>
												</div>
												<div class="card-body">
													<div id="hostRank"></div>
													<div class="chartTime text-right" id="hostRankTime">0000-00-00 00:00:00</div>
												</div>
											</div>
										</div>
										<div class="col-xl-6 col-sm-12">
											<div class="card">
												<div class="card-header d-flex justify-content-between">
													<div><i class="fas fa-chart-bar"></i>가상머신 TOP 5</div>
													<div class="btn-group btn-group-toggle" data-toggle="buttons">
														<label class="btn"><input type="radio" name="vmRankBtn" value="cpu" checked>CPU</label>
														<label class="btn"><input type="radio" name="vmRankBtn" value="memory">Memory</label>
													</div>
												</div>
												<div class="card-body">
													<div id="vmRank"></div>
													<div class="chartTime text-right" id="vmRankTime">0000-00-00 00:00:00</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-2 widget-4">
							<div class="card">
								<div class="card-header"><i class="fas fa-chart-pie"></i>운영 현황</div>
								<div class="card-body">
									<div><div><span>호스트</span><div id="hostStatus"><h6><b>0</b> / 0</h6>Hosts</div></div></div>
									<div><div><span>가상머신</span><div id="vmStatus"><h6><b>0</b> / 0</h6>VMs</div></div></div>
									<div><div><span>데이터스토어</span><div id="datastoreStatus"><h6><b>0</b> / 0</h6>TB</div></div></div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 widget-5">
							<div class="card">
								<div class="card-header"><i class="fas fa-circle-notch"></i>평균 사용량</div>
								<div class="card-body">
									<div class="row">
										<div class="col-6"><span>CPU</span><div class="chartTime usageTime">0000-00-00 00:00:00</div></div>
										<div class="col-6"><div class="h-100" id="cpuUsage"></div></div>
									</div>
									<div class="row">
										<div class="col-6"><span>Memory</span><div class="chartTime usageTime">0000-00-00 00:00:00</div></div>
										<div class="col-6"><div class="h-100" id="memoryUsage"></div></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 본문 끝 -->
	</div>
	
	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			
			// 대시보드 새로고침
			refreshDashboard();
			
			// 통합 데이터 센터 현황
			getAllCount();
			getApprovalCount();
			getAllResourcePhysics();
			getAllResourceVMs();
			 
			// 클러스터 리스트
			getClusterList();
		});
		
		// 대시보드 새로고침 주기
		function refreshDashboard() {
			$.ajax({
				url: '/config/selectBasic.do',
				type: 'POST',
				data: {
					targetName: 'reflashInterval'
				},
				success: function(data) {

					// 기본 새로고침 주기는 20초
					if (data == null || data == '') {
						$('meta[http-equiv="Refresh"]').attr('content', 20);

					// [인프라 관리>기본 기능]에서 설정한 대시보드 새로고침 주기 값
					} else {
						$('meta[http-equiv="Refresh"]').attr('content', data.value);
					}
				}
			});
		}
		
		// 통합
		function getAllCount() {
			$.ajax({
				url: "/dash/selectAllCountList.do",
				type: 'POST',
				success: function(data) {
					for (key in data) {
						$('#' + key).html(data[key]);
					}
				}
			})
		}
	
		// 신청 승인 현황
		function getApprovalCount() {
			$.ajax({
				url: "/dash/selectAllApprovalCheckcnt.do",
				type: 'POST',
				success: function(data) {
					for (key in data) {
						$('#' + key).html(data[key]);
					}
				}
			})
		}
	
		// 물리 자원 현황
		function getAllResourcePhysics() {
			$.ajax({
				url: "/dash/selectAllResourcePhysics.do",
				type: 'POST',
				success: function(data) {
					for (key in data) {
						$('#' + key).html(data[key]);
						
						if (key == 'all' || key == 'space') {
							dataUnitTB = parseFloat(data[key]);
							dataUnitTB = (dataUnitTB / 1024).toFixed(1);
							
							$('#' + key).html(dataUnitTB);
						}
					}
				}
			});
		}
	
		// 가상머신 할당 현황
		function getAllResourceVMs() {
			$.ajax({
				url: "/dash/selectAllResourceVMs.do",
				type: 'POST',
				success: function(data) {
					for (key in data) {
						$('#' + key + 'VM').html(data[key]);

						if (key == 'sumDisk') {
							dataUnitTB = parseFloat(data[key]);
							dataUnitTB = (dataUnitTB / 1024).toFixed(1);
							
							$('#' + key + 'VM').html(dataUnitTB);
						}
					}
				}
			})
		}

		// 클러스터 리스트 탭
		function getClusterList() {
			$.ajax({
				url: "/tenant/selectClusterList.do",
				type: 'POST',
				beforeSend: function() {
					$('#clusterTab_loading').removeClass('d-none');
				},
				complete: function() {
					$('#clusterTab_loading').addClass('d-none');
				},
				success: function(data) {
					var html = '';
					
					// 데이터가 없을 때
					if (data == null || data == '') {
						html += '<li class="nav-item"><a href="#" class="nav-link" data-toggle="tab">클러스터가 없습니다.</a></li>';
						$('#clusterTab').empty().append(html);
						
					// 데이터가 있을 때
					} else {
						for (key in data) {
							html += '<li class="nav-item"><a href="#item' + key + '" class="nav-link" data-toggle="tab" id="' + data[key].clusterID + '">' + data[key].clusterName + '</a></li>';
						}
						
						$('#clusterTab').empty().append(html);
						
						// 스크롤링 탭 설정
						$('#clusterTab').scrollingTabs().scrollingTabs('refresh');
	
						// 탭을 선택할 때 마다 실행
						$('#clusterTab li a').off('shown.bs.tab').on('shown.bs.tab', function() {
							$('#clusterTab_loading').removeClass('d-none');
							
							var clusterId = $(this).attr('id');
							
							// 선택된 클러스터의 데이터 조회
							clusterData(clusterId);
							
							// 현재 활성화된 탭 아이디를 localStorage에 저장
							localStorage.setItem(sessionUserId + 'ActiveTab', clusterId);
						});
						
						// 클러스터 리스트 탭 기능
						clusterTabOptions();
					}
				}
			})
		}

		// 클러스터별 현황
		function clusterData(clusterId) {
			
			// 자원 현황
			getClusterResourcePhysics(clusterId);
			getClusterResourceVMs(clusterId);
			
			// TOP 5
			$('input[name="hostRankBtn"]').off('change').on('change', function() {
				getHostRank(clusterId, $('input[name="hostRankBtn"]:checked').val());
			});
			
			$('input[name="vmRankBtn"]').off('change').on('change', function() {
				getVMRank(clusterId, $('input[name="vmRankBtn"]:checked').val());
			});
			
			getHostRank(clusterId, 'cpu');
			getVMRank(clusterId, 'cpu');

			// 운영 현황
			getHostStatus(clusterId);
			getVMStatus(clusterId);
			getDatastoreStatus(clusterId);

			// 평균 사용량
			getUsage(clusterId);
		}

		// 물리 자원 현황 - 클러스터별
		function getClusterResourcePhysics(clusterId) {
			$.ajax({
				url: "/dash/selectClusterResourcePhysics.do",
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					for (key in data) {
						$('#' + key + 'Cluster').html(data[key]);
					}
				}
			})
		}

		// 가상머신 할당 현황 - 클러스터별
		function getClusterResourceVMs(clusterId) {
			$.ajax({
				url: "/dash/selectClusterResourceVMs.do",
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					for (key in data) {
						$('#' + key + 'VMCluster').html(data[key]);
					}
				}
			})
		}

		// 호스트 TOP 5
		function getHostRank(clusterId, orderKey) {
			$.ajax({
				url: "/dash/selectHostPerformanceTop5List.do",
				type: 'POST',
				data: {
					clusterId: clusterId,
					order: orderKey
				},
				success: function(data) {
					
					// 호스트 TOP 5 차트
					var chart = echarts.init($('#hostRank')[0]);
					var option = {
						// 툴팁 설정
						tooltip: {
							trigger: 'axis',
							backgroundColor: 'transparent',
							// card 형태로 툴팁 포맷
							formatter: function(params) {
								var html = '';

								html += '<div class="card card-tooltip">';
								html += '<div class="card-header">' + params[0].name + '</div>';
								html += '<div class="card-body">';
								html += '<div>' + params[0].marker + params[0].seriesName + ' : ' + params[0].value + ' %</div>';
								html += '<div>' + params[1].marker + params[1].seriesName + ' : ' + params[1].value + ' %</div>';
								html += '</div>';
								html += '</div>';

								return html;
							}
						},
						// 그리드 설정
						grid: {top: '2', left: '2', right: '2', bottom: '2', containLabel: true},
						// x축 설정 (cpu/memory 값)
						xAxis: {
							type: 'value',
							min: 0,
							max: 100,
							splitNumber: 10,
							axisTick: {show: false},
							axisLine: {lineStyle: {color: '#E0E0E0'}},
							axisLabel: {color: '#212121',align: 'right',fontSize: 10}, splitLine: {lineStyle: {color: '#E0E0E0'}}
						},
						// y축 설정 (호스트 이름)
						yAxis: {
							type: 'category',
							axisTick: {show: false},
							axisLine: {lineStyle: {color: '#E0E0E0'}},
							axisLabel: {color: '#212121',fontSize: 10},
							data: []
						},
						// cpu/memory 타입 bar 설정
						series: [{type: 'bar', barWidth: '15', data: []}, {type: 'bar', barWidth: '3', barGap: 0, data: []}]
					}
					
					// 데이터 없을 때
					if (data == null || data == '') {
						$('input[name="hostRankBtn"]').parent().addClass('disabled');
						var hostRankTime = '데이터가 없습니다.';
						
						option.series[0].data[0] = 0;
						option.series[1].data[0] = 0;
						
					// 데이터 있을 때
					} else {
						$('input[name="hostRankBtn"]').parent().removeClass('disabled');
						
						data.reverse();

						for (key in data) {
							option.yAxis.data[key] = data[key].hostName;

							// cpu일 때
							if (orderKey == 'cpu') {
								option.series[0].name = 'CPU';
								option.series[0].color = '#FC9700';
								option.series[0].data[key] = data[key].cpu;

								option.series[1].name = 'Memory';
								option.series[1].color = '#20CCDE';
								option.series[1].data[key] = data[key].memory;
							}

							// memory일 때
							if (orderKey == 'memory') {
								option.series[0].name = 'Memory';
								option.series[0].color = '#20CCDE';
								option.series[0].data[key] = data[key].memory;

								option.series[1].name = 'CPU';
								option.series[1].color = '#FC9700';
								option.series[1].data[key] = data[key].cpu;
							}
						}
						var hostRankTime = data[0].dispTimestamp;
					}
					chart.setOption(option, true);
					chart.resize();
					
					$('#hostRankTime').html(hostRankTime);
					
					// 차트 크기 조정
					$(window).resize(function() {
						chart.resize();
					});
				}
			})
		}

		// 가상머신 TOP 5
		function getVMRank(clusterId, orderKey) {
			$.ajax({
				url: "/dash/selectVMPerformanceTop5List.do",
				type: 'POST',
				data: {
					clusterId: clusterId,
					order: orderKey
				},
				success: function(data) {
					
					// 가상머신 차트
					var chart = echarts.init($('#vmRank')[0]);
					var option = {
						// 툴팁 설정
						tooltip: {
							trigger: 'axis',
							backgroundColor: 'transparent',
							// card 형태로 툴팁 포맷
							formatter: function(params) {
								var html = '';

								html += '<div class="card card-tooltip">';
								html += '<div class="card-header">' + params[0].name + '</div>';
								html += '<div class="card-body">';
								html += '<div>' + params[0].marker + params[0].seriesName + ' : ' + params[0].value + ' %</div>';
								html += '<div>' + params[1].marker + params[1].seriesName + ' : ' + params[1].value + ' %</div>';
								html += '</div>';
								html += '</div>';

								return html;
							}
						},
						// 그리드 설정
						grid: {top: '2', left: '2', right: '2', bottom: '2', containLabel: true},
						// x축 설정 (cpu/memory 값)
						xAxis: {
							type: 'value',
							min: 0,
							max: 100,
							splitNumber: 10,
							axisTick: {show: false},
							axisLine: {lineStyle: {color: '#E0E0E0'}},
							axisLabel: {color: '#212121',align: 'right',fontSize: 10}, splitLine: {lineStyle: {color: '#E0E0E0'}}
						},
						// y축 설정 (가상머신 이름)
						yAxis: {
							type: 'category',
							axisTick: {show: false},
							axisLine: {lineStyle: {color: '#E0E0E0'}},
							axisLabel: {color: '#212121',fontSize: 10},
							data: []
						},
						// cpu/memory 타입 bar 설정
						series: [{type: 'bar', barWidth: '15', data: []}, {type: 'bar', barWidth: '3', barGap: 0, data: []}]
					}

					// 데이터 없을 때
					if (data == null || data == '') {
						$('input[name="vmRankBtn"]').parent().addClass('disabled');
						var vmRankTime = '데이터가 없습니다.';
						
						option.series[0].data[0] = 0;
						option.series[1].data[0] = 0;
						
					// 데이터 있을 때
					} else {
						$('input[name="vmRankBtn"]').parent().removeClass('disabled');
						
						data.reverse();

						for (key in data) {
							option.yAxis.data[key] = data[key].vmName;

							// cpu일 때
							if (orderKey == 'cpu') {
								option.series[0].name = 'CPU';
								option.series[0].color = '#F06A6A';
								option.series[0].data[key] = data[key].cpu;

								option.series[1].name = 'Memory';
								option.series[1].color = '#20CCDE';
								option.series[1].data[key] = data[key].memory;
							}

							// memory일 때
							if (orderKey == 'memory') {
								option.series[0].name = 'Memory';
								option.series[0].color = '#20CCDE';
								option.series[0].data[key] = data[key].memory;

								option.series[1].name = 'CPU';
								option.series[1].color = '#F06A6A';
								option.series[1].data[key] = data[key].cpu;
							}
						}
						var vmRankTime = data[0].dispTimestamp;
					}
					chart.setOption(option, true);
					chart.resize();
					$("#vmRankTime").html(vmRankTime);
					
					// 차트 크기 조정
					$(window).resize(function() {
						chart.resize();
					});
				}
			})
		}

		// 운영 현황 - 호스트
		function getHostStatus(clusterId) {
			$.ajax({
				url: "/dash/selectHostsState.do",
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					if (data != null || data != '') {
						$('#hostStatus').html('<h6><b>' + data.powerOn + '</b> / ' + data.allCtn + '</h6>Hosts');
					}
				}
			})
		}

		// 운영 현황 - 가상머신
		function getVMStatus(clusterId) {
			$.ajax({
				url: "/dash/selectVMState.do",
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					if (data != null || data != '') {
						var allVM = 0;

						allVM = parseFloat(data.vmPowerOn + data.vmPowerOff);
						$('#vmStatus').html('<h6><b>' + data.vmPowerOn + '</b> / ' + allVM + '</h6>VMs');
					}
				}
			})
		}

		// 운영 현황 - 데이터스토어
		function getDatastoreStatus(clusterId) {
			$.ajax({
				url: '/dash/getDataStoreState.do',
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					if (data != null || data != '') {
						var allDatastore = 0;
						var useDatastore = 0;

						for (key in data) {
							allDatastore += parseFloat(data[key].stAllca);
							useDatastore += parseFloat(data[key].stUseca);
						}

						allDatastore = (allDatastore / 1024).toFixed(1);
						useDatastore = (useDatastore / 1024).toFixed(1);

						$('#datastoreStatus').html('<h6><b>' + useDatastore + '</b> / ' + allDatastore + '</h6>TB');
					}
				}
			})
		}

		// 평균 사용량 - cpu/memory
		function getUsage(clusterId) {
			$.ajax({
				url: '/dash/selectClusterAveragePerformanceList.do',
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					
					// cpu 평균 사용량 차트
					var cpuChart = echarts.init($('#cpuUsage')[0]);
					var cpuOption = {
						series: [{
							type: 'pie',
							hoverAnimation: false,
							radius: ['100%', '90%'],
							cursor: 'defalut',
							label: {show: true, position: 'center', fontSize: 24, color: '#212121', formatter: ''},
							data: []
						}],
						color: ['#5723C6', '#E0E0E0']
					}

					// memory 평균 사용량 차트
					var memoryChart = echarts.init($('#memoryUsage')[0]);
					var memoryOption = {
						series: [{
							type: 'pie',
							hoverAnimation: false,
							radius: ['100%', '90%'],
							cursor: 'defalut',
							label: {show: true, position: 'center', fontSize: 24, color: '#212121', formatter: ''},
							data: []
						}],
						color: ['#2384DE', '#E0E0E0']
					}

					// 데이터 없을 때
					if (data == null || data == '') {
						// cpu 평균 사용량
						cpuOption.series[0].data[0] = 0;
						cpuOption.series[0].data[1] = 100;
						cpuOption.series[0].label.formatter = 0 + '%';

						// memory 평균 사용량
						memoryOption.series[0].data[0] = 0;
						memoryOption.series[0].data[1] = 100;
						memoryOption.series[0].label.formatter = 0 + '%';

						var usageTime = '데이터가 없습니다.';

					// 데이터 있을 때
					} else {
						// cpu 평균 사용량
						cpuOption.series[0].data[0] = data[0].avgCPU;
						cpuOption.series[0].data[1] = 100 - data[0].avgCPU;
						cpuOption.series[0].label.formatter = data[0].avgCPU + '%';

						// memory 평균 사용량
						memoryOption.series[0].data[0] = data[0].avgMemory;
						memoryOption.series[0].data[1] = 100 - data[0].avgMemory;
						memoryOption.series[0].label.formatter = data[0].avgMemory + '%';

						// timestamp 날짜 형식 변환
						var usageTime = dateTimeConverter(data[0].timestamp);
					}

					cpuChart.setOption(cpuOption, true);
					memoryChart.setOption(memoryOption, true);
					cpuChart.resize();
					memoryChart.resize();

					$('.usageTime').html(usageTime);

					// 차트 크기 조정
					$(window).resize(function() {
						cpuChart.resize();
						memoryChart.resize();
					});
				}
			})
		}
		
		//모든 ajax 요청이 완료될 때
		 $(document).ajaxStop(function() {
			$('#clusterTab_loading').addClass('d-none');
		});
		
		// 탭 기능
		function clusterTabOptions() {
			
			// 사용자 별로 활성화 탭 저장
			// 활성화된 탭이 없으면 첫번 째 탭 선택
			var userActiveTab = localStorage.getItem(sessionUserId + 'ActiveTab');
			userActiveTab ? $('#clusterTab li #' + userActiveTab).click() : $('#clusterTab li:first-child a').click();
			
			// 탭 자동 롤링
			var tabChange = function () {
				var clusterTab  = $('#clusterTab li');
				var activeTab = clusterTab.find('a.active');
				var activeTabParent = activeTab.parent('li');
				var activeTabKey = parseInt(activeTab.attr('href').replace('#item', '')) + 1;
				
				// 마지막 탭 선택 시 첫번 째 탭 선택
				var nextTab = clusterTab.length == activeTabKey ? $('#clusterTab li:first-child a') : activeTabParent.next('li').find('a');
				nextTab.click();
			}
			
			// 10초 마다 실행
			var tabCycle = setInterval(tabChange, 10000);
			
			// 도중에 다른 탭 선택 시 탭 사이클 재실행
			$('#clusterTab li a').click(function() {
				clearInterval(tabCycle);
				tabCycle = setInterval(tabChange, 10000);
			});
		}
	</script>
</body>

</html>
