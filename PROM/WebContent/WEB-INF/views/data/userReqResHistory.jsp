<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			$(document).ready(function() {
				getUserApplyHistoryList();
			});
	
			function getUserApplyHistoryList() {
				var userApplyTable = $("#userApplyTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/log/selectUserApplyLogList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "sReceive"},
							{"data": "name"},
							{"data": "sTarget"},
							{"data": "sKeyword",
								render: function(data, type, row) {
									if (data == 'Approval') {
										data = '승인';
									} else if (data == 'Request') {
										data = '신청';
									} else if (data == 'Return') {
										data = '반려';
									} else if (data == 'Hold') {
										data = '보류';
									}
									return data;
								}
							},
							{"data": "sContext"},
							{"data": "nCategory",
								render: function(data, type, row) {
									if (data == 2) {
										data = '완료';
									} else if (data == 2) {
										data = '실패';
									}
									return data;
								}
							},
							{"data": "sSendDay"},
						],
						order: [
							[6, "desc"]
						],
						language: {
							infoFiltered: "",
						},
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
									title: "사용자 신청 승인 이력",
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "사용자 신청 승인 이력",
								}
							]
						}]
					});
			}
		</script>
	</head>
	<body>
		<div class="card bg-dark mb-0 table-type-5-6">
			<table id="userApplyTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>대상</th>
						<th>작업 구분</th>
						<th>상세 정보</th>
						<th>작업 결과</th>
						<th>일시</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>