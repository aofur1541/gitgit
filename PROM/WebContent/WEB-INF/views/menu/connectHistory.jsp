<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/refreshMaintain.js"></script>
		<script src="${path}/resources/PROM_JS/adminCheck.js"></script>
	
		<script type="text/javascript">
			$(document).ready(function() {
				getAdminConnectList();
				getUserConnectList();
			});
			
			function getAdminConnectList() {
				var adminConnectTable = $("#adminConnectTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/log/selectAdminConnectLogList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "sReceive"},
							{"data": "sTarget"},
							{"data" : "sKeyword",
								render: function (data, type, row) {
									if (data == 'Login') {
										data = '로그인';
									} else if (data == 'Logout'){
										data = '로그아웃';
									}
									return data;
								}	
							},
							{"data": "sContext"},
							{"data" : "nCategory",
								render: function (data, type, row) {
									if (data == 0) {
										data = '성공';
									} else {
										data = '실패';
									}
									return data;
								}	
							},
							{"data": "sSendDay"}
						],
						order: [
							[5, "desc"]
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
									title: "관리자 접속 이력"
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "관리자 접속 이력"
								}
							]
						}]
					});
			}
			
			function getUserConnectList() {
				var userConnectTable = $("#userConnectTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/log/selectUserConnectLogList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "sReceive"},
							{"data": "sTarget"},
							{"data" : "sKeyword",
								render: function (data, type, row) {
									if (data == 'Login') {
										data = '로그인';
									} else if (data == 'Logout'){
										data = '로그아웃';
									}
									return data;
								}	
							},
							{"data": "sContext"},
							{"data" : "nCategory",
								render: function (data, type, row) {
									if (data == 0) {
										data = '성공';
									} else {
										data = '실패';
									}
									return data;
								}	
							},
							{"data": "sSendDay"}
						],
						order: [
							[5, "desc"]
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
									title: "사용자 접속 이력"
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "사용자 접속 이력"
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
		
		<div id="tabs">
			<label id="tab1" for="radio1" onclick="getContentTab(1)"><i class="icon-user"></i><span class="tabs-title">관리자 접속 이력</span></label>
			<label id="tab2" for="radio2" onclick="getContentTab(2)"><i class="icon-user-tie"></i><span class="tabs-title">사용자 접속 이력</span></label>
		</div>
		
		<div id="content">
			<section id="content1">
				<div class="card bg-dark mb-0 table-type-5-6">
					<table id="adminConnectTable" class="promTable hover" style="width:100%;">
						<thead>
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>접속 구분</th>
								<th>상세 정보</th>
								<th>상태</th>
								<th>일시</th>
							</tr>
						</thead>
					</table>
				</div>
			</section>
			<section id="content2">
				<div class="card bg-dark mb-0 table-type-5-6">
					<table id="userConnectTable" class="promTable hover" style="width:100%;">
						<thead>
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>접속 구분</th>
								<th>상세 정보</th>
								<th>상태</th>
								<th>일시</th>
							</tr>
						</thead>
					</table>
				</div>
			</section>
		</div>
	</body>
</html>