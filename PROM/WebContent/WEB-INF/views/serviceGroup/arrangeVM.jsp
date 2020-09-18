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
		
			<!-- 가상머신 배치 모달 -->
			<div class="modal fade" id="arrangeModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">가상머신 배치</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card modal-card-title">
								<b>가상머신 배치</b><span class="text-disabled">선택한 가상머신을 배치할 서비스를 선택해 주세요.</span>
							</div>
							<div class="modal-card">
								<div class="row">
									<div class="col-6">
										<label>서비스 그룹 <span class="text-danger">*</span></label>
										<select class="form-control mb-0" id="arrangeModal_serviceGroup"></select>
									</div>
									<div class="col-6">
										<label>서비스 <span class="text-danger">*</span></label>
										<select class="form-control mb-0" id="arrangeModal_service"></select>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" id="arrangeBtn">배치</button>
							<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
		
			<div class="row">
				<div class="col-xl-6 col-sm-12">
					<h6 style="margin-bottom: 15px;">서비스 배치 가상머신</h6>
					<div class="card card-body">
						<table id="tableArrangeVM" class="cell-border hover arrange-table" style="width:100%;">
							<thead>
								<tr>
									<th class="selecteAll"><span></span></th>
									<th>테넌트</th>
									<th>서비스</th>
									<th>가상머신</th>
									<th>vCPU</th>
									<th>Memory</th>
									<th>Disk</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				<div class="col-xl-6 col-sm-12">
					<h6 style="margin-bottom: 15px;">서비스 미배치 가상머신</h6>
					<div class="card card-body">
						<table id="tableUnArrangeVM" class="cell-border hover arrange-table" style="width:100%;">
							<thead>
								<tr>
									<th class="selecteAll"><span></span></th>
									<th>가상머신</th>
									<th>vCPU</th>
									<th>Memory</th>
									<th>Disk</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script>
		$(document).ready(function() {
			
			// 서비스 그룹 셀렉트 박스 변경 시
			$('#arrangeModal_serviceGroup').change(function () {
				var serviceGroupId = $('#arrangeModal_serviceGroup option:selected').val();
				selectServiceList(serviceGroupId);
			});
			
			getArrangeVMList();
			getUnArrangeVMList();
		});

		// 서비스 배치 가상머신 테이블
		function getArrangeVMList() {
			var tableArrangeVM = $('#tableArrangeVM').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"unArrangeB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/tenant/selectArrangedVMList.do',
					type: 'POST',
					dataSrc: ''
				},
				columns: [
					{data: 'vmID', orderable: false, render: function(data, type, row) {
						data = '<div id=' + data + '></div>';
						return data;
					}, className: 'select-checkbox'},
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
					}}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
				select: {style: 'multi', selector: 'tr'},
				order: [[1, 'ase']],
				buttons: [{
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}],
				initComplete: function(settings, data) {
					
					// 배치 가상머신 전체 선택/전체 해제 설정
					
					// selecteAll 체크 박스를 선택할 때마다 실행
					$('#tableArrangeVM .selecteAll').off('click').on('click', function() {
						$(this).toggleClass('checked');
						$(this).hasClass('checked') ? tableArrangeVM.rows().select() : tableArrangeVM.rows().deselect();
					});
					
					// 해당 테이블의 행을 선택할 때마다 실행
					$('#tableArrangeVM tbody').on('click', 'tr', function() {
						$(this).toggleClass('selected');
						
						var arrangeVMData = tableArrangeVM.rows('.selected').data();
						arrangeVMData.length == data.length ? $('#tableArrangeVM .selecteAll').addClass('checked') : $('#tableArrangeVM .selecteAll').removeClass('checked');
					});
				}
			});
			
			$('.unArrangeB').html('<button type="button" class="btn unArrangeBtn">제외하기</button>');
			$('.unArrangeBtn').off('click').on('click', function() {
				unArrangeVM(tableArrangeVM);
			});
		}
		
		// 가상머신 제외하기 실행
		function unArrangeVM(tableArrangeVM) {
			var vmId = [];
			var vmName = [];
			var data = tableArrangeVM.rows('.selected').data();

			$(data).each(function() {
				vmId.push($(this).attr('vmID'));
				vmName.push($(this).attr('vmName'));
			});

			if (vmId == '' && vmName == '') {
				alert('가상머신을 선택해 주세요.');
				return false;
			}
			
			$.ajax({
				url: '/tenant/unarrangeVM.do',
				type: 'POST',
				traditional: true,
				async: false,
				data: {
					vmIDList: vmId,
					vmNameList: vmName,
				},
				success: function(data) {
					alert('가상머신 제외가 완료되었습니다.');
					location.reload();
				}
			})
		}
		
		// 서비스 미배치 가상머신 테이블
		function getUnArrangeVMList() {
			var tableUnArrangeVM = $('#tableUnArrangeVM').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"arrangeB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/tenant/selectUnarrangedVMList.do',
					type: 'POST',
					dataSrc: ''
				},
				columns: [
					{data: 'vmID', orderable: false, render: function(data, type, row) {
						data = '<div id=' + data + '></div>';
						return data;
					}, className: 'select-checkbox'},
					{data: 'vmName'},
					{data: 'vmCPU'},
					{data: 'vmMemory', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'vmDisk', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
				select: {style: 'multi', selector: 'tr'},
				order: [[1, 'ase']],
				buttons: [{
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}],
				initComplete: function(settings, data) {
					
					// 미배치 가상머신 전체 선택/전체 해제 설정
					
					// selecteAll 체크 박스를 선택할 때마다 실행
					$('#tableUnArrangeVM .selecteAll').off('click').on('click', function() {
						$(this).toggleClass('checked');
						$(this).hasClass('checked') ? tableUnArrangeVM.rows().select() : tableUnArrangeVM.rows().deselect();
					});
					
					// 해당 테이블의 행을 선택할 때마다 실행
					$('#tableUnArrangeVM tbody').on('click', 'tr', function() {
						$(this).toggleClass('selected');
						
						var unArrangeVMData = tableUnArrangeVM.rows('.selected').data();
						unArrangeVMData.length == data.length ? $('#tableUnArrangeVM .selecteAll').addClass('checked') : $('#tableUnArrangeVM .selecteAll').removeClass('checked');
					});
				}
			});
			
			$('.arrangeB').html('<button type="button" class="btn arrangeBtn">배치하기</button>');
			$('.arrangeBtn').off('click').on('click', function() {
				arrangeVM(tableUnArrangeVM);
			});
		}
		
		// 서비스 그룹 목록
		function selectServiceGroupList() {
			$.ajax({
				url: '/tenant/selectTenantList.do',
				type: 'POST',
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="-2" selected disabled>서비스 그룹이 없습니다.</option>';
					
					} else {
						for (key in data) {
								html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
						}
					}
					
					$('#arrangeModal_serviceGroup').empty().append(html);
					
					var serviceGroupId = $('#arrangeModal_serviceGroup option:selected').val();
					selectServiceList(serviceGroupId);
				}
			})
		}

		// 서비스 목록
		function selectServiceList(serviceGroupId) {
			if (serviceGroupId == '-2') {
				$('#selectService').html('<option value="-2" selected disabled>서비스가 없습니다.</option>');
			
			} else {
				$.ajax({
					url: '/tenant/selectVMServiceListByTenantId.do',
					type: 'POST',
					data: {
						tenantId: serviceGroupId
					},
					success: function(data) {
						var html = '';
						
						if (data == null || data == '') {
							html += '<option value="-2" selected disabled>서비스가 없습니다.</option>';
					
						} else {
							for (key in data) {
								html += '<option value="' + data[key].vmServiceID + '">' + data[key].vmServiceName + '</option>';
							}
						}
						
						$('#arrangeModal_service').empty().append(html);
					}
				})
			}
		}
		
		// 가상머신 배치하기 실행
		function arrangeVM(tableUnArrangeVM) {
			var vmId = [];
			var vmName = [];
			var data = tableUnArrangeVM.rows('.selected').data();

			$(data).each(function() {
				vmId.push($(this).attr('vmID'));
				vmName.push($(this).attr('vmName'));
			});

			if (vmId == '' && vmName == '') {
				alert('가상머신을 선택해 주세요.');
				return false;
			}
			
			// 서비스 배치 모달 실행
			selectServiceGroupList();
			$('#arrangeModal').modal('show');
			
			$('#arrangeBtn').off('click').on('click', function() {
				var serviceGroupName = $('#arrangeModal_serviceGroup option:selected').text();
				var serviceId = $('#arrangeModal_service option:selected').val();
				var serviceName = $('#arrangeModal_service option:selected').text();
				
				$.ajax({
					url: '/tenant/arrangeVM.do',
					type: 'POST',
					traditional: true,
					async: false,
					data: {
						vmIDList: vmId,
						vmNameList: vmName,
						tenantName: serviceGroupName,
						vmServiceID: serviceId,
						vmServiceName: serviceName
					},
					success: function(data) {
						
						// 배치 성공
						alert('가상머신 배치가 완료되었습니다.');
						location.reload();
					}
				});
			});
		}
	</script>
</body>

</html>