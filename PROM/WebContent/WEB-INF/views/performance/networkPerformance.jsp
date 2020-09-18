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
					<div class="col-xl-3 col-sm-6">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">pNIC</span></div>
							<select class="form-control" id="selectPNIC"></select>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">주기</span></div>
							<select class="form-control no-search" id="selectCycle">
								<option value="0">실시간</option>
							</select>
						</div>
					</div>
				</div>
			</div>

			<!-- 네트워크 성능 차트 -->
			<div class="card customPerformance-card">
				<div class="card-body">
					<div class="loading-background card-loading"><div class="spinner-border" role="status"></div></div>
					<span class="empty-chart text-disabled d-none">현재 선택한 메트릭에 사용할 수 있는 성능 데이터가 없습니다.</span>
					<div class="chart d-none" id="networkPerformance"></div>
				</div>
			</div>
			
			<!-- NSX-T 클러스터 상태 -->
			<div class="table-body" style="margin-bottom: 15px;">
				<table id="tableStatus" class="cell-border" style="width: 100%;">
					<thead>
						<tr>
							<th>Control Cluster</th>
							<th>Mgmt Cluster</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>-</td>
							<td>-</td>
						</tr>
					</tbody>
				</table>
			</div>	
			
			<!-- NSX-T 노드 목록 -->
			<table id="tableNode" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>노드 (UUID)</th>
						<th>IP 주소</th>
						<th>상태</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			selectClusterList();
			
			getNSXTClusterStatus();
			getNodeList();
			
			// 클러스터 select box 변경 시
			$('#selectCluster').change(function() {
				var clusterId = $('#selectCluster option:selected').val();
				selectHostList(clusterId);
			});

			$('#selectHost').change(function() {
				var clusterId = $('#selectCluster option:selected').val();
				var hostId = $('#selectHost option:selected').val();
				selectPNICList(clusterId, hostId);
			});

			// 네트워크 변경 시 차트 새로고침
			$('#selectPNIC').change(function() {
				chartReload();
			});
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
						for (key in data) {
							html += '<option value="' + data[key].vmHID + '">' + data[key].vmHhostname + '</option>';
						}
					}

					$('#selectHost').empty().append(html);

					var hostId = $('#selectHost option:selected').val();
					selectPNICList(clusterId, hostId);
				}
			})
		}


		// pNIC 리스트
		function selectPNICList(clusterId, hostId) {
			$.ajax({
				url: '/apply/selectPNIC.do',
				type: 'POST',
				data: {
					clusterId: clusterId,
					hostId: hostId
				},
				success: function(data) {
					var html = '';

					if (data == null || data == '') {
						html += '<option value="0" selected disabled>물리적 어댑터가 없습니다.</option>';

					} else {
						for (key in data) {
							html += '<option value="' + data[key].adaptersName + '">' + data[key].adaptersName + '</option>';
						}
					}

					$('#selectPNIC').empty().append(html);

					chartReload();
				}
			})
		}

		// 네트워크 성능 차트
		function getPNICPerformance(hostId, adapterName, cycle) {
			$.ajax({
				url: '/performance/selectPNICPerformanceList.do',
				type: 'POST',
				data: {
					hostId: hostId,
					adaptersName: adapterName,
					period: cycle
				},
				beforeSend: function() {
					$('.card-loading').removeClass('d-none');

					$('.empty-chart').addClass('d-none');
					$('.chart').addClass('d-none');
				},
				complete: function() {
					$('.card-loading').addClass('d-none');
				},
				success: function(data) {

					// 데이터 없을 때
					if (data == null || data == '') {
						$('.empty-chart').removeClass('d-none');

						// 데이터 있을 때
					} else {
						$('.chart').removeClass('d-none');

						// 네트워크 성능 차트
						var chart = echarts.init($('#networkPerformance')[0]);
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
										if (params[key].seriesName == '최대 대역폭') {
											html += '<div>' + params[key].seriesName + ' : ' + params[key].value + '</div>';
										} else {
											html += '<div>' + params[key].marker + params[key].seriesName + ' : ' + params[key].value + ' KB</div>';
										}
									}
									html += '</div>';
									html += '</div>';

									return html;
								}
							},
							legend: {data: ['송신', '수신'], textStyle: {color: '#212121'}, left: 'center', formatter: function(name) {return name + ' (KB)';}},
							// 그리드 설정
							grid: {top: '35', left: '0', right: '1', bottom: '35', containLabel: true},
							// x축 설정 (시간)
							xAxis: {
								type: 'category',
								splitLine: {show: true, lineStyle: {color: '#E0E0E0'}},
								axisTick: {show: false},
								axisLine: {show: false},
								axisLabel: {align: 'center', color: '#212121', formatter: function(value) {return timeConverter(value);}},
								axisLine: {lineStyle: {color: '#9E9E9E'}},
								data: [],
							},
							// y축 설정
							yAxis: {
								type: 'value',
								min: 0,
								splitNumber: 15,
								splitLine: {lineStyle: {color: '#E0E0E0'}},
								axisTick: {show: false},
								axisLabel: {formatter: function(value) {return value + ' KB';}, color: '#212121', verticalAlign: 'bottom'},
								axisLine: {lineStyle: {color: '#9E9E9E'}}
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
								dataBackground: {
									lineStyle: { color: '#44A1EF', width: 1, opacity: 1},
									areaStyle: {color: 'transparent'}
								},
								fillerColor: 'rgba(68,161,239,0.25)',
								borderColor: '#BDBDBD'
							}],
							// line 차트 설정
							series: [
								{name: '송신', type: 'line', showSymbol: false, itemStyle: {color: '#F7B046'}, data: []},
								{name: '수신', type: 'line', showSymbol: false, itemStyle: {color: '#2484DE'}, data: []},
								{name: '최대 대역폭', type: 'line', showSymbol: false, itemStyle: {color: 'transparent'}, data: []},
							]
						}

						for (key in data) {
							option.xAxis.data[key] = data[key].timestamp;

							option.series[0].data[key] = data[key].pnicKBytesTx;
							option.series[1].data[key] = data[key].pnicKBytesRx;
							
							if (data[key].speedMB == 0) {
								option.series[2].data[key] = '알수 없음';
							
							} else if (data[key].speedMB >= 1000) {
								option.series[2].data[key] = data[key].speedMB / 1000 + ' G';
							
							} else {
								option.series[2].data[key] = data[key].speedMB + ' MB';
							}
						}
						
						// 다크 모드 차트 컬러 변경
						updatePNICPerformanceChartColor(option);

						$('#colorControl').on('click', function() {
							updatePNICPerformanceChartColor(option);

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
		function updatePNICPerformanceChartColor(option) {
			var darkMode = localStorage.getItem(sessionUserId + '_darkMode');

			// 다크 모드 ON
			if (darkMode == 'ON') {
				option.legend.textStyle.color = '#EFEFEF';
				
				option.xAxis.axisLabel.color = '#9D9FA4';
				option.xAxis.axisLine.lineStyle.color = '#2F343D';
				option.xAxis.splitLine.lineStyle.color = '#2F343D';
				
				option.yAxis.axisLabel.color = '#9D9FA4';
				option.yAxis.axisLine.lineStyle.color = '#2F343D';
				option.yAxis.splitLine.lineStyle.color = '#2F343D';
				
				option.dataZoom[1].borderColor = '#292D34';
				option.dataZoom[1].fillerColor = 'rgba(68,161,239,0.25)';
				option.dataZoom[1].dataBackground.lineStyle.color = '#44A1EF';

			// 다크 모드 OFF
			} else {
				option.legend.textStyle.color = '#212121';
				
				option.xAxis.axisLabel.color = '#212121';
				option.xAxis.axisLine.lineStyle.color = '#E0E0E0';
				option.xAxis.splitLine.lineStyle.color = '#E0E0E0';
				
				option.yAxis.axisLabel.color = '#212121';
				option.yAxis.axisLine.lineStyle.color = '#E0E0E0';
				option.yAxis.splitLine.lineStyle.color = '#E0E0E0';
				
				option.dataZoom[1].borderColor = '#BDBDBD';
				option.dataZoom[1].fillerColor = 'rgba(68,161,239,0.25)';
				option.dataZoom[1].dataBackground.lineStyle.color = '#44A1EF';
			}
		}

		// pNIC 성능 차트 새로고침
		function chartReload() {
			var hostId = $('#selectHost option:selected').val();
			var adapterName = $('#selectPNIC option:selected').val();
			var cycle = $('#selectCycle option:selected').val();
			
			getPNICPerformance(hostId, adapterName, cycle);
		}
		
		// NSX-T 클러스터 상태
		function getNSXTClusterStatus() {
			$.ajax({
				url: '/dash/getNSXTClusterList.do',
				type: 'GET',
				success: function(data) {
					var html = '';
					
					html += '<tr>'
					html += '<td>'
					if (data[0].controlClusterStatus == 'STABLE') {
						html += '<span class="text-on">정상</span>'
					
					} else if (data[0].controlClusterStatus == 'unknown') {
						html += '<span class="text-off">연결 끊김</span>'
					
					} else {
						html += '<span class="text-off">비정상</span>'
					}
					html += '</td>';

					html += '<td>';
					if (data[0].mgmtClusterStatusStaus == 'STABLE') {
						html += '<span class="text-on">정상</span>'
					
					} else if (data[0].mgmtClusterStatusStaus == 'unknown') {
						html += '<span class="text-off">연결 끊김</span>'
					
					} else {
						html += '<span class="text-off">비정상</span>'
					}
					html += '</td>';
					html += '</tr>'

					$('#tableStatus tbody').empty().append(html);
				}
			});
		}
		
		// NSX-T 클러스터 - 노드 목록
		function getNodeList() {
			var tableNode = $('#tableNode').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/dash/getNSXTClusterList.do',
					type: 'GET',
					dataSrc: ''
				},
				columns: [
					{data: 'uuid'},
					{data: 'mgmtClusterListenIpAddress'},
					{data: 'status', render: function(data, type, row) {
						data = data == 1 ? '<span class="text-on">정상</span>' : '<span class="text-off"> 비정상</span>'
						return data;
					}}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
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
						title: 'NSX-T 노드 목록'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: 'NSX-T 노드 목록'
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
	</script>
</body>

</html>