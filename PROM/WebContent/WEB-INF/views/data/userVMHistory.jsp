<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			$(document).ready(function() {
				getUserVMCreateGenerating();
			});
	
			function getUserVMCreateGenerating() {
				var realChk = 0;
				var realVal = '';
	
				var userVMHistoryTable = $("#userVMHistoryTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/log/selectUserVMLogList.do",
							"dataSrc": "",
						},
						columns: [{
								"data": "vmName"
							},
							{
								"data": "distinction",
								render: function(data, type, row) {
									if (data == 1) {
										data = '생성';
									} else if (data == 2) {
										data = '변경';
									} else if (data == 3) {
										data = '삭제';
									}
									return data;
								}
							},
							{
								"data": "finishStatus",
								render: function(data, type, row) {
									if (data == 0) {
										data = '진행중';
									} else if (data == 1) {
										data = '성공';
									} else if (data == 3) {
										data = '비정상 종료';
									} else if (row.sErrorCode != null) {
										data = '실패';
									}
									return data;
								}
							},
							{
								"data": "sErrorCode",
								render: function(data, type, row) {
									if (row.finishStatus == 0 && data == null) {
										realChk = 1;
									}
	
									if (data == null) {
										data = row.createStatus;
									} else {
										data = data;
									}
									return data;
								}
							},
							{
								"data": "dStartTime"
							},
							{
								"data": "dEndTime"
							},
							{
								"data": "finishStatus",
								render: function(data, type, row) {
									if (data == 1) {
										var startTime = new Date(row.dStartTime);
										var endTime = new Date(row.dEndTime);
	
										var result = (endTime.getTime() - startTime.getTime()) / 1000 / 60;
	
										if (result < 1) {
											data = result.toFixed(2) + ' 초';
										} else {
											data = Math.floor(result) + ' 분';
										}
									} else if (data == 2) {
										data = '에러 발생';
									} else {
										data = 'null';
									}
									return data;
								}
							},
						],
						order: [
							[4, "desc"]
						],
						lengthMenu: [
							[5, 10, 25, 50, -1],
							[5, 10, 25, 50, "All"]
						],
						pageLength: 10,
						responsive: true,
						dom: "<'datatables-header'<'row-padding-0'lf><'row-padding-0'B>>" + "<'datatables-body'rt>" + "<'datatables-footer'ip>",
						buttons: [{
							extend: "collection",
							text: "<i class='icon-import'></i><span class='ml-2'>내보내기</span>",
							className: "btn bg-prom dropdown-toggle",
							buttons: [{
									extend: "csvHtml5",
									charset: "UTF-8",
									bom: true,
									text: "CSV",
									title: "사용자 가상머신 이력",
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "사용자 가상머신 이력",
								}
							]
						}]
					});
				setTimeout(function() {
					if (realChk == 1) {
						realVal = setInterval(function() {
							userVMHistoryTable.ajax.reload(null, false);
							if (realChk == 0) {
								clearInterval(realVal);
								window.parent.location.reload();
							}
							realChk = 0;
						}, 5000)
					} else {
						clearInterval(realVal);
					}
				}, 300)
			}
		</script>
	</head>
	<body>
		<div class="card bg-dark mb-0 table-type-5-6">
			<table id="userVMHistoryTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>가상머신명</th>
						<th>작업 구분</th>
						<th>상태</th>
						<th>작업 내용/실패 사유</th>
						<th>시작 일시</th>
						<th>완료 일시</th>
						<th>수행 시간</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>