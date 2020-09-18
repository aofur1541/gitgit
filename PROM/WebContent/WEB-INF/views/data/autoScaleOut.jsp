<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/commonValidation.js"></script>
		<script type="text/javascript">
			var hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	
			$(document).ready(function() {
	
				if (sessionApproval <= CONTROLCHECK) {
					ftnlimited(3);
				}
	
				getAutoScaleList();
				getTemplateList();
				getTenantList();
	
				$(document).on('change', '#tenantSB', function() {
					serviceInTenant();
				})
	
				$(document).on('change', '#tenantSBup', function() {
					serviceInTenantUp();
				})
	
				commonModalOpen("addAutoScaleOut", "tenantSB");
			})
			
			function autoScaleRegisterEnterkey() {
				if (window.event.keyCode == 13) {
					vmthresHoldInsertConfirm();
				}
			}

			function getTenantList() {
	
				$.ajax({
					url: "/tenant/selectTenantList.do",
					success: function(data) {
						var html = '';
						html += '<option value="" selected disabled>:: 테넌트를 선택하십시오. ::</option>';
	
						for (key in data) {
							html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
						}
	
						$("#tenantSB").empty();
						$("#tenantSB").append(html);
					}
				})
			}
	
			function serviceInTenant() {
				var tenantsID = $("#tenantSB option:selected").val();
	
				$.ajax({
					data: {
						tenantId: tenantsID
					},
					url: "/tenant/selectVMServiceListByTenantId.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value="" selected disabled>:: 테넌트에 포함된 서비스가 없습니다. ::</option>';
						} else {
							for (key in data) {
								html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].dhcpOnoff + '>' + data[key].vmServiceName + '</option>';
							}
						}
						$("#tenantInServiceSB").empty();
						$("#tenantInServiceSB").append(html);
					}
				})
			}
	
			function getTemplateList() {
	
				var sorting = 'DESC';
	
				$.ajax({
	
					data: {
						sort: sorting
					},
					url: "/apply/selectVMTemplateOnList.do",
					success: function(data) {
						var html = '';
						html += '<option value="" selected disabled>:: 템플릿을 선택하십시오. ::</option>';
						for (key in data) {
							html += '<option value=' + data[key].vmID + '>' + data[key].vmName + '</option>';
						}
						$("#templateSB").empty();
						$("#templateSB").append(html);
					}
				})
			}
	
			function vmthresHoldInsertConfirm() {
	
				/* var isUse = 0;
				($("input:checkbox[id='useAutoScale']").is(":checked") == true) ? isUse = 1: isUse = 0; */
				
				var isUse = $("input[name='autoScale_onoff']:checked").val();
				
				var templateSBval = $("#templateSB option:selected").val();
				var tenantSBval = $("#tenantSB option:selected").val();
				var serviceSBval = $("#tenantInServiceSB option:selected").val();
	
				var templateSBtext = $("#templateSB option:selected").text();
				var serviceSBtext = $("#tenantInServiceSB option:selected").text();
	
				var minVM = parseInt($("#minVM").val());
				var maxVM = parseInt($("#maxVM").val());
				var naming = $("#naming").val();
				var postfix = $("#postfix").val();
				var startIP = $("#startIPAddr").val();
				var endIP = $("#endIPAddr").val();
				var upCPU = parseInt($("#scaleUpCPU").val());
				var upMemory = parseInt($("#scaleUpMemory").val());
				var downCPU = parseInt($("#scaleDownCPU").val());
				var downMemory = parseInt($("#scaleDownMemory").val());
	
				var shrinkLimit = 10;
				
				var startSplit = startIP.split('.');
				var endSplit = endIP.split('.');
	
				var startResult = startSplit[startSplit.length - 1];
				var endResult = endSplit[endSplit.length - 1];
	
				var ipCnt = (endResult - startResult) + 1;
				if (!tenantSBval) {
					alert("테넌트를 선택하십시오.");
					$("#tenantSB").focus();
					return false;
				} else if (!serviceSBval) {
					alert("서비스를 선택하십시오");
					$("#tenantInServiceSB").focus();
					return false;
				} else if (!minVM) {
					alert("최소 가상머신 개수는 필수 기입 항목입니다.");
					$("#minVM").focus();
					return false;
				} else if (!maxVM) {
					alert("최대 가상머신 개수는 필수 기입 항목입니다.");
					$("#maxVM").focus();
					return false;
				} else if (minVM > maxVM) {
					alert("최소 가상머신 개수가 최대 가상머신 개수보다 많을 수 없습니다.");
					$("#maxVM").focus();
					return false;
				} else if (!naming) {
					alert("네이밍은 필수 기입 항목입니다.");
					$("#naming").focus();
					return false;
				} else if (hangulcheck.test(naming)) {
					$("#naming").focus();
					alert("네이밍 룰에 한글을 넣을 수 없습니다.");
					return false;
				} else if (blank_pattern.test(naming)) {
					$("#naming").focus();
					alert("네이밍 룰에 공백(띄어쓰기)을 넣을 수 없습니다.");
					return false;
				} else if (!postfix) {
					alert("Postfix는 필수 기입 항목입니다.");
					$("#postfix").focus();
					return false;
				} else if (numberRegexchk.test(postfix)) {
					alert("Postfix의 값은 숫자로만 넣어야 합니다.");
					$("#postfix").focus();
					return false;
				} else if (!startIP) {
					alert("시작 IP 주소는 필수 기입 항목입니다.");
					$("#startIPAddr").focus();
					return false;
				} else if (!filter.test($('#startIPAddr').val())) {
					$("#startIPAddr").focus();
					alert("시작IP의 IP4 형식이 올바르지 않습니다.");
					return false;
				} else if (!endIP) {
					alert("끝 IP 주소는 필수 기입 항목입니다.");
					$("#endIPAddr").focus();
					return false;
				} else if (!filter.test($('#endIPAddr').val())) {
					$("#endIPAddr").focus();
					alert("끝IP의 IP4 형식이 올바르지 않습니다.");
					return false;
				} else if ((endResult - startResult) < 1) {
					$("#startIPAddr").focus();
					alert("시작 IP가 끝 IP보다 높을 수 없습니다.");
					return false;
				} else if (ipCnt != maxVM) {
					$("#endIPAddr").focus();
					alert("최소-최대 가상머신 개수와 시작-끝 IP 개수가 동일해야 합니다.");
					return false;
				} else if (startSplit[0] != endSplit[0]) {
					$("#endIPAddr").focus();
					alert("첫 번째 아이피 자리가 맞지 않습니다.");
					return false;
				} else if (startSplit[1] != endSplit[1]) {
					$("#endIPAddr").focus();
					alert("두 번째 아이피 자리가 맞지 않습니다.");
					return false;
				} else if (startSplit[2] != endSplit[2]) {
					$("#endIPAddr").focus();
					alert("세 번째 아이피 자리가 맞지 않습니다.");
					return false;
				} else if (!upCPU) {
					alert("Scale Out CPU 임계치는 필수 기입 항목입니다.");
					$("#scaleUpCPU").focus();
					return false;
				} else if (!upMemory) {
					alert("Scale Out Memory 임계치는 필수 기입 항목입니다.");
					$("#scaleUpMemory").focus();
					return false;
				} else if (!downCPU && downCPU != 0) {
					alert("Scale In CPU 임계치는 필수 기입 항목입니다.");
					$("#scaleDownCPU").focus();
					return false;
				} else if (!downMemory && downMemory != 0) {
					alert("Scale In Memory 임계치는 필수 기입 항목입니다.");
					$("#scaleDownMemory").focus();
					return false;
				} else if ((upCPU || upMemory || downCPU || downMemory) > 100) {
					alert("Scale 임계치를 재설정 하십시오. (1~100)");
					return false;
				} else if (upCPU < downCPU) {
					alert("Scale Out CPU 임계치가 Scale In CPU 임계치보다\n낮을 수 없습니다.");
					$("#scaleUpCPU").focus();
					return false;
				} else if (upMemory < downMemory) {
					alert("Scale Out Memory 임계치가 Scale In Memory 임계치보다\n낮을 수 없습니다.");
					$("#scaleUpMemory").focus();
					return false;
				}  else if (!templateSBval) {
					alert("템플릿을 선택 하십시오.");
					$("#templateSB").focus();
					return false;
				} else {
					if (confirm("Auto Scale Out 등록을 하시겠습니까?") == true) {
	
						$.ajax({
	
							url: "/jquery/autoScaleInsert.do",
							type: "POST",
							dataType: "json",
							contentType: "application/json;charset=UTF-8",
							data: JSON.stringify({
								service_id: serviceSBval,
								template_id: templateSBval,
								template_ids: templateSBtext,
								service_ids: serviceSBtext,
								minVM: minVM,
								maxVM: maxVM,
								naming: naming,
								postfix: postfix,
								startIP: startIP,
								endIP: endIP,
								isUse: isUse,
								cpuUp: upCPU,
								memoryUp: upMemory,
								cpuDown: downCPU,
								memoryDown: downMemory
							}),
							success: function(data) {
								if (data == 1) {
									alert("Auto Scale Out 등록이 완료되었습니다.");
									window.parent.location.reload();
								} else if (data == 2) {
									alert("해당 서비스는 이미 Auto Scale Out이 등록되어 있습니다.");
								}
							},
							error: function() {
								alert("통신 에러 ");
							}
						})
	
					} else {
						return false;
					}
				}
			}
	
			function getAutoScaleList() {
				var autoScaleOutTable = $("#autoScaleOutTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/jquery/getAutoScaleList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "serviceName",
								render: function(data, type, row) {
									var ten = '';
									var se = '';

									if (row.tenants_id == 0) {
										ten = 'De';
									} else {
										ten = row.tenants_id;
									}
									
									if (row.service_id == 0) {
										se = 'De';
									} else {
										se = row.service_id;
									}
									
									var tenantsLink = "\'" + '/menu/inventoryStatus.do?ten=' + ten + '&se=' + se +"#2\'";
									
									data = '<a href="#" onclick="javascript:window.parent.location.href=' + tenantsLink + '">' + data + '</a>';
									 
									return data;
								}
							},
							{"data": "cpuUp",
								render: function(data, type, row) {
									data = data + ' %';
									return data;
								}
							},
							{"data": "memoryUp",
								render: function(data, type, row) {
									data = data + ' %';
									return data;
								}
							},
							{"data": "cpuDown",
								render: function(data, type, row) {
									data = data + ' %';
									return data;
								}
							},
							{"data": "memoryDown",
								render: function(data, type, row) {
									data = data + ' %';
									return data;
								}
							},
							{"data": "minVM"},
							{"data": "maxVM"},
							{"data": "naming",
								render: function(data, type, row) {
									data = data + '<span class="text-prom">' + row.postfix + '</span>';
									return data;
								}
							},
							{"data": "startIP"},
							{"data": "endIP"},
							{"data": "vmName"},
							{"data": "isUse",
								render: function(data, type, row) {
									if (data == 1) {
										data = '<span class="text-prom">ON</span>';
									} else if (data == 0) {
										data = '<span class="text-muted">OFF</span>';
									}
									return data;
								}
							},
							{"data": "id",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
									var serviceName = "\'" + row.serviceName + "\'";
									
									if (sessionApproval != BanNumber && sessionApproval > CONTROLCHECK){
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
										html += '<a href="#" class="dropdown-item" onclick="autoScaleUpdateCheck(' + data + ', ' + serviceName + ', ' + 1 + ')"><i class="icon-file-text"></i>상세 보기</a>';
										html += '<a href="#" class="dropdown-item" onclick="autoScaleUpdateCheck(' + data + ', ' + serviceName + ', ' + 2 + ')"><i class="icon-pencil7"></i>정보 변경</a>';
										html += '<a href="#" class="dropdown-item" onclick="autoScaleDelete(' + data + ', ' + serviceName + ', ' + row.isUse + ')"><i class="icon-trash"></i>삭제</a>';
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
									title: "Auto Scale 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "Auto Scale 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
									}
								}
							]
						}]
					});
				$(".addModal").html('<button type="button" class="btn bg-prom" data-toggle="modal" data-target="#addAutoScaleOut"><i class="icon-plus2"></i><span class="ml-2">Auto Scale Out 등록</span></button>');
			}
			
			function getTenantListUp(tenants_id, service_id) {
				
				$.ajax({
					url: "/tenant/selectTenantList.do",
					success: function(data) {
						var html = '';
	
						for (key in data) {
							if (tenants_id != data[key].id) {
								html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
							} else {
								html += '<option value=' + data[key].id + ' value2=' + data[key].name + ' selected>' + data[key].name + '</option>';
							}
						}
	
						$("#tenantSBup").empty();
						$("#tenantSBup").append(html);
						serviceInTenantUp(service_id);
					}
				})
			}
	
			function serviceInTenantUp(service_id) {
				var tenantsID = $("#tenantSBup option:selected").val();
	
				$.ajax({
					data: {
						tenantId: tenantsID
					},
					url: "/tenant/selectVMServiceListByTenantId.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value="" selected disabled>:: 테넌트에 포함된 서비스가 없습니다. ::</option>';
						} else {
							for (key in data) {
								if (service_id != data[key].vmServiceID) {
									html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].dhcpOnoff + '>' + data[key].vmServiceName + '</option>';
								} else {
									html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].dhcpOnoff + ' selected>' + data[key].vmServiceName + '</option>';
								}
							}
						}
						$("#tenantInServiceSBup").empty();
						$("#tenantInServiceSBup").append(html);
					}
				})
			}
	
			function getTemplateListUp(template_id) {
	
				var sorting = 'DESC';
	
				$.ajax({
	
					data: {
						sort: sorting
					},
					url: "/apply/selectVMTemplateOnList.do",
					success: function(data) {
						var html = '';
						for (key in data) {
							if (template_id != data[key].vmID) {
								html += '<option value=' + data[key].vmID + '>' + data[key].vmName + '</option>';
							} else {
								html += '<option value=' + data[key].vmID + ' selected>' + data[key].vmName + '</option>';
							}
						}
						$("#templateSBup").empty();
						$("#templateSBup").append(html);
					}
				})
			}
			
			function autoScaleUpdateCheck(id, serviceName, index) {
				$.ajax({
					data: {
						id: id,
						serviceName: serviceName
					},
					url: "/jquery/getAutoScaleOneinfo.do",
					success: function(data) {
						btnStatusChk(id, serviceName, index);

						for (key in data){
							getTenantListUp(data[key].tenants_id,data[key].service_id);
							getTemplateListUp(data[key].template_id);	
							$("#tenantSBup").val();
							$("#tenantInServiceSBup").val();
							$("#minVMup").val(data[key].minVM);
							$("#maxVMup").val(data[key].maxVM);
							$("#namingup").val(data[key].naming);
							$("#postfixup").val(data[key].postfix);
							$("#startIPAddrup").val(data[key].startIP);
							$("#endIPAddrup").val(data[key].endIP);
							$("#scaleUpCPUup").val(data[key].cpuUp);
							$("#scaleUpMemoryup").val(data[key].memoryUp);
							$("#scaleDownCPUup").val(data[key].cpuDown);
							$("#scaleDownMemoryup").val(data[key].memoryDown);
							$("#templateSBup").val();
							
							if (data[key].isUse == 0) {
								$("input:radio[name='autoScale_onoffup'][value='0']").prop("checked", true);
							} else if (data[key].isUse == 1) {
								$("input:radio[name='autoScale_onoffup'][value='1']").prop("checked", true);
							}
						}

						$("#changeAutoScaleOut").modal("show");
					}
				})
			}
			
			function btnStatusChk(id, name, index) {
				var header = '';
				var footer = '';
	
				if (index == 1) {
					header += '<h5 class="modal-title mb-0">Auto Scale Out 상세 보기</h5>';
					$("#modal-footer").hide();
	
				} else if (index == 2) {
					header += '<h5 class="modal-title mb-0">Auto Scale Out 정보 변경</h5>';
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="autoScaleUpdate(' + id + ')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
					$("#modal-footer").show();
				}
				header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	
				$("#modal-header").empty();
				$("#modal-header").append(header);
	
				$("#modal-footer").empty();
				$("#modal-footer").append(footer);
	
				$("#required-inputup").addClass("show");
	
				if (index == 1) {
					$("#tenantSBup").attr("disabled", true);
					$("#tenantInServiceSBup").attr("disabled", true);
					$("#minVMup").attr("disabled", true);
					$("#maxVMup").attr("disabled", true);
					$("#namingup").attr("disabled", true);
					$("#postfixup").attr("disabled", true);
					$("#startIPAddrup").attr("disabled", true);
					$("#endIPAddrup").attr("disabled", true);
					$("#scaleUpCPUup").attr("disabled", true);
					$("#scaleUpMemoryup").attr("disabled", true);
					$("#scaleDownCPUup").attr("disabled", true);
					$("#scaleDownMemoryup").attr("disabled", true);
					$("#templateSBup").attr("disabled", true);
					$("#autoScale_onup").attr("disabled", true);
					$("#autoScale_offup").attr("disabled", true);

				} else if (index == 2) {
					$("#tenantSBup").attr("disabled", true);
					$("#tenantInServiceSBup").attr("disabled", true);
					$("#minVMup").attr("disabled", false);
					$("#maxVMup").attr("disabled", false);
					$("#namingup").attr("disabled", false);
					$("#postfixup").attr("disabled", false);
					$("#startIPAddrup").attr("disabled", false);
					$("#endIPAddrup").attr("disabled", false);
					$("#scaleUpCPUup").attr("disabled", false);
					$("#scaleUpMemoryup").attr("disabled", false);
					$("#scaleDownCPUup").attr("disabled", false);
					$("#scaleDownMemoryup").attr("disabled", false);
					$("#templateSBup").attr("disabled", false);
					$("#autoScale_onup").attr("disabled", false);
					$("#autoScale_offup").attr("disabled", false);
				}
				
			}
			
			function autoScaleUpdate(id) {
	
				var isUse = $("input[name='autoScale_onoffup']:checked").val();
				
				var templateSBval = $("#templateSBup option:selected").val();
				var tenantSBval = $("#tenantSBup option:selected").val();
				var serviceSBval = $("#tenantInServiceSBup option:selected").val();
	
				var templateSBtext = $("#templateSBup option:selected").text();
				var serviceSBtext = $("#tenantInServiceSBup option:selected").text();
	
				var minVM = parseInt($("#minVMup").val());
				var maxVM = parseInt($("#maxVMup").val());
				var naming = $("#namingup").val();
				var postfix = $("#postfixup").val();
				var startIP = $("#startIPAddrup").val();
				var endIP = $("#endIPAddrup").val();
				var upCPU = parseInt($("#scaleUpCPUup").val());
				var upMemory = parseInt($("#scaleUpMemoryup").val());
				var downCPU = parseInt($("#scaleDownCPUup").val());
				var downMemory = parseInt($("#scaleDownMemoryup").val());
	
				var shrinkLimit = 10;
				
				var startSplit = startIP.split('.');
				var endSplit = endIP.split('.');
	
				var startResult = startSplit[startSplit.length - 1];
				var endResult = endSplit[endSplit.length - 1];
	
				var ipCnt = (endResult - startResult) + 1;
	
				if (!tenantSBval) {
					alert("테넌트를 선택하십시오.");
					$("#tenantSBup").focus();
					return false;
				} else if (!serviceSBval) {
					alert("서비스를 선택하십시오");
					return false;
					$("#tenantInServiceSBup").focus();
				} else if (!minVM) {
					alert("최소 가상머신 개수를 기입하십시오.");
					$("#minVMup").focus();
					return false;
				} else if (!maxVM) {
					alert("최대 가상머신 개수는 필수 기입 항목입니다.");
					$("#maxVMup").focus();
					return false;
				} else if (minVM > maxVM) {
					alert("최소 가상머신 개수가 최대 가상머신 개수보다 많을 수 없습니다.");
					$("#maxVMup").focus();
					return false;
				} else if (!naming) {
					alert("네이밍은 필수 기입 항목입니다.");
					$("#namingup").focus();
					return false;
				} else if (hangulcheck.test(naming)) {
					alert("네이밍 룰에 한글을 넣을 수 없습니다.");
					$("#namingup").focus();
					return false;
				} else if (blank_pattern.test(naming)) {
					alert("네이밍 룰에 공백(띄어쓰기)을 넣을 수 없습니다.");
					$("#namingup").focus();
					return false;
				} else if (!postfix) {
					alert("Postfix는 필수 기입 항목입니다.");
					$("#postfixup").focus();
					return false;
				} else if (numberRegexchk.test(postfix)) {
					alert("Postfix의 값은 숫자로만 넣어야 합니다.");
					$("#postfixup").focus();
					return false;
				} else if (!startIP) {
					alert("시작 IP 주소는 필수 기입 항목입니다.");
					$("#startIPAddrup").focus();
					return false;
				} else if (!filter.test($('#startIPAddrup').val())) {
					alert("시작IP의 IP4 형식이 올바르지 않습니다.");
					$("#startIPAddrup").focus();
					return false;
				} else if (!endIP) {
					alert("끝 IP 주소는 필수 기입 항목입니다.");
					$("#endIPAddrup").focus();
					return false;
				} else if (!filter.test($('#endIPAddrup').val())) {
					alert("끝IP의 IP4 형식이 올바르지 않습니다.");
					$("#endIPAddrup").focus();
					return false;
				} else if (ipCnt != maxVM) {
					$("#endIPAddrup").focus();
					alert("최소-최대 가상머신 개수와 시작-끝 IP 개수가 동일해야 합니다.");
					return false;
				} else if (startSplit[0] != endSplit[0]) {
					$("#endIPAddrup").focus();
					alert("첫 번째 아이피 자리가 맞지 않습니다.");
					return false;
				} else if (startSplit[1] != endSplit[1]) {
					$("#endIPAddrup").focus();
					alert("두 번째 아이피 자리가 맞지 않습니다.");
					return false;
				} else if (startSplit[2] != endSplit[2]) {
					$("#endIPAddrup").focus();
					alert("세 번째 아이피 자리가 맞지 않습니다.");
					return false;
				} else if (!upCPU) {
					alert("Scale Out CPU 임계치는 필수 기입 항목입니다.");
					$("#scaleUpCPUup").focus();
					return false;
				} else if (!upMemory) {
					alert("Scale Out Memory 임계치는 필수 기입 항목입니다.");
					$("#scaleUpMemoryup").focus();
					return false;
				} else if (!downCPU && downCPU != 0) {
					alert("Scale In CPU 임계치는 필수 기입 항목입니다.");
					$("#scaleDownCPUup").focus();
					return false;
				} else if (!downMemory && downMemory != 0) {
					alert("Scale In Memory 임계치는 필수 기입 항목입니다.");
					$("#scaleDownMemoryup").focus();
					return false;
				} else if ((upCPU || upMemory || downCPU || downMemory) > 100) {
					alert("Scale 임계치를 재설정 하십시오. (1~100)");
					return false;
				} else if (upCPU < downCPU) {
					alert("Scale Out CPU 임계치가 Scale In CPU 임계치보다\n낮을 수 없습니다.");
					$("#scaleUpCPUup").focus();
					return false;
				} else if (upMemory < downMemory) {
					alert("Scale Out Memory 임계치가 Scale In Memory 임계치보다\n낮을 수 없습니다.");
					$("#scaleUpMemoryup").focus();
					return false;
				} else if (!templateSBval) {
					alert("템플릿을 선택 하십시오.");
					$("#templateSBup").focus();
					return false;
				} else {
	
					$.ajax({
	
						url: "/jquery/autoScaleUpdate.do",
						type: "POST",
						dataType: "json",
						contentType: "application/json;charset=UTF-8",
						data: JSON.stringify({
							id: id,
							service_id: serviceSBval,
							template_id: templateSBval,
							template_ids: templateSBtext,
							service_ids: serviceSBtext,
							minVM: minVM,
							maxVM: maxVM,
							naming: naming,
							postfix: postfix,
							startIP: startIP,
							endIP: endIP,
							isUse: isUse,
							cpuUp: upCPU,
							memoryUp: upMemory,
							cpuDown: downCPU,
							memoryDown: downMemory
						}),
						success: function(data) {
							if (data == 1) {
								alert("Auto Scale Out 변경 완료");
								window.parent.location.reload();
							} else if (data == 2) {
								alert("해당 서비스는 이미 Auto Scale Out이 등록돼 있습니다.");
							}
						},
						error: function() {
							alert("통신 에러 ");
						}
					})
				}
			}
	
			function autoScaleDelete(id, serviceName, isUse) {
	
				if (confirm("해당 Auto Scale Out을 삭제하시겠습니까?") == true) {
	
					if (isUse == 1) {
						alert("사용중인 Auto Scale Out 기능을 삭제할 수 없습니다.\n미사용으로 변경 후 삭제 바랍니다.");
						return false;
					} else {
	
						$.ajax({
							url: "/jquery/autoScaleDelete.do",
							type: "POST",
							dataType: "json",
							contentType: "application/json;charset=UTF-8",
							data: JSON.stringify({
								id: id,
								serviceName: serviceName
							}),
							success: function(data) {
								if (data == 1) {
									alert("Auto Scale Out 삭제가 완료되었습니다.");
								} else {
									alert("Auto Scale Out 삭제가 실패하였습니다.");
								}
									window.parent.location.reload();
							}
						})
	
					}
				} else {
					return false;
				}
			}
	
		</script>
	</head>
	<body>
		<div id="addAutoScaleOut" class="modal fade">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">Auto Scale Out 등록</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body bg-light modal-type-3">
						<div class="card mb-0">
							<div class="card-header bg-white">
								<a href="#required-input" data-toggle="collapse">
									<span class="h6 card-title"><i class="icon-checkbox-checked2 text-prom mr-2"></i>필수 입력 정보</span>
									<i class="icon-arrow-down12 text-prom"></i>
								</a>
							</div>
							<div id="required-input" class="collapse show">
								<div class="card-body bg-light padding-0 modal-type-3-body">
									<div class="row-padding-0">
										<div class="col-sm-6 col-xl-6 padding-0">
											<div class="card-body bg-light">
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>테넌트:<span class="text-prom ml-2">(필수)</span></label>
															<select class="form-control select-search" id="tenantSB" data-fouc>
																<option value="" selected disabled>:: 테넌트를 선택하십시오. ::</option>
															</select>
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>서비스:<span class="text-prom ml-2">(필수)</span></label>
															<select class="form-control select-search" id="tenantInServiceSB" data-fouc>
																<option value="" selected disabled>:: 테넌트 선택후 선택할 수 있습니다. ::</option>
															</select>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>최소 가상머신 개수:<span class="text-prom ml-2">(필수)</span></label>
															<input type="number" class="form-control form-control-modal" placeholder="minimum number of VM" min="1" onkeyup="autoScaleRegisterEnterkey()" id="minVM">
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>최대 가상머신 개수:<span class="text-prom ml-2">(필수)</span></label>
															<input type="number" class="form-control form-control-modal" placeholder="maximum number of VM" min="1" onkeyup="autoScaleRegisterEnterkey()" id="maxVM">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>네이밍:<span class="text-prom ml-2">(필수)</span></label>
															<input type="text" class="form-control form-control-modal" placeholder="naming" autocomplete="off" maxlength="50" onkeyup="autoScaleRegisterEnterkey()" id="naming">
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>Postfix:<span class="text-prom ml-2">(필수)</span></label>
															<input type="text" class="form-control form-control-modal" placeholder="postfix" autocomplete="off" maxlength="50" onkeyup="autoScaleRegisterEnterkey()" id="postfix">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>시작 IP 주소:<span class="text-prom ml-2">(필수)</span></label>
															<input type="text" class="form-control form-control-modal" placeholder="start IP address" autocomplete="off" onkeyup="autoScaleRegisterEnterkey()" id="startIPAddr">
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>끝 IP 주소:<span class="text-prom ml-2">(필수)</span></label>
															<input type="text" class="form-control form-control-modal" placeholder="end IP address" autocomplete="off" onkeyup="autoScaleRegisterEnterkey()" id="endIPAddr">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6 padding-0">
											<div class="card-body bg-light">
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>Scale Out CPU (%): <span class="text-prom ml-2">(필수)</span></label>
															<input type="number" class="form-control form-control-modal" placeholder="Scale Out CPU" min="1" max="100" onkeyup="autoScaleRegisterEnterkey()" id="scaleUpCPU">
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>Scale Out Memory (%):<span class="text-prom ml-2">(필수)</span></label>
															<input type="number" class="form-control form-control-modal" placeholder="Scale Out memory" min="1" max="100" onkeyup="autoScaleRegisterEnterkey()" id="scaleUpMemory">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>Scale In CPU (%):<span class="text-prom ml-2">(필수)</span></label>
															<input type="number" class="form-control form-control-modal" placeholder="Scale In CPU" min="1" max="100" onkeyup="autoScaleRegisterEnterkey()" id="scaleDownCPU">
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>Scale In Memory (%):<span class="text-prom ml-2">(필수)</span></label>
															<input type="number" class="form-control form-control-modal" placeholder="Scale In memory" min="1" max="100" onkeyup="autoScaleRegisterEnterkey()" id="scaleDownMemory">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-sm-12 col-xl-12">
														<div class="form-group">
															<label>템플릿:<span class="text-prom ml-2">(필수)</span></label>
															<select class="form-control select-search" id="templateSB" data-fouc>
																<option value="" selected disabled>:: 템플릿을 선택하십시오. ::</option>
															</select>
														</div>
													</div>
												</div>
												<div class="row mt-1">
													<div class="col-sm-12 col-xl-12">
														<div class="form-group form-check-inline">
															<div class="custom-control custom-radio mr-2-5">
																<input type="radio" class="custom-control-input" name="autoScale_onoff" id="autoScale_on" value="1">
																<label class="custom-control-label" for="autoScale_on">사용</label>
															</div>
															<div class="custom-control custom-radio">
																<input type="radio" class="custom-control-input" name="autoScale_onoff" id="autoScale_off" value="0" checked>
																<label class="custom-control-label" for="autoScale_off">미사용</label>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white">
						<button type="button" class="btn rounded-round bg-prom" onclick="vmthresHoldInsertConfirm()">등록<i class="icon-checkmark2 ml-2"></i></button>
					</div>
				</div>
			</div>
		</div>
		
		<div id="changeAutoScaleOut" class="modal fade">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header bg-prom" id="modal-header"></div>
					<div class="modal-body bg-light modal-type-3">
						<div class="card mb-0">
							<div class="card-header bg-white">
								<a href="#required-inputup" data-toggle="collapse">
									<span class="h6 card-title"><i class="icon-checkbox-checked2 text-prom mr-2"></i>필수 입력 정보</span>
									<i class="icon-arrow-down12 text-prom"></i>
								</a>
							</div>
							<div id="required-inputup" class="collapse show">
								<div class="card-body bg-light padding-0 modal-type-3-body">
									<div class="row-padding-0">
										<div class="col-sm-6 col-xl-6 padding-0">
											<div class="card-body bg-light">
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>테넌트:<span class="text-prom ml-2">(필수)</span></label>
															<select class="form-control select-search" id="tenantSBup" data-fouc>
																<option value="" selected disabled>:: 테넌트를 선택하십시오. ::</option>
															</select>
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>서비스:<span class="text-prom ml-2">(필수)</span></label>
															<select class="form-control select-search" id="tenantInServiceSBup" data-fouc>
																<option value="" selected disabled>:: 테넌트 선택후 선택할 수 있습니다. ::</option>
															</select>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>최소 가상머신 개수:<span class="text-prom ml-2">(필수)</span></label>
															<input type="number" class="form-control form-control-modal" placeholder="minimum number of VM" min="1" id="minVMup">
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>최대 가상머신 개수:<span class="text-prom ml-2">(필수)</span></label>
															<input type="number" class="form-control form-control-modal" placeholder="maximum number of VM" min="1" id="maxVMup">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>네이밍:<span class="text-prom ml-2">(필수)</span></label>
															<input type="text" class="form-control form-control-modal" placeholder="naming" autocomplete="off" maxlength="50" id="namingup">
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>Postfix:<span class="text-prom ml-2">(필수)</span></label>
															<input type="text" class="form-control form-control-modal" placeholder="postfix" autocomplete="off" maxlength="50" id="postfixup">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>시작 IP 주소:<span class="text-prom ml-2">(필수)</span></label>
															<input type="text" class="form-control form-control-modal" placeholder="start IP address" autocomplete="off" id="startIPAddrup">
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>끝 IP 주소:<span class="text-prom ml-2">(필수)</span></label>
															<input type="text" class="form-control form-control-modal" placeholder="end IP address" autocomplete="off" id="endIPAddrup">
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6 padding-0">
											<div class="card-body bg-light">
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>Scale Out CPU (%): <span class="text-prom ml-2">(필수)</span></label>
															<input type="number" class="form-control form-control-modal" placeholder="Scale Out CPU" min="1" max="100" id="scaleUpCPUup">
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>Scale Out Memory (%):<span class="text-prom ml-2">(필수)</span></label>
															<input type="number" class="form-control form-control-modal" placeholder="Scale Out memory" min="1" max="100" id="scaleUpMemoryup">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>Scale In CPU (%):<span class="text-prom ml-2">(필수)</span></label>
															<input type="number" class="form-control form-control-modal" placeholder="Scale In CPU" min="1" max="100" id="scaleDownCPUup">
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>Scale In Memory (%):<span class="text-prom ml-2">(필수)</span></label>
															<input type="number" class="form-control form-control-modal" placeholder="Scale In memory" min="1" max="100" id="scaleDownMemoryup">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-sm-12 col-xl-12">
														<div class="form-group">
															<label>템플릿:<span class="text-prom ml-2">(필수)</span></label>
															<select class="form-control select-search" id="templateSBup" data-fouc>
																<option value="" selected disabled>:: 템플릿을 선택하십시오. ::</option>
															</select>
														</div>
													</div>
												</div>
												<div class="row mt-1">
													<div class="col-sm-12 col-xl-12">
														<div class="form-group form-check-inline">
															<div class="custom-control custom-radio mr-2-5">
																<input type="radio" class="custom-control-input" name="autoScale_onoffup" id="autoScale_onup" value="1">
																<label class="custom-control-label" for="autoScale_onup">사용</label>
															</div>
															<div class="custom-control custom-radio">
																<input type="radio" class="custom-control-input" name="autoScale_onoffup" id="autoScale_offup" value="0">
																<label class="custom-control-label" for="autoScale_offup">미사용</label>
															</div>
														</div>
													</div>
												</div>
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
			<table id="autoScaleOutTable" class="promTable hover" style="width: 100%;">
				<thead>
					<tr>
						<th rowspan="2">서비스명</th>
						<th colspan="2" class="text-center">Out 임계치</th>
						<th colspan="2" class="text-center">In 임계치</th>
						<th colspan="2" class="text-center">가상머신 개수</th>
						<th rowspan="2">네이밍 룰</th>
						<th colspan="2" class="text-center">IP 주소</th>
						<th rowspan="2">템플릿명</th>
						<th rowspan="2">사용 여부</th>
						<th rowspan="2">관리</th>
					</tr>
					<tr>
						<th>CPU (%)</th>
						<th>Memory (%)</th>
						<th>CPU (%)</th>
						<th>Memory (%)</th>
						<th>최소</th>
						<th>최대</th>
						<th>시작</th>
						<th>끝</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>