function changeDateType() {
				var dateType = $("#dateSB option:selected").val();
	
				if (dateType == "date") {
					$("#dateInput").attr("type", "date");
					$("#dateInput").val(getDatetimeSet.getFullYear() + "-" + leadingZeros(getDatetimeSet.getMonth() + 1, 2) + "-" + leadingZeros(getDatetimeSet.getDate(), 2))
				} else if (dateType == "week") {
					$("#dateInput").attr("type", "week");
				} else {
					$("#dateInput").attr("type", "month");
					$("#dateInput").val(getDatetimeSet.getFullYear() + "-" + leadingZeros(getDatetimeSet.getMonth() + 1, 2));
				}
			}

function getClusterInfo() {
	$.ajax({
		url: "/tenant/selectClusterList.do",
		success: function(data) {
			var html = '';

			html += '<option value="clusterAll" selected>클러스터 전체</option>';
			for (key in data) {
				html += '<option value=' + data[key].clusterName + '>' + data[key].clusterName + '</option>';
			}
			$("#clusterSB").empty();
			$("#clusterSB").append(html);
		}
	})
}

function hostReportFilter() {
	var dateInput = $("#dateInput").val();
	var dateSB = $("#dateSB option:selected").val();
	var datecalc = dateDiff(dateInput, new Date())
	if (!dateInput) {
		alert("검색 할 날짜를 선택 하십시오.");
		return false;
	} else if (dateSB == 'date' && datecalc > 31) {
		alert("일 보고서는 최대 30일까지만 조회 가능합니다.");
		return false;
	} else if (dateSB == 'week' && datecalc > 99) {
		alert("주 보고서는 최대 14주까지만 조회 가능합니다.");
		return false;
	} else if (dateSB == 'month' && datecalc > 366) {
		alert("월 보고서는 최대 1년까지만 조회 가능합니다.");
		return false;
	} else {

		var myTable = $('#hostReportTable').DataTable();
		myTable.destroy();

		getHostReport();
	}
}