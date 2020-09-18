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
			
			<!-- 문의사항 목록 테이블 -->
			<table id="tableQuestion" class="cell-border hover" style="width: 100%">
				<thead>
					<tr>
						<th>순번</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록 일시</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
	
		$(document).ready(function() {
			getQuestionList();
		});
		
		// 문의사항 테이블
		function getQuestionList() {
			var tableQuestion = $("#tableQuestion").addClass("nowrap").DataTable({
				dom: "<'datatables-header'<'createB'><'manageB'>B>" + "<'datatables-body'rt>" + "<'datatables-footer'ifp>",
				ajax: {
					url: "/support/selectQuestionList.do",
					type: "POST",
					dataSrc: ""
				},
				columns: [
					{"data": "row"},
					{"data": "title",
						render: function(data, type, row) {
							data = '<a href=' + '\'' + '/support/viewQuestion.prom?id=' + row.id + '\'' + '">' + data + '</a>';
							return data;
						}
					},
					{"data": "questionerID"},
					{"data": "createdOn"},
				],
				language: datatables_lang,
				order: [[0, "desc"]],
				lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
				pageLength: 10,
				buttons: [{
					extend: "pageLength",
					className: "btn pageLengthBtn"
				}]
			});
	
			tableQuestionButton(tableQuestion);
			
			tableQuestion.on('init', function() {
				tableQuestion.rows().every(function() {
					this.child(format(this.data())).show();
					$(this.node()).addClass('shown');
				});
			});
		}
		
		// 답변 행
		function format(data) {
			var html = ''
			var viewQuestion = "\'" + '/support/viewQuestion.prom?id=' + data.id + "\'";
			
			if (data.isAnswered == 1) {
				html += '<tr class="titleCheck">';
				html += '<td><span class="d-none">'+ data.id +'</span></td>';
				html += '<td>ㄴ<a href=' + viewQuestion + '"><span class="text-prom ml-2">[답변] </span>' + data.title + '</a></td>';
				html += '<td>' + data.answerID + '</td>';
				html += '<td>' + data.updatedOn + '</td>';
				html += '</tr>';
			}
			return $(html).toArray();
		}
		
		
		
		// 등록, 관리 버튼
		function tableQuestionButton(tableQuestion) {
			$('.createB').html('<button type="button" class="btn createBtn" onclick="location.href=' + "\'" + '/support/addQuestion.prom' + "\'" + '">등록</button>');
			$('.manageB').html('<button type="button" class="btn manageBtn">문의 관리</button>');
	
			$('.manageBtn').click(function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableQuestion').on('click', 'tr', function() {
				var data = tableQuestion.row(this).data();
				$(this).addClass('selected');
				$('#tableQuestion tr').not(this).removeClass('selected');
				
				// 문의 행 선택 시
				if (data != undefined){
	
					// 관리 버튼 활성화		
					var html = '';
					
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown">문의 관리</button>';
					html += '<div class="dropdown-menu">';
					
					if (data.isAnswered == 0) {
						html += '<a href="#" class="dropdown-item" onclick="location.href=' + "\'" + '/support/addAnswer.prom?id=' + data.id + "\'" + '">답변 등록</a>';
						html += '<div class="dropdown-divider"></div>'
						html += '<a href="#" class="dropdown-item" onclick="location.href=' + "\'" + '/support/editQuestion.prom?id=' + data.id + "\'" + '">수정</a>';
					};
					
					html += '<a href="#" class="dropdown-item" id="deleteQuestion">삭제</a>';
					html += '</div>';
					
					$('.manageB').empty().append(html);
					
					$('#deleteQuestion').click(function() {
						deleteQuestion(data);
					});
					
				// 답변 행 선택시
				}  else if (data == undefined && $(this).hasClass('titleCheck') == true) {
					var dataId = $(this).children().eq(0).text();
					var dataTitle = $(this).prev().children().eq(1).text();
					
					// 관리 버튼 활성화		
					var html = '';
					
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown">답변 관리</button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" onclick="location.href=' + "\'" + '/support/editAnswer.prom?id=' + dataId + "\'" + '">수정</a>';
					html += '<a href="#" class="dropdown-item" id="deleteAnswer">삭제</a>';
					html += '</div>';
					
					$('.manageB').empty().append(html);
					
					$('#deleteAnswer').click(function() {
						deleteAnswer(dataId, dataTitle);
					});
				}
			});
		 }
		 
		// 문의 삭제
		function deleteQuestion(data) {
			if (confirm('\'' + data.title + '\' 글을 삭제하시겠습니까?') == true) {
				$.ajax({
					type : "POST",
					url : "/support/deleteQuestion.do",
					data : {
						id : data.id
					},
					success: function(data) {
						
						// 삭제 성공
						if (data == 1) {
								alert('삭제가 완료되었습니다.');
								location.reload();
							
						// 삭제 실패
						} else {
							alert('삭제에 실패했습니다.');
							return false;
						}
					}
				});
				
			} else {
				return false;
			}
		}
		 
		// 답변 삭제
		function deleteAnswer(dataId, dataTitle) {
			var id = dataId;
			if (confirm('\'' + dataTitle + '\' 글의 답변을 삭제하시겠습니까?') == true) {
				$.ajax({
					type : "POST",
					url : "/support/deleteAnswer.do",
					data : {
						id : id
					},
					success: function(data) {
						
						// 삭제 성공
						if (data == 1) {
								alert('삭제가 완료되었습니다.');
								location.reload();
							
						// 삭제 실패
						} else {
							alert('삭제에 실패했습니다.');
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