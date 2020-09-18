<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<link href="${path}/resources/scrollingTabs/jquery.scrolling-tabs.css" rel="stylesheet" type="text/css">
		<script src="${path}/resources/scrollingTabs/jquery.scrolling-tabs.js"></script>
	
		<script src="${path}/resources/external_JS/Chart.bundle.min.js"></script>
	</head>
	
	<body>
		<ul class="nav nav-tabs" id="clusterList"></ul> 
		<div class="tab-content">
			<div class="tab-pane active" id="content1">
				<div class="row">
					<div class="col-sm-7 col-xl-7">
						<div class="row">
							<div class="col-sm-12 col-xl-6">
								<div class="card mt-2 mb-0 bg-dark border-top-2 border-top-orange-300 border-bottom-2 border-bottom-orange-300 rounded-0 dashWidget-type-2">
									<div class="card-header">
										<h5 class="card-title mb-0">물리 자원 현황<span>Physical resource status</span></h5>
									</div>
									<div class="card-body">
										<div class="row">
											<div class="col-5">
												<span class="text-muted">Core</span>
												<h1 class="mb-0" id="dashBottomClusterResourcePhysicssumCPU">0</h1>
											</div>
											<div class="col-7">
												<span class="text-muted">Memory</span>
												<h1 class="mb-0" id="dashBottomClusterResourcePhysicssumMemory">0 GB</h1>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-12 col-xl-6">
								<div class="card mt-2 mb-0 bg-dark border-top-2 border-top-green border-bottom-2 border-bottom-green rounded-0 dashWidget-type-2">
									<div class="card-header">
										<h5 class="card-title mb-0">가상머신 할당 현황<span>Virtual Machine Status</span></h5>
									</div>
									<div class="card-body text-center">
										<div class="row">
											<div class="col-5">
												<span class="text-muted">vCPU</span>
												<h1 class="mb-0" id="dashBottomClusterResourcesumCPU">0</h1>
											</div>
											<div class="col-7">
												<span class="text-muted">Memory</span>
												<h1 class="mb-0" id="dashBottomClusterResourcesumMemory">0 GB</h1>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
	
						<div class="row">
							<div class="col-sm-12 col-xl-6">
								<div class="card bg-dark mt-2 mb-0 dashWidget-type-4">
									<div class="card-header">
										<h6 class="card-title mb-0">
											호스트 TOP 5<span>데이터 로딩 시간 : <span id="hostUseTime"></span></span>
										</h6>
									</div>
									<div id="topHostCarousel" class="carousel slide" data-ride="carousel" data-interval="false">
										<ol class="carousel-indicators">
											<li data-target="#topHostCarousel" data-slide-to="0" class="active"></li>
											<li data-target="#topHostCarousel" data-slide-to="1"></li>
										</ol>
										<div class="carousel-inner table-type-6">
											<div class="carousel-item active">
												<div class="card bg-dark mb-0 table-type-2 table-type-5-7">
													<div class="datatables-body">
														<table class="promTable hover" style="width:100%;">
															<thead>
																<tr>
																	<th>이름</th>
																	<th>CPU</th>
																	<th>Memory</th>
																</tr>
															</thead>
															<tbody id="clusterTOP5HostCPU">
																<tr>
																	<td class="text-center" colspan="3">데이터가 없습니다.</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
											<div class="carousel-item">
												<div class="card bg-dark mb-0 table-type-2 table-type-5-7">
													<div class="datatables-body">
														<table class="promTable hover" style="width:100%;">
															<thead>
																<tr>
																	<th>이름</th>
																	<th>CPU</th>
																	<th>Memory</th>
																</tr>
															</thead>
															<tbody id="clusterTOP5HostMemory">
																<tr>
																	<td class="text-center" colspan="3">데이터가 없습니다.</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
										<div class="carousel-nav">
											<a class="carousel-control-prev" href="#topHostCarousel" role="button" data-slide="prev"><i class="icon-2x icon-arrow-left12"></i></a>
											<a class="carousel-control-next" href="#topHostCarousel" role="button" data-slide="next"><i class="icon-2x icon-arrow-right13"></i></a>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-12 col-xl-6">
								<div class="card bg-dark mt-2 mb-0 dashWidget-type-4">
									<div class="card-header">
										<h6 class="card-title mb-0">
											가상머신 TOP 5<span>데이터 로딩 시간 : <span id="vmUseTime"></span></span>
										</h6>
									</div>
									<div id="topVMCarousel" class="carousel slide" data-ride="carousel" data-interval="false">
										<ol class="carousel-indicators">
											<li data-target="#topVMCarousel" data-slide-to="0" class="active"></li>
											<li data-target="#topVMCarousel" data-slide-to="1"></li>
										</ol>
										<div class="carousel-inner table-type-6">
											<div class="carousel-item active">
												<div class="card bg-dark mb-0 table-type-2 table-type-5-7">
													<div class="datatables-body">
														<table class="promTable hover" style="width:100%;">
															<thead>
																<tr>
																	<th>이름</th>
																	<th>vCPU</th>
																	<th>Memory</th>
																</tr>
															</thead>
															<tbody id="clusterTOP5CPU">
																<tr>
																	<td class="text-center" colspan="3">데이터가 없습니다.</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
											<div class="carousel-item">
												<div class="card bg-dark mb-0 table-type-2 table-type-5-7">
													<div class="datatables-body">
														<table class="promTable hover" style="width:100%;">
															<thead>
																<tr>
																	<th>이름</th>
																	<th>vCPU</th>
																	<th>Memory</th>
																</tr>
															</thead>
															<tbody id="clusterTOP5Memory">
																<tr>
																	<td class="text-center" colspan="3">데이터가 없습니다.</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
										<div class="carousel-nav">
											<a class="carousel-control-prev" href="#topVMCarousel" role="button" data-slide="prev"><i class="icon-2x icon-arrow-left12"></i></a>
											<a class="carousel-control-next" href="#topVMCarousel" role="button" data-slide="next"><i class="icon-2x icon-arrow-right13"></i></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-5 col-xl-5 nolink">
						<div class="row">
							<div class="col-sm-12 col-xl-4">
								<div class="card bg-dark mt-2 mb-0 table-type-1">
									<div class="table-title-light cpointer" onclick="javascript:window.parent.location.href='/menu/inventoryStatus.do#3'">
										<h6 class="card-title mb-0">호스트 현황</h6>
									</div>
									<div class="clusterWidget-chart-body-2">
										<canvas id="hostChart"></canvas>
										<div class="clusterWidget-chart-title" id="totalHost"></div>
									</div>
								</div>
							</div>
							<div class="col-sm-12 col-xl-4">
								<div class="card bg-dark mt-2 mb-0 table-type-1">
									<div class="table-title-light cpointer" onclick="javascript:window.parent.location.href='/menu/inventoryStatus.do#1'">
										<h6 class="card-title mb-0">가상머신 현황</h6>
									</div>
									<div class="clusterWidget-chart-body-2">
										<canvas id="vmChart"></canvas>
										<div class="clusterWidget-chart-title" id="totalVM"></div>
									</div>
								</div>
							</div>
							<div class="col-sm-12 col-xl-4">
								<div class="card bg-dark mt-2 mb-0 table-type-1">
									<div class="table-title-light cpointer" onclick="javascript:window.parent.location.href='/menu/inventoryStatus.do#4'">
										<h6 class="card-title mb-0">데이터스토어 현황</h6>
									</div>
									<div class="clusterWidget-chart-body-2">
										<canvas id="datastoreChart"></canvas>
										<div class="clusterWidget-chart-title" id="totalDatastore"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6 col-xl-6">
								<div class="card bg-dark mt-2 mb-0 table-type-1">
									<div class="table-title-light">
										<h6 class="card-title mb-0">CPU 평균 사용량</h6>
									</div>
									<div class="clusterWidget-chart-body-1" id="clusterInHostCPUResourceChart"></div>
								</div>
							</div>
							<div class="col-sm-6 col-xl-6">
								<div class="card bg-dark mt-2 mb-0 table-type-1">
									<div class="table-title-light">
										<h6 class="card-title mb-0">Memory 평균 사용량</h6>
									</div>
									<div class="clusterWidget-chart-body-1" id="clusterInHostMemoryResourceChart"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<script>
			var globalClusterId = null;
			$(document).ready(function() {
				$("#dataloading").show();
				$(".nav-tabs").scrollingTabs();
				getClusterList();
	
				setInterval(function() {
					getClusterResourceVMs(globalClusterId);
					getClusterResourcePhysics(globalClusterId);
					getClusterInHostStates(globalClusterId);
					getClusterInVMStates(globalClusterId);
					getClusterInDataStoreStates(globalClusterId);
	
					getClusterInHostRanking('cpu', globalClusterId);
					getClusterInHostRanking('memory', globalClusterId);
	
					getClusterInVMRanking('cpu', globalClusterId);
					getClusterInVMRanking('memory', globalClusterId);
					getClusterInResourceGraph(globalClusterId);
				}, 20000)
	
				if (sessionApproval == BanNumber) {
					ftnlimited(99);
					$('div').removeClass('cpointer');
				}
			});
	
			var clusterInHostCPUResourceChart = echarts.init($('#clusterInHostCPUResourceChart')[0]);
			var clusterInHostMemoryResourceChart = echarts.init($('#clusterInHostMemoryResourceChart')[0]);
	
			var clusterInHostCPUResourceChartOption = {
				tooltip: {
					backgroundColor: 'rgba(255, 255, 255, 0.9)',
					padding: [15],
					textStyle: {
						fontSize: 13,
						color: '#333'
					},
					formatter: '<b>{a}</b><br/>{b} : {c} %'
				},
				series: [{
					name: 'CPU 사용량',
					type: 'gauge',
					center: ['50%', '59%'],
					radius: '100%',
					axisLine: {
						lineStyle: {
							color: [
								[0.05, '#8ac24b'],
								[0.10, '#95C648'],
								[0.15, '#A0CB45'],
								[0.20, '#ABCF42'],
								[0.25, '#B6D33F'],
								[0.30, '#C1D83C'],
								[0.35, '#ccdc39'],
								[0.40, '#D4D831'],
								[0.45, '#DDD328'],
								[0.50, '#E5CF20'],
								[0.55, '#EDCA17'],
								[0.60, '#F6C60F'],
								[0.65, '#fec106'],
								[0.70, '#FAAC05'],
								[0.75, '#F79703'],
								[0.80, '#F38102'],
								[0.85, '#ef6c00'],
								[0.90, '#EB5B11'],
								[0.95, '#E74A22'],
								[1.00, '#e33933']
							],
							width: 10
						}
					},
					axisTick: {
						splitNumber: 10,
						length: 15,
						lineStyle: {
							color: 'auto'
						}
					},
					splitLine: {
						length: 18,
						lineStyle: {
							color: 'auto'
						}
					},
					title: {
						offsetCenter: [0, '-25%'],
						textStyle: {
							fontSize: 14,
							color: '#999'
						}
					},
					detail: {
						offsetCenter: [-2, '45%'],
						formatter: '{value}% ',
						textStyle: {
							fontSize: 17,
							fontWeight: 700
						}
					},
					pointer: {
						length: '60%',
						width: 3
					},
					data: [{
						value: 0,
						name: 'CPU'
					}]
				}]
			};
	
			var clusterInHostMemoryResourceChartOption = {
				tooltip: {
					backgroundColor: 'rgba(255, 255, 255, 0.9)',
					padding: [15],
					textStyle: {
						fontSize: 13,
						color: '#333'
					},
					formatter: '<b>{a}</b><br/>{b} : {c} %'
				},
				series: [{
					name: 'Memory 사용량',
					type: 'gauge',
					center: ['50%', '59%'],
					radius: '100%',
					axisLine: {
						lineStyle: {
							color: [
								[0.05, '#8ac24b'],
								[0.10, '#95C648'],
								[0.15, '#A0CB45'],
								[0.20, '#ABCF42'],
								[0.25, '#B6D33F'],
								[0.30, '#C1D83C'],
								[0.35, '#ccdc39'],
								[0.40, '#D4D831'],
								[0.45, '#DDD328'],
								[0.50, '#E5CF20'],
								[0.55, '#EDCA17'],
								[0.60, '#F6C60F'],
								[0.65, '#fec106'],
								[0.70, '#FAAC05'],
								[0.75, '#F79703'],
								[0.80, '#F38102'],
								[0.85, '#ef6c00'],
								[0.90, '#EB5B11'],
								[0.95, '#E74A22'],
								[1.00, '#e33933']
							],
							width: 10
						}
					},
					axisTick: {
						splitNumber: 10,
						length: 15,
						lineStyle: {
							color: 'auto'
						}
					},
					splitLine: {
						length: 18,
						lineStyle: {
							color: 'auto'
						}
					},
					title: {
						offsetCenter: [0, '-25%'],
						textStyle: {
							fontSize: 14,
							color: '#999'
						}
					},
					detail: {
						offsetCenter: [-3, '45%'],
						formatter: '{value}% ',
						textStyle: {
							fontSize: 17,
							fontWeight: 700
						}
					},
					pointer: {
						length: '60%',
						width: 3
					},
					data: [{
						value: 0,
						name: 'Memory'
					}]
				}]
			};
	
			clusterInHostCPUResourceChart.setOption(clusterInHostCPUResourceChartOption);
			clusterInHostMemoryResourceChart.setOption(clusterInHostMemoryResourceChartOption);
	
			$(window).resize(function() {
				clusterInHostCPUResourceChart.resize();
				clusterInHostMemoryResourceChart.resize();
			});
			
			// 게이지 그래프
			function getClusterInResourceGraph(clusterId) {
				globalClusterId = clusterId;
				var dateChk = 1;
				$.ajax({
					data: {
						clusterId: clusterId,
						dateChk: dateChk
					},
					url: "/dash/getPerfHosts.do",
					timeout: 5000,
					success: function(hostPerf) {
						if (hostPerf == null || hostPerf == '') {
							clusterInHostCPUResourceChartOption.series[0].name = '메트릭에 사용할 수 있는 성능 데이터가 없습니다.';
							clusterInHostMemoryResourceChartOption.series[0].name = '메트릭에 사용할 수 있는 성능 데이터가 없습니다.';
	
						} else {
							var date = new Date(hostPerf[0].timestamp);
	
							var year = date.getFullYear();
							var month = date.getMonth() + 1;
							var day = date.getDay();
							var hour = date.getHours();
							var min = date.getMinutes();
							var sec = date.getSeconds();
	
							var retVal = year + "-" + (month < 10 ? "0" + month : month) + "-" + (day < 10 ? "0" + day : day) + " " + (hour < 10 ? "0" + hour : hour) + ":" + (min < 10 ? "0" + min : min) + ":" + (sec < 10 ? "0" + sec : sec);
	
							clusterInHostCPUResourceChartOption.series[0].name = retVal;
							clusterInHostMemoryResourceChartOption.series[0].name = retVal;
	
							clusterInHostCPUResourceChartOption.series[0].data[0].value = hostPerf[0].cpu;
							clusterInHostMemoryResourceChartOption.series[0].data[0].value = hostPerf[0].memory;
						}
						clusterInHostCPUResourceChart.setOption(clusterInHostCPUResourceChartOption, true);
						clusterInHostMemoryResourceChart.setOption(clusterInHostMemoryResourceChartOption, true);
					}
				})
			}
	
			//원형 그래프
			Chart.defaults.global.legend.display = false;
			Chart.defaults.global.defaultFontColor = "#dedede";
	
			var optionsHost = {
				type: 'doughnut',
				data: {
					labels: ["운영중", "연결 끊김"],
					datasets: [{
						data: [],
						backgroundColor: ["#009fe8", "#dbdbdb"],
						hoverBackgroundColor: ["#009fe8", "#dbdbdb"],
						weight: 2,
						borderWidth: [0, 0]
					}]
				},
				options: {
					hover: {
						onHover: function(e, el) {
							$("#hostChart").css("cursor",
								el[0] ? "pointer" : "default");
						}
					},
					cutoutPercentage: 88,
					animation: {
						animateScale: true,
						duration: 1000
					},
					legend: {
						display: false
					},
					maintainAspectRatio: false,
					tooltips: {
						displayColors: false,
						callbacks: {
							title: function(tooltipItem, data) {
								return data['labels'][tooltipItem[0]['index']];
							},
							label: function(tooltipItem, data) {
								return data['datasets'][0]['data'][tooltipItem['index']] + ' Hosts';
							}
						},
						titleFontStyle: "bold",
						titleFontColor: '#000',
						backgroundColor: '#fff',
						bodyFontColor: '#000',
						caretSize: 5,
						cornerRadius: 2,
						xPadding: 20,
						yPadding: 10
					}
				}
			}
	
			var optionsVM = {
				type: 'doughnut',
				data: {
					labels: ["운영중", "전원 꺼짐"],
					datasets: [{
						data: [],
						backgroundColor: ["#009fe8", "#dbdbdb"],
						hoverBackgroundColor: ["#009fe8", "#dbdbdb"],
						weight: 2,
						borderWidth: [0, 0]
					}]
				},
	
				options: {
					hover: {
						onHover: function(e, el) {
							$("#vmChart").css("cursor",
								el[0] ? "pointer" : "default");
						}
					},
					cutoutPercentage: 88,
					animation: {
						animateScale: true,
						duration: 1000
					},
					legend: {
						display: false
					},
					maintainAspectRatio: false,
					tooltips: {
						displayColors: false,
						callbacks: {
							title: function(tooltipItem, data) {
								return data['labels'][tooltipItem[0]['index']];
							},
							label: function(tooltipItem, data) {
								return data['datasets'][0]['data'][tooltipItem['index']] + ' VMs';
							}
						},
						titleFontStyle: "bold",
						titleFontColor: '#000',
						backgroundColor: '#fff',
						bodyFontColor: '#000',
						caretSize: 5,
						cornerRadius: 2,
						xPadding: 20,
						yPadding: 10
					}
				}
			}
	
			var optionsDatastore = {
				type: 'doughnut',
				data: {
					labels: ["할당 용량", "남은 용량"],
					datasets: [{
						data: [],
						backgroundColor: ["#009fe8", "#dbdbdb"],
						hoverBackgroundColor: ["#009fe8", "#dbdbdb"],
						weight: 2,
						borderWidth: [0, 0]
					}]
				},
				options: {
					hover: {
						onHover: function(e, el) {
							$("#datastoreChart").css("cursor",
								el[0] ? "pointer" : "default");
						}
					},
					cutoutPercentage: 88,
					animation: {
						animateScale: true,
						duration: 1000
					},
					legend: {
						display: false
					},
					maintainAspectRatio: false,
					tooltips: {
						displayColors: false,
						callbacks: {
							title: function(tooltipItem, data) {
								return data['labels'][tooltipItem[0]['index']];
							},
							label: function(tooltipItem, data) {
								return data['datasets'][0]['data'][tooltipItem['index']] + ' TB';
							}
						},
						titleFontStyle: "bold",
						titleFontColor: '#000',
						backgroundColor: '#fff',
						bodyFontColor: '#000',
						caretSize: 5,
						cornerRadius: 2,
						xPadding: 20,
						yPadding: 10
					}
				}
			}
	
			var ctxHost = document.getElementById('hostChart').getContext('2d');
			var hostdoughnutChart = new Chart(ctxHost, optionsHost);
	
			var ctxVM = document.getElementById('vmChart').getContext('2d');
			var vmdoughnutChart = new Chart(ctxVM, optionsVM);
	
			var ctxDatastore = document.getElementById('datastoreChart').getContext('2d');
			var datastoredoughnutChart = new Chart(ctxDatastore, optionsDatastore);
	
			function getClusterList() {
				$.ajax({
					url: "/tenant/selectClusterList.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {} else {
							for (key in data) {
								var strClusterID = "\'" + data[key].clusterID + "\'";
								var strClusterName = "\'" + data[key].clusterName + "\'";
								html += '<li class="nav-item"><a href="#content' + key + '" class="nav-link" onclick="getClusterSpecResource(' + strClusterID + ', ' + strClusterName + ')" data-toggle="tab">' + data[key].clusterName + '</a></li>';
							}
							getClusterSpecResource(data[0].clusterID, data[0].clusterName);
						}
						$("#clusterList").empty();
						$("#clusterList").append(html);
						
						// nav tabs 새로고침
						$(".nav-tabs").scrollingTabs("refresh");
						
						$("#clusterList a[href='#content0']").trigger("click");
	
						// 새로고침시 활성탭 유지
						$("#clusterList a[data-toggle='tab']").on("show.bs.tab", function() {
							localStorage.setItem("activeTab", $(this).attr("href"));
						});
						var activeTab = localStorage.getItem("activeTab");
						if (activeTab) {
							$("#clusterList a[href='" + activeTab + "']").trigger("click");
						}
	
						$("#dataloading").hide();
					}
				})
			}
	
			function getClusterSpecResource(clusterId, clusterName) {
				getClusterResourceVMs(clusterId);
				getClusterResourcePhysics(clusterId);
				getClusterInHostStates(clusterId);
				getClusterInVMStates(clusterId);
				getClusterInDataStoreStates(clusterId);
	
				getClusterInHostRanking('cpu', clusterId);
				getClusterInHostRanking('memory', clusterId);
	
				getClusterInVMRanking('cpu', clusterId);
				getClusterInVMRanking('memory', clusterId);
	
				getClusterInResourceGraph(clusterId);
			}
	
			function getClusterResourceVMs(clusterId) {
				$.ajax({
					url: "/dash/getClusterResourceVMs.do",
					data: {
						clusterId: clusterId
					},
					success: function(data) {
						$("#dashBottomClusterResourcesumCPU").empty();
						$("#dashBottomClusterResourcesumCPU").append(numberWithCommas(data['sumCPU']));
	
						$("#dashBottomClusterResourcesumMemory").empty();
						$("#dashBottomClusterResourcesumMemory").append(numberWithCommas(data['sumMemory']) + ' GB');
					}
				})
			}
	
			function getClusterResourcePhysics(clusterId) {
				$.ajax({
					url: "/dash/getClusterResourcePhysics.do",
					data: {
						clusterId: clusterId
					},
					success: function(data) {
						$("#dashBottomClusterResourcePhysicssumCPU").empty();
						$("#dashBottomClusterResourcePhysicssumCPU").append(numberWithCommas(data['sumCPU']));
	
						$("#dashBottomClusterResourcePhysicssumMemory").empty();
						$("#dashBottomClusterResourcePhysicssumMemory").append(numberWithCommas(data['sumMemory']) + ' GB');
					}
				})
			}
	
			function getClusterInHostStates(clusterId) {
	
				$.ajax({
	
					url: "/dash/getHostsState.do",
					data: {
						clusterId: clusterId
					},
					success: function(data) {
						var html = '';
	
						html += '<h6 class="text-center text-muted mb-0">TOTAL</h6>';
						html += '<h2 class="text-center mb-0"><span class="text-prom">' + data['powerOn'] + '</span> / ' + data["allCtn"] + ' <span class="font-size-base text-muted"> Hosts</span></h2>';
	
						$("#totalHost").empty();
						$("#totalHost").append(html);
	
						optionsHost.data.datasets[0].data = [];
	
						optionsHost.data.datasets[0].data[0] = data["powerOn"];
						optionsHost.data.datasets[0].data[1] = data["powerOff"];
	
						hostdoughnutChart.update();
					}
				})
			}
	
			function getClusterInVMStates(clusterId) {
	
				$.ajax({
	
					url: "/dash/getVMState.do",
					data: {
						clusterId: clusterId
					},
					success: function(data) {
						var html = '';
						var vmSumCnt = 0;
	
						vmSumCnt = parseInt(data["vmPowerOn"]) + parseInt(data["vmPowerOff"]);
	
						html += '<h6 class="text-center text-muted mb-0">TOTAL</h6>';
						html += '<h2 class="text-center mb-0"><span class="text-prom">' + data["vmPowerOn"] + '</span> / ' + vmSumCnt + ' <span class="font-size-base text-muted"> VMs</span></h2>';
	
						$("#totalVM").empty();
						$("#totalVM").append(html);
	
						optionsVM.data.datasets[0].data = [];
	
						optionsVM.data.datasets[0].data[0] = data["vmPowerOn"];
						optionsVM.data.datasets[0].data[1] = data["vmPowerOff"];
	
						vmdoughnutChart.update();
	
					}
				})
			}
	
			function getClusterInDataStoreStates(clusterId) {
				$.ajax({
					url: "/dash/getDataStoreState.do",
					data: {
						clusterId: clusterId
					},
					success: function(data) {
						var html = '';
						var all = 0;
						var use = 0;
						var space = 0;
						var GBtoTB = 1024;
						for (key in data) {
	
							all += data[key].st_Allca
							use += data[key].st_Useca
							space += data[key].st_space
	
						}
	
						all = (all / GBtoTB);
						use = (use / GBtoTB);
						space = (space / GBtoTB);
	
						html += '<h6 class="text-center text-muted mb-0">TOTAL</h6>';
						html += '<h2 class="text-center mb-0"><span class="text-prom">' + use.toFixed(1) + '</span> / ' + all.toFixed(1) + ' <span class="font-size-base text-muted"> TB</span></h2>';
	
						$("#totalDatastore").empty();
						$("#totalDatastore").append(html);
	
						optionsDatastore.data.datasets[0].data = [];
	
						optionsDatastore.data.datasets[0].data[0] = use.toFixed(1);
						optionsDatastore.data.datasets[0].data[1] = space.toFixed(1);
	
						datastoredoughnutChart.update();
					}
				})
			}
	
			function getClusterInHostRanking(orderKey, clusterId) {
				$.ajax({
					url: "/dash/getClusterInHostRanking.do",
					data: {
						orderKey: orderKey,
						clusterId: clusterId
					},
					success: function(data) {
						var category = '';
						var html = '';
						for (key in data) {
							var hostLink = hostMonitoringLink(clusterId, data[key].name);
	
							html += '<tr class="cpointer" onclick="javascript:window.parent.location.href=' + hostLink + '">';
	
							html += '<td class="font-size-small">' + data[key].name + '</td>';
	
							if (data[key].cpu > 90) {
								html += '<td class="text-danger">' + data[key].cpu + '%</td>';
							} else if (data[key].cpu > 80) {
								html += '<td class="text-warning">' + data[key].cpu + '%</td>';
							} else if (data[key].cpu > 70) {
								html += '<td class="text-orange">' + data[key].cpu + '%</td>';
							} else {
								html += '<td>' + data[key].cpu + '%</td>';
							}
	
							if (data[key].memory > 90) {
								html += '<td class="text-danger">' + data[key].memory + '%</td>';
							} else if (data[key].memory > 80) {
								html += '<td class="text-warning">' + data[key].memory + '%</td>';
							} else if (data[key].memory > 70) {
								html += '<td class="text-orange">' + data[key].memory + '%</td>';
							} else {
								html += '<td>' + data[key].memory + '%</td>';
							}
	
							html += '</tr>';
						}
	
						if (orderKey == 'cpu') {
							category = 'clusterTOP5HostCPU';
						} else if (orderKey == 'memory') {
							category = 'clusterTOP5HostMemory';
						}
	
						$("#hostUseTime").empty();
						$("#hostUseTime").append(data[0].timeString);
	
						$("#" + category).empty();
						$("#" + category).append(html);
	
					}
				})
			}
	
			function getClusterInVMRanking(orderKey, clusterId) {
				$.ajax({
					url: "/dash/getClusterInVMRanking.do",
					data: {
						orderKey: orderKey,
						clusterId: clusterId
					},
					success: function(data) {
						var html = '';
						var category = '';
						var ten = '';
						var se = '';
						for (key in data) {
							if (data[key].tenants_id == 0) {
								ten = 'De';
							} else {
								ten = data[key].tenants_id;
							}
	
							if (data[key].service_id == 0) {
								se = 'De';
							} else {
								se = data[key].service_id;
							}
	
							var vmLink = "\'" + '/menu/monitoring.do?vn=' + data[key].id + '&ten=' + ten + '&se=' + se + "#1\'";
	
							html += '<tr class="cpointer" onclick="javascript:window.parent.location.href=' + vmLink + '">';
	
							html += '<td class="font-size-small">' + data[key].name + ' (' + data[key].serviceName + ')</td>';
	
							if (data[key].cpu > 90) {
								html += '<td class="text-danger">' + data[key].cpu + '%</td>';
							} else if (data[key].cpu > 80) {
								html += '<td class="text-warning">' + data[key].cpu + '%</td>';
							} else if (data[key].cpu > 70) {
								html += '<td class="text-orange">' + data[key].cpu + '%</td>';
							} else {
								html += '<td>' + data[key].cpu + '%</td>';
							}
	
							if (data[key].memory > 90) {
								html += '<td class="text-danger">' + data[key].memory + '%</td>';
							} else if (data[key].memory > 80) {
								html += '<td class="text-warning">' + data[key].memory + '%</td>';
							} else if (data[key].memory > 70) {
								html += '<td class="text-orange">' + data[key].memory + '%</td>';
							} else {
								html += '<td>' + data[key].memory + '%</td>';
							}
	
							html += '</tr>';
	
						}
	
						if (orderKey == 'cpu') {
							category = 'clusterTOP5CPU';
						} else if (orderKey == 'memory') {
							category = 'clusterTOP5Memory';
						}
	
						$("#vmUseTime").empty();
						$("#vmUseTime").append(data[0].timeString);
	
						$("#" + category).empty();
						$("#" + category).append(html);
					}
				})
			}
			/* 가상머신 TOP5 */
		</script>
	</body>
</html>