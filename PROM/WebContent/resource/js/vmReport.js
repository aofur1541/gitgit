// 사용자가 매핑된 테넌트 사용 여부 
var isUserTenantMapping = 'false';

$(document).ready(function() {
	
	// 클러스터별/서비스 그룹별 radio 변경 시
	$('input[name="clusterOrServiceGroup"]').change(function () {
		$('#page_loading').removeClass('d-none');
		
		// 클러스터별 선택 시
		if ($('#byCluster').is(':checked')) {
			
			$('.clusterDiv').removeClass('d-none');
			$('.serviceGroupDiv').addClass('d-none');
			$('#reportFilterBtn').attr('onclick', 'reportFilter("cluster")');
			
			selectClusterList();
		}
		
		// 서비스 그룹별 선택 시
		if ($('#byServiceGroup').is(':checked')) {
			
			$('.clusterDiv').addClass('d-none');
			$('.serviceGroupDiv').removeClass('d-none');
			$('#reportFilterBtn').attr('onclick', 'reportFilter("serviceGroup")');
			
			sessionUserApproval > USER_CHECK ? selectServiceGroupList() : selectUserServiceGroupList();
		}
	});
	
	// 클러스터 셀렉트 박스 변경 시
	$('#selectCluster').change(function () {
		var clusterId = $('#selectCluster option:selected').val();
		selectHostList(clusterId);
	});
	
	// 서비스 그룹 셀렉트 박스 변경 시
	$('#selectServiceGroup').change(function () {
		var serviceGroupId = $('#selectServiceGroup option:selected').val();
		selectServiceList(serviceGroupId);
	});
	
	// 주기 변경 시
	$('#selectCycle').change(function() {
		var cycle = $('#selectCycle option:selected').val();
		changeCycle(cycle);
	});
	
	$('#inputDate').val(todayConverter('date'));
	
	// 처음 실행 시 관리자면 클러스터별 보기, 사용자면 서비스 그룹별 보기 실행
	// 사용자는 서비스 그룹별로만 볼 수 있음 (클러스터별/서비스 그룹별 radio 숨김)
	if (sessionUserApproval > USER_CHECK) {
		isUserTenantMapping = 'false';
		
		$('.clusterOrServiceGroupDiv').removeClass('d-none');
		$('#byCluster').click();
	
	} else {
		isUserTenantMapping = 'true';
		
		$('.clusterOrServiceGroupDiv').addClass('d-none');
		$('#byServiceGroup').click();
	}
});

var isFirstSearch = true;

// 주기 변경
function changeCycle(cycle) {
		
	// 일간이면 어제 일자 표시
	if (cycle == 1) {
		$('#inputDate').attr('type', 'date');
		$('#inputDate').val(todayConverter('date'));
	}

	// 주간이면 이번주 표시
	if (cycle == 2) {
		$('#inputDate').attr('type', 'week');
		$('#inputDate').val(todayConverter('week'));
	}

	// 월간이면 이번달 표시
	if (cycle == 3) {
		$('#inputDate').attr('type', 'month');
		$('#inputDate').val(todayConverter('month'));
	}
}

// 클러스터 목록
function selectClusterList() {
	$.ajax({
		url: '/tenant/selectClusterList.do',
		type: 'POST',
		success: function(data) {
			var html = '';
			
			if (data == null || data == '') {
				html += '<option value="0" selected disabled>클러스터가 없습니다.</option>';
			
			} else {
				html += '<option value="clusterAll" selected>전체</option>';
				for (key in data) {
					html += '<option value="' + data[key].clusterID + '">' + data[key].clusterName + '</option>';
				}
			}
			
			$('#selectCluster').empty().append(html);
			
			var clusterId = $('#selectCluster option:selected').val();
			selectHostList(clusterId);
		}
	})
}

// 호스트 목록
function selectHostList(clusterId) {
	$.ajax({
		url: '/status/selectVMHostList.do',
		type: 'POST',
		data: {
			clusterId: clusterId
		},
		success: function(data) {
			var html = '';
			
			if (data == null || data == '') {
				html += '<option value="0" selected disabled>호스트가 없습니니다.</option>';
			
			} else {
				html += '<option value="hostAll" selected>전체</option>';
				for (key in data) {
					html += '<option value="' + data[key].vmHID + '">' + data[key].vmHhostname + '</option>';
				}
			}
			
			$('#selectHost').empty().append(html);
			
			if (isFirstSearch) {
				reportFilter('cluster');
				isFirstSearch = false;
			}
		}
	})
}

// 서비스 그룹 목록
function selectServiceGroupList() {
	$.ajax({
		url: '/tenant/selectTenantList.do',
		type: 'POST',
		success: function(data) {
			var html = '';
			
			if (data == null || data == '') {
				html += '<option value="-2" selected disabled>서비스 그룹이 없습니다.</option>';
			
			} else {
				html += '<option value="" selected>전체</option>';
				for (key in data) {
						html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
				}
				html += '<option value="-1">미배치</option>';
			}
			
			$('#selectServiceGroup').empty().append(html);
			
			var serviceGroupId = $('#selectServiceGroup option:selected').val();
			selectServiceList(serviceGroupId);
		}
	})
}

// 사용자 서비스 그룹 목록
function selectUserServiceGroupList() {
	$.ajax({
		url: '/tenant/selectLoginUserTenantList.do',
		type: 'POST',
		success: function(data) {
			var html = '';
			
			if (data == null || data == '') {
				html += '<option value="-2" selected disabled>서비스 그룹이 없습니다.</option>';
			
			} else {
				html += '<option value="" selected>전체</option>';
				for (key in data) {
					html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
				}
			}
			
			$('#selectServiceGroup').empty().append(html);
			
			var serviceGroupId = $('#selectServiceGroup option:selected').val();
			selectServiceList(serviceGroupId);
		}
	})
}

// 서비스 목록
function selectServiceList(serviceGroupId) {
	if (serviceGroupId == '-2') {
		var html =  '<option value="-2" selected disabled>서비스가 없습니다.</option>';
		
		$('#selectService').empty().append(html);
		
		if (isFirstSearch) {
			reportFilter('serviceGroup');
			isFirstSearch = false;
		}
	
	} else {
		$.ajax({
			url: '/tenant/selectVMServiceListByTenantId.do',
			type: 'POST',
			data: {
				tenantId: serviceGroupId,
				isUserTenantMapping : isUserTenantMapping
			},
			success: function(data) {
				var html = '';
				
				if (data == null || data == '') {
					html += '<option value="-2" selected disabled>서비스가 없습니다.</option>';
			
				} else if (serviceGroupId == -1) {
					html += '<option value="-1" selected disabled>미배치</option>';
					
				} else {
					html += '<option value="" selected>전체</option>';
					for (key in data) {
						html += '<option value="' + data[key].vmServiceID + '">' + data[key].vmServiceName + '</option>';
					}
				}
				
				$('#selectService').empty().append(html);
				
				if (isFirstSearch) {
					reportFilter('serviceGroup');
					isFirstSearch = false;
				}
			}
		})
	}
}

// 결과 조회
function reportFilter(category) {
	var cycle = $('#selectCycle option:selected').val();
	var inputDate = $('#inputDate').val();
	
	// 입력 체크
	if (!inputDate) {
		alert('일자를 입력해 주세요.');
		$('#inputDate').focus();
		return false;
	}
	
	// 일간/월간
	if (cycle == 1 || cycle == 3) {
		var sdt = new Date();
		var edt = new Date(inputDate);
		var dateDiff = Math.ceil((edt.getTime() - sdt.getTime())/(1000*3600*24));
		
		if (dateDiff > 0) {
			alert('미래의 일자는 선택할 수 없습니다. 다시 선택해 주세요.');
			return false;
		}
		
		if (cycle == 1 && dateDiff < -31) {
			alert('일간 보고서는 최대 30일까지 조회할 수 있습니다.');
			return false;
		}
		
		if (cycle == 3 && dateDiff < -366) {
			alert('월간 보고서는 최대 1년까지 조회할 수 있습니다.');
			return false;
		}
	}

	// 주간
	if (cycle == 2) {
		var sdt = todayConverter('week').replace('W', '').split('-');
		sdt = Number(sdt[0] + sdt[1]);
		var edt = inputDate.replace('W', '').split('-');
		edt = Number(edt[0] + edt[1]);
		var weekDiff = edt - sdt;
		
		if (weekDiff > 0) {
			alert('미래의 일자는 선택할 수 없습니다. 다시 선택해 주세요.');
			return false;
		}
		
		if (weekDiff < -14) {
			alert('주간 보고서는 최대 14주까지 조회할 수 있습니다.');
			return false;
		}
	}
	
	// 조회 실행
	var tableReport = $('#tableReport').DataTable();
	tableReport.destroy();
	
	// 클러스터별
	if (category == 'cluster') {
		$('#name1').html('클러스터');
		$('#name2').html('호스트');
		
		var clusterId = $('#selectCluster option:selected').val();
		var hostId = $('#selectHost option:selected').val();
		
		getReportCluster(cycle, clusterId, hostId, inputDate);
	}
	
	// 서비스 그룹별
	if (category == 'serviceGroup') {
		$('#name1').html('서비스 그룹');
		$('#name2').html('서비스');
		
		var serviceGroupId = $('#selectServiceGroup option:selected').val();
		var serviceId = $('#selectService option:selected').val();
		
		getReportserviceGroup(cycle, serviceGroupId, serviceId, inputDate);
	}
}