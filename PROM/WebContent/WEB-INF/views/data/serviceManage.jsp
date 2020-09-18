<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script>
			var filter = /^([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\.([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])){3}$/;
			var blank_pattern = /[\s]/g;
			var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
	
			$(document).ready(function() {
				if (sessionApproval == BanNumber) {
					ftnlimited(1);
				}
	
				$("#tenantsIDSB").change(function() {
					getTenantsinUsers();
				})
	
				$(document).on('change', '#defaultClusterSB', function() {
					getClusterinHostInfo();
				})
	
				$(document).on('change', '#defaultClusterSBup', function() {
					selectClusterinHostInfo();
				})
	
				$(document).on('change', '#tenantsIDSBup', function() {
					selectTenantsinUsers();
				})
	
				$(document).on('change', '#defaultHostSB', function() {
					hostinNetwork($("#defaultHostSB option:selected").val());
					hostinDataStore($("#defaultHostSB option:selected").val());
				})
	
				getServiceList();
				getTenantsList();
				getClusterInfo();
	
				dhcpOnOffCheck();
				
				commonModalOpen("addService", "vm_service_name");
			})
	
			function dhcpOnOffCheck() {
				$("input[name='dhcp_onoff']").click(function() {
					var dhcp_onoff = $("input[name='dhcp_onoff']:checked").val();
					if (dhcp_onoff == 1) {
						$("#gateway").attr("disabled", true);
						$("#netmask").attr("disabled", true);
						$("#gateway").val("");
						$("#netmask").val("");
					} else if (dhcp_onoff == 2) {
						$("#gateway").attr("disabled", false);
						$("#netmask").attr("disabled", false);
					}
				});
	
				$("input[name='dhcp_onoffup']").click(function() {
					var dhcp_onoffup = $("input[name='dhcp_onoffup']:checked").val();
					if (dhcp_onoffup == 1) {
						$("#gatewayup").attr("disabled", true);
						$("#netmaskup").attr("disabled", true);
						$("#gatewayup").val("");
						$("#netmaskup").val("");
					} else if (dhcp_onoffup == 2) {
						$("#gatewayup").attr("disabled", false);
						$("#netmaskup").attr("disabled", false);
					}
				});
			}
	
			function serviceRegisterEnterkey() {
				if (window.event.keyCode == 13) {
					serviceRegisterValidation();
				}
			}
	
			function serviceUpdateEnterkey(id) {
				if (window.event.keyCode == 13) {
					selectServiceUpdateValidation(id);
				}
			}
	
			function selectClusterinHostInfo(id, clusterID, hostID, storageID, networkID) {
	
				var cluster_id = $("#defaultClusterSBup option:selected").val();
				if (clusterID != cluster_id && typeof cluster_id !== 'undefined') {
					clusterID = cluster_id;
				}
	
				$.ajax({
					data: {
						hostParent: clusterID
					},
					url: "/tenant/selectVMHostList.do",
					success: function(data) {
						var html = '';
						var host = '';
						if (data == null || data == '') {
							html = '<option value="" selected disabled>:: 호스트가 존재하지 않습니다. ::</option>';
						} else {
							for (key in data) {
								if (hostID != data[key].vmHhostname) {
									html += '<option value=' + data[key].vmHhostname + '>' + data[key].vmHhostname + '</option>';
								} else {
									html += '<option value=' + hostID + ' selected>' + data[key].vmHhostname + '</option>';
								}
							}
						}
						$("#defaultHostSBup").empty();
						$("#defaultHostSBup").append(html);
						selecthostinDataStore(id, clusterID, hostID, storageID);
						selecthostinNetwork(id, clusterID, hostID, networkID);
					}
				})
			}
	
			function selecthostinDataStore(id, clusterID, hostID, storageID) {
				var host_id = $("#defaultHostSBup").val();
				$.ajax({
	
					url: "/tenant/selectHostDataStoreListByHostID.do",
					data: {
						hostID: host_id
					},
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value="" selected disabled>:: 데이터스토어가 존재하지 않습니다. ::</option>';
						} else {
							for (key in data) {
								if (storageID != data[key].dataStoreID) {
									html += '<option value=' + data[key].dataStoreID + ' value2=' + data[key].dataStoreName + '>' + data[key].dataStoreName + " / 전체 " + data[key].stAllca + ' GB / 사용량 ' + data[key].stUseca + " GB / 남은용량 " + data[key].stSpace + ' GB</option>';
								} else {
									html += '<option value=' + storageID + ' value2=' + data[key].dataStoreName + ' selected>' + data[key].dataStoreName + " / 전체 " + data[key].stAllca + ' GB / 사용량 ' + data[key].stUseca + " GB / 남은용량 " + data[key].stSpace + ' GB</option>';
								}
							}
						}
						$("#defaultStorageSBup").empty();
						$("#defaultStorageSBup").append(html);
					}
				})
			}
	
			function selecthostinNetwork(id, clusterID, hostID, networkID) {
				var host_id = $("#defaultHostSBup").val();
				$.ajax({
	
					url: "/tenant/selectHostNetworkListByHostID.do",
					data: {
						hostID: host_id
					},
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value="" selected disabled>:: 네트워크가 존재하지 않습니다. ::</option>';
						}
						for (key in data) {
							if (networkID != data[key].netWorkID) {
								html += '<option value="' + data[key].netWorkID + '" value2="' + data[key].netWorkName + '">' + data[key].netWorkName + '</option>';
							} else {
								html += '<option value="' + networkID + '" value2="' + data[key].netWorkName + '" selected>' + data[key].netWorkName + '</option>';
							}
						}
						$("#defaultNetworkSBup").empty();
						$("#defaultNetworkSBup").append(html);
					}
				})
			}
	
			function selectClusterInfo(id, clusterID, hostID, storageID, networkID) {
	
				$.ajax({
	
					url: "/tenant/selectClusterList.do",
					success: function(data) {
						var html = '';
						html += '<option value="">선택 안함</option>';
						for (key in data) {
							if (clusterID != data[key].clusterName) {
								html += '<option value=' + data[key].clusterName + '>' + data[key].clusterName + '</option>';
							} else {
								html += '<option value=' + clusterID + ' selected>' + data[key].clusterName + '</option>';
							}
						}
	
						$("#defaultClusterSBup").empty();
						$("#defaultClusterSBup").append(html);
						selectClusterinHostInfo(id, clusterID, hostID, storageID, networkID);
					}
				})
			}
	
			function selectTenantsinUsers(vmServiceUserId) {
	
				var tenantsID = $("#tenantsIDSBup").val();
	
				$.ajax({
					data: {
						tenantId: tenantsID
					},
					url: "/user/selectUserTenantMappingList.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value="" selected disabled>:: 사용자가 존재하지 않습니다. ::</option>';
						} else {
							for (key in data) {
								if (vmServiceUserId != data[key].id) {
									html += '<option value=' + data[key].id + ' value2=' + data[key].sName + '>' + data[key].sUserID + '(' + data[key].sName + ')' + '</option>';
								} else {
									html += '<option value=' + data[key].id + ' value2=' + data[key].sName + ' selected>' + data[key].sUserID + '(' + data[key].sName + ')' + '</option>';
								}
							}
							html += '<option value="">관리자 미지정</option>';
						}
						$("#vm_service_sUserIDSBup").empty();
						$("#vm_service_sUserIDSBup").append(html);
					}
				})
			}
	
			function selectTenantsList(id, tenantID, vmServiceUserId) {
	
				$.ajax({
					url: "/tenant/selectTenantList.do",
					success: function(data) {
						var html = '';
						for (key in data) {
							if (tenantID != data[key].id) {
								html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
							} else {
								html += '<option value=' + data[key].id + ' value2=' + data[key].name + ' selected>' + data[key].name + '</option>';
							}
						}
						$("#tenantsIDSBup").empty();
						$("#tenantsIDSBup").append(html);
						selectTenantsinUsers(vmServiceUserId);
					}
				})
			}
	
			function hostinDataStore() {
	
				var hostChoice = $("#defaultHostSB").val();
	
				$.ajax({
	
					url: "/tenant/selectHostDataStoreListByHostID.do",
					data: {
						hostID: hostChoice
					},
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html += '<option value="" selected disabled>:: 데이터스토어가 존재하지 않습니다. ::</option>';
						} else {
							for (key in data) {
								html += '<option value=' + data[key].dataStoreID + ' value2=' + data[key].dataStoreName + '>' + data[key].dataStoreName + " / 전체 " + data[key].stAllca + ' GB / 사용량 ' + data[key].stUseca + " GB / 남은용량 " + data[key].stSpace + ' GB</option>';
							}
						}
						$("#defaultStorageSB").empty();
						$("#defaultStorageSB").append(html);
					}
	
				})
			}
	
			function hostinNetwork() {
	
				var hostChoice = $("#defaultHostSB").val();
	
				$.ajax({
	
					url: "/tenant/selectHostNetworkListByHostID.do",
					data: {
						hostID: hostChoice
					},
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html += '<option value="" selected disabled>:: 네트워크가 존재하지 않습니다. ::</option>';
						} else {
							for (key in data) {
								html += '<option value="' + data[key].netWorkID + '" value2="' + data[key].netWorkName + '">' + data[key].netWorkName + '</option>';
							}
						}
						$("#defaultNetworkSB").empty();
						$("#defaultNetworkSB").append(html);
					}
				})
			}
	
			function getClusterinHostInfo() {
	
				var clusterName = $("#defaultClusterSB").val();
				$.ajax({
					data: {
						hostParent: clusterName
					},
					url: "/tenant/selectVMHostList.do",
					success: function(data) {
						var html = '';
						var host = '';
						if (data == '' || data == null) {
	
							html += '<option value="" selected disabled>:: 호스트가 존재하지 않습니다. ::</option>';
							$("#defaultStorageSB").empty();
							$("#defaultStorageSB").append(html);
							$("#defaultNetworkSB").empty();
							$("#defaultNetworkSB").append(html);
						} else {
							for (key in data) {
								html += '<option value=' + data[key].vmHhostname + '>' + data[key].vmHhostname + '</option>';
							}
						}
						$("#defaultHostSB").empty();
						$("#defaultHostSB").append(html);
						hostinNetwork();
						hostinDataStore();
					}
				})
			}
	
			function getClusterInfo() {
	
				$.ajax({
	
					url: "/tenant/selectClusterList.do",
					success: function(data) {
						var html = '';
						html += '<option value="" selected disabled>:: 클러스터를 선택하십시오. ::</option>';
						for (key in data) {
							html += '<option value=' + data[key].clusterName + '>' + data[key].clusterName + '</option>';
						}
	
						$("#defaultClusterSB").empty();
						$("#defaultClusterSB").append(html);
					}
				})
			}
	
			function getTenantsinUsers() {
	
				var tenantsID = $("#tenantsIDSB option:selected").val();
				$.ajax({
	
					data: {
						tenantId: tenantsID
					},
					url: "/user/selectUserTenantMappingList.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value="" selected disabled>:: 사용자가 존재하지 않습니다. ::</option>';
						} else {
							for (key in data) {
								html += '<option value=' + data[key].id + ' value2=' + data[key].sName + '>' + data[key].sUserID + '(' + data[key].sName + ')</option>';
							}
							html += '<option value="">관리자 미지정</option>';
						}
						$("#vm_service_sUserIDSB").empty();
						$("#vm_service_sUserIDSB").append(html);
					}
				})
			}
	
			function getTenantsList() {
	
				$.ajax({
					url: "/tenant/selectTenantList.do",
					success: function(data) {
						var html = '';
						html = '<option value="" value2="" selected disabled>:: 테넌트를 선택하십시오. ::</option>';
						for (key in data) {
							html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
						}
						$("#tenantsIDSB").empty();
						$("#tenantsIDSB").append(html);
					}
				})
			}
	
			function serviceRegisterValidation() {
	
				var vm_service_name = $("#vm_service_name").val();
				var service_parentsTenants = $("#tenantsIDSB option:selected").val();
				var service_TenantsName = $("#tenantsIDSB option:selected").attr("value2");
				var gateway = $("#gateway").val();
				var netmask = $("#netmask").val();
	
				var service_admin = $("#vm_service_sUserIDSB option:selected").val();
				var service_userName = $("#vm_service_sUserIDSB option:selected").attr("value2");
				var defaultCluster = $("#defaultClusterSB option:selected").val();
				var defaultHost = $("#defaultHostSB option:selected").val();
				var defaultStorage = $("#defaultStorageSB option:selected").val();
				var defaultStorageName = $("#defaultStorageSB option:selected").attr("value2");
				var defaultNetwork = $("#defaultNetworkSB option:selected").val();
				var defaultNetworkName = $("#defaultNetworkSB option:selected").attr("value2");
				var serviceDescription = $("#serviceDescription").val();
				var dhcp_onoff = $("input[name='dhcp_onoff']:checked").val();
	
				if (defaultNetwork != 0 && dhcp_onoff == 2) {
	
					if (!gateway) {
						alert("네트워크 선택 시 게이트웨이 주소를 지정해야 됩니다.");
						$("#gateway").focus();
						return false;
					} else if (!netmask) {
						alert("네트워크 선택 시 서브넷 마스크 주소를 지정해야 됩니다.");
						$("#netmask").focus();
						return false;
					} else if (!filter.test(gateway)) {
						alert("게이트웨이 형식이 잘못됐습니다.");
						$("#gateway").focus();
						return false;
					} else if (!filter.test(netmask)) {
						alert("서브넷 마스크 형식이 잘못됐습니다.");
						$("#netmask").focus();
						return false;
					}
				}
				if (!vm_service_name) {
					alert("서비스명은 필수 기입 항목입니다.");
					$("#vm_service_name").focus();
					return false;
				} else if (blank_pattern.test(vm_service_name)) {
					alert("서비스명에 띄어쓰기(공백)을 넣을 수 없습니다.");
					$("#vm_service_name").focus();
					return false;
				} else if (special_pattern.test(vm_service_name) == true) {
					alert("서비스명을 특수문자로 구성할 수 없습니다.");
					$("#vm_service_name").focus();
					return false;
				} else if (!service_parentsTenants || service_parentsTenants == 0) {
					alert("테넌트를 선택하십시오.");
					$("#tenantsIDSB").focus();
					return false;
				} else {
					$.ajax({
	
						data: {
							vmServiceName: vm_service_name,
							vmServiceUserID: service_admin,
							vmServiceUserName: service_userName,
							tenantId: service_parentsTenants,
							tenantName: service_TenantsName,
							defaultCluster: defaultCluster,
							defaultHost: defaultHost,
							defaultStorage: defaultStorage,
							defaultStorageName: defaultStorageName,
							defaultNetwork: defaultNetwork,
							defaultNetworkName: defaultNetworkName,
							defaultGateway: gateway,
							defaultNetmask: netmask,
							description: serviceDescription,
							dhcpOnoff: dhcp_onoff,
						},
						url: "/tenant/insertVMService.do",
						type: 'POST',
						success: function(data) {
							if (data == 1) {
								alert("서비스 등록 완료");
								location.reload();
							} else if (data == 2) {
								alert("이미 같은 서비스 이름이 존재합니다.");
								$("#vm_service_name").focus();
								return false;
							} else {
								globalMessage(1);
							}
						},error: function (jqXHR, exception) {
							getErrorMessage(jqXHR, exception);
						}
	
					})
				}
			}
	
			function getServiceList() {
				var serviecTable = $("#serviecTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/tenant/selectVMServiceList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "tenantName"},
							{"data": "vmServiceName"},
							{"data": "vmServiceUserName",
								render: function(data, type, row) {
									if (data == '관리자 미지정') {
										data = '<span class="text-muted">관리자 미지정</span>'
									} else {
										data = data;
									}
									return data;
								}
							},
							{"data": "countVM"},
							{
								"data": "defaultCluster",
								render: function(data, type, row) {
									if (data == 0 || data == '') {
										data = '<span class="text-muted">미지정</span>'
									} else {
										data = data;
									}
									return data;
								}
							},
							{
								"data": "defaultHost",
								render: function(data, type, row) {
									if (data == 0 || data == '') {
										data = '<span class="text-muted">미지정</span>'
									} else {
										data = data;
									}
									return data;
								}
							},
							{"data": "defaultStorageName",
								render: function(data, type, row) {
								if (data == '미지정') {
									data = '<span class="text-muted">미지정</span>'
								} else {
									data = data;
									}
								return data;
								}
							},
							{"data": "defaultNetworkName",
								render: function(data, type, row) {
									if (data == '미지정') {
										data = '<span class="text-muted">미지정</span>'
									} else {
										data = data;
										}
									return data;
									}
							},
							{
								"data": "dhcpOnoff",
								render: function(data, type, row) {
									if (data == 1) {
										data = '<span class="text-prom">ON</span>';
									} else if (data == 2) {
										data = '<span class="text-muted">OFF</span>';
									}
									return data;
								}
							},
							{
								"data": "description"
							},
							{
								"data": "vmServiceID",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
									var name = "\'" + row.vmServiceName + "\'";
									if (sessionApproval != BanNumber) {
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
										html += '<a href="#" class="dropdown-item" onclick="serviceUpdateCheck(' + data + ', ' + name + ', ' + 1 + ')"><i class="icon-file-text"></i>상세 보기</a>';
										html += '<a href="#" class="dropdown-item" onclick="serviceUpdateCheck(' + data + ', ' + name + ', ' + 2 + ')"><i class="icon-pencil7"></i>정보 변경</a>';
										html += '<a href="#" class="dropdown-item" onclick="serviceDeleteCheck(' + data + ', ' + name + ')"><i class="icon-trash"></i>삭제</a>';
										html += '</div>';
									} else {
										html += '<i class="icon-lock2"></i>';
									}
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
						columnDefs: [{
							responsivePriority: 1,
							targets: 0
						}, {
							responsivePriority: 2,
							targets: -1
						}],
						dom: "<'datatables-header'<'row-padding-0'lf><'row-padding-0'B<'addModal'>>>" + "<'datatables-body'rt>" + "<'datatables-footer'ip>",
						buttons: [{
							extend: "collection",
							text: "<i class='icon-import'></i><span class='ml-2'>내보내기</span>",
							className: "btn bg-prom dropdown-toggle",
							buttons: [{
									extend: "csvHtml5",
									charset: "UTF-8",
									bom: true,
									text: "CSV",
									title: "서비스 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "서비스 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
									}
								}
							]
						}]
					});
				$(".addModal").html('<button type="button" class="btn bg-prom" data-toggle="modal" data-target="#addService"><i class="icon-plus2"></i><span class="ml-2">서비스 등록</span></button>');
			}
	
			function serviceUpdateCheck(id, name, index) {
				$.ajax({
					data: {
						vmServiceID: id
					},
					url: "/tenant/selectVMService.do",
					success: function(data) {
	
						$("#gatewayup").val(data.defaultGateway);
						$("#netmaskup").val(data.defaultNetmask);
	
						$("#vm_service_nameup").val(data.vmServiceName);
						$("#serviceDescriptionup").val(data.description);
	
						if (data.dhcpOnoff == 1) {
							$("input:radio[name='dhcp_onoffup'][value='1']").prop("checked", true);
							$("#gatewayup").val("");
							$("#netmaskup").val("");
						} else if (data.dhcpOnoff == 2) {
							$("input:radio[name='dhcp_onoffup'][value='2']").prop("checked", true);
						}
	
						if (index == 2) {
							if (data.dhcp_onoff == 1) {
								$("#gatewayup").attr("disabled", true);
								$("#netmaskup").attr("disabled", true);
								$("#gatewayup").val("");
								$("#netmaskup").val("");
							} else if (data.dhcp_onoff == 2) {
								$("#gatewayup").attr("disabled", false);
								$("#netmaskup").attr("disabled", false);
							}
						}
						selectTenantsList(id, data.tenantId, data.vmServiceUserID);
						selectClusterInfo(id, data.defaultCluster, data.defaultHost, data.defaultStorage, data.defaultNetwork);
	
						btnStatusChk(id, name, index);
	
						$("#changeService").modal("show");
					}
				})
			}
	
			function btnStatusChk(id, name, index) {
	
				var header = '';
				var footer = '';
	
				if (index == 1) {
					header += '<h5 class="modal-title mb-0">' + name + ' 상세 보기</h5>';
					$("#modal-footer").hide();
	
				} else if (index == 2) {
					header += '<h5 class="modal-title mb-0">' + name + ' 정보 변경</h5>';
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="selectServiceUpdateValidation(' + id + ')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
					$("#modal-footer").show();
				}
				header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	
				$("#modal-header").empty();
				$("#modal-header").append(header);
	
				$("#modal-footer").empty();
				$("#modal-footer").append(footer);
	
				$("#required-inputup").addClass("show");
				$("#select-inputup").addClass("show");
	
				if (index == 1) {
					$("#vm_service_nameup").attr("disabled", true);
					$("#tenantsIDSBup").attr("disabled", true);
					$("#vm_service_sUserIDSBup").attr("disabled", true);
					$("#defaultClusterSBup").attr("disabled", true);
					$("#defaultHostSBup").attr("disabled", true);
					$("#defaultStorageSBup").attr("disabled", true);
					$("#defaultNetworkSBup").attr("disabled", true);
					$("#serviceDescriptionup").attr("disabled", true);
					$("#gatewayup").attr("disabled", true);
					$("#netmaskup").attr("disabled", true);
					$("#dhcp_onup").attr("disabled", true);
					$("#dhcp_offup").attr("disabled", true);
	
				} else if (index == 2) {
					$("#vm_service_nameup").attr("disabled", false);
					$("#tenantsIDSBup").attr("disabled", false);
					$("#vm_service_sUserIDSBup").attr("disabled", false);
					$("#defaultClusterSBup").attr("disabled", false);
					$("#defaultHostSBup").attr("disabled", false);
					$("#defaultStorageSBup").attr("disabled", false);
					$("#defaultNetworkSBup").attr("disabled", false);
					$("#serviceDescriptionup").attr("disabled", false);
					$("#dhcp_onup").attr("disabled", false);
					$("#dhcp_offup").attr("disabled", false);
				}
			}
	
			function selectServiceUpdateValidation(id) {
	
				var defaultCluster = $("#defaultClusterSBup option:selected").val();
				var defaultHost = $("#defaultHostSBup option:selected").val();
				var defaultStorage = $("#defaultStorageSBup option:selected").val();
				var defaultNetwork = $("#defaultNetworkSBup option:selected").val();
	
				var vm_service_name = $("#vm_service_nameup").val();
				var service_admin = $("#vm_service_sUserIDSBup option:selected").val();
				var service_parentsTenants = $("#tenantsIDSBup option:selected").val();
	
				var gateway = $("#gatewayup").val();
				var netmask = $("#netmaskup").val();
	
				var service_name = $("#vm_service_sUserIDSBup option:selected").attr("value2");
				var service_TenantsName = $("#tenantsIDSBup option:selected").attr("value2");
				var defaultStoragename = $("#defaultStorageSBup option:selected").attr("value2");
				var defaultNetworkname = $("#defaultNetworkSBup option:selected").attr("value2");
				var serviceDescription = $("#serviceDescriptionup").val();
				var dhcp_onoff = $("input[name='dhcp_onoffup']:checked").val();
	
				if (defaultNetwork != 0 && dhcp_onoff == 2) {
	
					if (!gateway) {
						alert("네트워크 선택 시 게이트웨이 주소를 지정해야 됩니다.");
						$("#gatewayup").focus();
						return false;
					} else if (!netmask) {
						alert("네트워크 선택 시 서브넷 마스크 주소를 지정해야 됩니다.");
						$("#netmaskup").focus();
						return false;
					} else if (!filter.test(gateway)) {
						alert("게이트웨이 형식이 잘못됐습니다.");
						$("#gatewayup").focus();
						return false;
					} else if (!filter.test(netmask)) {
						alert("서브넷 마스크 형식이 잘못됐습니다.");
						$("#netmaskup").focus();
						return false;
					}
				}
	
				if (!vm_service_name) {
					alert("서비스명은 필수 기입 항목입니다.");
					$("#vm_service_nameup").focus();
					return false;
				} else if (blank_pattern.test(vm_service_name)) {
					alert("서비스명에 띄어쓰기(공백)을 넣을 수 없습니다.");
					$("#vm_service_nameup").focus();
					return false;
				} else if (special_pattern.test(vm_service_name) == true) {
					alert("서비스명을 특수문자로 구성할 수 없습니다.");
					$("#vm_service_nameup").focus();
					return false;
				} else if (!service_parentsTenants || service_parentsTenants == 0) {
					alert("테넌트를 선택하십시오.");
					$("#tenantsIDSBup").focus();
					return false;
				/*
				} else if (!service_admin) {
					alert("서비스 관리자를 선택하십시오.");
					$("#vm_service_sUserIDSBup").focus();
					return false;*/
				} else if (defaultCluster != "" && defaultHost == "") {
					alert("호스트를 선택하십시오.");
					$("#defaultHostSBup").focus();
					return false;
				} else {
	
					$.ajax({
	
						data: {
							vmServiceID: id,
							vmServiceName: vm_service_name,
							vmServiceUserID: service_admin,
							vmServiceUserName: service_name,
							tenantId: service_parentsTenants,
							tenantName: service_TenantsName,
							defaultCluster: defaultCluster,
							defaultHost: defaultHost,
							defaultStorage: defaultStorage,
							defaultStorageName: defaultStoragename,
							defaultNetwork: defaultNetwork,
							defaultNetworkName: defaultNetworkname,
							defaultGateway: gateway,
							defaultNetmask: netmask,
							description: serviceDescription,
							dhcpOnoff: dhcp_onoff
						},
						url: "/tenant/updateVMService.do",
						type: 'POST',
						success: function(data) {
							if (data == 1) {
								alert("서비스 변경이 완료되었습니다.");
								window.parent.location.reload();
							} else if (data == 2) {
								alert("동일한 서비스명이 있습니다.");
								$("#vm_service_nameup").focus();
							} else {
								globalMessage(1);
							}
						},error: function (jqXHR, exception) {
							getErrorMessage(jqXHR, exception);
						}
	
					})
	
				}
			}
	
			function serviceDeleteCheck(id, name) {
				if (confirm(name + " 서비스를 삭제 하시겠습니까?") == true) {
					serviceDelete(id, name);
				} else {
					return false;
				}
			}
	
			function serviceDelete(id, name) {
				$.ajax({
					data: {
						vmServiceID: id,
						vmServiceName: name
					},
					url: "/tenant/deleteVMService.do",
					success: function(data) {
						if (data == 1) {
							alert("서비스 삭제가 완료되었습니다.");
							window.parent.location.reload();
						} else if (data == 2) {
							if (confirm("서비스에 속한 가상머신이 있어 삭제할 수 없습니다.\n가상머신의 서비스를 변경하러 가시겠습니까? ") == true) {
								window.parent.location.href = '/menu/tenantSetting.do#3';
								window.parent.location.reload();
							} else {
								return false;
							}
						} else if (data == 3) {
							if (confirm("서비스에 속한 사용자가 있어 삭제할 수 없습니다.\n사용자의 서비스를 변경하러 가시겠습니까? ") == true) {
								window.parent.location.href = '/menu/userSetting.do#3';
								window.parent.location.reload();
							} else {
								return false;
							}
						} else {
							globalMessage(1);
						}
					},error: function (jqXHR, exception) {
						getErrorMessage(jqXHR, exception);
					}
				})
			}
		</script>
	</head>
	
	<body>
		<div id="addService" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">서비스 등록</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body bg-light modal-type-1 modal-type-1-2">
						<div class="card mb-0">
							<div class="card-header bg-white">
								<a href="#required-input" data-toggle="collapse">
									<span class="h6 card-title"><i class="icon-checkbox-checked2 text-prom mr-2"></i>필수 입력 정보</span>
									<i class="icon-arrow-down12 text-prom"></i>
								</a>
							</div>
							<div id="required-input" class="collapse show">
								<div class="card-body bg-light">
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>서비스명:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="service name" autocomplete="off" maxlength="30" onkeyup="serviceRegisterEnterkey()" id="vm_service_name">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>테넌트:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="tenantsIDSB" data-fouc></select>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>서비스 관리자:</label>
												<select class="form-control select-search" id="vm_service_sUserIDSB" data-fouc>
													<option value="" selected disabled>:: 테넌트 선택 후 선택할 수 있습니다. ::</option>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>클러스터:</label>
												<select class="form-control select-search" id="defaultClusterSB" data-fouc></select>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>호스트:</label>
												<select class="form-control select-search" id="defaultHostSB" data-fouc>
													<option value="" selected disabled>:: 클러스터 선택 후 선택할 수 있습니다. ::</option>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>스토리지:</label>
												<select class="form-control select-search" id="defaultStorageSB" data-fouc>
													<option value="" selected disabled>:: 호스트 선택 후 선택할 수 있습니다. ::</option>
												</select>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>네트워크:</label>
												<select class="form-control select-search" id="defaultNetworkSB" data-fouc>
													<option value="" selected disabled>:: 호스트 선택 후 선택할 수 있습니다. ::</option>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>게이트웨이:</label>
												<input type="text" class="form-control form-control-modal" placeholder="gateway" autocomplete="off" maxlength="20" onkeyup="serviceRegisterEnterkey()" id="gateway">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>서브넷 마스크:</label>
												<input type="text" class="form-control form-control-modal" placeholder="subnet mask" autocomplete="off" maxlength="20" onkeyup="serviceRegisterEnterkey()" id="netmask">
											</div>
										</div>
									</div>
									<div class="row mt-1">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group form-check-inline">
												<div class="custom-control custom-radio mr-2-5">
													<input type="radio" class="custom-control-input" name="dhcp_onoff" id="dhcp_on" value="1">
													<label class="custom-control-label" for="dhcp_on">DHCP 사용</label>
												</div>
												<div class="custom-control custom-radio">
													<input type="radio" class="custom-control-input" name="dhcp_onoff" id="dhcp_off" value="2" checked>
													<label class="custom-control-label" for="dhcp_off">DHCP 미사용</label>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="card mb-0">
							<div class="card-header bg-white">
								<a href="#select-input" data-toggle="collapse">
									<span class="h6 card-title"><i class="icon-checkbox-unchecked2 text-prom mr-2"></i>선택 입력 정보</span>
									<i class="icon-arrow-down12 text-prom"></i>
								</a>
							</div>
							<div id="select-input" class="collapse show">
								<div class="card-body bg-light">
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>설명:</label>
												<input type="text" class="form-control form-control-modal" placeholder="description" autocomplete="off" maxlength="50" onkeyup="serviceRegisterEnterkey()" id="serviceDescription">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white">
						<button type="button" class="btn bg-prom rounded-round" onclick="serviceRegisterValidation()">등록<i class="icon-checkmark2 ml-2"></i></button>
					</div>
				</div>
			</div>
		</div>
	
		<div id="changeService" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom" id="modal-header"></div>
					<div class="modal-body bg-light modal-type-1 modal-type-1-2">
						<div class="card mb-0">
							<div class="card-header bg-white">
								<a href="#required-inputup" data-toggle="collapse">
									<span class="h6 card-title"><i class="icon-checkbox-checked2 text-prom mr-2"></i>필수 입력 정보</span>
									<i class="icon-arrow-down12 text-prom"></i>
								</a>
							</div>
							<div id="required-inputup" class="collapse show">
								<div class="card-body bg-light">
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>서비스명:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="service name" autocomplete="off" maxlength="30" id="vm_service_nameup">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>테넌트:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="tenantsIDSBup" data-fouc></select>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>서비스 관리자:</label>
												<select class="form-control select-search" id="vm_service_sUserIDSBup" data-fouc></select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>클러스터:</label>
												<select class="form-control select-search" id="defaultClusterSBup" data-fouc></select>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>호스트:</label>
												<select class="form-control select-search" id="defaultHostSBup" data-fouc></select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>스토리지:</label>
												<select class="form-control select-search" id="defaultStorageSBup" data-fouc></select>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>네트워크:</label>
												<select class="form-control select-search" id="defaultNetworkSBup" data-fouc></select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>게이트웨이:</label>
												<input type="text" class="form-control form-control-modal" placeholder="gateway" autocomplete="off" maxlength="20" id="gatewayup">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>서브넷 마스크:</label>
												<input type="text" class="form-control form-control-modal" placeholder="subnet mask" autocomplete="off" maxlength="20" id="netmaskup">
											</div>
										</div>
									</div>
									<div class="row mt-1">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group form-check-inline">
												<div class="custom-control custom-radio mr-2-5">
													<input type="radio" class="custom-control-input" name="dhcp_onoffup" id="dhcp_onup" value="1">
													<label class="custom-control-label" for="dhcp_onup">DHCP 사용</label>
												</div>
												<div class="custom-control custom-radio">
													<input type="radio" class="custom-control-input" name="dhcp_onoffup" id="dhcp_offup" value="2" checked>
													<label class="custom-control-label" for="dhcp_offup">DHCP 미사용</label>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="card mb-0">
							<div class="card-header bg-white">
								<a href="#select-inputup" data-toggle="collapse">
									<span class="h6 card-title"><i class="icon-checkbox-unchecked2 text-prom mr-2"></i>선택 입력 정보</span>
									<i class="icon-arrow-down12 text-prom"></i>
								</a>
							</div>
							<div id="select-inputup" class="collapse show">
								<div class="card-body bg-light">
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>설명:</label>
												<input type="text" class="form-control form-control-modal" placeholder="description" autocomplete="off" maxlength="50" id="serviceDescriptionup">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white" id="modal-footer"></div>
				</div>
			</div>
		</div>
	
		<div class="card bg-dark mb-0 table-type-5-6">
			<table id="serviecTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>테넌트명</th>
						<th>서비스명</th>
						<th>서비스 관리자</th>
						<th>가상머신 수</th>
						<th>클러스터</th>
						<th>호스트</th>
						<th>데이터스토어</th>
						<th>네트워크</th>
						<th>DHCP 여부</th>
						<th>설명</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>