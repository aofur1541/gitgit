<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			$(document).ready(function() {
				
				if (sessionApproval <= CONTROLCHECK) {
					ftnlimited(3);
				}
				
				getAutoScaleUPList();
				getTenantList();
				
				$(document).on('change', '#tenantSB', function() {
					serviceInTenant();
				})
				
				$(document).on('change', '#tenantSBup', function() {
					serviceInTenantUp();
				})
				
				commonModalOpen("addAutoScaleUP", "tenantSB");
			})
			
			function autoScaleRegisterEnterkey() {
				if (window.event.keyCode == 13) {
					synthesisInputValidation('',0);
				}
			}
			
			function synthesisInputValidation(category,id){
				var add = '';
				var msg = '';
				var url = '';
				
			if (category == 'up') {
					add = 'up';
					msg = '수정'
					url = '/environ/upAutoScaleUpInfo.do';
				} else if (category == '') {
					add = '';
					msg = '등록'
					url = '/environ/setAutoScaleUpInfo.do';
				}

				var tenantSBval = $("#tenantSB" + add + " option:selected").val();
				var serviceSBval = $("#tenantInServiceSB" + add + " option:selected").val();
				var serviceSBtext = $("#tenantInServiceSB" + add + " option:selected").text();

				var upCPU = parseInt($("#scaleUpCPU" + add).val());
				var upMemory = parseInt($("#scaleUpMemory" + add).val());
				var addUpvCPU = parseInt($("#addUpvCPU" + add).val());
				var addUpMemory = parseInt($("#addUpMemory" + add).val());
				var waitingTime = parseInt($("#waiting" + add).val());

				var isUseValue = 'autoScale_onoff' + add
				var isUse = $("input[name=" + isUseValue + "]:checked").val();
				var index = 0;
				
				if (!tenantSBval) {
					alert("테넌트를 선택하십시오.");
					$("#tenantSB" + add).focus();
					return false;
				} else if (!serviceSBval) {
					alert("서비스를 선택하십시오");
					$("#tenantInServiceSB" + add).focus();
					return false;
				} else if (!upCPU) {
					alert("Scale UP CPU 임계치는 필수 기입 항목입니다.");
					$("#scaleUpCPU" + add).focus();
					return false;
				} else if (!upMemory) {
					alert("Scale UP Memory 임계치는 필수 기입 항목입니다.");
					$("#scaleUpMemory" + add).focus();
					return false;
				} else if (!addUpvCPU && addUpvCPU != 0) {
					console.log(addUpvCPU);
					alert("Scale UP vCPU 추가 개수는 필수 기입 항목입니다.");
					$("#addUpvCPU" + add).focus();
					return false;
				} else if (!addUpMemory && addUpMemory != 0) {
					alert("Scale UP Memory 추가는 필수 기입 항목입니다.");
					$("#addUpMemory" + add).focus();
					return false;
				} else if (!waitingTime) {
					alert("대기 시간은 필수 기입 항목입니다.");
					$("#waiting" + add).focus();
					return false;
				} else {
					index = getVMsInService(serviceSBval);
					if(index == 0){
					
					if (confirm("Auto Scale Up " + msg + "을 하시겠습니까?") == true) {

						$.ajax({

							url : url,
							type : "POST",
							dataType : "json",
							contentType : "application/json;charset=UTF-8",
							data : JSON.stringify({
								id : id,
								service_id : serviceSBval,
								service_ids : serviceSBtext,
								cpuUp : upCPU,
								memoryUp : upMemory,
								cpuAdd : addUpvCPU,
								memoryAdd : addUpMemory,
								isUse : isUse,
								waiting : waitingTime,
							}),
							success : function(data) {
								if (data == 1) {
									alert("Auto Scale Up "  + msg + "이 완료되었습니다.");
									window.parent.location.reload();
								} else if (data == 2) {
									alert("해당 서비스는 이미 Auto Scale Up이 등록되어 있습니다.");
								}
							},
							error : function() {
								console.log("통신 에러 ");
							}
						})

					} else {
						return false;
					}
						}
				}
			}
			
			function getVMsInService(serviceId){
				
				var hotAddnoneVMs = '';
				var index = 0;
				
				$.ajax({

					url : '/environ/getVMsInService.do',
					data : {
						service_id : serviceId,
					},
					async: false,
					success : function(data) {
						
						for(key in data){
							
							if(data[key].cpuHotAdd == 'true' && data[key].memoryHotAdd == 'true'){
								index = 0;
							} else if(data[key].cpuHotAdd == 'false' || data[key].memoryHotAdd == 'false') {
								hotAddnoneVMs += data[key].vm_name+"\n";
								index = 1;
							}
							
						}

						if(index == 1){ alert(hotAddnoneVMs+"가상머신이 HotAdd 설정이 Off로 되어있습니다.\nHotAdd 설정이 On으로 되어있어야 합니다.")};
						
					}
				})
				return index;
			}

			function getTenantList() {

				$.ajax({
					url : "/tenant/selectTenantList.do",
					success : function(data) {
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
					data : {
						tenantId : tenantsID
					},
					url : "/tenant/selectVMServiceListByTenantId.do",
					success : function(data) {
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

			function getAutoScaleUPList() {

				var autoScaleUP = $("#autoScaleUP").addClass("nowrap").DataTable({
					ajax : {
						"url" : "/environ/getAutoScaleUpList.do",
						"dataSrc" : "",
					},
					columns : [ {
						"data" : "service_ids",
						render : function(data, type, row) {
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
					}, {
						"data" : "cpuUp",
						render : function(data, type, row) {
							data = data + ' %';
							return data;
						}
					}, {
						"data" : "memoryUp",
						render : function(data, type, row) {
							data = data + ' %';
							return data;
						}
					}, {"data" : "cpuAdd"},
					   {"data" : "memoryAdd"},  
					   {"data" : "isUse",
						render : function(data, type, row) {
							if (data == 1) {
								data = '<span class="text-prom">ON</span>';
							} else if (data == 0) {
								data = '<span class="text-muted">OFF</span>';
							}
							return data;
						}
					}, {
						"data" : "id",
						"orderable" : false,
						render : function(data, type, row) {
							var html = '';
							var strService_ids = "\'"+row.service_ids+"\'";
							if (sessionApproval != BanNumber && sessionApproval > CONTROLCHECK) {
								html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
								html += '<i class="icon-menu9"></i>';
								html += '</a>';
								html += '<div class="dropdown-menu">';
								html += '<a href="#" class="dropdown-item" onclick="autoScaleUpUpdateCheck(' + data + "," + 1 + ')"><i class="icon-file-text"></i>상세 보기</a>';
								html += '<a href="#" class="dropdown-item" onclick="autoScaleUpUpdateCheck(' + data + "," + 2 + ')"><i class="icon-pencil7"></i>정보 변경</a>';
								html += '<a href="#" class="dropdown-item" onclick="autoScaleUpDelete('+data+","+strService_ids+','+row.isUse+')"><i class="icon-trash"></i>삭제</a>';
								html += '</div>';
							} else {
								html += '<i class="icon-lock2"></i>';
							}

							return html;
						}
					} ],
					lengthMenu : [ [ 5, 10, 25, 50, -1 ], [ 5, 10, 25, 50, "All" ] ],
					pageLength : 10,
					responsive : true,
					columnDefs : [ {
						responsivePriority : 1,
						targets : 0
					}, {
						responsivePriority : 2,
						targets : -1
					} ],
					dom : "<'datatables-header'<'row-padding-0'lf><'row-padding-0'B<'addModal'>>>" + "<'datatables-body'rt>" + "<'datatables-footer'ip>",
					buttons : [ {
						extend : "collection",
						text : "<i class='icon-import'></i><span class='ml-2'>내보내기</span>",
						className : "btn bg-prom dropdown-toggle",
						buttons : [ {
							extend : "csvHtml5",
							charset : "UTF-8",
							bom : true,
							text : "CSV",
							title : "Auto Scale UP 정보",
							exportOptions : {
								columns : [ 0, 1, 2, 3, 4, 5 ]
							}
						}, {
							extend : "excelHtml5",
							text : "Excel",
							title : "Auto Scale UP 정보",
							exportOptions : {
								columns : [ 0, 1, 2, 3, 4, 5 ]
							}
						} ]
					} ]
				});
				$(".addModal").html('<button type="button" class="btn bg-prom" data-toggle="modal" data-target="#addAutoScaleUP"><i class="icon-plus2"></i><span class="ml-2">Auto Scale UP 등록</span></button>');
			}

			function getTenantListUp(tenants_id, service_id) {
				$.ajax({
					url : "/tenant/selectTenantList.do",
					success : function(data) {
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
					data : {
						tenantId : tenantsID
					},
					url : "/tenant/selectVMServiceListByTenantId.do",
					success : function(data) {
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

			function autoScaleUpUpdateCheck(id, index) {

				$.ajax({
					url : "/environ/getOneAutoScaleUp.do",
					data : {
						id : id
					},
					success : function(data) {
						btnStatusChk(id, index);
						for (key in data) {
							getTenantListUp(data[key].tenants_id, data[key].service_id);
							$("#scaleUpCPUup").val(data[key].cpuUp);
							$("#scaleUpMemoryup").val(data[key].memoryUp);
							$("#addUpvCPUup").val(data[key].cpuAdd);
							$("#addUpMemoryup").val(data[key].memoryAdd);
							$("#waitingup").val(data[key].waiting);

							if (data[key].isUse == 0) {
								$("input:radio[name='autoScale_onoffup'][value='0']").prop("checked", true);
							} else if (data[key].isUse == 1) {
								$("input:radio[name='autoScale_onoffup'][value='1']").prop("checked", true);
							}
						}

						$("#changeAutoScaleUP").modal("show");
					}
				})
			}

			function btnStatusChk(id, index) {
				var header = '';
				var footer = '';
				var category = "\'"+'up'+"\'";
				
				if (index == 1) {
					header += '<h5 class="modal-title mb-0">Auto Scale UP 상세 보기</h5>';
					$("#modal-footer").hide();

				} else if (index == 2) {
					header += '<h5 class="modal-title mb-0">Auto Scale UP 정보 변경</h5>';
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="synthesisInputValidation('+category+','+id+')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
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
					$("#scaleUpCPUup").attr("disabled", true);
					$("#scaleUpMemoryup").attr("disabled", true);
					$("#addUpvCPUup").attr("disabled", true);
					$("#addUpMemoryup").attr("disabled", true);
					$("#waitingup").attr("disabled", true);
					$("#autoScale_onup").attr("disabled", true);
					$("#autoScale_offup").attr("disabled", true);

				} else if (index == 2) {
					$("#tenantSBup").attr("disabled", false);
					$("#tenantInServiceSBup").attr("disabled", false);
					$("#scaleUpCPUup").attr("disabled", false);
					$("#scaleUpMemoryup").attr("disabled", false);
					$("#addUpvCPUup").attr("disabled", false);
					$("#addUpMemoryup").attr("disabled", false);
					$("#waitingup").attr("disabled", false);
					$("#autoScale_onup").attr("disabled", false);
					$("#autoScale_offup").attr("disabled", false);
				}
			}

			//삭제
			function autoScaleUpDelete(id,serviceName,isUse) {

				var msg = '삭제';
				var url = '/environ/deleteAutoScaleUpInfo.do';
				
				if (confirm("Auto Scale Up " + msg + "을 하시겠습니까?") == true) {
					
					if (isUse == 1) {
						alert("사용중인 Auto Scale Up 기능을 삭제할 수 없습니다.\n미사용으로 변경 후 삭제 바랍니다.");
						return false;
					} else {
					
					$.ajax({

						url : url,
						type : "POST",
						dataType : "json",
						contentType : "application/json;charset=UTF-8",
						data : JSON.stringify({
							id : id,
							service_ids : serviceName
						}),
						success : function(data) {
							if (data == 1) {
								alert("Auto Scale Up "  + msg + "가 완료되었습니다.");
								window.parent.location.reload();
							}
						},
						error : function() {
							console.log("통신 에러 ");
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
	
		<div id="addAutoScaleUP" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">Auto Scale UP 등록</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body bg-light modal-type-4">
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
												<label>Scale UP CPU (%): <span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" placeholder="scale up CPU" min="1" max="100" onkeyup="autoScaleRegisterEnterkey()" id="scaleUpCPU">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>Scale UP Memory (%):<span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" placeholder="scale up memory" min="1" max="100" onkeyup="autoScaleRegisterEnterkey()" id="scaleUpMemory">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>Scale UP vCPU 추가 개수: <span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" placeholder="number of scale up vCPU" onkeyup="autoScaleRegisterEnterkey()" id="addUpvCPU">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>Scale UP Memory 추가 용량 (GB):<span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" placeholder="number of scale up memory" onkeyup="autoScaleRegisterEnterkey()" id="addUpMemory">
											</div>
										</div>
									</div>
									<div class="row mb-2-5">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group mb-0">
												<label>대기 시간 (분): <span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" placeholder="waiting time" min="1" max="60" value="5" onkeyup="autoScaleRegisterEnterkey()" id="waiting">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6 d-flex align-items-center mt-3">
											<div class="form-group form-check-inline mb-0">
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
					<div class="modal-footer bg-white">
						<button type="button" class="btn bg-prom rounded-round" onclick="synthesisInputValidation('',0)">등록<i class="icon-checkmark2 ml-2"></i></button>
					</div>
				</div>
			</div>
		</div>
		
		<div id="changeAutoScaleUP" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom" id="modal-header"></div>
					<div class="modal-body bg-light modal-type-4">
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
												<label>Scale UP CPU (%): <span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" min="1" max="100" id="scaleUpCPUup">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>Scale UP Memory (%):<span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" min="1" max="100" id="scaleUpMemoryup">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group"> 
												<label>Scale UP vCPU 개수: <span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" id="addUpvCPUup">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>Scale UP Memory 용량 (GB):<span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" id="addUpMemoryup">
											</div>
										</div>
									</div>
									<div class="row mb-2-5">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group mb-0">
												<label>대기 시간 (분): <span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" min="1" max="60" value="5" id="waitingup">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6 d-flex align-items-center mt-3">
											<div class="form-group form-check-inline mb-0">
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
					<div class="modal-footer bg-white" id="modal-footer"></div>
				</div>
			</div>
		</div>
		
		<div class="card bg-dark mb-0 table-type-5-6">
			<table id="autoScaleUP" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th rowspan="2">서비스명</th>
						
						<th colspan="2" class="text-center">UP 임계치</th>
						<th colspan="2" class="text-center">UP 단위</th>
						<th rowspan="2">사용 여부</th>
						<th rowspan="2">관리</th>
					</tr>
					<tr>
						<th>CPU (%)</th>
						<th>Memory (%)</th>
						<th>vCPU</th>
						<th>Memory (GB)</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>