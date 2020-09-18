<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>

	<link href="${path}/resource/css/dashboard.css" rel="stylesheet" type="text/css">

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
				<div class="card-header">서비스 그룹 통합 현황</div>
				<div class="card-body">
					<div class="row">
						<div class="col-xl-4 col-sm-12 widget-6">
							<div class="row title-widget"><i class="fab fa-buffer"></i>서비스 그룹</div>
							<div class="row content-widget">
								<div class="col-6">서비스 그룹<div class="d-flex align-items-end">
										<h4 id="tenantCount"></h4>개
									</div>
								</div>
								<div class="col-6">서비스<div class="d-flex align-items-end">
										<h4 id="serviceCount"></h4>개
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-4 col-sm-12 widget-6">
							<div class="row title-widget"><i class="fas fa-cube"></i>가상머신</div>
							<div class="row content-widget">
								<div class="col-6"><span>운영 중인 가상머신</span>
									<div class="d-flex align-items-end">
										<h4 id="vmOnCount"></h4><span>VMs</span>
									</div>
								</div>
								<div class="col-6"><span>전원이 꺼진 가상머신</span>
									<div class="d-flex align-items-end">
										<h4 id="vmOffCount"></h4><span>VMs</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-4 col-sm-12 widget-6">
							<div class="row title-widget"><i class="fas fa-cube"></i>가상머신 할당 현황</div>
							<div class="row content-widget">
								<div class="col-6"><span>CPU</span>
									<div class="d-flex align-items-end">
										<h4 id="cpuTotal"></h4><span>EA</span>
									</div>
								</div>
								<div class="col-6"><span>memory</span>
									<div class="d-flex align-items-end">
										<h4 id="memoryTotal"></h4><span>GB</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="card section-card">
				<div class="card-header">서비스별 현황<span id="serviceGroupName"></span></div>
				<div class="card-body">
					<ul class="nav nav-tabs" id="serviceTab">
						<li class="nav-item"><a href="#" class="nav-link" data-toggle="tab"><span class="spinner-border spinner-border-sm mr-2" role="status"></span>서비스 그룹 로딩 중...</a></li>
					</ul>
					<div class="row">
						<div class="loading-background d-none" id="serviceTab_loading">
							<div class="spinner-border" role="status"></div>
						</div>
						<div class="col-xl-9 rows-card">
							<div class="row">
								<div class="col-12 widget-3">
									<div class="row">
										<div class="col-xl-6 col-sm-12">
											<div class="card">
												<div class="card-header"><i class="fas fa-chart-bar"></i>CPU TOP 5</div>
												<div class="card-body">
													<div id="cpuRank"></div>
													<div class="chartTime text-right usageTime">0000-00-00 00:00:00</div>
												</div>
											</div>
										</div>
										<div class="col-xl-6 col-sm-12">
											<div class="card">
												<div class="card-header"><i class="fas fa-chart-bar"></i>Memory TOP 5</div>
												<div class="card-body">
													<div id="memoryRank"></div>
													<div class="chartTime text-right usageTime">0000-00-00 00:00:00</div>
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
												<div class="card-header"><i class="fas fa-chart-bar"></i>Disk TOP 5</div>
												<div class="card-body">
													<div id="diskRank"></div>
													<div class="chartTime text-right usageTime">0000-00-00 00:00:00</div>
												</div>
											</div>
										</div>
										<div class="col-xl-6 col-sm-12">
											<div class="card">
												<div class="card-header"><i class="fas fa-chart-bar"></i>Network TOP 5</div>
												<div class="card-body">
													<div id="networkRank"></div>
													<div class="chartTime text-right usageTime">0000-00-00 00:00:00</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 widget-4">
							<div class="card">
								<div class="card-header"><i class="fas fa-chart-pie"></i>서비스 현황</div>
								<div class="card-body">
									<div><div><span>가상머신</span><div id="vmStatus"><h6 id="serviceStatus_vmCount"></h6>VMs</div></div></div>
									<div><div><span>CPU</span><div id="cpuStatus"><h6><b id="serviceStatus_cpu"></b></h6>EA</div></div></div>
									<div><div><span>Memory</span><div id="memoryStatus"><h6><b id="serviceStatus_memory"></b></h6>GB</div></div></div>
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
			
			getUserTenantStatistics();
			getServiceList();
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

		// 사용자가 속한 서비스 그룹의 통계 얻기
		function getUserTenantStatistics() {
			$.ajax({
				url: '/dash/selectUserTenantStatus.do',
				type: 'POST',
				success: function(data) {
					$('#tenantCount').text(data.tenantCount);
					$('#serviceCount').text(data.serviceCount);
					$('#vmOnCount').text(data.vmOnCount);
					$('#vmOffCount').text(data.vmOffCount);
					$('#cpuTotal').text(data.cpuTotal);
					$('#memoryTotal').text(data.memoryTotal);
				}
			})
		}

		// 서비스 리스트 탭
		function getServiceList() {
			$.ajax({
				url: '/tenant/selectVMServiceListByTenantId.do',
				type: 'POST',
				data: {
					isUserTenantMapping: 'true'
				},
				beforeSend: function() {
					$('#serviceTab_loading').removeClass('d-none');
				},
				complete: function() {
					$('#serviceTab_loading').addClass('d-none');
				},
				success: function(data) {
					var html = '';

					// 데이터가 없을 때
					if (data == null || data == '') {
						html += '<li class="nav-item"><a href="#" class="nav-link" data-toggle="tab">서비스가 없습니다.</a></li>';
						$('#serviceTab').empty().append(html);

						// 데이터가 있을 때
					} else {

						for (key in data) {
							html += '<li class="nav-item"><a href="#item' + key + '" class="nav-link" data-toggle="tab" id="' + data[key].vmServiceID+ '" serviceGroupName="' + data[key].tenantName  + '" >' + data[key].vmServiceName + '</a></li>';
						}

						$('#serviceTab').empty().append(html);

						// 스크롤링 탭 설정
						$('#serviceTab').scrollingTabs().scrollingTabs('refresh');

						// 탭을 선택할 때 마다 실행
						$('#serviceTab li a').off('shown.bs.tab').on('shown.bs.tab', function() {
							$('#serviceTab_loading').removeClass('d-none');

							var serviceGroupName = $(this).attr('serviceGroupName');
							$('#serviceGroupName').html('서비스 그룹 - ' + serviceGroupName);
							
							var serviceId = $(this).attr('id');
							
							// 선택된 클러스터의 데이터 조회
							serviceData(serviceId);
							
							// 현재 활성화된 탭 아이디를 localStorage에 저장
							localStorage.setItem(sessionUserId + 'ActiveTab', serviceId);
						});

						// 서비스 리스트 탭 기능
						serviceTabOptions();
					}
				}
			})
		}

		// CPU TOP 5
		var cpuChart = echarts.init($('#cpuRank')[0]);
		var cpuOption = {
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
					html += '</div>';
					html += '</div>';

					return html;
				}
			},
			// 그리드 설정
			grid: {
				top: '2',
				left: '2',
				right: '2',
				bottom: '2',
				containLabel: true
			},
			// x축 설정 (cpu/memory 값)
			xAxis: {
				type: 'value',
				min: 0,
				max: 100,
				splitNumber: 10,
				axisTick: {
					show: false
				},
				axisLine: {
					lineStyle: {
						color: '#E0E0E0'
					}
				},
				axisLabel: {
					color: '#212121',
					align: 'right',
					fontSize: 10
				},
				splitLine: {
					lineStyle: {
						color: '#E0E0E0'
					}
				}
			},
			// y축 설정 (가상머신 이름)
			yAxis: {
				type: 'category',
				axisTick: {
					show: false
				},
				axisLine: {
					lineStyle: {
						color: '#E0E0E0'
					}
				},
				axisLabel: {
					color: '#212121',
					fontSize: 10
				},
				data: []
			},
			// cpu/memory 타입 bar 설정
			series: [{
				name: 'CPU',
				type: 'bar',
				barWidth: '14',
				itemStyle: {
					color: '#F7B046'
				},
				data: []
			}]
		}

		// Memory TOP 5
		var memoryChart = echarts.init($('#memoryRank')[0]);
		var memoryOption = {
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
					html += '</div>';
					html += '</div>';

					return html;
				}
			},
			// 그리드 설정
			grid: {
				top: '2',
				left: '2',
				right: '2',
				bottom: '2',
				containLabel: true
			},
			// x축 설정 (cpu/memory 값)
			xAxis: {
				type: 'value',
				min: 0,
				max: 100,
				splitNumber: 10,
				axisTick: {
					show: false
				},
				axisLine: {
					lineStyle: {
						color: '#E0E0E0'
					}
				},
				axisLabel: {
					color: '#212121',
					align: 'right',
					fontSize: 10
				},
				splitLine: {
					lineStyle: {
						color: '#E0E0E0'
					}
				}
			},
			// y축 설정 (가상머신 이름)
			yAxis: {
				type: 'category',
				axisTick: {
					show: false
				},
				axisLine: {
					lineStyle: {
						color: '#E0E0E0'
					}
				},
				axisLabel: {
					color: '#212121',
					fontSize: 10
				},
				data: []
			},
			// cpu/memory 타입 bar 설정
			series: [{
				name: 'Memory',
				type: 'bar',
				barWidth: '14',
				itemStyle: {
					color: '#F7B046'
				},
				data: []
			}]
		}

		// Disk TOP 5
		var diskChart = echarts.init($('#diskRank')[0]);
		var diskOption = {
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
					html += '<div>' + params[0].marker + params[0].seriesName + ' : ' + params[0].value + ' KB</div>';
					html += '</div>';
					html += '</div>';

					return html;
				}
			},
			// 그리드 설정
			grid: {
				top: '2',
				left: '2',
				right: '2',
				bottom: '2',
				containLabel: true
			},
			// x축 설정 (cpu/memory 값)
			xAxis: {
				type: 'value',
				min: 0,
				splitNumber: 10,
				axisTick: {
					show: false
				},
				axisLine: {
					lineStyle: {
						color: '#E0E0E0'
					}
				},
				axisLabel: {
					color: '#212121',
					align: 'right',
					fontSize: 10
				},
				splitLine: {
					lineStyle: {
						color: '#E0E0E0'
					}
				}
			},
			// y축 설정 (가상머신 이름)
			yAxis: {
				type: 'category',
				axisTick: {
					show: false
				},
				axisLine: {
					lineStyle: {
						color: '#E0E0E0'
					}
				},
				axisLabel: {
					color: '#212121',
					fontSize: 10
				},
				data: []
			},
			// cpu/memory 타입 bar 설정
			series: [{
				name: 'Disk',
				type: 'bar',
				barWidth: '14',
				itemStyle: {
					color: '#F7B046'
				},
				data: []
			}]
		}

		// Network TOP 5
		var networkChart = echarts.init($('#networkRank')[0]);
		var networkOption = {
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
					html += '<div>' + params[0].marker + params[0].seriesName + ' : ' + params[0].value + ' KB</div>';
					html += '</div>';
					html += '</div>';

					return html;
				}
			},
			// 그리드 설정
			grid: {
				top: '2',
				left: '2',
				right: '2',
				bottom: '2',
				containLabel: true
			},
			// x축 설정 (cpu/memory 값)
			xAxis: {
				type: 'value',
				min: 0,
				splitNumber: 10,
				axisTick: {
					show: false
				},
				axisLine: {
					lineStyle: {
						color: '#E0E0E0'
					}
				},
				axisLabel: {
					color: '#212121',
					align: 'right',
					fontSize: 10
				},
				splitLine: {
					lineStyle: {
						color: '#E0E0E0'
					}
				}
			},
			// y축 설정 (가상머신 이름)
			yAxis: {
				type: 'category',
				axisTick: {
					show: false
				},
				axisLine: {
					lineStyle: {
						color: '#E0E0E0'
					}
				},
				axisLabel: {
					color: '#212121',
					fontSize: 10
				},
				data: []
			},
			// cpu/memory 타입 bar 설정
			series: [{
				name: 'Network',
				type: 'bar',
				barWidth: '14',
				itemStyle: {
					color: '#F7B046'
				},
				data: []
			}]
		}

		// 가상머신 TOP 5
		function serviceData(serviceId) {
			$.ajax({
				url: '/dash/selectServiceStatus.do',
				type: 'POST',
				data: {
					serviceId: serviceId
				},
				success: function(data) {
					
					var usageTime = "";
					
					// 초기화
					for(var i=0; i<5; i++) {
						cpuOption.yAxis.data[i] = "";
						cpuOption.series[0].data[i] = 0;
						memoryOption.yAxis.data[i] = "";
						memoryOption.series[0].data[i] = 0;
						diskOption.yAxis.data[i] = "";
						diskOption.series[0].data[i] = 0;
						networkOption.yAxis.data[i] = "";
						networkOption.series[0].data[i] = 0;
					}
					
					// 데이터 없을 때
					if (data == null || data == '') {
						
						cpuOption.series[0].data[0] = 0;
						memoryOption.series[0].data[0] = 0;
						diskOption.series[0].data[0] = 0;
						networkOption.series[0].data[0] = 0;
						
						usageTime = '데이터가 없습니다.';
						
					// 데이터 있을 때
					} else {
						// 서비스 현황 설정
						$('#serviceStatus_vmCount').html("<b>" + data.vmOnCount + "</b> / " + data.vmCount);
						$('#serviceStatus_cpu').text(data.cpuTotal);
						$('#serviceStatus_memory').text(data.memoryTotal);
						
						// cpu Top 5 
						if (data.cpuTop5List != null && data.cpuTop5List != '') {
							
							for (key in data.cpuTop5List) {
								cpuOption.yAxis.data[key] = data.cpuTop5List[key].vmName;
								cpuOption.series[0].data[key] = data.cpuTop5List[key].cpu;
							}
							
							// timestamp 날짜 형식 변환
							usageTime = dateTimeConverter(data.cpuTop5List[0].timestamp);
						}
						
						// memory Top 5 
						if (data.memoryTop5List != null && data.memoryTop5List != '') {

							for (key in data.cpuTop5List) {
								memoryOption.yAxis.data[key] = data.memoryTop5List[key].vmName;
								memoryOption.series[0].data[key] = data.memoryTop5List[key].memory;
							}
							
							// timestamp 날짜 형식 변환
							usageTime = dateTimeConverter(data.memoryTop5List[0].timestamp);
						}
						
						// disk Top 5 
						if (data.diskTop5List != null && data.diskTop5List != '') {
							for (key in data.cpuTop5List) {
								diskOption.yAxis.data[key] = data.diskTop5List[key].vmName;
								diskOption.series[0].data[key] = data.diskTop5List[key].disk;
							}
							
							// timestamp 날짜 형식 변환
							usageTime = dateTimeConverter(data.diskTop5List[0].timestamp);
						}
						
						// network Top 5 
						if (data.networkTop5List == null && data.networkTop5List != '') {
							for (key in data.cpuTop5List) {
								networkOption.yAxis.data[key] = data.networkTop5List[key].vmName;
								networkOption.series[0].data[key] = data.networkTop5List[key].network;
							}
							
							// timestamp 날짜 형식 변환
							usageTime = dateTimeConverter(data.networkTop5List[0].timestamp);
						}
						
					}
					cpuChart.setOption(cpuOption, true);
					memoryChart.setOption(memoryOption, true);
					diskChart.setOption(diskOption, true);
					networkChart.setOption(networkOption, true);
					
					cpuChart.resize();
					memoryChart.resize();
					diskChart.resize();
					networkChart.resize();
					
					$('.usageTime').html(usageTime);
					
					// 차트 크기 조정
					$(window).resize(function() {
						cpuChart.resize();
						memoryChart.resize();
						diskChart.resize();
						networkChart.resize();
					});
				}
			})
		}

		//모든 ajax 요청이 완료될 때
		$(document).ajaxStop(function() {
			$('#serviceTab_loading').addClass('d-none');
		});

		// 탭 기능
		function serviceTabOptions() {
			
			// 사용자 별로 활성화 탭 저장
			// 활성화된 탭이 없으면 첫번 째 탭 선택
			var userActiveTab = localStorage.getItem(sessionUserId + 'ActiveTab');
			userActiveTab ? $('#serviceTab li #' + userActiveTab).click() : $('#serviceTab li:first-child a').click();
			
			// 탭 자동 롤링
			var tabChange = function () {
				var serviceTab  = $('#serviceTab li');
				var activeTab = serviceTab.find('a.active');
				var activeTabParent = activeTab.parent('li');
				var activeTabKey = parseInt(activeTab.attr('href').replace('#item', '')) + 1;
				
				// 마지막 탭 선택 시 첫번 째 탭 선택
				var nextTab = serviceTab.length == activeTabKey ? $('#serviceTab li:first-child a') : activeTabParent.next('li').find('a');
				nextTab.click();
			}
			
			// 10초 마다 실행
			var tabCycle = setInterval(tabChange, 10000);
			
			// 도중에 다른 탭 선택 시 탭 사이클 재실행
			$('#serviceTab li a').click(function() {
				clearInterval(tabCycle);
				tabCycle = setInterval(tabChange, 10000);
			});
		}
	</script>
</body>

</html>