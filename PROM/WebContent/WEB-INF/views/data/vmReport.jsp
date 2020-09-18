<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/vmReport.js"></script>
		<script type="text/javascript">
			var getDatetimeSet = new Date();
			var dateInputCache = null;
			getDatetimeSet.setDate(getDatetimeSet.getDate() - 1);
			$(document).ready(function() {
				if (sessionApproval > ADMINCHECK) {
					getTenantList();
				} else {
					getUserTenantList();
				}
				setTimeout(function() {
					getVMReport();
				}, 100)
	
				$("#tenantSB").change(function() {
					serviceInTenant();
				})
				$("#dateInput").val(getDatetimeSet.getFullYear() + "-" + leadingZeros(getDatetimeSet.getMonth() + 1, 2) + "-" + leadingZeros(getDatetimeSet.getDate(), 2))
			});
	
			function getVMReport() {
				var dateSB = $("#dateSB option:selected").val();
				var tenantSB = $("#tenantSB option:selected").val();
				var serviceSB = $("#serviceInTenantSB option:selected").val();
				var dateInput = $("#dateInput").val();
				var timeset = 0;
	
				if (dateSB == 'date') {
					timeset = 1
				} else if (dateSB == 'week') {
					timeset = 2
				} else if (dateSB == 'month') {
					timeset = 3
				}
				var vmReportTable = $("#vmReportTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/jquery/getReportLogic.do",
							"dataSrc": "",
							"data": function(d) {
								d.category = 'sVM',
									d.timeset = timeset,
									d.tenantName = tenantSB,
									d.serviceName = serviceSB,
									d.usageStartTime = dateInput,
									d.usageEndTime = dateInput
							}
						},
						columns: [
							{"data": "tenantsName"},
							{"data": "serviceName"},
							{"data": "name"},
							{"data": "vm_cpu"},
							{"data": "vm_memory",
								render: function(data, type, row) {
									if(type === 'display' || type === 'filter'){
									data = data + ' GB';
									}
									return data;
								}
							},
							{"data": "vm_disk",
								render: function(data, type, row) {
									data = data + ' GB';
									return data;
								}
							},
							{"data": "vm_OS"},
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
							[0, "asc"],[1, 'asc']
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
							},
							{
								visible: false,
								targets: 1
							},
						],
						dom: "<'datatables-header'<'row-padding-0'lf><'row-padding-0'B>>" + "<'datatables-body'rt>" + "<'datatables-footer'ip>",
						buttons: [{
							extend: "collection",
							text: "<i class='icon-import'></i><span class='ml-2'>내보내기</span>",
							className: "btn bg-prom dropdown-toggle",
							buttons: [
								{
									extend: "csvHtml5",
									charset: "UTF-8",
									bom: true,
									text: "CSV",
									title: "가상머신 보고서(주, 야간)",
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "가상머신 보고서(주, 야간)",
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
						<div class="col-xl-3 col-sm-4">
							<select class="form-control select-search" id="tenantSB" data-fouc></select>
						</div>
						<div class="col-xl-3 col-sm-4">
							<select class="form-control select-search" id="serviceInTenantSB" data-fouc></select>
						</div>
					</div>
				</div>
				<div class="col-xl-1 col-sm-2 width-100">
					<button type="button" class="btn bg-prom col-md-12" onclick="vmReportFilter()" id="resultBtn"><i class="icon-filter3 mr-2"></i>결과 조회</button>
				</div>
			</div>
			<table id="vmReportTable" class="promTable hover" style="width: 100%;">
				<thead>
					<tr>
						<th rowspan="2">테넌트명</th>
						<th rowspan="2">서비스명</th>
						<th rowspan="2">가상머신명</th>
						<th rowspan="2">vCPU</th>
						<th rowspan="2">Memory</th>
						<th rowspan="2">Disk</th>
						<th rowspan="2">OS명</th>
						<th colspan="4" class="text-center">주간 ( AM 08 ~ PM 08 )</th>
						<th colspan="4" class="text-center">야간 ( PM 08 ~ AM 08 )</th>
					</tr>
					<tr>
						<th>평균 vCPU</th>
						<th>평균 Memory</th>
						<th>최대 vCPU</th>
						<th>최대 Memory</th>
						<th>평균 vCPU</th>
						<th>평균 Memory</th>
						<th>최대 vCPU</th>
						<th>최대 Memory</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>