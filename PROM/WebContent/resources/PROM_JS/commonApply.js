function getApprovalProgress(vmCreateData) {
				var html = '';

				var applyUser = '';
				var approvalUser = '';
				var reviewer = '';
				var approver = '';
				var worker = '';

				var applyTime = '';
				var approvalTime = '';
				var reviewerTime = '';
				var approverTime = '';
				var workerTime = '';

				var stageText1 = '';
				var stageText2 = '';
				var stageText3 = '';
				var stageText4 = '';
				var stageText5 = '';

				var reasonText1 = '';
				var reasonText2 = '';
				var reasonText3 = '';
				var reasonText4 = '';
				var reasonText5 = '';

				var stage1 = '';
				var stage2 = '';
				var stage3 = '';
				var stage4 = '';
				var stage5 = '';
				
				var arrow1 = '';
				var arrow2 = '';
				var arrow3 = '';
				var arrow4 = '';
				var arrow5 = '';

				var arrowPass = 'icon-arrow-right16 icon-2x text-prom mb-3'; 
				var arrowPROM = 'icon-arrow-right16 icon-2x text-prom mb-3'; 
				var arrowWarning = 'icon-cross2 icon-2x text-warning mb-3'; 
				var arrowMuted = 'icon-hand icon-2x text-muted mb-3'; 
				//var arrowMuted = 'icon-arrow-right16 icon-2x text-muted mb-3'; 
				var approval = 3;
				var companion = 5;
				
				var cr_num = vmCreateData.crNum;
				
				$.ajax({
					url : "/approval/selectApprovalWorkflowList.do",
					data : {
						crNum : cr_num
					},
					success : function(data) {

						for (key in data) {

							
							if(data[key].stage == 1){
								
								stageText1 = statusToText(data[key].status);
								reasonText1 = reasonToText(data[key].status);
								stage1 = data[key].stage;
								if (data[key].status == approval) {
									arrow1 = arrowPROM;
								} else if(data[key].status == companion){
									arrow1 = arrowWarning;
								} else {
									arrow1 = arrowMuted;
								}
							}
							
							if (data[key].stage == 2) {

								stageText2 = statusToText(data[key].status);
								reasonText2 = reasonToText(data[key].status);
								stage2 = data[key].stage;
								approvalUser = data[key].name;
								approvalTime = data[key].timestamp;
								if (data[key].status == approval) {
									arrow2 = arrowPROM;
								} else if(data[key].status == companion){
									arrow2 = arrowWarning;
								} else {
									arrow2 = arrowMuted;
								}

							}

							if (data[key].stage == 3) {

								stageText3 = statusToText(data[key].status);
								reasonText3 = reasonToText(data[key].status);
								stage3 = data[key].stage;
								
								reviewer = data[key].name;
								reviewerTime = data[key].timestamp;
								
								if (data[key].status == approval) {
									arrow3 = arrowPROM;
								} else if(data[key].status == companion){
									arrow3 = arrowWarning;
								} else {
									arrow3 = arrowMuted;
								}
								
							}

							if (data[key].stage == 4) {

								stageText4 = statusToText(data[key].status);
								reasonText4 = reasonToText(data[key].status);
								stage4 = data[key].stage;
								
								approver = data[key].name;
								approverTime = data[key].timestamp;
								
								if (data[key].status == approval) {
									arrow4 = arrowPROM;
								} else if(data[key].status == companion){
									arrow4 = arrowWarning;
								} else {
									arrow4 = arrowMuted;
								}
								
							}

							if (data[key].stage == 5) {

								stageText5 = statusToText(data[key].status);
								reasonText5 = reasonToText(data[key].status);
								stage5 = data[key].stage;
								
								worker = data[key].name;
								workerTime = data[key].timestamp;
								
								if (data[key].status == approval) {
									arrow5 = arrowPROM;
								} else if(data[key].status == companion){
									arrow5 = arrowWarning;
								} else {
									arrow5 = arrowMuted;
								}

							}

							
						}
						var maxlength = 0;
						maxlength = data[data.length-1].stage;
						
						var sessionStage = data[0].stage;
						var name = "\'" + vmCreateData.crVMName + "\'";
						var reason = "\'" + vmCreateData.crVMContext + "\'";

						//html += '<td class="bg-process" rowspan="4"><i class="icon-cross2 icon-2x text-warning mb-3"></i></td>';  반려 됐을 시 아이콘

						html += '<tr>';
						html += '<th>상태</th>';
						if(stageText1 != ''){ html += '<td>'+stageText1+'</td>';}
						else { html += '<td>신청</td>';}

						if(maxlength > 1){ html += '<td class="bg-process" rowspan="4"><i class="'+arrowPass+'"></i></td>'; 
						}else { html += '<td class="bg-process" rowspan="4"><i class="'+arrow1+'"></i></td>';  }
						
						if(stageText2 != ''){
							html += '<td>' + stageText2 + '</td>';
						}else if(maxlength == 1 && stageText1 != '신청 취소') { html += '<td>결재 대기</td>' 
							}else { html += '<td></td>';}

						if(maxlength > 2){ html += '<td class="bg-process" rowspan="4"><i class="'+arrowPass+'"></i></td>'; 
						}else { html += '<td class="bg-process" rowspan="4"><i class="'+arrow2+'"></i></td>';  }
						
						if(stageText3 != ''){
							html += '<td>' + stageText3 + '</td>';
						}else if(maxlength == 2 && stageText2 != '반려') { html += '<td>검토 중</td>' 
							}else { html += '<td></td>';}
						
						if(maxlength > 3){ html += '<td class="bg-process" rowspan="4"><i class="'+arrowPass+'"></i></td>'; 
						}else { html += '<td class="bg-process" rowspan="4"><i class="'+arrow3+'"></i></td>';  }
						
						if(stageText4 != ''){
							html += '<td>' + stageText4 + '</td>';
						}else if(maxlength == 3 && stageText3 != '반려') { html += '<td>승인 대기</td>' 
							}else { html += '<td></td>';}
						
						if(maxlength > 4){ html += '<td class="bg-process" rowspan="4"><i class="'+arrowPass+'"></i></td>'; 
						}else { html += '<td class="bg-process" rowspan="4"><i class="'+arrow4+'"></i></td>';  }
						
						if(stageText5 != ''){
							html += '<td>' + stageText5 + '</td>';
						}else if(maxlength == 4 && stageText4 != '반려') { html += '<td>작업 대기</td>' 
							}else { html += '<td></td>';}
						html += '</tr>'

						html += '<tr>';
						html += '<th>이름</th>';
						html += '<td>' + vmCreateData.userName + '</td>';
						html += '<td>' + approvalUser + '</td>';
						html += '<td>' + reviewer + '</td>';
						html += '<td>' + approver + '</td>';
						html += '<td>' + worker + '</td>';
						html += '</tr>';

						html += '<tr>';
						html += '<th>일시</th>';
						html += '<td>' + vmCreateData.crDatetime + '</td>';
						html += '<td>' + approvalTime + '</td>';
						html += '<td>' + reviewerTime + '</td>';
						html += '<td>' + approverTime + '</td>';
						html += '<td>' + workerTime + '</td>';
						html += '</tr>';

						html += '<tr>';
						html += '<th>사유</th>';
						html += '<td class="cpointer" onclick="vmReasonView(' + name + ', ' + cr_num + ',' + sessionStage + ')">신청 사유<i class="icon-add text-muted ml-2"></i></td>';
						if(reasonText2 != '' && reasonText2 != null){
						html += '<td class="cpointer" onclick="vmReasonView('+ name + ',' + cr_num + ',' + stage2 + ')">' + reasonText2 + '<i class="icon-add text-muted ml-2"></i></td>';
						}else { html += '<td></td>' }
						if(reasonText3 != '' && reasonText3 != null){
							html += '<td class="cpointer" onclick="vmReasonView('+ name + ',' + cr_num + ',' + stage3 + ')">' + reasonText3 + '<i class="icon-add text-muted ml-2"></i></td>';
							}else { html += '<td></td>' }
						if(reasonText4 != '' && reasonText4 != null){
							html += '<td class="cpointer" onclick="vmReasonView('+ name + ',' + cr_num + ',' + stage4 + ')">' + reasonText4 + '<i class="icon-add text-muted ml-2"></i></td>';
							}else { html += '<td></td>' }
						if(reasonText5 != '' && reasonText5 != null){
							html += '<td class="cpointer" onclick="vmReasonView('+ name + ',' + cr_num + ',' + stage5 + ')">' + reasonText5 + '<i class="icon-add text-muted ml-2"></i></td>';
							}else { html += '<td></td>' }
						html += '</tr>';

						$("#approvalProcessList").empty();
						$("#approvalProcessList").append(html);

					}
				})
			}

function statusToText(status) {

	var text = '';

	if (status == 1) {
		text = '신청';
	} else if (status == 2) {
		text = '신청 취소';
	} else if (status == 3) {
		text = '승인';
	} else if (status == 4) {
		text = '대기';
	} else if (status == 5) {
		text = '반려';
	} else if (status == 6) {
		text = '보류';
	} else if (status == 7) {
		text = '완료';
	}
	return text;

}

function reasonToText(status) {

	var text = '';

	if (status == 1) {
		text = '신청 사유';
	} else if (status == 2) {
		text = '신청 취소';
	} else if (status == 3) {
		text = '의견 사유';
	} else if (status == 4) {
		text = '대기';
	} else if (status == 5) {
		text = '반려 사유';
	} else if (status == 6) {
		text = '보류 사유';
	} else if (status == 7) {
		text = '완료';
	}
	return text;
}

//사유
function vmReasonView(vmName, cr_num, stage) {
	var header = '';
	$("#vmReason").modal("show");

	$.ajax({

		url : "/approval/selectApprovalWorkflowList.do",
		data : {
			crNum : cr_num,
			stage : stage
		},
		success : function(data) {
			$("#reasonVMName").val(vmName);
			$("#commentVMReason").val(data[0].description);

			header += '<h5 class="modal-title mb-0">' + vmName + ' 사유</h5>'; // 신청 사유 / 의견 / 작업 내용 / 반려 사유 / 보류 사유
			header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';

			$("#vmReason-modal-header").empty();
			$("#vmReason-modal-header").append(header);

		}

	})
}

function userApplyCancel(num) {
	if (confirm('가상머신 '+category+' 신청을 취소하시겠습니까?') == true) {
		$.ajax({
			url : "/approval/cancelVMCreate.do",
			data : {
				crNum : num,
			},
			success : function(data) {
				if (data == 1) {
					alert('가상머신 '+category+' 신청 취소가 완료되었습니다.');
					location.reload();
				}
			}
		})
	} else {
		return false;
	}
}

function modalOpen(index) {
	if(index == 1){
		
	$("#vmApproveAdmin").on("shown.bs.modal", function() {
		$("#crIPaddr").focus();
	})

	$(document).on('click', '#vmApprovePrevious', function() {
		$("#template-info").addClass("show");
		$("#warning-info").addClass("show");
		$("#input-info").addClass("show");

		$("#vmApproveAdmin").modal("show");
		$("#checkSetting").modal("hide");
	})
	
	}else if(index == 2){
		
	$("#vmApproveAdmin").on("shown.bs.modal", function() {
		$("#approvalVMReasonAdmin").focus();
	})	
		
	}
	
	$("#vmDelete").on("shown.bs.modal", function() {
		$("#deleteVMReason").focus();
	})
	$("#vmApprove").on("shown.bs.modal", function() {
		$("#aproveVMReason").focus();
	})
	$("#vmHold").on("shown.bs.modal", function() {
		$("#holdVMReason").focus();
	})
	
}

//작업자 승인 모달
function modalControllApprovalAdmin(cr_num, vmName, sUserID, cr_sorting) {
	$("#vmApproveAdmin").modal("show");

	$("#template-info").addClass("show");
	$("#warning-info").addClass("show");
	$("#input-info").addClass("show");

	$.ajax({
		url : "/approval/selectVMCreate.do",
		data : {
			crNum : cr_num,
			crSorting : cr_sorting
		},
		success : function(data) {
			var header = '';
			var footer = '';
			var name = "\'" + vmName + "\'";
			if(cr_sorting == 1){
				
				chkDHCPval(data.vmServiceID);
				chkChoiceSettingval(data.vmServiceID);
			
				header += '<h5 class="modal-title mb-0">' + vmName + ' 생성 승인</h5>';
				header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';

				footer += '<button type="button" class="btn bg-prom rounded-round" onclick="applyLastView(' + cr_num + ', ' + name + ',' + data.crSorting + ')">다음<i class="icon-arrow-right13 ml-2"></i></button>';
			
				// 템플릿 정보
				$("#templateName").html(data.crTemplet);
				$("#templateOS").html(data.vmOS);
				$("#templateDisk").html(data.vmDisk + " GB");
	
				if (data.description == null) {
					$("#templateDescription").html("<span class='text-muted'>설명이 없습니다.</span>");
				} else {
					$("#templateDescription").html(data.description);
				}

				// 필수 입력 정보
				$("#vCPU").val(data.crCPU);
				$("#memory").val(data.crMemory);

				var vcpu = data.crCPU;
				var memory = data.crMemory;
	
				$("#flavorList").empty();
	
				if (vcpu == 1 && memory == 2) {
					$("#flavorList").append("<option>Tiny</option>");
				} else if (vcpu == 2 && memory == 4) {
					$("#flavorList").append("<option>Small</option>");
				} else if (vcpu == 4 && memory == 8) {
					$("#flavorList").append("<option>Middle</option>");
				} else if (vcpu == 8 && memory == 16) {
					$("#flavorList").append("<option>Large</option>");
				} else {
					$("#flavorList").append("<option>Custom</option>");
				}
	
				$("#tenantSelectBox").empty();
				$("#tenantSelectBox").append("<option>" + data.tenantName + "</option>");
				$("#serviceSelectBox").empty();
				$("#serviceSelectBox").append("<option>" + data.serviceName + "</option>");
	
				$("#crVMname").val(data.crVMName);
				$("#crVMcontext").val(data.crVMContext);
	
				// 신청 정보 확인
				var flavorValueCPU = $("#vCPU").val();
				var flavorValueMemory = $("#memory").val();
				var flavorValue = $("#flavorList option:selected").val();
				var tenantSBtext = $("#tenantSelectBox option:selected").text();
				var serviceSBtext = $("#serviceSelectBox option:selected").text();
				var createVMname = $("#crVMname").val();
				var createContext = $("#crVMcontext").val();
				
				$("#cstemplateName").html(data.crTemplet);
				$("#cstemplateOS").html(data.vmOS);
				$("#cstemplateDisk").html(data.vmDisk + " GB");
				$("#cstemplateFlavor").html(flavorValue + " (vCPU: " + flavorValueCPU + " / Memory: " + flavorValueMemory + " GB)");
				if (data.description == null) {
					$("#cstemplateDescription").html("<span class='text-muted'>설명이 없습니다.</span>");
				} else {
					$("#cstemplateDescription").html(data.description);
				}
				
				$("#cstemplateTenants").html(tenantSBtext);
				$("#cstemplateService").html(serviceSBtext);
				$("#csnewVMname").html(createVMname);
				$("#csserviceContext").html(data.crVMContext);
			
			} else if( cr_sorting == 2 ){
				header += '<h5 class="modal-title mb-0">' + vmName + ' 변경 승인</h5>';
				header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
				//취소 UI 다시
				//footer += '<button type="button" class="btn bg-prom rounded-round close" data-dismiss="modal">취소<i class="icon-arrow-right13 ml-2"></i></button>';
				footer += '<button type="button" class="btn bg-prom rounded-round" onclick="applyVMDetail(' + cr_num + ', ' + data.crSorting + ',' + data.cpuHotAdd +','+ data.memoryHotAdd +')">승인<i class="icon-checkmark2 ml-2"></i></button>';
				
				$("#subjectVMname").val(vmName);
				
				$("#beforevCPU").val(data.vmCPU);
				$("#beforeMemory").val(data.vmMemory);
				
				$("#aftervCPU").val(data.crCPU);
				$("#afterMemory").val(data.crMemory);
				
				$("#vCPUhotAddState").empty();
				$("#memoryhotAddState").empty();
				
				if(data.cpuHotAdd == true){
					$("#vCPUhotAddState").append("ON");
				}else { $("#vCPUhotAddState").append("OFF"); }
					
				if(data.memoryHotAdd == true){
					$("#memoryhotAddState").append("ON");
				}else { $("#memoryhotAddState").append("OFF"); }
				
			} 
			
			$("#vmApproveAdmin-modal-header").empty();
			$("#vmApproveAdmin-modal-header").append(header);
			
			$("#vmApproveAdminl-modal-footer").empty();
			$("#vmApproveAdminl-modal-footer").append(footer);
			
		}
	})
}

function modalControlladdApprovalAdmin(cr_num, vmName,category,originallyHost,vm_ID,cr_disk,cr_template) {
	
	var footer = '';
	var header = '';
	var functionName = '';
	var authoritychk = 2;
	var vmIdToString = "\'" +vm_ID+ "\'";
	var vmNameToString = "\'" + vmName + "\'";
	var categoryToString = "\'" + category + "\'";
	var templateToString = "\'" + cr_template + "\'";
	$("#addVMInfo").modal("show");
	
	if(category == 'addDisk'){
		header += '<h5 class="modal-title mb-0">디스크 추가 승인</h5>';
		getDataStoresParamVerInHost(originallyHost, "commonSB");
		//$("#changeTitle").empty().append("Disk #");
		$("#changeSub").empty().append("데이터스토어:<span class='text-prom ml-2'>(필수)</span>");
		functionName = 'addDiskOfVM';
	} else if ( category == 'addCDROM') {
		header += '<h5 class="modal-title mb-0">CD-ROM 연결 승인</h5>';
		getDataStoresParamVerInHost(originallyHost, "commonSB");
		//$("#changeTitle").empty().append("Disk #");
		$("#changeSub").empty().append("데이터스토어:<span class='text-prom ml-2'>(필수)</span>");
		functionName = 'mountCD';
	} else if (category == 'addvNic') {
		header += '<h5 class="modal-title mb-0">네트워크 추가 승인</h5>';
		getNetworksParamVerInHost(originallyHost, "commonSB");
		//$("#changeTitle").empty().append("Network #");
		$("#changeSub").empty().append("네트워크:<span class='text-prom ml-2'>(필수)</span>");
		functionName = 'addvNICOfVM';
	}
	
	header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	footer += '<button type="button" class="btn bg-prom rounded-round" onclick="addpartOfVMapproval('+ categoryToString +','+ cr_num + ',' + vmIdToString +','+vmNameToString+','+ cr_disk+','+templateToString+')">승인<i class="icon-checkmark2 ml-2"></i></button>';
	
	$("#modal-header").empty();
	$("#modal-header").append(header);
	
	$("#modal-footer").empty();
	$("#modal-footer").append(footer);
	
}

function addpartOfVMapproval(category,cr_num,vm_ID,vmName,cr_disk,cr_template){

	var commonSB = $("#commonSB option:selected").val();
	var commonSBText = $("#commonSB option:selected").text();
	
	if(cr_disk == null || cr_disk == 'undefined'){
		cr_disk = 0;
	}
	
	$.ajax({
		
		url : "/approval/approvalVMCreate.do",
		type : 'POST',
		data : {
			crSorting : 2,
			category : category,
			crNum : cr_num,
			crDisk : cr_disk,
			crTemplet : cr_template,
			vmID : vm_ID,
			crVMName : vmName,
			selectedValue : commonSB,
			selectedText : commonSBText
		},
		beforeSend: function() {
			var footer = '';

			footer += '<button type="button" class="btn bg-prom rounded-round" >가상머신 변경 작업중...<i class="icon-spinner2 spinner ml-2"></i></button>';
			$("#modal-footer").empty();
			$("#modal-footer").append(footer);
		},
		success:function(data){
			window.parent.location.reload();
		}
	})
}

//승인
function modalControllApprove(cr_num, vmName, userId) {
	var header = '';
	var footer = '';
	var index = 1;
	var sUserID = "\'" + userId + "\'";
	
	$("#vmApprove").modal("show");

	$("#approveVMName").val(vmName);

	header += '<h5 class="modal-title mb-0">' + vmName +' '+ category +' 승인</h5>';
	header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	$("#vmApprove-modal-header").empty();
	$("#vmApprove-modal-header").append(header);

	footer += '<button type="button" class="btn bg-prom rounded-round" onclick="approveVMDetail(' + cr_num +',' + index + ')">승인<i class="icon-checkmark2 ml-2"></i></button>';
	$("#vmApprove-modal-footer").empty();
	$("#vmApprove-modal-footer").append(footer);
}

function approveVMDetail(cr_num,index) {
	var description = $("#aproveVMReason").val();
	$.ajax({
		url : "/approval/updateVMCreateApproval.do",
		data : {
			index : index,
			crNum : cr_num,
			description : description,
		},
		success : function(data) {
			if (data == 1) {
				alert('가상머신 '+ category +' 신청 승인 완료되었습니다.');
				window.parent.location.reload();
			}
		}

	})
}

// 반려
function modalControllDelete(cr_num, vmName) {
	var header = '';
	var footer = '';
	$("#vmDelete").modal("show");

	$("#deleteVMName").val(vmName);

	header += '<h5 class="modal-title mb-0">' + vmName +' '+ category +' 반려</h5>';
	header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	$("#vmDelete-modal-header").empty();
	$("#vmDelete-modal-header").append(header);

	footer += '<button type="button" class="btn bg-prom rounded-round" onclick="deleteVMDetail(' + cr_num + ')">반려<i class="icon-checkmark2 ml-2"></i></button>';
	$("#vmDelete-modal-footer").empty();
	$("#vmDelete-modal-footer").append(footer);
}

function deleteVMDetail(cr_num) {
	var description = $("#deleteVMReason").val();
	$.ajax({
		url : "/approval/rejectVMCreate.do",
		data : {
			crNum : cr_num,
			description : description
		},

		success : function(data) {
			if (data == 1) {
				alert('가상머신 '+ category +' 신청 반려가 완료되었습니다.');
				window.parent.location.reload();
			}
		},
		error : function() {
			alert("예기치 못한 오류\n반려 실패");
		}
	})
}

// 보류
function modalControllHold(cr_num, vmName) {
	var header = '';
	var footer = '';
	$("#vmHold").modal("show");
	$("#holdVMName").val(vmName);

	header += '<h5 class="modal-title mb-0">' + vmName +' '+ category +' 보류</h5>';
	header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	$("#vmHold-modal-header").empty();
	$("#vmHold-modal-header").append(header);

	footer += '<button type="button" class="btn bg-prom rounded-round" onclick="holdVMDetail(' + cr_num + ')">보류<i class="icon-checkmark2 ml-2"></i></button>';
	$("#vmHold-modal-footer").empty();
	$("#vmHold-modal-footer").append(footer);
}

function holdVMDetail(cr_num) {
	var description = $("#holdVMReason").val();
	$.ajax({
		url : "/approval/holdVMCreate.do",
		data : {
			crNum : cr_num,
			description : description
		},

		success : function(data) {
			if (data == 1) {
				alert('가상머신 '+ category +' 신청 보류가 완료되었습니다.');
				location.reload();
			}
		},
		error : function() {
		}
	})
}

function chkDHCP(optionServiceId) {

	var serviceId = $("#" + optionServiceId + " option:selected").val();
	
	$.ajax({

		data : {
			serviceId : serviceId
		},
		url : "/tenant/selectDHCPState.do",
		success : function(data) {
				console.log(data);
				if (data['getOneInfo'].dhcpOnoff == 1) {
					$("#crIPgroup").hide();
					globalDHCPChk = 1;
				} else {
					$("#crIPgroup").show();
					globalDHCPChk = 2;
				}
		}
	})

}

function chkDHCPval(paraServiceId){
	
	var serviceId = paraServiceId;
	
	$.ajax({

		data : {
			serviceId : serviceId
		},
		url : "/tenant/selectDHCPState.do",
		success : function(data) {
				console.log(data);
				if (data['getOneInfo'].dhcpOnoff == 1) {
					$("#crIPgroup").hide();
					globalDHCPChk = 1;
				} else {
					$("#crIPgroup").show();
					globalDHCPChk = 2;
				}
		}
	})
	
}


