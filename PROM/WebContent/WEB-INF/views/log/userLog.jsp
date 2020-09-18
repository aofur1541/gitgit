<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>
		
		<!-- 본문 시작 -->
		<div class="content">
			<table id="tableUserWork" class="cell-border hover" style="width: 100%">
				<thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>대상</th>
						<th>구분</th>
						<th>상세 내용</th>
						<th>결과</th>
						<th>일시</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			getUserWorkList();
		});
		
		function getUserWorkList() {
			var tableUserWork = $('#tableUserWork').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/log/selectUserWorkLogList.do',
					type: 'POST',
					dataSrc: '',
				},
				columns: [
					{data: 'sReceive'},
					{data: 'name'},
					{data: 'sTarget'},
					{data: 'sKeyword', render: function (data, type, row) {
						if (data == 'Create') {
							data = '생성';
						
						} else if (data == 'Update') {
							data = '변경';
						
						} else if (data == 'Delete') {
							data = '삭제';
						
						} else if (data == 'Mapping') {
							data = '매핑';
						
						} else if (data == 'Select') {
							data = '조회';
						}
						
						return data;
					}},
					{data: 'sContext', className: 'text-wrap'},
					{data : 'nCategory', render: function (data, type, row) {
						data = data == 0 ? '성공' : '실패';
						
						return data;
					}},
					{data: 'sSendDay'}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
				order: [[6, 'desc']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '사용자 작업 이력'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '사용자 작업 이력'
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
		}
	</script>
</body>

</html>