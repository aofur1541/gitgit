<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<script src="${path}/resources/PROM_JS/vmControl.js"></script>
	<script src="${path}/resources/PROM_JS/commonVMResourceChange.js"></script>
	
	<script type="text/javascript">
		var userVMCtrlchk = 0;
		var globalDiskMaxNum = 0;
		var globalNetworkMaxNum = 0;
		var connect = "연결";
		var disconnect = "연결 끊김";
		var btnDisconnect = "연결 해제";
		var commonVMTable = '';
		var msg = "";
		// 사용자가 매핑된 테넌트 사용 여부 
		var isUserTenantMapping = 'false';

		$(document).ready(function() {
			$("#vmDeleteLoading").hide();
			if (sessionApproval > ADMINCHECK) {
				isUserTenantMapping = 'false';
				getTenantList();
			} else {
				isUserTenantMapping = 'true';
				getUserTenantList();
			}
			setTimeout(function(){
			var temptable = $('#serviceVMTable').DataTable();
			var start = temptable.row().data();
			$('#serviceVMTable tr').eq(1).addClass("selectedTr");
			getVMDetailInfo(start);
			},1000);
			
			getUserVMCtrlchk();

		})

		function authorityMsg(paramMsg,authoritychk){
			if(authoritychk == 0){
				$("#reasonContext").val('');
				return msg = paramMsg+" 신청";
			} else if (authoritychk == 1){
				return msg = paramMsg;
			} else {
				return msg = "값 오류";
			}
		}
		
		function getUserTenantList() {
			$.ajax({
				url: "/tenant/selectLoginUserTenantList.do",
				success: function(data) {
					var html = '';

					for (key in data) {
						html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
					}
					$("#tenantSelcetBox").empty();
					$("#tenantSelcetBox").append(html);
					serviceInTenant();
				}
			})
		}

		function getTenantList() {

			var getTenants = '${ten}';

			$.ajax({
				url: "/tenant/selectTenantList.do",
				success: function(data) {
					var html = '';

					html += '<option value="" value2="테넌트 전체" selected>테넌트 전체</option>';
					for (key in data) {
						if (getTenants == data[key].id) {
							html += '<option value=' + data[key].id + ' value2=' + data[key].name + ' selected>' + data[key].name + '</option>';
						} else {
							html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
						}
					}
					if (getTenants == 'De') {
						html += '<option value="-1" value2="미배치" selected>미배치 가상머신</option>';
					} else {
						html += '<option value="-1" value2="미배치">미배치 가상머신</option>';
					}
					$("#tenantSelcetBox").empty();
					$("#tenantSelcetBox").append(html);
					serviceInTenant();
				}
			})
		}

		function serviceInTenant() {

			var getService = '${se}';
			var tenantsID = $("#tenantSelcetBox option:selected").val();

			if(tenantsID == -1) {
				// 미배치
				var html = '<option value="-1" value2="서비스없음" selected>서비스 미배치</option>';
				$("#tenantInServiceSelcetBox").empty();
				$("#tenantInServiceSelcetBox").append(html);
				serviceInVM();
			} else {
			
				$.ajax({
					data: {
						tenantId: tenantsID,
						isUserTenantMapping : isUserTenantMapping
					},
					url: "/tenant/selectVMServiceListByTenantId.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html += '<option value="-1" value2="서비스없음" selected>서비스 미배치</option>';
						} else {
							html += '<option value="" value2="서비스 전체" selected>서비스 전체</option>';
							for (key in data) {
								if (getService == data[key].vmServiceID) {
									html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].vmServiceName + ' selected>' + data[key].vmServiceName + '</option>';
								} else {
									html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].vmServiceName + '>' + data[key].vmServiceName + '</option>';
								}
							}
						}
						$("#tenantInServiceSelcetBox").empty();
						$("#tenantInServiceSelcetBox").append(html);
						serviceInVM();
					}
				})
			}
		}

		function serviceInVMs() {
			var tenantsID = $("#tenantSelcetBox option:selected").val();
			var tenantsName = $("#tenantSelcetBox option:selected").attr("value2");
			var serviceID = $("#tenantInServiceSelcetBox").val();
			var serviceName = $("#tenantInServiceSelcetBox option:selected").attr("value2");

			commonVMTable = $("#serviceVMTable")
				.addClass("nowrap")
				.DataTable({
					ajax: {
						"url": "/apply/selectVMDataList.do",
						"dataSrc": function(d) {
							return d
						},
						"data": function(d) {
							d.tenantId = tenantsID,
							d.vmServiceID = serviceID,
							d.isUserTenantMapping = isUserTenantMapping
						}
					},
					columns: [{
							"data": "vmName"
						},
						{
							"data": "vmCPU"
						},
						{
							"data": "vmMemory",
							render: function(data, type, row) {
								data = data + ' GB';
								return data;
							}
						},
						{
							"data": "vmDisk",
							render: function(data, type, row) {
								data = data + ' GB';
								return data;
							}
						}
					],
					lengthMenu: [
						[5, 10, 25, 50, -1],
						[5, 10, 25, 50, "All"]
					],
					pageLength: 25,
					responsive: true,
					stateSave: true,
					columnDefs: [{
						targets: "_all",
						defaultContent: '-'
					}],
					dom: "<'datatables-header'<'row-padding-0'lf><'row-padding-0'>>" + "<'datatables-body'rt>" + "<'datatables-footer'ip>",
				});
			$("#serviceVMTable tbody").on("click", "tr", function() {
				var data = commonVMTable.row(this).data();
				if (data != undefined) {
					globalPreObj = data;
					$(this).addClass("selectedTr");
					$("#serviceVMTable tr").not(this).removeClass("selectedTr");
					var select = document.querySelector('.selectedTr');
					var trindex = select.rowIndex;
					globalThis = trindex;
					getVMDetailInfo(data);
				}
			});
		}

		function getVMDetailInfo(data) {
			
			
			var html = '';
			var title = '';
			var tenantName = data.name;
			var serviceName = data.vmServiceName;
			var vm_name = "\'" + data.vmName + "\'";
			var vmIDtoString = "\'" + data.vmID + "\'";
			var ten = '';
			var se = '';

			var functionReload = "\'" + 'functionReload' + "\'";

			vmBasicInfo(data);
			vmDiskInfo(data.vmID);
			vmNetworkInfo(data.vmID);
			vmCDROMInfo(data.vmID);
			getDataStoresParamVerInHost(data.vmHost, "datastoreSBDisk");
			getDataStoresParamVerInHost(data.vmHost, "datastoreSBCDROM");
			getNetworksParamVerInHost(data.vmHost, "portGroupSB");

			// 타이틀
			if (data.tenantId == 0 || data.tenantId == '') {
				ten = 'De';
				tenantName = '미배치';
			} else {
				ten = data.tenantId;
				tenantName = data.tenantName;
			}

			if (data.vmServiceID == 0 || data.vmServiceID == '') {
				se = 'De';
				serviceName = '미배치';
			} else {
				se = data.vmServiceID;
				serviceName = data.vmServiceName;
			}

			var vmLink = "\'" + '/menu/monitoring.do?vn=' + data.vmID + '&ten=' + ten + '&se=' + se + "#1\'";
			title += '<a href="#" onclick="javascript:window.parent.location.href=' + vmLink + '">' + data.vmID + '</a>';
			title += '<span class="ml-2">(' + tenantName + ' / ' + serviceName + ')</span>';

			if (sessionApproval != BanNumber) {
				html += '<button type="button" class="btn btn-sm btn-outline bg-prom border-prom text-prom btn-icon rounded-round border-2 ml-2" onclick="vmResourceChange(' + vm_name + ', ' + data.vmCPU + ', ' + data.vmMemory + ', ' + data.cpuHotAdd + ', ' + data.memoryHotAdd + ', ' + data.vmServiceID + ', ' + vmIDtoString + ')"><i class="icon-cube4"></i><i class="icon-arrow-up16"></i></button>';

				// 전원
				if (userVMCtrlchk == 0 && sessionApproval < CONTROLCHECK) {

				} else {
					html += '<div>';
					html += '<button type="button" class="btn btn-sm btn-outline bg-prom border-prom text-prom btn-icon rounded-round border-2 ml-2" data-toggle="dropdown">';
					if (data.vmStatus == 'poweredOn') {
						html += '<i class="icon-switch"></i>';
					} else if (data.vmStatus == 'poweredOff') {
						html += '<i class="icon-power-cord"></i>';
					}
					html += '</button>';
					html += '<div class="dropdown-menu">';
					if (data.vmStatus == 'poweredOn') {
						html += '<a href="#" class="dropdown-item" onclick="ctrlPowerOfVM(' + vm_name + ', ' + 2 + ', ' + functionReload + ')"><i class="icon-power-cord"></i>전원 끄기</a>';
						html += '<a href="#" class="dropdown-item" onclick="ctrlPowerOfVM(' + vm_name + ', ' + 3 + ', ' + functionReload + ')"><i class="icon-rotate-ccw3"></i>다시 시작</a>';

					} else if (data.vmStatus == 'poweredOff') {
						html += '<a href="#" class="dropdown-item" onclick="ctrlPowerOfVM(' + vm_name + ', ' + 1 + ', ' + functionReload + ')"><i class="icon-switch"></i>전원 켜기</a>';
					}
					html += '</div>';
					html += '</div>';
				}

				// 삭제
				if (data.vmStatus == 'poweredOff' && (sessionApproval == ADMIN_NAPP || sessionApproval == OPERATOR_NAPP) && (data.vmServiceID == 0 || data.vmServiceID == null)) {
					html += '<button type="button" class="btn btn-sm btn-outline bg-prom border-prom text-prom btn-icon rounded-round border-2 ml-2" onclick="destoryVMvalidation(' + vm_name + ')"><i class="icon-trash"></i></button>';
				}

				// 추가 버튼
				if (sessionApproval < CONTROLCHECK) {
					var strAdd = '추가 신청';
				} else {
					var strAdd = '추가';
				}

				$("#addDiskBtn").html('<button type="button" class="btn btn-sm bg-prom" onclick="vmAddInfoModal('+data.vmServiceID+','+ vmIDtoString + ',' + vm_name + ',' + 1 + ')"><i class="icon-plus2"></i><span class="ml-2">Disk ' + strAdd + '</span></button>');
				$("#addvNICBtn").html('<button type="button" class="btn btn-sm bg-prom" onclick="vmAddInfoModal('+data.vmServiceID+','+ vmIDtoString + ',' + vm_name + ',' + 2 + ')"><i class="icon-plus2"></i><span class="ml-2">vNIC ' + strAdd + '</span></button>');
				$("#addCDROMBtn").html('<button type="button" class="btn btn-sm bg-prom" onclick="vmAddInfoModal('+data.vmServiceID+','+ vmIDtoString + ',' + vm_name + ',' + 3 + ')"><i class="icon-plus2"></i><span class="ml-2">CD-ROM ' + strAdd + '</span></button>');
			}

			$("#vmOneTitle").empty().append(title);
			$("#vmOnOffBtn").empty().append(html);
		}

		// 추가 모달
		function vmAddInfoModal(service_id,vm_ID, vmName, index) {
			$("#addVMInfo").modal("show");

			var header = '';
			var footer = '';
			var vmNameToString = "\'" + vmName + "\'";
			var vmIdToString = "\'" + vm_ID + "\'";

			var authoritychk = 0;
			
			// 추가 버튼
			if (sessionApproval < CONTROLCHECK) {
				var addBtn = '신청';
				var connectBtn = '신청';
				authoritychk = 0;
			} else {
				var addBtn = '추가';
				var connectBtn = '연결';
				authoritychk = 1;
			}

			// Disk
			if (index == 1) {

				header += '<h5 class="modal-title mb-0">Disk 추가</h5>';
				footer += '<button type="button" class="btn bg-prom rounded-round" onclick="addDiskOfVM('+service_id+','+ vmNameToString + ',' + vmIdToString +','+ authoritychk+')">' + addBtn + '<i class="icon-checkmark2 ml-2"></i></button>';

				if (sessionApproval < CONTROLCHECK) {
					$("#addDisk1").hide();
					$("#addDisk2").show();
					$("#addContextDiv").show();
					
					$("#addVMInfo").on("shown.bs.modal", function() {
						$("#diskCapacity").focus();
					});
				
				} else {
					$("#diskNum").val(globalDiskMaxNum);
					$("#addDisk1").show();
					$("#addDisk2").show();
					
					$("#addContextDiv").hide();

					$("#addVMInfo").on("shown.bs.modal", function() {
						$("#datastoreSBDisk").focus();
					});
				}
				$("#addvNIC").hide();
				$("#addCDROM").hide();
				$("#addSpanDiv").hide();

			// vNIC
			} else if (index == 2) {
				header += '<h5 class="modal-title mb-0">vNIC 추가</h5>';
				footer += '<button type="button" class="btn bg-prom rounded-round" onclick="addvNICOfVM('+service_id+','+ vmNameToString + ',' + vmIdToString + ','+ authoritychk+ ')">' + addBtn + '<i class="icon-checkmark2 ml-2"></i></button>';
				
				if (sessionApproval < CONTROLCHECK) {
					$("#addContextDiv").show();
					$("#addvNIC").hide();
					
					$("#addVMInfo").on("shown.bs.modal", function() {
						$("#reasonContext").focus();
					});
				
				} else {
					$("#portGroupNum").val(globalNetworkMaxNum);
					$("#addvNIC").show();
					
					$("#addContextDiv").hide();

					$("#addVMInfo").on("shown.bs.modal", function() {
						$("#portGroupSB").focus();
					});
				}
				$("#addDisk1").hide();
				$("#addDisk2").hide();
				$("#addCDROM").hide();
				$("#addSpanDiv").hide();
				
			// CD-ROM
			} else if (index == 3) {
				header += '<h5 class="modal-title mb-0">CD-ROM 추가</h5>';
				footer += '<button type="button" class="btn bg-prom rounded-round" onclick="mountCD('+service_id+','+ vmIdToString + ',' + vmNameToString + ','+ authoritychk+ ')">' + connectBtn + '<i class="icon-checkmark2 ml-2"></i></button>';
				
				
				if (sessionApproval < CONTROLCHECK) {
					$("#addContextDiv").show();
					$("#addSpanDiv").show();
					
					$("#addCDROM").hide();
					
					$("#addVMInfo").on("shown.bs.modal", function() {
						$("#reasonContext").focus();
					});
				
				} else {
					$("#addCDROM").show();
					
					$("#addContextDiv").hide();
					$("#addSpanDiv").hide();

					$("#addVMInfo").on("shown.bs.modal", function() {
						$("#datastoreSBCDROM").focus();
					});
				}
				$("#addDisk1").hide();
				$("#addDisk2").hide();
				$("#addvNIC").hide();
			}

			header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';

			$("#modal-header").empty();
			$("#modal-header").append(header);

			$("#modal-footer").empty();
			$("#modal-footer").append(footer);
		}

		// 기본 정보
		function vmBasicInfo(data) {
			var html = '';

			html += '<tr>';
			html += '<td>' + data.vmHost + '</td>';
			html += '<td>' + data.vmOS + '</td>';
			html += '<td>' + data.vmCPU + '</td>';
			html += '<td>' + data.vmMemory + ' GB</td>';
			html += '<td>' + data.vmDisk + ' GB</td>';

			if (data.cpuHotAdd == "true") {
				html += '<td><span class="text-prom">ON</span></td>';
			} else if (data.cpuHotAdd == "false") {
				html += '<td><span class="text-muted">OFF</span></td>';
			}

			if (data.memoryHotAdd == "true") {
				html += '<td><span class="text-prom">ON</span></td>';
			} else if (data.memoryHotAdd == "false") {
				html += '<td><span class="text-muted">OFF</span></td>';
			}

			if (data.vmtoolsStatus == "guestToolsRunning") {
				html += '<td><span class="text-prom">ON</span></td>';
			} else if (data.vmtoolsStatus == "guestToolsNotRunning") {
				html += '<td><span class="text-muted">OFF</span></td>';
			}

			if (data.vmStatus == "poweredOn") {
				html += '<td><span class="text-prom">ON</span></td>';
			} else if (data.vmStatus == "poweredOff") {
				html += '<td><span class="text-muted">OFF</span></td>';
			}
			html += '</tr>';

			$("#vmBasicList").empty();
			$("#vmBasicList").append(html);
		}

		// Disk 정보		
		function vmDiskInfo(vm_ID) {
			var html = '';
			$.ajax({
				data: {
					vmID: vm_ID
				},
				url: "/apply/selectVMDiskList.do",
				success: function(data) {
					if (dataEmptyCheck(data)) {
						html += '<td colspan="4" class="text-center">데이터가 없습니다.</td>';
					} else {
						for (key in data) {
							html += '<tr>';
							html += '<td class="text-center">' + data[key].nSCSInumber + '</td>';
							html += '<td>' + data[key].sDiskLocation + '</td>';
							html += '<td>' + data[key].nDiskCapacity + '</td>';
							html += '<td><span class="text-prom">정상</span></td>';
							html += '</tr>';
						}
						globalDiskMaxNum = (data.length + 1);

						$("#vmDiskList").empty();
						$("#vmDiskList").append(html);
					}
				}
			})
		}

		// Network 정보		
		function vmNetworkInfo(vm_ID) {
			var html = '';
			var totalIp = '';
			var networkStatus = 0;
			var vmIDToString = "\'" + vm_ID + "\'";
			var connectToString = "\'" + 'Connect' + "\'";
			var disconnectToString = "\'" + 'Disconnect' + "\'";

			$.ajax({
				url: "/apply/selectVMNetworkList.do",
				data: {
					vmID: vm_ID
				},
				success: function(data) {
					if (dataEmptyCheck(data)) {
						html = '<td colspan="5" class="text-center">데이터가 없습니다.</td>';
					} else {
						for (key in data) {
							var vmNameToString = "\'" + data[key].sVmName + "\'";
							var portgroupToString = "\'" + data[key].portgroup + "\'";

							html += '<tr>';
							html += '<td class="text-center">' + data[key].labelNumber + '</td>';
							html += '<td>' + data[key].portgroup + '</td>';
							if (data[key].ipAddress == '' || data[key].ipAddress == null) {
								html += '<td><span class="text-muted">없음</span></td>';
							} else {
								html += '<td>' + data[key].ipAddress + '</td>';
							}
							if (data[key].status == 'true') {
								html += '<td><span class="text-prom">' + connect + '</span></td>';
							} else if (data[key].status == 'false') {
								html += '<td><span class="text-prom">' + disconnect + '</span></td>';
							} else {
								html += '<td><span class="text-muted">비정상</span></td>';
							}
							html += '<td>';
							
							if(sessionApproval > CONTROLCHECK){
							
							html += '<a href="#" class="list-icons-item" data-toggle="dropdown"><i class="icon-menu9"></i></a>';
							html += '<div class="dropdown-menu">';
							if (data[key].status == 'true') {
								html += '<a href="#" class="dropdown-item" onclick="ctrlNetworkAdapterOfVM(' + vmIDToString + ',' + disconnectToString + ',' + vmNameToString + ',' + data[key].labelNumber + ',' + portgroupToString + ')"><i class="icon-unlink"></i>' + btnDisconnect + '</a>';
							} else if (data[key].status == 'false') {
								html += '<a href="#" class="dropdown-item" onclick="ctrlNetworkAdapterOfVM(' + vmIDToString + ',' + connectToString + ',' + vmNameToString + ',' + data[key].labelNumber + ',' + portgroupToString + ')"><i class="icon-link"></i>' + connect + '</a>';
							}
							html += '</div>';
							
							} else { html += '<i class="icon-lock2"></i>'; }
							
							html += '</td>';
							html += '</tr>';
						}
						globalNetworkMaxNum = (data.length + 1);

						$("#vmNetworkList").empty();
						$("#vmNetworkList").append(html);
					}
				}
			})
		}

		function ctrlNetworkAdapterOfVM(vmID, conn, vmName, labelNumber, portgroup) {
			var footer = '';
			$.ajax({
				url: "/apply/controlVMNetwork.do",
				type: 'POST',
				data: {
					mode: conn,
					sVmName: vmName,
					labelNumber: labelNumber,
					portgroup: portgroup
				},
				beforeSend: function() {
					footer += '<button type="button" class="btn bg-prom rounded-round">네트워크 어댑터 상태변경 작업..<i class="icon-spinner2 spinner ml-2"></i></button>';
					$("#modal-footer").empty();
					$("#modal-footer").append(footer);
				},
				success: function(data) {
					$("#addVMInfo").modal("hide");
					
					if (data == 1) {
						alert("네트워크 어댑터 상태변경이 완료되었습니다.");
					} else {
						alert("네트워크 어댑터 상태변경을 실패하였습니다.");
					}
					setTimeout(function() {
						vmNetworkInfo(vmID);
					}, 300);
				}
			})
		}

		// CD-ROM 정보
		function vmCDROMInfo(vm_ID) {
			var html = '';
			var vmIDToString = "\'" + vm_ID + "\'";

			$.ajax({
				data: {
					vmID: vm_ID
				},
				url: "/apply/selectVMCDROMList.do",
				success: function(data) {
					if (dataEmptyCheck(data)) {
						html += '<td colspan="5" class="text-center">데이터가 없습니다.</td>';
					} else {
						for (key in data) {
							var vmNameToString = "\'" + data[key].sVmName + "\'";
							var dataStoreNameToString = "\'" + data[key].dataStoreName + "\'";
							var filePathToString = "\'" + data[key].filePath + "\'";

							html += '<tr>';
							html += '<td class="text-center">' + data[key].nSCSInumber + '</td>';
							html += '<td>' + data[key].dataStoreName + '</td>';
							html += '<td>' + data[key].filePath + '</td>';
							
							if (data[key].status == 'true') {
								html += '<td><span class="text-prom">' + connect + '</span></td>';
							} else if (data[key].status == 'false') {
								html += '<td><span class="text-muted">' + disconnect + '</span></td>';
							} else {
								html += '<td><span class="text-muted">비정상</span></td>';
							}
							html += '<td>';
							if(sessionApproval > CONTROLCHECK){
								
							html += '<a href="#" class="list-icons-item" data-toggle="dropdown"><i class="icon-menu9"></i></a>';
							html += '<div class="dropdown-menu">';
							if (data[key].status == 'true') {
								var mode = "\'UNMOUNT\'";
								html += '<a href="#" class="dropdown-item" onclick="ctrlCDROM(' + vmIDToString + ',' + vmNameToString + ',' + dataStoreNameToString + ',' + filePathToString + ',' + mode + ')"><i class="icon-unlink"></i>' + btnDisconnect + '</a>';
							} else if (data[key].status == 'false') {
								var mode = "\'MOUNT\'";
								html += '<a href="#" class="dropdown-item" onclick="ctrlCDROM(' + vmIDToString + ',' + vmNameToString + ',' + dataStoreNameToString + ',' + filePathToString + ',' + mode + ')"><i class="icon-link"></i>' + connect + '</a>';
							}
							
							html += '</div>';
							} else { html += '<i class="icon-lock2"></i>'; }
							html += '</td>';
							html += '</tr>';
						}
					}
					$("#vmCDROMList").empty();
					$("#vmCDROMList").append(html);
				}
			})
		}

		function ctrlCDROM(vm_ID, vmName, dataStoreName, filePath, mode) {
			$.ajax({
				data: {
					sVmID: vm_ID,
					sVmName: vmName,
					dataStoreName: dataStoreName,
					filePath: filePath,
					mode: mode
				},
				type: 'POST',
				url: "/apply/controlVMCDROM.do",
				beforeSend: function() {
					$("#vmDeleteLoading").show();
					$("#loadingMessages").text("CD-ROM 연결 해제중...");
				},
				success: function(data) {
					$("#vmDeleteLoading").hide();
					$("#loadingMessages").text("");
					alert("CD-ROM 연결 상태가 변경되었습니다.");
					vmCDROMInfo(vm_ID);
				}
			})
		}

		function mountCD(service_id,vm_ID, vmName,authoritychk) {
			var datastoreSBCDROM = $("#datastoreSBCDROM option:selected").text();
			var reasonContext = $("#reasonContext").val();
			var sISO = $("#sISO").val();
			var footer = '';

			$.ajax({
				data: {
					serviceId : service_id,
					sVmID: vm_ID,
					sVmName: vmName,
					dataStoreName: datastoreSBCDROM,
					filePath: sISO,
					role : authoritychk,
					reasonContext : reasonContext
				},
				type: 'POST',
				url: "/apply/mountVMCDROM.do",
				beforeSend: function() {
					footer += '<button type="button" class="btn bg-prom rounded-round">CD 마운트 작업..<i class="icon-spinner2 spinner ml-2"></i></button>';
					$("#modal-footer").empty();
					$("#modal-footer").append(footer);
				},
				success: function(data) {
					$("#addVMInfo").modal("hide");
					
					msg = authorityMsg("연결",authoritychk);
					
					if (data == 1) {
						alert("CD-ROM "+msg+"이 완료되었습니다.");
					} else if (data == 2) {
						alert("이미 CD-ROM에 CD가 연결돼있습니다.");
					} else {
						alert("CD-ROM "+msg+"을 실패하였습니다.");
					}
					vmCDROMInfo(vm_ID)
				}
			})
		}

		function addDiskOfVM(service_id,vmName, vm_ID,authoritychk) {
			var diskCapacity = $("#diskCapacity").val();
			var datastoreSBDisk = $("#datastoreSBDisk option:selected").val();
			var datastoreSBDiskText = $("#datastoreSBDisk option:selected").text();
			var reasonContext = $("#reasonContext").val();
			var footer = '';

			$.ajax({
				data: {
					serviceId : service_id,
					sVmName: vmName,
					nSCSInumber: globalDiskMaxNum,
					sDiskLocation: datastoreSBDiskText,
					sDiskId: datastoreSBDisk,
					nDiskCapacity: diskCapacity,
					role : authoritychk,
					reasonContext : reasonContext
				},
				type: 'POST',
				url: "/apply/addVMDisk.do",
				beforeSend: function() {
					footer += '<button type="button" class="btn bg-prom rounded-round">디스크 추가 작업..<i class="icon-spinner2 spinner ml-2"></i></button>';
					$("#modal-footer").empty();
					$("#modal-footer").append(footer);
				},
				success: function(data) {
					$("#addVMInfo").modal("hide");
					
					msg = authorityMsg("추가",authoritychk);
					
					if (data == 1) {
						alert("Disk "+msg+" 완료되었습니다.");
					} else {
						alert("Disk "+msg+" 실패하였습니다.");
					}
					commonVMTable.ajax.reload( null, false );
					getOneVMInfo(0);
					$("#diskCapacity").val('');
				}
			})
		}

		function addvNICOfVM(service_id,vmName, vm_ID,authoritychk) {
			var portGroupSB = $("#portGroupSB option:selected").val();
			var portGroupSBText = $("#portGroupSB option:selected").text();
			var reasonContext = $("#reasonContext").val();
			var footer = '';

			$.ajax({
				data: {
					serviceId : service_id,
					sVmName: vmName,
					portgroup: portGroupSBText,
					portgroupId: portGroupSB,
					role : authoritychk,
					reasonContext : reasonContext
				},
				type: 'POST',
				url: "/apply/addVMNetwork.do",
				beforeSend: function() {
					footer += '<button type="button" class="btn bg-prom rounded-round">네트워크 어댑터 추가 작업..<i class="icon-spinner2 spinner ml-2"></i></button>';
					$("#modal-footer").empty();
					$("#modal-footer").append(footer);
				},
				success: function(data) {
					$("#addVMInfo").modal("hide");
					
					msg = authorityMsg("추가",authoritychk);
					
					if (data == 1) {
						alert("네트워크 어댑터 "+msg+" 완료되었습니다.");
					} else {
						alert("네트워크 어댑터 "+msg+" 실패하였습니다.");
					}
					vmNetworkInfo(vm_ID);
				}
			})
		}

		function serviceInVM() {
			setTimeout(function() {
				var commonVMTable = $('#serviceVMTable').DataTable();
				commonVMTable.destroy();

				serviceInVMs();
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
	
	 <div id="addVMInfo" class="modal fade">
		<div class="modal-dialog modal-sm">
			<div class="modal-content" style="margin-top: 100px;">
				<div class="modal-header bg-prom" id="modal-header"></div>
				<div class="modal-body modal-type-5">
					
					<!-- Disk -->
					<div id="addDisk1">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>Disk #</label>
									<input type="text" class="form-control form-control-modal" id="diskNum" disabled>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>데이터스토어:<span class="text-prom ml-2">(필수)</span></label>
									<select class="form-control select-search" id="datastoreSBDisk" data-fouc></select>
								</div>
							</div>
						</div>
					</div>
					<div id="addDisk2">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>추가 용량 (GB):<span class="text-prom ml-2">(필수)</span></label>
									<input type="number" class="form-control form-control-modal" placeholder="capacity" autocomplete="off" id="diskCapacity">
								</div>
							</div>
						</div>
					</div>

					<!-- vNIC -->
					<div id="addvNIC">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>인터페이스 #</label>
									<input type="text" class="form-control form-control-modal" id="portGroupNum" disabled>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>네트워크 인터페이스 (PortGroup)​:<span class="text-prom ml-2">(필수)</span></label>
									<select class="form-control select-search" id="portGroupSB" data-fouc></select>
								</div>
							</div>
						</div>
					</div>

					<!-- CD-ROM -->
					<div id="addCDROM">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>CD-ROM #</label>
									<input type="text" class="form-control form-control-modal" id="numCDROM" value="1" disabled>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>데이터스토어:<span class="text-prom ml-2">(필수)</span></label>
									<select class="form-control select-search" id="datastoreSBCDROM" data-fouc></select>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>연결 파일명 (ISO):<span class="text-prom ml-2">(필수)</span></label>
									<input type="text" class="form-control form-control-modal" placeholder="path/file.iso" autocomplete="off" id="sISO">
								</div>
							</div>
						</div>
					</div>

					<!-- 사용자 신청 사유 -->
					<div class="row" id="addContextDiv">
						<div class="col-sm-12 col-xl-12">
							<div class="form-group">
								<label>신청 사유:<span class="text-prom ml-2">(필수)</span></label>
								<textarea class="form-control form-control-modal" placeholder="reason" autocomplete="off" maxlength="200" id="reasonContext"></textarea>
							</div>
						</div>
					</div>
					<div class="row" id="addSpanDiv">
						<div class="col-sm-12 col-xl-12 mb-2-5">
							<span><i class="icon-exclamation text-prom mr-2"></i>연결할 소프트웨어명, 파일명 등을 입력하십시오.</span>
						</div>
					</div>
				</div>
				<div class="modal-footer bg-white" id="modal-footer"></div>
			</div>
		</div>
	</div>

	<div class="card bg-dark mb-0 table-type-9">
		<div class="row-padding-0">
			<div class="col-sm-12 col-xl-4 padding-0">
				<div class="card bg-dark mb-0 table-type-3 table-type-5-2 border-bottom-light">
					<div class="table-filter-light">
						<div class="col-xl-6 col-sm-6">
							<select class="form-control select-search" id="tenantSelcetBox" onchange="serviceInTenant()" data-fouc></select>
						</div>
						<div class="col-xl-6 col-sm-6">
							<select class="form-control select-search" id="tenantInServiceSelcetBox" onchange="serviceInVM()" data-fouc></select>
						</div>
					</div>
					<table id="serviceVMTable" class="promTable hover cpointer" style="width: 100%;">
						<thead>
							<tr>
								<th>가상머신명</th>
								<th>vCPU</th>
								<th>Memory</th>
								<th>Disk</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<div class="col-sm-12 col-xl-8 padding-0">
				<div class="card bg-dark mb-0 table-type-1 table-type-2">
					<div class="table-title-dark align-items-end">
						<h6 class="card-title mb-0"><b>가상머신 상세 정보</b></h6>
						<!-- 나중으로 보류 (시간없음)
								 <button type="submit" class="btn bg-prom"><i class="icon-import"></i><span class="ml-2">내보내기</span></button> -->
					</div>
					<div id="rightCard">
						<div class="table-title-dark">
							<h6 class="card-title mb-0">기본 정보 <span class="font-size-base ml-2" id="vmOneTitle"></span></h6>
							<div class="list-icons" id="vmOnOffBtn"></div>
						</div>
						<div class="datatables-body border-bottom-light">
							<table class="promTable hover" style="width: 100%;">
								<thead>
									<tr>
										<th>호스트명</th>
										<th>OS명</th>
										<th>vCPU</th>
										<th>Memory</th>
										<th>Total Disk</th>
										<th>CPU 핫플러그</th>
										<th>Memory 핫플러그</th>
										<th>Tools</th>
										<th>전원</th>
									</tr>
								</thead>
								<tbody id="vmBasicList">
									<tr>
										<td colspan="9" class="text-center">가상 머신을 하나 선택하세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="table-title-dark">
							<h6 class="card-title mb-0">Disk 정보</h6>
							<div id="addDiskBtn"></div>
						</div>
						<div class="datatables-body border-bottom-light">
							<table class="promTable hover" style="width: 100%;">
								<thead>
									<tr>
										<th width="5%" class="text-center">#</th>
										<th>데이터스토어명</th>
										<th>용량 (GB)​</th>
										<th width="25%">유형</th>
									</tr>
								</thead>
								<tbody id="vmDiskList">
									<tr>
										<td colspan="4" class="text-center">&emsp;</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="table-title-dark">
							<h6 class="card-title mb-0">Network 인터페이스 정보</h6>
							<div id="addvNICBtn"></div>
						</div>
						<div class="datatables-body border-bottom-light">
							<table class="promTable hover" style="width: 100%;">
								<thead>
									<tr>
										<th width="5%" class="text-center">#</th>
										<th>Network 인터페이스명 (PortGroup)</th>
										<th>IP 주소</th>
										<th width="15%">상태</th>
										<th width="10%">관리</th>
									</tr>
								</thead>
								<tbody id="vmNetworkList">
									<tr>
										<td colspan="5" class="text-center">&emsp;</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="table-title-dark">
							<h6 class="card-title mb-0">CD-ROM 정보</h6>
							<div id="addCDROMBtn"></div>
						</div>
						<div class="datatables-body">
							<table class="promTable hover" style="width: 100%;">
								<thead>
									<tr>
										<th width="5%" class="text-center">#</th>
										<th>데이터스토어명</th>
										<th>연결 파일명</th>
										<th width="15%">상태</th>
										<th width="10%">관리</th>
									</tr>
								</thead>
								<tbody id="vmCDROMList">
									<tr>
										<td colspan="5" class="text-center">&emsp;</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>