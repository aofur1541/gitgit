<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<script src="${path}/resources/PROM_JS/vmControl.js"></script>
	<script src="${path}/resources/PROM_JS/commonVMResourceChange.js"></script>

	<script type="text/javascript">
		var userVMCtrlchk = 0;
		var commonVMTable = '';
		$(document).ready(function() {
			if (sessionApproval > ADMINCHECK) {
				getTenantList();
			} else if (sessionApproval < ADMINCHECK) {
				getUserTenantList();
			}
			getUserVMCtrlchk();
			$("#vmDeleteLoading").hide();
		})

		function getUserTenantList() {
			$.ajax({
				url: "/tenant/selectLoginUserTenantList.do",
				success: function(data) {
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
				url: "/tenant/selectTenantList.do",
				success: function(data) {
					var html = '';

					html += '<option value="0" value2="테넌트 전체" selected>테넌트 전체</option>';
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
				data: {
					tenantId: tenantsID
				},
				url: "/tenant/selectVMServiceListByTenantId.do",
				success: function(data) {
					var html = '';

					if (data == null || data == '') {
						html += '<option value="0" value2="서비스없음" selected>서비스 미배치</option>';
					} else {
						html += '<option value="-1" value2="서비스 전체" selected>서비스 전체</option>';
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
					serviceInVM();
				}
			})
		}

		function returnVMrequest(vmName, vmStatus, serviceID) {
			returnVMsetRequest(vmName, serviceID);
		}

		function returnVMsetRequest(vmName, serviceID) {
			$.ajax({
				data: {
					crVMName: vmName,
					vmServiceID: serviceID
				},
				type : "POST",
				url: "/apply/insertVMReturn.do",
				success: function(data) {
					if (data == 1) {
						alert("반환 신청이 완료되었습니다.");
						location.reload();
					} else if (data == 2) {
						alert("이미 반환 승인 대기 중인 가상머신 입니다.");
						return false;
					} else {
						alert("반환 신청 요청 실패");
					}
				}
			})
		}

		function serviceInVMs() {
			var tenantsID = $("#tenantSelcetBox option:selected").val();
			var tenantsName = $("#tenantSelcetBox option:selected").attr("value2");
			var serviceID = $("#tenantInServiceSelcetBox").val();
			var serviceName = $("#tenantInServiceSelcetBox option:selected").attr("value2");

			var tableReload = "\'"+'tableReload'+"\'";
			
			commonVMTable = $("#serviceVMTable")
				.addClass("nowrap")
				.DataTable({
					ajax: {
						"url": "/jquery/tenantsInServiceVMs.do",
						"dataSrc": function(d) {
							return d
						},
						"data": function(d) {
							d.tenantsID = tenantsID,
								d.serviceID = serviceID
						}
					},
					columns: [{
							"data": "name"
						},
						{
							"data": "servicename"
						},
						{
							"data": "vm_name",
							render: function(data, type, row) {
								var ten = '';
								var se = '';

								if (row.tenants_id == 0) {
									ten = 'De';
								} else {
									ten = row.tenants_id;
								}

								if (row.service_id == 0) {
									se = 'De';
								} else {
									se = row.service_id;
								}

								var vmLink = "\'" + '/menu/monitoring.do?vn=' + row.vm_ID + '&ten=' + ten + '&se=' + se + "#1\'";

								data = '<a href="#" onclick="javascript:window.parent.location.href=' + vmLink + '">' + data + '</a>';

								return data;
							}
						},
						{
							"data": "vm_cpu"
						},
						{
							"data": "vm_memory",
							render: function(data, type, row) {
								data = data + ' GB';
								return data;
							}
						},
						{
							"data": "vm_disk",
							render: function(data, type, row) {
								data = data + ' GB';
								return data;
							}
						},
						{
							"data": "vm_OS",
							render: function(data, type, row) {
								data = '<span class="font-size-small">' + data + '</span>';
								return data;
							}
						},
						{
							"data": "vm_ipaddr1",
							render: function(data, type, row) {
								if (data == null & row.vm_ipaddr2 == null & row.vm_ipaddr3 == null) { // all null
									data = '<span class="text-muted">없음</span>';

								} else if (data != null & row.vm_ipaddr2 == null & row.vm_ipaddr3 == null) { // 1 notnull 2,3 null
									data = '<span class="cpointer" title="' + data + '">' + data + ' (1)</span>';

								} else if (data == null & row.vm_ipaddr2 != null & row.vm_ipaddr3 == null) { // 1 null 2 notnull 3 null 
									data = '<span class="cpointer" title="' + row.vm_ipaddr2 + '">' + row.vm_ipaddr2 + ' (1)</span>';

								} else if (data == null & row.vm_ipaddr2 == null & row.vm_ipaddr3 != null) { //1 null 2 null 3 notnull
									data = '<span class="cpointer" title="' + row.vm_ipaddr3 + '">' + row.vm_ipaddr3 + ' (1)</span>';

								} else if (data != null & row.vm_ipaddr2 != null & row.vm_ipaddr3 == null) { // 1 nou null , 2 not null , 3 null
									data = '<span class="cpointer" title="' + data + ' / ' + row.vm_ipaddr2 + '">' + data + ' (2)</span>';

								} else if (data == null & row.vm_ipaddr2 != null & row.vm_ipaddr3 != null) { // 1 null , 2 notnull , 3 notnull
									data = '<span class="cpointer" title="' + row.vm_ipaddr2 + ' / ' + row.vm_ipaddr3 + '">' + row.vm_ipaddr2 + ' (2)</span>';

								} else if (data != null & row.vm_ipaddr2 == null & row.vm_ipaddr3 != null) { // 1 notnull , 2 null , 3 notnull
									data = '<span class="cpointer" title="' + data + ' / ' + row.vm_ipaddr3 + '">' + data + ' (2)</span>';

								} else { // all notnull
									data = '<span  class="cpointer" title="' + data + ' / ' + row.vm_ipaddr2 + ' / ' + row.vm_ipaddr3 + '" >' + data + ' (3)</span>';
								}
								return data;
							}
						},
						{
							"data": "vm_ipaddr1"
						},
						{
							"data": "vm_ipaddr2"
						},
						{
							"data": "vm_ipaddr3"
						},
						{
							"data": "vm_status",
							render: function(data, type, row) {
								if (data == 'poweredOn') {
									data = '<span class="text-prom">ON</span>';
								} else if (data == 'poweredOff') {
									data = '<span class="text-muted">OFF</span>';
								}
								return data;
							}
						},
						{
							"data": "vm_name",
							"orderable": false,
							render: function(data, type, row) {
								var html = '';
								var data = "\'" + data + "\'";
								var status = "\'" + row.vm_status + "\'";
								if (sessionApproval != BanNumber) {
									html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
									html += '<i class="icon-menu9"></i>';
									html += '</a>';
									html += '<div class="dropdown-menu">';

									if (sessionApproval < CONTROLCHECK) {
										var strChange = '자원 변경 신청';
									} else {
										var strChange = '자원 변경';
									}

									html += '<a href="#" class="dropdown-item" onclick="vmResourceChange(' + data + ', ' + row.vm_cpu + ', ' + row.vm_memory + ', ' + row.cpuHotAdd + ', ' + row.memoryHotAdd + ', ' + row.vm_service_ID + ')"><i class="icon-pencil7"></i>' + strChange + '</a>';
									if (sessionApproval < ADMINCHECK) {
										html += '<a href="#" class="dropdown-item" onclick="returnVMrequest(' + data + ', ' + status + ', ' + row.vm_service_ID + ')"><i class="icon-undo2"></i>반환 신청</a>';
									}

									if (row.vm_status == 'poweredOff' && (sessionApproval == ADMIN_NAPP || sessionApproval == OPERATOR_NAPP) && (row.vm_service_ID == 0 || row.vm_service_ID == null)) {
										html += '<a href="#" class="dropdown-item" onclick="destoryVMvalidation(' + data + ')"><i class="icon-trash"></i>자원 삭제</a>';
									}

									if (userVMCtrlchk == 0 && sessionApproval < CONTROLCHECK) {

									} else {
										html += '<div class="dropdown-divider"></div>';
										if (row.vm_status == 'poweredOn') {
											html += '<a href="#" class="dropdown-item" onclick="ctrlPowerOfVM(' + data + ', ' + 2 +','+tableReload+')"><i class="icon-power-cord"></i>전원 끄기</a>';
											html += '<a href="#" class="dropdown-item" onclick="ctrlPowerOfVM(' + data + ', ' + 3 +','+tableReload+')"><i class="icon-rotate-ccw3"></i>다시 시작</a>';

										} else if (row.vm_status == 'poweredOff') {
											html += '<a href="#" class="dropdown-item" onclick="ctrlPowerOfVM(' + data + ', ' + 1 +','+tableReload+')"><i class="icon-switch"></i>전원 켜기</a>';
										}
									}
								} else {
									html += '<i class="icon-lock2"></i>';
								}
								html += '</div>';

								return html;
							}
						}
					],
					lengthMenu: [
						[5, 10, 25, 50, -1],
						[5, 10, 25, 50, "All"]
					],
					pageLength: 10,
					responsive: true,
					stateSave: true,
					columnDefs: [{
							responsivePriority: 1,
							targets: 0
						},
						{
							responsivePriority: 2,
							targets: -1
						},
						{
							visible: false,
							targets: 8
						},
						{
							visible: false,
							targets: 9
						},
						{
							visible: false,
							targets: 10
						},
						{
							targets: "_all",
							defaultContent: '-'
						}
					],
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
								title: "테넌트/서비스별 가상머신 정보",
								exportOptions: {
									columns: [0, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11]
								}
							},
							{
								extend: "excelHtml5",
								text: "Excel",
								title: "테넌트/서비스별 가상머신 정보",
								exportOptions: {
									columns: [0, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11]
								}
							}
						]
					}]
				});

		}


		function serviceInVM() {
			setTimeout(function() {
				var commonVMTable = $('#serviceVMTable').DataTable();
				commonVMTable.destroy();

				serviceInVMs();
			}, 50)
		}
	</script>
</head>

<body>
	<div id="vmDeleteLoading">
		<div class="pace-demo">
			<div class="theme_tail theme_tail_circle theme_tail_with_text">
				<div class="pace_progress" data-progress-text="60%" data-progress="60"></div>
				<div class="pace_activity"></div>
				<span class="text-center" id="loadingMessages"></span>
			</div>
		</div>
		<div class="pace-back"></div>
	</div>

	<div class="card bg-dark mb-0 table-type-3 table-type-5-2">
		<div class="table-filter-light">
			<div class="col-xl-3 col-sm-6">
				<select class="form-control select-search" id="tenantSelcetBox" onchange="serviceInTenant()" data-fouc></select>
			</div>
			<div class="col-xl-3 col-sm-6">
				<select class="form-control select-search" id="tenantInServiceSelcetBox" onchange="serviceInVM()" data-fouc></select>
			</div>
		</div>
		<table id="serviceVMTable" class="promTable hover" style="width: 100%;">
			<thead>
				<tr>
					<th>테넌트명</th>
					<th>서비스명</th>
					<th>가상머신명</th>
					<th>vCPU</th>
					<th>Memory</th>
					<th>Disk</th>
					<th>OS</th>
					<th>IP 주소</th>
					<th>IP 주소 (1)</th>
					<th>IP 주소 (2)</th>
					<th>IP 주소 (3)</th>
					<th>전원</th>
					<th>관리</th>
				</tr>
			</thead>
		</table>
	</div>
</body>

</html>