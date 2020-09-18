<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<script src="${path}/resources/PROM_JS/refreshGetParaDelete.js"></script>

	<script type="text/javascript">
		var global_now = new Date();
		var category = '${ca}';
		var parent = '${pa}';
		var child = '${ch}';
		var vn = '${vn}';
		var dateTime = '${dt}';

		$(document).ready(function() {
			$("#dataloading").show();
			var vmUsageTable = $('#vmUsageTable').addClass("nowrap").DataTable({
				dom: "<'datatables-header'<'row-padding-0'lf>>" + "<'datatables-body'rt>" + "<'datatables-footer'ip>"
			});

			if (sessionApproval > ADMINCHECK) {
				if (category == 'clusterChoiceAll') {
					getClusterInfo();
					$('#subPickSelectBox').val('clusterChoiceAll').trigger('change');
				} else if (category == 'tenantsChoiceAll') {
					getTenantAll();
					$('#subPickSelectBox').val('tenantsChoiceAll').trigger('change');
				} else {
					getClusterInfo();
					$('#subPickSelectBox option[value=clusterChoiceAll]').attr('selected', 'selected');
				}

			} else if (sessionApproval < ADMINCHECK) {
				getUserTenant();
				$('select[id=subPickSelectBox]').val('tenantsChoiceAll');
			}

			$("#vmUsageStartDatetime").val(global_now.getFullYear() + "-" + leadingZeros(global_now.getMonth() + 1, 2) + "-" + leadingZeros(global_now.getDate(), 2));

			$("#vmUsageEndDatetime").val(global_now.getFullYear() + "-" + leadingZeros(global_now.getMonth() + 1, 2) + "-" + leadingZeros(global_now.getDate(), 2));
			$("#vmUsageEndTime").val(leadingZeros(global_now.getHours(), 2) + ":" + leadingZeros(global_now.getMinutes(), 2));

			if (dateTime == null || dateTime == '') {
				setTimeout(function() {
					getCommonGraph();
				}, 700);

			} else if (dateTime != null || dateTime != '') {
				var getDatetimeSet = new Date(parseInt(dateTime));

				$("#vmUsageStartDatetime").val(getDatetimeSet.getFullYear() + "-" + leadingZeros(getDatetimeSet.getMonth() + 1, 2) + "-" + leadingZeros(getDatetimeSet.getDate(), 2))
				$("#vmUsageStartTime").val(leadingZeros(getDatetimeSet.getHours() - 1, 2) + ":" + leadingZeros(getDatetimeSet.getMinutes(), 2));
				$("#vmUsageEndDatetime").val(getDatetimeSet.getFullYear() + "-" + leadingZeros(getDatetimeSet.getMonth() + 1, 2) + "-" + leadingZeros(getDatetimeSet.getDate(), 2))
				$("#vmUsageEndTime").val(leadingZeros(getDatetimeSet.getHours() + 1, 2) + ":" + leadingZeros(getDatetimeSet.getMinutes(), 2));

				setTimeout(function() {
					getCommonGraph();
				}, 700);
			}

			$("#timesetSB").change(function() {
				if ($("#timesetSB").val() == '4'){
					$("#vmUsageStartDatetime").val(global_now.getFullYear() + "-" + leadingZeros(global_now.getMonth() + 1, 2) + "-" + leadingZeros(global_now.getDate()-1, 2));
					$("#vmUsageEndDatetime").val(global_now.getFullYear() + "-" + leadingZeros(global_now.getMonth() + 1, 2) + "-" + leadingZeros(global_now.getDate()-1, 2));
				}else{
					$("#vmUsageStartDatetime").val(global_now.getFullYear() + "-" + leadingZeros(global_now.getMonth() + 1, 2) + "-" + leadingZeros(global_now.getDate(), 2));
					$("#vmUsageEndDatetime").val(global_now.getFullYear() + "-" + leadingZeros(global_now.getMonth() + 1, 2) + "-" + leadingZeros(global_now.getDate(), 2));
				}

				if ($("#timesetSB").val() == '0' || $("#timesetSB").val() == '1' || $("#timesetSB").val() == '2') {
					$("#startdayDiv, #enddayDiv").addClass("col-xl-2 col-sm-2");
					$("#startdayDiv, #enddayDiv").removeClass("col-xl-4 col-sm-4");
					$("#starttimeDiv, #endtimeDiv").show();
					$("#starttimeDiv, #endtimeDiv").show();

				} else {
					$("#startdayDiv, #enddayDiv").addClass("col-xl-4 col-sm-4");
					$("#startdayDiv, #enddayDiv").removeClass("col-xl-2 col-sm-2");
					$("#starttimeDiv, #endtimeDiv").hide();
					$("#starttimeDiv, #endtimeDiv").hide();
				}
			});

			$("#subPickSelectBox").change(function() {
				if ($("#subPickSelectBox").val() == 'clusterChoiceAll') {
					$("#subPickChildofChildofChild").show();
					getClusterInfo();
				}

				if ($("#subPickSelectBox").val() == 'tenantsChoiceAll') {
					$("#subPickChildofChildofChild").show();
					getTenantAll();
				}
			});

			$(document).on('change', '#childSB', function() {
				var choiceValue = $("#childSB option:selected").val();

				if (isNaN(choiceValue) == true) {
					getClusterinHostInfo();
				} else {
					getTenantsInServiceList();
				}
			})

			$(document).on('change', '#childOfChildSB', function() {
				var choiceValue = $("#childOfChildSB option:selected").val();

				if (isNaN(choiceValue) == true) {
					getClusterinHostInfoinVM();

				} else {
					getTenantsInServiceOfVMs();
				}

			})
		})

		function getUserTenant() {

			$.ajax({

				url: "/tenant/selectLoginUserTenantList.do",
				success: function(data) {
					var html = '';
					for (key in data) {
						html += '<option value=' + data[key].id + '>' + data[key].name + '</option>';
					}

					$("#childSB").empty();
					$("#childSB").append(html);
					getTenantsInServiceList();
				}
			})
		}

		function getTenantAll() {

			$.ajax({

				url: "/tenant/selectTenantList.do",
				success: function(data) {
					var html = '';
					html += '<option value="0">테넌트 전체</option>';
					for (key in data) {
						if (category == 'tenantsChoiceAll' && parent == data[key].id) {
							html += '<option value=' + data[key].id + ' selected>' + data[key].name + '</option>';
						} else {
							html += '<option value=' + data[key].id + '>' + data[key].name + '</option>';
						}
					}

					$("#childSB").empty();
					$("#childSB").append(html);
					getTenantsInServiceList();
				}
			})
		}

		function getTenantsInServiceList() {

			var tenantsID = $("#childSB option:selected").val();

			$.ajax({

				url: "/tenant/selectVMServiceListByTenantId.do",
				data: {
					tenantId: tenantsID
				},
				success: function(data) {
					var html = '';

					if (data == null || data == '') {
						html += '<option value="" selected disabled>:: 해당 서비스가 없습니다. ::</option>';
					} else {
						html += '<option value="">서비스 전체</option>';
						for (key in data) {
							if (category == 'tenantsChoiceAll' && child == data[key].vmServiceID) {
								html += '<option value=' + data[key].vmServiceID + ' selected>' + data[key].vmServiceName + '</option>';
							} else {
								html += '<option value=' + data[key].vmServiceID + '>' + data[key].vmServiceName + '</option>';
							}
						}

					}

					$("#childOfChildSB").empty();
					$("#childOfChildSB").append(html);
					getTenantsInServiceOfVMs();
				}
			})
		}

		function getTenantsInServiceOfVMs() {

			var tenantsID = $("#childSB option:selected").val();
			var serviceID = $("#childOfChildSB option:selected").val();

			$.ajax({
				data: {
					tenantsID: tenantsID,
					serviceID: serviceID
				},
				url: "/jquery/getTenantsInServiceOfVMs.do",
				success: function(data) {
					var html = '';
					if (data == '' || data == null) {
						html += '<option value="" selected disabled>:: 해당 가상머신이 없습니다. ::</option>';
					} else {
						html += '<option value="0" value2="0">가상머신 전체</option>';
						for (key in data) {

							if (data[key].vm_status == 'poweredOn') {
								if (vn != null && vn == data[key].vm_ID) {
									html += '<option value=' + data[key].vm_name + ' value2=' + data[key].vm_ID + '  selected>' + data[key].vm_name + ' (ON)</option>';
								} else {
									html += '<option value=' + data[key].vm_name + ' value2=' + data[key].vm_ID + ' >' + data[key].vm_name + ' (ON)</option>';
								}
							} else if (data[key].vm_status == 'poweredOff') {
								if (vn != null && vn == data[key].vm_ID) {
									html += '<option value=' + data[key].vm_name + ' value2=' + data[key].vm_ID + '  selected>' + data[key].vm_name + ' (OFF)</option>';
								} else {
									html += '<option value=' + data[key].vm_name + ' value2=' + data[key].vm_ID + ' >' + data[key].vm_name + ' (OFF)</option>';
								}
							}

						}
					}

					$("#childOfChildOfChildSB").empty();
					$("#childOfChildOfChildSB").append(html);
				}
			})
		}

		function getCommonGraph() {

			var category = $("#subPickSelectBox option:selected").val();

			var hostName = $("#childOfChildSB").val();
			var clusterName = $("#childSB").val();
			var vmID = $("#childOfChildOfChildSB option:selected").attr("value2");

			var commonC = $("#childSB option:selected").text();
			var commonCC = $("#childOfChildSB option:selected").text();
			var commonCCC = $("#childOfChildOfChildSB option:selected").text();

			var vmUsageStartDatetime = $("#vmUsageStartDatetime").val();
			var vmUsageEndDatetime = $("#vmUsageEndDatetime").val();
			var timesetSB = $("#timesetSB option:selected").val();
			var timesetSBText = $("#timesetSB option:selected").text();

			var startTime = $("#vmUsageStartTime").val();
			var endTime = $("#vmUsageEndTime").val();
			var maxDateindex;

			var cpuArr = new Array();
			var memoryArr = new Array();
			var networkArr = new Array();
			var diskArr = new Array();
			var dateArr = new Array();

			if (timesetSBText == '20초') {
				maxDateindex = '3일'
			} else if (timesetSBText == '5분') {
				maxDateindex = '7일'
			} else if (timesetSBText == '30분') {
				maxDateindex = '30일'
			} else if (timesetSBText == '2시간') {
				maxDateindex = '365일'
			} else if (timesetSBText == '24시간') {
				maxDateindex = '무제한'
			} else {
				maxDateindex = "empty";
			}

			$.ajax({

				data: {
					category: category,
					timeset: timesetSB,
					vmID: vmID,
					hostName: hostName,
					clusterName: clusterName,
					usageStartTime: vmUsageStartDatetime,
					usageEndTime: vmUsageEndDatetime,
					startTime: startTime,
					endTime: endTime
				},
				url: "/jquery/getPerfstatistics.do",
				success: function(data) {
					$("#dataloading").hide();

					var html = '';
					if (data.length == 1 && data.timeExcess == 1) {
						alert(timesetSBText + ' 데이터 통계의 최대 검색 기간은 ' + maxDateindex + '까지 입니다.\n검색 기간을 다시 지정해 주십시오.');

					} else if (data == '' || data === null) {
						alert("데이터가 없습니다.\n가상머신 전원 상태를 확인하십시오.");

					} else {
						statisticslineChart.data.labels = [];
						statisticslineChart.data.datasets[0].data = [];
						statisticslineChart.data.datasets[1].data = [];
						statisticslineChart.data.datasets[2].data = [];
						statisticslineChart.data.datasets[3].data = [];
						for (key in data) {
							if (timesetSB == 0) {
								statisticslineChart.data.labels[key] = getRealTimeStamp(data[key].timestamp);
							} else if (timesetSB == 1) {
								statisticslineChart.data.labels[key] = getRealTimeStamp(data[key].timestamp);
							} else if (timesetSB == 2) {
								statisticslineChart.data.labels[key] = getMonthTimeStamp(data[key].timestamp);
							} else {
								statisticslineChart.data.labels[key] = getTimeStamp(data[key].timestamp);
							}
							statisticslineChart.data.datasets[0].data[key] = data[key].cpu;
							statisticslineChart.data.datasets[1].data[key] = data[key].memory;
							statisticslineChart.data.datasets[2].data[key] = data[key].disk;
							statisticslineChart.data.datasets[3].data[key] = data[key].network;

							cpuArr.push(data[key].cpu);
							memoryArr.push(data[key].memory);
							networkArr.push(data[key].network);
							diskArr.push(data[key].disk);
							dateArr.push(getTimeStamp(data[key].timestamp));
						}

						var vmUsageTable = $('#vmUsageTable').DataTable();
						vmUsageTable.destroy();

						getVMUsageList(category, timesetSB, vmID, hostName, clusterName, vmUsageStartDatetime, vmUsageEndDatetime, startTime, endTime, commonC, commonCC, commonCCC, category);

						$("input[name=category]").val(category);
						$("input[name=cpuArr]").val(cpuArr);
						$("input[name=memArr]").val(memoryArr);
						$("input[name=networkArr]").val(networkArr);
						$("input[name=diskArr]").val(diskArr);
						$("input[name=dateArr]").val(dateArr);
						$("input[name=clusterName]").val(commonC);
						$("input[name=hostName]").val(commonCC);
						$("input[name=vmName]").val(commonCCC);

						statisticslineChart.update();
					}
				}
			})
		}

		function getVMUsageList(category, timesetSB, vmID, hostName, clusterName, vmUsageStartDatetime, vmUsageEndDatetime, startTime, endTime, commonC, commonCC, commonCCC) {

			if (category == "clusterChoiceAll") {
				$("#category1").text("클러스터명");
				$("#category2").text("호스트명");

			} else if (category == "tenantsChoiceAll") {
				$("#category1").text("테넌트명");
				$("#category2").text("서비스명");
			}

			var vmUsageTable = $("#vmUsageTable").addClass("nowrap").DataTable({
				ajax: {
					"url": "/jquery/getPerfstatistics.do",
					"data": {
						category: category,
						timeset: timesetSB,
						vmID: vmID,
						hostName: hostName,
						clusterName: clusterName,
						usageStartTime: vmUsageStartDatetime,
						usageEndTime: vmUsageEndDatetime,
						startTime: startTime,
						endTime: endTime
					},
					"dataSrc": "",
				},
				columns: [{
					"data": "clusterName",
					render: function(data, type, row) {
						data = commonC;
						return data;
					}
				}, {
					"data": "hostName",
					render: function(data, type, row) {
						data = commonCC;
						return data;
					}
				}, {
					"data": "vmName",
					render: function(data, type, row) {
						var vmName = commonCCC.replace(" (ON)", "");
						data = vmName;
						return data;
					}
				}, {
					"data": "cpu",
					render: function(data, type, row) {
						if (data >= 70) {
							data = '<span class="text-warning">' + data + ' %</span>';
						} else {
							data = data + ' %';
						}
						return data;
					}
				}, {
					"data": "memory",
					render: function(data, type, row) {
						if (data >= 70) {
							data = '<span class="text-warning">' + data + ' %</span>';
						} else {
							data = data + ' %';
						}
						return data;
					}
				}, {
					"data": "disk",
					render: function(data, type, row) {
						data = data + ' KB';
						return data;
					}
				}, {
					"data": "network",
					render: function(data, type, row) {
						data = data + ' KB';
						return data;
					}
				}, {
					"data": "timestamp",
					render: function(data, type, row) {
						data = getTimeStamp(data);
						return data;
					}
				}, ],
				order: [
					[7, "asc"]
				],
				lengthMenu: [
					[5, 10, 25, 50, -1],
					[5, 10, 25, 50, "All"]
				],
				pageLength: 5,
				responsive: true,
				dom: "<'datatables-header'<'row-padding-0'lf><'row-padding-0'B>>" + "<'datatables-body'rt>" + "<'datatables-footer'ip>",
				buttons: [{
					extend: "collection",
					text: "<i class='icon-import'></i><span class='ml-2'>내보내기</span>",
					className: "btn bg-prom dropdown-toggle",
					buttons: [{
						extend: "csvHtml5",
						charset: "UTF-8",
						bom: true,
						text: "CSV",
						title: "가상머신 성능 통계",
					}, {
						extend: "excelHtml5",
						text: "Excel",
						title: "가상머신 성능 통계",
					}]
				}]
			});
		}

		function getClusterInfo() {

			$.ajax({

				url: "/tenant/selectClusterList.do",
				success: function(data) {
					var html = '';
					html += '<option value="clusterAll">클러스터 전체</option>';
					for (key in data) {
						if (category == 'clusterChoiceAll' && parent != data[key].clusterID) {
							html += '<option value=' + data[key].clusterName + '>' + data[key].clusterName + '</option>';
						} else {
							html += '<option value=' + data[key].clusterName + ' selected>' + data[key].clusterName + '</option>';
						}
					}

					$("#childSB").empty();
					$("#childSB").append(html);
					getClusterinHostInfo();
				}
			})
		}

		function getClusterinHostInfo() {

			var clusterName = $("#childSB").val();

			$.ajax({
				data: {
					hostParent: clusterName
				},
				url: "/tenant/selectVMHostList.do",
				success: function(data) {
					var html = '';
					if (data == '' || data == null) {
						html += '<option value="" selected disabled>:: 해당 호스트가 없습니다. ::</option>';
					} else {
						html += '<option value="hostAll">호스트 전체</option>';
						for (key in data) {
							if (category == 'clusterChoiceAll' && child != data[key].vmHhostname) {
								html += '<option value=' + data[key].vmHhostname + '>' + data[key].vmHhostname + '</option>';
							} else {
								html += '<option value=' + data[key].vmHhostname + ' selected>' + data[key].vmHhostname + '</option>';
							}
						}
					}

					$("#childOfChildSB").empty();
					$("#childOfChildSB").append(html);
					getClusterinHostInfoinVM();
				}
			})
		}

		function getClusterinHostInfoinVM() {

			var hostName = $("#childOfChildSB").val();

			$.ajax({
				data: {
					hostName: hostName
				},
				url: "/jquery/getClusterinHostInfoinVM.do",
				success: function(data) {
					var html = '';
					if (data == '' || data == null) {
						html += '<option value="" selected disabled>:: 해당 가상머신이 없습니다. ::</option>';
					} else {
						html += '<option value="vmAll" value2="vmAll">가상머신 전체</option>';
						for (key in data) {

							if (data[key].vm_status == 'poweredOn') {
								if (vn != null && vn == data[key].vm_ID) {
									html += '<option value=' + data[key].vm_name + ' value2=' + data[key].vm_ID + '  selected>' + data[key].vm_name + ' (ON)</option>';
								} else {
									html += '<option value=' + data[key].vm_name + ' value2=' + data[key].vm_ID + ' >' + data[key].vm_name + ' (ON)</option>';
								}
							} else if (data[key].vm_status == 'poweredOff') {
								if (vn != null && vn == data[key].vm_ID) {
									html += '<option value=' + data[key].vm_name + ' value2=' + data[key].vm_ID + '  selected>' + data[key].vm_name + ' (OFF)</option>';
								} else {
									html += '<option value=' + data[key].vm_name + ' value2=' + data[key].vm_ID + ' >' + data[key].vm_name + ' (OFF)</option>';
								}
							}

						}
					}

					$("#childOfChildOfChildSB").empty();
					$("#childOfChildOfChildSB").append(html);
				}
			})
		}

		function getAllHostInfo() {
			$.ajax({
				url: "Mallhost_list.do",
				success: function(data) {
					var html = '';
					html += '<option>All</option>';
					for (key in data) {
						html += '<option>' + data[key].vm_Hhostname + '</option>';
					}

					$("#childSB").empty();
					$("#childSB").append(html);
				}
			})
		}

		function vmUsagefilterSearch() {

			var vmUsageStartDatetime = $("#vmUsageStartDatetime").val();
			var vmUsageEndDatetime = $("#vmUsageEndDatetime").val();
			var startFormat = new Date(vmUsageStartDatetime).getTime();
			var endFormat = new Date(vmUsageEndDatetime).getTime();

			if (!vmUsageStartDatetime) {
				alert("시작 일을 선택해 주세요.");
				return false;
			} else if (!vmUsageEndDatetime) {
				alert("종료 일을 선택해 주세요.");
				return false;
			} else if (endFormat - startFormat < -1) {
				alert("시작 일을 종료 일보다 빠르게 할 수 없습니다.");
				return false;
			} else {
				getCommonGraph();
				$("#dataloading").show();
			}
		}
	</script>
</head>

<body>
	<div class="card bg-dark mb-0 table-type-3 table-type-5-11">
		<div class="table-filter-light">
			<div class="col-12 mb-0 padding-0">
				<div class="row-padding-0">
					<div class="col-xl-2 col-sm-2">
						<select class="form-control select" id="subPickSelectBox" data-fouc>
							<c:if test="${sessionAppEL > ADMINCHECK}">
								<option value="clusterChoiceAll">클러스터별</option>
							</c:if>
							<option value="tenantsChoiceAll">테넌트별</option>
						</select>
					</div>
					<div class="col-xl-3 col-sm-3" id="subPickChild">
						<select class="form-control select-search" id="childSB" data-fouc></select>
					</div>
					<div class="col-xl-3 col-sm-3" id="subPickChildofchild">
						<select class="form-control select-search" id="childOfChildSB" data-fouc></select>
					</div>
					<div class="col-xl-4 col-sm-4" id="subPickChildofChildofChild">
						<select class="form-control select-search" id="childOfChildOfChildSB" data-fouc></select>
					</div>
				</div>
			</div>
			<div class="col-12 mb-0 padding-0">
				<div class="row-padding-0">
					<div class="col-xl-1 col-sm-1 d-flex align-items-center filter-label width-100">
						성능 데이터 종류</div>
					<div class="col-xl-1 col-sm-1 width-100">
						<select class="form-control select" id="timesetSB" data-fouc>
							<option value="0">20초</option>
							<c:if test="${ts == 5}">
								<option value="1" selected>5분</option>
								<option value="2">30분</option>
							</c:if>
							<c:if test="${ts == null or empty ts }">
								<option value="1">5분</option>
								<option value="2" selected>30분</option>
							</c:if>
							<option value="3">2시간</option>
							<option value="4">24시간</option>
						</select>
					</div>
					<div class="col-xl-2 col-sm-2" id="startdayDiv">
						<input id="vmUsageStartDatetime" class="form-control" type="date" name="date">
					</div>
					<div class="col-xl-2 col-sm-2" id="starttimeDiv">
						<input id="vmUsageStartTime" type="time" class="form-control" value="00:00">
					</div>
					<div class="col-xl-1 col-sm-1 d-flex align-items-center justify-content-center filter-label width-100">
						~</div>
					<div class="col-xl-2 col-sm-2" id="enddayDiv">
						<input id="vmUsageEndDatetime" class="form-control" type="date" name="date">
					</div>
					<div class="col-xl-2 col-sm-2" id="endtimeDiv">
						<input id="vmUsageEndTime" type="time" class="form-control" value="">
					</div>
					<div class="col-xl-1 col-sm-1 width-100">
						<button type="button" class="btn bg-prom col-md-12" onclick="vmUsagefilterSearch()">
							<i class="icon-filter3 mr-2"></i>결과 조회
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class=" statistics-chart-body">
			<canvas id="statisticsChart"></canvas>
		</div>
		<table id="vmUsageTable" class="promTable hover" style="width: 100%;">
			<thead>
				<tr>
					<th id="category1">클러스터명</th>
					<th id="category2">호스트명</th>
					<th>가상머신명</th>
					<th>vCPU</th>
					<th>Memory</th>
					<th>Disk</th>
					<th>Network</th>
					<th>일시</th>
				</tr>
			</thead>
		</table>
	</div>

	<script type="text/javascript">
		Chart.defaults.global.defaultFontColor = "#dedede";

		var optionsStatistics = {
			type: 'line',
			data: {
				labels: [],
				datasets: [{
					label: "CPU (%)",
					borderColor: "#46b5d3",
					borderWidth: 2,
					backgroundColor: "rgba(28, 36, 49, 0.3)",

					pointRadius: 1,
					pointBorderWidth: 1,
					pointBorderColor: "#46b5d3",

					pointHoverBorderColor: "#293243",
					pointHoverBackgroundColor: "#46b5d3",
					pointHoverBorderWidth: 4,
					pointHoverRadius: 6,
					pointHitRadius: 16,
					yAxisID: 'percent-y-axis'

				}, {
					label: "Memory (%)",
					data: [],
					borderColor: "#43A047",
					borderWidth: 2,
					backgroundColor: "rgba(28, 36, 49, 0.3)",

					pointRadius: 1,
					pointBorderWidth: 1,
					pointBorderColor: "#43A047",

					pointHoverBorderColor: "#293243",
					pointHoverBackgroundColor: "#43A047",
					pointHoverBorderWidth: 4,
					pointHoverRadius: 6,
					pointHitRadius: 16,
					yAxisID: 'percent-y-axis'
				}, {
					label: "Disk (KB)",
					data: [],
					borderColor: "#eba43c",
					borderWidth: 2,
					backgroundColor: "rgba(28, 36, 49, 0.3)",

					pointRadius: 1,
					pointBorderWidth: 1,
					pointBorderColor: "#eba43c",

					pointHoverBorderColor: "#293243",
					pointHoverBackgroundColor: "#eba43c",
					pointHoverBorderWidth: 4,
					pointHoverRadius: 6,
					pointHitRadius: 16,
					yAxisID: 'kb-y-axis'
				}, {
					label: "Network (KB)",
					data: [],
					borderColor: "#676fb5",
					borderWidth: 2,
					backgroundColor: "rgba(28, 36, 49, 0.3)",

					pointRadius: 1,
					pointBorderWidth: 1,
					pointBorderColor: "#676fb5",

					pointHoverBorderColor: "#293243",
					pointHoverBackgroundColor: "#676fb5",
					pointHoverBorderWidth: 4,
					pointHoverRadius: 6,
					pointHitRadius: 16,
					yAxisID: 'kb-y-axis'
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
					display: true
				},
				scales: {
					xAxes: [{
						gridLines: {
							display: false
						}
					}],
					yAxes: [{
						id: 'kb-y-axis',
						display: true,
						position: 'right',
						ticks: {
							callback: function(data, index, values) {
								return Math.round(data) + ' KB';
							},
							beginAtZero: true,

						}
					}, {
						id: 'percent-y-axis',
						display: true,
						position: 'left',
						ticks: {
							callback: function(data, index, values) {
								return data + ' %';
							},
							beginAtZero: true,
							max: 100,
							min: 0
						}
					}]
				}
			}
		}

		var ctxStatistics = document.getElementById('statisticsChart').getContext('2d');
		var statisticslineChart = new Chart(ctxStatistics, optionsStatistics);
	</script>
</body>

</html>