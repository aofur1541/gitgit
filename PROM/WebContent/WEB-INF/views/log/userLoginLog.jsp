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
			<table id="tableUserConnect" class="cell-border hover" style="width: 100%">
				<thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
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
			getUserConnectList();
		});
		
		function getUserConnectList() {
			var tableUserConnect = $('#tableUserConnect').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/log/selectUserConnectLogList.do',
					type: 'POST',
					dataSrc: '',
				},
				columns: [
					{data: 'sReceive'},
					{data: 'sTarget'},
					{data: 'sKeyword', render: function (data, type, row) {
						if (data == 'Login') {
							data = '로그인';
						
						} else if (data == 'Logout'){
							data = '로그아웃';
						}
						
						return data;
					}},
					{data: 'sContext'},
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
				order: [[5, 'desc']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '사용자 접속 이력'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '사용자 접속 이력'
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