<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<script src="${path}/resources/PROM_JS/vmControl.js"></script>
	<script src="${path}/resources/PROM_JS/adminCheck.js"></script>
	<script src="${path}/resources/PROM_JS/commonVMResourceChange.js"></script>

	<script type="text/javascript">
		var userVMCtrlchk = 0;
		var commonVMTable = '';
		$(document).ready(function() {

			$(document).on('change', '#defaultClusterSB', function() {
				getDefaultHostsInCluster();
			})

			$(document).on('change', '#defaultHostSB', function() {
				getVMsInHostRefresh();
			})


			getDefaultClusterList();
			getUserVMCtrlchk();
			$("#vmDeleteLoading").hide();
		})


		function getVMsInHost() {
			var hostChoice = $("#defaultHostSB option:selected").val();
			var clusterID = $("#defaultClusterSB option:selected").val();
			var tableReload = "\'"+'tableReload'+"\'";
			
			commonVMTable = $("#hostVMTable")
				.addClass("nowrap")
				.DataTable({
					ajax: {
						"url": "/jquery/getVMsInHost.do",
						"dataSrc": "",
						"data": function(d) {
							d.clusterID = clusterID,
								d.HID = hostChoice
						}
					},
					columns: [{
							"data": "name"
						},
						{
							"data": "vm_host",
							render: function(data, type, row) {
								if (type == 'display') {
									var hostLink = hostMonitoringLink(clusterID, data);
									data = '<a href="#" onclick="javascript:window.parent.location.href=' + hostLink + '">' + data + '</a>';
								}

								return data;
							}
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
							"data": "vm_DataStore"
						},
						{
							"data": "vm_devices"
						},
						{
							"data": "cpuHotAdd",
							render: function(data, type, row) {
								if (data == 'true') {
									data = '<span class="text-prom">ON</span>';
								} else if (data == 'false') {
									data = '<span class="text-muted">OFF</span>';
								}
								return data;
							}
						},
						{
							"data": "memoryHotAdd",
							render: function(data, type, row) {
								if (data == 'true') {
									data = '<span class="text-prom">ON</span>';
								} else if (data == 'false') {
									data = '<span class="text-muted">OFF</span>';
								}
								return data;
							}
						},
						{
							"data": "vm_vmtools_status",
							render: function(data, type, row) {
								if (data == 'guestToolsRunning') {
									data = '<span class="text-prom">ON</span>';
								} else if (data == 'guestToolsNotRunning') {
									data = '<span class="text-muted">OFF</span>';
								}
								return data;
							}
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
							targets: 0
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
					order: [
						[0, "asc"],
						[1, "asc"]
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
								title: "클러스터 가상머신 현황",
								exportOptions: {
									columns: [0, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16]
								}
							},
							{
								extend: "excelHtml5",
								text: "Excel",
								title: "클러스터 가상머신 현황",
								exportOptions: {
									columns: [0, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16]
								}
							}
						]
					}]
				});
		}

		function getDefaultClusterList() {
			$.ajax({

				url: "/tenant/selectClusterList.do",
				success: function(data) {
					var html = '';
					if (data == null || data == '') {
						html += '<option value=0 selected disabled>:: 클러스터가 존재하지 않습니다. ::</option>';
					} else {

						html += '<option value="clusterAll" selected>클러스터 전체</option>';
						for (key in data) {
							html += '<option value=' + data[key].clusterID + '>' + data[key].clusterName + '</option>';
						}

						$("#defaultClusterSB").empty();
						$("#defaultClusterSB").append(html);
						getDefaultHostsInCluster();
					}
				}
			})
		}

		function getDefaultHostsInCluster() {

			var clusterID = $("#defaultClusterSB option:selected").val();

			$.ajax({
				data: {
					clusterId: clusterID
				},
				url: "/status/getHostsInCluster.do",
				success: function(data) {
					var html = '';
					var host = '';
					if (data == '' || data == null) {
						html += '<option value=0 selected disabled>:: 호스트가 존재하지 않습니다. ::</option>';
					} else {
						html += '<option value="hostAll" selected>호스트 전체</option>';
						for (key in data) {
							html += '<option value=' + data[key].vm_HID + '>' + data[key].vm_Hhostname + '</option>';
						}
					}
					$("#defaultHostSB").empty();
					$("#defaultHostSB").append(html);
					getVMsInHostRefresh();
				}
			})
		}

		function getVMsInHostRefresh() {
			setTimeout(function() {
				var commonVMTable = $('#hostVMTable').DataTable();
				commonVMTable.destroy();

				getVMsInHost();
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
				<select class="form-control select-search" id="defaultClusterSB" data-fouc></select>
			</div>
			<div class="col-xl-3 col-sm-6">
				<select class="form-control select-search" id="defaultHostSB" data-fouc></select>
			</div>
		</div>
		<table id="hostVMTable" class="promTable hover" style="width: 100%;">
			<thead>
				<tr>
					<th>클러스터</th>
					<th>호스트</th>
					<th>가상머신명</th>
					<th>vCPU</th>
					<th>Memory</th>
					<th>Disk</th>
					<th>OS</th>
					<th>IP 주소</th>
					<th>IP 주소 (1)</th>
					<th>IP 주소 (2)</th>
					<th>IP 주소 (3)</th>
					<th>데이터스토어</th>
					<th class="text-center">CD/DVD<br>드라이브</th>
					<th class="text-center">CPU<br>핫플러그</th>
					<th class="text-center">Memory<br>핫플러그</th>
					<th>Tools</th>
					<th>전원</th>
					<th>관리</th>
				</tr>
			</thead>
		</table>
	</div>
</body>

</html>