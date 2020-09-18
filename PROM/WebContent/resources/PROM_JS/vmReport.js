function dateweekdiff(weekdate) {
				var weekindex = weekdate.replace('-', '').replace('W', '');
				return weekindex;
			}

function vmReportFilter() {
	
	var dateSB = $("#dateSB option:selected").val();
	var tenantSB = $("#tenantSB option:selected").val();
	var serviceSB = $("#serviceInTenantSB option:selected").val();
	var dateInput = $("#dateInput").val();
	var datecalc = dateDiff(dateInput, new Date());
	var timeset = 0;

	if (!dateInput) {
		alert("검색 할 날짜를 선택 하십시오.");
		return false;
	} else if (dateSB == 'date' && datecalc > 31) {
		alert("일 보고서는 최대 30일까지만 조회 가능합니다.");
		return false;
	} else if (dateSB == 'week' && timeset == 4) {
		if (dateweekdiff(dateInput)) {
			alert("주 보고서는 최대 14주까지만 조회 가능합니다.");
			return false;
		}
	} else if (dateSB == 'month' && datecalc > 366) {
		alert("월 보고서는 최대 1년까지만 조회 가능합니다.");
		return false;
	} else {
		var myTable = $('#vmReportTable').DataTable();
		myTable.destroy();

		getVMReport();
	}
}

function getUserTenantList() {
	
	$.ajax({

		url: "/tenant/selectLoginUserTenantList.do",
		success: function(data) {
			var html = '';
			for (key in data) {
				html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
			}

			$("#tenantSB").empty();
			$("#tenantSB").append(html);
			serviceInTenant();
		}
	})
}

function serviceInTenant() {

	var tenantsID = $("#tenantSB option:selected").val();

	$.ajax({
		data: {
			tenantId: tenantsID
		},
		url: "/tenant/selectVMServiceListByTenantId.do",
		success: function(data) {
			var html = '';
			if (data == null || data == '') {
				html += '<option value="0" value2="서비스없음" selected>서비스가 없습니다.</option>';
			} else {
				html += '<option value="-1" value2="서비스 전체" selected>서비스 전체</option>';
				for (key in data) {
					html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].vmServiceName + '>' + data[key].vmServiceName + '</option>';
				}
			}
			$("#serviceInTenantSB").empty();
			$("#serviceInTenantSB").append(html);
		}
	})
}

function changeDateType() {
	var dateType = $("#dateSB option:selected").val();

	if (dateType == "date") {
		$("#dateInput").attr("type", "date");
		$("#dateInput").val(getDatetimeSet.getFullYear() + "-" + leadingZeros(getDatetimeSet.getMonth() + 1, 2) + "-" + leadingZeros(getDatetimeSet.getDate(), 2));
	} else if (dateType == "week") {
		$("#dateInput").attr("type", "week");
	} else {
		$("#dateInput").attr("type", "month");
		$("#dateInput").val(getDatetimeSet.getFullYear() + "-" + leadingZeros(getDatetimeSet.getMonth() + 1, 2));
	}
}

function getTenantList() {
	$.ajax({
		url: "/tenant/selectTenantList.do",
		success: function(data) {
			var html = '';

			html += '<option value="0" value2="테넌트 전체" selected>테넌트 전체</option>';
			for (key in data) {
				html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
			}
			$("#tenantSB").empty();
			$("#tenantSB").append(html);
			serviceInTenant();
		}
	})
}
