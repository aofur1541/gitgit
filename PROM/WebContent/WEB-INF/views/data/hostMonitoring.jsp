<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/external_JS/Chart.bundle.min.js"></script>
		<script src="${path}/resources/PROM_JS/refreshGetParaDelete.js"></script>
		<script src="${path}/resources/PROM_JS/adminCheck.js"></script>
	</head>
	<body>
		<div class="card bg-dark mb-0 table-type-2 table-type-3 border-bottom-dark">
			<div class="table-filter-dark">
				<div class="col-sm-3 col-xl-3">
					<select class="form-control select-search" id="defaultClusterSB" data-fouc></select>
				</div>
				<div class="col-sm-3 col-xl-3">
					<select class="form-control select-search" id="defaultHostSB" data-fouc></select>
				</div>
				<div class="col-sm-2 col-xl-4 width-100 mb-0">
				</div>
				<div class="col-sm-2 col-xl-1">
					<select class="form-control select" id="hostUseGraphTimeChoice" data-fouc>
						<option value="Realtime">실시간</option>
						<option value="oneDay">하루</option>
						<option value="oneWeek">일주일</option>
					</select>
				</div>
				<div class="col-sm-2 col-xl-1">
					<form action="/jquery/perfHostExport.do" id="perfHostExportForm">
						<input type="hidden" name="perfClusterID">
						<input type="hidden" name="perfClusterName">
						<input type="hidden" name="perfHostID">
						<input type="hidden" name="perfHostdate">
						<button type="submit" class="btn bg-prom col-md-12"><i class="icon-import"></i><span class="ml-2">내보내기</span></button>
					</form>
				</div>
			</div>
			<div class="datatables-body">
				<table class="promTable hover" style="width:100%;">
					<thead>
						<tr id="topHosthead">
						</tr>
					</thead>
					<tbody id="hostInfoList"></tbody>
				</table>
			</div>
		</div>
		
		<div class="card mb-0 bg-dark table-type-4">
			<div class="row-padding-0">
				<div class="col-sm-6 col-xl-6 padding-0 border-bottom-light">
					<div class="card bg-dark mb-0 table-type-1">
						<div class="table-title-light">
							<h6 class="card-title mb-0">CPU 사용량 (%)</h6>
						</div>
						<div class="monitoring-chart-body">
							<span class="monitoring-chart-empty">현재 선택한 메트릭에 사용할 수 있는 성능 데이터가 없습니다.</span>
							<canvas id="cpuChart"></canvas>
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-xl-6 padding-0 border-bottom-light">
					<div class="card bg-dark mb-0 table-type-1">
						<div class="table-title-light">
							<h6 class="card-title mb-0">Memory 사용량 (%)</h6>
						</div>
						<div class="monitoring-chart-body">
							<span class="monitoring-chart-empty">현재 선택한 메트릭에 사용할 수 있는 성능 데이터가 없습니다.</span>
							<canvas id="memoryChart"></canvas>
						</div>
					</div>
				</div>
			</div>
			<div class="row-padding-0">
				<div class="col-sm-6 col-xl-6 padding-0 border-bottom-light">
					<div class="card bg-dark mb-0 table-type-1">
						<div class="table-title-light">
							<h6 class="card-title mb-0">Disk 사용량 (KB)</h6>
						</div>
						<div class="monitoring-chart-body">
							<span class="monitoring-chart-empty">현재 선택한 메트릭에 사용할 수 있는 성능 데이터가 없습니다.</span>
							<canvas id="diskChart"></canvas>
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-xl-6 padding-0">
					<div class="card bg-dark mb-0 table-type-1">
						<div class="table-title-light">
							<h6 class="card-title mb-0">Network 사용량 (KB)</h6>
						</div>
						<div class="monitoring-chart-body">
							<span class="monitoring-chart-empty">현재 선택한 메트릭에 사용할 수 있는 성능 데이터가 없습니다.</span>
							<canvas id="networkChart"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>
				
		<script>
			var global_getParameterCluster = '${clusterActiveName}';
			var global_getParameterHost = '${hostActiveName}';
			var realval = '';
		
			$(function() {
				
				$("#perfHostExportForm").submit(function(event) {
					var hostUseGraphTimeChoice = $("#hostUseGraphTimeChoice option:selected").val();
					var hostID = $("#defaultHostSB option:selected").val();
					var clusterID = $("#defaultClusterSB option:selected").val();
					var clusterName = $("#defaultClusterSB option:selected").text();
					$("input[name=perfClusterName]").val(clusterName);
					$("input[name=perfClusterID]").val(clusterID);
					$("input[name=perfHostID]").val(hostID);
					$("input[name=perfHostdate]").val(hostUseGraphTimeChoice);
				});
				
				$("#defaultClusterSB").change(function() {
					getHostsInClusterCaseOne();
				})
				
				$("#defaultHostSB").change(function() {
					hostDataOptions();
				})
				
				$('#hostUseGraphTimeChoice').change(function() {
					var hostUseGraphTimeChoice = $("#hostUseGraphTimeChoice option:selected").val();
					var setHost = $("#defaultHostSB option:selected").val();
					var dateChk = 0;
					
					dateChk = setDateCheck(hostUseGraphTimeChoice);
					
					if (hostUseGraphTimeChoice == 'Realtime') {
						realTimeAction(true);
					} else if (hostUseGraphTimeChoice == 'oneDay') {
						realTimeAction(false);
					} else if (hostUseGraphTimeChoice == 'oneWeek') {
						realTimeAction(false);
					}
					
					if ( setHost == 'hostAll' ) {
						getClusterTotalPerfOfHosts();
					} else {
						getHostInfo();
					}
					
				})
				
				getClusterListCaseOne(global_getParameterCluster,global_getParameterHost);
	
				if (global_getParameterHost != '') {
					setTimeout(function() {
						getPerfHost(0);
					}, 700)

				} else {
					setTimeout(function() {
						getClusterTotalPerfGraphOfHosts(0);
					}, 700)

				}

				realTimeAction(true);
				
			});
			
			Chart.defaults.global.defaultFontColor = "#dedede";

			//cpu 차트
			var optionsCPU = {
				type : 'line',
				data : {
					labels : [],
					datasets : [ {
						label : "CPU 사용량(%)",
						data : [],
						borderColor : "#00baf2",
						borderWidth : 2,

						pointRadius : 1,
						pointBorderWidth : 1,
						pointBorderColor : "#00baf2",

						pointHoverBorderColor : "#fff",
						pointHoverBackgroundColor : "#00baf2",
						pointHoverBorderWidth : 3,
					} ]
				},
				options : {
					maintainAspectRatio : false,
					tooltips : {
						backgroundColor : "#fff",
						displayColors : false,
						titleFontColor : "#000",
						bodyFontColor : "#000",
						mode : "nearest",
						intersect : 0,
						position : "nearest",
					},
					legend : {
						display : false,
					},
					scales : {
						xAxes : [ {
							gridLines : {
								display : false
							},
							type : 'time',
							distribution : 'series',
							
							time : {
								
								displayFormats : {
									'day' : 'YYYY-MM-DD',
									'hour' : 'DD-HH:mm:ss',
									'minute' : 'HH:mm:ss'
								},
								unit : '',
								unitStepSize : 0,
							
							},
						
						} ],
						yAxes : [ {
							gridLines : {
								color : "#1d2026",
							},
							ticks : {
								callback : function(data, index, values) {
									return data + ' %';
								},
								beginAtZero : true
							}
						} ],
					}
				}
			}

			//메모리 차트
			var optionsMemory = {
				type : 'line',
				data : {
					labels : [],
					datasets : [ {
						label : "Memory 사용량(%)",
						data : [],
						borderColor : "#00baf2",
						borderWidth : 2,

						pointRadius : 1,
						pointBorderWidth : 1,
						pointBorderColor : "#00baf2",

						pointHoverBorderColor : "#fff",
						pointHoverBackgroundColor : "#00baf2",
						pointHoverBorderWidth : 3,
					} ]
				},
				options : {
					maintainAspectRatio : false,
					tooltips : {
						backgroundColor : "#fff",
						displayColors : false,
						titleFontColor : "#000",
						bodyFontColor : "#000",
						mode : "nearest",
						intersect : 0,
						position : "nearest",
					},
					legend : {
						display : false
					},
					scales : {
						xAxes : [ {
							gridLines : {
								display : false
							},
							type : 'time',
							distribution : 'series',
							time : {
								displayFormats : {
									'day' : 'YYYY-MM-DD',
									'hour' : 'DD-HH:mm:ss',
									'minute' : 'HH:mm:ss'
								},
								unit : '',
								unitStepSize : 0,
							},
						} ],
						yAxes : [ {
							gridLines : {
								color : "#1d2026",
							},
							ticks : {
								callback : function(data, index, values) {
									return data + ' %';
								},
								beginAtZero : true
							}
						} ],
					}
				}
			}

			//디스크 차트
			var optionsDisk = {
				type : 'line',
				data : {
					labels : [],
					datasets : [ {
						label : "Disk 사용량(KB)",
						data : [],
						borderColor : "#00baf2",
						borderWidth : 2,

						pointRadius : 1,
						pointBorderWidth : 1,
						pointBorderColor : "#00baf2",

						pointHoverBorderColor : "#fff",
						pointHoverBackgroundColor : "#00baf2",
						pointHoverBorderWidth : 3,
					} ]
				},
				options : {
					maintainAspectRatio : false,
					tooltips : {
						backgroundColor : "#fff",
						displayColors : false,
						titleFontColor : "#000",
						bodyFontColor : "#000",
						mode : "nearest",
						intersect : 0,
						position : "nearest",
					},
					legend : {
						display : false
					},
					scales : {
						xAxes : [ {
							gridLines : {
								display : false
							},
							type : 'time',
							distribution : 'series',
							time : {
								displayFormats : {
									'day' : 'YYYY-MM-DD',
									'hour' : 'DD-HH:mm:ss',
									'minute' : 'HH:mm:ss'
								},
								unit : '',
								unitStepSize : 0,
							},
						} ],
						yAxes : [ {
							gridLines : {
								color : "#1d2026",
							},
							ticks : {
								callback : function(value, index, values) {
									return (value) + ' KB';
								}
							}
						} ],
					}
				}
			}

			//네트워크 차트
			var optionsNetwork = {
				type : 'line',
				data : {
					labels : [],
					datasets : [ {
						label : "Network 사용량(KB)",
						data : [],
						borderColor : "#00baf2",
						borderWidth : 2,

						pointRadius : 1,
						pointBorderWidth : 1,
						pointBorderColor : "#00baf2",

						pointHoverBorderColor : "#fff",
						pointHoverBackgroundColor : "#00baf2",
						pointHoverBorderWidth : 3,
					} ]
				},
				options : {
					maintainAspectRatio : false,
					tooltips : {
						backgroundColor : "#fff",
						displayColors : false,
						titleFontColor : "#000",
						bodyFontColor : "#000",
						mode : "nearest",
						intersect : 0,
						position : "nearest",
					},
					legend : {
						display : false
					},
					scales : {
						xAxes : [ {
							gridLines : {
								display : false
							},
							type : 'time',
							distribution : 'series',
							time : {
								displayFormats : {
									'day' : 'YYYY-MM-DD',
									'hour' : 'DD-HH:mm:ss',
									'minute' : 'HH:mm:ss'
								},
								unit : '',
								unitStepSize : 0,
							},
						} ],
						yAxes : [ {
							gridLines : {
								color : "#1d2026",
							},
							ticks : {
								callback : function(value, index, values) {
									return (value) + ' KB';
								}
							}
						} ],
					}
				}
			}

			var ctxCPU = document.getElementById('cpuChart').getContext('2d');
			var cpulineChart = new Chart(ctxCPU, optionsCPU);

			var ctxMemory = document.getElementById('memoryChart').getContext('2d');
			var memorylineChart = new Chart(ctxMemory, optionsMemory);

			var ctxDisk = document.getElementById('diskChart').getContext('2d');
			var disklineChart = new Chart(ctxDisk, optionsDisk);

			var ctxNetwork = document.getElementById('networkChart').getContext('2d');
			var networklineChart = new Chart(ctxNetwork, optionsNetwork);

			
			function hostDataOptions() {

				var setHost = $("#defaultHostSB option:selected").val();
				
				if (setHost == 'hostAll') {
					getClusterTotalPerfOfHosts();
				} else {
					getHostInfo();
				}

			}
			
			var realTimeAction = function(bool) {

				var dateChk = 0;
				var hostUseGraphTimeChoice = $("#hostUseGraphTimeChoice option:selected").val();

				dateChk = setDateCheck(hostUseGraphTimeChoice);

				if (bool) {

					realval = setTimeout(function() {
						var setHost = $("#defaultHostSB option:selected").val();
						
						realTimeAction(bool);
						if (dateChk == 0) {
							if (setHost == 'hostAll') {
								getClusterTotalPerfGraphOfHosts(dateChk);
							} else {
								getPerfHost(dateChk);
							}
						} else {
							clearTimeout(realval);
						}
					}, 5000)
				} else {
					clearTimeout(realval);
				}
			}
			
			function getClusterTotalPerfGraphOfHosts(dateChk) {

				var setTime = new Array();
				
				var clusterID = $("#defaultClusterSB option:selected").val();

				$.ajax({
					data : {
						clusterID : clusterID,
						dateChk : dateChk
					},
					url : "/perf/getClusterTotalPerfGraphOfHosts.do",
					success : function(hostPerf) {
						optionsCPU.data.labels = [];
						optionsCPU.data.datasets[0].data = [];

						optionsMemory.data.labels = [];
						optionsMemory.data.datasets[0].data = [];

						optionsDisk.data.labels = [];
						optionsDisk.data.datasets[0].data = [];

						optionsNetwork.data.labels = [];
						optionsNetwork.data.datasets[0].data = [];

						if (hostPerf == null || hostPerf == '') {
							$(".monitoring-chart-empty").show();
							$(".monitoring-chart-body>canvas").hide();

						} else {
							$(".monitoring-chart-empty").hide();
							$(".monitoring-chart-body>canvas").show();
							
							setTime = setTimeSetting(dateChk);
							
							optionsCPU.options.scales.xAxes[0].time.unit = setTime[0];
							optionsCPU.options.scales.xAxes[0].time.unitStepSize = setTime[1];

							optionsMemory.options.scales.xAxes[0].time.unit = setTime[0];
							optionsMemory.options.scales.xAxes[0].time.unitStepSize = setTime[1];

							optionsDisk.options.scales.xAxes[0].time.unit = setTime[0];
							optionsDisk.options.scales.xAxes[0].time.unitStepSize = setTime[1];

							optionsNetwork.options.scales.xAxes[0].time.unit = setTime[0];
							optionsNetwork.options.scales.xAxes[0].time.unitStepSize = setTime[1];

							for (key in hostPerf) {
								nowDate = new Date(hostPerf[key].timestamp)
								optionsCPU.data.labels[key] = nowDate;
								optionsCPU.data.datasets[0].data[key] = hostPerf[key].cpu;

								optionsMemory.data.labels[key] = nowDate;
								optionsMemory.data.datasets[0].data[key] = hostPerf[key].memory;

								optionsDisk.data.labels[key] = nowDate;
								optionsDisk.data.datasets[0].data[key] = hostPerf[key].disk;

								optionsNetwork.data.labels[key] = nowDate;
								optionsNetwork.data.datasets[0].data[key] = hostPerf[key].network;
							}

						}

						cpulineChart.update();
						memorylineChart.update();
						disklineChart.update();
						networklineChart.update();
					}
				})

			}
			
			function getClusterTotalPerfOfHosts() {

				
				var dateChk = 0;
				var clusterID = $("#defaultClusterSB option:selected").val();
				var useGraphValue = $("#hostUseGraphTimeChoice option:selected").val();
				
				$.ajax({
					data : {
						clusterID : clusterID
					},
					url : "/perf/getClusterTotalPerfOfHosts.do",
					success : function(data) {
						var html = '';
						var head = '';
						
						head += '<th>호스트 수</th>';
						head += '<th>가상머신 수</th>';
						head += '<th>Core/Thread</th>';
						head += '<th>Memory</th>';
						$("#topHosthead").empty();
						$("#topHosthead").append(head);

						html += '<tr>';

						html += '<td>' + data['countHosts'] + '</td>';
						
						html += '<td>' + data['countVMs'] + '</td>';
						
						html += '<td>' + data['sumCPU'] + "/" + data['sumThread'] + '</td>';
						
						html += '<td>' + data['sumMemory'] + 'GB</td>';

						html += '</tr>';

						$("#hostInfoList").empty();
						$("#hostInfoList").append(html);
						
						dateChk = setDateCheck(useGraphValue);
						getClusterTotalPerfGraphOfHosts(dateChk);
					}
				})
			}
			
			function getPerfHost(dateChk) {
				var setTime = new Array();
				
				var hostID = $("#defaultHostSB option:selected").val();

				$.ajax({
					data : {
						id : hostID,
						dateChk : dateChk
					},
					url : "/jquery/getPerfHost.do",
					success : function(hostPerf) {
						optionsCPU.data.labels = [];
						optionsCPU.data.datasets[0].data = [];

						optionsMemory.data.labels = [];
						optionsMemory.data.datasets[0].data = [];

						optionsDisk.data.labels = [];
						optionsDisk.data.datasets[0].data = [];

						optionsNetwork.data.labels = [];
						optionsNetwork.data.datasets[0].data = [];

						if (hostPerf == null || hostPerf == '') {
							$(".monitoring-chart-empty").show();
							$(".monitoring-chart-body>canvas").hide();

						} else {
							$(".monitoring-chart-empty").hide();
							$(".monitoring-chart-body>canvas").show();
							
							setTime = setTimeSetting(dateChk);

							optionsCPU.options.scales.xAxes[0].time.unit = setTime[0];
							optionsCPU.options.scales.xAxes[0].time.unitStepSize = setTime[1];

							optionsMemory.options.scales.xAxes[0].time.unit = setTime[0];
							optionsMemory.options.scales.xAxes[0].time.unitStepSize = setTime[1];

							optionsDisk.options.scales.xAxes[0].time.unit = setTime[0];
							optionsDisk.options.scales.xAxes[0].time.unitStepSize = setTime[1];

							optionsNetwork.options.scales.xAxes[0].time.unit = setTime[0];
							optionsNetwork.options.scales.xAxes[0].time.unitStepSize = setTime[1];
							
							for (key in hostPerf) {
								nowDate = new Date(hostPerf[key].timestamp)
								optionsCPU.data.labels[key] = nowDate;
								optionsCPU.data.datasets[0].data[key] = hostPerf[key].cpu;

								optionsMemory.data.labels[key] = nowDate;
								optionsMemory.data.datasets[0].data[key] = hostPerf[key].memory;

								optionsDisk.data.labels[key] = nowDate;
								optionsDisk.data.datasets[0].data[key] = hostPerf[key].disk;

								optionsNetwork.data.labels[key] = nowDate;
								optionsNetwork.data.datasets[0].data[key] = hostPerf[key].network;
							}

						}

						cpulineChart.update();
						memorylineChart.update();
						disklineChart.update();
						networklineChart.update();
					}
				})
			}

			function getHostInfo() {

				var hostID = $("#defaultHostSB option:selected").val();
				var hostUseGraphTimeChoice = $("#hostUseGraphTimeChoice option:selected").val();
				

				$.ajax({

					data : {
						vm_HID : hostID
					},
					url : "/jquery/getHostinfoDetail.do",
					success : function(data) {
						var html = '';
						var head = '';
						
						head += '<th>CPU 모델</th>';
						head += '<th>Core/Thread</th>';
						head += '<th>Memory</th>'
						head += '<th>Disk</th>';
						head += '<th>ESXi</th>';
						head += '<th>가상머신 수</th>';
						head += '<th>총 할당 vCPU</th>';
						head += '<th>총 할당 Memory</th>';
						head += '<th>Uptime</th>';
						head += '<th>모델명</th>';

						$("#topHosthead").empty();
						$("#topHosthead").append(head);

						html += '<tr>';
						html += '<td>' + data.host_cpu_model + '</td>';
						html += '<td>' + data.vm_Hcpu + "/" + data.host_thread + '</td>';
						html += '<td>' + data.vm_Hmemory + 'GB</td>';
						html += '<td> - </td>';
						html += '<td>' + data.vm_Hver_bu + '</td>';
						html += '<td>' + parseInt(data.vm_HvmCount) + '</td>';
						html += '<td>' + data.sumCPU + '</td>';
						html += '<td>' + data.sumMemory + 'GB</td>';
						html += '<td>' + data.vm_Huptime + '일</td>';
						html += '<td>' + data.host_model + '</td>';
						html += '</tr>';

						$("#hostInfoList").empty();
						$("#hostInfoList").append(html);

						dateChk = setDateCheck(hostUseGraphTimeChoice);
						
						getPerfHost(dateChk);

					}
				})
			}
		</script>
	</body>
</html>