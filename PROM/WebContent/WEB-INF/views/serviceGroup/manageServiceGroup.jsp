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
		
			<!-- 서비스 그룹 모달 -->
			<div class="modal fade" id="serviceGroupModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">서비스 그룹 등록</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<label>서비스 그룹 <span class="text-danger">*</span></label>
								<input type="text" class="form-control" placeholder="서비스 그룹 이름" autocomplete="off" maxlength="30" id="serviceGroupModal_serviceGroup">
								<div class="row">
									<div class="col-6">
										<label>클러스터 <span class="text-danger">*</span></label>
										<select class="form-control" id="serviceGroupModal_cluster"></select>
									</div>
									<div class="col-6">
										<label>호스트 <span class="text-danger">*</span></label>
										<select class="form-control" id="serviceGroupModal_host"></select>
									</div>
								</div>
								<div class="row">
									<div class="col-6">
										<label>데이터스토어 <span class="text-danger">*</span></label>
										<select class="form-control" id="serviceGroupModal_datastore"></select>
									</div>
									<div class="col-6">
										<label>네트워크 <span class="text-danger">*</span></label>
										<select class="form-control" id="serviceGroupModal_network"></select>
									</div>
								</div>
								<div class="row">
									<div class="col-6">
										<label>게이트웨이 <span class="text-danger">*</span></label>
										<input type="text" class="form-control" placeholder="게이트웨이" autocomplete="off" maxlength="20" id="serviceGroupModal_gateway">
									</div>
									<div class="col-6">
										<label>서브넷 마스크 <span class="text-danger">*</span></label>
										<input type="text" class="form-control" placeholder="서브넷 마스크" autocomplete="off" maxlength="20" id="serviceGroupModal_subnetMask">
									</div>
								</div>
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" class="custom-control-input" id="serviceGroupModal_dhcpOn" name="serviceGroupModal_useDHCP" value="1">
									<label class="custom-control-label" for="serviceGroupModal_dhcpOn">DHCP 사용</label>
								</div>
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" class="custom-control-input" id="serviceGroupModal_dhcpOff" name="serviceGroupModal_useDHCP" value="0" checked>
									<label class="custom-control-label" for="serviceGroupModal_dhcpOff">DHCP 미사용</label>
								</div>
							</div>
							<div class="modal-card">
								<div class="serviceGroupDiv d-none">
									<label>서비스 그룹 관리자</label>
									<select class="form-control" id="serviceGroupModal_serviceGroupAdmin"></select>
								</div>
								<label>설명</label>
								<input type="text" class="form-control mb-0" placeholder="서비스 그룹 설명" autocomplete="off" maxlength="40" id="serviceGroupModal_description">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" onclick="validationServiceGroup()" id="serviceGroupBtn">등록</button>
							<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 서비스 그룹 테이블 -->
			<table id="tableServiceGroup" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>서비스 그룹</th>
						<th>관리자</th>
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
			getServiceGroupList();
			
			// 클러스터 셀렉트 박스 변경 시
			$('#serviceGroupModal_cluster').change(function() {
				var clusterName= $('#serviceGroupModal_cluster option:selected').val();
				selectHostList(clusterName);
			});
			
			// 호스트 셀렉트 박스 변경 시
			$('#serviceGroupModal_host').change(function() {
				var hostName = $('#serviceGroupModal_host option:selected').val();
				selectDatastoreList(hostName);
				selectNetworkList(hostName);
			});
			
			// DHCP 변경 시
			$('input[name="serviceGroupModal_useDHCP"]').change(function() {
				var dhcp = $('input[name="serviceGroupModal_useDHCP"]:checked').val();
				changeDHCP(dhcp);
			});
		})
	
		// DHCP 변경 시
		function changeDHCP(dhcp) {
			
			// OFF
			if (dhcp == 0) {
				$('#serviceGroupModal_gateway').attr('disabled', false);
				$('#serviceGroupModal_subnetMask').attr('disabled', false);
			
			// ON
			} else if (dhcp == 1) {
				$('#serviceGroupModal_gateway').val('').attr('disabled', true);
				$('#serviceGroupModal_subnetMask').val('').attr('disabled', true);
			}
		}

		// 서비스 그룹 테이블
		function getServiceGroupList() {
			var tableServiceGroup = $('#tableServiceGroup').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"createB"><"manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/tenant/selectTenantList.do',
					type: 'POST',
					dataSrc: ''
				},
				columns: [
					{data: 'name'},
					{data: 'adminName', render: function(data, type, row) {
						data = data == null || data == '' ? '<span class="text-disabled">미지정</span>' : data;
						return data;
					}},
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
					{data: 'description'},
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
						title: '서비스 그룹 정보'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '서비스 그룹 정보'
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
			
			tableServiceGroupButton(tableServiceGroup);
		}
		
		// 관리 버튼 설정
		function tableServiceGroupButton(tableServiceGroup){
			$('.createB').html('<button type="button" class="btn createBtn" onclick="insertServiceGroup()">등록</button>');
			$('.manageB').html('<button type="button" class="btn manageBtn">관리</button>');
			
			$('.manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableServiceGroup').on('click', 'tr', function() {
				var data = tableServiceGroup.row(this).data();
				
				if (data != undefined){
					$(this).addClass("selected");
					$("#tableServiceGroup tr").not(this).removeClass("selected");
					
					// 관리 버튼 활성화
					var html = '';
					
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown">관리</button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" id="updateServiceGroup">서비스 그룹 정보 변경</a>';
					html += '<a href="#" class="dropdown-item" id="deleteServiceGroup">서비스 그룹 삭제</a>';
					html += '</div>';
					
					$('.manageB').empty().append(html);
					
					$('#updateServiceGroup').off('click').on('click', function() {
						updateServiceGroup(data);
					});
					
					$('#deleteServiceGroup').off('click').on('click', function() {
						deleteServiceGroup(data);
					});

				}
			});
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
					
					$('#serviceGroupModal_cluster').empty().append(html);
					
					clusterName = !clusterName ? $('#serviceGroupModal_cluster option:selected').val() : clusterName;
					selectHostList(clusterName, hostName, datastoreId, networkId);
				}
			})
		}

		// 호스트 목록
		function selectHostList(clusterName, hostName, datastoreId, networkId) {
			
			// 클러스터 미지정
			if (clusterName == '' || clusterName == 0) {
				$('#serviceGroupModal_host').html('<option value="" selected >미지정</option>');
				$('#serviceGroupModal_datastore').html('<option value="" selected>미지정</option>');
				$('#serviceGroupModal_network').html('<option value="" selected>미지정</option>');
				
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
						
						$('#serviceGroupModal_host').empty().append(html);
						
						hostName = !hostName ? $('#serviceGroupModal_host option:selected').val() : hostName;
						selectDatastoreList(hostName, datastoreId);
						selectNetworkList(hostName, networkId);
					}
				})
			}
		}

		// 데이터스토어 목록
		function selectDatastoreList(hostName, datastoreId) {
			if (hostName == '0') {
				$('#serviceGroupModal_datastore').empty().append('<option value="0" selected disabled>데이터스토어가 없습니다.</option>');
				
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
						
						$('#serviceGroupModal_datastore').empty().append(html);
					}
				})
			}
		}

		// 네트워크 목록
		function selectNetworkList(hostName, networkId) {
			if (hostName == '0') {
				$('#serviceGroupModal_network').empty().append('<option value="0" selected disabled>네트워크가 없습니다.</option>');
				
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
						
						$('#serviceGroupModal_network').empty().append(html);
					}
				})
			}
		}
		
		// 서비스 그룹 관리자
		function selectUserTenantMappingList(tenantId, adminId) {
			$.ajax({
				data: {
					tenantId: tenantId
				},
				url: "/user/selectUserTenantMappingList.do",
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html = '<option value="" selected disabled>관리자 미지정</option>';
					
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
					$("#serviceGroupModal_serviceGroupAdmin").empty().append(html);
				}
			})
		}
		
		// 등록/수정 모달 값 초기화
		function clearModal() {
			
			// 셀렉트 박스 설정
			selectClusterList();

			// 값 초기화
			$('#serviceGroupModal_serviceGroup').val('');
			$('#serviceGroupModal_cluster').val('');
			$('#serviceGroupModal_host').val('');
			$('#serviceGroupModal_datastore').val('');
			$('#serviceGroupModal_network').val('');
			$('#serviceGroupModal_gateway').val('');
			$('#serviceGroupModal_subnetMask').val('');
			$('#serviceGroupModal_serviceGroupAdmin').val('');
			$('#serviceGroupModal_description').val('');
			
			$('input[name="serviceGroupModal_useDHCP"][value="1"]').prop('checked', true);
			changeDHCP('1');
		}
		
		// 등록 모달 설정		
		function insertServiceGroup() {
			
			// 모달 초기화
			clearModal();
			
			$('.serviceGroupDiv').addClass('d-none');
			
			$('.modal-title').html('서비스 그룹 등록');
			$('#serviceGroupBtn').html('등록');
			$('#serviceGroupBtn').attr('onclick', 'validationServiceGroup("create");');
			
			
			$('#serviceGroupModal').modal('show');
			
			// 등록 창 열리면 첫번째 폼 포커스
			$('#serviceGroupModal').on('shown.bs.modal', function () {
				$('#serviceGroupModal_serviceGroup').focus();
			})
			
			selectClusterList();
		}
		
		// 변경 모달 설정		
		function updateServiceGroup(data) { 
			selectClusterList(data.defaultCluster, data.defaultHost, data.defaultStorage, data.defaultNetwork);
			selectUserTenantMappingList(data.id, data.adminId);
			
			$('.serviceGroupDiv').removeClass('d-none');
			
			$('#serviceGroupModal_serviceGroup').val(data.name);
			$('#serviceGroupModal_cluster').val(data.defaultCluster);
			$('#serviceGroupModal_host').val(data.defaultHost);
			$('#serviceGroupModal_datastore').val(data.defaultStorage);
			$('#serviceGroupModal_network').val(data.defaultNetwork);
			$('#serviceGroupModal_gateway').val(data.defaultGateway);
			$('#serviceGroupModal_subnetMask').val(data.defaultNetmask);
			$('#serviceGroupModal_serviceGroupAdmin').val(data.admin);
			$('#serviceGroupModal_description').val(data.description);

			if (data.dhcpOnoff == 2) {
				$('input[name="serviceGroupModal_useDHCP"][value="0"]').prop('checked', true);
				changeDHCP('0');

			} else if (data.dhcpOnoff == 1) {
				$('input[name="serviceGroupModal_useDHCP"][value="1"]').prop('checked', true);
				changeDHCP('1');
			}
			
			$('.modal-title').html('\'' + data.name + '\' 서비스 그룹 정보 변경');
			$('#serviceGroupBtn').html('변경');
			$('#serviceGroupBtn').attr('onclick', 'validationServiceGroup("update", "' + data.id + '")');
			
			$('#serviceGroupModal').modal('show');
		}
		
		// 유효성 검사
		function validationServiceGroup(category, id) {
			
			// 검사 항목
			var serviceGroupName = $("#serviceGroupModal_serviceGroup").val();
			var clusterName = $("#serviceGroupModal_cluster option:selected").val();
			var hostName = $("#serviceGroupModal_host option:selected").val();
			var datastoreId = $("#serviceGroupModal_datastore option:selected").val();
			var datastoreName = $("#serviceGroupModal_datastore option:selected").attr("value2");
			var networkId = $("#serviceGroupModal_network option:selected").val();
			var networkName = $("#serviceGroupModal_network option:selected").attr("value2");
			var gateway = $("#serviceGroupModal_gateway").val();
			var subnetMask = $("#serviceGroupModal_subnetMask").val();
			var useDHCP = $("input[name='serviceGroupModal_useDHCP']:checked").val();
			useDHCP = useDHCP == 0 ? 2 : 1;
			var adminId = $("#serviceGroupModal_serviceGroupAdmin option:selected").val();
			var adminName = $("#serviceGroupModal_serviceGroupAdmin option:selected").attr("value2");
			var description = $("#serviceGroupModal_description").val();
			
			// 이름 체크
			if (!serviceGroupName) {
				alert('서비스 그룹 이름을 입력해 주세요.');
				$('#serviceGroupModal_serviceGroup').focus();
				return false;
			}
			
			if (pattern_blank.test(serviceGroupName)) {
				alert('서비스 그룹 이름에 공백은 사용할 수 없습니다. 다시 입력해 주세요.');
				$('#serviceGroupModal_serviceGroup').focus();
				return false;
			}
			
			if (pattern_spc.test(serviceGroupName)) {
				alert('서비스 그룹 이름에 특수문자는 사용할 수 없습니다. 다시 입력해 주세요.');
				$('#serviceGroupModal_serviceGroup').focus();
				return false;
			}
			
			// DHCP를 사용하고 네트워크를 지정하면 게이트웨이, 서브넷 마스크 필수 입력
			if (networkId && useDHCP == 2) {
				if (!gateway) {
					alert('게이트웨이를 입력해 주세요.');
					$('#serviceGroupModal_gateway').focus();
					return false;
				}
				
				if (!pattern_ipAddress.test(gateway)) {
					alert('게이트웨이 형식이 다릅니다. 다시 입력해 주세요.');
					$('#serviceGroupModal_gateway').focus();
					return false;
				}
				
				if (!subnetMask) {
					alert('서브넷 마스크를 입력해 주세요.');
					$('#serviceGroupModal_subnetMask').focus();
					return false;
				}
				
				if (!pattern_ipAddress.test(subnetMask)) {
					alert('서브넷 마스크 형식이 다릅니다. 다시 입력해 주세요.');
					$('#serviceGroupModal_subnetMask').focus();
					return false;
				}
			}	

			// 등록
			if (category == 'create' && !id) {
				$.ajax({
					url: "/tenant/insertTenant.do",
					type: 'POST',
					data: {
						id: id,
						name: serviceGroupName,
						description: description,
						dhcpOnoff: useDHCP,
						defaultCluster: clusterName,
						defaultHost: hostName,
						defaultStorage: datastoreId,
						defaultStorageName: datastoreName,
						defaultNetwork: networkId,
						defaultNetworkName: networkName,
						defaultGateway: gateway,
						defaultNetmask: subnetMask
					},
					success: function(data) {
						
						// 등록 성공
						if (data == 1) {
							alert('등록이 완료되었습니다.');
							location.reload();
						
						// 등록 실패
						} else if (data == 2) {
							alert('동일한 서비스 그룹명이 있습니다. 다시 입력해 주세요.');
							$("#serviceGroupModal_serviceGroup").focus();
							
						} else {
							alert('서비스 그룹 등록에 실패했습니다.');
							return false;
						}
					}
				})
			}
			
			// 변경
			if (category == 'update' && id){
				
				$.ajax({
					url: "/tenant/updateTenant.do",
					type: "POST",
					data: {
						id: id,
						name: serviceGroupName,
						adminId: adminId,
						adminName: adminName,
						description: description,
						defaultCluster: clusterName,
						defaultHost: hostName,
						defaultStorage: datastoreId,
						defaultStorageName: datastoreName,
						defaultNetwork: networkId,
						defaultNetworkName: networkName,
						defaultGateway: gateway,
						defaultNetmask: subnetMask,
						dhcpOnoff: useDHCP						
					},
					success: function(data) {
						
						// 변경 성공
						if (data == 1) {
							alert('서비스 그룹 설정 변경이 완료되었습니다.');
							location.reload();
						
						// 변경 실패
						} else if (data == 2) {
							alert('동일한 서비스 그룹 이름이 있습니다. 다시 입력해 주세요.');
							$('#serviceGroupModal_serviceGroup').focus();
							return false;
						
						} else {
							alert('서비스 그룹 설정 변경에 실패했습니다.');
							return false;
						}
					}
				})
			}
		}
		

		// 삭제
		function deleteServiceGroup(data) {
			if (confirm('\'' + data.name + '\' 서비스 그룹을 삭제하시겠습니까?') == true) {
				$.ajax({
					url: "/tenant/deleteTenant.do",
					type: 'POST',
					data: {
						id: data.id
					},
					success: function(data) {
						
						// 삭제 성공
						if (data == 1) {
							alert('서비스 그룹 삭제가 완료되었습니다.');
							location.reload();

						// 삭제 실패
						} else if (data == 2) {
							if (confirm("서비스 그룹에 속한 서비스가 있어 삭제할 수 없습니다. \n서비스 설정 메뉴로 이동하시겠습니까?") == true) {
								location.href = '/serviceGroup/manageService.prom';
							} else {
								return false;
							}
						} else if (data == 3) {
							if (confirm("서비스 그룹에 속한 사용자가 있어 삭제할 수 없습니다.\n사용자의 서비스 그룹을 변경하러 가시겠습니까?") == true) {
								location.href = '/user/manageUser.prom';
							} else {
								return false;
							}
						} else {
							alert('서비스 그룹 삭제에 실패했습니다.');
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
