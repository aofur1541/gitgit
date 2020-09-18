<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/refreshMaintain.js"></script>
		<script src="${path}/resources/PROM_JS/adminCheck.js"></script>
	
		<script type="text/javascript">
			$(document).ready(function() {
				getUserWorkList()
				getAdminWorkList()
				getVMApproveWorkList();
			});
			
			function getAdminWorkList() {
				var adminWorkTable = $("#adminWorkTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/log/selectAdminWorkLogList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "sReceive"},
							{"data": "name"},
							{"data": "sTarget"},
							{"data" : "sKeyword",
								render: function (data, type, row) {
									if (data == 'Create') {
										data = '생성';
									} else if (data == 'Update'){
										data = '변경';
									} else if (data == 'Delete'){
										data = '삭제';
									} else if (data == 'Mapping'){
										data = '매핑';
									} else if (data == 'Select'){
										data = '조회';
									}
									return data;
								}	
							},
							{"data": "sContext"},
							{"data": "nCategory",
								render: function (data, type, row) {
									if (data == 0) {
										data = '정상';
									} else {
										data = '비정상';
									}
									return data;
								}
							},
							{"data": "sSendDay"}
						],
						order: [
							[6, "desc"]
						],
						lengthMenu: [
							[5, 10, 25, 50, -1],
							[5, 10, 25, 50, "All"]
						],
						pageLength: 10,
						responsive: true,
						columnDefs: [{
							responsivePriority: 1,
							targets: 0
						}, {
							responsivePriority: 2,
							targets: -1
						}],
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
									title: "관리자 작업 이력"
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "관리자 작업 이력"
								}
							]
						}]
					});
			}
			
			function getUserWorkList() {
				var userWorkTable = $("#userWorkTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/log/selectUserWorkLogList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "sReceive"},
							{"data": "name"},
							{"data": "sTarget"},
							{"data" : "sKeyword",
								render: function (data, type, row) {
									if (data == 'Create') {
										data = '생성';
									} else if (data == 'Update'){
										data = '변경';
									} else if (data == 'Delete'){
										data = '삭제';
									} else if (data == 'Mapping'){
										data = '매핑';
									} else if (data == 'Select'){
										data = '조회';
									}
									return data;
								}	
							},
							{"data": "sContext"},
							{"data": "nCategory",
								render: function (data, type, row) {
									if (data == 0) {
										data = '정상';
									} else {
										data = '비정상';
									}
									return data;
								}
							},
							{"data": "sSendDay"}
						],
						order: [
							[6, "desc"]
						],
						lengthMenu: [
							[5, 10, 25, 50, -1],
							[5, 10, 25, 50, "All"]
						],
						pageLength: 10,
						responsive: true,
						columnDefs: [{
							responsivePriority: 1,
							targets: 0
						}, {
							responsivePriority: 2,
							targets: -1
						}],
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
									title: "사용자 작업 이력"
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "사용자 작업 이력"
								}
							]
						}]
					});
			}
			
			function getVMApproveWorkList() {
				var approveTable = $("#approveTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/log/selectApproveLogList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "sReceive"},
							{"data": "name"},
							{"data": "sTarget"},
							{"data" : "sKeyword",
								render: function (data, type, row) {
									if (data == 'Approval') {
										data = '승인';
									} else if (data == 'Request'){
										data = '신청';
									} else if (data == 'Return'){
										data = '반려';
									} else if (data == 'Hold'){
										data = '보류';
									}
									return data;
								}	
							},
							{"data": "sContext"},
							{"data": "nCategory",
								render: function (data, type, row) {
									if (data == 2) {
										data = '성공';
									} else if (data == 3) {
										data = '실패';
									}
									return data;
								}
							},
							{"data": "sSendDay"}
						],
						order: [
							[6, "desc"]
						],
						lengthMenu: [
							[5, 10, 25, 50, -1],
							[5, 10, 25, 50, "All"]
						],
						pageLength: 10,
						responsive: true,
						columnDefs: [{
							responsivePriority: 1,
							targets: 0
						}, {
							responsivePriority: 2,
							targets: -1
						}],
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
									title: "신청 승인 이력"
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "신청 승인 이력"
								}
							]
						}]
					});
			}
		</script>
	</head>

	<body>
		<input id="radio1" type="radio" name="css-tabs" checked>
		<input id="radio2" type="radio" name="css-tabs">
		<input id="radio3" type="radio" name="css-tabs">
		
		<div id="tabs">
			<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-user"></i><span class="tabs-title">관리자 작업 이력</span></label>
			<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-user-tie"></i><span class="tabs-title">사용자 작업 이력</span></label>
			<label id="tab3" for="radio3" onclick="getContentTab(3)"><i class="icon-bell2"></i><span class="tabs-title">신청 승인 이력</span></label>
		</div>
		
		<div id="content">
			<section id="content1">
				<div class="card bg-dark mb-0 table-type-5-6">
					<table id="adminWorkTable" class="promTable hover" style="width:100%;">
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
			</section>
			<section id="content2">
				<div class="card bg-dark mb-0 table-type-5-6">
					<table id="userWorkTable" class="promTable hover" style="width:100%;">
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
			</section>
			<section id="content3">
				<div class="card bg-dark mb-0 table-type-5-6">
					<table id="approveTable" class="promTable hover" style="width:100%;">
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
			</section>
		</div>
	</body>
</html>