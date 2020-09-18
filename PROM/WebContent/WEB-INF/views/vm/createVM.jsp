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

			<!-- 가상머신 생성 - 입력 -->
			<div class="modal fade" id="vmModal" tabindex="-1">
				<div class="modal-dialog modal-xl modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">가상머신 생성</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-xl-4">
									<div class="modal-card"><b>템플릿 정보</b></div>
									<div class="modal-card template" style="padding: 0;"></div>
									<div class="modal-card"><b>주의사항</b></div>
									<div class="modal-card">
										1. 가상머신 이름에 언더바(_)를 포함할 경우 정상 작동하지 않습니다.
									</div>
								</div>
								<div class="col-xl-8">
									<div class="modal-card">
										<div class="row">
											<div class="col-6">
												<label>카탈로그 <span class="text-danger">*</span></label>
												<select class="form-control" id="vmModal_catalog"></select>
											</div>
											<div class="col-3">
												<label>vCPU <span class="text-danger">*</span></label>
												<input type="number" class="form-control" id="vmModal_vCPU">
											</div>
											<div class="col-3">
												<label>Memory <span class="text-danger">*</span></label>
												<input type="number" class="form-control" id="vmModal_memory">
											</div>
										</div>
										<div class="row">
											<div class="col-6">
												<label>테넌트 <span class="text-danger">*</span></label>
												<select class="form-control" id="vmModal_serviceGroup"></select>
											</div>
											<div class="col-6">
												<label>서비스 <span class="text-danger">*</span></label>
												<select class="form-control" id="vmModal_service"></select>
											</div>
										</div>
										<div class="row">
											<div class="col-6">
												<label>클러스터 <span class="text-danger">*</span></label>
												<select class="form-control" id="vmModal_cluster"></select>
											</div>
											<div class="col-6">
												<label>호스트 <span class="text-danger">*</span></label>
												<select class="form-control" id="vmModal_host"></select>
											</div>
										</div>
										<div class="row">
											<div class="col-6">
												<label>데이터스토어 <span class="text-danger">*</span></label>
												<select class="form-control" id="vmModal_datastore"></select>
											</div>
											<div class="col-6">
												<label>네트워크 <span class="text-danger">*</span></label>
												<select class="form-control" id="vmModal_network"></select>
											</div>
										</div>
										<div class="row">
											<div class="col-6 vmNameDiv">
												<label>가상머신 <span class="text-danger">*</span></label>
												<input class="form-control" placeholder="가상머신 이름" autocomplete="off" maxlength="40" id="vmModal_vmName">
											</div>
											<div class="col-6 ipAddressDiv">
												<label>IP 주소 <span class="text-danger">*</span></label>
												<input class="form-control" placeholder="IP 주소" autocomplete="off" maxlength="20" id="vmModal_ipAddress">
											</div>
										</div>
										<label>생성 사유 <span class="text-danger">*</span></label>
										<input class="form-control mb-0" placeholder="생성 사유" autocomplete="off" maxlength="50" id="vmModal_createReason">
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer" >
							<button type="button" class="btn" id="nextModalBtn">다음</button>
							<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 가상머신 생성 - 확인 -->
			<div class="modal fade" id="confirmVMModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">가상머신 생성 확인</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card" style="padding: 0;"></div>
						</div>
						<div class="modal-footer d-flex justify-content-between">
							<button type="button" class="btn" id="prevModalBtn">이전</button>
							<div>
								<button type="button" class="btn" id="vmBtn">생성</button>
								<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- 필터 -->
			<div class=" row">
				<div class="col-xl-2 col-sm-6 w-50">
					<div class="input-group search-group">
						<input type="text" class="form-control " placeholder="SEARCH" autocomplete="off" id="inputSearch">
						<div class="input-group-append"><span class="input-group-text"><i class="fas fa-search"></i></span></div>
					</div>
				</div>
				<div class="col-xl-10 col-sm-6 w-50 text-right">
					<button type="button" class="btn sortingBtn h-100" data-toggle="dropdown">오름차순으로 보기</button>
					<div class="dropdown-menu">
						<a href="#" class="dropdown-item" id="asc">오름차순</a>
						<a href="#" class="dropdown-item" id="desc">내림차순</a>
					</div>
				</div>
			</div>

			<!-- 템플릿 카드 -->
			<div class="row" id="templateDiv"></div>
		</div>
		<!-- 본문 끝 -->
	</div>
	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
	
		// 사용자가 매핑된 테넌트 사용 여부 
		var isUserTenantMapping = 'false';
		
		var globalSorting = 'ASC';
		var globalDHCP = 0;
		var globalDHCPCategory = 0;
		
		$(document).ready(function() {
			getTemplateList(globalSorting, '');
			
			// 차순 변경 시 템플릿 목록
			$('.dropdown-item').off('click').on('click', function() {
				var sorting = $(this).attr('id');
				var inputSearch = $('#inputSearch').val();
				
				// 오름차순일 때
				if (sorting == 'asc') {
					$('.sortingBtn').html('오름차순으로 보기');
					globalSorting = 'ASC';
				}
				
				// 내림차순일 때
				if (sorting == 'desc') {
					$('.sortingBtn').html('내림차순으로 보기');
					globalSorting = 'DESC';
				}
				
				getTemplateList(globalSorting, inputSearch);
			})
			
			// 검색 시 템플릿 목록
			$('#inputSearch').keyup(function() {
				var inputSearch = $(this).val();
				getTemplateList(globalSorting, inputSearch);
			});

			// 카탈로그 셀렉트 박스 변경 시
			$('#vmModal_catalog').change(function() {
				var catalogName = $('#vmModal_catalog option:selected').text();
				var vmModal_vCPU = $('#vmModal_catalog option:selected').val();
				var vmModal_memory = $('#vmModal_catalog option:selected').attr('value2');
				
				changeCatalog(catalogName, vmModal_vCPU, vmModal_memory);
			});
			
			// 서비스 그룹 셀렉트 박스 변경 시
			$('#vmModal_serviceGroup').change(function() {
				var serviceGroupId = $('#vmModal_serviceGroup option:selected').val();
				selectServiceList(serviceGroupId);
			});
			
			// 서비스 셀렉트 박스 변경 시
			$('#vmModal_service').change(function() {
				var serviceId = $('#vmModal_service option:selected').val();
				getDHCPState(serviceId);
			});
			
			// 클러스터 셀렉트 박스 변경 시
			$('#vmModal_cluster').change(function() {
				var clusterName= $('#vmModal_cluster option:selected').text();
				selectHostList(clusterName);
			});
			
			// 호스트 셀렉트 박스 변경 시
			$('#vmModal_host').change(function() {
				var hostName = $('#vmModal_host option:selected').val();
				selectDatastoreList(hostName);
				selectNetworkList(hostName);
			});
		})
		
		// 템플릿 목록
		function getTemplateList(globalSorting, inputSearch) {
			$.ajax({
				url: '/apply/selectVMTemplateOnList.do',
				type: 'POST',
				data: {
					sort: globalSorting,
					searchParam: inputSearch
				},
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<div class="col-12 text-center">';
						inputSearch == '' ? html += '템플릿이 없습니다.' : html += '검색된 템플릿이 없습니다.';
						html += '</div>';
					
					} else {
						for (key in data) {
							var templateName = '\'' + data[key].vmName + '\'';
							var os = '\'' + data[key].vmOS + '\'';
							var disk = '\'' + data[key].vmDisk + '\'';
							var description = '\'' + data[key].description + '\'';
							
							html += '<div class="col-xl-3 col-sm-6">';
							html += '<div class="card template-card">';
							
							html += '<div class="card-header">' + data[key].vmName + '</div>';
							html += '<div class="card-body">';
							
							// OS
							html += '<div class="row">';
							html += '<div class="col-2">OS</div>';
							html += '<div class="col-10">' + data[key].vmOS + '</div>';
							html += '</div>';
							
							// Disk
							html += '<div class="row">';
							html += '<div class="col-2">Disk</div>';
							html += '<div class="col-10">' + data[key].vmDisk + ' GB</div>';
							html += '</div>';
							
							// 설명
							html += '<div class="row">';
							html += '<div class="col-2">설명</div>';
							if (data[key].description == null || data[key].description == ''){
								html += '<div class="col-10 text-disabled">설명이 없습니다.</div>';
							} else {
								html += '<div class="col-10">' + data[key].description + '</div>';
							}
							html += '</div>';
							
							html += '</div>';
							html += '<div class="card-footer"><button type="button" class="btn" onclick="insertVM(' + templateName + ', ' + os + ', ' + disk + ', ' + description + ')">생성</button></div>';
							html += '</div>';
							html += '</div>';
						}
					}

					$('#templateDiv').empty().append(html);
				}
			})
		}
		
		// 카탈로그 목록
		function selectCatalogList() {
			$.ajax({
				url: '/config/selectFlavorList.do',
				type: 'POST',
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="">카탈로그가 없습니다.</option>';

					} else {
						for (key in data) {
							html += '<option value="' + data[key].vCPU + '" value2="' + data[key].memory + '">' + data[key].name + '</option>';
						}
					}
					$('#vmModal_catalog').empty().append(html);
					
					var catalogName = $('#vmModal_catalog option:selected').text();
					var vCPU = $('#vmModal_catalog option:selected').val();
					var memory = $('#vmModal_catalog option:selected').attr('value2');
					
					changeCatalog(catalogName, vCPU, memory);
				}
			})
		}
	
		// 카탈로그 변경 시
		function changeCatalog(catalogName, vCPU, memory) {
			if (catalogName == 'Custom') {
				$('#vmModal_vCPU').attr('disabled', false);
				$('#vmModal_memory').attr('disabled', false);
			
			} else {
				$('#vmModal_vCPU').attr('disabled', true);
				$('#vmModal_memory').attr('disabled', true);
			}
			
			$('#vmModal_vCPU').val(vCPU);
			$('#vmModal_memory').val(memory);
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
								html += '<option value="' + data[key].id + '" value2="' + data[key].dhcpOnoff + '">' + data[key].name + '</option>';
						}
					}
					
					$('#vmModal_serviceGroup').empty().append(html);
					
					var serviceGroupId = $('#vmModal_serviceGroup option:selected').val();
					selectServiceList(serviceGroupId);
				}
			})
		}
		
		// 서비스 목록
		function selectServiceList(serviceGroupId) {
			if (serviceGroupId == '-2') {
				$('#vmModal_service').empty().append('<option value="-2" selected disabled>서비스가 없습니다.</option>');
			
			} else {
				$.ajax({
					url: '/tenant/selectVMServiceListByTenantId.do',
					type: 'POST',
					data: {
						tenantId: serviceGroupId,
						isUserTenantMapping : isUserTenantMapping
					},
					success: function(data) {
						var html = '';
						
						if (data == null || data == '') {
							html += '<option value="-2" selected disabled>서비스가 없습니다.</option>';
					
						} else {
							for (key in data) {
								html += '<option value="' + data[key].vmServiceID + '" value2="' + data[key].dhcpOnoff + '">' + data[key].vmServiceName + '</option>';
							}
						}
						
						$('#vmModal_service').empty().append(html);
						
						var serviceId = $('#vmModal_service option:selected').val();
						getDHCPState(serviceId);
					}
				})
			}
		}
		
		// DHCP 사용
		function getDHCPState(serviceId) {
			
			// 서비스 없을 때
			if (serviceId == '-2') {
				$('#vmModal_cluster').empty().append('<option value="0" selected disabled>클러스터가 없습니다.</option>');
				$('#vmModal_host').empty().append('<option value="0" selected disabled>호스트가 없습니다.</option>');
				$('#vmModal_datastore').empty().append('<option value="0" selected disabled>데이터스토어가 없습니다.</option>');
				$('#vmModal_network').empty().append('<option value="0" selected disabled>네트워크가 없습니다.</option>');
				
			// 서비스 있을 때
			} else {
				$.ajax({
					url: '/tenant/selectDHCPState.do',
					type: 'POST',
					data: {
						vm_service_ID: serviceId
					},
					success: function(data) {
						if (data == null || data == '' || data.length == undefined) {
							$('#vmModal_cluster').empty().append('<option value="0" selected disabled>클러스터가 없습니다.</option>');
							$('#vmModal_host').empty().append('<option value="0" selected disabled>호스트가 없습니다.</option>');
							$('#vmModal_datastore').empty().append('<option value="0" selected disabled>데이터스토어가 없습니다.</option>');
							$('#vmModal_network').empty().append('<option value="0" selected disabled>네트워크가 없습니다.</option>');
							
						} else {
							selectClusterList(data.getOneInfo.defaultCluster, data.getOneInfo.defaultHost, data.getOneInfo.defaultStorage, data.getOneInfo.defaultNetwork);
							
							globalDHCPCategory = data.resultNum;
							
							// 선택된 서비스가 DHCP를 사용 중이면 1, IP 입력 X / 미사용이면 0, IP 입력 필수
							globalDHCP = data.getOneInfo.dhcpOnoff == 1 ? 1 : 0;
								
							// DHCP 사용에 따라 가상머신 생성 - 입력 모달의 IP 주소 div 변경
							if (globalDHCP == 1) {
								$('.ipAddressDiv').removeClass('d-none');
								$('.vmNameDiv').addClass('col-6').removeClass('col-12');
								
							} else {
								$('.ipAddressDiv').addClass('d-none');
								$('.vmNameDiv').removeClass('col-6').addClass('col-12');
							}
						}
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
						for (key in data) {
							if (clusterName && clusterName == data[key].clusterName) {
								html += '<option value="' + data[key].clusterName + '" selected>' + data[key].clusterName + '</option>';
							
							} else {
								html += '<option value="' + data[key].clusterName + '">' + data[key].clusterName + '</option>';
							}
						}
					}
					
					$('#vmModal_cluster').empty().append(html);
					
					selectHostList(clusterName, hostName, datastoreId, networkId);
				}
			})
		}

		// 호스트 목록
		function selectHostList(clusterName, hostName, datastoreId, networkId) {
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
					
					$('#vmModal_host').empty().append(html);
					
					selectDatastoreList(hostName, datastoreId);
					selectNetworkList(hostName, networkId);
				}
			})
		}

		// 데이터스토어 목록
		function selectDatastoreList(hostName, datastoreId) {
			if (hostName == '0') {
				$('#vmModal_datastore').empty().append('<option value="0" selected disabled>데이터스토어가 없습니다.</option>');
				
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
						
						$('#vmModal_datastore').empty().append(html);
					}
				})
			}
		}

		// 네트워크 목록
		function selectNetworkList(hostName, networkId) {
			if (hostName == '0') {
				$('#vmModal_datastore').empty().append('<option value="0" selected disabled>네트워크가 없습니다.</option>');
				
			} else {
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
								if (networkId && networkId == data[key].netWorkID) {
									html += '<option value="' + data[key].netWorkID + '" selected>' + data[key].netWorkName + '</option>';
								
								} else {
									html += '<option value="' + data[key].netWorkID + '">' + data[key].netWorkName + '</option>';
								}
							}
						}
						
						$('#vmModal_network').empty().append(html);
					}
				})
			}
		}
		
		// 모달 값 초기화
		function clearModal() {
			
			// 셀렉트 박스
			selectCatalogList();
			selectServiceGroupList();

			// 값 초기화
			$('#vmModal_vmName').val('');
			$('#vmModal_ipAddress').val('');
		}
		
		// 가상머신 생성 - 입력 모달 설정
		function insertVM(templateName, os, disk, description) {
			var html = '';
			
			// 모달 초기화
			clearModal();
			
			// 템플릿 정보
			description = description == null || description == '' ? '없음' : description;
			
			html += '<ul class="list-group list-group-flush">';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">템플릿</div><div class="col-9">' + templateName + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">OS</div><div class="col-9">' + os + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">Disk</div><div class="col-9">' + disk + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">설명</div><div class="col-9">' + description + '</div></div></li>';
			html += '</ul>';
			
			$('#vmModal .modal-body .modal-card.template').empty().append(html);
			$('#vmModal').modal('show');
			
			// 다음 버튼 클릭 시 입력 값 유효성 검사
			$('#nextModalBtn').off('click').on('click', function() {
				validationVM(templateName, os, disk, description);
			});
		}
		
		// 생성 유효성 검사
		function validationVM(templateName, os, disk, description) {
			var serviceId = $('#vmModal_service option:selected').val();
			var vCPU = $('#vmModal_vCPU').val();
			var memory = $('#vmModal_memory').val();
			var vmName = $('#vmModal_vmName').val();
			var ipAddress = $('#vmModal_ipAddress').val();
			var createReason = $('#vmModal_createReason').val();
			
			if (serviceId == -2) {
				alert('서비스를 선택해 주세요.');
				$('#vmModal_service').focus();
				return false;
			}
			
			if (!vCPU) {
				alert('vCPU 값을 입력해 주세요.');
				$('#vmModal_vCPU').focus();
				return false;
			}
			
			if (vCPU > 32 || vCPU < 1) {
				alert('vCPU는 최소 1 개, 최대 32 개까지 입력할 수 있습니다. 다시 입력해 주세요.');
				$('#vmModal_vCPU').focus();
				return false;
			}
			
			if (!memory) {
				alert('Memory 값을 입력해 주세요.');
				$('#vmModal_memory').focus();
				return false;
			}
			
			if (memory > 64 || memory < 1) {
				alert('Memory는 최소 1 GB, 최대 64 GB까지 입력할 수 있습니다. 다시 입력해 주세요.');
				$('#vmModal_memory').focus();
				return false;
			}
			
			if (!vmName) {
				alert('가상머신 이름을 입력해 주세요.');
				$('#vmModal_vmName').focus();
				return false;
			}
			
			// DHCP를 사용 중이면 ip 유효성 검사 진행
			if (globalDHCP == 1) {
				if (!ipAddress) {
					alert('IP 주소를 입력해 주세요.');
					$('#vmModal_ipAddress').focus();
					return false;
				}
				
				if (!pattern_ipAddress.test(ipAddress)) {
					alert('IP 주소 형식이 다릅니다. 다시 입력해 주세요.');
					$('#vmModal_ipAddress').focus();
					return false;
				}
			}
			
			if (!createReason) {
				alert('생성 사유를 입력해 주세요.');
				$('#vmModal_createReason').focus();
				return false;
			}
			
			confirmVM(templateName, os, disk, description, vCPU, memory, vmName, ipAddress, createReason);
		}
		
		// 가상머신 생성 - 확인 모달 설정
		function confirmVM(templateName, os, disk, description, vCPU, memory, vmName, ipAddress, createReason) {
			var html = '';
			
			var catalogName = $('#vmModal_catalog option:selected').text();
			var serviceGroupName = $('#vmModal_serviceGroup option:selected').text();
			var serviceName = $('#vmModal_service option:selected').text();
			var clusterName = $('#vmModal_cluster option:selected').text();
			var hostName = $('#vmModal_host option:selected').text();
			var datastoreName = $('#vmModal_datastore option:selected').text();
			var networkName = $('#vmModal_network option:selected').text();
			
			description = description == null || description == '' ? '없음' : description;
			ipAddress = globalDHCP == 1 ? ipAddress : 'DHCP';
			
			// 입력한 정보
			html += '<ul class="list-group list-group-flush">';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">템플릿</div><div class="col-9">' + templateName + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">OS</div><div class="col-9">' + os + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">Disk</div><div class="col-9">' + disk + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">설명</div><div class="col-9">' + description + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">카탈로그</div><div class="col-9">' + catalogName + ' (vCPU: ' + vCPU + ' / Memory: ' + memory + ' GB)</div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">서비스 그룹</div><div class="col-9">' + serviceGroupName + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">서비스</div><div class="col-9">' + serviceName + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">클러스터</div><div class="col-9">' + clusterName + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">호스트</div><div class="col-9">' + hostName + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">데이터스토어</div><div class="col-9">' + datastoreName + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">네트워크</div><div class="col-9">' + networkName + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">가상머신 이름</div><div class="col-9">' + vmName + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">IP 주소</div><div class="col-9">' + ipAddress + '</div></div></li>';
			html += '<li class="list-group-item"><div class="row-padding-0"><div class="col-3">생성 사유</div><div class="col-9">' + createReason + '</div></div></li>';
			html += '</ul>';
			
			$('#confirmVMModal .modal-body .modal-card').empty().append(html);
			
			$('#vmModal').modal('hide');
			$('#confirmVMModal').modal('show');
			
			// 이전 버튼 클릭 시
			$('#prevModalBtn').off('click').on('click', function() {
				$('#vmModal').modal('show');
				$('#confirmVMModal').modal('hide');
			});
			
			// 생성 버튼 클릭 시 가상머신 생성 실행
			$('#vmBtn').off('click').on('click', function() {
				createVM(templateName, disk, vCPU, memory, serviceGroupName, serviceName, hostName, vmName, ipAddress, createReason);
			});
		}

		// 가상머신 생성
		function createVM(templateName, disk, vCPU, memory, serviceGroupName, serviceName, hostName, vmName, ipAddress, createReason) {
			var serviceGroupId = $('#vmModal_serviceGroup option:selected').val();
			var serviceId = $('#vmModal_service option:selected').val();
			var datastoreId = $('#vmModal_datastore option:selected').val();
			var networkId = $('#vmModal_network option:selected').val();
			
			$.ajax({
				url: '/apply/insertVMCreate.do',
				type: 'POST',
				data: {
					crTemplet: templateName,
					crDisk: disk,
					crCPU: vCPU,
					crMemory: memory,
					tenantId: serviceGroupId,
					tenantName: serviceGroupName,
					vmServiceID: serviceId,
					serviceName: serviceName,
					crHost: hostName,
					crStorage: datastoreId,
					crNetWork: networkId,
					crDhcp: globalDHCP,
					dhcpCategory: globalDHCPCategory,
					crVMName: vmName,
					crIPAddress: ipAddress,
					crVMContext: createReason
				},
				beforeSend: function() {
					$('#vmBtn').text('생성 중...');
				},
				success: function(data) {
					
					// 생성 실행
					if (confirm('가상머신 생성 실행이 완료되었습니다.\n가상머신 이력에서 결과를 확인하시겠습니까?') == true) {
						location.href = '/log/vmLog.prom';
					
					} else {
						location.reload();
						return false;
					}
				}
			})
		}
	</script>
</body>

</html>