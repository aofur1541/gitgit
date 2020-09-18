<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>

		<c:if test="${null ne viewQuestions}">

			<!-- 본문 시작 -->
			<div class="content">

				<!-- 답변이 없을 경우 -->
				<c:if test="${viewQuestions.isAnswered == 0}">

					<!-- 게시글 버튼 - 문의 -->
					<div class="viewPost-button">
						
						<!-- 답변이 없으면서 관리자만 답변 등록 가능 -->
						<c:if test="${sessionUserApproval > ADMIN_CHECK && viewQuestions.isAnswered == 0}">
							<button type="button" class="btn answerBtn" onclick="addAnswer()">답변 등록</button>
						</c:if>
						
						<!-- 답변이 없으면서 본인이 쓴 게시물이어야 변경 가능 -->
						<c:if test="${sessionUserName == viewQuestions.questionerID && viewQuestions.isAnswered == 0}">
							<button type="button" class="btn updateBtn" onclick="updateQuestion()">문의 변경</button>
						</c:if>
						
						<!-- 관리자거나 본인이 쓴 게시물이면 삭제 가능 -->
						<c:if test="${sessionUserApproval > ADMIN_CHECK || sessionUserName == viewQuestions.questionerID}">
							<button type="button" class="btn deleteBtn" onclick="deleteQuestion()">문의 삭제</button>
						</c:if>
						
						<button type="button" class="btn listBtn" onclick="location.href='/support/question.prom'">목록</button>
					</div>

					<!-- 게시글 - 문의 -->
					<div class="card post-card">
						<div class="card-header">
							<div class="card-header-title" title="${viewQuestions.title}">${viewQuestions.title}</div>
							<div class="card-header-info"><span>작성자 : ${viewQuestions.questionerID}</span><span>마지막 변경 일시 : ${viewQuestions.createdOn}</span></div>
						</div>
						<div class="card-body">${viewQuestions.question}</div>
					</div>
				</c:if>

				<!-- 답변이 있을 경우 -->
				<c:if test="${viewQuestions.isAnswered == 1}">

					<!-- 게시글 버튼 - 문의 -->
					<div class="viewPost-button">
					
						<!-- 관리자거나 본인이 쓴 게시물이면 삭제 가능 -->
						<c:if test="${sessionUserApproval > ADMIN_CHECK || sessionUserName == viewQuestions.questionerID}">
							<button type="button" class="btn deleteBtn" onclick="deleteQuestion()">문의 삭제</button>
						</c:if>
						
						<button type="button" class="btn listBtn" onclick="location.href='/support/question.prom'">목록</button>
					</div>

					<!-- 게시글 - 문의 -->
					<div class="card post-card">
						<div class="card-header">
							<div class="card-header-title" title="${viewQuestions.title}">${viewQuestions.title}</div>
							<div class="card-header-info"><span>작성자 : ${viewQuestions.questionerID}</span><span>마지막 변경 일시 : ${viewQuestions.createdOn}</span></div>
						</div>
						<div class="card-body">${viewQuestions.question}</div>
					</div>

					<!-- 게시글 버튼 - 답변 -->
					<div class="viewPost-button">
						
						<!-- 관리자거나 본인이 쓴 게시물이면 변경/삭제 가능 -->
						<c:if test="${sessionUserApproval > ADMIN_CHECK || sessionUserName == viewQuestions.answerID}">
							<button type="button" class="btn updateBtn" onclick="updateAnswer()">답변 변경</button>
							<button type="button" class="btn deleteBtn" onclick="deleteAnswer()">답변 삭제</button>
						</c:if>
					</div>

					<!-- 게시글 - 답변 -->
					<div class="card post-card">
						<div class="card-header">
							<div class="card-header-title" title="[답변] ${viewQuestions.title}">[답변] ${viewQuestions.title}</div>
							<div class="card-header-info"><span>작성자: ${viewQuestions.answerID}</span><span>등록 일시: ${viewQuestions.updatedOn}</span></div>
						</div>
						<div class="card-body">${viewQuestions.answer}</div>
					</div>
				</c:if>

				<!-- 게시글 이동 -->
				<table class="postMove-table" style="width: 100%;">
					<tbody>
						<c:if test="${null eq getNext}">
							<tr>
								<th>다음글<i class="fas fa-caret-up text-disabled"></i></th>
								<td><a class="text-disabled">다음글이 없습니다.</a></td>
							</tr>
						</c:if>
						<c:if test="${null ne getNext}">
							<tr>
								<th>다음글<i class="fas fa-caret-up"></i></th>
								<td><a href="#" onclick="next()" title="${getNext.title}">${getNext.title}</a></td>
							</tr>
						</c:if>
						<c:if test="${null eq getPre}">
							<tr>
								<th>이전글<i class="fas fa-caret-down text-disabled"></i></th>
								<td><a class="text-disabled">이전글이 없습니다.</a></td>
							</tr>
						</c:if>
						<c:if test="${null ne getPre}">
							<tr>
								<th>이전글<i class="fas fa-caret-down"></i></th>
								<td><a href="#" onclick="pre()" title="${getPre.title}">${getPre.title}</a></td>
							</tr>
						</c:if>
					</tbody>
				</table>

				<!-- 위로 가기 -->
				<div><button type="button" class="btn goTopBtn" onclick="$('html,body').animate({scrollTop:0},300)"><i class="fas fa-arrow-up"></i></button></div>

				<input type="hidden" value="${viewQuestions.id}" id="id">
				<input type="hidden" value="${getPre.id}" id="preId">
				<input type="hidden" value="${getNext.id}" id="nextId">
			</div>
			<!-- 본문 끝 -->
		</c:if>
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		
		// 답변 등록
		function addAnswer() {
			var id = $('#id').val();
			
			location.href = '/support/addAnswer.prom?id=' + id;
		}

		// 문의 변경
		function updateQuestion() {
			var id = $('#id').val();
			
			location.href = '/support/editQuestion.prom?id=' + id;
		}
		
		// 문의 삭제
		function deleteQuestion() {
			var id = $('#id').val();
			
			// 삭제 확인
			if (confirm('문의를 삭제 하시겠습니까?') == true) {
				$.ajax({
					url: '/support/deleteQuestion.do',
					type: 'POST',
					data: {
						id: id
					},
					success: function(data) {
						alert('문의 삭제가 완료되었습니다.');
						location.href = '/support/question.prom';
					}
				})
			
			} else {
				return false;
			}
		}
		
		// 답변 변경
		function updateAnswer() {
			var id = $('#id').val();
			
			location.href = '/support/editAnswer.prom?id=' + id;
		}

		// 답변 삭제
		function deleteAnswer() {
			var id = $('#id').val();
			
			// 삭제 확인
			if (confirm('답변을 삭제 하시겠습니까?') == true) {
				$.ajax({
					url: '/support/deleteAnswer.do',
					type: 'POST',
					data: {
						id: id
					},
					success: function(data) {
						alert('답변 삭제가 완료되었습니다.');
						location.href = '/support/viewQuestion.prom?id=' + id;
					}
				});
			
			} else {
				return false;
			}
		}
		
		// 이전 게시글
		function pre() {
			var id = $('#preId').val();
			
			location.href = '/support/viewQuestion.prom?id=' + id;
		}
		
		// 다음 게시글
		function next() {
			var id = $('#nextId').val();
			
			location.href = '/support/viewQuestion.prom?id=' + id;
		}
	</script>
</body>

</html>