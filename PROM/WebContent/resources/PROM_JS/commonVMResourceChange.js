function vmResourceChangeCheck(vmName, vCPUhotAdd, memoryHotAdd, service_ID, vmID) {
	if (!$("#vCPUchangeValueIT").val()) {
		alert("변경할 vCPU를 선택하십시오");
		$("#vCPUchangeValueIT").focus();

	} else if (!$("#memorychangeValueIT").val()) {
		alert("변경할 Memory를 선택하십시오");
		$("#memorychangeValueIT").focus();

	} else if ($("#vCPUchangeValueIT").val() > 32 || $("#vCPUchangeValueIT").val() < 1) {
		alert("vCPU는 1~32까지만 지원합니다.");
		$("#vCPUchangeValueIT").focus();

	} else if ($("#memorychangeValueIT").val() > 32 || $("#memorychangeValueIT").val() < 1) {
		alert("Memory는 1~32GB까지만 지원합니다.");
		$("#memorychangeValueIT").focus();

	} else {
		if (sessionApproval < CONTROLCHECK) {
			vmChangeRequestFinish(vmName, vCPUhotAdd, memoryHotAdd, service_ID, vmID);
		} else {
			//HOTADD 여부 체크
			if (vCPUhotAdd == true && memoryHotAdd == true) {
				vmResourceChangeStartHotON(vmName, service_ID, vmID);
			} else {
				if (confirm("해당 가상머신의 핫 플러그 기능이 꺼져있기 때문에\n해당 가상머신이 재부팅 됩니다 그대로 진행하시겠습니까?") == true) {
					vmResourceChangeStartHotOFF(vmName, service_ID, vmID);
				} else {
					return false;
				}
			}
		}
	}
}

function vmResourceChange(vmName, vCPU, Memory, vCPUhotAdd, memoryHotAdd, vm_service_ID, vmID) {
	var vmNameReplace = "\'" + vmName + "\'";
	var vmIDtoString = "\'" + vmID + "\'";
	var header = '';
	var footer = '';

	$("#changeVMResource").modal("show");
	
	$("#change-input").addClass("show");
	$("#change-warning-info").addClass("show");

	$("#choicevmName").val(vmName);
	$("#vCPUchangeValueIT").val(vCPU);
	$("#memorychangeValueIT").val(Memory);

	if (vCPUhotAdd == true) {
		$("#choicevCPUhotAdd").text("ON");
	} else if (vCPUhotAdd == false) {
		$("#choicevCPUhotAdd").text("OFF");
	}

	if (memoryHotAdd == true) {
		$("#choiceMemoryhotAdd").text("ON");
	} else if (memoryHotAdd == false) {
		$("#choiceMemoryhotAdd").text("OFF");
	}

	header += '<h5 class="modal-title mb-0">' + vmName + ' 자원 변경</h5>';
	header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	
	$("#changeVM-modal-header").empty();
	$("#changeVM-modal-header").append(header);

	if (sessionApproval < CONTROLCHECK) {
		var strChangeBtn = '자원 변경 신청';
	} else {
		var strChangeBtn = '자원 변경 실행';
	}

	footer += '<button type="button" class="btn bg-prom rounded-round" onclick="vmResourceChangeCheck(' + vmNameReplace + ", " + vCPUhotAdd + ", " + memoryHotAdd + ", " + vm_service_ID + ", " + vmIDtoString + ')">' + strChangeBtn + '<i class="icon-checkmark2 ml-2"></i></button>';

	$("#changeVM-modal-footer").empty();
	$("#changeVM-modal-footer").append(footer);
}

function vmChangeRequestFinish(vmName, vCPUhotAdd, memoryHotAdd, vm_service_ID, vmID) {
	var CR_cpu = $("#vCPUchangeValueIT").val();
	var CR_memory = $("#memorychangeValueIT").val();
	var cr_vmcontext = $("#reasonForApply").val();
	$.ajax({
		type: "POST",
		data: {
			vmID: vmID,
			crVMName: vmName,
			crCPU: CR_cpu,
			crMemory: CR_memory,
			crVMContext: cr_vmcontext,
			vmServiceID: vm_service_ID
		},
		url: "/apply/insertVMChange.do",
		success: function(data) {
			if(data = 1) {
				alert("가상머신 변경 신청이 완료되었습니다.");
				location.reload();
			} else if(data = 2) {
				alert("변경된 것이 없습니다.");
			} else {
				alert("가상머신 변경 신청에 실패했습니다.");
			}
		}
	})
}

function vmResourceChangeStartHotON(vmName, vm_service_ID, vmID) {
	var finalvCPUvalue = $("#vCPUchangeValueIT").val();
	var finalMemoryValue = $("#memorychangeValueIT").val();
	$.ajax({
		type: "POST",
		data: {
			vmID: vmID,
			crCPU: finalvCPUvalue,
			crMemory: finalMemoryValue,
			crVMName: vmName,
			vmServiceID: vm_service_ID,
			hotPlugOnOff: 'ON'
		},
		url: "/apply/changeVMResource.do",
		beforeSend: function() {
			var html = '<button class="btn bg-prom rounded-round" >자원 변경 작업 중...<i class="icon-spinner2 spinner ml-2"></i></button>';
			$("#changeVM-modal-footer").empty();
			$("#changeVM-modal-footer").append(html);
		},
		success: function(data) {
			if(data == 1) {
				alert("가상머신 자원 변경 완료 되었습니다.");
			} else if(data == 2) {
				alert("변경된 것이 없습니다.");
			} else {
				alert("가상머신 자원 변경에 실패했습니다.");
			}
			$("#changeVMResource").modal("hide");
			console.log(globalPreObj);
			setTimeout(function(){
			commonVMTable.ajax.reload( null, false );
			if( (globalPreObj != '' && globalPreObj != null) && typeof globalPreObj != 'undefined' ) {
				getOneVMInfo(0);
			}
			},3500)
		}
	})
}

function vmResourceChangeStartHotOFF(vmName, vm_service_ID, vmID) {
	var finalvCPUvalue = $("#vCPUchangeValueIT").val();
	var finalMemoryValue = $("#memorychangeValueIT").val();
	$.ajax({
		type: "POST",
		data: {
			vmID: vmID,
			crCPU: finalvCPUvalue,
			crMemory: finalMemoryValue,
			crVMName: vmName,
			vmServiceID: vm_service_ID,
			hotPlugOnOff: 'OFF'
		},
		url: "/apply/changeVMResource.do",
		beforeSend: function() {
			var html = '<button class="btn bg-prom rounded-round" >자원 변경 작업 중...<i class="icon-spinner2 spinner ml-2"></i></button>';
			$("#changeVM-modal-footer").empty();
			$("#changeVM-modal-footer").append(html);
		},
		success: function(data) {
			if(data == 1) {
				alert("가상머신 자원 변경 완료 되었습니다.");
			} else if(data == 2) {
				alert("변경된 것이 없습니다.");
			} else {
				alert("가상머신 자원 변경에 실패했습니다.");
			}
			$("#changeVMResource").modal("hide");
			setTimeout(function(){
				commonVMTable.ajax.reload( null, false );
				if( (globalPreObj != '' && globalPreObj != null) && typeof globalPreObj != 'undefined' ) {
					getOneVMInfo(0);
				}
				},3500)
		}
	})
}