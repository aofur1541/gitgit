<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>
		
		<!-- 본문 시작 -->
		<div class="content">
		
			<!-- 필터 -->
			<div class="card Inquire-card">
				<div class="row">
					<div class="col-12 clusterOrServiceGroupDiv">
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" class="custom-control-input" id="byCluster" name="clusterOrServiceGroup">
							<label class="custom-control-label" for="byCluster">클러스터별</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" class="custom-control-input" id="byServiceGroup" name="clusterOrServiceGroup">
							<label class="custom-control-label" for="byServiceGroup">서비스 그룹별</label>
						</div>
					</div>
					<div class="col-xl-4 col-sm-6 clusterDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">클러스터</span></div>
							<select class="form-control" id="selectCluster"></select>
						</div>
					</div>
					<div class="col-xl-4 col-sm-6 clusterDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">호스트</span></div>
							<select class="form-control" id="selectHost"></select>
						</div>
					</div>
					<div class="col-xl-4 col-sm-6 serviceGroupDiv d-none">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">서비스 그룹</span></div>
							<select class="form-control" id="selectServiceGroup"></select>
						</div>
					</div>
					<div class="col-xl-4 col-sm-6 serviceGroupDiv d-none">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">서비스</span></div>
							<select class="form-control" id="selectService"></select>
						</div>
					</div>
					<div class="col-xl-4 col-sm-12">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">가상머신</span></div>
							<select class="form-control" id="selectVM"></select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xl-2 col-sm-12">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">보기 단위</span></div>
							<select class="form-control no-search" id="selectDateType">
								<option value="0">20초</option>
								<option value="1">5분</option>
								<option value="2" selected>30분</option>
								<option value="3">2시간</option>
								<option value="4">24시간</option>
							</select>
						</div>
					</div>
					<div class="col-xl-2 col-sm-6 startDateDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">일자</span></div>
							<input type="date" class="form-control" id="startDate">
						</div>
					</div>
					<div class="col-xl-2 col-sm-6 startTimeDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">시간</span></div>
							<input type="time" class="form-control" value="00:00" id="startTime">
						</div>
					</div>
					<div class="col-group tilde">~</div>
					<div class="col-xl-2 col-sm-6 endDateDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">일자</span></div>
							<input type="date" class="form-control" id="endDate">
						</div>
					</div>
					<div class="col-xl-2 col-sm-6 endTimeDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">시간</span></div>
							<input type="time" class="form-control" value="23:59" id="endTime">
						</div>
					</div>
					<div class="col-xl-1 col-sm-12">
						<button type="button" class="btn w-100 h-100" id="performanceFilterBtn">조회</button>
					</div>
				</div>
			</div>
			
			<!-- 가상머신 성능 차트  -->
			<div class="card customPerformance-card">
				<div class="card-body">
					<div class="loading-background card-loading"><div class="spinner-border" role="status"></div></div>
					<span class="empty-chart text-disabled d-none">현재 선택한 메트릭에 사용할 수 있는 성능 데이터가 없습니다.</span>
					<div class="chart d-none" id="vmPerformance"></div>
				</div>
			</div>
			
			<!-- 가상머신 성능 테이블 -->
			<table id="tableVMPerformance" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th id="name1">클러스터</th>
						<th id="name2">호스트</th>
						<th>가상머신</th>
						<th>vCPU</th>
						<th>Memory</th>
						<th>Disk</th>
						<th>Network</th>
						<th>일시</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		
	// 사용자가 매핑된 테넌트 사용 여부 
		var isUserTenantMapping = 'false';
	
		$(document).ready(function() {
			
			// 클러스터별/서비스 그룹별 radio 변경 시
			$('input[name="clusterOrServiceGroup"]').change(function () {
				$('#page_loading').removeClass('d-none');
				
				// 클러스터별 선택 시
				if ($('#byCluster').is(':checked')) {
					$('.clusterDiv').removeClass('d-none');
					$('.serviceGroupDiv').addClass('d-none');
					$('#performanceFilterBtn').attr('onclick', 'performanceFilter("clusterChoiceAll")');
					
					selectClusterList();
				}
				
				// 서비스 그룹별 선택 시
				if ($('#byServiceGroup').is(':checked')) {
					$('.clusterDiv').addClass('d-none');
					$('.serviceGroupDiv').removeClass('d-none');
					$('#performanceFilterBtn').attr('onclick', 'performanceFilter("tenantsChoiceAll")');
					
					sessionUserApproval > USER_CHECK ? selectServiceGroupList() : selectUserServiceGroupList();
				}
			});
			
			// 클러스터 select box 변경 시
			$('#selectCluster').change(function () {
				var clusterId = $('#selectCluster option:selected').val();
				selectHostList(clusterId);
			});
			
			// 서비스 그룹 select box 변경 시
			$('#selectServiceGroup').change(function () {
				var serviceGroupId = $('#selectServiceGroup option:selected').val();
				selectServiceList(serviceGroupId);
			});
			
			// 서비스 그룹 select box 변경 시
			$('#selectService').change(function () {
				var serviceGroupId = $('#selectServiceGroup option:selected').val();
				var serviceId = $('#selectService option:selected').val();
				getTenantVMList(serviceGroupId, serviceId);
			});
			
			// 단위 변경 시
			$('#selectDateType').change(function() {
				var dateType = $('#selectDateType option:selected').val();
				changeDateType(dateType);
			});
			
			$('#startDate').val(todayConverter('today'));
			$('#endDate').val(todayConverter('today'));
			
			// 처음 실행 시 관리자면 클러스터별 보기, 사용자면 서비스 그룹별 보기 실행
			// 사용자는 서비스 그룹별로만 볼 수 있음 (클러스터별/서비스 그룹별 radio 숨김)
			if (sessionUserApproval > USER_CHECK) {
				isUserTenantMapping = 'false';
				
				$('.clusterOrServiceGroupDiv').removeClass('d-none');
				$('#byCluster').click();
			
			} else {
				isUserTenantMapping = 'true';
				
				$('.clusterOrServiceGroupDiv').addClass('d-none');
				$('#byServiceGroup').click();
			}
		});
		
		var isFirstSearch = true;
		
		// 단위 변경 시 시간 숨김
		function changeDateType(dateType) {
			
			// 20초/5분/30분일 때 시간 선택 가능, 기본값 오늘 일자
			if (dateType == 0 || dateType == 1 || dateType == 2 ) {
				$('.startTimeDiv, .endTimeDiv').removeClass('d-none');
				
				$('#startDate').val(todayConverter('today'));
				$('#endDate').val(todayConverter('today'));
			}
			
			// 2시간일 때 시간 선택 숨김, 기본값 오늘 일자
			if (dateType == 3) {
				$('.startTimeDiv, .endTimeDiv').addClass('d-none');
				
				$('#startDate').val(todayConverter('today'));
				$('#endDate').val(todayConverter('today'));
			}
			
			// 24시간일 때 시간 선택 숨김, 기본값 어제 일자
			if (dateType == 4) {
				$('.startTimeDiv, .endTimeDiv').addClass('d-none');
				
				$('#startDate').val(todayConverter('date'));
				$('#endDate').val(todayConverter('date'));
			}
		}
		
		// 클러스터 목록
		function selectClusterList() {
			$.ajax({
				url: '/tenant/selectClusterList.do',
				type: 'POST',
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="0" selected disabled>클러스터가 없습니다.</option>';
					
					} else {
						html += '<option value="clusterAll" selected>전체</option>';
						for (key in data) {
							html += '<option value="' + data[key].clusterID + '">' + data[key].clusterName + '</option>';
						}
					}
					
					$('#selectCluster').empty().append(html);
					
					var clusterId = $('#selectCluster option:selected').val();
					selectHostList(clusterId);
				}
			})
		}
		
		// 호스트 목록
		function selectHostList(clusterId) {
			$.ajax({
				url: '/status/selectVMHostList.do',
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="0" selected disabled>호스트가 없습니니다.</option>';
					
					} else {
						html += '<option value="hostAll" selected>전체</option>';
						for (key in data) {
							html += '<option value="' + data[key].vmHID + '">' + data[key].vmHhostname + '</option>';
						}
					}
					
					$('#selectHost').empty().append(html);
					
					var hostId = $('#selectHost option:selected').val();
					getClusterVMList(clusterId, hostId);
				}
			})
		}
		
		// 클러스터별 가상머신 목록
		function getClusterVMList(clusterId, hostId) {
			$.ajax({
				url: '/apply/selectVMDataList.do',
				type: 'POST',
				data: {
					clusterId: clusterId,
					hostId: hostId
				},
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="0" selected disabled>가상머신이 없습니다.</option>';
					
					} else {
						html += '<option value="vmAll" value2="전체">전체</option>';
						for (key in data) {
							if (data[key].vmStatus == 'poweredOn') {
								html += '<option value="' + data[key].vmID + '" value2="' + data[key].vmName + '">' + data[key].vmName + ' (ON)</option>';
							
							} else if (data[key].vmStatus == 'poweredOff') {
								html += '<option value="' + data[key].vmID + '" value2="' + data[key].vmName + '">' + data[key].vmName + ' (OFF)</option>';
							}
						}
					}
					
					$('#selectVM').empty().append(html);
					
					if (isFirstSearch) {
						performanceFilter('clusterChoiceAll');
						isFirstSearch = false;
					}
				}
			})
		}
		
		// 서비스 그룹 목록
		function selectServiceGroupList() {
			$.ajax({
				url: '/tenant/selectTenantList.do',
				type: 'POST',
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="-2" selected disabled>서비스 그룹이 없습니다.</option>';
					
					} else {
						html += '<option value="" selected>전체</option>';
						for (key in data) {
								html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
						}
						html += '<option value="-1">미배치</option>';
					}
					
					$('#selectServiceGroup').empty().append(html);
					
					var serviceGroupId = $('#selectServiceGroup option:selected').val();
					selectServiceList(serviceGroupId);
				}
			})
		}

		// 사용자 서비스 그룹 목록
		function selectUserServiceGroupList() {
			$.ajax({
				url: '/tenant/selectLoginUserTenantList.do',
				type: 'POST',
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="-2" selected disabled>서비스 그룹이 없습니다.</option>';
					
					} else {
						html += '<option value="" selected>전체</option>';
						for (key in data) {
							html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
						}
					}
					
					$('#selectServiceGroup').empty().append(html);
					
					var serviceGroupId = $('#selectServiceGroup option:selected').val();
					selectServiceList(serviceGroupId);
				}
			})
		}

		// 서비스 목록
		function selectServiceList(serviceGroupId) {
			if (serviceGroupId == '-2') {
				var html =  '<option value="-2" selected disabled>서비스가 없습니다.</option>';
				
				$('#selectService').empty().append(html);
				getTenantVMList('-2', '-2');
			
			} else {
				$.ajax({
					url: '/tenant/selectVMServiceListByTenantId.do',
					type: 'POST',
					data: {
						tenantId: serviceGroupId,
						isUserTenantMapping: isUserTenantMapping
					},
					success: function(data) {
						var html = '';
						
						if (data == null || data == '') {
							html += '<option value="-2" selected disabled>서비스가 없습니다.</option>';
					
						} else if (serviceGroupId == -1) {
							html += '<option value="-1" selected disabled>미배치</option>';
							
						} else {
							html += '<option value="" selected>전체</option>';
							for (key in data) {
								html += '<option value="' + data[key].vmServiceID + '">' + data[key].vmServiceName + '</option>';
							}
						}
						
						$('#selectService').empty().append(html);
						
						var serviceId = $('#selectService option:selected').val();
						getTenantVMList(serviceGroupId, serviceId);
					}
				})
			}
		}
		
		// 서비스 그룹별 가상머신 목록
		function getTenantVMList(serviceGroupId, serviceId) {
			
			if (serviceGroupId == '-2' && serviceId == '-2') {
				var html =  '<option value="-1" value2="가상머신이 없습니다." selected disabled>가상머신이 없습니다.</option>';
				
				$('#selectVM').empty().append(html);
				
				if (isFirstSearch) {
					performanceFilter('tenantsChoiceAll');
					isFirstSearch = false;
				}
			
			} else {
				$.ajax({
					url: '/apply/selectVMDataList.do',
					type: 'POST',
					data: {
						tenantId: serviceGroupId,
						vmServiceID: serviceId,
						isUserTenantMapping: isUserTenantMapping
					},
					success: function(data) {
						var html = '';
						
						if (data == null || data == '') {
							html += '<option value="-1" selected disabled>가상머신이 없습니다.</option>';
							
						} else {
							html += '<option value="vmAll" value2="전체">전체</option>';
							for (key in data) {
								if (data[key].vmStatus == 'poweredOn') {
									html += '<option value="' + data[key].vmID + '" value2="' + data[key].vmName + '">' + data[key].vmName + ' (ON)</option>';
								
								} else if (data[key].vmStatus == 'poweredOff') {
									html += '<option value="' + data[key].vmID + '" value2="' + data[key].vmName + '">' + data[key].vmName + ' (OFF)</option>';
								}
							}
						}
						
						$('#selectVM').empty().append(html);
						
						if (isFirstSearch) {
							performanceFilter('tenantsChoiceAll');
							isFirstSearch = false;
						}
					}
				})
			}
		}
		
		// 가상머신 성능 차트
		function getVMPerformance(category, dateType, clusterId, hostId, serviceGroupId, serviceId, vmId, startDate, endDate, startTime, endTime) {
			$.ajax({
				url: '/performance/selectVMPerformanceTotalList.do',
				type: 'POST',
				data: {
					category: category,
					period: dateType,
					clusterId: clusterId,
					hostId: hostId,
					tenantId: serviceGroupId,
					serviceId: serviceId,
					vmID: vmId,
					startDate: startDate,
					endDate: endDate,
					startTime: startTime,
					endTime: endTime,
					isUserTenantMapping: isUserTenantMapping
				},
				beforeSend: function() {
					$('.card-loading').removeClass('d-none');
					
					$('.empty-chart').addClass('d-none');
					$('.chart').addClass('d-none');
				},
				complete: function() {
					$('.card-loading').addClass('d-none');
				},
				success : function(data) {
					
					// 데이터 없을 때
					if (data == null || data == '') {
						$('.empty-chart').removeClass('d-none');
						
					// 데이터 있을 때
					} else {
						$('.chart').removeClass('d-none');
						
						// 가상머신 성능 차트
						var chart = echarts.init($('#vmPerformance')[0]);
						var option = {
							tooltip: {
								trigger: 'axis',
								backgroundColor: 'transparent',
								formatter: function(params) {
									var html = '';
									
									html += '<div class="card card-tooltip">';
									html += '<div class="card-header">' + dateTimeConverter(Number(params[0].name)) + '</div>';
									html += '<div class="card-body">';
									for (key in params) {
										if (params[key].seriesName == 'CPU' || params[key].seriesName == 'Memory') {
											html += '<div>' + params[key].marker + params[key].seriesName + ' : ' + params[key].value+ ' %</div>';
										}
										
										if (params[key].seriesName == 'Disk' || params[key].seriesName == 'Network') {
											html += '<div>' + params[key].marker + params[key].seriesName + ' : ' + params[key].value+ ' KB</div>';
										}
									}
									html += '</div>';
									html += '</div>';
				
									return html;
								}
							},
							legend: {
								data: ['CPU', 'Memory', 'Disk', 'Network'],
								textStyle: {color: '#212121'},
								left: 'center',
								formatter: function(name) {
									if (name == 'CPU' || name == 'Memory') {return name + ' (%)';}
									if (name == 'Disk' || name == 'Network') {return name + ' (KB)';}
								}
							},
							// 그리드 설정
							grid: {top: '35', left: '0', right: '0', bottom: '35', containLabel: true},
							// x축 설정 (시간)
							xAxis: {
								type: 'category',
								axisTick: {show: false},
								axisLine: {show: false},
								axisLabel: {align: 'left', color: '#212121',
									formatter: function (value) {
										return performanceTime(value);
									}	
								},
								axisLine: {lineStyle: {color: '#E0E0E0'}},
								data: [],
							},
							// y축 설정 (좌측 % 단위, 우측 KB 단위)
							yAxis: [{
									type: 'value',
									min: 0,
									max: 100,
									axisLabel: {formatter: '{value} %', color: '#212121', verticalAlign: 'center'},
									axisTick: {show: false},
									axisLine: {show: false}
								}, {
									type: 'value',
									min: 0,
									axisLabel: {formatter: '{value} KB', color: '#212121', verticalAlign: 'center'},
									axisTick: {show: false},
									axisLine: {show: false},
									splitLine : {show: false}
							}],
							// data zoom 설정
							dataZoom: [{
									type: 'inside',
							        start: 0,
							        end: 100
								}, {
							        start: 0,
							        end: 100,
							        bottom: '0',
							        showDetail: false,
							        handleSize: '100%',
							        handleStyle: {color: 'transparent'},
							        dataBackground: {lineStyle:{color: '#44A1EF', width: 1, opacity: 1}, areaStyle: {color: 'transparent'}
						        },
						        fillerColor: 'rgba(68,161,239,0.25)',
						        borderColor: '#BDBDBD'
						    }],
						 	// line 차트 설정
							series: [
								{name: 'CPU', type: 'line', showSymbol: false, itemStyle: {color: '#F7B046'}, data: []}, 
								{name: 'Memory', type: 'line', showSymbol: false, itemStyle: {color: '#2484DE'}, data: []},
								{name: 'Disk', type: 'line', showSymbol: false, itemStyle: {color: '#95257F'}, yAxisIndex: 1, data: []}, 
								{name: 'Network', type: 'line', showSymbol: false, itemStyle: {color: '#52A06E'}, yAxisIndex: 1, data: []}
							]
						}
						
						for (key in data) {
							option.xAxis.data[key] = data[key].timestamp;
							
							option.series[0].data[key] = data[key].cpu;
							option.series[1].data[key] = data[key].memory;
							option.series[2].data[key] = data[key].disk;
							option.series[3].data[key] = data[key].network;
						}
						
						// 다크 모드 차트 컬러 변경
						updateVMPerformanceChartColor(option);

						$('#colorControl').on('click', function() {
							updateVMPerformanceChartColor(option);

							chart.setOption(option, true);
						});

						chart.setOption(option, true);
						chart.resize();
					}
					
					// 차트 크기 조정
					$(window).resize(function() {
						chart.resize();
					});
				}
			})
		}
		
		// 다크 모드 차트 컬러 변경
		function updateVMPerformanceChartColor(option) {
			var darkMode = localStorage.getItem(sessionUserId + '_darkMode');

			// 다크 모드 ON
			if (darkMode == 'ON') {
				option.legend.textStyle.color = '#EFEFEF';
				
				option.xAxis.axisLabel.color = '#9D9FA4';
				option.xAxis.axisLine.lineStyle.color = '#2F343D';
				
				
			
				option.dataZoom[1].borderColor = '#292D34';
				option.dataZoom[1].fillerColor = 'rgba(68,161,239,0.25)';
				option.dataZoom[1].dataBackground.lineStyle.color = '#44A1EF';

			// 다크 모드 OFF
			} else {
				option.legend.textStyle.color = '#212121';
				
				option.xAxis.axisLabel.color = '#212121';
				option.xAxis.axisLine.lineStyle.color = '#E0E0E0';
				
				
				option.yAxis.axisLabel.color = '#212121';
				option.yAxis.axisLine.lineStyle.color = '#E0E0E0';
		
				
				option.dataZoom[1].borderColor = '#BDBDBD';
				option.dataZoom[1].fillerColor = 'rgba(68,161,239,0.25)';
				option.dataZoom[1].dataBackground.lineStyle.color = '#44A1EF';
			}
		}
		
		// 가상머신 성능 테이블
		function getVMPerformanceList(category, dateType, clusterId, hostId, serviceGroupId, serviceId, clusterName, hostName, serviceGroupName, serviceName, vmId, vmName, startDate, endDate, startTime, endTime) {
			var tableVMPerformance = $('#tableVMPerformance').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/performance/selectVMPerformanceTotalList.do',
					type: 'POST',
					dataSrc: '',
					data: {
						category: category,
						period: dateType,
						clusterId: clusterId,
						hostId: hostId,
						tenantId: serviceGroupId,
						serviceId: serviceId,
						vmID: vmId,
						startDate: startDate,
						endDate: endDate,
						startTime: startTime,
						endTime: endTime,
						isUserTenantMapping: isUserTenantMapping
					}
				},
				columns: [
					{data: 'clusterName', render: function(data, type, row) {
						if (category == 'clusterChoiceAll') {
							data = clusterName == 'clusterAll' ? '전체' : clusterName;
						}
						
						if (category == 'tenantsChoiceAll') {
							data = serviceGroupName;
						}
						
						return data;
					}},
					{data: 'hostName', render: function(data, type, row) {
						if (category == 'clusterChoiceAll') {
							data = hostName == 'hostAll' ? '전체' : hostName;
						}
						
						if (category == 'tenantsChoiceAll') {
							data = serviceName;
						}
						
						return data;
					}},
					{data: 'vmName', render: function(data, type, row) {
						data = vmName;
						return data;
					}},
					{data: 'cpu', render: function(data, type, row) {
						data = data + ' %';
						return data;
					}},
					{data: 'memory', render: function(data, type, row) {
						data = data + ' %';
						return data;
					}},
					{data: 'disk', render: function(data, type, row) {
						data = data + ' KB';
						return data;
					}},
					{data: 'network', render: function(data, type, row) {
						data = data + ' KB';
						return data;
					}},
					{data: 'timestamp', render: function(data, type, row) {
						data = dateTimeConverter(data);
						return data;
					}}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				order: [[7, 'asc']],
				lengthMenu: [[5, 10, 25, 50, -1],	 ['5', '10', '25', '50', '전체']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '호스트 고급 성능'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '호스트 고급 성능'
					}]
				}, {
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}, {
					extend: 'colvis',
					text: '테이블 편집',
					className: 'btn colvisBtn'
				}]
			});
		}
		
		// 성능 차트 데이터 변환
		function performanceTime(value) {
			var date = new Date(Number(value));
			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var day = date.getDate();
			var hour = date.getHours();
			var min = date.getMinutes();
			var sec = date.getSeconds();
			
			var dateType = $('#selectDateType option:selected').val();
			
			// 20초 데이터(1시간) HH:mm:ss
			if (dateType == 0) {
				return (hour < 10 ? '0' + hour : hour) + ':' + (min < 10 ? '0' + min : min) + ':' + (sec < 10 ? '0' + sec : sec);
			}
			
			// 5분 데이터(1일) / 30분 데이터(7일) / 2시간 데이터(30일) MM-dd HH:mm
			if (dateType == 1 || dateType == 2 || dateType == 3) {
				return (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day) + ' ' + (hour < 10 ? '0' + hour : hour) + ':' + (min < 10 ? '0' + min : min);
			}
			
			// 24시간 데이터 (365일) yyyy-MM-dd
			if (dateType == 4) {
				return year + '-' + (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day);
			}
		}
		
		// 결과 조회
		function performanceFilter(category) {
			var vmId = $('#selectVM option:selected').val();
			var vmName = $('#selectVM option:selected').attr('value2');
			
			var dateType = $('#selectDateType option:selected').val();
			var startDate = $('#startDate').val();
			var endDate = $('#endDate').val();
			var startTime = $('#startTime').val();
			var endTime = $('#endTime').val();
			
			var serviceGroupId = $('#selectServiceGroup option:selected').val();
			var serviceId = $('#selectService option:selected').val();
			var serviceGroupName = $('#selectServiceGroup option:selected').text();
			var serviceName = $('#selectService option:selected').text();
			
			var clusterId = $('#selectCluster option:selected').val();
			var hostId = $('#selectHost option:selected').val();
			var clusterName = $('#selectCluster option:selected').text();
			var hostName = $('#selectHost option:selected').text();
			
			// 유효성 검사
			var sdt = new Date(startDate);
			var edt = new Date(endDate);
			var tdt = new Date();
			
			var dateDiff = Math.ceil((sdt.getTime() - edt.getTime())/(1000*3600*24));
			var todayStartDiff = Math.ceil((sdt.getTime() - tdt.getTime())/(1000*3600*24));
			var todayEndDiff = Math.ceil((edt.getTime() - tdt.getTime())/(1000*3600*24));
		
			if (todayStartDiff > 0 || todayEndDiff > 0) {
				alert('미래의 일자는 선택할 수 없습니다. 다시 선택해 주세요.');
				return false;
			}
			
			// 20초 단위 (1시간)
			if (dateType == 0) {
				var st = Number(startTime.replace(':', ''));
				var et = Number(endTime.replace(':', ''));
				var timeDiff = Math.ceil(et-st);
				
				if (timeDiff > 100) {
					alert('20초 단위는 최대 1시간까지 조회할 수 있습니다.');
					return false;
				}
			}
			
			// 5분 단위 (1일) 
			if (dateType == 1 && dateDiff < -1) {
				alert('5분 단위는 최대 1일까지 조회할 수 있습니다.');
				return false;
			}
			
			// 30분 단위 (7일)
			if (dateType == 2 && dateDiff < -7) {
				alert('30분 단위는 최대 7일까지 조회할 수 있습니다.');
				return false;
			}
			
			// 2시간 단위 (30일)
			if (dateType == 3 && dateDiff < -30) {
				alert('2시간 단위는 최대 30일까지 조회할 수 있습니다.');
				return false;
			}
			
			// 24시간 단위 (365일)
			if (dateType == 4 && dateDiff < -365) {
				alert('24시간 단위는 최대 1년까지 조회할 수 있습니다.');
				return false;
			}
			
			// 조회 실행
			if (category == 'clusterChoiceAll') {
				$('#name1').html('클러스터');
				$('#name2').html('호스트');
				
				clusterId = clusterName == '전체' ? 'clusterAll' : clusterId;
				hostId = hostName == '전체' ? 'hostAll' : hostId;
			}
			
			if (category == 'tenantsChoiceAll') {
				$('#name1').html('서비스 그룹');
				$('#name2').html('서비스');
				
				clusterName = 0;
				hostName = 0;
			}
			
			// 차트 새로고침
			getVMPerformance(category, dateType, clusterId, hostId, serviceGroupId, serviceId, vmId, startDate, endDate, startTime, endTime);
			
			// 테이블 새로고침
			tableReload();
			getVMPerformanceList(category, dateType, clusterId, hostId, serviceGroupId, serviceId, 
					clusterName, hostName, serviceGroupName, serviceName, vmId, vmName, startDate, endDate, startTime, endTime);
		}
		
		// 테이블 초기화
		function tableReload() {
			var tableVMPerformance = $('#tableVMPerformance').DataTable();
			tableVMPerformance.destroy();
		}
	</script>
</body>

</html>