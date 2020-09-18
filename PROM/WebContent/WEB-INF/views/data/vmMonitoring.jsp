<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/external_JS/Chart.bundle.min.js"></script>
	</head>
	<body>
		<div class="card bg-dark mb-0 table-type-2 table-type-3 border-bottom-dark">
			<div class="table-filter-dark">
				<div class="col-xl-3 col-sm-2">
					<select class="form-control select-search" id="tenantSelcetBox" data-fouc></select>
				</div>
				<div class="col-xl-3 col-sm-2">
					<select class="form-control select-search" id="tenantInServiceSelcetBox" onchange="serviceInVMs()" data-fouc></select>
				</div>
				<div class="col-xl-4 col-sm-4 width-100">
					<select class="form-control select-search" id="serviceVMList" onchange="dataOptions()" data-fouc></select>
				</div>
	
				<div class="col-xl-1 col-sm-2">
					<select class="form-control select" id="useGraphTimeChoice" data-fouc>
						<option value="Realtime">실시간</option>
						<option value="oneDay">하루</option>
						<option value="oneWeek">일주일</option>
					</select>
				</div>
				<div class="col-xl-1 col-sm-2">
					<form action="/jquery/perfVMExport.do" id="perfVMExportForm">
						<input type="hidden" name="perfVMID">
						<input type="hidden" name="perfTenants">
						<input type="hidden" name="perfServiceName">
						<input type="hidden" name="perfServiceId">
						<input type="hidden" name="perfVMdate">
						<button type="submit" class="btn bg-prom col-md-12"><i class="icon-import"></i><span class="ml-2">내보내기</span></button>
					</form>
				</div>
			</div>
			<div class="datatables-body">
				<table class="promTable hover" style="width:100%;">
					<thead>
						<tr id="topVMhead">
						</tr>
					</thead>
					<tbody id="vmInfoList"></tbody>
				</table>
			</div>
		</div>
		
		<div class="card mb-0 bg-dark table-type-4">
			<div class="row-padding-0">
				<div class="col-sm-6 col-xl-6 padding-0 border-bottom-light">
					<div class="card bg-dark mb-0 table-type-1">
						<div class="table-title-light">
							<h6 class="card-title mb-0">vCPU 사용량 (%)</h6>
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
			var global_vm_ID = '';
			var global_getParameter = '${vmActiveName}';
			var realval = '';
			$(function() {
				
				window.onkeydown = function() {
					var kcode = event.keyCode;
					if (kcode == 116) {
						history.replaceState({}, null, location.pathname);
					}
				}
	
				if (sessionApproval > ADMINCHECK) {
					getTenantList();
				} else if (sessionApproval < ADMINCHECK) {
					getUserTenantList();
				}
	
				$("#tenantSelcetBox").change(function() {
					serviceInTenant();
				})
	
				$("#perfVMExportForm").submit(function(event) {
					var serviceName = $("#tenantInServiceSelcetBox > option:selected").attr("value2");
					var serviceId = $("#tenantInServiceSelcetBox option:selected").val();
					var tenantName = $("#tenantSelcetBox > option:selected").attr("value2");
					var vmUseGraphTimeChoice = $("#useGraphTimeChoice").val();
					var vmID = $("#serviceVMList option:selected").val();
					$("input[name=perfVMID]").val(vmID);
					$("input[name=perfTenants]").val(tenantName);
					$("input[name=perfServiceName]").val(serviceName);
					$("input[name=perfServiceId]").val(serviceId);
					$("input[name=perfVMdate]").val(vmUseGraphTimeChoice);
				});
				
				$('#useGraphTimeChoice').change(function() {
					var useGraphValue = $("#useGraphTimeChoice option:selected").val();
					var setVM = $("#serviceVMList option:selected").val();
					var dateChk = 0;

					if (useGraphValue == 'Realtime') {
						dateChk = 0;
						realTimeAction(true);
					} else if (useGraphValue == 'oneDay') {
						dateChk = 1;
						realTimeAction(false);
					} else if (useGraphValue == 'oneWeek') {
						dateChk = 2;
						realTimeAction(false);
					}
						
						if (setVM == 'serviceAll') {
							getServicePerfGraphOfVMs(dateChk);
						} else {
							getPerfVM(dateChk);
						}
					
				})
				
				
				if (global_getParameter != '') {
					setTimeout(function() {
						getPerfVM(0);
					}, 700)

				} else {
					setTimeout(function() {
						getServicePerfGraphOfVMs(0);
					}, 700)

				}

				realTimeAction(true);

			});

			function getUserTenantList() {
				$.ajax({
					url : "/tenant/selectLoginUserTenantList.do",
					success : function(data) {
						var html = '';
						for (key in data) {
							html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
						}
						$("#tenantSelcetBox").empty();
						$("#tenantSelcetBox").append(html);
						serviceInTenant();
					}
				})
			}

			function getTenantList() {

				var getTenants = '${ten}';

				$.ajax({
					url : "/tenant/selectTenantList.do",
					success : function(data) {
						var html = '';
						for (key in data) {
							if (getTenants == data[key].id) {
								html += '<option value=' + data[key].id + ' value2=' + data[key].name + ' selected>' + data[key].name + '</option>';
							} else {
								html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
							}
						}
						if (getTenants == 'De') {
							html += '<option value="-1" value2="미배치" selected>미배치 가상머신</option>';
						} else {
							html += '<option value="-1" value2="미배치">미배치 가상머신</option>';
						}
						$("#tenantSelcetBox").empty();
						$("#tenantSelcetBox").append(html);
						serviceInTenant();
					}
				})
			}

			function serviceInTenant() {

				var getService = '${se}';
				var tenantsID = $("#tenantSelcetBox option:selected").val();
				$.ajax({
					data : {
						tenantId : tenantsID
					},
					url : "/tenant/selectVMServiceListByTenantId.do",
					success : function(data) {
						var html = '';
						if (data == null || data == '') {
							html += '<option value="0" value2="서비스없음" selected>서비스 미배치</option>';
						} else {
							for (key in data) {
								if (getService == data[key].vmServiceID) {
									html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].vmServiceName + ' selected>' + data[key].vmServiceName + '</option>';
								} else {
									html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].vmServiceName + '>' + data[key].vmServiceName + '</option>';
								}
							}
						}
						$("#tenantInServiceSelcetBox").empty();
						$("#tenantInServiceSelcetBox").append(html);
						serviceInVMs();
					}
				})
			}

			function serviceInVMs() {
				var tenantsID = $("#tenantSelcetBox option:selected").val();
				var tenantsName = $("#tenantSelcetBox option:selected").attr("value2");
				var serviceID = $("#tenantInServiceSelcetBox option:selected").val();
				var serviceName = $("#tenantInServiceSelcetBox option:selected").attr("value2");
				
				$.ajax({
					data : {
						tenantsID : tenantsID,
						serviceID : serviceID
					},
					url : "/jquery/tenantsInServiceVMs.do",
					success : function(data) {
						var html = '';
						if (data == null || data == '') {
							html += '<option value="0" disabled selected>:: 가상머신이 없습니다. ::</option>';
						} else {
							if (tenantsID > -1) {
								html += '<option value="serviceAll">서비스 전체</option>';
							}
							for (key in data) {
								if (data[key].vm_ID != '${vmActiveName}') {
									if (data[key].vm_status == 'poweredOn') {
										html += '<option value=' + data[key].vm_ID + '>' + data[key].vm_name + ' (ON)</option>';
									} else if (data[key].vm_status == 'poweredOff') {
										html += '<option value=' + data[key].vm_ID + '>' + data[key].vm_name + ' (OFF)</option>';
									}
								} else {
									if (data[key].vm_status == 'poweredOn') {
										html += '<option value=' + data[key].vm_ID + ' selected>' + data[key].vm_name + ' (ON)</option>';
									} else if (data[key].vm_status == 'poweredOff') {
										html += '<option value=' + data[key].vm_ID + ' selected>' + data[key].vm_name + ' (OFF)</option>';
									}
								}
							}
						}
						$("#serviceVMList").empty();
						$("#serviceVMList").append(html);
						dataOptions();
					}
				})
			}

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
						backgroundColor : '#fff',
						displayColors : false,
						titleFontColor : '#000',
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
								unit : 'minute',
								displayFormats : {
									'day' : 'YYYY-MM-DD',
									'hour' : 'DD-HH:mm:ss',
									'minute' : 'HH:mm:ss'
								},
								unitStepSize : 5,
							},
							ticks : {
								autoSkip : true,
								maxTicksLimit : 30
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
							},
							scaleLabel : {
								display : true
							},
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
						backgroundColor : '#fff',
						displayColors : false,
						titleFontColor : '#000',
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
							//autoSkip: false,
							time : {
								//parser: 'YYYY-MM-DD HH:mm',
								//tooltipFormat: 'll HH:mm',
								displayFormats : {
									'day' : 'YYYY-MM-DD',
									'hour' : 'DD-HH:mm:ss',
									'minute' : 'HH:mm:ss'
								},
								unit : '',
								unitStepSize : 0,
							//stepSize : 3
							},
						/* scaleLabel: {
						      display: true
						       }, */
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
							//autoSkip: false,
							time : {
								//parser: 'YYYY-MM-DD HH:mm',
								//tooltipFormat: 'll HH:mm',
								displayFormats : {
									'day' : 'YYYY-MM-DD',
									'hour' : 'DD-HH:mm:ss',
									'minute' : 'HH:mm:ss'
								},
								unit : '',
								unitStepSize : 0,
							//stepSize : 3
							},
						/* scaleLabel: {
						      display: true
						       }, */
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
						backgroundColor : '#fff',
						displayColors : false,
						titleFontColor : '#000',
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
							//autoSkip: false,
							time : {
								//parser: 'YYYY-MM-DD HH:mm',
								//tooltipFormat: 'll HH:mm',
								displayFormats : {
									'day' : 'YYYY-MM-DD',
									'hour' : 'DD-HH:mm:ss',
									'minute' : 'HH:mm:ss'
								},
								unit : '',
								unitStepSize : 0,
							//stepSize : 3
							},
						/* scaleLabel: {
						      display: true
						       }, */
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

			var realTimeAction = function(bool) {

				var dateChk = 0;
				var useGraphValue = $("#useGraphTimeChoice option:selected").val();

				if (useGraphValue == 'Realtime') {
					dateChk = 0;
				} else if (useGraphValue == 'oneDay') {
					dateChk = 1;
				} else if (useGraphValue == 'oneWeek') {
					dateChk = 2;
				}

				if (bool) {

					realval = setTimeout(function() {
						var setVM = $("#serviceVMList option:selected").val();
						var dateChk = 0;

						realTimeAction(bool);
						if (dateChk == 0) {
							if (setVM == 'serviceAll') {
								getServicePerfGraphOfVMs(dateChk);
							} else {
								getPerfVM(dateChk);
							}
						} else {
							clearTimeout(realval);
						}
					}, 5000)
				} else {
					clearTimeout(realval);
				}
			}

			function getPerfVM(dateChk) {

				var targetVM = $("#serviceVMList option:selected").val();

				$.ajax({
					data : {
						id : targetVM,
						dateChk : dateChk
					},
					url : "/jquery/getPerfVM.do",
					success : function(vmPerf) {

						var setDay = "day";
						var setHour = "hour";
						var setMinute = "minute";
						var nowDate = null;

						var beginString = 0;
						var endString = 0;
						optionsCPU.data.labels = [];
						optionsCPU.data.datasets[0].data = [];
						optionsCPU.options.scales.xAxes[0].time.unit = ''
						optionsCPU.options.scales.xAxes[0].time.unitStepSize = 0;

						optionsMemory.data.labels = [];
						optionsMemory.data.datasets[0].data = [];

						optionsDisk.data.labels = [];
						optionsDisk.data.datasets[0].data = [];

						optionsNetwork.data.labels = [];
						optionsNetwork.data.datasets[0].data = [];

						if (vmPerf == null || vmPerf == '') {
							$(".monitoring-chart-empty").show();
							$(".monitoring-chart-body>canvas").hide();

						} else {
							$(".monitoring-chart-empty").hide();
							$(".monitoring-chart-body>canvas").show();

							if (dateChk == 0) {
								optionsCPU.options.scales.xAxes[0].time.unit = setMinute;
								optionsCPU.options.scales.xAxes[0].time.unitStepSize = 5;

								optionsMemory.options.scales.xAxes[0].time.unit = setMinute;
								optionsMemory.options.scales.xAxes[0].time.unitStepSize = 5;

								optionsDisk.options.scales.xAxes[0].time.unit = setMinute;
								optionsDisk.options.scales.xAxes[0].time.unitStepSize = 5;

								optionsNetwork.options.scales.xAxes[0].time.unit = setMinute;
								optionsNetwork.options.scales.xAxes[0].time.unitStepSize = 5;
							} else if (dateChk == 1) {
								optionsCPU.options.scales.xAxes[0].time.unit = setHour;
								optionsCPU.options.scales.xAxes[0].time.unitStepSize = 4;

								optionsMemory.options.scales.xAxes[0].time.unit = setHour;
								optionsMemory.options.scales.xAxes[0].time.unitStepSize = 4;

								optionsDisk.options.scales.xAxes[0].time.unit = setHour;
								optionsDisk.options.scales.xAxes[0].time.unitStepSize = 4;

								optionsNetwork.options.scales.xAxes[0].time.unit = setHour;
								optionsNetwork.options.scales.xAxes[0].time.unitStepSize = 4;
							} else if (dateChk == 2) {
								optionsCPU.options.scales.xAxes[0].time.unit = setDay;
								optionsCPU.options.scales.xAxes[0].time.unitStepSize = 1;

								optionsMemory.options.scales.xAxes[0].time.unit = setDay;
								optionsMemory.options.scales.xAxes[0].time.unitStepSize = 1;

								optionsDisk.options.scales.xAxes[0].time.unit = setDay;
								optionsDisk.options.scales.xAxes[0].time.unitStepSize = 1;

								optionsNetwork.options.scales.xAxes[0].time.unit = setDay;
								optionsNetwork.options.scales.xAxes[0].time.unitStepSize = 1;
							}

							for (key in vmPerf) {
								nowDate = new Date(vmPerf[key].timestamp)
								optionsCPU.data.labels[key] = nowDate;
								optionsCPU.data.datasets[0].data[key] = vmPerf[key].cpu;

								optionsMemory.data.labels[key] = nowDate;
								optionsMemory.data.datasets[0].data[key] = vmPerf[key].memory;

								optionsDisk.data.labels[key] = nowDate;
								optionsDisk.data.datasets[0].data[key] = vmPerf[key].disk;

								optionsNetwork.data.labels[key] = nowDate;
								optionsNetwork.data.datasets[0].data[key] = vmPerf[key].network;
							}

						}

						cpulineChart.update();
						memorylineChart.update();
						disklineChart.update();
						networklineChart.update();
					}
				})
			}

			function getServicePerfGraphOfVMs(dateChk) {

				var serviceID = $("#tenantInServiceSelcetBox option:selected").val();
				var setVM = $("#serviceVMList option:selected").val();
				var realval = '';

				$.ajax({
					data : {
						service_id : serviceID,
						dateChk : dateChk
					},
					url : "/perf/getServicePerfGraphOfVMs.do",
					success : function(vmPerf) {

						var setDay = "day";
						var setHour = "hour";
						var setMinute = "minute";
						var nowDate = null;

						var beginString = 0;
						var endString = 0;
						optionsCPU.data.labels = [];
						optionsCPU.data.datasets[0].data = [];
						optionsCPU.options.scales.xAxes[0].time.unit = ''
						optionsCPU.options.scales.xAxes[0].time.unitStepSize = 0;

						optionsMemory.data.labels = [];
						optionsMemory.data.datasets[0].data = [];

						optionsDisk.data.labels = [];
						optionsDisk.data.datasets[0].data = [];

						optionsNetwork.data.labels = [];
						optionsNetwork.data.datasets[0].data = [];

						if (vmPerf == null || vmPerf == '') {
							$(".monitoring-chart-empty").show();
							$(".monitoring-chart-body>canvas").hide();

						} else {
							$(".monitoring-chart-empty").hide();
							$(".monitoring-chart-body>canvas").show();

							if (dateChk == 0) {
								optionsCPU.options.scales.xAxes[0].time.unit = setMinute;
								optionsCPU.options.scales.xAxes[0].time.unitStepSize = 5;

								optionsMemory.options.scales.xAxes[0].time.unit = setMinute;
								optionsMemory.options.scales.xAxes[0].time.unitStepSize = 5;

								optionsDisk.options.scales.xAxes[0].time.unit = setMinute;
								optionsDisk.options.scales.xAxes[0].time.unitStepSize = 5;

								optionsNetwork.options.scales.xAxes[0].time.unit = setMinute;
								optionsNetwork.options.scales.xAxes[0].time.unitStepSize = 5;
							} else if (dateChk == 1) {
								optionsCPU.options.scales.xAxes[0].time.unit = setHour;
								optionsCPU.options.scales.xAxes[0].time.unitStepSize = 4;

								optionsMemory.options.scales.xAxes[0].time.unit = setHour;
								optionsMemory.options.scales.xAxes[0].time.unitStepSize = 4;

								optionsDisk.options.scales.xAxes[0].time.unit = setHour;
								optionsDisk.options.scales.xAxes[0].time.unitStepSize = 4;

								optionsNetwork.options.scales.xAxes[0].time.unit = setHour;
								optionsNetwork.options.scales.xAxes[0].time.unitStepSize = 4;
							} else if (dateChk == 2) {
								optionsCPU.options.scales.xAxes[0].time.unit = setDay;
								optionsCPU.options.scales.xAxes[0].time.unitStepSize = 1;

								optionsMemory.options.scales.xAxes[0].time.unit = setDay;
								optionsMemory.options.scales.xAxes[0].time.unitStepSize = 1;

								optionsDisk.options.scales.xAxes[0].time.unit = setDay;
								optionsDisk.options.scales.xAxes[0].time.unitStepSize = 1;

								optionsNetwork.options.scales.xAxes[0].time.unit = setDay;
								optionsNetwork.options.scales.xAxes[0].time.unitStepSize = 1;
							}

							for (key in vmPerf) {
								nowDate = new Date(vmPerf[key].timestamp)
								optionsCPU.data.labels[key] = nowDate;
								optionsCPU.data.datasets[0].data[key] = vmPerf[key].cpu;

								optionsMemory.data.labels[key] = nowDate;
								optionsMemory.data.datasets[0].data[key] = vmPerf[key].memory;

								optionsDisk.data.labels[key] = nowDate;
								optionsDisk.data.datasets[0].data[key] = vmPerf[key].disk;

								optionsNetwork.data.labels[key] = nowDate;
								optionsNetwork.data.datasets[0].data[key] = vmPerf[key].network;
							}

						}

						cpulineChart.update();
						memorylineChart.update();
						disklineChart.update();
						networklineChart.update();

					}
				})

			}

			function dataOptions() {

				var setVM = $("#serviceVMList option:selected").val();

				if (setVM == 'serviceAll') {
					getServiceTotalPerfOfVMs();
				} else {
					getVMInfo();
				}

			}

			function getServiceTotalPerfOfVMs() {

				var html = '';
				var head = '';
				var serviceID = $("#tenantInServiceSelcetBox option:selected").val();

				$.ajax({
					data : {
						service_id : serviceID
					},
					url : "/perf/getServiceTotalPerfOfVMs.do",
					success : function(data) {

						head += '<th>가상머신 수</th>';
						head += '<th>총 vCPU</th>';
						head += '<th>총 Memory</th>'
						head += '<th>총 Disk</th>';

						$("#topVMhead").empty();
						$("#topVMhead").append(head);

						html += '<tr>';

						html += '<td>' + data['countVMs'] + '</td>';

						html += '<td>' + data['sumCPU'] + '</td>';

						html += '<td>' + data['sumMemory'] + 'GB</td>';

						html += '<td>' + data['sumDisk'] + 'GB</td>';

						html += '</tr>';

						$("#vmInfoList").empty();
						$("#vmInfoList").append(html);

						var useGraphValue = $("#useGraphTimeChoice option:selected").val();
						if (useGraphValue == 'Realtime') {
							getServicePerfGraphOfVMs(0);
						} else if (useGraphValue == 'oneDay') {
							getServicePerfGraphOfVMs(1);
						} else if (useGraphValue == 'oneWeek') {
							getServicePerfGraphOfVMs(2);
						}
					}
				})
			}

			function getVMInfo() {

				var html = '';
				var head = '';
				var targetVM = $("#serviceVMList option:selected").val();
				$.ajax({
					data : {
						vm_ID : targetVM
					},
					url : "/jquery/getVMInfo.do",
					success : function(data) {
						var totalIp = '';

						head += '<th>vCPU</th>';
						head += '<th>Memory</th>';
						head += '<th>총 Disk</th>'
						head += '<th>IP 주소</th>';
						head += '<th>OS명</th>';

						$("#topVMhead").empty();
						$("#topVMhead").append(head);

						if (data.vm_ipaddr1 != null && data.vm_ipaddr1 != '') {
							totalIp += ', ' + data.vm_ipaddr1;
						}
						if (data.vm_ipaddr2 != null && data.vm_ipaddr2 != '') {
							totalIp += ', ' + data.vm_ipaddr2;
						}
						if (data.vm_ipaddr3 != null && data.vm_ipaddr3 != '') {
							totalIp += ', ' + data.vm_ipaddr3;
						}

						if (totalIp.startsWith(',')) {
							totalIp = totalIp.substr(1);
						}

						html += '<tr>';
						if (data.vm_cpu == null) {
							html += '<td class="text-muted">없음</td>';
						} else {
							html += '<td>' + data.vm_cpu + '</td>';
						}
						if (data.vm_memory == null) {
							html += '<td class="text-muted">없음</td>';
						} else {
							html += '<td>' + data.vm_memory + 'GB</td>';
						}
						if (data.vm_disk == null) {
							html += '<td class="text-muted">없음</td>';
						} else {
							html += '<td>' + data.vm_disk + 'GB</td>';
						}
						if (totalIp == '') {
							html += '<td class="text-muted">없음</td>';
						} else {
							html += '<td>' + totalIp + '</td>';
						}
						if (data.vm_OS == null) {
							html += '<td class="text-muted">없음</td>';
						} else {
							html += '<td>' + data.vm_OS + '</td>';
						}
						html += '</tr>';

						$("#vmInfoList").empty();
						$("#vmInfoList").append(html);

						var useGraphValue = $("#useGraphTimeChoice").val();
						if (useGraphValue == 'Realtime') {
							getPerfVM(0);
						} else if (useGraphValue == 'oneDay') {
							getPerfVM(1);
						} else if (useGraphValue == 'oneWeek') {
							getPerfVM(2);
						}
					}
				})
			}
		</script>
	</body>
</html>