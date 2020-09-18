<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>

	<script src="${path}/resource/plugin/bootstrap-submenu/bootstrap-submenu.js"></script>
	<link href="${path}/resource/plugin/bootstrap-submenu/bootstrap-submenu.css" rel="stylesheet" type="text/css">
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>
	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>

		<!-- 본문 시작 -->
		<div class="content">
		
		
		<!-- 코멘트입력 -->
			<div class="modal fade" id="updatedescmodal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">가상머신 설명 변경</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<label>가상머신 <span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="updateVMModal_vmName2" disabled>
								<div class="row">
									<div class="col-6">
										<label>Comment <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="updateVMModal_desc">
									</div>
									
								</div>
							</div>
				  	</div>
				  	<div class="modal-footer">
							<button type="button" class="btn" id="vmBtn">변경</button>
							<button type="button" class="btn closeModalBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
				</div>			
							
							
			
		
		
		
		
			<!-- 가상머신 자원 변경 모달 -->
			<div class="modal fade" id="updateVMModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">가상머신 자원 변경</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<label>가상머신 <span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="updateVMModal_vmName" disabled>
								<div class="row">
									<div class="col-6">
										<label>vCPU <span class="text-danger">*</span></label>
										<input type="number" class="form-control mb-0" min="1" max="32" id="updateVMModal_vCPU">
									</div>
									<div class="col-6">
										<label>Memory <span class="text-danger">*</span></label>
										<input type="number" class="form-control mb-0" min="1" max="64" id="updateVMModal_memory">
									</div>
								</div>
							</div>
				
							
							<div class="modal-card">
								<p>
									1. 핫플러그가 OFF인 경우 가상머신이 다시 시작 됩니다.<br>
									<span class="ml-3">CPU 핫플러그: <span class="text-on">ON</span></span><br>
									<span class="ml-3">Memory 핫플러그: <span class="text-on">ON</span></span>
								</p>
								<p>2. 활성 Memory 크기보다 작게 축소할 수 없습니다.</p>
								<p class="mb-0">3. 핫 플러그 활성화 가상머신의 Memory가 3 GB 이하일 경우 자원 변경 기능이 작동하지 않습니다.</p>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" id="vmBtn">변경</button>
							<button type="button" class="btn closeModalBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- Disk 정보 모달 -->
			<div class="modal fade" id="diskModal" tabindex="-1">
				<div class="modal-dialog modal-lg modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">가상머신 Disk 정보</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="loading-background card-loading modal-loading"><div class="spinner-border" role="status"></div></div>
							<div class="modal-card">
								
								<!-- Disk 테이블 -->
								<table id="tableDisk" class="cell-border hover" style="width: 100%;">
									<thead>
										<tr>
											<th>#</th>
											<th>데이터스토어</th>
											<th>용량 (GB)</th>
											<th>유형</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn closeModalBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			
			
			
			<!-- Disk 추가 모달 -->
			<div class="modal fade" id="addDiskModal" tabindex="-1">
				<div class="modal-dialog modal-sm modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">Disk 추가</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<label>데이터스토어 <span class="text-danger">*</span></label>
								<select class="form-control" id="addDiskModal_datastore"></select>
								
								<label>용량 (GB)​ <span class="text-danger">*</span></label>
								<input type="number" class="form-control mb-0" placeholder="용량 (GB)" id="addDiskModal_capacity">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" id="diskBtn">추가</button>
							<button type="button" class="btn closeModalBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- vNIC 정보 모달 -->
			<div class="modal fade" id="vNICModal" tabindex="-1">
				<div class="modal-dialog modal-lg modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">가상머신 vNIC 정보</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="loading-background card-loading modal-loading"><div class="spinner-border" role="status"></div></div>
							<div class="modal-card">
								
								<!-- vNIC 테이블 -->
								<table id="tablevNIC" class="cell-border hover" style="width: 100%;">
									<thead>
										<tr>
											<th>#</th>
											<th>네트워크</th>
											<th>IP 주소</th>
											<th>상태</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn closeModalBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- vNIC 추가 모달 -->
			<div class="modal fade" id="addvNICModal" tabindex="-1">
				<div class="modal-dialog modal-sm modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">vNIC 추가</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<label>네트워크 <span class="text-danger">*</span></label>
								<select class="form-control mb-0" id="addvNICModal_network"></select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" id="vNICBtn">추가</button>
							<button type="button" class="btn closeModalBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- CD-ROM 정보 모달 -->
			<div class="modal fade" id="cdromModal" tabindex="-1">
				<div class="modal-dialog modal-lg modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">가상머신 vNIC 정보</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="loading-background card-loading modal-loading"><div class="spinner-border" role="status"></div></div>
							<div class="modal-card">
								
								<!-- CD-ROM 테이블 -->
								<table id="tableCDROM" class="cell-border hover" style="width: 100%;">
									<thead>
										<tr>
											<th>#</th>
											<th>데이터스토어</th>
											<th>연결 파일</th>
											<th>상태</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn closeModalBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- CD-ROM 추가 모달 -->
			<div class="modal fade" id="addCDROMModal" tabindex="-1">
				<div class="modal-dialog modal-sm modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">CD-ROM 추가</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<label>데이터스토어 <span class="text-danger">*</span></label>
								<select class="form-control" id="addCDROMModal_datastore"></select>
								
								<label>연결 파일 (ISO)​ <span class="text-danger">*</span></label>
								<input type="text" class="form-control mb-0" placeholder="연결 파일 (ISO)" id="addCDROMModal_file">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" id="cdromBtn">추가</button>
							<button type="button" class="btn closeModalBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>

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
						<th id="desc">설명</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>
	<script src="${path}/resource/js/sidebar.js"></script>
	<script src="${path}/resource/js/vm.js"></script>
	
	<script type="text/javascript">
	
		// 부트스트랩 다중 모달 설정
		var count = 0; // 모달이 열릴 때 마다 count 해서  z-index값을 높여줌
		
		$(document).on('show.bs.modal', '.modal', function() {
			var zIndex = 1040 + (10 * count);
			$(this).css('z-index', zIndex);
			setTimeout(function() {
				$('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
			}, 0);
			count = count + 1;
		});
	
		// multiple modal Scrollbar fix
		$(document).on('hidden.bs.modal', '.modal', function() {
			$('.modal:visible').length && $(document.body).addClass('modal-open');
		});
	
		var countDisk = 0;
		
		// 클러스터별 가상머신 테이블
		function getVMListCluster(clusterId, hostId) {
			var tableVM = $('#tableVM').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"vm-manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
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
			
			tableVMButton(tableVM);
		}
	
		// 서비스 그룹별 가상머신 테이블
		function getVMListTenant(serviceGroupId, serviceId) {
			var tableVM = $('#tableVM').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"vm-manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
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
			
			tableVMButton(tableVM);
		}
	
		// 관리 버튼 설정
		function tableVMButton(tableVM) {
			$('.vm-manageB').html('<button type="button" class="btn manageBtn">관리</button>');
			
			$('.manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableVM tbody').off('click').on('click', 'tr', function() {
				var data = tableVM.row(this).data();
				
				
				if (data != undefined) {
					$(this).addClass('selected');
					$('#tableVM tr').not(this).removeClass('selected');
					
					// 관리 버튼 활성화
					var html = '';
					
					html += '<div class="dropdown">';
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown" data-submenu="">관리</button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" id="updatedesc">코멘트</a>';
					html += '<a href="#" class="dropdown-item" id="updateVM">자원 변경</a>';
					html +='<div class="dropdown-divider"></div>';
					
					html += '<div class="dropdown dropright dropdown-submenu">';
					html += '<a href="#" class="dropdown-item dropdown-toggle" data-toggle="dropdown">전원</a>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" id="powerOFF">전원 끄기</a>';
					html += '<a href="#" class="dropdown-item" id="powerON">전원 켜기</a>';
					html += '<a href="#" class="dropdown-item" id="powerRestart">다시 시작</a>';
					html += '</div>';
					html += '</div>';
						
					html +='<div class="dropdown-divider"></div>';
					html += '<a href="#" class="dropdown-item" id="diskInfo">Disk 설정</a>';
					html += '<a href="#" class="dropdown-item" id="vNICInfo">vNIC 설정</a>';
					html += '<a href="#" class="dropdown-item" id="cdromInfo">CD-ROM 설정</a>';
					
					html +='<div class="dropdown-divider"></div>';
					html += '<a href="#" class="dropdown-item" id="deleteVM">삭제</a>';
					html += '</div>';
					html += '</div>';

					$('.vm-manageB').empty().append(html);
					$('[data-submenu]').submenupicker();
					
					
				
					
					// 가상머신 자원 변경
					$('#updateVM').off('click').on('click', function() {
						updateVM();
					});
					
					// 설명 추가
					$('#updatedesc').off('click').on('click', function() {
						
						
						$('#updatedescmodal').modal('show');
						$('#updateVMModal_vmName2').val(data.vmName);
						$('#updateVMModal_desc').val(data.description);
					
						
						$('.modal-title').html('\'' + data.vmName + '\' 가상머신 코멘트');
						
						$('#vmBtn').off('click').on('click', function() {
							updatedesc(data);
						});
					});
					
					function updatedesc(data){
						
						var newdesc = $('#updateVMModal_desc').val();
						
						
					
						// 데이터 받아왔음 . 칸에 vm NAME 이랑 ip주소 전원 onoff정도 표기하고
						// 바꾸는거 ㄱㄱ
						
						$.ajax({
							url: '/apply/changedescription.do',
							type: 'POST',
							data: {
								vmName: data.vmName,
								description: newdesc
							},
							beforeSend: function() {
								$('#page_loading').removeClass('d-none');
							},
							complete: function() {
								$('#page_loading').addClass('d-none');
							},
							success: function(data) {
								
								location.href = '/vm/changeVM.prom'

							
							
							}//success 
						})//ajax
					}//fucntion
						
						
					
						
				
					
					
						
						
		
							
					}
					
					// 가상머신 전원 관리
					if (data.vmStatus == 'poweredOn') {
						$('#powerON').addClass('disabled');
						$('#powerOFF').removeClass('disabled');
						$('#powerRestart').removeClass('disabled');
						
					} else if (data.vmStatus == 'poweredOff') {
						$('#powerON').removeClass('disabled');
						$('#powerOFF').addClass('disabled');
						$('#powerRestart').addClass('disabled');
					}
					
					$('#powerON').not('.disabled').off('click').on('click', function() {
						managePower(data, 1);
					});
					
					$('#powerOFF').not('.disabled').off('click').on('click', function() {
						managePower(data, 2);
					});
					
					$('#powerRestart').not('.disabled').off('click').on('click', function() {
						managePower(data, 3);
					});
					
					// Disk 정보
					$('#diskInfo').off('click').on('click', function() {
						diskInfo(data);
					});
					
					// vNIC 정보
					$('#vNICInfo').off('click').on('click', function() {
						console.log('테스트');
						
						vNICInfo(data);
					});
					
					// CD-ROM 정보
					$('#cdromInfo').off('click').on('click', function() {
						cdromInfo(data);
					});
					
					// 가상머신 삭제
					// 전원이 OFF 이면서 서비스에 미배치된 가상머신만 삭제 가능
					data.vmStatus == 'poweredOff' && data.vmServiceID == 0 ? $('#deleteVM').removeClass('disabled') : $('#deleteVM').addClass('disabled');
					
					$('#deleteVM').not('.disabled').off('click').on('click', function() {
						deleteVM(data);
					});
				
			});
		}
		

		
		
		
		
		
		// 변경 모달 설정
		function updateVM(data) {
			$('#updateVMModal_vmName').val(data.vmName);
			$('#updateVMModal_vCPU').val(data.vmCPU);
			$('#updateVMModal_memory').val(data.vmMemory);
			
			$('.modal-title').html('\'' + data.vmName + '\' 가상머신 자원 변경');
			$('#updateVMModal').modal('show');
			
			$('#vmBtn').off('click').on('click', function() {
				updateVMCheck(data);
			});
		}
		
		// 유효성 검사
		function updateVMCheck(data) {
			var vCPU = $('#updateVMModal_vCPU').val();
			var memory = $('#updateVMModal_memory').val();
			
			// 유효성 검사
			if (vCPU == data.vmCPU && memory == data.vmMemory) {
				alert('변경된 값이 없습니다.');
				return false;
			}
			
			// vCPU 체크
			if (!vCPU) {
				alert('vCPU 값을 입력해 주세요.');
				$('#updateVMModal_vCPU').focus();
				return false;
			}
			
			if (vCPU > 32 || vCPU < 1) {
				alert('vCPU는 최소 1 개, 최대 32 개까지 입력할 수 있습니다. 다시 입력해 주세요.');
				$('#updateVMModal_vCPU').focus();
				return false;
			}
			
			// memory 체크
			if (!memory) {
				alert('Memory 값을 입력해 주세요.');
				$('#updateVMModal_memory').focus();
				return false;
			}
			
			if (memory > 64 || memory < 1) {
				alert('Memory는 최소 1 GB, 최대 64 GB까지 입력할 수 있습니다. 다시 입력해 주세요.');
				$('#updateVMModal_memory').focus();
				return false;
			}
			
			// 핫플러그 체크
			if (data.cpuHotAdd == true && data.memoryHotAdd == true) {
				updateVMhotPlugCheck(data, vCPU, memory, 'ON');
			
			} else {
				if (confirm('\'' + data.vmName + '\' 가상머신은 핫플러그가 꺼져있습니다.\n자원 변경 시 가상머신이 다시 시작됩니다. 진행하시겠습니까?') == true) {
					updateVMhotPlugCheck(data, vCPU, memory, 'OFF');
				
				} else {
					return false;
				}
			}
		}
		
		// 가상머신 변경
		function updateVMhotPlugCheck(data, vCPU, memory, hotPlug) {
			hotPlug = '\"' + hotPlug + '\"';
			
			$.ajax({
				url: '/apply/changeVMResource.do',
				type: 'POST',
				data: {
					vmID: data.vmID,
					crVMName: data.vmName,
					vmServiceID: data.vmServiceID,
					crCPU: vCPU,
					crMemory: memory,
					hotPlugOnOff: hotPlug
				},
				beforeSend: function() {
					$('#updateVMModal').modal('hide');
					$('#page_loading').removeClass('d-none');
				},
				complete: function() {
					$('#page_loading').addClass('d-none');
				},
				success: function(data) {
					
					// 성공
					if (data == 1) {
						if (confirm('가상머신 자원 변경 실행이 완료되었습니다.\n가상머신 이력에서 결과를 확인하시겠습니까?') == true) {
							location.href = '/log/vmLog.prom';
						
						} else {
							location.reload();
							return false;
						}
					
					// 실패
					} else if (data == 2) {
						alert('변경된 값이 없습니다.');
						return false;
					
					} else {
						alert('가상머신 자원 변경에 실패했습니다.');
						return false;
					}
				}
			})
		}
		
		// 가상머신 전원 관리
		function managePower(data, category) {
			var message = '';
			
			if (category == 1) {
				message = '켜시겠습니까?';
			}
			
			if (category == 2) {
				message = '끄시겠습니까?';
			}
			
			if (category == 3) {
				message = '다시 시작 하시겠습니까?';
			}
			
			// 전원 관리 실행 확인
			if (confirm('\'' + data.vmName + '\' 가상머신의 전원을 ' + message) == true) {
				$.ajax({
					url: '/apply/controlVMState.do',
					type: 'POST',
					data : { 
						vmName : data.vmName,
						stateIndex : category	
					},
					beforeSend: function() {
						$('#page_loading').removeClass('d-none');
					},
					complete: function() {
						$('#page_loading').addClass('d-none');
					},
					success: function(data) {
						if (confirm('실행이 완료되었습니다.\n가상머신 이력에서 결과를 확인하시겠습니까?') == true) {
							location.href = '/log/vmLog.prom';
						
						} else {
							location.reload();
							return false;
						}
					}
				})
			
			} else {
				return false;
			}
		}
		
		// 데이터스토어 목록
		function selectDatastoreList(hostName, modalName) {
			$.ajax({
				url: "/tenant/selectHostDataStoreListByHostID.do",
				type: "POST",
				data: {
					hostID: hostName
				},
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="0" selected disabled>데이터스토어가 없습니다.</option>';
					
					} else {
						for (key in data) {
							html += '<option value="' + data[key].dataStoreID + '">' + data[key].dataStoreName + '</option>';
						}
					}
					
					$('#' + modalName + '_datastore').empty().append(html);
				}
			})
		}
		
		// 네트워크 목록
		function selectNetworkList(hostName, modalName) {
			$.ajax({
				url: '/tenant/selectHostNetworkListByHostID.do',
				type: 'POST',
				data: {
					hostID: hostName
				},
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="0" selected disabled>네트워크가 없습니다.</option>';
					
					} else {
						for (key in data) {
							html += '<option value="' + data[key].netWorkID + '">' + data[key].netWorkName + '</option>';
						}
					}
					
					$('#' + modalName + '_network').empty().append(html);
				}
			})
		}
		
		// Disk 설정 - 정보 모달 설정
		function diskInfo(data) {
			$('.card-loading').removeClass('d-none');
			$('#diskModal .modal-title').html('\'' + data.vmName + '\' 가상머신 Disk 정보');
			
			$('#diskModal').modal('show');
			$('#diskModal').off('shown.bs.modal').on('shown.bs.modal', function() {
				var tableDisk = $('#tableDisk').DataTable();
				tableDisk.destroy();
				
				getDiskList(data);
			});
		}
		
		// Disk 설정 - 테이블
		function getDiskList(data) {
			var tableDisk = $('#tableDisk').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"createB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/apply/selectVMDiskList.do',
					type: 'POST',
					dataSrc: '',
					data: {
						vmID: data.vmID
					},
				},
				columns: [
					{data: 'nSCSInumber'},
					{data: 'sDiskLocation'},
					{data: 'nDiskCapacity'},
					{data: 'status', render: function(data, type, row) {
						data = '<span class="text-on">정상</span>'
						
						return data;
					}}
				],
				language: datatables_lang,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1],	 ['10', '25', '50', '전체']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: 'Disk 정보'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: 'Disk 정보'
					}]
				}, {
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}],
				initComplete: function(settings, data) {
					countDisk = (data.length + 1);
					
					// 테이블 로딩 완료 시 모달 로딩 해제
					$('.card-loading').addClass('d-none');
				}
			});
			
			// 테이블 버튼 설정
			$('#tableDisk_wrapper .createB').html('<button type="button" class="btn createBtn">추가</button>');
			$('#tableDisk_wrapper .createBtn').off('click').on('click', function() {
				addDisk(data, tableDisk);
			});
		}
		
		// Disk 설정 - 추가 모달 및 실행
		function addDisk(data, tableDisk) {
			selectDatastoreList(data.vmHost, 'addDiskModal');
			
			$('#addDiskModal').modal('show');
			
			// Disk 추가 버튼 클릭 시
			$('#diskBtn').off('click').on('click', function() {
				var datastoreId = $('#addDiskModal_datastore option:selected').val();
				var datastoreName = $('#addDiskModal_datastore option:selected').text();
				var capacity = $('#addDiskModal_capacity').val();
				
				if (!capacity) {
					alert('Disk 용량을 입력해 주세요.');
					$('#addDiskModal_capacity').focus();
					return false;
				}
				
				// Disk 추가 실행
				$.ajax({
					url: '/apply/addVMDisk.do',
					type: 'POST',
					data: {
						serviceId : data.vmServiceID,
						sVmName: data.vmName,
						nSCSInumber: countDisk,
						sDiskId: datastoreId,
						sDiskLocation: datastoreName,
						nDiskCapacity: capacity,
						role : 1
					},
					beforeSend: function() {
						$('#diskBtn').html('추가 중...').css('pointer-events', 'none');
					},
					complete: function() {
						$('#diskBtn').html('추가').css('pointer-events', '');
					},
					success: function(data) {
						
						// 추가 성공
						if (data == 1) {
							alert('Disk 추가가 완료되었습니다.');
						
						// 추가 실패
						} else {
							alert('Disk 추가에 실패했습니다.');
							return false;
						}
						
						$('#addDiskModal').modal('hide');
						tableDisk.ajax.reload();
						
						$('#addDiskModal_capacity').val('');
					}
				});
			});
		}
		
		// vNIC 설정 - 정보 모달 설정
		function vNICInfo(data) {
			$('.card-loading').removeClass('d-none');
			$('#vNICModal .modal-title').html('\'' + data.vmName + '\' 가상머신 vNIC 정보');
			
			$('#vNICModal').modal('show');
			$('#vNICModal').off('shown.bs.modal').on('shown.bs.modal', function() {
				var tablevNIC = $('#tablevNIC').DataTable();
				tablevNIC.destroy();
				
				getvNICList(data);
			});
			
			console.log('모달 오픈');
		}
		
		// vNIC 설정 - 테이블
		function getvNICList(data) {
			var tablevNIC = $('#tablevNIC').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"createB"><"manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/apply/selectVMNetworkList.do',
					type: 'POST',
					dataSrc: '',
					data: {
						vmID: data.vmID
					},
				},
				columns: [
					{data: 'labelNumber'},
					{data: 'portgroup'},
					{data: 'ipAddress', render: function(data, type, row) {
						data = data == null || data == '' ? '<span class="text-disabled">없음</span>' : data;
						return data;
					}},
					{data: 'status', render: function(data, type, row) {
						if (data == 'true') {
							data = '<span class="text-on">연결</span>'
						
						} else if (data == 'false') {
							data = '<span class="text-off">연결 해제</span>'
						
						} else {
							data = '<span class="text-off">비정상</span>'
						}
						
						return data;
					}}
				],
				language: datatables_lang,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1],	 ['10', '25', '50', '전체']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: 'vNIC 정보'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: 'vNIC 정보'
					}]
				}, {
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}],
				initComplete: function(settings, data) {
					
					// 테이블 로딩 완료 시 모달 로딩 해제
					$('.card-loading').addClass('d-none');
				}
			});
			
			tablevNICButton(data, tablevNIC);
		}
		
		// vNIC 설정 - 테이블 버튼
		function tablevNICButton(data, tablevNIC) {
			$('#tablevNIC_wrapper .createB').html('<button type="button" class="btn createBtn">추가</button>');
			$('#tablevNIC_wrapper .manageB').html('<button type="button" class="btn manageBtn">연결 상태 변경</button>');
			
			$('#tablevNIC_wrapper .createBtn').off('click').on('click', function() {
				addvNIC(data, tablevNIC);
			});
			
			$('#tablevNIC_wrapper .manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tablevNIC tbody').on('click', 'tr', function() {
				var data = tablevNIC.row(this).data();
				console.log(data);
				
				if (data != undefined) {
					$(this).addClass('selected');
					$('#tablevNIC tr').not(this).removeClass('selected');
					
					$('#tablevNIC_wrapper .manageBtn').html(data.status == 'true' ? '연결 해제' : '연결');
					$('#tablevNIC_wrapper .manageBtn').off('click').on('click', function() {
						updatevNIC(data, tablevNIC);
					});
				}
			});
		}
		
		// vNIC 설정 - 추가 모달 및 실행
		function addvNIC(data, tablevNIC) {
			selectNetworkList(data.vmHost, 'addvNICModal');
			
			$('#addvNICModal').modal('show');
			
			// vNIC 추가 버튼 클릭 시
			$('#vNICBtn').off('click').on('click', function() {
				var networkId = $('#addvNICModal_network option:selected').val();
				var networkName = $('#addvNICModal_network option:selected').text();
				
				// vNIC 추가 실행
				$.ajax({
					url: '/apply/addVMNetwork.do',
					type: 'POST',
					data: {
						serviceId : data.vmServiceID,
						sVmName: data.vmName,
						portgroupId: networkId,
						portgroup: networkName,
						role : 1
					},
					beforeSend: function() {
						$('#vNICBtn').html('추가 중...').css('pointer-events', 'none');
					},
					complete: function() {
						$('#vNICBtn').html('추가').css('pointer-events', '');
					},
					success: function(data) {
						
						// 추가 성공
						if (data == 1) {
							alert('Network 추가가 완료되었습니다.');
						
						// 추가 실패
						} else {
							alert('Network 추가에 실패했습니다.');
							return false;
						}
						
						$('#addvNICModal').modal('hide');
						tablevNIC.ajax.reload();
					}
				});
			});
		}
		
		// vNIC 설정 - 상태 변경
		function updatevNIC(data, tablevNIC) {
			var category = data.status == 'true' ? 'Disconnect' : 'Connect';
			
			$.ajax({
				url: "/apply/controlVMNetwork.do",
				type: 'POST',
				data: {
					mode: category,
					sVmName: data.sVmName,
					labelNumber: data.labelNumber,
					portgroup: data.portgroup
				},
				beforeSend: function() {
					$('.card-loading').removeClass('d-none');
				},
				complete: function() {
					$('.card-loading').addClass('d-none');
				},
				success: function(data) {
					
					// 상태 변경 성공
					if (data == 1) {
						alert('상태 변경이 완료되었습니다.');
					
					// 실패
					} else {
						alert('상태 변경에 실패했습니다.');
						return false;
					}
					
					$('#tablevNIC_wrapper .manageBtn').html('연결 상태 변경');
					tablevNIC.ajax.reload();
				}
			})
		}
		
		// CD-ROM 설정 - 정보 모달 설정
		function cdromInfo(data) {
			$('.card-loading').removeClass('d-none');
			$('#cdromModal .modal-title').html('\'' + data.vmName + '\' 가상머신 CD-ROM 정보');
			
			$('#cdromModal').modal('show');
			$('#cdromModal').off('shown.bs.modal').on('shown.bs.modal', function() {
				var tableCDROM = $('#tableCDROM').DataTable();
				tableCDROM.destroy();
				
				getCDROMList(data);
			});
		}
		
		// CD-ROM 설정 - 테이블
		function getCDROMList(data) {
			var tableCDROM = $('#tableCDROM').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"createB"><"manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/apply/selectVMCDROMList.do',
					type: 'POST',
					dataSrc: '',
					data: {
						vmID: data.vmID
					},
				},
				columns: [
					{data: 'nSCSInumber'},
					{data: 'dataStoreName'},
					{data: 'filePath'},
					{data: 'status', render: function(data, type, row) {
						if (data == 'true') {
							data = '<span class="text-on">연결</span>'
						
						} else if (data == 'false') {
							data = '<span class="text-off">연결 해제</span>'
						
						} else {
							data = '<span class="text-off">비정상</span>'
						}
						
						return data;
					}}
				],
				language: datatables_lang,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1],	 ['10', '25', '50', '전체']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: 'CD-ROM 정보'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: 'CD-ROM 정보'
					}]
				}, {
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}],
				initComplete: function(settings, data) {
					countCDROM = (data.length + 1);
					
					// 테이블 로딩 완료 시 모달 로딩 해제
					$('.card-loading').addClass('d-none');
				}
			});
			
			tableCDROMButton(data, tableCDROM);
		}
		
		// CD-ROM 설정 - 테이블 버튼
		function tableCDROMButton(data, tableCDROM) {
			$('#tableCDROM_wrapper .createB').html('<button type="button" class="btn createBtn">연결 추가</button>');
			$('#tableCDROM_wrapper .manageB').html('<button type="button" class="btn manageBtn">연결 상태 변경</button>');
			
			$('#tableCDROM_wrapper .createBtn').off('click').on('click', function() {
				addCDROM(data, tableCDROM);
			});
			
			$('#tableCDROM_wrapper .manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableCDROM tbody').on('click', 'tr', function() {
				var data = tableCDROM.row(this).data();
				
				if (data != undefined) {
					$(this).addClass('selected');
					$('#tableCDROM tr').not(this).removeClass('selected');
					
					$('#tableCDROM_wrapper .manageBtn').html(data.status == 'true' ? '연결 해제' : '연결');
					$('#tableCDROM_wrapper .manageBtn').off('click').on('click', function() {
						updateCDROM(data, tableCDROM);
					});
				}
			});
		}
		
		// CD-ROM 설정 - 추가 모달 및 실행
		function addCDROM(data, tableCDROM) {
			selectDatastoreList(data.vmHost, 'addCDROMModal');
			
			$('#addCDROMModal').modal('show');
			
			// CD-ROM 추가 버튼 클릭 시
			$('#cdromBtn').off('click').on('click', function() {
				var datastoreName = $('#addCDROMModal_datastore option:selected').text();
				var file = $('#addCDROMModal_file').val();
				
				if (!file) {
					alert('연결할 파일을 입력해 주세요.');
					$('#addCDROMModal_file').focus();
					return false;
				}
				
				// CD-ROM 추가 실행
				$.ajax({
					url: '/apply/mountVMCDROM.do',
					type: 'POST',
					data: {
						serviceId :  data.vmServiceID,
						sVmID: data.vmID,
						sVmName: data.vmName,
						dataStoreName: datastoreName,
						filePath: file,
						role : 1
					},
					beforeSend: function() {
						$('#cdromBtn').html('추가 중...').css('pointer-events', 'none');
					},
					complete: function() {
						$('#cdromBtn').html('추가').css('pointer-events', '');
					},
					success: function(data) {
						
						// 추가 성공
						if (data == 1) {
							alert('CD-ROM 추가가 완료되었습니다.');
						
						// 추가 실패
						} else if (data == 2) {
							alert('이미 CD-ROM에 CD가 연결되어있습니다.');
							return false;
							
						} else {
							alert('CD-ROM 추가에 실패했습니다.');
							return false;
						}
						
						$('#addCDROMModal').modal('hide');
						tableCDROM.ajax.reload();
						
						$('#addCDROMModal_file').val('');
					}
				});
			});
		}
		
		// CD-ROM 설정 - CD-ROM 상태 변경
		function updateCDROM(data, tableCDROM) {
			var category = data.status == 'true' ? 'UNMOUNT' : 'MOUNT';
			
			$.ajax({
				url: '/apply/controlVMCDROM.do',
				type: 'POST',
				data: {
					mode: category,
					sVmID: data.sVmID,
					sVmName: data.vmName,
					dataStoreName: data.dataStoreName,
					filePath: data.filePath
				},
				beforeSend: function() {
					$('.card-loading').removeClass('d-none');
				},
				complete: function() {
					$('.card-loading').addClass('d-none');
				},
				success: function(data) {
					alert('상태 변경이 완료되었습니다.');
					
					$('#tableCDROM_wrapper .manageBtn').html('연결 상태 변경');
					tableCDROM.ajax.reload();
				}
			});
		}
		
		// 가상머신 삭제
		function deleteVM(data) {
			
			// 삭제 확인
			if (confirm('\'' + data.vmName + '\' 가상머신을 삭제하시겠습니까?') == true) {
				$.ajax({
					url: '/apply/deleteVM.do',
					type: 'POST',
					data: {
						vmName: data.vmName,
					},
					beforeSend: function() {
						$('#page_loading').removeClass('d-none');
					},
					complete: function() {
						$('#page_loading').addClass('d-none');
					},
					success: function(data) {
						
						// 삭제 성공
						if (data == 2) {
							if (confirm('가상머신 삭제 실행이 완료되었습니다.\n가상머신 이력에서 결과를 확인하시겠습니까?') == true) {
								location.href = '/log/vmLog.prom';
							
							} else {
								location.reload();
								return false;
							}

						// 삭제 실패
						} else {
							alert('가상머신 삭제에 실패했습니다.');
							return false;
						}
					}
				})
		
			} else {
				return false;
			}
		}
	</script>
</body>

</html>