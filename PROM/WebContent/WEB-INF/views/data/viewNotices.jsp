<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
	</head>
	<body>
		<c:if test="${null ne viewNotices}">
			<div class="card bg-dark mb-0">
				<div class="helpDesk-header d-flex justify-content-between align-items-center">
					<div class="header-title">
						<h4><b>${viewNotices.title}</b></h4>
						<h6 class="text-muted mb-0">마지막 수정 일시: ${viewNotices.updatedOn}<span class="mr-2 ml-2">|</span>작성자: ${viewNotices.writerID}</h6>
					</div>
					<div class="d-flex">
						<a href="#" class="list-icons-item dropdown-toggle" data-toggle="dropdown"><i class="icon-menu7 mr-0"></i></a>
						<div class="dropdown-menu">
							<a href="#" class="dropdown-item" onclick="location.href='/data/notices.do'"><i class="icon-list3"></i>목록 보기</a>
							<c:if test="${sessionAppEL!=USER_NAPP&&sessionAppEL!= USERHEAD_NAPP&&sessionAppEL!=CONTROLOPERATOR_NAPP}">
								<div class="dropdown-divider"></div>
								<a href="#" class="dropdown-item" onclick="updateNotice()"><i class="icon-pencil7"></i>공지 변경</a>
								<a href="#" class="dropdown-item" onclick="deleteNotice()"><i class="icon-trash"></i>공지 삭제</a>
							</c:if>
						</div>
					</div>
				</div>
				<div class="helpDesk-body text-default helpDesk-type-1">
					<c:out value="${viewNotices.contents}" escapeXml="false" />
				</div>
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
			<input type="hidden" value="${viewNotices.id}" id="id">
			<input type="hidden" value="${getPre.id}" id="preId">
			<input type="hidden" value="${getNext.id}" id="nextId">
		
			<script type="text/javascript">
				/* $(document).ready(function() {
						 if(!window.location.hash) {
						        window.location = window.location + '#loaded';
						        window.location.reload();
						    }
		
						}); */
	
				function pre() {
					var id = document.getElementById('preId').value;
					location.href = '/data/viewNotice.do?id=' + id;
				}
	
				function next() {
					var id = document.getElementById('nextId').value;
					location.href = '/data/viewNotice.do?id=' + id;
				}
	
				function updateNotice() {
				
					var id = $("#id").val();
					location.href = '/data/editNotice.do?id=' + id;
				}
	
				function deleteNotice() {
					
					var id = $("#id").val();
					if (confirm("해당 게시물을 삭제 하시겠습니까?") == true) {
						
						$.ajax({
							url: "/support/deleteNotice.do",
							type: "POST",
							data: {
								id: id
							}
						});
	
					} else {
						return false;
					}
					location.href = '/data/notices.do';
				}
			</script>
		</c:if>
	</body>
</html>