<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/commonApply.js"></script>
		<script type="text/javascript">
			var category = "생성";
			var globalDHCPChk = 0;
			var globalDHCPCategory = 0;
			$(document).ready(function() {
				if (sessionApproval == BanNumber) {
					ftnlimited(1);
				}
				if (sessionApproval == USER_NAPP) {
					getUserNotapplyVMList();
				} else if (sessionApproval >= USER_HEAD_NAPP) {
					getUserUnApplyList();
				}
	
				$(document).on('change', '#defaultClusterSB', function() {
					getClusterinHostList();
				})
	
				modalOpen(1);
			});
	
			//사용자 전용 리스트
			function getUserNotapplyVMList() {
				var applyLevel = 1;
				var vmApplyTable = $("#vmApplyTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/approval/selectApplyVMListByUserMapping.do",
							"dataSrc": "",
							data: {
								applyLevel: applyLevel
							}
						},
						columns: [
							{"data": "crUserID"},
							{"data": "userName"},
							{"data": "tenantName"},
							{"data": "serviceName"},
							{"data": "crVMName"},
							{"data": "crCPU",
								render: function(data, type, row) {
									if (row.crIPAddress == null || row.crIPAddress == '') {
										data = 'vCPU: ' + data + ' / Memory: ' + row.crMemory + ' GB / IP 주소: <span class="text-muted">없음</span>';
									} else {
										data = 'vCPU: ' + data + ' / Memory: ' + row.crMemory + ' GB / IP 주소: ' + row.crIPAddress;
									}
									return data;
								}
							},
							{"data": "crVMContext"},
							{"data": "crDatetime"},
							{"data": "crApproval",
								render: function(data, type, row) {
									if (type == 'display') {
	
										if (data == 10) {
											data = '신청 취소';
										} else if (data == 1) {
											data = '신청';
										} else if (data == 2) {
											data = '결재 완료';
										} else if (data == 3) {
											data = '검토 완료';
										} else if (data == 4) {
											data = '승인 완료';
										} else if (data == 5) {
											data = '작업 완료';
										} else if (data == 6) {
											data = '보류';
										} else if (data == 7) {
											data = '반려';
										} else if (data == 8) {
											data = '완료';
										}
	
									} else {
										return data;
									}
	
									return data;
								}
							},
							{"data": "crNum",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
									var name = "\'" + row.crVMName + "\'";
	
									if (row.crUserID == sessionUserID && (row.crApproval != 5 && row.crApproval != 7 && row.crApproval != 8 && row.crApproval != 10) && row.crApproval != 0) {
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
										html += '<a href="#" class="dropdown-item" onclick="userApplyCancel(' + data + ')"><i class="icon-reply-all"></i>신청 취소</a>';
										html += '</div>';
									} else {
										html += '<i class="icon-lock2"></i>';
									}
									return html;
								}
							}
						],
						order: [
							[8, 'asc'],
							[7, 'asc']
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
						}, {
							responsivePriority: 3,
							targets: -2
						}, {
							responsivePriority: 4,
							targets: -3
						}, {
							responsivePriority: 5,
							targets: -4
						}],
						dom: "<'datatables-header'<'row-padding-0'lf><'row-padding-0'B>>" + "<'datatables-body'rt>" + "<'datatables-footer'ip>",
						buttons: [{
							extend: "collection",
							text: "<i class='icon-import'></i><span class='ml-2'>내보내기</span>",
							className: "btn bg-prom dropdown-toggle",
							buttons: [{
									extend: "csvHtml5",
									charset: "UTF-8",
									bom: true,
									text: "CSV",
									title: "가상머신 생성 신청",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7, 8]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "가상머신 생성 신청",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7, 8]
									}
								}
							]
						}]
					});
				$("#vmApplyTable tbody").on("click", "tr", function() {
					var data = vmApplyTable.row(this).data();
					if (data != undefined) {
						$(this).addClass("selectedTr");
						$("#vmApplyTable tr").not(this).removeClass("selectedTr");
						
						getApprovalProgress(data);
					}
				});
			}
	
			function getUserUnApplyList() {
	
				var applyLevel = 1;
	
				var vmApplyTable = $("#vmApplyTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/approval/selectApplyVMList.do",
							"dataSrc": "",
							data: {
								applyLevel: applyLevel,
							}
						},
						columns: [
							{"data": "crUserID"},
							{"data": "userName"},
							{"data": "tenantName"},
							{"data": "serviceName"},
							{"data": "crVMName"},
							{"data": "crCPU",
								render: function(data, type, row) {
									if (row.crIPAddress == null || row.crIPAddress == '') {
										data = 'vCPU: ' + data + ' / Memory: ' + row.crMemory + ' GB / IP 주소: <span class="text-muted">없음</span>';
									} else {
										data = 'vCPU: ' + data + ' / Memory: ' + row.crMemory + ' GB / IP 주소: ' + row.crIPAddress;
									}
									return data;
								}
							},
							{"data": "crVMContext"},
							{"data": "crDatetime"},
							{"data": "crApproval",
								render: function(data, type, row) {
									if (type == 'display') {
	
										if (data == 10) {
											data = '신청 취소';
										} else if (data == 1) {
											data = '신청';
										} else if (data == 2) {
											data = '결재 완료';
										} else if (data == 3) {
											data = '검토 완료';
										} else if (data == 4) {
											data = '승인 완료';
										} else if (data == 5) {
											data = '작업 완료';
										} else if (data == 6) {
											data = '보류';
										} else if (data == 7) {
											data = '반려';
										} else if (data == 8) {
											data = '완료';
										}
									} else {
										return data;
									}
									return data;
								}
							},
							{"data": "crNum",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
									var name = "\'" + row.crVMName + "\'";
									var userId = "\'" + row.crUserID + "\'";
	
									if ((getStage(sessionApproval) == row.crApproval || ((row.crApproval == 7) || row.crApproval == 8)) || (getStage(sessionApproval) < row.stage) || row.crApproval == 0) {
											html += '<i class="icon-lock2"></i>';
									} else {
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
		
										if (sessionApproval != BanNumber && sessionApproval > CONTROLCHECK) {
		
											html += '<a href="#" class="dropdown-item" onclick="modalControllApprovalAdmin(' + data + ', ' + name + ', ' + userId + ',' + row.crSorting + ')"><i class="icon-googleplus5"></i>작업자 승인</a>';
											html += '<a href="#" class="dropdown-item" onclick="modalControllDelete(' + data + ', ' + name + ')"><i class="icon-undo2"></i>반려</a>';
											if (row.crApproval != 6) {
												html += '<a href="#" class="dropdown-item" onclick="modalControllHold(' + data + ', ' + name + ')"><i class="icon-comments"></i>보류</a>';
											}
		
										} else if (sessionApproval != BanNumber && sessionApproval < CONTROLCHECK) {
		
											if (row.crUserID == sessionUserID) {
												html += '<a href="#" class="dropdown-item" onclick="userApplyCancel(' + data + ')"><i class="icon-reply-all"></i>신청 취소</a>';
											} else {
												html += '<a href="#" class="dropdown-item" onclick="modalControllApprove(' + data + ', ' + name + ', ' + userId + ')"><i class="icon-googleplus5"></i>승인</a>';
												html += '<a href="#" class="dropdown-item" onclick="modalControllDelete(' + data + ', ' + name + ')"><i class="icon-undo2"></i>반려</a>';
											}
										}
										html += '</div>';
									}
									return html;
								}
							}
						],
						order: [
							[8, 'asc'],
							[7, 'asc']
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
						}, {
							responsivePriority: 3,
							targets: -2
						}, {
							responsivePriority: 4,
							targets: -3
						}, {
							responsivePriority: 5,
							targets: -4
						}],
						dom: "<'datatables-header'<'row-padding-0'lf><'row-padding-0'B>>" + "<'datatables-body'rt>" + "<'datatables-footer'ip>",
						buttons: [{
							extend: "collection",
							text: "<i class='icon-import'></i><span class='ml-2'>내보내기</span>",
							className: "btn bg-prom dropdown-toggle",
							buttons: [{
								extend: "csvHtml5",
								charset: "UTF-8",
								bom: true,
								text: "CSV",
								title: "가상머신 생성 신청",
								exportOptions: {
									columns: [0, 1, 2, 3, 4, 5, 6, 7, 8]
								}
							}, {
								extend: "excelHtml5",
								text: "Excel",
								title: "가상머신 생성 신청",
								exportOptions: {
									columns: [0, 1, 2, 3, 4, 5, 6, 7, 8]
								}
							}]
						}]
					});
				$("#vmApplyTable tbody").on("click", "tr", function() {
					var data = vmApplyTable.row(this).data();
					if (data != undefined) {
						$(this).addClass("selectedTr");
						$("#vmApplyTable tr").not(this).removeClass("selectedTr");
						
						getApprovalProgress(data);
					}
				});
			}
	
			function applyLastView(cr_num, vmName, cr_sorting) {
				var createIP = $("#crIPaddr").val();
				var valueCreateIP = "\'" + createIP + "\'";
				var defaultClusterText = $("#defaultClusterSB option:selected").text();
				var defaultHost = $("#defaultHostSB option:selected").text();
				var defaultStorage = $("#defaultStorageSB option:selected").text();
				var defaultNetwork = $("#defaultNetworkSB option:selected").text();
	
				var header = '';
				var footer = '';
	
				if (!createIP && globalDHCPChk == 2) {
					alert("IP 주소는 필수 입력 사항입니다.");
					$("#crIPaddr").focus();
					return false;
				} else if (!ipRegexchk.test(createIP) && globalDHCPChk == 2) {
					alert("IPv4 형식이 잘못됐습니다.");
					$("#crIPaddr").focus();
					return false;
				} else {
					$("#vmApproveAdmin").modal("hide");
	
					$("#checkSetting").modal("show");
					$("#input-check").addClass("show");
					if (globalDHCPChk == 2) {
						$("#csnewIPaddr").html(createIP);
					} else if (globalDHCPChk == 1) {
						$("#csnewIPaddr").html("DHCP");
					}
	
					$("#cstemplateCluster").html(defaultClusterText);
					$("#cstemplateHost").html(defaultHost);
					$("#cstemplateDataStore").html(defaultStorage);
					$("#cstemplateNetwork").html(defaultNetwork);
	
					header += '<h5 class="modal-title mb-0">' + vmName + ' 생성 승인</h5>';
					header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	
					$("#checkSetting-modal-header").empty();
					$("#checkSetting-modal-header").append(header);
	
					footer += '<button type="button" class="btn btn-outline bg-prom text-prom border-prom border-2 rounded-round" id="vmApprovePrevious"><i class="icon-arrow-left12"></i>이전</button>';
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="applyVMDetail(' + cr_num + ', ' + cr_sorting + ', ' + valueCreateIP + ')">생성<i class="icon-checkmark2 ml-2"></i></button>';
	
					$("#checkSetting-modal-footer").empty();
					$("#checkSetting-modal-footer").append(footer);
				}
			}
	
			function applyVMDetail(cr_num, cr_sorting, cr_ipaddress) {
				var description = $("#approvalVMReasonAdmin").val();
				var defaultHost = $("#defaultHostSB option:selected").val();
				var defaultStorage = $("#defaultStorageSB option:selected").val();
				var defaultNetwork = $("#defaultNetworkSB option:selected").val();
	
				$.ajax({
					url: "/approval/approvalVMCreate.do",
					data: {
						crNum: cr_num,
						crSorting: cr_sorting,
						crIPAddress: cr_ipaddress,
						crHost: defaultHost,
						crStorage: defaultStorage,
						crNetWork: defaultNetwork,
						crDhcp: globalDHCPChk,
						description: description,
						dhcpCategory: globalDHCPCategory
					},
					timeout: 20000,
					beforeSend: function() {
						var footer = '';
	
						footer += '<button type="button" class="btn btn-outline bg-prom text-prom border-prom border-2 rounded-round" id="vmApprovePrevious"><i class="icon-arrow-left12"></i>이전</button>';
						footer += '<button class="btn bg-prom rounded-round" >가상머신 생성중...<i class="icon-spinner2 spinner ml-2"></i></button>';
	
						$("#checkSetting-modal-footer").empty();
						$("#checkSetting-modal-footer").append(footer);
					},
					success: function(data) {
	
						window.parent.location.reload();
					},
					error: function() {
						alert("가상머신 생성 도중 예기치 않은 예외 발생");
					}
				})
			}
	
	
			function chkChoiceSettingval(paraServiceId) {
	
				var serviceId = paraServiceId;
	
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
		</script>
	</head>
	<body>
		<!-- 작업자 승인 모달 -->
		<div id="vmApproveAdmin" class="modal fade">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header bg-prom" id="vmApproveAdmin-modal-header"></div>
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
														<label>Flavor:</label>
														<select class="form-control select-search" id="flavorList" data-fouc disabled></select>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>vCPU:</label>
														<input type="number" class="form-control form-control-modal" id="vCPU" disabled>
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>Memory:</label>
														<input type="number" class="form-control form-control-modal" id="memory" disabled>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>테넌트:</label> <select class="form-control select-search" id="tenantSelectBox" data-fouc disabled></select>
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>서비스:</label> <select class="form-control select-search" id="serviceSelectBox" data-fouc disabled></select>
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
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>가상머신명:</label>
														<input type="text" class="form-control form-control-modal" id="crVMname" disabled>
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group" id="crIPgroup">
														<label>IP 주소:<span class="text-prom ml-2">(필수)</span></label>
														<input type="text" class="form-control form-control-modal" placeholder="IP address" autocomplete="off" id="crIPaddr">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-12 col-xl-12">
													<div class="form-group">
														<label>사유:</label>
														<textarea class="form-control form-control-modal" id="crVMcontext" disabled></textarea>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-12 col-xl-12">
													<div class="form-group">
														<label>의견:</label>
														<textarea class="form-control form-control-modal" placeholder="comment for approval VM " autocomplete="off" maxlength="80" id="approvalVMReasonAdmin"></textarea>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white" id="vmApproveAdminl-modal-footer"></div>
				</div>
			</div>
		</div>
		
		<div id="checkSetting" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom" id="checkSetting-modal-header"></div>
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
											<span class="mr-2">템플릿명:</span><span id="cstemplateName"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">OS명:</span><span id="cstemplateOS"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">Disk:</span><span id="cstemplateDisk"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">설명:</span><span id="cstemplateDescription"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">Flavor명:</span><span id="cstemplateFlavor"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">테넌트명:</span><span id="cstemplateTenants"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">서비스명:</span><span id="cstemplateService"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">클러스터명:</span><span id="cstemplateCluster"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">호스트명:</span><span id="cstemplateHost"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">데이터스토어명:</span><span id="cstemplateDataStore"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">네트워크명:</span><span id="cstemplateNetwork"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">가상머신명:</span><span id="csnewVMname"></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">IP 주소:</span><span id=csnewIPaddr></span>
										</div>
										<div class="list-feed-item border-prom">
											<span class="mr-2">사유:</span><span id="csserviceContext"></span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white justify-content-between" id="checkSetting-modal-footer"></div>
				</div>
			</div>
		</div>
		
		<!-- 사유  -->
		<div id="vmReason" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content" style="margin-top: 100px;">
					<div class="modal-header bg-prom" id="vmReason-modal-header"></div>
					<div class="modal-body modal-type-5">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>가상머신명:</label>
									<input type="text" class="form-control form-control-modal" id="reasonVMName" disabled>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>사유:</label>
									<textarea class="form-control form-control-modal" id="commentVMReason" disabled></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 승인  -->
		<div id="vmApprove" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content" style="margin-top: 100px;">
					<div class="modal-header bg-prom" id="vmApprove-modal-header"></div>
					<div class="modal-body modal-type-5">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>가상머신명:</label>
									<input type="text" class="form-control form-control-modal" id="approveVMName" disabled>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>사유:</label>
									<textarea class="form-control form-control-modal" placeholder="reason for return VM" autocomplete="off" maxlength="80" id="aproveVMReason"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white" id="vmApprove-modal-footer"></div>
				</div>
			</div>
		</div>
		
		<!-- 반려  -->
		<div id="vmDelete" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content" style="margin-top: 100px;">
					<div class="modal-header bg-prom" id="vmDelete-modal-header"></div>
					<div class="modal-body modal-type-5">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>가상머신명:</label>
									<input type="text" class="form-control form-control-modal" id="deleteVMName" disabled>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>사유:</label>
									<textarea class="form-control form-control-modal" placeholder="reason for return VM" autocomplete="off" maxlength="80" id="deleteVMReason"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white" id="vmDelete-modal-footer"></div>
				</div>
			</div>
		</div>
		
		<!-- 보류  -->
		<div id="vmHold" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content" style="margin-top: 100px;">
					<div class="modal-header bg-prom" id="vmHold-modal-header"></div>
					<div class="modal-body modal-type-5">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>가상머신명:</label>
									<input type="text" class="form-control form-control-modal" id="holdVMName" disabled>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>사유:</label>
									<textarea class="form-control form-control-modal" placeholder="reason for hold VM" autocomplete="off" maxlength="80" id="holdVMReason"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white" id="vmHold-modal-footer"></div>
				</div>
			</div>
		</div>
		
		<div class="card bg-dark mb-0 table-type-2 table-type-7">
			<div>
				<h6 class="card-title mb-0">결재 진행 상태</h6>
			</div>
			<div class="datatables-body">
				<table class="promTable text-center" style="width:100%;">
					<thead>
						<tr>
							<th width="9%">-</th>
							<th width="15%">신청</th>
							<th width="4%"></th>
							<th width="15%">결재</th>
							<th width="4%"></th>
							<th width="15%">검토</th>
							<th width="4%"></th>
							<th width="15%">검토 승인</th>
							<th width="4%"></th>
							<th width="15%">작업</th>
						</tr>
					</thead>
					<tbody id="approvalProcessList">
						<tr>
							<th>상태</th>
							<td></td>
							<td class="bg-process" rowspan="4"><i class="icon-arrow-right16 icon-2x text-muted mb-3"></i></td>
							<td></td>
							<td class="bg-process" rowspan="4"><i class="icon-arrow-right16 icon-2x text-muted mb-3"></i></td>
							<td></td>
							<td class="bg-process" rowspan="4"><i class="icon-arrow-right16 icon-2x text-muted mb-3"></i></td>
							<td></td>
							<td class="bg-process" rowspan="4"><i class="icon-arrow-right16 icon-2x text-muted mb-3"></i></td>
							<td></td>
						</tr>
						<tr>
							<th>이름</th>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>일시</th>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>사유</th>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="card bg-dark mb-0 table-type-5-8">
			<table id="vmApplyTable" class="promTable hover cpointer" style="width:100%;">
				<thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>테넌트명</th>
						<th>서비스명</th>
						<th>가상머신명</th>
						<th>상세 정보</th>
						<th>사유</th>
						<th>요청 일시</th>
						<th>상태</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>