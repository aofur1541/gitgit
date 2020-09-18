<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/adminCheck.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				allStorageList();
				localDataStoreList();
			});
	
			function allStorageList() {
	
				var allDatastoreTable = $("#allDatastoreTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/menu/Mallstorage_list.do",
							"dataSrc": "",
						},
						columns: [{
								"data": "st_name"
							},
							{
								"data": "st_Allca",
								render: function(data, type, row) {
									data = data.toLocaleString() + ' GB';
									return data;
								}
							},
							{
								"data": "st_space",
								render: function(data, type, row) {
									data = data.toLocaleString() + ' GB';
									return data;
								}
							},
							{
								"data": "st_Useca",
								render: function(data, type, row) {
									data = data.toLocaleString() + ' GB';
									return data;
								}
							},
							{
								"data": "st_Allca",
								"orderable": false,
								render: function(data, type, row) {
									var percent = Math.floor(row.st_Allca - row.st_space);
									var percentResult = percent / row.st_Allca * 100;
	
									var html = '';
	
									if (isNaN(percentResult)) {
										data = 0;
									} else {
										data = percentResult.toFixed(1);
									}
	
									html += '<div class="progress">';
	
									if (Math.floor(percentResult) >= 90) {
										html += '<div class="progress-bar bg-danger" style="width: ' + data + '%">';
	
									} else if (Math.floor(percentResult) <= 89 && Math.floor(percentResult) >= 80) {
										html += '<div class="progress-bar bg-orange-400" style="width: ' + data + '%">';
	
									} else {
										html += '<div class="progress-bar bg-green" style="width: ' + data + '%">';
									}
									html += '</div>';
									html += '</div>';
	
									return html;
								}
							},
							{
								"data": "st_Allca",
								render: function(data, type, row) {
									var percent = Math.floor(row.st_Allca - row.st_space);
									var percentResult = percent / row.st_Allca * 100;
									if (isNaN(percentResult)) {
										data = 0 + ' %';
									} else {
										data = percentResult.toFixed(1) + ' %';
									}
									return data;
								}
							}
						],
						lengthMenu: [
							[5, 10, 25, 50, -1],
							[5, 10, 25, 50, "All"]
						],
						pageLength: 5,
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
									title: "데이터스토어 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 5]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "데이터스토어 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 5]
									}
								}
							]
						}]
					});
			}
	
			function tgStorageList() {
	
				var allDatastoreTable = $("#allDatastoreTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/menu/Mallstorage_list.do",
							"dataSrc": "",
						},
						columns: [{
								"data": "st_name"
							},
							{
								"data": "st_Allca",
								render: function(data, type, row) {
									data = (data / 1024).toFixed(2) + ' TB';
									return data;
								}
							},
							{
								"data": "st_space",
								render: function(data, type, row) {
									data = (data / 1024).toFixed(2) + ' TB';
									return data;
								}
							},
							{
								"data": "st_Useca",
								render: function(data, type, row) {
									data = (data / 1024).toFixed(2) + ' TB';
									return data;
								}
							},
							{
								"data": "st_Allca",
								"orderable": false,
								render: function(data, type, row) {
									var percent = Math.floor(row.st_Allca - row.st_space);
									var percentResult = percent / row.st_Allca * 100;
	
									var html = '';
	
									if (isNaN(percentResult)) {
										data = 0;
									} else {
										data = percentResult.toFixed(1);
									}
	
									html += '<div class="progress">';
	
									if (Math.floor(percentResult) >= 90) {
										html += '<div class="progress-bar bg-danger" style="width: ' + data + '%">';
	
									} else if (Math.floor(percentResult) <= 89 && Math.floor(percentResult) >= 80) {
										html += '<div class="progress-bar bg-orange-400" style="width: ' + data + '%">';
	
									} else {
										html += '<div class="progress-bar bg-green" style="width: ' + data + '%">';
									}
									html += '</div>';
									html += '</div>';
	
									return html;
								}
							},
							{
								"data": "st_Allca",
								render: function(data, type, row) {
									var percent = Math.floor(row.st_Allca - row.st_space);
									var percentResult = percent / row.st_Allca * 100;
									if (isNaN(percentResult)) {
										data = 0 + ' %';
									} else {
										data = percentResult.toFixed(1) + ' %';
									}
									return data;
								}
							}
						],
						lengthMenu: [
							[5, 10, 25, 50, -1],
							[5, 10, 25, 50, "All"]
						],
						pageLength: 5,
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
									title: "데이터스토어 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 5]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "데이터스토어 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 5]
									}
								}
							]
						}]
					});
			}
	
			function localDataStoreList() {
	
				var localDatastoreTable = $("#localDatastoreTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/jquery/localDataStoreList.do",
							"dataSrc": "",
						},
						columns: [{
								"data": "st_name"
							},
							{
								"data": "st_Allca",
								render: function(data, type, row) {
									data = data.toLocaleString() + ' GB';
									return data;
								}
							},
							{
								"data": "st_space",
								render: function(data, type, row) {
									data = data.toLocaleString() + ' GB';
									return data;
								}
							},
							{
								"data": "st_Useca",
								render: function(data, type, row) {
									data = data.toLocaleString() + ' GB';
									return data;
								}
							},
							{
								"data": "st_Allca",
								"orderable": false,
								render: function(data, type, row) {
									var percent = Math.floor(row.st_Allca - row.st_space);
									var percentResult = percent / row.st_Allca * 100;
	
									var html = '';
	
									if (isNaN(percentResult)) {
										data = 0;
									} else {
										data = percentResult.toFixed(1);
									}
	
									html += '<div class="progress">';
	
									if (Math.floor(percentResult) >= 90) {
										html += '<div class="progress-bar bg-danger" style="width: ' + data + '%">';
	
									} else if (Math.floor(percentResult) <= 89 && Math.floor(percentResult) >= 80) {
										html += '<div class="progress-bar bg-orange-400" style="width: ' + data + '%">';
	
									} else {
										html += '<div class="progress-bar bg-green" style="width: ' + data + '%">';
									}
									html += '</div>';
									html += '</div>';
	
									return html;
								}
							},
							{
								"data": "st_Allca",
								render: function(data, type, row) {
									var percent = Math.floor(row.st_Allca - row.st_space);
									var percentResult = percent / row.st_Allca * 100;
									if (isNaN(percentResult)) {
										data = 0 + ' %';
									} else {
										data = percentResult.toFixed(1) + ' %';
									}
									return data;
								}
							}
						],
						lengthMenu: [
							[5, 10, 25, 50, -1],
							[5, 10, 25, 50, "All"]
						],
						pageLength: 5,
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
									title: "데이터스토어 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 5]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "데이터스토어 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 5]
									}
								}
							]
						}]
					});
			}
	
			function localDataStoreTBList() {
	
				var localDatastoreTable = $("#localDatastoreTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/jquery/localDataStoreList.do",
							"dataSrc": "",
						},
						columns: [{
								"data": "st_name"
							},
							{
								"data": "st_Allca",
								render: function(data, type, row) {
									data = (data / 1024).toFixed(2) + ' TB';
									return data;
								}
							},
							{
								"data": "st_space",
								render: function(data, type, row) {
									data = (data / 1024).toFixed(2) + ' TB';
									return data;
								}
							},
							{
								"data": "st_Useca",
								render: function(data, type, row) {
									data = (data / 1024).toFixed(2) + ' TB';
									return data;
								}
							},
							{
								"data": "st_Allca",
								"orderable": false,
								render: function(data, type, row) {
									var percent = Math.floor(row.st_Allca - row.st_space);
									var percentResult = percent / row.st_Allca * 100;
	
									var html = '';
	
									if (isNaN(percentResult)) {
										data = 0;
									} else {
										data = percentResult.toFixed(1);
									}
	
									html += '<div class="progress">';
	
									if (Math.floor(percentResult) >= 90) {
										html += '<div class="progress-bar bg-danger" style="width: ' + data + '%">';
	
									} else if (Math.floor(percentResult) <= 89 && Math.floor(percentResult) >= 80) {
										html += '<div class="progress-bar bg-orange-400" style="width: ' + data + '%">';
	
									} else {
										html += '<div class="progress-bar bg-green" style="width: ' + data + '%">';
									}
									html += '</div>';
									html += '</div>';
	
									return html;
								}
							},
							{
								"data": "st_Allca",
								render: function(data, type, row) {
									var percent = Math.floor(row.st_Allca - row.st_space);
									var percentResult = percent / row.st_Allca * 100;
									if (isNaN(percentResult)) {
										data = 0 + ' %';
									} else {
										data = percentResult.toFixed(1) + ' %';
									}
									return data;
								}
							}
						],
						lengthMenu: [
							[5, 10, 25, 50, -1],
							[5, 10, 25, 50, "All"]
						],
						pageLength: 5,
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
									title: "데이터스토어 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 5]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "데이터스토어 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 5]
									}
								}
							]
						}]
					});
			}
	
			function unitTypeCheck() {
				setTimeout(function() {
					var unit = $("#unitCheck").val();
	
					if (unit == 'GB') {
						var allDatastoreTable = $('#allDatastoreTable').DataTable();
						allDatastoreTable.destroy();
	
						allStorageList();
	
						var localDatastoreTable = $('#localDatastoreTable').DataTable();
						localDatastoreTable.destroy();
	
						localDataStoreList();
	
					} else if (unit == 'TB') {
						var allDatastoreTable = $('#allDatastoreTable').DataTable();
						allDatastoreTable.destroy();
	
						tgStorageList();
	
						var localDatastoreTable = $('#localDatastoreTable').DataTable();
						localDatastoreTable.destroy();
	
						localDataStoreTBList();
					}
				}, 50)
			}
		</script>
	</head>
	
	<body>
		<div class="card bg-dark mb-0 table-type-3 table-type-5-3">
			<div class="table-filter-light">
				<div class="col-xl-1 col-sm-1">
					<select class="form-control select" onchange="unitTypeCheck()" id="unitCheck" data-fouc>
						<option value="GB">GB</option>
						<option value="TB">TB</option>
					</select>
				</div>
			</div>
			<div class="border-bottom-light">
				<table id="allDatastoreTable" class="promTable hover" style="width:100%;">
					<thead>
						<tr>
							<th>공용 데이터스토어명 (LUN)</th>
							<th>총 용량</th>
							<th>가용 용량</th>
							<th>할당 용량</th>
							<th>&emsp;&emsp;&emsp;&emsp;</th>
							<th>사용률</th>
						</tr>
					</thead>
				</table>
			</div>
			<table id="localDatastoreTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>로컬 데이터스토어명 (LUN)</th>
						<th>총 용량</th>
						<th>가용 용량</th>
						<th>할당 용량</th>
						<th>&emsp;&emsp;&emsp;&emsp;</th>
						<th>사용률</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>