<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<script type="text/javascript">
		$(document).ready(function() {
			getQuestionsList();
		});

		function getQuestionsList() {
			var questionsTable = $("#questionsTable")
				.addClass("nowrap")
				.DataTable({
					ajax: {
						"url": "/support/selectQuestionList.do",
						"dataSrc": ""
					},
					columns: [{
							"data": "row"
						},
						{
							"data": "title",
							render: function(data, type, row) {
								var viewQuestions = "\'" +
									'/data/viewQuestion.do?id=' +
									row.id + "\'";
								data = '<span class="helpDesk-link" onclick="location.href=' + viewQuestions + '">' +
									data + '</span>';
								return data;
							}
						},
						{
							"data": "questionerID"
						},
						{
							"data": "createdOn"
						},
						{
							"data": "id",
							"orderable": false,
							render: function(data, type, row) {
								var questionerID = row.questionerID;
								var isAnswered = row.isAnswered;
								var viewQuestions = "\'" +
									'/data/viewQuestion.do?id=' +
									row.id + "\'";
								var updateQuestions = "\'" +
									'/data/editQuestion.do?id=' +
									row.id + "\'";
								var html = '';
								html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
								html += '<i class="icon-menu9"></i>';
								html += '</a>';
								html += '<div class="dropdown-menu">';
								html += '<a href="#" class="dropdown-item" onclick="location.href=' + viewQuestions + '"><i class="icon-file-text"></i>상세 보기</a>';
								if (sessionApproval > ADMINCHECK &&
									sessionApproval != CONTROL_OPERATOR_NAPP) {
									if (row.isAnswered == 0) {
										var editAnswer = "\'" +
											'/data/addAnswer.do?id=' +
											row.id + "\'";
										html += '<div class="dropdown-divider"></div>';
										html += '<a href="#" class="dropdown-item" onclick="location.href=' + editAnswer + '"><i class="icon-pencil7"></i>답변 등록</a>';

									}
								}
								if (sessionName == questionerID &&
									isAnswered != 1) {
									html += '<a href="#" class="dropdown-item" onclick="location.href=' + updateQuestions + '"><i class="icon-pencil7"></i>문의 변경</a>';
								}
								if (sessionName == questionerID ||
									(sessionApproval > ADMINCHECK) &&
									(sessionUserID != CONTROLCHECK)) {
									html += '<a href="#" class="dropdown-item" onclick="deleteQuestionsCheck(' +
										row.id +
										')"><i class="icon-trash"></i>문의 삭제</a>';
								}
								html += '</div>';
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
					pageLength: 5,
					dom: "<'datatables-header'<'row-padding-0'lf><'row-padding-0'<'addModal'>>>" +
						"<'datatables-body'rt>" +
						"<'datatables-footer'ip>"
				});
			if (sessionApproval != CONTROL_OPERATOR_NAPP) {
				var editQuestions = "\'" + '/data/addQuestion.do' + "\'";
				$(".addModal")
					.html(
						'<button type="button" class="btn bg-prom" onclick="location.href=' + editQuestions + '"><i class="icon-plus2"></i><span class="ml-2">문의하기</span></button>');
			}
			questionsTable.on('init', function() {
				questionsTable.rows().every(function() {
					this.child(format(this.data())).show();
					$(this.node()).addClass('shown')
				});
			});
		}

		function format(data) {
			var html = '';
			var viewQuestions = "\'" + '/data/viewQuestion.do?id=' + data.id + "\'";
			var updateQuestions = "\'" + '/data/editAnswer.do?id=' + data.id +
				"\'";
			if (data.isAnswered == 1) {
				html += '<tr>';
				html += '<td></td>';
				html += '<td>ㄴ<span class="helpDesk-link" onclick="location.href=' + viewQuestions + '"><span class="text-prom ml-2">[답변] </span>' +
					data.title + '</span></td>';
				html += '<td>' + data.answerID + '</td>';
				html += '<td>' + data.updatedOn + '</td>';
				html += '<td>';
				html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
				html += '<i class="icon-menu9"></i>';
				html += '</a>';
				html += '<div class="dropdown-menu">';
				html += '<a href="#" class="dropdown-item" onclick="location.href=' + viewQuestions + '"><i class="icon-file-text"></i>상세 보기</a>';
				if (sessionApproval > ADMINCHECK &&
					sessionApproval != CONTROL_OPERATOR_NAPP &&
					data.answerID == sessionName) {
					html += '<a href="#" class="dropdown-item" onclick="location.href=' + updateQuestions + '"><i class="icon-pencil7"></i>답변 변경</a>';
					html += '<a href="#" class="dropdown-item" onclick="deleteAnswerCheck(' +
						data.id + ')"><i class="icon-trash"></i>답변 삭제</a>';
				} else {
					html += '</div>';
					html += '</td>';
					html += '</tr>';
				}
			}
			return $(html).toArray();
		}
	</script>
</head>

<body>
	<div class="card bg-dark mb-0 table-type-5-6">
		<table id="questionsTable" class="promTable hover" style="width: 100%">
			<thead>
				<tr>
					<th>순번</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록 일시</th>
					<th>관리</th>
				</tr>
			</thead>
		</table>
	</div>
	<script>
		function deleteQuestionsCheck(target) {
			if (confirm("해당 게시물을 삭제 하시겠습니까?") == true) {
				deleteSelectQuestions(target);
			} else {
				return false;
			}
		}

		function deleteSelectQuestions(target) {
			var id = target;
			$.ajax({
				type: "POST",
				url: "/support/deleteQuestion.do",
				data: {
					id: id
				}
			});
			window.location.href = '/data/questions.do';
		}

		function deleteAnswerCheck(target) {
			if (confirm("해당 게시물을 삭제 하시겠습니까?") == true) {
				deleteSelectAnswer(target);
			} else {
				return false;
			}
		}

		function deleteSelectAnswer(target) {
			var id = target;
			$.ajax({
				type: "POST",
				url: "/support/deleteAnswer.do",
				data: {
					id: id
				}
			});
			window.location.href = '/data/questions.do';
		}
	</script>
</body>

</html>