<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			$(document).ready(function() {
				getnoticesList();
			})
		
			function getnoticesList() {
				var noticesTable = $("#noticesTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/support/selectNoticeList.do",
							"dataSrc": ""
						},
						columns: [
							{"data": "row"},
							{"data": "title",
								render: function(data, type, row) {
									var viewnotices = "\'" + '/data/viewNotice.do?id=' + row.id + "\'";
									data = '<span class="helpDesk-link" onclick="location.href=' + viewnotices + '">' + data + '</span>';
									return data;
								}
							},
							{"data": "writerID"},
							{"data": "createdOn"},
							{"data": "viewCount"},
							{"data": "id",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
									var viewNotices = "\'" + '/data/viewNotice.do?id=' +	row.id + "\'";
									var updateNotices = "\'" + '/data/editNotice.do?id=' + data + "\'";
									
									if (sessionApproval > ADMINCHECK && sessionApproval != CONTROL_OPERATOR_NAPP) {
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9 mr-0"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
										html += '<a href="#" class="dropdown-item" onclick="location.href=' + viewNotices + '"><i class="icon-file-text"></i>상세 보기</a>';
										html += '<a href="#" class="dropdown-item" onclick="location.href=' + updateNotices + '"><i class="icon-pencil7"></i>공지 변경</a>';
										html += '<a href="#" class="dropdown-item" onclick="deleteNoticeCheck(' + data + ')"><i class="icon-trash"></i>공지 삭제</a>';
										html += '</div>';
									} else {
										html += '<i class="icon-lock2 mr-0"></i>';
									}
									return html;
								}
							}
						],
						order: [
							[0, "desc"]
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
						dom: "<'datatables-header'<'row-padding-0'lf><'row-padding-0'<'addModal'>>>" + "<'datatables-body'rt>" + "<'datatables-footer'ip>"
					});
				var editNotices = "\'" + '/data/addNotice.do' + "\'";
				if (sessionApproval > ADMINCHECK && sessionApproval != CONTROL_OPERATOR_NAPP) {
					$(".addModal").html('<button type="button" class="btn bg-prom" onclick="location.href=' + editNotices + '"><i class="icon-plus2"></i><span class="ml-2">공지 등록</span></button>');
				}
			}
		</script>
	</head>
	<body>
		<div class="card bg-dark mb-0 table-type-5-6">
			<table id="noticesTable" class="promTable hover" style="width: 100%;">
				<thead>
					<tr>
						<th>순번</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록 일시</th>
						<th>조회</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
		
		<script type="text/javascript">
			function deleteNoticeCheck(id) {
				if (confirm("해당 게시물을 삭제 하시겠습니까?") == true) {
					deleteNotice(id);
				} else {
					return false;
				}
			}
			
			function deleteNotice(data) {
				var id = data;
				$.ajax({
					type : "POST",
					url : "/support/deleteNotice.do",
					data : {
						id : id
					}
				});
				location.href='/data/notices.do';
			}
		</script>
	</body>
</html>