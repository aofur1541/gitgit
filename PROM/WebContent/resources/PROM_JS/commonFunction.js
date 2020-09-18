function ftnlimited(index) {

	if (index == 1) {
		setTimeout(function() {
			$('button').attr('disabled', true);
			$('a').prop("disabled", true);
			// 내보내기 버튼 활성화 여부 코드
			//$('.dropdown-toggle').attr('disabled', false);
		}, 200)
	} else if (index == 2) {
		setTimeout(function() {
			$('input').attr('disabled', true);
			$('number').attr('disabled', true);
			$('select').attr('disabled', true);
		}, 200)
	} else if (index == 3) {
		setTimeout(function() {
			$('input').attr('disabled', true);
			$('number').attr('disabled', true);
			$('select').attr('disabled', true);
			$('button').attr('disabled', true);
			$('a').prop("disabled", true);
		}, 200)
	} else if (index == 4) {
		setTimeout(function() {
			$('button').attr('disabled', true);
		}, 200)
	} else if (index == 5) {
		setTimeout(function() {
			$('a').prop("disabled", true);
		}, 200)
	} else if (index == 99) {
		 var $preview_zone = $('.nolink');
		    $preview_zone
		      .find('div,a, [onclick]').on('click', function(){
		        return false;
		      })
		      .prop('onclick', null);
		    ;
	}

}

function getUserVMCtrlchk() {
	$.ajax({
		url : "/config/selectBasic.do",
		data : {
			targetName : 'userVMCtrl'
		},
		success : function(data) {
			userVMCtrlchk = data.value
		}
	})
}

function getStage(nApproval) {
	var result = nApproval;
	var stage = 0;
	if (result == USER_NAPP) {
		stage = 1;
	} else if (result == USER_HEAD_NAPP) {
		stage = 2;
	} else if (result == MANAGER_NAPP) {
		stage = 3;
	} else if (result == MANAGER_HEAD_NAPP) {
		stage = 4;
	} else if (result == OPERATOR_NAPP) {
		stage = 5;
	} else if (result == ADMIN_NAPP) {
		stage = 5;
	}

	return stage;

}

function getClusterList(clusterInfo, hostInfo, dataStoreInfo, networkInfo) {
	$.ajax({

		url : "/tenant/selectClusterList.do",
		success : function(data) {
			var html = '';
			for (key in data) {
				if (clusterInfo != data[key].clusterName) {
					html += '<option value=' + data[key].clusterName + '>' + data[key].clusterName + '</option>';
				} else {
					html += '<option value=' + data[key].clusterName + ' selected>' + data[key].clusterName + '</option>';
				}
			}

			$("#defaultClusterSB").empty();
			$("#defaultClusterSB").append(html);
			getClusterinHostList(hostInfo, dataStoreInfo, networkInfo);
		}
	})
}

function getClusterinHostList(hostInfo, dataStoreInfo, networkInfo) {

	var clusterName = $("#defaultClusterSB option:selected").val();
	$.ajax({
		data : {
			hostParent : clusterName
		},
		url : "/tenant/selectVMHostList.do",
		success : function(data) {
			var html = '';
			var host = '';
			if (data == '' || data == null) {

				html += '<option value=0 selected disabled>:: 호스트가 존재하지 않습니다. ::</option>';
				$("#defaultStorageSB").empty();
				$("#defaultStorageSB").append(html);
				$("#defaultNetworkSB").empty();
				$("#defaultNetworkSB").append(html);
			} else {
				for (key in data) {
					if (hostInfo != data[key].vmHhostname) {
						html += '<option value=' + data[key].vmHhostname + '>' + data[key].vmHhostname + '</option>';
					} else {
						html += '<option value=' + data[key].vmHhostname + ' selected>' + data[key].vmHhostname + '</option>';
					}
				}
			}
			$("#defaultHostSB").empty();
			$("#defaultHostSB").append(html);
			hostinDataStoreList(dataStoreInfo);
			hostinNetworkList(networkInfo);
		}
	})
}

function hostinDataStoreList(dataStoreInfo) {

	var hostChoice = $("#defaultHostSB option:selected").val();
	$.ajax({

		url : "/tenant/selectHostDataStoreListByHostID.do",
		data : {
			hostID : hostChoice
		},
		success : function(data) {
			var html = '';
			if (data == null || data == '') {
				html += '<option value=0 selected disabled>:: 데이터스토어가 존재하지 않습니다. ::</option>';
			} else {
				for (key in data) {
					if (dataStoreInfo != data[key].dataStoreID) {
						html += '<option value=' + data[key].dataStoreID + ' value2=' + data[key].dataStoreName + '>' + data[key].dataStoreName + " / 전체 " + data[key].stAllca + ' GB / 사용량 ' + data[key].stUseca + " GB / 남은용량 "
								+ data[key].stSpace + ' GB</option>';
					} else {
						html += '<option value=' + data[key].dataStoreID + ' value2=' + data[key].dataStoreName + ' selected>' + data[key].dataStoreName + " / 전체 " + data[key].stAllca + ' GB / 사용량 ' + data[key].stUseca + " GB / 남은용량 "
								+ data[key].stSpace + ' GB</option>';
					}
				}
			}
			$("#defaultStorageSB").empty();
			$("#defaultStorageSB").append(html);
		}

	})
}

function hostinNetworkList(networkInfo) {

	var hostChoice = $("#defaultHostSB option:selected").val();

	$.ajax({

		url : "/tenant/selectHostNetworkListByHostID.do",
		data : {
			hostID : hostChoice
		},
		success : function(data) {
			var html = '';
			if (data == null || data == '') {
				html += '<option value="0" selected disabled>:: 네트워크가 존재하지 않습니다. ::</option>';
			} else {
				for (key in data) {
					if (networkInfo != data[key].netWorkID) {
						html += '<option value=' + data[key].netWorkID + ' value2=' + data[key].netWorkName + '>' + data[key].netWorkName + '</option>';
					} else {
						html += '<option value=' + data[key].netWorkID + ' value2=' + data[key].netWorkName + ' selected>' + data[key].netWorkName + '</option>';
					}
				}
			}
			$("#defaultNetworkSB").empty();
			$("#defaultNetworkSB").append(html);
		}
	})
}
//#1099
function getDataStoresParamVerInHost(hostName,appendId) {

	$.ajax({

		url : "/common/getDataStoresInHost.do",
		data : {
			hostId : hostName
		},
		success : function(data) {
			var html = '';
			if (data == null || data == '') {
				html += '<option value=0 selected disabled>:: 데이터스토어가 존재하지 않습니다. ::</option>';
			} else {
				for (key in data) {
					html += '<option value=' + data[key].dataStoreID + '>' + data[key].dataStoreName + '</option>';
				}
			}
			$("#"+appendId).empty();
			$("#"+appendId).append(html);
		}

	})
}
//#1099
function getNetworksParamVerInHost(hostName,appendId) {

	$.ajax({

		url : "/common/getNetworksInHost.do",
		data : {
			hostId : hostName
		},
		success : function(data) {
			var html = '';
			if (data == null || data == '') {
				html += '<option value="0" selected disabled>:: 네트워크가 존재하지 않습니다. ::</option>';
			} else {
				for (key in data) {
						html += '<option value=' + data[key].netWorkID +'>' + data[key].netWorkName + '</option>';
				}
			}
			$("#"+appendId).empty();
			$("#"+appendId).append(html);
		}
	})
}

function getHostInfoByName(hostChoice){
	
	var hostParent;
	
	if(typeof hostChoice === 'undefined'){
		
	} else {
		
		$.ajax({
			
			url : "/common/getHostInfoByName.do",
			data : { hostName : hostChoice },
			async : false,
			success:function(data){
				
				hostParent = data.clusterId;
			}
			
		})
	}
	return hostParent;
}

function getClusterListCaseOne(clusterChoice,hostChoice) {
	
	
	$.ajax({

		url : "/tenant/selectClusterList.do",
		success : function(data) {
			var html = '';
			if (data == null || data == '') {

				html += '<option value="0" selected disabled>:: 클러스터가 존재하지 않습니다. ::</option>';

			} else {
				var hostParent = getHostInfoByName(hostChoice);
				for (key in data) {
					if (clusterChoice == 'clusterAll' && hostParent == data[key].clusterID) {
						html += '<option value=' + data[key].clusterID + ' selected>' + data[key].clusterName + '</option>';
					} else if(clusterChoice != data[key].clusterID){
						html += '<option value=' + data[key].clusterID + '>' + data[key].clusterName + '</option>';
					} else {
						html += '<option value=' + data[key].clusterID + ' selected>' + data[key].clusterName + '</option>';
					}
				}
			}

			$("#defaultClusterSB").empty();
			$("#defaultClusterSB").append(html);
			getHostsInClusterCaseOne(hostChoice);
		}
	})
}

function getHostsInClusterCaseOne(hostChoice) {

	var clusterID = $("#defaultClusterSB option:selected").val();

	$.ajax({
		data : {
			clusterID : clusterID
		},
		url : "/common/getHostsInCluster.do",
		success : function(data) {
			var html = '';
			if (data == '' || data == null) {
				html = '<option value=0 selected disabled>:: 호스트가 존재하지 않습니다. ::</option>';
			} else {
					html += '<option value="hostAll">호스트 전체</option>';
				for (key in data) {
					if ( hostChoice != data[key].vm_Hhostname ) {
						html += '<option value=' + data[key].vm_HID + '>' + data[key].vm_Hhostname + '</option>';
					} else {
						html += '<option value=' + data[key].vm_HID + ' selected>' + data[key].vm_Hhostname + '</option>';
					}
				}
			}
			$("#defaultHostSB").empty();
			$("#defaultHostSB").append(html);
			hostDataOptions();
		}
	})

}



function getTenantsCaseOne(tenants_id) {
	
	var select = '';
	
	$.ajax({

		url: "/tenant/selectTenantList.do",
		success: function(data) {
			var html = '';
			html += '<option value="0">테넌트 전체</option>';
			for (key in data) {
				if(tenants_id != data[key].id){
					html += '<option value=' + data[key].id + '>' + data[key].name + '</option>';
				} else {
					select = '<option value=' + data[key].id + '>' + data[key].name + '</option>';
				}
			}

			$("#defaultTenantsSB").empty();
			if(typeof tenants_id === 'undefined'){
				$("#defaultTenantsSB").append(html);
			} else {
				$("#defaultTenantsSB").append(select);
			}
		}
	})
}

function getClusterListCaseTwo() {
	
	$.ajax({

		url : "/tenant/selectClusterList.do",
		success : function(data) {
			var html = '';
			if (data == null || data == '') {

				html = '<option value="0" selected disabled>:: 클러스터가 존재하지 않습니다. ::</option>';

			} else {
						html += '<option value="clusterAll">클러스터 전체</option>';
				for (key in data) {
						html += '<option value=' + data[key].clusterID + '>' + data[key].clusterName + '</option>';
				}
			}

			$("#defaultClusterSB").empty();
			$("#defaultClusterSB").append(html);
		}
	})
}

function setTimeSetting(dateChk) {

	var setTimeArr = new Array();
	switch (dateChk) {
	case 0:
		setTimeArr[0] = 'minute';
		setTimeArr[1] = 5;
		break;
	case 1:
		setTimeArr[0] = 'hour';
		setTimeArr[1] = 4;
		break;
	case 2:
		setTimeArr[0] = 'day';
		setTimeArr[1] = 1;
		break;
	default:
		setTimeArr[0] = 'minute';
		setTimeArr[1] = 5;
	}
	return setTimeArr;
}

function setDateCheck(useGraphTimeChoice) {

	switch (useGraphTimeChoice) {

	case 'Realtime':
		return 0;
		break;
	case 'oneDay':
		return 1;
		break;
	case 'oneWeek':
		return 2;
		break;
	default:
		return 0;

	}

}

//host common link
function hostMonitoringLink(clusterName,hostName){
	
	var hostLink = '';
	
	hostLink = "\'" + '/menu/monitoring.do?cn='+clusterName+'&hn=' + hostName + "#2\'";
	
	return hostLink;
	
}

//Function to print the number ","
function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//Date Replace Time
function getTimeStamp(date) {
	var d = new Date(date);
	var s = leadingZeros(d.getFullYear(), 4) + '-' + leadingZeros(d.getMonth() + 1, 2) + '-' + leadingZeros(d.getDate(), 2) + ' ' + leadingZeros(d.getHours(), 2) + ':' + leadingZeros(d.getMinutes(), 2) + ':' + leadingZeros(d.getSeconds(), 2);

	return s;
}

//Date Replace RealTime
function getRealTimeStamp(date) {
	var d = new Date(date);
	var s = leadingZeros(d.getDate(), 2) + ' ' + leadingZeros(d.getHours(), 2) + ':' + leadingZeros(d.getMinutes(), 2) + ':' + leadingZeros(d.getSeconds(), 2);

	return s;
}

//Date Replace Month
function getMonthTimeStamp(date) {
	var d = new Date(date);
	var s = leadingZeros(d.getMonth() + 1, 2) + '-' + leadingZeros(d.getDate(), 2) + ' ' + leadingZeros(d.getHours(), 2) + ':' + leadingZeros(d.getMinutes(), 2) + ':' + leadingZeros(d.getSeconds(), 2);

	return s;
}

function dataEmptyCheck(data){
	
	if(data == null || data == ''){
		return true;
	} else {
		return false;
	}
	
}

function globalMessage(index){
	var msg = '';
	if(index == 1){
		msg = '알 수 없는 오류';
		alert(msg);
	} else {
		console.log("function globalMessage 값이 올바르지 않음");
	}
	
	
}

function getErrorMessage(jqXHR, exception){
	
	var msg = '';
    if (jqXHR.status === 0) {
        msg = 'Not connect.\n Verify Network.';
    } else if (jqXHR.status == 404) {
        msg = 'Requested page not found. [404]';
    } else if (jqXHR.status == 500) {
        msg = 'Internal Server Error [500].';
    } else if (exception === 'parsererror') {
        msg = 'Requested JSON parse failed.';
    } else if (exception === 'timeout') {
        msg = 'Time out error.';
    } else if (exception === 'abort') {
        msg = 'Ajax request aborted.';
    } else {
        msg = 'Uncaught Error.\n' + jqXHR.responseText;
    }
    alert(msg);
	
}


