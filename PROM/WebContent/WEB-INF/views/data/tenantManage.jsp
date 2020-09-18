<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script>
			var global_tenantID;
			var global_tenantName;
	
			var blank_pattern = /[\s]/g;
			var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
			var filter = /^([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\.([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])){3}$/;
	
			$(document).ready(function() {
				if (sessionApproval == BanNumber) {
					ftnlimited(1);
				}
	
				$(document).on('change', '#defaultClusterSB_Ten', function() {
					getClusterinHostInfo();
				})
	
				$(document).on('change', '#defaultHostSB_Ten', function() {
					hostinNetwork($("#defaultHostSB_Ten option:selected").val());
					hostinDataStore($("#defaultHostSB_Ten option:selected").val());
				})
	
				$(document).on('change', '#defaultClusterSB_Tenup', function() {
					selectClusterinHostInfo();
				})
	
				getClusterInfo();
				getTenantsList();
				dhcpOnOffCheck();
				
				commonModalOpen("addTenant", "tenantsName");
			})
			
			function tenantsRegisterEnterkey() {
				if (window.event.keyCode == 13) {
					tenantsRegisterCheck();
				}
			}
	
			function tenantsUpdateEnterkey(id) {
				if (window.event.keyCode == 13) {
					selectTenantUpdateValidation(id);
				}
			}
	
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
	
			function selectUserTenantMappingList(tenantId, adminId) {
				
				if(tenantId == '') {
					
					var html = '<option value="" selected disabled>관리자 미지정</option>';
					$("#companyInUsersSB").empty();
					$("#companyInUsersSB").append(html);
					
				} else {
				
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
								for (key in data) {
									if (adminId != data[key].id) {
										html += '<option value=' + data[key].id + ' value2=' + data[key].sName + '>' + data[key].sUserID + '(' + data[key].sName + ')' + '</option>';
									} else {
										html += '<option value=' + adminId + ' value2=' + data[key].sName + ' selected>' + data[key].sUserID + '(' + data[key].sName + ')' + '</option>';
									}
								}
								if (adminId == null || adminId == '' || adminId == 0) {
									html += '<option value="" selected>관리자 미지정</option>';
								} else {
									html += '<option value="">관리자 미지정</option>';
								}
							}
							$("#companyInUsersSBup").empty();
							$("#companyInUsersSBup").append(html);
						}
					})
				}
			}
			
			function selectClusterInfo(id, clusterID, hostID, storageID, networkID) {
				$.ajax({
					url: "/tenant/selectClusterList.do",
					success: function(data) {
						var html = '';
						for (key in data) {
							if (clusterID != data[key].clusterName) {
								html += '<option value=' + data[key].clusterName + '>' + data[key].clusterName + '</option>';
							} else {
								html += '<option value=' + clusterID + ' selected>' + data[key].clusterName + '</option>';
							}
						}
						$("#defaultClusterSB_Tenup").empty();
						$("#defaultClusterSB_Tenup").append(html);
						selectClusterinHostInfo(id, clusterID, hostID, storageID, networkID);
					}
				})
			}
	
			function selectClusterinHostInfo(id, clusterID, hostID, storageID, networkID) {
				var cluster_id = $("#defaultClusterSB_Tenup option:selected").val();
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
							html = '<option value="">호스트가 존재하지 않습니다.</option>';
						} else {
							for (key in data) {
								if (hostID != data[key].vmHhostname) {
									html += '<option value=' + data[key].vmHhostname + '>' + data[key].vmHhostname + '</option>';
								} else {
									html += '<option value=' + hostID + ' selected>' + data[key].vmHhostname + '</option>';
								}
							}
						}
						$("#defaultHostSB_Tenup").empty();
						$("#defaultHostSB_Tenup").append(html);
						selecthostinDataStore(id, clusterID, hostID, storageID);
						selecthostinNetwork(id, clusterID, hostID, networkID);
					}
				})
			}
	
			function selecthostinDataStore(id, clusterID, hostID, storageID) {
				var host_id = $("#defaultHostSB_Tenup").val();
				$.ajax({
	
					url: "/tenant/selectHostDataStoreListByHostID.do",
					data: {
						hostID: host_id
					},
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value="">데이터스토어가 존재하지 않습니다.</option>';
						} else {
							for (key in data) {
								if (storageID != data[key].dataStoreID) {
									html += '<option value=' + data[key].dataStoreID + ' value2=' + data[key].dataStoreName + '>' + data[key].dataStoreName + " / 전체 " + data[key].stAllca + ' GB / 사용량 ' + data[key].stUseca + " GB / 남은용량 " +
										data[key].stSpace + ' GB</option>';
								} else {
									html += '<option value=' + storageID + ' value2=' + data[key].dataStoreName + ' selected>' + data[key].dataStoreName + " / 전체 " + data[key].stAllca + ' GB / 사용량 ' + data[key].stUseca + " GB / 남은용량 " +
										data[key].stSpace + ' GB</option>';
								}
							}
						}
						$("#defaultStorageSB_Tenup").empty();
						$("#defaultStorageSB_Tenup").append(html);
					}
				})
			}
	
			function selecthostinNetwork(id, clusterID, hostID, networkID) {
				var host_id = $("#defaultHostSB_Tenup").val();
				$.ajax({
	
					url: "/tenant/selectHostNetworkListByHostID.do",
					data: {
						hostID: host_id
					},
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value="">네트워크가 존재하지 않습니다.</option>';
						}
						for (key in data) {
							if (networkID != data[key].netWorkID) {
								html += '<option value="' + data[key].netWorkID + '" value2="' + data[key].netWorkName + '">' + data[key].netWorkName + '</option>';
							} else {
								html += '<option value="' + networkID + '" value2="' + data[key].netWorkName + '" selected>' + data[key].netWorkName + '</option>';
							}
						}
						$("#defaultNetworkSB_Tenup").empty();
						$("#defaultNetworkSB_Tenup").append(html);
					}
				})
			}
	
	
			function hostinDataStore() {
	
				var hostChoice = $("#defaultHostSB_Ten").val();
	
				$.ajax({
					url: "/tenant/selectHostDataStoreListByHostID.do",
					data: {
						hostID: hostChoice
					},
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html += '<option value="">데이터스토어가 존재하지 않습니다.</option>';
						} else {
							for (key in data) {
								html += '<option value=' + data[key].dataStoreID + ' value2=' + data[key].dataStoreName + '>' + data[key].dataStoreName + " / 전체 " + data[key].stAllca + ' GB / 사용량 ' + data[key].stUseca + " GB / 남은용량 " +
									data[key].stSpace + ' GB</option>';
							}
						}
						$("#defaultStorageSB_Ten").empty();
						$("#defaultStorageSB_Ten").append(html);
					}
	
				})
			}
	
			function hostinNetwork() {
				var hostChoice = $("#defaultHostSB_Ten").val();
				$.ajax({
					url: "/tenant/selectHostNetworkListByHostID.do",
					data: {
						hostID: hostChoice
					},
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html += '<option value="">네트워크가 존재하지 않습니다.</option>';
						} else {
							for (key in data) {
								html += '<option value="' + data[key].netWorkID + '" value2="' + data[key].netWorkName + '">' + data[key].netWorkName + '</option>';
								
							}
						}
						$("#defaultNetworkSB_Ten").empty();
						$("#defaultNetworkSB_Ten").append(html);
					}
				})
			}
	
			function getClusterinHostInfo() {
				var clusterName = $("#defaultClusterSB_Ten").val();
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
							$("#defaultStorageSB_Ten").empty();
							$("#defaultStorageSB_Ten").append(html);
							$("#defaultNetworkSB_Ten").empty();
							$("#defaultNetworkSB_Ten").append(html);
						} else {
							for (key in data) {
								html += '<option value=' + data[key].vmHhostname + '>' + data[key].vmHhostname + '</option>';
							}
						}
						$("#defaultHostSB_Ten").empty();
						$("#defaultHostSB_Ten").append(html);
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
						for (key in data) {
							html += '<option value=' + data[key].clusterName + '>' + data[key].clusterName + '</option>';
						}
						$("#defaultClusterSB_Ten").empty();
						$("#defaultClusterSB_Ten").append(html);
						getClusterinHostInfo();
					}
				})
			}
	
			function tenantsRegisterCheck() {
	
				//Vaildtion
				var name = $("#tenantsName").val();
				var default_cluster = $("#defaultClusterSB_Ten option:selected").val();
				var default_host = $("#defaultHostSB_Ten option:selected").val();
				var default_storage = $("#defaultStorageSB_Ten option:selected").val();
				var default_network = $("#defaultNetworkSB_Ten option:selected").val();
				var gateway = $("#gateway").val();
				var netmask = $("#netmask").val();
	
				//Insert
				var description = $("#tenantsDescription").val();
				var default_storageName = $("#defaultStorageSB_Ten option:selected").attr("value2");
				var default_networkName = $("#defaultNetworkSB_Ten option:selected").attr("value2");
				var dhcp_onoff = $("input[name='dhcp_onoff']:checked").val();
	
				if (dhcp_onoff == 2) {
					if (!gateway) {
						alert("게이트웨이 주소를 지정해야 됩니다.");
						$("#gateway").focus();
						return false;
					} else if (!netmask) {
						alert("서브넷 마스크 주소를 지정해야 됩니다.");
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
	
				if (!name) {
					alert("테넌트명은 필수 기입 항목입니다.");
					$("#tenantsName").focus();
					return false;
				} else if (blank_pattern.test(name) == true) {
					alert("테넌트명에 띄어쓰기(공백)을 넣을 수 없습니다.");
					$("#tenantsName").focus();
					return false;
				} else if (special_pattern.test(name) == true) {
					alert("테넌트명을 특수문자로 구성할 수 없습니다.");
					$("#tenantsName").focus();
					return false;
				} else if (!default_cluster) {
					alert("지정 클러스터를 선택하십시오.");
					$("#defaultClusterSB_Ten").focus();
					return false;
				} else if (!default_host) {
					alert("지정 호스트를 선택하십시오.");
					$("#defaultHostSB_Ten").focus();
					return false;
				} else if (!default_storage) {
					alert("지정 데이터스토어를 선택하십시오.");
					$("#defaultStorageSB_Ten").focus();
					return false;
				} else if (!default_network) {
					alert("지정 네트워크를 선택하십시오.");
					$("#defaultNetworkSB_Ten").focus();
					return false;
	
				} else {
					$.ajax({
						data: {
							name: name,
							description: description,
							dhcpOnoff: dhcp_onoff,
							defaultCluster: default_cluster,
							defaultHost: default_host,
							defaultStorage: default_storage,
							defaultStorageName: default_storageName,
							defaultNetwork: default_network,
							defaultNetworkName: default_networkName,
							defaultGateway: gateway,
							defaultNetmask: netmask
						},
						url: "/tenant/insertTenant.do",
						type: 'POST',
						success: function(data) {
							if (data == 1) {
								alert("테넌트 등록이 완료되었습니다.");
								window.parent.location.reload();
							} else if (data == 2) {
								alert("동일한 테넌트명이 있습니다.");
								$("#tenantsName").focus();
							} else if (data == 3) {
								alert("이미 테넌트 관리자인 사람입니다.\n다른 유저를 선택하세요.");
							} else {
								globalMessage(1);
							}
						},error: function (jqXHR, exception) {
							getErrorMessage(jqXHR, exception);
						}
	
					})
				}
			}
	
			function getTenantsList() {
				var tenantTable = $("#tenantTable").addClass("nowrap").DataTable({
					ajax: {
						"url": "/tenant/selectTenantList.do",
						"dataSrc": "",
					},
					columns: [
						{"data": "name"},
						{"data": "adminName",
							render: function(data, type, row) {
								if (data == null || data == '') {
									data = '<span class="text-muted">관리자 미지정</span>';
								} else {
									data = data;
								}
								return data;
							}
						},
						{"data": "defaultCluster"},
						{"data": "defaultHost"},
						{"data": "defaultStorageName"},
						{"data": "defaultNetworkName"},
						{"data": "dhcpOnoff",
							render: function(data, type, row) {
								if (data == 1) {
									data = '<span class="text-prom">ON</span>';
								} else if (data == 2) {
									data = '<span class="text-muted">OFF</span>';
								}
								return data;
							}
						},
						{"data": "description"},
						{"data": "id",
							"orderable": false,
							render: function(data, type, row) {
								var html = '';
								var name = "\'" + row.name + "\'";
								if (sessionApproval != BanNumber) {
									html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
									html += '<i class="icon-menu9"></i>';
									html += '</a>';
									html += '<div class="dropdown-menu">';
									html += '<a href="#" class="dropdown-item" onclick="tenantUpdateCheck(' + data + ', ' + name + ', ' + 1 + ')"><i class="icon-file-text"></i>상세 보기</a>';
									html += '<a href="#" class="dropdown-item" onclick="tenantUpdateCheck(' + data + ', ' + name + ', ' + 2 + ')"><i class="icon-pencil7"></i>정보 변경</a>';
									html += '<a href="#" class="dropdown-item" onclick="tenantsDeleteCheck(' + data + ', ' + name + ')"><i class="icon-trash"></i>삭제</a>';
									html += '</div>';
								} else {
									html += '<i class="icon-lock2"></i>';
								}
								return html;
							}
						}],
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
								title: "테넌트 정보",
								exportOptions: {
									columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
								}
							}, {
								extend: "excelHtml5",
								text: "Excel",
								title: "테넌트 정보",
								exportOptions: {
									columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
								}
							}]
						}]
					});
				$(".addModal").html('<button type="button" class="btn bg-prom" data-toggle="modal" data-target="#addTenant"><i class="icon-plus2"></i><span class="ml-2">테넌트 등록</span></button>');
			}
	
			//변경
			function tenantUpdateCheck(id, name, index) {
	
				global_tenantID = id;
				global_tenantName = name;
				$.ajax({
					data: {
						id: id
					},
					url: "/tenant/selectTenant.do",
					success: function(data) {
	
						$("#gatewayup").val(data.defaultGateway);
						$("#netmaskup").val(data.defaultNetmask);
	
						$("#tenantsNameup").val(data.name);
						$("#tenantsDescriptionup").val(data.description);
	
						if (data.dhcpOnoff == 1) {
							$("input:radio[name='dhcp_onoffup'][value='1']").prop("checked", true);
							$("#gatewayup").val("");
							$("#netmaskup").val("");
						} else if (data.dhcpOnoff == 2) {
							$("input:radio[name='dhcp_onoffup'][value='2']").prop("checked", true);
						}
	
						if (index == 2) {
							if (data.dhcpOnoff == 1) {
								$("#gatewayup").attr("disabled", true);
								$("#netmaskup").attr("disabled", true);
								$("#gatewayup").val("");
								$("#netmaskup").val("");
							} else if (data.dhcpOnoff == 2) {
								$("#gatewayup").attr("disabled", false);
								$("#netmaskup").attr("disabled", false);
							}
						}
						
						selectUserTenantMappingList(id, data.adminId);
	
						setTimeout(function() {
							selectClusterInfo(id, data.defaultCluster, data.defaultHost, data.defaultStorage, data.defaultNetwork);
						}, 50)
	
						btnStatusChk(id, name, index);
	
						$("#changeTenant").modal("show");
	
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
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="selectTenantUpdateValidation(' + id + ')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
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
					$("#tenantsNameup").attr("disabled", true);
					$("#companyInUsersSBup").attr("disabled", true);
					$("#defaultClusterSB_Tenup").attr("disabled", true);
					$("#defaultHostSB_Tenup").attr("disabled", true);
					$("#defaultStorageSB_Tenup").attr("disabled", true);
					$("#defaultNetworkSB_Tenup").attr("disabled", true);
					$("#tenantsDescriptionup").attr("disabled", true);
					$("#gatewayup").attr("disabled", true);
					$("#netmaskup").attr("disabled", true);
					$("#dhcp_onup").attr("disabled", true);
					$("#dhcp_offup").attr("disabled", true);
	
				} else if (index == 2) {
					$("#tenantsNameup").attr("disabled", false);
					$("#companyInUsersSBup").attr("disabled", false);
					$("#defaultClusterSB_Tenup").attr("disabled", false);
					$("#defaultHostSB_Tenup").attr("disabled", false);
					$("#defaultStorageSB_Tenup").attr("disabled", false);
					$("#defaultNetworkSB_Tenup").attr("disabled", false);
					$("#tenantsDescriptionup").attr("disabled", false);
					$("#dhcp_onup").attr("disabled", false);
					$("#dhcp_offup").attr("disabled", false);
				}
			}
	
			function selectTenantUpdateValidation(id) {
	
				var name = $("#tenantsNameup").val();
				var gateway = $("#gatewayup").val();
				var netmask = $("#netmaskup").val();
				
				var admin_id = $("#companyInUsersSBup option:selected").val();
				var default_cluster = $("#defaultClusterSB_Tenup option:selected").val();
				var default_host = $("#defaultHostSB_Tenup option:selected").val();
				var default_storage = $("#defaultStorageSB_Tenup option:selected").val();
				var default_network = $("#defaultNetworkSB_Tenup option:selected").val();
				var description = $("#tenantsDescriptionup").val();
	
				var admin_name = $("#companyInUsersSBup option:selected").attr("value2");
				var default_storageName = $("#defaultStorageSB_Tenup option:selected").attr("value2");
				var default_networkName = $("#defaultNetworkSB_Tenup option:selected").attr("value2");
	
				var dhcp_onoff = $("input[name='dhcp_onoffup']:checked").val();
	
				if (dhcp_onoff == 2) {
					if (!gateway) {
						alert("게이트웨이 주소를 지정해야 됩니다.");
						$("#gatewayup").focus();
						return false;
					} else if (!netmask) {
						alert("서브넷 마스크 주소를 지정해야 됩니다.");
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
				} else if (dhcp_onoff == 1) {
					gateway = '';
					netmask = '';
				}
	
				if (!name) {
					alert("테넌트명은 필수 기입 항목입니다.");
					$("#tenantsNameup").focus();
					return false;
				} else if (blank_pattern.test(name) == true) {
					alert("테넌트명에 띄어쓰기(공백)을 넣을 수 없습니다.");
					$("#tenantsNameup").focus();
					return false;
				} else if (special_pattern.test(name) == true) {
					alert("테넌트명을 특수문자로 구성할 수 없습니다.");
					$("#tenantsNameup").focus();
					return false;
				} else if (!default_cluster) {
					alert("지정 클러스터를 선택하십시오.");
					$("#defaultClusterSB_Tenup").focus();
					return false;
				} else if (!default_host) {
					alert("지정 호스트를 선택하십시오.");
					$("#defaultHostSB_Tenup").focus();
					return false;
				} else if (!default_storage) {
					alert("지정 데이터스토어를 선택하십시오.");
					$("#defaultStorageSB_Tenup").focus();
					return false;
				} else if (!default_storage) {
					alert("지정 네트워크를 선택하십시오.");
					$("#defaultNetworkSB_Tenup").focus();
					return false;
				} else {
	
					$.ajax({
	
						data: {
							id: id,
							name: name,
							adminId: admin_id,
							adminName: admin_name,
							description: description,
							defaultCluster: default_cluster,
							defaultHost: default_host,
							defaultStorage: default_storage,
							defaultStorageName: default_storageName,
							defaultNetwork: default_network,
							defaultNetworkName: default_networkName,
							defaultGateway: gateway,
							defaultNetmask: netmask,
							dhcpOnoff: dhcp_onoff
						},
						url: "/tenant/updateTenant.do",
						type: 'POST',
						success: function(data) {
							if (data == 1) {
								alert("테넌트 변경이 완료되었습니다.");
								window.parent.location.reload()
							} else if (data == 2) {
								alert("이미 사용된 테넌트명입니다\n다른 테넌트명을 사용 해주세요.");
								$("#tenantsNameup").focus();
							} else if (data == 3) {
								alert("이미 테넌트 관리자인 사람입니다.\n다른 유저를 선택하세요.");
							} else {
								globalMessage(1);
							}
						},error: function (jqXHR, exception) {
							getErrorMessage(jqXHR, exception);
						}
					})
				}
			}
	
			//삭제
			function tenantsDeleteCheck(id, name) {
				if (confirm(name + " 테넌트를 삭제 하시겠습니까?") == true) {
					tenantsDelete(id, name);
				} else {
					return false;
				}
			}
	
			function tenantsDelete(id, name) {
	
				$.ajax({
					data: {
						id: id
					},
					type: 'POST',
					url: "/tenant/deleteTenant.do",
					success: function(data) {
						if (data == 1) {
							alert("테넌트 삭제가 완료되었습니다.");
							window.parent.location.reload();
						} else if (data == 2) {
							if (confirm("테넌트에 속한 서비스가 있어 삭제할 수 없습니다.\n서비스의 테넌트를 변경하러 가시겠습니까? ") == true) {
								window.parent.location.href = '/menu/tenantSetting.do#2';
								window.parent.location.reload();
							} else {
								return false;
							}
						} else if (data == 3) {
							if (confirm("테넌트에 속한 사용자가 있어 삭제할 수 없습니다.\n사용자의 테넌트를 변경하러 가시겠습니까? ") == true) {
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
		<div id="addTenant" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">테넌트 등록</h5>
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
												<label>테넌트명:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="tenant name" autocomplete="off" maxlength="30" onkeyup="tenantsRegisterEnterkey()" id="tenantsName">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>클러스터:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="defaultClusterSB_Ten" data-fouc></select>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>호스트:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="defaultHostSB_Ten" data-fouc></select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>스토리지:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="defaultStorageSB_Ten" data-fouc></select>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>네트워크:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="defaultNetworkSB_Ten" data-fouc></select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>게이트웨이:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="gateway" autocomplete="off" maxlength="20" onkeyup="tenantsRegisterEnterkey()" id="gateway">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>서브넷 마스크:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="subnet mask" autocomplete="off" maxlength="20" onkeyup="tenantsRegisterEnterkey()" id="netmask">
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
												<input type="text" class="form-control form-control-modal" placeholder="description" autocomplete="off" maxlength="50" onkeyup="tenantsRegisterEnterkey()" id="tenantsDescription">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white">
						<button type="button" class="btn bg-prom rounded-round" onclick="tenantsRegisterCheck()">등록<i class="icon-checkmark2 ml-2"></i></button>
					</div>
				</div>
			</div>
		</div>
	
		<div id="changeTenant" class="modal fade">
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
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>테넌트명:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="tenant name" autocomplete="off" maxlength="30" id="tenantsNameup">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>테넌트 관리자:<span class="text-prom ml-2"></span></label>
												<select class="form-control select-search" id="companyInUsersSBup" data-fouc>
													<option value="" selected disabled>:: 선택 ::</option>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>클러스터:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="defaultClusterSB_Tenup" data-fouc></select>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>호스트:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="defaultHostSB_Tenup" data-fouc></select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>스토리지:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="defaultStorageSB_Tenup" data-fouc></select>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>네트워크:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="defaultNetworkSB_Tenup" data-fouc></select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>게이트웨이:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="gateway" autocomplete="off" maxlength="20" id="gatewayup">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>서브넷 마스크:<span class="text-prom ml-2">(필수)</span></label>
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
												<input type="text" class="form-control form-control-modal" placeholder="description" autocomplete="off" maxlength="50" id="tenantsDescriptionup">
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
			<table id="tenantTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>테넌트명</th>
						<th>테넌트 관리자</th>
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