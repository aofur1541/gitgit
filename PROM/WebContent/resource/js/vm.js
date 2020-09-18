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
			
			$('#name1').html('클러스터');
			$('#name2').html('호스트');
			
			selectClusterList();
		}
		
		// 서비스 그룹별 선택 시
		if ($('#byServiceGroup').is(':checked')) {
			
			$('.clusterDiv').addClass('d-none');
			$('.serviceGroupDiv').removeClass('d-none');
			
			$('#name1').html('서비스 그룹');
			$('#name2').html('서비스');
			
			sessionUserApproval > USER_CHECK ? selectServiceGroupList() : selectUserServiceGroupList();
		}
	});
	
	// 클러스터 select box 변경 시
	$('#selectCluster').change(function () {
		var clusterId = $('#selectCluster option:selected').val();
		selectHostList(clusterId);
	});
	
	$('#selectHost').change(function () {
		tableReload('cluster');
	});
	
	// 서비스 그룹 select box 변경 시
	$('#selectServiceGroup').change(function () {
		var serviceGroupId = $('#selectServiceGroup option:selected').val();
		selectServiceList(serviceGroupId);
	});
	
	$('#selectService').change(function () {
		tableReload('serviceGroup');
	});
	
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
})

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
			tableReload('cluster');
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
		tableReload('serviceGroup');
	
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
				tableReload('serviceGroup');
			}
		})
	}
}

// 테이블 새로고침
function tableReload(category) {
	var tableVM = $('#tableVM').DataTable();
	tableVM.destroy();
	
	// 클러스터별
	if (category == 'cluster') {
		var clusterId = $('#selectCluster option:selected').val();
		var hostId = $('#selectHost option:selected').val();
		
		getVMListCluster(clusterId, hostId);
	}
	
	// 서비스 그룹별
	if (category == 'serviceGroup') {
		var serviceGroupId = $('#selectServiceGroup option:selected').val();
		var serviceId = $('#selectService option:selected').val();
		
		getVMListTenant(serviceGroupId, serviceId);
	}
}