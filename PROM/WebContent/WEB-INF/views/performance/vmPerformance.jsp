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
					<div class="col-xl-3 col-sm-6 clusterDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">클러스터</span></div>
							<select class="form-control" id="selectCluster"></select>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6 clusterDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">호스트</span></div>
							<select class="form-control" id="selectHost"></select>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6 serviceGroupDiv d-none">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">서비스 그룹</span></div>
							<select class="form-control" id="selectServiceGroup"></select>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6 serviceGroupDiv d-none">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">서비스</span></div>
							<select class="form-control" id="selectService"></select>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">가상머신</span></div>
							<select class="form-control" id="selectVM"></select>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">주기</span></div>
							<select class="form-control no-search" id="selectCycle">
								<option value="0">실시간</option>
								<option value="1">일간</option>
								<option value="2">주간</option>
							</select>
						</div>
					</div>
				</div>
			</div>	
			
			<!-- 내보내기 -->
			<form method="post" action="/performance/exportVMPerformance.do" id="exportExcel">
				<input type="hidden" name="tenantId">
				<input type="hidden" name="tenantName">
				<input type="hidden" name="serviceId">
				<input type="hidden" name="serviceName">
				<input type="hidden" name="clusterId">
				<input type="hidden" name="clusterName">
				<input type="hidden" name="hostId">
				<input type="hidden" name="hostName">
				<input type="hidden" name="category">
				<input type="hidden" name="vmID">
				<input type="hidden" name="period">
				<input type="hidden" name="isUserTenantMapping">
				<button type="submit" class="btn exportBtn">내보내기</button>
			</form>
			
			<!-- 가상머신 성능 정보 테이블 -->
			<div class="table-body performance-table">
				<table class="cell-border" style="width: 100%;">
					<thead>
						<tr>
							<th>가상머신 수</th>
							<th>총 vCPU</th>
							<th>총 Memory</th>
							<th>총 Disk</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>-</td>
							<td>-</td>
							<td>-</td>
							<td>-</td>
						</tr>
					</tbody>
				</table>
			</div>	
			
			<!-- 가상머신 성능 차트 -->
			<div class="row">
				<div class="col-xl-6 col-sm-12">
					<div class="card performance-card mt-0">
						<div class="card-header">vCPU 사용률 (%)</div>
						<div class="card-body">
							<div class="loading-background card-loading"><div class="spinner-border" role="status"></div></div>
							<span class="empty-chart text-disabled d-none">현재 선택한 메트릭에 사용할 수 있는 성능 데이터가 없습니다.</span>
							<div class="chart d-none" id="cpuPerformance"></div>
						</div>
					</div>
				</div>
				<div class="col-xl-6 col-sm-12">
					<div class="card performance-card mt-0">
						<div class="card-header">Memory 사용률 (%)</div>
						<div class="card-body">
							<div class="loading-background card-loading"><div class="spinner-border" role="status"></div></div>
							<span class="empty-chart text-disabled d-none">현재 선택한 메트릭에 사용할 수 있는 성능 데이터가 없습니다.</span>
							<div class="chart d-none" id="memoryPerformance"></div>
						</div>
					</div>
				</div>
				<div class="col-xl-6 col-sm-12">
					<div class="card performance-card">
						<div class="card-header">Disk 사용량 (KB)</div>
						<div class="card-body">
							<div class="loading-background card-loading"><div class="spinner-border" role="status"></div></div>
							<span class="empty-chart text-disabled d-none">현재 선택한 메트릭에 사용할 수 있는 성능 데이터가 없습니다.</span>
							<div class="chart d-none" id="diskPerformance"></div>
						</div>
					</div>
				</div>
				<div class="col-xl-6 col-sm-12">
					<div class="card performance-card">
						<div class="card-header">Network 사용량 (KB)</div>
						<div class="card-body">
							<div class="loading-background card-loading"><div class="spinner-border" role="status"></div></div>
							<span class="empty-chart text-disabled d-none">현재 선택한 메트릭에 사용할 수 있는 성능 데이터가 없습니다.</span>
							<div class="chart d-none" id="networkPerformance"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		var activeCluster = '${activeCluster}';
		var activeHost = '${activeHost}';
		var activeServiceGroup = '${activeServiceGroup}';
		var activeService= '${activeService}';
		var activeVM = '${activeVM}';
		
		// 사용자가 매핑된 테넌트 사용 여부 
		var isUserTenantMapping = 'false';
		var category = (activeCluster && activeHost) || !activeVM ? 'cluster' : 'serviceGroup';
		
		$(document).ready(function() {
			
			// 클러스터별/서비스 그룹별 radio 변경 시
			$('input[name="clusterOrServiceGroup"]').change(function () {
				$('#page_loading').removeClass('d-none');
				
				// 클러스터별 선택 시
				if ($('#byCluster').is(':checked')) {
					category = 'cluster';
					
					$('.clusterDiv').removeClass('d-none');
					$('.serviceGroupDiv').addClass('d-none');
					
					$('#name1').html('클러스터');
					$('#name2').html('호스트');
					
					selectClusterList();
				}
				
				// 서비스 그룹별 선택 시
				if ($('#byServiceGroup').is(':checked')) {
					category = 'serviceGroup';
					
					$('.clusterDiv').addClass('d-none');
					$('.serviceGroupDiv').removeClass('d-none');
					
					$('#name1').html('서비스 그룹');
					$('#name2').html('서비스');
					
					sessionUserApproval > USER_CHECK ? selectServiceGroupList() : selectUserServiceGroupList();
				}
			});
			
			// 클러스터 select box 변경 시
			$('#selectCluster').change(function () {
				var clusterId = $('#selectCluster option:selected').val();
				selectHostList(clusterId);
			});
			
			$('#selectHost').change(function () {
				var clusterId = $('#selectCluster option:selected').val();
				var hostId = $('#selectHost option:selected').val();
				getClusterVMList(clusterId, hostId);
			});
			
			// 서비스 그룹 select box 변경 시
			$('#selectServiceGroup').change(function () {
				var serviceGroupId = $('#selectServiceGroup option:selected').val();
				selectServiceList(serviceGroupId);
			});
			
			$('#selectService').change(function () {
				var serviceGroupId = $('#selectServiceGroup option:selected').val();
				var serviceId = $('#selectService option:selected').val();
				getTenantVMList(serviceGroupId, serviceId);
			});
			
			// 가상머신 변경 시 차트/테이블 새로고침
			$('#selectVM').change(function () {
				tableReload();
				chartReload();
			});
			
			// 주기 변경 시 차트 새로고침
			$('#selectCycle').change(function() {
				chartReload();
			});
			
			// 내보내기
			$('#exportExcel').submit(function() {
				var tenantId = $('#selectServiceGroup option:selected').val();
				var tenantName = $('#selectServiceGroup option:selected').text();
				var serviceId = $('#selectService option:selected').val();
				var serviceName = $('#selectService option:selected').text();
				var clusterId = $('#selectCluster option:selected').val();
				var clusterName = $('#selectCluster option:selected').text();
				var hostId = $('#selectHost option:selected').val();
				var hostName = $('#selectHost option:selected').text();
				var vmId = $('#selectVM option:selected').val();
				var cycle = $('#selectCycle option:selected').val();

				$('input[name=tenantId]').val(tenantId);
				$('input[name=tenantName]').val(tenantName);
				$('input[name=serviceId]').val(serviceId);
				$('input[name=serviceName]').val(serviceName);
				$('input[name=clusterId]').val(clusterId);
				$('input[name=clusterName]').val(clusterName);
				$('input[name=hostId]').val(hostId);
				$('input[name=hostName]').val(hostName);
				$('input[name=vmID]').val(vmId);
				$('input[name=period]').val(cycle);
				$('input[name=category]').val(category);
				$('input[name=isUserTenantMapping]').val(isUserTenantMapping);
			});
			
			// 처음 실행 시 관리자면 클러스터별 보기, 사용자면 서비스 그룹별 보기 실행
			// 사용자는 서비스 그룹별로만 볼 수 있음 (클러스터별/서비스 그룹별 radio 숨김)
			if (sessionUserApproval > USER_CHECK) {
				isUserTenantMapping = 'false';
				
				$('.clusterOrServiceGroupDiv').removeClass('d-none');
				category == 'cluster' ? $('#byCluster').click() : $('#byServiceGroup').click();
			
			} else {
				isUserTenantMapping = 'true';
				
				$('.clusterOrServiceGroupDiv').addClass('d-none');
				$('#byServiceGroup').click();
			}
		});
		
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
							if (activeCluster && activeCluster == data[key].clusterID) {
								html += '<option value="' + data[key].clusterID + '" selected>' + data[key].clusterName + '</option>';
							
							} else {
								html += '<option value="' + data[key].clusterID + '">' + data[key].clusterName + '</option>';
							}
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
							if (activeHost && activeHost == data[key].vmHID) {
								html += '<option value="' + data[key].vmHID + '" selected>' + data[key].vmHhostname + '</option>';
							
							} else {
								html += '<option value="' + data[key].vmHID + '">' + data[key].vmHhostname + '</option>';
							}
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
						html += '<option value="vmAll" selected>전체</option>';
						for (key in data) {
							if (activeVM && activeVM == data[key].vmID) {
								html += '<option value="' + data[key].vmID + '" selected>' + data[key].vmName + '</option>';
							
							} else {
								html += '<option value="' + data[key].vmID + '">' + data[key].vmName + '</option>';
							}
						}
					}
					
					$('#selectVM').empty().append(html);
					
					tableReload();
					chartReload();
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
							if (activeServiceGroup && activeServiceGroup == data[key].id) {
								html += '<option value="' + data[key].id + '" selected>' + data[key].name + '</option>';
							
							} else {
								html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
							}
						}
						if (activeServiceGroup && activeServiceGroup == -1) {
							html += '<option value="-1" selected>미배치</option>';
						}
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
							if (activeServiceGroup && activeServiceGroup == data[key].id) {
								html += '<option value="' + data[key].id + '" selected>' + data[key].name + '</option>';
							
							} else {
								html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
							}
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
							html += '<option value="-1" selected>미배치</option>';
							
						} else {
							html += '<option value="" selected>전체</option>';
							for (key in data) {
								if (activeService && activeService == data[key].vmServiceID) {
									html += '<option value="' + data[key].vmServiceID + '" selected>' + data[key].vmServiceName + '</option>';
								
								} else {
									html += '<option value="' + data[key].vmServiceID + '">' + data[key].vmServiceName + '</option>';
								}
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
				$('#selectVM').html('<option value="0" selected disabled>가상머신이 없습니다.</option>');
				
				tableReload();
				chartReload();
			
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
							html += '<option value="0" selected disabled>가상머신이 없습니다.</option>';
							
						} else {
							html += '<option value="vmAll">전체</option>';
							for (key in data) {
								if (activeVM && activeVM == data[key].vmID) {
									html += '<option value="' + data[key].vmID + '" selected>' + data[key].vmName + '</option>';
								
								} else {
									html += '<option value="' + data[key].vmID + '">' + data[key].vmName + '</option>';
								}
							}
						}
						
						$('#selectVM').empty().append(html);
						tableReload();
						chartReload();
					}
				})
			}
		}
		
		// 가상머신 전체의 성능 테이블
		function getAllVMInformation(serviceGroupId, serviceId, clusterId, hostId) {
			var param = {};
			
			if (category == 'serviceGroup') {
				param = {tenantId : serviceGroupId, serviceId : serviceId, isUserTenantMapping : isUserTenantMapping};
			
			} else {
				param = {clusterId : clusterId, hostId : hostId};
			}
		
			$.ajax({
				url: '/performance/selectVMResourceStatistics.do',
				type: 'POST',
				data: param,
				success : function(data) {
					var head = '';
					var body = '';
					
					head += '<th>가상머신 수</th>';
					head += '<th>총 vCPU</th>';
					head += '<th>총 Memory</th>'
					head += '<th>총 Disk</th>';
					
					// 데이터 없을 때
					if (data == null || data == '') {
						body += '<td>-</td>';
						body += '<td>-</td>';
						body += '<td>-</td>';
						body += '<td>-</td>';
						
					// 데이터 있을 때
					} else {
						body += '<td>' + data.countVM + '</td>';
						body += '<td>' + data.sumCPU + '</td>';
						body += '<td>' + data.sumMemory + ' GB</td>';
						body += '<td>' + data.sumDisk + ' GB</td>';
					}
					
					$('.performance-table thead tr').empty().append(head);
					$('.performance-table tbody tr').empty().append(body);
				}
			})
		}
	
		// 가상머신 한 개의 성능 테이블
		function getOneVMInformation(vmId) {
			$.ajax({
				url: '/apply/selectVMData.do',
				type: 'POST',
				data: {
					vmId: vmId
				},
				success: function(data) {
					var head = '';
					var body = '';
					var totalIp = '';
					
					head += '<th>vCPU</th>';
					head += '<th>Memory</th>';
					head += '<th>총 Disk</th>'
					head += '<th>IP 주소</th>';
					head += '<th>OS</th>';
					head += '<th>전원</th>';
					
					// 데이터 없을 때
					if (data == null || data == '') {
						body += '<td>-</td>';
						body += '<td>-</td>';
						body += '<td>-</td>';
						body += '<td>-</td>';
						body += '<td>-</td>';
						body += '<td>-</td>';
						
					// 데이터 있을 때
					} else {
						if (data.vmIpaddr1 != null) {
							totalIp += data.vmIpaddr1;
						}
						
						if (data.vmIpaddr2 != null) {
							totalIp += ', ' + data.vmIpaddr2;
						}
						
						if (data.vmIpaddr3 != null) {
							totalIp += ', ' + data.vmIpaddr3;
						}
						
						if (totalIp.startsWith(',')) {
							totalIp == totalIp.substr(1);
						}
						
						if (data.vmIpaddr1 == null && data.vmIpaddr2 == null && data.vmIpaddr3 == null) {
							totalIp = '<span class="text-disabled">없음</span>';
						}
						
						body += '<td>' + data.vmCPU + '</td>';
						body += '<td>' + data.vmMemory + ' GB</td>';
						body += '<td>' + data.vmDisk + ' GB</td>';
						body += '<td>' + totalIp + '</td>';
						body += '<td>' + data.vmOS + '</td>';
						body += data.vmStatus == 'poweredOn' ? '<td class="text-on">ON</td>' : '<td class="text-off">OFF</td>';
					}
					
					$('.performance-table thead tr').empty().append(head);
					$('.performance-table tbody tr').empty().append(body);
				}
			})
		}
		
		// CPU 사용률 차트
		var cpuChart = echarts.init($('#cpuPerformance')[0]);
		var cpuOption = {
			color: ["#3398DB"],
			// 툴팁 설정
			tooltip: {
				trigger: 'axis',
				backgroundColor: 'transparent',
				// card 형태로 툴팁 포맷
				formatter: function(params) {
					var html = '';
					
					html += '<div class="card card-tooltip">';
					html += '<div class="card-header">' + dateTimeConverter(Number(params[0].name)) + '</div>';
					html += '<div class="card-body">';
					html += params[0].marker + 'vCPU: ' + params[0].value+ ' %';
					html += '</div>';
					html += '</div>';

					return html;
				}
			},
			// 그리드 설정
			grid: {top: '0', left: '25', right: '25', bottom: '35', containLabel: true},
			// x축 설정 (시간)
			xAxis: {
				type: 'category',
				splitLine: {show: true, lineStyle: {color: "#E0E0E0"}},
				axisTick: {show : false},
				axisLabel: {align: "center", color: "212121",
					formatter: function (value) {
						return performanceTime(value);
					}	
				},
				axisLine: {lineStyle: {color: "#9E9E9E"}},
				min: function (value) {return value.min;},
				max: function (value) {return value.max;},
				data: [],
			},
			// y축 설정
			yAxis: {
				type: 'value',
				min: 0,
				max: 100,
				splitNumber: 10,
				splitLine: {lineStyle: {color: "#E0E0E0"}},
				axisTick: {show : false},
				axisLabel: {formatter: function(value) {return value + ' %';}, color: "#212121", verticalAlign: "bottom"},
				axisLine: {lineStyle: {color: "#9E9E9E"}}
			},
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
			series: [{type: 'line', hoverAnimation: false, showSymbol: false, smooth: true, lineStyle: {width: 2.5}, data: []}]
		}
		
		// Memory 사용률 차트
		var memoryChart = echarts.init($('#memoryPerformance')[0]);
		var memoryOption = {
			color: ["#3398DB"],
			// 툴팁 설정
			tooltip: {
				trigger: 'axis',
				backgroundColor: 'transparent',
				// card 형태로 툴팁 포맷
				formatter: function(params) {
					var html = '';
					
					html += '<div class="card card-tooltip">';
					html += '<div class="card-header">' + dateTimeConverter(Number(params[0].name)) + '</div>';
					html += '<div class="card-body">';
					html += params[0].marker + 'Memory: ' + params[0].value+ ' %';
					html += '</div>';
					html += '</div>';

					return html;
				}
			},
			// 그리드 설정
			grid: {top: '0', left: '25', right: '25', bottom: '35', containLabel: true},
			// x축 설정 (시간)
			xAxis: {
				type: 'category',
				splitLine: {show: true, lineStyle: {color: "#E0E0E0"}},
				axisTick: {show : false},
				axisLabel: {align: "center", color: "212121",
					formatter: function (value) {
						return performanceTime(value);
					}	
				},
				axisLine: {lineStyle: {color: "#9E9E9E"}},
				min: function (value) {return value.min;},
				max: function (value) {return value.max;},
				data: [],
			},
			// y축 설정
			yAxis: {
				type: 'value',
				min: 0,
				max: 100,
				splitNumber: 10,
				splitLine: {lineStyle: {color: "#E0E0E0"}},
				axisTick: {show : false},
				axisLabel: {formatter: function(value) {return value + ' %';}, color: "#212121", verticalAlign: "bottom"},
				axisLine: {lineStyle: {color: "#9E9E9E"}}
			},
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
			series: [{type: 'line', hoverAnimation: false, showSymbol: false, smooth: true, lineStyle: {width: 2.5}, data: []}]
		}
		
		// Disk 사용률 차트
		var diskChart = echarts.init($('#diskPerformance')[0]);
		var diskOption = {
			color: ["#3398DB"],
			// 툴팁 설정
			tooltip: {
				trigger: 'axis',
				backgroundColor: 'transparent',
				// card 형태로 툴팁 포맷
				formatter: function(params) {
					var html = '';
					
					html += '<div class="card card-tooltip">';
					html += '<div class="card-header">' + dateTimeConverter(Number(params[0].name)) + '</div>';
					html += '<div class="card-body">';
					html += params[0].marker + 'Disk: ' + params[0].value+ ' KB';
					html += '</div>';
					html += '</div>';

					return html;
				}
			},
			// 그리드 설정
			grid: {top: '0', left: '25', right: '25', bottom: '35', containLabel: true},
			// x축 설정 (시간)
			xAxis: {
				type: 'category',
				splitLine: {show: true, lineStyle: {color: "#E0E0E0"}},
				axisTick: {show : false},
				axisLabel: {align: "center", color: "212121",
					formatter: function (value) {
						return performanceTime(value);
					}	
				},
				axisLine: {lineStyle: {color: "#9E9E9E"}},
				min: function (value) {return value.min;},
				max: function (value) {return value.max;},
				data: [],
			},
			// y축 설정
			yAxis: {
				type: 'value',
				min: 0,
				splitNumber: 10,
				splitLine: {lineStyle: {color: "#E0E0E0"}},
				axisTick: {show : false},
				axisLabel: {formatter: function(value) {return value + ' KB';}, color: "#212121", verticalAlign: "bottom"},
				axisLine: {lineStyle: {color: "#9E9E9E"}}
			},
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
			series: [{type: 'line', hoverAnimation: false, showSymbol: false, smooth: true, lineStyle: {width: 2.5}, data: []}]
		}
		
		// Network 사용률 차트
		var networkChart = echarts.init($('#networkPerformance')[0]);
		var networkOption = {
			color: ['#3398DB'],
			// 툴팁 설정
			tooltip: {
				trigger: 'axis',
				backgroundColor: 'transparent',
				// card 형태로 툴팁 포맷
				formatter: function(params) {
					var html = '';
					
					html += '<div class="card card-tooltip">';
					html += '<div class="card-header">' + dateTimeConverter(Number(params[0].name)) + '</div>';
					html += '<div class="card-body">';
					html += params[0].marker + 'Network: ' + params[0].value+ ' KB';
					html += '</div>';
					html += '</div>';

					return html;
				}
			},
			// 그리드 설정
			grid: {top: '0', left: '25', right: '25', bottom: '35', containLabel: true},
			// x축 설정 (시간)
			xAxis: {
				type: 'category',
				splitLine: {show: true, lineStyle: {color: "#E0E0E0"}},
				axisTick: {show : false},
				axisLabel: {align: "center", color: "212121",
					formatter: function (value) {
						return performanceTime(value);
					}	
				},
				axisLine: {lineStyle: {color: "#9E9E9E"}},
				min: function (value) {return value.min;},
				max: function (value) {return value.max;},
				data: [],
			},
			// y축 설정
			yAxis: {
				type: 'value',
				min: 0,
				splitNumber: 10,
				splitLine: {lineStyle: {color: "#E0E0E0"}},
				axisTick: {show : false},
				axisLabel: {formatter: function(value) {return value + ' KB';}, color: "#212121", verticalAlign: "bottom"},
				axisLine: {lineStyle: {color: "#9E9E9E"}}
			},
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
			series: [{type: 'line', hoverAnimation: false, showSymbol: false, smooth: true, lineStyle: {width: 2.5}, data: []}]
		}
		
		// 다크 모드 차트 컬러 변경
		function updateVMPerformanceChartColor(cpuOption, memoryOption, diskOption, networkOption) {
			var darkMode = localStorage.getItem(sessionUserId + '_darkMode');
			var vmPerformanceChart = [cpuOption, memoryOption, diskOption, networkOption];

			// 다크 모드 ON
			if (darkMode == 'ON') {
				$(vmPerformanceChart).each(function(index, item) {
					console.log(item);
					
					item.xAxis.axisLabel.color = '#9D9FA4';
					item.xAxis.axisLine.lineStyle.color = '#292D34';
					item.xAxis.splitLine.lineStyle.color = '#292D34';
					
					item.yAxis.axisLabel.color = '#9D9FA4';
					item.yAxis.axisLine.lineStyle.color = '#292D34';
					item.yAxis.splitLine.lineStyle.color = '#292D34';
					
					item.dataZoom[1].borderColor = '#292D34';
					item.dataZoom[1].fillerColor = 'rgba(68,161,239,0.25)';
					item.dataZoom[1].dataBackground.lineStyle.color = '#44A1EF';
					
					item.color = '#57D7FF';
				});

				// 다크 모드 OFF
			} else {
				$(vmPerformanceChart).each(function(index, item) {
					item.xAxis.axisLabel.color = '#212121';
					item.xAxis.axisLine.lineStyle.color = '#9E9E9E';
					item.xAxis.splitLine.lineStyle.color = '#E0E0E0';
					
					item.yAxis.axisLabel.color = '#212121';
					item.yAxis.axisLine.lineStyle.color = '#9E9E9E';
					item.yAxis.splitLine.lineStyle.color = '#E0E0E0';
					
					item.dataZoom[1].borderColor = '#BDBDBD';
					item.dataZoom[1].fillerColor = 'rgba(68,161,239,0.25)';
					item.dataZoom[1].dataBackground.lineStyle.color = '#44A1EF';
					
					item.color = '#3398DB';
				});
			}
		}
		
		// 가상머신 전체의 성능 차트
		function getAllVMPerformance(tenantId, serviceId, clusterId, hostId, cycle) {
			var param = {};
			
			if (category == 'serviceGroup') {
				param = {tenantId : tenantId, serviceId : serviceId, period : cycle, isUserTenantMapping : isUserTenantMapping};
			
			} else {
				param = {clusterId : clusterId, hostId : hostId, period : cycle};
			}
			
			$.ajax({
				url: '/performance/selectVMPerformanceStatistics.do',
				type: 'POST',
				data: param,
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
						
						for (key in data) {
							cpuOption.xAxis.data[key] = data[key].timestamp;
							memoryOption.xAxis.data[key] = data[key].timestamp;
							diskOption.xAxis.data[key] = data[key].timestamp;
							networkOption.xAxis.data[key] = data[key].timestamp;
							
							cpuOption.series[0].data[key] = data[key].avgCPU;
							memoryOption.series[0].data[key] = data[key].avgMemory;
							diskOption.series[0].data[key] = data[key].avgDisk;
							networkOption.series[0].data[key] = data[key].avgNetwork;
						}
					}
					
					// 다크 모드 차트 컬러 변경
					updateVMPerformanceChartColor(cpuOption, memoryOption, diskOption, networkOption);

					$('#colorControl').on('click', function() {
						updateVMPerformanceChartColor(cpuOption, memoryOption, diskOption, networkOption);

						cpuChart.setOption(cpuOption, true);
						memoryChart.setOption(memoryOption, true);
						diskChart.setOption(diskOption, true);
						networkChart.setOption(networkOption, true);
					});
					
					cpuChart.setOption(cpuOption, true);
					memoryChart.setOption(memoryOption, true);
					diskChart.setOption(diskOption, true);
					networkChart.setOption(networkOption, true);
					
					cpuChart.resize();
					memoryChart.resize();
					diskChart.resize();
					networkChart.resize();
					
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
		
		// 가상머신 한 개의 성능 차트
		function getOneVMPerformance(vmId, cycle) {
			$.ajax({
				url: '/performance/selectVMPerformanceList.do',
				type: 'POST',
				data: {
					vmID : vmId,
					period : cycle
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
						
						for (key in data) {
							cpuOption.xAxis.data[key] = data[key].timestamp;
							memoryOption.xAxis.data[key] = data[key].timestamp;
							diskOption.xAxis.data[key] = data[key].timestamp;
							networkOption.xAxis.data[key] = data[key].timestamp;
							
							cpuOption.series[0].data[key] = data[key].cpu;
							memoryOption.series[0].data[key] = data[key].memory;
							diskOption.series[0].data[key] = data[key].disk;
							networkOption.series[0].data[key] = data[key].network;
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

		// 성능 차트 데이터 변환
		function performanceTime(value) {
			var cycle = $('#selectCycle option:selected').val();
			
			var date = new Date(Number(value));
			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var day = date.getDate();
			var hour = date.getHours();
			var min = date.getMinutes();
			var sec = date.getSeconds();
			
			// 실시간 일 때 HH:mm:ss
			if (cycle == 0) {
				return (hour < 10 ? '0' + hour : hour) + ':' + (min < 10 ? '0' + min : min) + ':' + (sec < 10 ? '0' + sec : sec);
			}
			
			// 일간 일 때 MM-dd HH:mm:ss
			if (cycle == 1) {
				return (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day) + ' ' + (hour < 10 ? '0' + hour : hour) + ':' + (min < 10 ? '0' + min : min) + ':' + (sec < 10 ? '0' + sec : sec);
			}

			// 주간 일 때 yyyy-MM-dd
			if (cycle == 2) {
				return year + '-' + (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day);
			}
		}
		
		// 가상머신 성능 테이블 새로고침
		function tableReload() {
			if (category == 'serviceGroup') {
				var serviceGroupId = $('#selectServiceGroup option:selected').val();
				var serviceId = $('#selectService option:selected').val();
				var vmId = $('#selectVM option:selected').val();
				
				vmId == 'vmAll' ? getAllVMInformation(serviceGroupId, serviceId, '', '') : getOneVMInformation(vmId);
			
			} else {
				var clusterId = $('#selectCluster option:selected').val();
				var hostId = $('#selectHost option:selected').val();
				var vmId = $('#selectVM option:selected').val();
				
				vmId == 'vmAll' ? getAllVMInformation('', '', clusterId, hostId) : getOneVMInformation(vmId);
			} 
		}
		
		// 가상머신 성능 차트 새로고침
		function chartReload() {
			if (category == 'serviceGroup') {
				var serviceGroupId = $('#selectServiceGroup option:selected').val();
				var serviceId = $('#selectService option:selected').val();
				var vmId = $('#selectVM option:selected').val();
				var cycle = $('#selectCycle option:selected').val();
				
				vmId == 'vmAll' ? getAllVMPerformance(serviceGroupId, serviceId, '', '', cycle) : getOneVMPerformance(vmId, cycle);
			
			} else {
				var clusterId = $('#selectCluster option:selected').val();
				var hostId = $('#selectHost option:selected').val();
				var vmId = $('#selectVM option:selected').val();
				var cycle = $('#selectCycle option:selected').val();
				
				vmId == 'vmAll' ? getAllVMPerformance('', '', clusterId, hostId, cycle) : getOneVMPerformance(vmId, cycle);
			}
		}
	</script>
</body>

</html>