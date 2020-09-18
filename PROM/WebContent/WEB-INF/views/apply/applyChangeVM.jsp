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
					<div class="col-group">
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" class="custom-control-input" id="byCluster" name="radioClusterTenant">
							<label class="custom-control-label" for="byCluster">클러스터별</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" class="custom-control-input" id="byTenant" name="radioClusterTenant">
							<label class="custom-control-label" for="byTenant">서비스 그룹별</label>
						</div>
					</div>
					<div class="col-xl-3 clusterFilter">
						<div class="input-group select-group">
							<div class="input-group-prepend"><span class="input-group-text">클러스터</span></div>
							<select class="form-control" id="selectCluster"></select>
						</div>
					</div>
					<div class="col-xl-3 clusterFilter">
						<div class="input-group select-group">
							<div class="input-group-prepend"><span class="input-group-text">호스트</span></div>
							<select class="form-control" id="selectHost"></select>
						</div>
					</div>
					<div class="col-xl-3 tenantFilter">
						<div class="input-group select-group">
							<div class="input-group-prepend"><span class="input-group-text">서비스 그룹</span></div>
							<select class="form-control" id="selectTenant"></select>
						</div>
					</div>
					<div class="col-xl-3 tenantFilter">
						<div class="input-group select-group">
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
						<th id="titleFilter1">클러스터</th>
						<th id="titleFilter2">호스트</th>
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
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
	
		// 사용자가 매핑된 테넌트 사용 여부 
		var isUserTenantMapping = 'false';
		
		$(document).ready(function() {
			$('input[name="radioClusterTenant"]').change(function () {
				$('#page_loading').removeClass('d-none');
				
				// 클러스터별 선택 시
				if ($('#byCluster').is(":checked")) {
					
					$('.clusterFilter').removeClass('d-none');
					$('.tenantFilter').addClass('d-none');
					
					$('#titleFilter1').html('클러스터');
					$('#titleFilter2').html('호스트');
					
					selectClusterList();
				}
				
				// 서비스 그룹별 선택 시
				if ($('#byTenant').is(":checked")) {
					
					$('.tenantFilter').removeClass('d-none');
					$('.clusterFilter').addClass('d-none');
					
					$('#titleFilter1').html('서비스 그룹');
					$('#titleFilter2').html('서비스');
					
					sessionUserApproval > USER_CHECK ? selectTenantList() : selectUserTenantList();
				}
				
				if (sessionUserApproval > USER_CHECK) {
					isUserTenantMapping = 'false';
				
				} else {
					isUserTenantMapping = 'true';
				}
			})
			
			$('#byCluster').click();
			
			$(document).on('change', '#selectCluster', function() {
				selectHostList();
			});
			
			$(document).on('change', '#selectHost', function() {
				tableReload('cluster');
			});
			
			$(document).on('change', '#selectTenant', function() {
				selectServiceList();
			});
			
			$(document).on('change', '#selectService', function() {
				tableReload('tenant');
			});
		})
		
		// 클러스터 목록
		function selectClusterList() {
			var html = '';
			
			$.ajax({
				url: "/tenant/selectClusterList.do",
				success: function(data) {
					if (data == null || data == '') {
						html += '<option value="0" selected disabled>클러스터가 없습니다.</option>';
					
					} else {
						html += '<option value="clusterAll" selected>전체</option>';
						
						for (key in data) {
							html += '<option value="' + data[key].clusterID + '">' + data[key].clusterName + '</option>';
						}

						$('#selectCluster').empty().append(html);
						selectHostList();
					}
				}
			})
		}
		
		// 선택된 클러스터의 호스트 목록
		function selectHostList() {
			var html = '';
			var clusterId = $("#selectCluster option:selected").val();

			$.ajax({
				data: {
					clusterId: clusterId
				},
				url: "/status/selectVMHostList.do",
				success: function(data) {
					if (data == '' || data == null) {
						html += '<option value="0" selected disabled>호스트가 없습니니다.</option>';
					
					} else {
						html += '<option value="hostAll" selected>전체</option>';
						
						for (key in data) {
							html += '<option value="' + data[key].vmHID + '">' + data[key].vmHhostname + '</option>';
						}
					}
					$('#selectHost').empty().append(html);
					tableReload('cluster');
				}
			})
		}
		
		// 서비스 그룹 목록
		function selectTenantList() {
			var html = '';
			
			$.ajax({
				url: "/tenant/selectTenantList.do",
				success: function(data) {
					if (data == null || data == '') {
						html += '<option value="-2" selected disabled>서비스 그룹이 없습니다.</option>';
					
					} else {
						html += '<option value="" selected>전체</option>';
						for (key in data) {
								html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
						}
						
						html += '<option value="-1">미배치</option>';
					}
					$('#selectTenant').empty().append(html);
					selectServiceList();
				}
			})
		}
		
		// 사용자 서비스 그룹 목록
		function selectUserTenantList() {
			var html = '';
			
			$.ajax({
				url: "/tenant/selectLoginUserTenantList.do",
				success: function(data) {
					if (data == null || data == '') {
						html += '<option value="-2" selected disabled>서비스 그룹이 없습니다.</option>';
					
					} else {
						for (key in data) {
							html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
						}
					}
					
					$('#selectTenant').empty().append(html);
					selectServiceList();
				}
			})
		}

		// 서비스 그룹의 서비스 목록
		function selectServiceList() {
			var html = '';
			var tenantId = $("#selectTenant option:selected").val();
			
			$.ajax({
				data: {
					tenantId: tenantId
				},
				url: "/tenant/selectVMServiceListByTenantId.do",
				success: function(data) {
					if (data == null || data == '') {
						html += '<option value="-2" selected disabled>서비스가 없습니다.</option>';
				
					} else if (tenantId == -1) {
						html += '<option value="-1" selected disabled>미배치</option>';
						
					} else {
						html += '<option value="" selected>전체</option>';
						for (key in data) {
							html += '<option value="' + data[key].vmServiceID + '">' + data[key].vmServiceName + '</option>';
						}
					}
					$('#selectService').empty().append(html);
					tableReload('tenant');
				}
			})
		}
	
		// 클러스터별 가상머신 테이블
		function getVMListCluster() {
			var clusterId = $('#selectCluster option:selected').val();
			var hostId = $('#selectHost option:selected').val();
			
			var tableVM = $('#tableVM').addClass('nowrap').DataTable({
				dom: "<'datatables-header'<'manageB'>B>" + "<'datatables-body'rt>" + "<'datatables-footer'ifp>",
				ajax: {
					url: "/apply/selectVMDataList.do",
					type: "POST",
					dataSrc: "",
					data: {
						clusterId: clusterId,
						hostId: hostId
					}
				},
				columns: [
					{data: "clusterName"},
					{data: "vmHost"},
					{data: "vmName"},
					{data: "vmCPU"},
					{data: "vmMemory", render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: "vmDisk", render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: "vmOS"},
					{data: "vmIpaddr1", render: function(data, type, row) {
						var totalIp = '';
						
						if (row.vmIpaddr1 != null) {
							totalIp += row.vmIpaddr1;
						}
						
						if (row.vmIpaddr2 != null) {
							totalIp += ', ' + row.vmIpaddr2;
						}
						
						if (row.vmIpaddr3 != null) {
							totalIp += ', ' + row.vmIpaddr3;
						}
						
						if (totalIp.startsWith(',')) {
							totalIp == totalIp.substr(1);
						}
						
						if (row.vmIpaddr1 == null && row.vmIpaddr2 == null && row.vmIpaddr3 == null) {
							totalIp = '<span class="text-muted">없음</span>';
						}
						
						return totalIp;
					}},
					{data: "vmtoolsStatus", render: function(data, type, row) {
						if (data == 'guestToolsRunning') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'guestToolsNotRunning') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						return data;
					}},
					{data: "vmStatus", render: function(data, type, row) {
						if (data == 'poweredOn') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'poweredOff') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						return data;
					}},
					{data: "cpuHotAdd", render: function(data, type, row) {
						if (data == 'true') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'false') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						return data;
					}},
					{data: "memoryHotAdd", render: function(data, type, row) {
						if (data == 'true') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'false') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						return data;
					}},
					{data: "vmDataStore"},
					{data: "vmDevices"}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1],	 ['10', '25', '50', '전체']],
				columnDefs: [
					{visible: false, targets: 10},
					{visible: false, targets: 11},
					{visible: false, targets: 12},
					{visible: false, targets: 13}
				],
				buttons: [{
					extend: "collection",
					text: "<i class='fas fa-download'></i><span>내보내기</span>",
					className: "btn exportBtn",
					buttons: [{
							extend: "csvHtml5",
							charset: "UTF-8",
							bom: true,
							text: "CSV",
							title: "가상머신 현황"
						},
						{
							extend: "excelHtml5",
							text: "Excel",
							title: "가상머신 현황"
						}
					]
				}, {
					extend: "pageLength",
					className: "btn pageLengthBtn",
				}, {
					extend: 'colvis',
					text: '테이블 편집',
					className: 'btn colvisBtn'
				}]
			});
			tableVMButton(tableVM);
		}
		
		// 서비스 그룹별 가상머신 테이블
		function getVMListTenant() {
			var tenantId = $('#selectTenant option:selected').val();
			var serviceId = $('#selectService option:selected').val();
			
			var tableVM = $('#tableVM').addClass('nowrap').DataTable({
				dom: "<'datatables-header'<'manageB'>B>" + "<'datatables-body'rt>" + "<'datatables-footer'ifp>",
				ajax: {
					url: "/apply/selectVMDataList.do",
					type: "POST",
					dataSrc: "",
					data: {
						tenantId: tenantId,
						vmServiceID: serviceId,
						isUserTenantMapping: isUserTenantMapping
					}
				},
				columns: [
					{data: "tenantName"},
					{data: "vmServiceName"},
					{data: "vmName"},
					{data: "vmCPU"},
					{data: "vmMemory", render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: "vmDisk", render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: "vmOS"},
					{data: "vmIpaddr1", render: function(data, type, row) {
						var totalIp = '';
						
						if (row.vmIpaddr1 != null) {
							totalIp += row.vmIpaddr1;
						}
						
						if (row.vmIpaddr2 != null) {
							totalIp += ', ' + row.vmIpaddr2;
						}
						
						if (row.vmIpaddr3 != null) {
							totalIp += ', ' + row.vmIpaddr3;
						}
						
						if (totalIp.startsWith(',')) {
							totalIp == totalIp.substr(1);
						}
						
						if (row.vmIpaddr1 == null && row.vmIpaddr2 == null && row.vmIpaddr3 == null) {
							totalIp = '<span class="text-muted">없음</span>';
						}
						
						return totalIp;
					}},
					{data: "vmtoolsStatus", render: function(data, type, row) {
						if (data == 'guestToolsRunning') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'guestToolsNotRunning') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						return data;
					}},
					{data: "vmStatus", render: function(data, type, row) {
						if (data == 'poweredOn') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'poweredOff') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						return data;
					}},
					{data: "cpuHotAdd", render: function(data, type, row) {
						if (data == 'true') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'false') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						return data;
					}},
					{data: "memoryHotAdd", render: function(data, type, row) {
						if (data == 'true') {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 'false') {
							data = '<span class="text-off">OFF</span>';
						
						} else {
							data = '';
						}
						return data;
					}},
					{data: "vmDataStore"},
					{data: "vmDevices"}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1],	 ['10', '25', '50', '전체']],
				columnDefs: [
					{visible: false, targets: 10},
					{visible: false, targets: 11},
					{visible: false, targets: 12},
					{visible: false, targets: 13}
				],
				buttons: [{
					extend: "collection",
					text: "<i class='fas fa-download'></i><span>내보내기</span>",
					className: "btn exportBtn",
					buttons: [{
							extend: "csvHtml5",
							charset: "UTF-8",
							bom: true,
							text: "CSV",
							title: "가상머신 현황"
						},
						{
							extend: "excelHtml5",
							text: "Excel",
							title: "가상머신 현황"
						}
					]
				}, {
					extend: "pageLength",
					className: "btn pageLengthBtn",
				}, {
					extend: 'colvis',
					text: '테이블 편집',
					className: 'btn colvisBtn'
				}]
			});
			tableVMButton(tableVM);
		}
		
		// 등록, 관리 버튼 설정
		function tableVMButton(tableVM){
			$('.manageB').html('<button type="button" class="btn manageBtn"><i class="fas fa-ellipsis-h"></i><span>관리</span></button>');
			
			$('.manageBtn').click(function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableVM').on('click', 'tr', function() {
				var data = tableVM.row(this).data();
				
				if (data != undefined){
					$(this).addClass('selected');
					$('#tableVM tr').not(this).removeClass('selected');
					
					// 관리 버튼 활성화
					var html = '';
					
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown"><i class="fas fa-ellipsis-h"></i><span>관리</span></button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item">자원 변경</a>';
					html += '<a href="#" class="dropdown-item">Disk 추가</a>';
					html += '<a href="#" class="dropdown-item">vNIC 추가</a>';
					html += '<a href="#" class="dropdown-item">CD-ROM 추가</a>';
					html += '</div>';
					
					$('.manageB').empty().append(html);
				}
			});
		}
		
		// 테이블 초기화
		function tableReload(category) {
			var tableVM = $('#tableVM').DataTable();
			tableVM.destroy();
			
			// 클러스터별
			if (category == 'cluster') {
				getVMListCluster();
			}
			
			// 서비스 그룹별
			if (category == 'tenant') {
				getVMListTenant();
			}
		}
	</script>
</body>

</html>