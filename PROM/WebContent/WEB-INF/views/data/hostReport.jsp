<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/hostReport.js"></script>
		<script type="text/javascript">
			var getDatetimeSet = new Date();
			getDatetimeSet.setDate(getDatetimeSet.getDate() - 1);
			$(document).ready(function() {
				$("#dateInput").val(getDatetimeSet.getFullYear() + "-" + leadingZeros(getDatetimeSet.getMonth() + 1, 2) + "-" + leadingZeros(getDatetimeSet.getDate(), 2))
				getClusterInfo();
				setTimeout(function() {
					getHostReport();
				},100)
			});
	
			function getHostReport() {
	
				var dateSB = $("#dateSB option:selected").val();
				var clusterSB = $("#clusterSB option:selected").val();
				var dateInput = $("#dateInput").val();
	
				if (dateSB == 'date') {
					timeset = 1
				} else if (dateSB == 'week') {
					timeset = 2
				} else if (dateSB == 'month') {
					timeset = 3
				}
	
				var hostReportTable = $("#hostReportTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/jquery/getReportLogic.do",
							"dataSrc": "",
							"data": function(d) {
								d.category = 'sHost',
									d.timeset = timeset,
									d.clusterName = clusterSB,
									d.usageStartTime = dateInput,
									d.usageEndTime = dateInput
							}
						},
						columns: [
							{"data": "clusterName"},
							{"data": "name"},
							{"data": "vm_cpu"},
							{"data": "vm_memory",
								render: function(data, type, row) {
									data = data + ' GB';
									return data;
								}
							},
							{"data": "host_cpu_model",
								render: function(data, type, row) {
									data = '<span class="font-size-small">' + data + '</span>';
									return data;
								}
							},
							{"data": "vmCount"},
							{"data": "vmAllCPU"},
							{"data": "vmAllMemory",
								render: function(data, type, row) {
									data = data + ' GB';
									return data;
								}
							},
							{"data": "cpu",
								render: function(data, type, row) {
									data = data + ' %';
									return data;
								}
							},
							{"data": "memory",
								render: function(data, type, row) {
									data = data + ' %';
									return data;
								}
							},
							{"data": "maxCPU",
								render: function(data, type, row) {
									data = data + ' %';
									return data;
								}
							},
							{"data": "maxMemory",
								render: function(data, type, row) {
									data = data + ' %';
									return data;
								}
							},
							{"data": "nCPU",
								render: function(data, type, row) {
									data = data + ' %';
									return data;
								}
							},
							{"data": "nMemory",
								render: function(data, type, row) {
									data = data + ' %';
									return data;
								}
							},
							{"data": "nMaxCPU",
								render: function(data, type, row) {
									data = data + ' %';
									return data;
								}
							},
							{"data": "nMaxMemory",
								render: function(data, type, row) {
									data = data + ' %';
									return data;
								}
							}
						],
						order: [
							[0, "asc"]
						],
						lengthMenu: [
							[5, 10, 25, 50, -1],
							[5, 10, 25, 50, "All"]
						],
						pageLength: 10,
						responsive: true,
						columnDefs: [{
							visible: false,
							targets: 0
						}, ],
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
									title: "호스트 보고서(주, 야간)",
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "호스트 보고서(주, 야간)",
								}
							]
						}]
					});
			}
		</script>
	</head>
	<body>
		<div class="card bg-dark mb-0 table-type-3 table-type-5-5">
			<div class="table-filter-light">
				<div class="col-xl-11 col-sm-10 mb-0 padding-0 width-100">
					<div class="row-padding-0">
						<div class="col-xl-1 col-sm-2">
							<select class="form-control select" onchange="changeDateType()" id="dateSB" data-fouc>
								<option value="date">일</option>
								<option value="week">주</option>
								<option value="month">월</option>
							</select>
						</div>
						<div class="col-xl-2 col-sm-2">
							<input type="date" class="form-control" id="dateInput">
						</div>
						<div class="col-xl-3 col-sm-4 width-100">
							<select class="form-control select-search" id="clusterSB" data-fouc></select>
						</div>
					</div>
				</div>
				<div class="col-xl-1 col-sm-2 width-100">
					<button type="button" class="btn bg-prom col-md-12" onclick="hostReportFilter()" id="resultBtn"><i class="icon-filter3 mr-2"></i>결과 조회</button>
				</div>
			</div>
			<table id="hostReportTable" class="promTable hover" style="width: 100%;">
				<thead>
					<tr>
						<th rowspan="2">클러스터명</th>
						<th rowspan="2">호스트명</th>
						<th rowspan="2">CPU</th>
						<th rowspan="2">Memory</th>
						<th rowspan="2">CPU 모델</th>
						<th rowspan="2">가상머신 수</th>
						<th rowspan="2">할당 vCPU</th>
						<th rowspan="2">할당 Memory</th>
						<th colspan="4" class="text-center">주간 ( AM 08 ~ PM 08 )</th>
						<th colspan="4" class="text-center">야간 ( PM 08 ~ AM 08 )</th>
					</tr>
					<tr>
						<th>평균 CPU</th>
						<th>평균 Memory</th>
						<th>최대 CPU</th>
						<th>최대 Memory</th>
						<th>평균 CPU</th>
						<th>평균 Memory</th>
						<th>최대 CPU</th>
						<th>최대 Memory</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>
