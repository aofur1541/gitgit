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
		
			<!-- 서비스 그룹 배치 모달 -->
			<div class="modal fade" id="arrangeModal" tabindex="-1">
				<div class="modal-dialog modal-xl modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">서비스 그룹 배치</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="loading-background card-loading modal-loading"><div class="spinner-border" role="status"></div></div>
							<div class="modal-card modal-card-title">
								<b>사용자 배치</b><span class="text-disabled">해당 사용자를 배치할 서비스 그룹을 선택해 주세요.</span>
							</div>
							<div class="modal-card">
								
								<!-- 미배치 가상머신 테이블 -->
								<table id="tableVM" class="cell-border hover arrange-table" style="width: 100%;">
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
						<div class="modal-footer">
							<div><button type="button" class="btn" id="arrangeBtn">배치</button></div>
							<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
		
			<!-- 서비스 모달 -->
			<div class="modal fade" id="serviceModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">서비스 등록</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<div class="row">
									<div class="col-6">
										<label>서비스 그룹 <span class="text-danger">*</span></label>
										 <select class="form-control" id="serviceModal_serviceGroup"></select>
									</div>
									<div class="col-6">
										<label>서비스 <span class="text-danger">*</span></label>
										<input type="text" class="form-control" placeholder="서비스" autocomplete="off" maxlength="30" id="serviceModal_service">
									</div>
								</div>
								<div class="row">
									<div class="col-6">
										<label>게이트웨이 <span class="text-danger">*</span></label>
										 <input type="text" class="form-control" placeholder="게이트웨이" autocomplete="off" maxlength="20" id="serviceModal_gateway">
									</div>
									<div class="col-6">
										<label>서브넷 마스크 <span class="text-danger">*</span></label>
										<input type="text" class="form-control" placeholder="서브넷 마스크" autocomplete="off" maxlength="20" id="serviceModal_subnetMask">
									</div>
								</div>
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" class="custom-control-input" id="serviceModal_dhcpOn" name="serviceModal_useDHCP" value="1" checked>
									<label class="custom-control-label" for="serviceModal_dhcpOn">DHCP 사용</label>
								</div>
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" class="custom-control-input" id="serviceModal_dhcpOff" name="serviceModal_useDHCP" value="0">
									<label class="custom-control-label" for="serviceModal_dhcpOff">DHCP 미사용</label>
								</div>
							</div>
							<div class="modal-card">
								<label>서비스 관리자</label>
								<select class="form-control" id="serviceModal_serviceAdmin"></select>
								<div class="row">
									<div class="col-6">
										<label>클러스터</label>
										<select class="form-control" id="serviceModal_cluster"></select>
									</div>
									<div class="col-6">
										<label>호스트</label>
										<select class="form-control" id="serviceModal_host"></select>
									</div>
								</div>
								<div class="row">
									<div class="col-6">
										<label>데이터스토어</label>
										<select class="form-control" id="serviceModal_datastore"></select>
									</div>
									<div class="col-6">
										<label>네트워크</label>
										<select class="form-control" id="serviceModal_network"></select>
									</div>
								</div>
								<label>설명</label>
								<input type="text" class="form-control mb-0" placeholder="서비스 설명" autocomplete="off" maxlength="40" id="serviceModal_description">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" id="serviceBtn">등록</button>
							<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 서비스 테이블 -->
			<table id="tableService" class="cell-border hover" style="width:100%;">
				<thead>
					<tr>
						<th>테넌트</th>
						<th>서비스</th>
						<th>서비스 관리자</th>
						<th>가상머신 수</th>
						<th>클러스터</th>
						<th>호스트</th>
						<th>데이터스토어</th>
						<th>네트워크</th>
						<th>DHCP</th>
						<th>설명</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			getServiceList();
			
			// 서비스 그룹 셀렉트 박스 변경 시
			$('#serviceModal_serviceGroup').change(function () {
				var serviceGroupId = $('#serviceModal_serviceGroup option:selected').val();
				selectUserList(serviceGroupId);
			});
			
			// 클러스터 셀렉트 박스 변경 시
			$('#serviceModal_cluster').change(function() {
				var clusterName= $('#serviceModal_cluster option:selected').val();
				selectHostList(clusterName);
			});
			
			// 호스트 셀렉트 박스 변경 시
			$('#serviceModal_host').change(function() {
				var hostName = $('#serviceModal_host option:selected').val();
				selectDatastoreList(hostName);
				selectNetworkList(hostName);
			});
			
			// DHCP 변경 시
			$('input[name="serviceModal_useDHCP"]').change(function() {
				var dhcp = $('input[name="serviceModal_useDHCP"]:checked').val();
				changeDHCP(dhcp);
			});
		})
		
		// DHCP 변경 시
		function changeDHCP(dhcp) {
			
			// OFF
			if (dhcp == 0) {
				$('#serviceModal_gateway').attr('disabled', false);
				$('#serviceModal_subnetMask').attr('disabled', false);
			
			// ON
			} else if (dhcp == 1) {
				$('#serviceModal_gateway').val('').attr('disabled', true);
				$('#serviceModal_subnetMask').val('').attr('disabled', true);
			}
		}
		
		// 서비스 테이블
		function getServiceList() {
			var tableService = $('#tableService').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"createB"><"manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/tenant/selectVMServiceList.do',
					type: 'POST',
					dataSrc: ''
				},
				columns: [
					{data: 'tenantName'},
					{data: 'vmServiceName'},
					{data: 'vmServiceUserName', render: function(data, type, row) {
						data = data == '관리자 미지정' ? '<span class="text-disabled">미지정</span>' : data;
						return data;
					}},
					{data: 'countVM'},
					{data: 'defaultCluster', render: function(data, type, row) {
						data = data == 0 || data == '' ? '<span class="text-disabled">미지정</span>' : data;
						return data;
					}},
					{data: 'defaultHost', render: function(data, type, row) {
						data = data == 0 || data == '' ? '<span class="text-disabled">미지정</span>' : data;
						return data;
					}},
					{data: 'defaultStorageName', render: function(data, type, row) {
						data = data == '미지정' ? '<span class="text-disabled">미지정</span>' : data;
						return data;
					}},
					{data: 'defaultNetworkName', render: function(data, type, row) {
						data =data == '미지정' ? '<span class="text-disabled">미지정</span>' : data;
						return data;
					}},
					{data: 'dhcpOnoff', render: function(data, type, row) {
						if (data == 1) {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 2) {
							data = '<span class="text-off">OFF</span>';
						}
						
						return data;
					}},
					{data: 'description'}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '서비스 정보'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '서비스 정보'
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
			
			tableServiceButton(tableService);
		}
		
		// 관리 버튼 설정
		function tableServiceButton(tableService) {
			$('.createB').html('<button type="button" class="btn createBtn" onclick="insertService()">등록</button>');
			$('.manageB').html('<button type="button" class="btn manageBtn">관리</button>');
			
			$('.manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableService').on('click', 'tr', function() {
				var data = tableService.row(this).data();
				
				if (data != undefined){
					$(this).addClass('selected');
					$('#tableService tr').not(this).removeClass('selected');
					
					// 관리 버튼 활성화
					var html = '';
					
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown">관리</button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" id="updateService">서비스 정보 변경</a>';
					html += '<a href="#" class="dropdown-item" id="deleteService">서비스 삭제</a>';
					html += '</div>';
					
					$('.manageB').empty().append(html);
					
					$('#updateService').off('click').on('click', function() {
						updateService(data);
					});
					
					$('#deleteService').off('click').on('click', function() {
						deleteService(data);
					});
				}
			});
		}
		
		// 서비스 그룹 목록
		function selectServiceGroupList(serviceGroupId, adminId) {
			$.ajax({
				url: '/tenant/selectTenantList.do',
				type: 'POST',
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="-2" selected disabled>서비스 그룹이 없습니다.</option>';
					
					} else {
						for (key in data) {
							if (serviceGroupId && serviceGroupId == data[key].id) {
								html += '<option value="' + data[key].id + '" selected>' + data[key].name + '</option>';
							
							} else {
								html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
							}
						}
					}
					
					$('#serviceModal_serviceGroup').empty().append(html);
					
					serviceGroupId = !serviceGroupId ? $('#serviceModal_serviceGroup option:selected').val() : serviceGroupId;
					selectUserList(serviceGroupId, adminId);
				}
			})
		}
		
		// 서비스 관리자 목록
		function selectUserList(serviceGroupId, adminId) {
			if (serviceGroupId == '-2') {
				$('#serviceModal_serviceAdmin').html('<option value="" selected disabled>사용자가 없습니다.</option>');
			
			} else {
				$.ajax({
					url: '/user/selectUserTenantMappingList.do',
					type: 'POST',
					data: {
						tenantId: serviceGroupId
					},
					success: function(data) {
						console.log(data);
						
						var html = '';
						
						if (data == null || data == '') {
							html += '<option value="" selected disabled>사용자가 없습니다.</option>';
						
						} else {
							html += '<option value="">미지정</option>';
							for (key in data) {
								if (adminId && adminId == data[key].id) {
									html += '<option value="' + data[key].id + '" selected>' + data[key].sName + '</option>';
								
								} else {
									html += '<option value="' + data[key].id + '">' + data[key].sName + '</option>';
								}
							}
						}
						
						$('#serviceModal_serviceAdmin').empty().append(html);
					}
				})
			}
		}
		
		// 클러스터 목록
		function selectClusterList(clusterName, hostName, datastoreId, networkId) {
			$.ajax({
				url: '/tenant/selectClusterList.do',
				type: 'POST',
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="0" selected disabled>클러스터가 없습니다.</option>';
					
					} else {
						html += '<option value="" selected>미지정</option>';
						for (key in data) {
							if (clusterName && clusterName == data[key].clusterName) {
								html += '<option value="' + data[key].clusterName + '" selected>' + data[key].clusterName + '</option>';
								
							} else {
								html += '<option value="' + data[key].clusterName + '">' + data[key].clusterName + '</option>';
							}
						}
					}
					
					$('#serviceModal_cluster').empty().append(html);
					
					clusterName = !clusterName ? $('#serviceModal_cluster option:selected').val() : clusterName;
					selectHostList(clusterName, hostName, datastoreId, networkId);
				}
			})
		}

		// 호스트 목록
		function selectHostList(clusterName, hostName, datastoreId, networkId) {
			
			// 클러스터 미지정
			if (clusterName == '' || clusterName == 0) {
				$('#serviceModal_host').html('<option value="" selected >미지정</option>');
				$('#serviceModal_datastore').html('<option value="" selected>미지정</option>');
				$('#serviceModal_network').html('<option value="" selected>미지정</option>');
				
			// 서비스 있을 때
			} else {
				$.ajax({
					url: '/tenant/selectVMHostList.do',
					type: 'POST',
					data: {
						hostParent: clusterName
					},
					success: function(data) {
						var html = '';
						
						if (data == null || data == '') {
							html += '<option value="0" selected disabled>호스트가 없습니니다.</option>';
						
						} else {
							for (key in data) {
								if (hostName && hostName == data[key].vmHhostname) {
									html += '<option value="' + data[key].vmHhostname + '" selected>' + data[key].vmHhostname + '</option>';
								
								} else {
									html += '<option value="' + data[key].vmHhostname + '">' + data[key].vmHhostname + '</option>';
								}
							}
						}
						
						$('#serviceModal_host').empty().append(html);
						
						hostName = !hostName ? $('#serviceModal_host option:selected').val() : hostName;
						selectDatastoreList(hostName, datastoreId);
						selectNetworkList(hostName, networkId);
					}
				})
			}
		}

		// 데이터스토어 목록
		function selectDatastoreList(hostName, datastoreId) {
			if (hostName == '0') {
				$('#serviceModal_datastore').empty().append('<option value="0" selected disabled>데이터스토어가 없습니다.</option>');
				
			} else {
				$.ajax({
					url: '/tenant/selectHostDataStoreListByHostID.do',
					type: 'POST',
					data: {
						hostID: hostName
					},
					success: function(data) {
						var html = '';
						
						if (data == null || data == '') {
							html += '<option value="0" selected disabled>데이터스토어가 없습니다.</option>';
						
						} else {
							for (key in data) {
								if (datastoreId && datastoreId == data[key].dataStoreID) {
									html += '<option value="' + data[key].dataStoreID + '" selected>' + data[key].dataStoreName + '</option>';
								
								} else {
									html += '<option value="' + data[key].dataStoreID + '">' + data[key].dataStoreName + '</option>';
								}
							}
						}
						
						$('#serviceModal_datastore').empty().append(html);
					}
				})
			}
		}

		// 네트워크 목록
		function selectNetworkList(hostName, networkId) {
			if (hostName == '0') {
				$('#serviceModal_network').empty().append('<option value="0" selected disabled>네트워크가 없습니다.</option>');
				
			} else {
				$.ajax({
					url: "/tenant/selectHostNetworkListByHostID.do",
					type: "POST",
					data: {
						hostID: hostName
					},
					success: function(data) {
						var html = '';
						
						if (data == null || data == '') {
							html += '<option value="0" selected disabled>네트워크가 없습니다.</option>';
						
						} else {
							for (key in data) {
								if (networkId && networkId == data[key].netWorkID) {
									html += '<option value="' + data[key].netWorkID + '" selected>' + data[key].netWorkName + '</option>';
								
								} else {
									html += '<option value="' + data[key].netWorkID + '">' + data[key].netWorkName + '</option>';
								}
							}
						}
						
						$('#serviceModal_network').empty().append(html);
					}
				})
			}
		}
		
		// 등록/변경 모달 값 초기화
		function clearModal() {
			
			// 셀렉트 박스 초기화
			selectServiceGroupList();
			selectClusterList();
			
			// 값 초기화
			$('#serviceModal_service').val('');
			$('#serviceModal_description').val('');
			$('#serviceModal_gateway').val('').attr('disabled', false);
			$('#serviceModal_subnetMask').val('').attr('disabled', false);
			
			$('input[name="serviceModal_useDHCP"][value="1"]').prop('checked', true);
			changeDHCP('1');
		}
		
		// 등록 모달 설정
		function insertService() {
			
			// 모달 초기화
			clearModal();

			$('.modal-title').html('서비스 등록');
			$('#serviceBtn').html('등록');
			$('#serviceBtn').attr('onclick', 'validationService("create");');
			
			$('#serviceModal').modal('show');
			
			// 등록 창 열리면 첫번째 폼 포커스
			$('#serviceModal').on('shown.bs.modal', function () {
				$('#serviceModal_service').focus();
			})
		}
		
		// 변경 모달 설정
		function updateService(data) {
			selectServiceGroupList(data.tenantId, data.vmServiceUserID);
			selectClusterList(data.defaultCluster, data.defaultHost, data.defaultStorage, data.defaultNetwork);
			
			console.log(data.defaultCluster, data.defaultHost, data.defaultStorage, data.defaultNetwork);
			
			$('#serviceModal_service').val(data.vmServiceName);
			$('#serviceModal_description').val(data.description);
			$('#serviceModal_gateway').val(data.defaultGateway);
			$('#serviceModal_subnetMask').val(data.defaultNetmask);
			
			if (data.dhcpOnoff == 2) {
				$('input[name="serviceModal_useDHCP"][value="0"]').prop('checked', true);
				changeDHCP('0');

			} else if (data.dhcpOnoff == 1) {
				$('input[name="serviceModal_useDHCP"][value="1"]').prop('checked', true);
				changeDHCP('1');
			}
	
			$('.modal-title').html('\'' + data.vmServiceName + '\' 서비스 정보 변경');
			$('#serviceBtn').html('변경');
			$('#serviceBtn').attr('onclick', 'validationService("update", "' + data.vmServiceID + '")');
			
			$('#serviceModal').modal('show');
		}

		// 유효성 검사
		function validationService(category, id) {
			var serviceGroupId = $('#serviceModal_serviceGroup option:selected').val();
			var serviceGroupName = $('#serviceModal_serviceGroup option:selected').text();
			var service = $('#serviceModal_service').val();
			var serviceAdminId = $('#serviceModal_serviceAdmin option:selected').val();
			var serviceAdminName = $('#serviceModal_serviceAdmin option:selected').text();
			var gateway = $('#serviceModal_gateway').val();
			var subnetMask = $('#serviceModal_subnetMask').val();
			var useDHCP = $('input[name="serviceModal_useDHCP"]:checked').val();
			useDHCP = useDHCP == 0 ? 2 : 1;
			var clusterName = $('#serviceModal_cluster option:selected').val();
			var hostName = $('#serviceModal_host option:selected').val();
			var datastoreId = $('#serviceModal_datastore option:selected').val();
			var datastoreName = $('#serviceModal_datastore option:selected').text();
			var networkId = $('#serviceModal_network option:selected').val();
			var networkName = $('#serviceModal_network option:selected').text();
			var description = $('#serviceModal_description').val();
			
			if (serviceGroupId == -2) {
				alert('서비스 그룹을 선택해 주세요.');
				$('#serviceModal_serviceGroup').focus();
				return false;
			}
			
			if (!service) {
				alert('서비스 이름을 입력해 주세요.');
				$('#serviceModal_service').focus();
				return false;
			}

			if (pattern_blank.test(service)) {
				alert('서비스 이름에 공백은 사용할 수 없습니다. 다시 입력해 주세요.');
				$('#serviceModal_service').focus();
				return false;
			}

			if (pattern_spc.test(service)) {
				alert('서비스 이름에 특수문자는 사용할 수 없습니다. 다시 입력해 주세요.');
				$('#serviceModal_service').focus();
				return false;
			}
			
			// DHCP를 사용하고 네트워크를 지정하면 게이트웨이, 서브넷 마스크 필수 입력
			if (networkId && useDHCP == 2) {
				if (!gateway) {
					alert('게이트웨이를 입력해 주세요.');
					$('#serviceModal_gateway').focus();
					return false;
				}
				
				if (!pattern_ipAddress.test(gateway)) {
					alert('게이트웨이 형식이 다릅니다. 다시 입력해 주세요.');
					$('#serviceModal_gateway').focus();
					return false;
				}
				
				if (!subnetMask) {
					alert('서브넷 마스크를 입력해 주세요.');
					$('#serviceModal_subnetMask').focus();
					return false;
				}
				
				if (!pattern_ipAddress.test(subnetMask)) {
					alert('서브넷 마스크 형식이 다릅니다. 다시 입력해 주세요.');
					$('#serviceModal_subnetMask').focus();
					return false;
				}
			}			
			
			// 등록
			if (category == 'create' && !id) {
				$.ajax({
					url: '/tenant/insertVMService.do',
					type: 'POST',
					data: {
						tenantId: serviceGroupId,
						tenantName: serviceGroupName,
						vmServiceName: service,
						vmServiceUserID: serviceAdminId,
						vmServiceUserName: serviceAdminName,
						defaultGateway: gateway,
						defaultNetmask: subnetMask,
						dhcpOnoff: useDHCP,
						defaultCluster: clusterName,
						defaultHost: hostName,
						defaultStorage: datastoreId,
						defaultStorageName: datastoreName,
						defaultNetwork: networkId,
						defaultNetworkName: networkName,
						description: description,
					},
					success: function(data) {
						
						// 등록 성공
						if (data == 1) {
							alert('서비스 등록이 완료되었습니다.');
							location.reload();
						
						// 등록 실패
						} else if (data == 2) {
							alert('동일한 서비스 이름이 있습니다. 다시 입력해 주세요.');
							$('#serviceModal_service').focus();
							return false;
						
						} else {
							alert('서비스 등록에 실패했습니다.');
							return false;
						}
					}
				})
			}
			
			// 변경
			if (category == 'update' && id) {
				$.ajax({
					url: '/tenant/updateVMService.do',
					type: 'POST',
					data: {
						vmServiceID: id,
						tenantId: serviceGroupId,
						tenantName: serviceGroupName,
						vmServiceName: service,
						vmServiceUserID: serviceAdminId,
						vmServiceUserName: serviceAdminName,
						defaultGateway: gateway,
						defaultNetmask: subnetMask,
						dhcpOnoff: useDHCP,
						defaultCluster: clusterName,
						defaultHost: hostName,
						defaultStorage: datastoreId,
						defaultStorageName: datastoreName,
						defaultNetwork: networkId,
						defaultNetworkName: networkName,
						description: description,
					},
					success: function(data) {
						
						// 변경 성공
						if (data == 1) {
							alert('서비스 변경이 완료되었습니다.');
							location.reload();
						
						// 변경 실패
						} else if (data == 2) {
							alert('동일한 서비스 이름이 있습니다. 다시 입력해 주세요.');
							$('#serviceModal_service').focus();
							return false;
						
						} else {
							alert('서비스 변경에 실패했습니다.');
							return false;
						}
					}
				})
			}
		}
		
		// 서비스 삭제
		function deleteService(data) {
			
			// 삭제 확인
			if (confirm('\'' + data.vmServiceName + '\' 서비스를 삭제하시겠습니까?') == true) {
				$.ajax({
					url: '/tenant/deleteVMService.do',
					type: 'POST',
					data: {
						vmServiceID: data.vmServiceID,
						vmServiceName: data.vmServiceName
					},
					success: function(data) {
						
						// 삭제 성공
						if (data == 1) {
							alert('서비스 삭제가 완료되었습니다.');
							location.reload();

						// 삭제 실패
						} else if (data ==2 ) {
							alert('서비스에 소속된 가상머신이 있어 삭제할 수 없습니다.');
							return false;
							
						} else {
							alert('서비스 삭제에 실패했습니다.');
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