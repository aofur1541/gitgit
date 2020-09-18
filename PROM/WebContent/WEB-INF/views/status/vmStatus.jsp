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
					<div class="col-group w-100 clusterOrServiceGroupDiv">
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" class="custom-control-input" id="byCluster" name="clusterOrServiceGroup">
							<label class="custom-control-label" for="byCluster">클러스터별</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" class="custom-control-input" id="byServiceGroup" name="clusterOrServiceGroup">
							<label class="custom-control-label" for="byServiceGroup">서비스 그룹별</label>
						</div>
					</div>
					<div class="col-group w-50 clusterDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">클러스터</span></div>
							<select class="form-control" id="selectCluster"></select>
						</div>
					</div>
					<div class="col-group w-50 clusterDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">호스트</span></div>
							<select class="form-control" id="selectHost"></select>
						</div>
					</div>
					<div class="col-group w-50 serviceGroupDiv d-none">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">서비스 그룹</span></div>
							<select class="form-control" id="selectServiceGroup"></select>
						</div>
					</div>
					<div class="col-group w-50 serviceGroupDiv d-none">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">서비스</span></div>
							<select class="form-control" id="selectService"></select>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 가상머신 테이블 -->
			<table id="tableVM" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th id="name1">클러스터</th>
						<th id="name2">호스트</th>
						<th>가상머신</th>
						<th>vCPU</th>
						<th>Memory</th>
						<th>총 Disk</th>
						<th>OS</th>
						<th>IP 주소</th>
						<th>Tools</th>
						<th>전원</th>
						<th>CPU 핫플러그</th>
						<th>Memory 핫플러그</th>
						<th>데이터스토어</th>
						<th>CD/DVD드라이브</th>
						<th>설명</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script src="${path}/resource/js/vm.js"></script>
	
	<script type="text/javascript">
	
		// 클러스터별 가상머신 테이블
		function getVMListCluster(clusterId, hostId) {
			var tableVM = $('#tableVM').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/apply/selectVMDataList.do',
					type: 'POST',
					dataSrc: '',
					data: {
						clusterId: clusterId,
						hostId: hostId
					}
				},
				columns: [
					{data: 'clusterName'},
					{data: 'vmHost'},
					{data: 'vmName'},
					{data: 'vmCPU'},
					{data: 'vmMemory', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'vmDisk', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'vmOS'},
					{data: 'vmIpaddr1', render: function(data, type, row) {
						var ipTotal = '';
						
						if (row.vmIpaddr1 != null) {
							ipTotal += row.vmIpaddr1;
						}
						
						if (row.vmIpaddr2 != null) {
							ipTotal += ', ' + row.vmIpaddr2;
						}
						
						if (row.vmIpaddr3 != null) {
							ipTotal += ', ' + row.vmIpaddr3;
						}
						
						if (ipTotal.startsWith(',')) {
							ipTotal == ipTotal.substr(1);
						}
						
						if (row.vmIpaddr1 == null && row.vmIpaddr2 == null && row.vmIpaddr3 == null) {
							ipTotal = '<span class="text-disabled">없음</span>';
						}
						
						return ipTotal;
					}},
					{data: 'vmtoolsStatus', render: function(data, type, row) {
						if (data == 'guestToolsRunning') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'guestToolsNotRunning') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						
						return data;
					}},
					{data: 'vmStatus', render: function(data, type, row) {
						if (data == 'poweredOn') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'poweredOff') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						
						return data;
					}},
					{data: 'cpuHotAdd', render: function(data, type, row) {
						if (data == 'true') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'false') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						
						return data;
					}},
					{data: 'memoryHotAdd', render: function(data, type, row) {
						if (data == 'true') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'false') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						
						return data;
					}},
					{data: 'vmDataStore'},
					{data: 'vmDevices'},
					{data: 'description'}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1],	 ['10', '25', '50', '전체']],
				columnDefs: [{visible: false, targets: 10}, {visible: false, targets: 11}, {visible: false, targets: 12}, {visible: false, targets: 13}],
				order: [[7, 'desc']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '가상머신 현황'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '가상머신 현황'
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
		
		// 서비스 그룹별 가상머신 테이블
		function getVMListTenant(serviceGroupId, serviceId) {
			var tableVM = $('#tableVM').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/apply/selectVMDataList.do',
					type: 'POST',
					dataSrc: '',
					data: {
						tenantId: serviceGroupId,
						vmServiceID: serviceId,
						isUserTenantMapping: isUserTenantMapping
					}
				},
				columns: [
					{data: 'tenantName'},
					{data: 'vmServiceName'},
					{data: 'vmName'},
					{data: 'vmCPU'},
					{data: 'vmMemory', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'vmDisk', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'vmOS'},
					{data: 'vmIpaddr1', render: function(data, type, row) {
						var ipTotal = '';
						
						if (row.vmIpaddr1 != null) {
							ipTotal += row.vmIpaddr1;
						}
						
						if (row.vmIpaddr2 != null) {
							ipTotal += ', ' + row.vmIpaddr2;
						}
						
						if (row.vmIpaddr3 != null) {
							ipTotal += ', ' + row.vmIpaddr3;
						}
						
						if (ipTotal.startsWith(',')) {
							ipTotal == ipTotal.substr(1);
						}
						
						if (row.vmIpaddr1 == null && row.vmIpaddr2 == null && row.vmIpaddr3 == null) {
							ipTotal = '<span class="text-disabled">없음</span>';
						}
						
						return ipTotal;
					}},
					{data: 'vmtoolsStatus', render: function(data, type, row) {
						if (data == 'guestToolsRunning') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'guestToolsNotRunning') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						
						return data;
					}},
					{data: 'vmStatus', render: function(data, type, row) {
						if (data == 'poweredOn') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'poweredOff') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						
						return data;
					}},
					{data: 'cpuHotAdd', render: function(data, type, row) {
						if (data == 'true') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'false') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						
						return data;
					}},
					{data: 'memoryHotAdd', render: function(data, type, row) {
						if (data == 'true') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'false') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						
						return data;
					}},
					{data: 'vmDataStore'},
					{data: 'vmDevices'}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1],	 ['10', '25', '50', '전체']],
				columnDefs: [{visible: false, targets: 10}, {visible: false, targets: 11}, {visible: false, targets: 12}, {visible: false, targets: 13}],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '가상머신 현황'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '가상머신 현황'
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