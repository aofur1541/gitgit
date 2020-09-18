<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<script src="${path}/resources/PROM_JS/commonApply.js"></script>
		<script type="text/javascript">
			var globalDHCPChk = 0;
			var globalDHCPCategory = 0;
			
			// 사용자가 매핑된 테넌트 사용 여부 
			var isUserTenantMapping = 'false';
			
			$(document).ready(function() {
				getTemplateList();
				$(document).on('change', '#sortingSB', function() {
					var inputed = $("#autoFilterInput").val();
					if (inputed == '' || inputed == null) {
						getTemplateList();
					} else {
						templatesFilter();
					}
				})
				
				$(document).on('change', '#tenantSelectBox', function() {
					serviceInTenant();
				})
				
				$(document).on('change', '#defaultClusterSB', function() {
					getClusterinHostList();
				})
				
				if (sessionApproval > CONTROLCHECK) {
					$(document).on('change', '#serviceSelectBox', function() {
						chkDHCP("serviceSelectBox");
						chkChoiceSetting();
					})
				}
				
				$("#vmCreate3").on('hide', function() {
					location.reload();
				});
				
				if (sessionApproval < CONTROLCHECK) {
					isUserTenantMapping = 'true';
					$("#IPaddrDiv").hide();
					$("#vmNameDiv").addClass("col-sm-12 col-xl-12");
				} else {
					isUserTenantMapping = 'false';
					$("#IPaddrDiv").show();
					$("#vmNameDiv").removeClass("col-sm-12 col-xl-12");
				}
				
				$("#clusterDiv").hide();
				
				modalOpen();
			})
	
			function keyCheck() {
				if (window.event.keyCode == 27) {
					location.reload();
				}
			}
			
			function modalOpen() {
				$("#vmCreate1").on("shown.bs.modal", function() {
					$("#flavorList").focus();
				})
				$("#vmCreate2").on("shown.bs.modal", function() {
					$(document).on('click', '#chooseServicePrevious', function() {
						$("#vmCreate1").modal("show");
						$("#vmCreate2").modal("hide");
						
						$("#template-info.collapse").addClass("show");
						$("#warning-info.collapse").addClass("show");
						$("#input-info.collapse").addClass("show");
					})
				})
			}
	
			function getTemplateList() {
				var sorting = $("#sortingSB > option:selected").val();
				console.log(sorting);
				$.ajax({
					data: {
						sort: sorting
					},
					url: "/apply/selectVMTemplateOnList.do",
					success: function(data) {
						var html = '';
						html += '<div class="row">';
						if (data == null || data == '') {
							html += '<div class="col-sm-12 col-xl-12 text-center">데이터가 없습니다.</div>';
						} else {
							for (key in data) {
								var valueDescription = "\'" + data[key].description + "\'";
								var valueDisk = "\'" + data[key].vmDisk + "\'";
								var valueOS = "\'" + data[key].vmOS + "\'";
								var valueName = "\'" + data[key].vmName + "\'";
								
								html += '<div class="col-xl-3 col-sm-6">';
								html += '<div class="card bg-dark mb-0 border-bottom-prom rounded-bottom-0">';
								html += '<div class="card-header bg-prom" style="padding: 0.9375rem;">';
								html += '<h6 class="card-title mb-0">' + data[key].vmName + '</h6>';
								html += '</div>';
								html += '<div class="card-body">';
								html += '<p><span class="text-prom">OS: </span><span>' + data[key].vmOS + '</span></p>';
								html += '<p><span class="text-prom">Disk: </span><span>' + data[key].vmDisk + ' GB</span></p>';
								if (data[key].description == null || data[key].description == '') {
									html += '<p class="mb-0"><span class="text-prom">설명: </span><span class="text-muted">설명이 없습니다.</span></p>';
								} else {
									html += '<p class="mb-0"><span class="text-prom">설명: </span><span>' + data[key].description + '</span></p>';
								}
								html += '</div>';
								if (sessionApproval != BanNumber) {
									html += '<div class="card-footer d-flex justify-content-end">';
									html += '<button type="button" class="btn btn-sm btn-outline-prom border-transparent rounded-round" onclick="vmCreateStep2(' + key + ',' + valueName + ',' + valueOS + ',' + valueDisk + ',' + valueDescription + ')">선택<i class="icon-checkmark2 ml-2"></i></button>';
									html += '</div>';
								}
								html += '</div>';
								html += '</div>';
								getFlavorList(key);
							}
						}
						html += '</div>';
						
						$("#appendContent").empty();
						$("#appendContent").append(html);
						
						$(".card-footer>button").click(function(){
							$("#template-info.collapse").addClass("show");
							$("#warning-info.collapse").addClass("show");
							$("#input-info.collapse").addClass("show");
						})
					}
				})
			}
	
			function templatesFilter() {
				var sorting = $("#sortingSB > option:selected").val();
				var inputed = $("#autoFilterInput").val();
				$.ajax({
					data: {
						sort: sorting,
						searchParam: inputed
					},
					url: "/apply/selectVMTemplateOnList.do",
					success: function(data) {
						var html = '';
						html += '<div class="row">';
						if (data == null || data == '') {
							html += '<div class="col-sm-12 col-xl-12 text-center">데이터가 없습니다.</div>';
						} else {
							for (key in data) {
								var valueDescription = "\'" + data[key].description + "\'";
								var valueDisk = "\'" + data[key].vmDisk + "\'";
								var valueOS = "\'" + data[key].vmOS + "\'";
								var valueName = "\'" + data[key].vmName + "\'";
								
								html += '<div class="col-xl-3 col-sm-6">';
								html += '<div class="card bg-dark mb-0 border-bottom-prom rounded-bottom-0">';
								html += '<div class="card-header bg-prom" style="padding: 0.9375rem;">';
								html += '<h6 class="card-title mb-0">' + data[key].vmName + '</h6>';
								html += '</div>';
								html += '<div class="card-body">';
								html += '<p><span class="text-prom">OS: </span><span>' + data[key].vmOS + '</span></p>';
								html += '<p><span class="text-prom">Disk: </span><span>' + data[key].vmDisk + ' GB</span></p>';
								if (data[key].description == null || data[key].description == '') {
									html += '<p class="mb-0"><span class="text-prom">설명: </span><span class="text-muted">설명이 없습니다.</span></p>';
								} else {
									html += '<p class="mb-0"><span class="text-prom">설명: </span><span>' + data[key].description + '</span></p>';
								}
								html += '</div>';
								if (sessionApproval != BanNumber) {
									html += '<div class="card-footer d-flex justify-content-end">';
									html += '<button type="button" class="btn btn-sm btn-outline-prom border-transparent rounded-round" onclick="vmCreateStep2(' + key + ',' + valueName + ',' + valueOS + ',' + valueDisk + ',' + valueDescription + ')">선택<i class="icon-checkmark2 ml-2"></i></button>';
									html += '</div>';
								}
								html += '</div>';
								html += '</div>';
								getFlavorList(key);
							}
						}
						html += '</div>';
						
						$("#appendContent").empty();
						$("#appendContent").append(html);
					}
				})
			}
			
			function chkChoiceSetting() {
				var serviceId = $("#serviceSelectBox option:selected").val();
				if (!serviceId) {
					$("#clusterDiv").hide();
					return false;
				}
				$.ajax({
					url: "/tenant/selectDHCPState.do",
					data: {
						serviceId: serviceId
					},
					success: function(data) {
						globalDHCPCategory = data['resultNum'];
						$("#clusterDiv").show();
						getClusterList(data['getOneInfo'].defaultCluster, data['getOneInfo'].defaultHost, data['getOneInfo'].defaultStorage, data['getOneInfo'].defaultNetwork);
					}
				})
			}
	
			function getFlavorList(id) {
				$.ajax({
					url: "/config/selectFlavorList.do",
					success: function(data) {
						var html = '';
						var flavorSpec = '';
						html += '<option value="" selected disabled>:: Flavor를 선택하십시오. ::</option>';
						for (key in data) {
							html += '<option value=' + data[key].vCPU + ' value2=' + data[key].memory + ' value3=' + data[key].name + '>' + data[key].name + '</option>';
						}
						$("#flavorList").empty();
						$("#flavorList").append(html);
					}
				})
			}
	
			function getUserTenantList() {
				$.ajax({
					url: "/tenant/selectLoginUserTenantList.do",
					success: function(data) {
						var html = '';
						html += '<option value="" selected disabled>:: 테넌트를 선택하십시오. ::</option>';
						for (key in data) {
							html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
						}
						$("#tenantSelectBox").empty();
						$("#tenantSelectBox").append(html);
						//serviceInTenant();
					}
				})
			}
	
			function getTenantList() {
				$.ajax({
					url: "/tenant/selectTenantList.do",
					success: function(data) {
						var html = '';
						html += '<option value="" selected disabled>:: 테넌트를 선택하십시오. ::</option>';
						for (key in data) {
							html += '<option value=' + data[key].id + ' value2=' + data[key].dhcpOnoff + '>' + data[key].name + '</option>';
						}
						$("#tenantSelectBox").empty();
						$("#tenantSelectBox").append(html);
						
						
					}
				})
			}
	
			function serviceInTenant() {
				var tenantsID = $("#tenantSelectBox option:selected").val();
				
				$.ajax({
					data: {
						tenantId: tenantsID,
						isUserTenantMapping : isUserTenantMapping
					},
					url: "/tenant/selectVMServiceListByTenantId.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value="">:: 테넌트에 포함된 서비스가 없습니다. ::</option>';
						} else {
							for (key in data) {
								html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].dhcpOnoff + '>' + data[key].vmServiceName + '</option>';
							}
						}
						$("#serviceSelectBox").empty();
						$("#serviceSelectBox").append(html);
						if (sessionApproval > CONTROLCHECK) {
							chkDHCP("serviceSelectBox");
							chkChoiceSetting()
						}
					}
				})
			}
	
			function customCheck(id) {
				var html = '';
				var flavorValueCPU = $("#flavorList > option:selected").val();
				var flavorValueMemory = $("#flavorList > option:selected").attr("value2");
				var flavorValue = $("#flavorList > option:selected").attr("value3");
				
				if (flavorValue == 'Custom') {
					$("#vCPU").attr('disabled', false);
					$("#memory").attr('disabled', false);
					$("#vCPU").val(flavorValueCPU);
					$("#memory").val(flavorValueMemory);
				} else {
					$("#vCPU").attr('disabled', true);
					$("#memory").attr('disabled', true);
					$("#vCPU").val(flavorValueCPU);
					$("#memory").val(flavorValueMemory);
				}
			}
	
			function vmCreateStep2(id, valueName, valueOS, valueDisk, valueDescription) {
				var valueDescription2 = "\'" + valueDescription + "\'";
				var valueDisk2 = "\'" + valueDisk + "\'";
				var valueOS2 = "\'" + valueOS + "\'";
				var valueName2 = "\'" + valueName + "\'";
				
				$("#vmCreate1").modal("show");
				
				// 템플릿 정보
				$("#templateName").html(valueName);
				$("#templateOS").html(valueOS);
				$("#templateDisk").html(valueDisk + " GB");
				if (valueDescription == 'null' || valueDescription == '') {
					$("#templateDescription").html("<span class='text-muted'>설명이 없습니다.</span>");
				} else {
					$("#templateDescription").html(valueDescription);
				}
				
				// 입력 정보
				$("#CR_VM_name").val('');
				$("#CR_IP_address").val('');
				$("#CR_VMcontext").val('');
				$("#tenantSelectBox").val('');
				$("#serviceSelectBox").val('');
				
				if (sessionApproval > ADMINCHECK) {
					getTenantList();
				} else if (sessionApproval < ADMINCHECK) {
					getUserTenantList();
				}
				
				var footer = '';
				footer += '<button type="button" class="btn bg-prom rounded-round" onclick="vmCreateStep3(' + id + ',' + valueName2 + ',' + valueOS2 + ',' + valueDisk2 + ',' + valueDescription2 + ')">다음<i class="icon-arrow-right13 ml-2"></i></button>';
				$("#vmCreate1-footer").empty();
				$("#vmCreate1-footer").append(footer);
			}
	
			function vmCreateStep3(id, valueName, valueOS, valueDisk, valueDescription) {
				var html = '';
				var tenantSBval = $("#tenantSelectBox option:selected").val();
				var serviceSBval = $("#serviceSelectBox option:selected").val();
				var flavorValueCPU = $("#flavorList > option:selected").val();
				var flavorValueMemory = $("#flavorList > option:selected").attr("value2");
				var flavorValueCheck = $("#flavorList > option:selected").val();
				var createVMname = $("#CR_VM_name").val();
				var createIP = $("#CR_IP_address").val();
				var createContext = $("#CR_VMcontext").val();
				var flavorCPUinput = $("#vCPU").val();
				var flavorMemoryinput = $("#memory").val();
				var filter = /^([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\.([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])){3}$/;
				if (!flavorValueCheck) {
					alert("flavor를 선택하십시오.");
					$("#flavorList").focus();
					return false;
				} else if (!flavorCPUinput || !flavorMemoryinput) {
					alert("Custom flavor의 자원 설정은 필수입니다.");
					return false;
				} else if (flavorCPUinput > 64 || flavorMemoryinput > 64) {
					alert("Custom flavor의 자원 할당량이 너무 높습니다.");
					return false;
				} else if (!tenantSBval) {
					alert("테넌트를 선택하십시오.");
					$("#tenantSelectBox").focus();
					return false;
				} else if (!serviceSBval) {
					alert("서비스를 선택하십시오.");
					$("#serviceSelectBox").focus();
					return false;
				} else if (!createVMname) {
					alert("가상머신명은 필수기입 항목입니다.");
					$("#CR_VM_name").focus();
					return false;
				} else if (!createContext) {
					alert("가상머신 신청 사유는 필수기입 항목입니다.");
					$("#CR_VMcontext").focus();
					return false;
				} else {
					if (sessionApproval > CONTROLCHECK && globalDHCPChk == 2) {
						if (!createIP) {
							alert("IP 주소는 필수기입 항목입니다.");
							$("#CR_IP_address").focus();
							return false;
						} else if (!filter.test($('#CR_IP_address').val())) {
							$("#CR_IP_address").focus();
							alert("IPv4 형식이 잘못됐습니다.");
							$("#CR_IP_address").focus();
							return false;
						} else {
							$("#vmCreate1").modal("hide");
							$("#vmCreate2").modal("show");
							vmCreateStep4(id, valueName, valueOS, valueDisk, valueDescription);
						}
					} else {
						$("#vmCreate1").modal("hide");
						$("#vmCreate2").modal("show");
						vmCreateStep4(id, valueName, valueOS, valueDisk, valueDescription);
					}
				}
			}
	
			function vmCreateStep4(id, valueName, valueOS, valueDisk, valueDescription) {
				var flavorValueCPU = $("#flavorList > option:selected").val();
				var flavorValueMemory = $("#flavorList > option:selected").attr("value2");
				var flavorValue = $("#flavorList > option:selected").attr("value3");
				var tenantSBtext = $("#tenantSelectBox option:selected").text();
				var tenantSBval = $("#tenantSelectBox option:selected").val();
				var serviceSBtext = $("#serviceSelectBox option:selected").text();
				var serviceSBval = $("#serviceSelectBox option:selected").val();
				var defaultCluster = $("#defaultClusterSB option:selected").text();
				var defaultHost = $("#defaultHostSB option:selected").text();
				var defaultStorage = $("#defaultStorageSB option:selected").text();
				var defaultNetwork = $("#defaultNetworkSB option:selected").text();
				var createVMname = $("#CR_VM_name").val();
				var createIP = $("#CR_IP_address").val();
				var createContext = $("#CR_VMcontext").val();
				var valueDescription2 = "\'" + valueDescription + "\'";
				var valueDisk2 = "\'" + valueDisk + "\'";
				var valueOS2 = "\'" + valueOS + "\'";
				var valueName2 = "\'" + valueName + "\'";
				
				if (flavorValue == 'Custom') {
					flavorValueCPU = $("#vCPU").val();
					flavorValueMemory = $("#memory").val();
				}
				
				// 신청 정보 확인
				$("#step4TemplateName").html(valueName);
				$("#cstemplateOS").html(valueOS);
				$("#step4TemplateDisk").html(valueDisk + " GB");
				$("#step4TemplateFlavor").html(flavorValue + " (vCPU: " + flavorValueCPU + " / Memory: " + flavorValueMemory + " GB)");
				if (valueDescription == 'null' || valueDescription == '') {
					$("#step4TemplateDescription").html("<span class='text-muted'>설명이 없습니다.</span>");
				} else {
					$("#step4TemplateDescription").html(valueDescription);
				}
				$("#step4TemplateTenants").html(tenantSBtext);
				$("#step4TemplateService").html(serviceSBtext);
				$("#step4NewVMname").html(createVMname);
				if (sessionApproval > CONTROLCHECK) {
					if (globalDHCPChk == 1) {
						createIP = 'DHCP'
					}
					$("#step4TemplateCluster").html(defaultCluster);
					$("#step4TemplateHost").html(defaultHost);
					$("#step4TemplateDataStore").html(defaultStorage);
					$("#step4TemplateNetwork").html(defaultNetwork);
				}
				$("#step4NewIPaddr").html(createIP);
				$("#step4ServiceContext").html(createContext);
				
				var footer = '';
				footer += '<button type="button" class="btn btn-outline bg-prom text-prom border-prom border-2 rounded-round" id="chooseServicePrevious"><i class="icon-arrow-left12"></i>이전</button>';
				if (sessionApproval > CONTROLCHECK) {
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="vmCreateStep5(' + id + ',' + valueName2 + ',' + valueOS2 + ',' + valueDisk2 + ',' + valueDescription2 + ')">생성<i class="icon-checkmark2 ml-2"></i></button>';
				} else {
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="vmCreateStep5(' + id + ',' + valueName2 + ',' + valueOS2 + ',' + valueDisk2 + ',' + valueDescription2 + ')">신청<i class="icon-checkmark2 ml-2"></i></button>';
				}
				$("#vmCreate2-footer").empty();
				$("#vmCreate2-footer").append(footer);
			}
	
			function vmCreateStep5(id, valueName, valueOS, valueDisk, valueDescription) {
				var flavorValueCPU = $("#flavorList > option:selected").val();
				var flavorValueMemory = $("#flavorList > option:selected").attr("value2");
				var flavorValue = $("#flavorList > option:selected").attr("value3");
				var tenantSBval = $("#tenantSelectBox option:selected").val();
				var tenantSBtext = $("#tenantSelectBox option:selected").text();
				var serviceSBval = $("#serviceSelectBox option:selected").val();
				var serviceSBtext = $("#serviceSelectBox option:selected").text();
				var defaultCluster = $("#defaultClusterSB option:selected").val();
				var defaultHost = $("#defaultHostSB option:selected").val();
				var defaultStorage = $("#defaultStorageSB option:selected").val();
				var defaultNetwork = $("#defaultNetworkSB option:selected").val();
				var createVMname = $("#CR_VM_name").val();
				var createIP = $("#CR_IP_address").val();
				var createContext = $("#CR_VMcontext").val();
				
				if (flavorValue == 'Custom') {
					flavorValueCPU = $("#vCPU").val();
					flavorValueMemory = $("#memory").val();
				}
				
				$.ajax({
					data: {
						crVMName: createVMname,
						crCPU: flavorValueCPU,
						crMemory: flavorValueMemory,
						crVMContext: createContext,
						crIPAddress: createIP,
						crTemplet: valueName,
						crHost: defaultHost,
						crStorage: defaultStorage,
						crNetWork: defaultNetwork,
						crDhcp: globalDHCPChk,
						vmServiceID: serviceSBval,
						tenantId: tenantSBval,
						serviceName: serviceSBtext,
						tenantName: tenantSBtext,
						crDisk: valueDisk,
						dhcpCategory: globalDHCPCategory
					},
					type: 'POST',
					url: "/apply/insertVMCreate.do",
					beforeSend: function() {
						var footer = '';
						footer += '<button type="button" class="btn btn-outline bg-prom text-prom border-prom border-2 rounded-round" id="chooseServicePrevious"><i class="icon-arrow-left12"></i>이전</button>';
						if (sessionApproval > CONTROLCHECK) {
							footer += '<button type="button" class="btn bg-prom rounded-round">가상머신 생성중...<i class="icon-spinner2 spinner ml-2"></i></button>';
						} else {
							footer += '<button type="button" class="btn bg-prom rounded-round">가상머신 신청중...<i class="icon-spinner2 spinner ml-2"></i></button>';
						}
						$("#vmCreate2-footer").empty();
						$("#vmCreate2-footer").append(footer);
					},
					success: function(data) {
						$("#vmCreate2").modal("hide");
						$("#vmCreate3").modal("show");
					},
					error: function() {
						alert("에러 : 서버 통신 상태를 확인해 주십시오.");
					}
				})
			}
		</script>
	</head>
	<body>
		<div id="vmCreate1" class="modal fade">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">가상머신 생성 설정</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body bg-light modal-type-6">
						<div class="row-padding-0">
							<div class="col-sm-6 col-xl-6 padding-0">
								<div class="card mb-0">
									<div class="card-header bg-white">
										<a href="#template-info" data-toggle="collapse">
											<span class="h6 card-title"><i class="icon-grid5 text-prom mr-2"></i>템플릿 정보</span>
											<i class="icon-arrow-down12 text-prom"></i>
										</a>
									</div>
									<div id="template-info" class="collapse show">
										<div class="card-body bg-light">
											<div class="list-feed mb-2-5">
												<div class="list-feed-item border-prom">
													<span class="mr-2">템플릿명:</span><span id="templateName"></span>
												</div>
												<div class="list-feed-item border-prom">
													<span class="mr-2">OS명:</span><span id="templateOS"></span>
												</div>
												<div class="list-feed-item border-prom">
													<span class="mr-2">Disk:</span><span id="templateDisk"></span>
												</div>
												<div class="list-feed-item border-prom">
													<span class="mr-2">설명:</span><span id="templateDescription"></span>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="card mb-0">
									<div class="card-header bg-white">
										<a href="#warning-info" data-toggle="collapse">
											<span class="h6 card-title"><i class="icon-warning22 text-prom mr-2"></i>주의 사항</span>
											<i class="icon-arrow-down12 text-prom"></i>
										</a>
									</div>
									<div id="warning-info" class="collapse show">
										<div class="card-body bg-light">
											<p>
												1. 가상머신 생성 시 가상머신명에 "_" 언더바(under-bar)를 포함할 경우 정상 작동하지 않습니다.
											</p>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-6 col-xl-6 padding-0">
								<div class="card mb-0">
									<div class="card-header bg-white">
										<a href="#input-info" data-toggle="collapse">
											<span class="h6 card-title"><i class="icon-list3 text-prom mr-2"></i>입력 정보</span>
											<i class="icon-arrow-down12 text-prom"></i>
										</a>
									</div>
									<div id="input-info" class="collapse show">
										<div class="card-body bg-light">
											<div class="row">
												<div class="col-sm-12 col-xl-12">
													<div class="form-group">
														<label>Flavor:<span class="text-prom ml-2">(필수)</span></label>
														<select class="form-control select-search" id="flavorList" onchange="customCheck()" data-fouc></select>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>vCPU:<span class="text-prom ml-2">(필수)</span></label>
														<input type="number" class="form-control form-control-modal" id="vCPU" disabled>
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>Memory:<span class="text-prom ml-2">(필수)</span></label>
														<input type="number" class="form-control form-control-modal" id="memory" disabled>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>테넌트:<span class="text-prom ml-2">(필수)</span></label>
														<select class="form-control select-search" id="tenantSelectBox" data-fouc></select>
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>서비스:<span class="text-prom ml-2">(필수)</span></label>
														<select class="form-control select-search" id="serviceSelectBox" data-fouc>
															<option value="" selected disabled>:: 테넌트 선택 후 선택할 수 있습니다. ::</option>
														</select>
													</div>
												</div>
											</div>
											<div id="clusterDiv">
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>클러스터:<span class="text-prom ml-2">(필수)</span></label>
															<select class="form-control select-search" id="defaultClusterSB" data-fouc></select>
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>호스트:<span class="text-prom ml-2">(필수)</span></label>
															<select class="form-control select-search" id="defaultHostSB" data-fouc></select>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>데이터스토어:<span class="text-prom ml-2">(필수)</span></label>
															<select class="form-control select-search" id="defaultStorageSB" data-fouc></select>
														</div>
													</div>
													<div class="col-sm-6 col-xl-6">
														<div class="form-group">
															<label>네트워크:<span class="text-prom ml-2">(필수)</span></label>
															<select class="form-control select-search" id="defaultNetworkSB" data-fouc></select>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6" id="vmNameDiv">
													<div class="form-group">
														<label>가상머신명:<span class="text-prom ml-2">(필수)</span></label>
														<input class="form-control form-control-modal" placeholder="VM name" autocomplete="off" maxlength="40" id="CR_VM_name">
													</div>
												</div>
												<div class="col-sm-6 col-xl-6" id="IPaddrDiv">
													<div class="form-group">
														<label>IP 주소:<span class="text-prom ml-2">(필수)</span></label>
														<input class="form-control form-control-modal" placeholder="IP address" autocomplete="off" maxlength="20" id="CR_IP_address">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-12 col-xl-12">
													<div class="form-group">
														<label>사유:<span class="text-prom ml-2">(필수)</span></label>
														<textarea class="form-control form-control-modal" placeholder="reason for applying VM" autocomplete="off" maxlength="200" id="CR_VMcontext"></textarea>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white" id="vmCreate1-footer"></div>
				</div>
			</div>
		</div>
		
		<div id="vmCreate2" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">가상머신 생성 설정</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body bg-light modal-type-4">
						<div class="card mb-0">
							<div class="card-header bg-white">
								<a href="#check-input" data-toggle="collapse">
									<span class="h6 card-title"><i class="icon-exclamation text-prom mr-2"></i>입력 정보 확인</span>
									<i class="icon-arrow-down12 text-prom"></i>
								</a>
							</div>
							<div id="check-input" class="collapse show">
								<div class="card-body bg-light">
									<div class="list-feed mb-2-5">
										<div class="list-feed-item border-prom">
											<span class="mr-2">템플릿명:</span><span id="step4TemplateName"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">OS명:</span><span id="cstemplateOS"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">Disk:</span><span id="step4TemplateDisk"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">설명:</span><span id="step4TemplateDescription"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">Flavor명:</span><span id="step4TemplateFlavor"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">테넌트명:</span><span id="step4TemplateTenants"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">서비스명:</span><span id="step4TemplateService"></span>
										</div>
										<c:if test="${sessionAppEL > CONTROLCHECK}">
											<div class="list-feed-item border-prom">
												<span class="mr-2">클러스터명:</span><span id="step4TemplateCluster"></span>
											</div>
											<div class="list-feed-item border-prom">
												<span class="mr-2">호스트명:</span><span id="step4TemplateHost"></span>
											</div>
											<div class="list-feed-item border-prom">
												<span class="mr-2">데이터스토어명:</span><span id="step4TemplateDataStore"></span>
											</div>
											<div class="list-feed-item border-prom">
												<span class="mr-2">네트워크명:</span><span id="step4TemplateNetwork"></span>
											</div>
										</c:if>
										<div class="list-feed-item border-prom">
											<span class="mr-2">가상머신명:</span><span id="step4NewVMname"></span>
										</div>
										<c:if test="${sessionAppEL > CONTROLCHECK}">
											<div class="list-feed-item border-prom">
												<span class="mr-2">IP 주소:</span><span id=step4NewIPaddr></span>
											</div>
										</c:if>
										<div class="list-feed-item border-prom">
											<span class="mr-2">사유:</span><span id="step4ServiceContext"></span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white justify-content-between" id="vmCreate2-footer"></div>
				</div>
			</div>
		</div>
		
		<div id="vmCreate3" class="modal fade" tabindex="-1" onkeyup="keyCheck()">
			<div class="modal-dialog modal-sm">
				<div class="modal-content" style="margin-top: 100px;">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">
							<c:if test="${sessionAppEL > CONTROLCHECK}">
								가상머신 생성
							</c:if>
							<c:if test="${sessionAppEL < CONTROLCHECK}">
								가상머신 신청
							</c:if>
						</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body modal-type-5 text-center">
						<div class="mb-2-5">
							<c:if test="${sessionAppEL > CONTROLCHECK}">
								가상머신이 배포중입니다.
							</c:if>
							<c:if test="${sessionAppEL < CONTROLCHECK}">
								가상머신 신청이 완료되었습니다.
							</c:if>	
						</div>
					</div>
					<div class="modal-footer bg-white">
						<c:if test="${sessionAppEL > CONTROLCHECK}">
							<button type="button" class="btn bg-prom rounded-round" onclick="javascript:window.parent.location.href='/menu/vmHistory.do#1'">진행 상태 확인</button>
						</c:if>
						<c:if test="${sessionAppEL < CONTROLCHECK}">
							<button type="button" class="btn bg-prom rounded-round" onclick="javascript:window.parent.location.href='/menu/approvalManage.do#1'">신청 현황 확인</button>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		
		<div class="card mb-0 bg-dark table-type-1">
			<div class="table-title-light">
				<div class="col-sm-3 col-xl-2 padding-0">
					<div class="form-group form-group-feedback form-group-feedback-right mb-0">
						<input type="text" class="form-control" placeholder="search" autocomplete="off" onkeyup="templatesFilter()" id="autoFilterInput">
						<div class="form-control-feedback">
							<i class="icon-search4 font-size-small text-prom"></i>
						</div>
					</div>
				</div>
				<div class="col-sm-3 col-xl-2 padding-0">
					<select class="form-control select" id="sortingSB" data-fouc>
						<option value="ASC" selected="selected">오름차순</option>
						<option value="DESC">내림차순</option>
					</select>
				</div>
			</div>
			<div class="vmCreate-body" id="appendContent"></div>
		</div>
	</body>
</html>