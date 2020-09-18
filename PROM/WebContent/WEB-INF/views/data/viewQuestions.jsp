<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
	</head>
	<body>
		<c:if test="${null ne viewQuestions}">
			<div class="card bg-dark mb-0">
				<c:if test="${viewQuestions.isAnswered == 0}">
					<div class="helpDesk-header d-flex justify-content-between align-items-center">
						<div class="header-title">
							<h4><b>${viewQuestions.title}</b></h4>
							<h6 class="text-muted mb-0">등록 일시: ${viewQuestions.createdOn}<span class="mr-2 ml-2">|</span>작성자: ${viewQuestions.questionerID}</h6>
						</div>
						<div class="d-flex">
							<a href="#" class="list-icons-item dropdown-toggle" data-toggle="dropdown"><i class="icon-menu7"></i></a>
							<div class="dropdown-menu">
								<a href="#" class="dropdown-item" onclick="location.href='/data/questions.do'"><i class="icon-list3"></i>목록 보기</a>
							
								<c:if test="${viewQuestions.isAnswered == 0 && sessionAppEL > ADMINCHECK}">
									<div class="dropdown-divider"></div>
									<a href="#" class="dropdown-item" onclick="editAnswer()"><i class="icon-pencil7"></i>답변 등록</a>
								</c:if>
								<c:if test="${viewQuestions.isAnswered == 0 && sessionUserNameEL eq viewQuestions.questionerID}">
									<a href="#" class="dropdown-item" onclick="updateQuestions()"><i class="icon-pencil7"></i>문의 변경</a>
								</c:if>
								<c:if test="${sessionAppEL > ADMINCHECK || sessionUserNameEL eq viewQuestions.questionerID}">
									<a href="#" class="dropdown-item" onclick="deleteQuestions()"><i class="icon-trash"></i>문의 삭제</a>
								</c:if>
							</div>
						</div>
					</div>
					<div class="helpDesk-body text-default helpDesk-type-1">${viewQuestions.question}</div>
				</c:if>
				<c:if test="${viewQuestions.isAnswered == 1}">
					<div class="helpDesk-header d-flex justify-content-between align-items-center">
						<div class="header-title">
							<h4><b>${viewQuestions.title}</b></h4>
							<h6 class="text-muted mb-0">등록 일시: ${viewQuestions.createdOn}<span class="mr-2 ml-2">|</span>작성자: ${viewQuestions.questionerID}</h6>
						</div>
						<div class="d-flex">
							<a href="#" class="list-icons-item dropdown-toggle" data-toggle="dropdown"><i class="icon-menu7"></i></a>
							<div class="dropdown-menu">
								<a href="#" class="dropdown-item" onclick="location.href='/data/questions.do'"><i class="icon-list3"></i>목록 보기</a>
								<div class="dropdown-divider"></div>
								<c:if test="${viewQuestions.isAnswered == 0 && sessionAppEL > ADMINCHECK}">
									<a href="#" class="dropdown-item" onclick="editAnswer()"><i class="icon-pencil7"></i>답변 등록</a>
								</c:if>
								<c:if test="${viewQuestions.isAnswered == 0 && sessionUserNameEL eq viewQuestions.questionerID}">
									<a href="#" class="dropdown-item" onclick="updateQuestions()"><i class="icon-pencil7"></i>문의 변경</a>
								</c:if>
								<c:if test="${sessionAppEL > ADMINCHECK || sessionUserNameEL eq viewQuestions.questionerID}">
									<a href="#" class="dropdown-item" onclick="deleteQuestions()"><i class="icon-trash"></i>문의 삭제</a>
								</c:if>
							</div>
						</div>
					</div>
					<div class="helpDesk-body text-default helpDesk-type-2">${viewQuestions.question}</div>
					<div class="helpDesk-header d-flex justify-content-between align-items-center border-top-light">
						<div class="header-title">
							<h4><b><span class="text-prom">[답변] </span>${viewQuestions.title}</b> </h4>
							<h6 class="text-muted mb-0">등록 일시: ${viewQuestions.updatedOn}<span class="mr-2 ml-2">|</span>작성자: ${viewQuestions.answerID}</h6>
						</div>
						<c:if test="${sessionUserNameEL eq viewQuestions.answerID && sessionAppEL > ADMINCHECK && sessionAppEL!=CONTROLOPERATOR_NAPP}">
							<div class="d-flex">
								<a href="#" class="list-icons-item dropdown-toggle" data-toggle="dropdown"><i class="icon-menu7"></i></a>
								<div class="dropdown-menu">
									<a href="#" class="dropdown-item" onclick="updateAnswer()"><i class="icon-pencil7"></i>답변 변경</a> <a href="#" class="dropdown-item" onclick="deleteAnswer()"><i class="icon-trash"></i>답변 삭제</a>
								</div>
							</div>
						</c:if>
					</div>
					<div class="helpDesk-body text-default helpDesk-type-2">${viewQuestions.answer}</div>
				</c:if>
				<div class="helpDesk-footer padding-0">
					<table class="orderTable" style="width: 100%">
						<tbody>
							<c:if test="${null eq getPre}">
								<tr>
									<th>이전글<i class="icon-arrow-up12 ml-2 text-muted"></i></th>
									<td><span class="text-muted">이전글이 없습니다.</span></td>
								</tr>
							</c:if>
							<c:if test="${null ne getPre}">
								<tr>
									<th>이전글<i class="icon-arrow-up12 ml-2 text-prom"></i></th>
									<td><span class="helpDesk-link" onclick="pre()">${getPre.title}</span></td>
								</tr>
							</c:if>
							<c:if test="${null eq getNext}">
								<tr>
									<th>다음글<i class="icon-arrow-down12 ml-2 text-muted"></i></th>
									<td><span class="text-muted">다음글이 없습니다.</span></td>
								</tr>
							</c:if>
							<c:if test="${null ne getNext}">
								<tr>
									<th>다음글<i class="icon-arrow-down12 ml-2 text-prom"></i></th>
									<td><span class="helpDesk-link" onclick="next()">${getNext.title}</span></td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
			<input type="hidden" value="${viewQuestions.id}" id="id">
			<input type="hidden" value="${getPre.id}" id="preId">
			<input type="hidden" value="${getNext.id}" id="nextId">
	
			<script>
				function editAnswer() {
					var id = $("#id").val();
					location.href = '/data/addAnswer.do?id=' + id;
				}
	
				function deleteAnswer() {
					
					var id = $("#id").val();
					if (confirm("해당 게시물을 삭제 하시겠습니까?") == true) {
						$.ajax({
							url: "/support/deleteAnswer.do",
							type: "POST",
							data: {
								id: id
							},
						})
						location.href = '/data/questions.do';
					} else {
						return false;
					}
				}
	
				function updateAnswer() {
					var id = $("#id").val();
					location.href = '/data/editAnswer.do?id=' + id;
				}
	
				function deleteQuestions() {
					var id = $("#id").val();
					if (confirm("해당 게시물을 삭제 하시겠습니까?") == true) {
						
						$.ajax({
							url: "/support/deleteQuestion.do",
							type: "POST",
							data: {
								id: id
							}
						})
						location.href = '/data/questions.do';
					} else {
						return false;
					}
				}
	
				function updateQuestions() {
					var id = $("#id").val();
					location.href = '/data/editQuestion.do?id=' + id;
				}
	
				function pre() {
					var id = document.getElementById('preId').value;
					location.href = '/data/viewQuestion.do?id=' + id;
				}
	
				function next() {
					var id = document.getElementById('nextId').value;
					location.href = '/data/viewQuestion.do?id=' + id;
				}
			</script>
		</c:if>
	</body>
</html>