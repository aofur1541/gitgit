$(document).ready(function() {
	selectClusterList();
	
	// 주기 변경 시
	$('#selectCycle').change(function() {
		var cycle = $('#selectCycle option:selected').val();
		changeCycle(cycle);
	});
	
	$('#inputDate').val(todayConverter('date'));
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
		url: "/tenant/selectClusterList.do",
		type: "POST",
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
		url: "/status/selectVMHostList.do",
		type: "POST",
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
		}
	})
	
	if (isFirstSearch) {
		reportFilter();
		isFirstSearch = false;
	}
}

// 테이블 조회
function reportFilter() {
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
	var clusterId = $('#selectCluster option:selected').val();
	var tableReport = $('#tableReport').DataTable();
	tableReport.destroy();
	
	getReport(cycle, clusterId, inputDate);
}