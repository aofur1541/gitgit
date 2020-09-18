<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta http-equiv="Refresh" content="20">
	</head>
	<body>
		<div id="dayVcenterAlertCheck"></div>
		<div class="row">
			<div class="col-xl-6">
				<div class="card bg-dark">
					<div class="card-header header-elements-inline">
						<h6 class="card-title">
							<i class="icon-cloud2"></i>클라우드 운영 현황
						</h6>
					</div>
					<div class="card-body cloud-chart-body">
						<canvas id="cloudChart"></canvas>
					</div>
				</div>
			</div>
			<div class="col-xl-6">
				<div class="row">
					<div class="col-xl-4 col-sm-4">
						<div class="card bg-dark">
							<div class="card-header header-elements-inline">
								<h6 class="card-title cpointer" onclick="location.href='Mallhostlist.do'">
									<i class="icon-server"></i>호스트 현황
								</h6>
								<div class="header-elements">
									<div class="list-icons"></div>
								</div>
							</div>
							<div class="card-body chart-body">
								<canvas id="hostChart"></canvas>
								<div class="doughnut-title" id="totalHost"></div>
							</div>
						</div>
					</div>
					<div class="col-xl-4 col-sm-4">
						<div class="card bg-dark">
							<div class="card-header header-elements-inline">
								<h6 class="card-title cpointer" onclick="location.href='/menu/inventoryStatus.do#1'">
									<i class="icon-cube4"></i>가상머신 현황
								</h6>
								<div class="header-elements">
									<div class="list-icons"></div>
								</div>
							</div>
							<div class="card-body chart-body">
								<canvas id="vmChart"></canvas>
								<div class="doughnut-title" id="totalVM"></div>
							</div>
						</div>
					</div>
					<div class="col-xl-4 col-sm-4">
						<div class="card bg-dark">
							<div class="card-header header-elements-inline">
								<h6 class="card-title cpointer" onclick="location.href='/menu/inventoryStatus.do#3'">
									<i class="icon-database"></i>데이터스토어 현황
								</h6>
								<div class="header-elements">
									<div class="list-icons"></div>
								</div>
							</div>
							<div class="card-body chart-body">
								<canvas id="datastoreChart"></canvas>
								<div class="doughnut-title" id="totalDatastore"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xl-6 col-sm-12">
				<div class="card bg-dark table-type-1">
					<div class="table-title-dark">
						<h6 class="card-title mb-0">
							가상머신 TOP 5 
							<span class="text-muted font-size-base ml-2">데이터 로딩 시간 : <span id="vmUseTime"></span></span>
						</h6>
					</div>
					<div id="topVMCarousel" class="carousel slide" data-ride="carousel" data-interval="false">
						<ol class="carousel-indicators">
							<li data-target="#topVMCarousel" data-slide-to="0" class="active"></li>
							<li data-target="#topVMCarousel" data-slide-to="1"></li>
							<li data-target="#topVMCarousel" data-slide-to="2"></li>
							<li data-target="#topVMCarousel" data-slide-to="3"></li>
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
													<th>Disk</th>
													<th>Network</th>
												</tr>
											</thead>
											<tbody id="vmRankingCPUTop5">
												<tr>
													<td class="text-center" colspan="5">데이터가 없습니다.</td>
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
													<th>Disk</th>
													<th>Network</th>
												</tr>
											</thead>
											<tbody id="vmRankingMemoryTop5">
												<tr>
													<td class="text-center" colspan="5">데이터가 없습니다.</td>
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
													<th>Disk</th>
													<th>Network</th>
												</tr>
											</thead>
											<tbody id="vmRankingDiskTop5">
												<tr>
													<td class="text-center" colspan="5">데이터가 없습니다.</td>
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
													<th>Disk</th>
													<th>Network</th>
												</tr>
											</thead>
											<tbody id="vmRankingNetworkTop5">
												<tr>
													<td class="text-center" colspan="5">데이터가 없습니다.</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="carousel-nav">
							<a class="carousel-control-prev" href="#topVMCarousel" role="button" data-slide="prev"><i class="icon-2x icon-arrow-left12" ></i></a>
							<a class="carousel-control-next" href="#topVMCarousel" role="button" data-slide="next"><i class="icon-2x icon-arrow-right13"></i></a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xl-6 col-sm-12">
				<div class="card bg-dark table-type-1">
					<div class="table-title-dark">
						<h6 class="card-title mb-0">
							호스트 TOP 5 
							<span class="text-muted font-size-base ml-2">데이터 로딩 시간 : <span id="hostUseTime"></span></span>
						</h6>
					</div>
					<div id="topHostCarousel" class="carousel slide" data-ride="carousel" data-interval="false">
						<ol class="carousel-indicators">
							<li data-target="#topHostCarousel" data-slide-to="0" class="active"></li>
							<li data-target="#topHostCarousel" data-slide-to="1"></li>
							<li data-target="#topHostCarousel" data-slide-to="2"></li>
							<li data-target="#topHostCarousel" data-slide-to="3"></li>
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
													<th>Disk</th>
													<th>Network</th>
												</tr>
											</thead>
											<tbody id="hostRankingCPUTop5">
												<tr>
													<td class="text-center" colspan="5">데이터가 없습니다.</td>
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
													<th>Disk</th>
													<th>Network</th>
												</tr>
											</thead>
											<tbody id="hostRankingMemoryTop5">
												<tr>
													<td class="text-center" colspan="5">데이터가 없습니다.</td>
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
													<th>Disk</th>
													<th>Network</th>
												</tr>
											</thead>
											<tbody id="hostRankingDiskTop5">
												<tr>
													<td class="text-center" colspan="5">데이터가 없습니다.</td>
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
													<th>Disk</th>
													<th>Network</th>
												</tr>
											</thead>
											<tbody id="hostRankingNetworkTop5">
												<tr>
													<td class="text-center" colspan="5">데이터가 없습니다.</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="carousel-nav">
							<a class="carousel-control-prev" href="#topHostCarousel" role="button" data-slide="prev"><i class="icon-2x icon-arrow-left12" ></i></a>
							<a class="carousel-control-next" href="#topHostCarousel" role="button" data-slide="next"><i class="icon-2x icon-arrow-right13"></i></a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xl-4">
				<div class="card bg-dark">
					<div class="card-header header-elements-inline">
						<h6 class="card-title cpointer" onclick="location.href='approvalManage.do'">
							<i class="icon-bell2"></i>승인 신청 현황
						</h6>
					</div>
					<div class="card-body card-logbody">
						<table class="status-table">
							<tbody id="dataEmptyCheck">
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-xl-4">
				<div class="card bg-dark">
					<div class="card-header header-elements-inline">
						<h6 class="card-title cpointer" onclick="location.href='/menu/monitoring.do#3'">
							<i class="icon-alarm"></i>데이터센터 알람
						</h6>
					</div>
					<div class="card-body card-logbody">
						<ul class="article-list mb-0" id="dashVcenterAlert"></ul>
					</div>
				</div>
			</div>
			<div class="col-xl-4">
				<div class="card bg-dark ">
					<div class="card-header header-elements-inline">
						<h6 class="card-title">
							<i class=icon-file-text3></i>최신 이력 현황
						</h6>
					</div>
					<div class="card-body card-logbody">
						<table class="status-table">
							<tbody id="DashLog">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	
		<script type="text/javascript">
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
	
			var optionsCloud = {
				type: 'line',
				data: {
					labels: [],
					datasets: [{
						label: "배치 가상머신 수",
						data: [],
						borderColor: "#fff",
						borderWidth: 2,
						backgroundColor: "transparent",
	
						pointRadius: 2,
						pointBackgroundColor: "#fff",
	
						pointHoverBorderColor: "#293243",
						pointHoverBackgroundColor: "#dbdbdb",
						pointHoverBorderWidth: 4,
						pointHoverRadius: 6,
						pointHitRadius: 16,
						lineTension: 0
					}, {
						label: "미배치 가상머신 수",
						data: [],
						borderColor: "#a1a1a1",
						borderWidth: 2,
						backgroundColor: "transparent",
	
						pointRadius: 2,
						pointBackgroundColor: "#a1a1a1",
	
						pointHoverBorderColor: "#293243",
						pointHoverBackgroundColor: "#dbdbdb",
						pointHoverBorderWidth: 4,
						pointHoverRadius: 6,
						pointHitRadius: 16,
						lineTension: 0
					}, {
						label: "전체 가상머신 수",
						data: [],
						borderColor: "#009fe8",
						borderWidth: 2,
						backgroundColor: "transparent",
	
						pointRadius: 2,
						pointBackgroundColor: "#009fe8",
	
						pointHoverBorderColor: "#293243",
						pointHoverBackgroundColor: "#dbdbdb",
						pointHoverBorderWidth: 4,
						pointHoverRadius: 6,
						pointHitRadius: 16,
						lineTension: 0
					}]
				},
				options: {
					maintainAspectRatio: false,
					tooltips: {
						titleFontStyle: "bold",
						titleFontColor: '#000',
						backgroundColor: '#fff',
						bodyFontColor: '#000',
						caretSize: 5,
						cornerRadius: 2,
						mode: "nearest",
						intersect: 0,
						position: "nearest",
					},
					legend: {
						display: false
					},
					scales: {
						xAxes: [{
							gridLines: {
								display: false
							}
						}],
						yAxes: [{
							gridLines: {
								display: false,
								drawBorder: false
							}
						}]
					}
				}
			}
	
			var ctxHost = document.getElementById('hostChart').getContext('2d');
			var hostdoughnutChart = new Chart(ctxHost, optionsHost);
	
			var ctxVM = document.getElementById('vmChart').getContext('2d');
			var vmdoughnutChart = new Chart(ctxVM, optionsVM);
	
			var ctxDatastore = document.getElementById('datastoreChart').getContext('2d');
			var datastoredoughnutChart = new Chart(ctxDatastore, optionsDatastore);
	
			var ctxCloud = document.getElementById("cloudChart").getContext("2d");
			var cloudlineChart = new Chart(ctxCloud, optionsCloud);
	
			function graphRealTime() {
				var result;
				$.ajax({
					url: "/jquery/getServiceRealTimeTotalCnt.do",
					async: false,
					success: function(data) {
						result = data;
					}
				})
				return result;
			}
	
			function DashServiceGraph() {
				var currentTime = new Date();
				$.ajax({
					url: "DashServiceGraph.do",
					success: function(Service) {
						Service.reverse();
	
						for (key in Service) {
							optionsCloud.data.labels[key] = Service[key].dServiceDatetime;
							optionsCloud.data.datasets[0].data[key] = Service[key].nServiceCount;
							optionsCloud.data.datasets[1].data[key] = Service[key].nFreeVMCount;
							optionsCloud.data.datasets[2].data[key] = Service[key].nVMCount;
						}
						var serviceRealTimeCnt = graphRealTime();
	
						optionsCloud.data.labels[Service.length] = currentTime.getFullYear() + "-" + leadingZeros(currentTime.getMonth() + 1, 2) + "-" + leadingZeros(currentTime.getDate(), 2);
						optionsCloud.data.datasets[0].data[Service.length] = serviceRealTimeCnt['nServiceCount'];
						optionsCloud.data.datasets[1].data[Service.length] = serviceRealTimeCnt['nFreeVMCount'];
						optionsCloud.data.datasets[2].data[Service.length] = serviceRealTimeCnt['nVMCount'];
	
						cloudlineChart.update();
	
						setTimeout(function() {
							DashServiceGraph();
						}, 21600000);
					}
				})
			}
	
			$(document).ready(function() {
				dashboardReflash();
				dashVcenterAlert();
				Dashboard_Storage();
				VMPower_status();
				DashServiceGraph();
				DashServiceNotApplyList();
				DashLog();
				Host_status();
				vmRanking('cpu');
				vmRanking('memory');
				vmRanking('disk');
				vmRanking('network');
				hostRanking('cpu');
				hostRanking('memory');
				hostRanking('disk');
				hostRanking('network');
			});
	
			function dashboardReflash() {
				var targetName = 'reflashInterval';
				console.log($('meta[http-equiv="Refresh"]').attr('content'));
	
				$.ajax({
	
					url: "/config/selectBasic.do",
					data: {
						targetName: targetName
					},
					success: function(data) {
						if (data == null || data == '') {
							var reflashUpdate = $('meta[http-equiv="Refresh"]').attr('content', 20);
						} else {
							var reflashUpdate = $('meta[http-equiv="Refresh"]').attr('content', data.value);
							console.log($('meta[http-equiv="Refresh"]').attr('content'));
						}
					}
				})
	
			}
	
			function dashVcenterAlert() {
	
				$.ajax({
					url: "dashVcenterAlert.do",
					success: function(data) {
						var html = '';
	
						for (key in data) {
							html += '<li>';
							if (data[key].sAlert_color == 'red') {
								html += '<p class="mb-0"><span class="title-log"><i class="icon-spam text-danger"></i>' + data[key].sTarget + '&nbsp' + data[key].sVc_Message + '</span><span class="text-muted log-date">' + data[key].dAlert_time + '</span></p>';
							} else if (data[key].sAlert_color == 'yellow') {
								html += '<p class="mb-0"><span class="title-log"><i class="icon-warning22 text-warning"></i>' + data[key].sTarget + '&nbsp' + data[key].sVc_Message + '</span><span class="text-muted log-date">' + data[key].dAlert_time + '</span></p>';
							}
							html += '</li>';
						}
						$('#dashVcenterAlert').empty();
						$('#dashVcenterAlert').append(html);
					}
				})
			}
	
			function DashLog() {
				$.ajax({
					url: "DashLog.do",
					data: {
						sUserID: '${sessionScope.loginUser.sUserID}'
					},
					success: function(logs) {
						var html = '';
	
						if (logs == null || logs == '') {
							html += '<tr><td colspan="3"><h6 class="text-center mb-0">최신 이력이 없습니다.</h6></td>';
						}
	
						for (key in logs) {
							html += '<tr>';
							html += '<td width="27%">';
	
							if (logs[key].no_sTarget == '관리자' && logs[key].no_sKeyword == 'Login' || logs[key].no_sKeyword == 'Logout') {
								html += '<i class="icon-user-tie"></i>접속<a href="/menu/connectHistory.do#2"><span class="badge bg-blue-600 badge-pill ml-2">상세 보기</span></a>';
	
							} else if (logs[key].no_sTarget != '관리자' && logs[key].no_sKeyword == 'Login' || logs[key].no_sKeyword == 'Logout') {
								html += '<i class="icon-user"></i>접속<a href="/menu/connectHistory.do#1"><span class="badge bg-blue-600 badge-pill ml-2">상세 보기</span></a>';
	
							} else if (logs[key].no_sKeyword == 'Create' || logs[key].no_sKeyword == 'Delete' || logs[key].no_sKeyword == 'Update' || logs[key].no_sKeyword == 'Mapping') {
								html += '<i class="icon-compose"></i>작업<a href="/menu/workHistory.do#1"><span class="badge bg-blue-600 badge-pill ml-2">상세 보기</span></a>';
	
							} else if (logs[key].no_sKeyword == 'Approval' || logs[key].no_sKeyword == 'Request' || logs[key].no_sKeyword == 'Return' || logs[key].no_sKeyword == 'Hold') {
								html += '<i class="icon-bell2"></i>승인 신청<a href="/menu/workHistory.do#3"><span class="badge bg-blue-600 badge-pill ml-2">상세 보기</span></a>';
							}
	
							html += '</td>';
							html += '<td width="42%">' + logs[key].no_sContext + '</span></td>';
							html += '<td width="30%" class="text-right"><span class="text-muted">' + logs[key].no_sSendDay + '</span></td>';
	
							html += '</tr>';
						}
						$("#DashLog").empty();
						$("#DashLog").append(html);
					},
				})
			}
	
			function hostRanking(target) {
				var orderKey = target;
				$.ajax({
	
					url: "/jquery/hostRanking.do",
					data: {
						orderKey: orderKey
					},
					success: function(data) {
						var html = '';
	
						for (key in data) {
	
							var disk_KBtoMB = Math.floor(data[key].disk / 1024);
							var network_KBtoMB = Math.floor(data[key].network / 1024);
	
							html += '<tr>';
							
							html += '<td>' + data[key].name + '</td>';
	
							if (data[key].cpu > 90) {
								html += '<td class="text-danger">' + data[key].cpu + '%</td>';
	
							} else if (data[key].cpu > 80) {
								html += '<td class="text-warning">' + data[key].cpu + '%</td>';
	
							} else if (data[key].cpu > 70) {
								html += '<td class="text-orange-400">' + data[key].cpu + '%</td>';
	
							} else {
								html += '<td>' + data[key].cpu + '%</td>';
							}
	
							if (data[key].memory > 90) {
								html += '<td class="text-danger">' + data[key].memory + '%</td>';
	
							} else if (data[key].memory > 80) {
								html += '<td class="text-warning">' + data[key].memory + '%</td>';
	
							} else if (data[key].memory > 70) {
								html += '<td class="text-orange-400">' + data[key].memory + '%</td>';
	
							} else {
								html += '<td>' + data[key].memory + '%</td>';
							}
	
							if (disk_KBtoMB > 0) {
								html += '<td>' + disk_KBtoMB + 'MB</td>';
	
							} else {
								html += '<td>' + data[key].disk + 'KB</td>';
							}
	
							if (network_KBtoMB > 0) {
								html += '<td>' + network_KBtoMB + 'MB</td>';
							} else {
								html += '<td>' + data[key].network + 'KB</td>';
							}
							html += '</tr>';
						}
	
						$("#hostUseTime").empty();
						$("#hostUseTime").append(data[0].timeString);
						if (target == 'cpu') {
							$("#hostRankingCPUTop5").empty();
							$("#hostRankingCPUTop5").append(html);
						} else if (target == 'memory') {
							$("#hostRankingMemoryTop5").empty();
							$("#hostRankingMemoryTop5").append(html);
						} else if (target == 'disk') {
							$("#hostRankingDiskTop5").empty();
							$("#hostRankingDiskTop5").append(html);
						} else if (target == 'network') {
							$("#hostRankingNetworkTop5").empty();
							$("#hostRankingNetworkTop5").append(html);
						}
					},
					error: function() {
						alert("host error");
					}
				})
			}
	
			function vmRanking(target) {
				var orderKey = target;
	
				$.ajax({
	
					url: "/jquery/vmRanking.do",
					data: {
						orderKey: orderKey
					},
					success: function(data) {
						var html = '';
	
						for (key in data) {
							var disk_KBtoMB = Math.floor(data[key].disk / 1024);
							var network_KBtoMB = Math.floor(data[key].network / 1024);
	
							html += '<tr>';
	
							html += '<td>' + data[key].name + '</td>';
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
	
							if (disk_KBtoMB > 0) {
								html += '<td>' + disk_KBtoMB + 'MB</td>';
	
							} else {
								html += '<td>' + data[key].disk + 'KB</td>';
							}
	
							if (network_KBtoMB > 0) {
								html += '<td>' + network_KBtoMB + 'MB</td>';
							} else {
								html += '<td>' + data[key].network + 'KB</td>';
							}
							html += '</tr>';
						}
	
						$("#vmUseTime").empty();
						$("#vmUseTime").append(data[0].timeString);
						if (target == 'cpu') {
							$("#vmRankingCPUTop5").empty();
							$("#vmRankingCPUTop5").append(html);
						} else if (target == 'memory') {
							$("#vmRankingMemoryTop5").empty();
							$("#vmRankingMemoryTop5").append(html);
						} else if (target == 'disk') {
							$("#vmRankingDiskTop5").empty();
							$("#vmRankingDiskTop5").append(html);
						} else if (target == 'network') {
							$("#vmRankingNetworkTop5").empty();
							$("#vmRankingNetworkTop5").append(html);
						}
	
					},
					error: function() {
						alert("vmRanking error");
					}
				})
			}
	
			function DashServiceNotApplyList() {
	
				$.ajax({
					url: "/menu/NotApplyList.do",
					success: function(NotAPPVMCR) {
						var html = '';
						if (NotAPPVMCR == null || NotAPPVMCR == '') {
							html += '<tr><td colspan="3"><h6 class="text-center mb-0">승인 신청이 없습니다.</h6></td>';
	
						} else {
							for (key in NotAPPVMCR) {
								html += '<tr>';
	
	
								html += '<td width="43%">';
	
								if (NotAPPVMCR[key].cr_sorting == 1) {
									html += '<i class="icon-cube4"></i>가상머신 생성<a href="/menu/approvalManage.do#1"><span class="badge bg-blue-600 badge-pill ml-2">상세 보기</span></a>';
	
								} else if (NotAPPVMCR[key].cr_sorting == 2) {
									html += '<i class="icon-clipboard3"></i>가상머신 자원 변경<a href="/menu/approvalManage.do#2"><span class="badge bg-blue-600 badge-pill ml-2">상세 보기</span></a>';
	
								} else if (NotAPPVMCR[key].cr_sorting == 3) {
									html += '<i class="icon-user"></i>가상머신 반환<a href="/menu/approvalManage.do#3"><span class="badge bg-blue-600 badge-pill ml-2">상세 보기</span></a>';
	
								} else {
									html += '<i class="icon-unlocked"></i>비밀번호 변경<a href="/menu/approvalManage.do#4"><span class="badge bg-blue-600 badge-pill ml-2">상세 보기</span></a>';
								}
	
								html += '</td>';
								html += '<td width="27%">' + NotAPPVMCR[key].userName + " (" + NotAPPVMCR[key].cr_sUserID + ")" + '</td>';
								html += '<td width="30%" class="text-right"><span class="text-muted">' + NotAPPVMCR[key].cr_datetime + '</span></td>';
								html += '</tr>';
							}
						}
						$("#dataEmptyCheck").empty();
						$("#dataEmptyCheck").append(html);
					},
				})
			}
	
			function Host_status() {
	
				$.ajax({
	
					url: "Host_Status.do",
					success: function(Host) {
	
						var html = "";
						var hostDisconnected = "";
						var hostAggregate = "";
	
						html += '<div class="font-size-base text-center"><b>TOTAL :</b></div>';
						html += '<div class="text-center"><span class="text-blue">' + Host["powerOn"] + '</span> / ' + Host["allCtn"] + '<span class="unit-text"> Hosts</span></div>';
	
						$("#totalHost").empty();
						$("#totalHost").append(html);
	
						optionsHost.data.datasets[0].data = [];
	
						optionsHost.data.datasets[0].data[0] = Host["powerOn"];
						optionsHost.data.datasets[0].data[1] = Host["powerOff"];
	
						hostdoughnutChart.update();
					},
					error: function() {
						alert("통신 에러 : 연결 상태를 확인해주십시오.");
					}
				})
			}
	
			function VMPower_status() {
	
				$.ajax({
					url: "Mvm_Status.do",
					success: function(VMPower) {
						var html = "";
						var vmSumCnt = 0;
						var PowerOn = '';
						var PowerOff = '';
						var Powertemplate = '';
						var vmTotalCnt = '';
	
						vmSumCnt = parseInt(VMPower["vmPowerOn"]) + parseInt(VMPower["vmPowerOff"]);
	
						html += '<div class="font-size-base text-center"><b>TOTAL :</b></div>';
						html += '<div class="text-center"><span class="text-blue">' + VMPower["vmPowerOn"] + '</span> / ' + vmSumCnt + '<span class="unit-text"> VMs</span></div>';
	
						$("#totalVM").empty();
						$("#totalVM").append(html);
	
						optionsVM.data.datasets[0].data = [];
	
						optionsVM.data.datasets[0].data[0] = VMPower["vmPowerOn"];
						optionsVM.data.datasets[0].data[1] = VMPower["vmPowerOff"];
	
						vmdoughnutChart.update();
					},
				})
			}
	
			function Dashboard_Storage() {
	
				$.ajax({
					url: "Mallstorage_list.do",
					success: function(storage) {
						var All = 0;
						var Use = 0;
						var Ration = 0;
						var TB = 1024;
						var StRation = '';
						var StUse = '';
						var StAll = '';
	
						html = "";
						for (key in storage) {
							All += storage[key].st_Allca / TB
							Use += storage[key].st_Useca / TB
							Ration += storage[key].st_space / TB
						}
	
						html += '<div class="font-size-base text-center"><b>TOTAL :</b></div>';
						html += '<div class="text-center"><span class="text-blue">' + Use.toFixed(1) + '</span> / ' + All.toFixed(1) + '<span class="unit-text"> TB</span></div>';
	
						$("#totalDatastore").empty();
						$("#totalDatastore").append(html);
	
						optionsDatastore.data.datasets[0].data = [];
	
						optionsDatastore.data.datasets[0].data[0] = Use.toFixed(1);
						optionsDatastore.data.datasets[0].data[1] = Ration.toFixed(1);
	
						datastoredoughnutChart.update();
					},
				})
			}
		</script>
	</body>
</html>