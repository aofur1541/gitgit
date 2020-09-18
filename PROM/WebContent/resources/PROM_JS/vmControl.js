function ctrlPowerOfVM(vmName,index,category) {
	
	var msg;
	
	switch(index){
	case 1 : msg="시작";
	break;
	case 2 : msg="종료";
	break;
	case 3 : msg="다시 시작";
	break;
	}
	
	if(confirm(vmName + " 전원을 "+msg+" 하시겠습니까?") == true){
		executeVMStateChange(vmName,index,category);
	} else { return false;}
	
}

			
function executeVMStateChange(vmName,index,category){
	$.ajax({
		type: 'POST',
		data : { 
			vmName : vmName,
			stateIndex : index	
		},
		url : "/apply/controlVMState.do",
		success:function(data){
			if(index == 1){alert("가상머신 전원 켜기 실행")}
			if(index == 2){alert("가상머신 전원 끄기 실행")}
			if(index == 3){alert("가상머신 전원 리셋 실행")}
			commonVMTable.ajax.reload( null, false );
			if(category == 'tableReload'){
				commonVMTable.ajax.reload( null, false );
			} else if(category == 'functionReload') {
				if(globalPreObj != ""){
					setTimeout(function(){
						getOneVMInfo(0);
					},1000)
				} else {
					location.reload();
				}
			}
		}
	})
}

function getOneVMInfo(active){
	
	console.log(globalPreObj.vm_ID);
	
	$.ajax({
		url : "/apply/selectVMData.do",
		data : {
			vmId : globalPreObj.vm_ID 
		},
		success:function(data){
			setTimeout(function(){
			if( active == 1 ){
				var temptable = $('#serviceVMTable').DataTable();
				var start = temptable.row().data();
				$('#serviceVMTable tr').eq(1).addClass("selectedTr");
				getVMDetailInfo(start);
			} else {
				$('#serviceVMTable tr').eq(globalThis).addClass("selectedTr");
				getVMDetailInfo(data[0]);
			}
			},1000)
		}
		
	})
	
}

function destoryVMvalidation(vmName){
	
	if(confirm(vmName+" 가상머신을 삭제 하시겠습니까?") == true){
		$("#vmDeleteLoading").show();
		$("#loadingMessages").text("가상머신 삭제중...");
		$.ajax({
			data : { vmName : vmName },
			type: 'POST',
			url : "/apply/deleteVM.do",
			success:function(data){
				$("#vmDeleteLoading").hide();
				$("#loadingMessages").text("");
				if(data == 1){
					alert("가상머신 삭제 실행");
				}else if(data == 2){
					alert("전원이 켜진 가상머신은 삭제할 수 없습니다.");
					return;
				}else if(data == 3){
					alert("서비스에 매핑된 가상머신은 삭제할 수 없습니다.");
					return;
				}else{
					alert("가상머신 삭제 실패");
					return;
				}
				commonVMTable.ajax.reload( null, false );
				
				if( globalThis != null ){
					
				if((globalThis-1) < 1){
					location.reload();
				} else {
					setTimeout(function(){
						getOneVMInfo(1)
					},1000)
				}
				
				}
				
			}
		})
	} else {return false;}
}
