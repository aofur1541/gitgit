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

			<!-- 공지사항 목록 테이블 -->
			<table id="tableNotice" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>순번</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록 일시</th>
						<th>조회</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			getnoticeList();
		});

		// 공지사항 테이블
		function getnoticeList() {
			var tableNotice = $('#tableNotice').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"createB"><"manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/support/selectNoticeList.do',
					type: 'POST',
					dataSrc: ''
				},
				columns: [
					{data: 'row'},
					{data: 'title', render: function(data, type, row) {
						data = '<a href=' + '\'' + '/support/viewNotice.prom?id=' + row.id + '\'' + '">' + data + '</a>';
						return data;
					}},
					{data: 'writerID'},
					{data: 'createdOn'},
					{data: 'viewCount'}
				],
				language: datatables_lang,
				order: [[0, 'desc']],
				lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
				pageLength: 10,
				buttons: [{
					extend: 'pageLength',
					className: 'btn pageLengthBtn'
				}]
			});
	
			// 관리자만 공지 등록, 변경 가능함
			if (sessionUserApproval > ADMIN_CHECK) {
				tableNoticeButton(tableNotice);
			}
		}

		function tableNoticeButton(tableNotice) {
			$('.createB').html('<button type="button" class="btn createBtn" onclick="location.href=' + '\'' + '/support/addNotice.prom' + '\'' + '">등록</button>');
			$('.manageB').html('<button type="button" class="btn manageBtn">관리</button>');

			$('.manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});

			// 행 선택 시
			$('#tableNotice').on('click', 'tr', function() {
				var data = tableNotice.row(this).data();

				if (data != undefined) {
					$(this).addClass('selected');
					$('#tableNotice tr').not(this).removeClass('selected');

					// 관리 버튼 활성화
					var html = '';

					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown">관리</button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" id="updateNotice" onclick="location.href=' + '\'' + '/support/editNotice.prom?id=' + data.id + '\'' + '">변경</a>';
					html += '<a href="#" class="dropdown-item" id="deleteNotice">삭제</a>';
					html += '</div>';

					$('.manageB').empty().append(html);

					$('#deleteNotice').off('click').on('click', function() {
						deleteNotice(data);
					});
				}
			});
		}

		// 공지 삭제
		function deleteNotice(data) {

			// 삭제 확인
			if (confirm('\'' + data.title + '\' 공지를 삭제하시겠습니까?') == true) {
				$.ajax({
					url: '/support/deleteNotice.do',
					type: 'POST',
					data: {
						id: data.id
					},
					success: function(data) {
						
						// 삭제 성공
						if (data == 1) {
							alert('공지 삭제가 완료되었습니다.');
							location.reload();

						// 삭제 실패
						} else {
							alert('공지 삭제에 실패했습니다.');
							return false;
						}
					}
				});

			} else {
				return false;
			}
		}
	</script>
</body>

</html>