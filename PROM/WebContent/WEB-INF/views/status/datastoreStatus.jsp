<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp" %>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
	
	<style type="text/css">
		#tableAllDatastore_wrapper {
			margin-bottom: 50px;
		}
	</style>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>
		
		<!-- 본문 시작 -->
		<div class="content">
		
			<!-- 공용 데이터스토어 테이블 -->
			<table id="tableAllDatastore" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>공용 데이터스토어</th>
						<th>총 용량</th>
						<th>가용 용량</th>
						<th>할당 용량</th>
						<th>사용률 그래프</th>
						<th>사용률</th>
					</tr>
				</thead>
			</table>
			
			<!-- 로컬 데이터스토어 테이블 -->
			<table id="tableLocalDatastore" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>로컬 데이터스토어</th>
						<th>총 용량</th>
						<th>가용 용량</th>
						<th>할당 용량</th>
						<th>사용률 그래프</th>
						<th>사용률</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>
	
	<script src='${path}/resource/js/sidebar.js'></script>
	<script type='text/javascript'>
		$(document).ready(function() {
			getAllDatastoreGBList();
			getLocalDatastoreGBList();
		});
		
		// 공용 데이터스토어 테이블 (GB)
		function getAllDatastoreGBList() {
			var tableAllDatastore = $('#tableAllDatastore').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B<"unitB allUnitB">>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/status/selectPublicDatastoreList.do',
					type: 'POST',
					dataSrc: '',
				},
				columns: [
					{data: 'stName'},
					{data: 'stAllca', render: function(data, type, row) {
						data = data.toLocaleString() + ' GB';
						return data;
					}},
					{data: 'stSpace', render: function(data, type, row) {
						data = data.toLocaleString() + ' GB';
						return data;
					}},
					{data: 'stUseca', render: function(data, type, row) {
						data = data.toLocaleString() + ' GB';
						return data;
					}},
					{data: 'stAllca', 
						orderable: false,
						render: function(data, type, row) {
						var html = '';
						var allotment = Math.floor(data - row.stSpace);
						var percentage = allotment / data * 100;
						
						if (isNaN(percentage)) {
							data = 0;
						} else {
							data = percentage.toFixed(1);
						}
						
						html += '<div class="progress">';
						
						if (Math.floor(percentage) >= 90) {
							html += '<div class="progress-bar bg-danger" style="width: ' + data + '%"></div>';
						
						} else if (Math.floor(percentage) <= 89 && Math.floor(percentage) >= 80) {
							html += '<div class="progress-bar bg-yellow" style="width: ' + data + '%"></div>';

						} else {
							html += '<div class="progress-bar bg-green" style="width: ' + data + '%"></div>';
						}
						
						html += '</div>';

						return html;
					}},
					{data: 'stAllca', render: function(data, type, row) {
						var html = '';
						var allotment = Math.floor(data - row.stSpace);
						var percentage = allotment / data * 100;
						
						if (isNaN(percentage)) {
							data = 0 + ' %';
						} else {
							data = percentage.toFixed(1) + ' %';
						}
						
						return data;
					}}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[5, 10, 25, 50, -1], ['5', '10', '25', '50', '전체']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '데이터스토어 현황',
						exportOptions: {columns: [0, 1, 2, 3, 5]}
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '데이터스토어 현황',
						exportOptions: {columns: [0, 1, 2, 3, 5]}
					}]
				}, {
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}, {
					extend: 'colvis',
					text: '테이블 편집',
					className: 'btn colvisBtn'
				}]
			});
			
			tableAllDatastoreButton();
		}
		
		// 공용 데이터스토어 테이블 (TB)
		function getAllDatastoreTBList() {
			var tableAllDatastore = $('#tableAllDatastore').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B<"unitB allUnitB">>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/status/selectPublicDatastoreList.do',
					type: 'POST',
					dataSrc: '',
				},
				columns: [
					{data: 'stName'},
					{data: 'stAllca', render: function(data, type, row) {
						data = (data / 1024).toFixed(2) + ' TB';
						return data;
					}},
					{data: 'stSpace', render: function(data, type, row) {
						data = (data / 1024).toFixed(2) + ' TB';
						return data;
					}},
					{data: 'stUseca', render: function(data, type, row) {
						data = (data / 1024).toFixed(2) + ' TB';
						return data;
					}},
					{data: 'stAllca', 
						orderable: false,
						render: function(data, type, row) {
						var html = '';
						var allotment = Math.floor(data - row.stSpace);
						var percentage = allotment / data * 100;
						
						if (isNaN(percentage)) {
							data = 0;
						} else {
							data = percentage.toFixed(1);
						}
						
						html += '<div class="progress">';
						
						if (Math.floor(percentage) >= 90) {
							html += '<div class="progress-bar bg-danger" style="width: ' + data + '%"></div>';
						
						} else if (Math.floor(percentage) <= 89 && Math.floor(percentage) >= 80) {
							html += '<div class="progress-bar bg-yellow" style="width: ' + data + '%"></div>';

						} else {
							html += '<div class="progress-bar bg-green" style="width: ' + data + '%"></div>';
						}
						
						html += '</div>';

						return html;
					}},
					{data: 'stAllca', render: function(data, type, row) {
						var html = '';
						var allotment = Math.floor(data - row.stSpace);
						var percentage = allotment / data * 100;
						
						if (isNaN(percentage)) {
							data = 0 + ' %';
						} else {
							data = percentage.toFixed(1) + ' %';
						}
						
						return data;
					}}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[5, 10, 25, 50, -1], ['5', '10', '25', '50', '전체']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '데이터스토어 현황',
						exportOptions: {columns: [0, 1, 2, 3, 5]}
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '데이터스토어 현황',
						exportOptions: {columns: [0, 1, 2, 3, 5]}
					}]
				}, {
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}, {
					extend: 'colvis',
					text: '테이블 편집',
					className: 'btn colvisBtn'
				}]
			});
			
			tableAllDatastoreButton();
		}
		
		// 공용 데이터스토어 버튼
		function tableAllDatastoreButton() {
			var html = '';
			
			html += '<button type="button" class="btn unitButton" data-toggle="dropdown" id="allUnitButton">GB 단위</button>';
			html += '<div class="dropdown-menu">';
			html += '<a href="#" class="dropdown-item" id="allGB">GB</a>';
			html += '<a href="#" class="dropdown-item" id="allTB">TB</a>';
			html += '</div>';
			
			$('.allUnitB').empty().append(html);
			
			$('#allGB').off('click').on('click', function() {
				var tableAllDatastore = $('#tableAllDatastore').DataTable();
				tableAllDatastore.destroy();
				
				getAllDatastoreGBList();
				$('#allUnitButton').html('GB 단위');
			});
			
			$('#allTB').off('click').on('click', function() {
				var tableAllDatastore = $('#tableAllDatastore').DataTable();
				tableAllDatastore.destroy();
				
				getAllDatastoreTBList();
				$('#allUnitButton').html('TB 단위');
			});
		}
		
		// 로컬 데이터스토어 테이블 (GB)
		function getLocalDatastoreGBList() {
			var tableLocalDatastore = $('#tableLocalDatastore').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B<"unitB localUnitB">>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/status/selectLocalDatastoreList.do',
					type: 'POST',
					dataSrc: '',
				},
				columns: [
					{data: 'stName'},
					{data: 'stAllca', render: function(data, type, row) {
						data = data.toLocaleString() + ' GB';
						return data;
					}},
					{data: 'stSpace', render: function(data, type, row) {
						data = data.toLocaleString() + ' GB';
						return data;
					}},
					{data: 'stUseca', render: function(data, type, row) {
						data = data.toLocaleString() + ' GB';
						return data;
					}},
					{data: 'stAllca', orderable: false, render: function(data, type, row) {
						var html = '';
						
						var allotment = Math.floor(data - row.stSpace);
						var percentage = allotment / data * 100;
						
						if (isNaN(percentage)) {
							data = 0;
						} else {
							data = percentage.toFixed(1);
						}
						
						html += '<div class="progress">';
						
						if (Math.floor(percentage) >= 90) {
							html += '<div class="progress-bar bg-danger" style="width: ' + data + '%"></div>';
						
						} else if (Math.floor(percentage) <= 89 && Math.floor(percentage) >= 80) {
							html += '<div class="progress-bar bg-yellow" style="width: ' + data + '%"></div>';

						} else {
							html += '<div class="progress-bar bg-green" style="width: ' + data + '%"></div>';
						}
						
						html += '</div>';

						return html;
					}},
					{data: 'stAllca', render: function(data, type, row) {
						var html = '';
						var allotment = Math.floor(data - row.stSpace);
						var percentage = allotment / data * 100;
						
						if (isNaN(percentage)) {
							data = 0 + ' %';
						} else {
							data = percentage.toFixed(1) + ' %';
						}
						
						return data;
					}}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[5, 10, 25, 50, -1], ['5', '10', '25', '50', '전체']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '데이터스토어 현황',
						exportOptions: {columns: [0, 1, 2, 3, 5]}
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '데이터스토어 현황',
						exportOptions: {columns: [0, 1, 2, 3, 5]}
					}]
				}, {
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}, {
					extend: 'colvis',
					text: '테이블 편집',
					className: 'btn colvisBtn'
				}]
			});
			
			tableLocalDatastoreButton();
		}
		
		// 로컬 데이터스토어 테이블 (TB)
		function getLocalDatastoreTBList() {
			var tableLocalDatastore = $('#tableLocalDatastore').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B<"unitB localUnitB">>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/status/selectLocalDatastoreList.do',
					type: 'POST',
					dataSrc: '',
				},
				columns: [
					{data: 'stName'},
					{data: 'stAllca', render: function(data, type, row) {
						data = (data / 1024).toFixed(2) + ' TB';
						return data;
					}},
					{data: 'stSpace', render: function(data, type, row) {
						data = (data / 1024).toFixed(2) + ' TB';
						return data;
					}},
					{data: 'stUseca', render: function(data, type, row) {
						data = (data / 1024).toFixed(2) + ' TB';
						return data;
					}},
					{data: 'stAllca', orderable: false, render: function(data, type, row) {
						var html = '';
						
						var allotment = Math.floor(data - row.stSpace);
						var percentage = allotment / data * 100;
						
						if (isNaN(percentage)) {
							data = 0;
						} else {
							data = percentage.toFixed(1);
						}
						
						html += '<div class="progress">';
						
						if (Math.floor(percentage) >= 90) {
							html += '<div class="progress-bar bg-danger" style="width: ' + data + '%"></div>';
						
						} else if (Math.floor(percentage) <= 89 && Math.floor(percentage) >= 80) {
							html += '<div class="progress-bar bg-yellow" style="width: ' + data + '%"></div>';

						} else {
							html += '<div class="progress-bar bg-green" style="width: ' + data + '%"></div>';
						}
						
						html += '</div>';

						return html;
					}},
					{data: 'stAllca', render: function(data, type, row) {
						var html = '';
						var allotment = Math.floor(data - row.stSpace);
						var percentage = allotment / data * 100;
						
						if (isNaN(percentage)) {
							data = 0 + ' %';
						} else {
							data = percentage.toFixed(1) + ' %';
						}
						
						return data;
					}}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[5, 10, 25, 50, -1], ['5', '10', '25', '50', '전체']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '데이터스토어 현황',
						exportOptions: {columns: [0, 1, 2, 3, 5]}
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '데이터스토어 현황',
						exportOptions: {columns: [0, 1, 2, 3, 5]}
					}]
				}, {
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}, {
					extend: 'colvis',
					text: '테이블 편집',
					className: 'btn colvisBtn'
				}]
			});
			
			tableLocalDatastoreButton();
		}
		
		// 로컬 데이터스토어 버튼
		function tableLocalDatastoreButton() {
			var html = '';
			
			html += '<button type="button" class="btn unitButton" data-toggle="dropdown" id="LocalUnitButton">GB 단위</button>';
			html += '<div class="dropdown-menu">';
			html += '<a href="#" class="dropdown-item" id="LocalGB">GB</a>';
			html += '<a href="#" class="dropdown-item" id="LocalTB">TB</a>';
			html += '</div>';
			
			$('.localUnitB').empty().append(html);
			
			$('#LocalGB').off('click').on('click', function() {
				var tableLocalDatastore = $('#tableLocalDatastore').DataTable();
				tableLocalDatastore.destroy();
				
				getLocalDatastoreGBList();
				$('#LocalUnitButton').html('GB 단위');
			});
			
			$('#LocalTB').off('click').on('click', function() {
				var tableLocalDatastore = $('#tableLocalDatastore').DataTable();
				tableLocalDatastore.destroy();
				
				getLocalDatastoreTBList();
				$('#LocalUnitButton').html('TB 단위');
			});
		}
	</script>
</body>

</html>