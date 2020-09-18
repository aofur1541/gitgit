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

		<c:if test="${null ne viewNotices}">

			<!-- 본문 시작 -->
			<div class="content">

				<!-- 게시글 버튼 -->
				<div class="viewPost-button">
					<c:if test="${sessionUserApproval > ADMIN_CHECK}">
						<button type="button" class="btn updateBtn" onclick="updateNotice()">변경</button>
						<button type="button" class="btn deleteBtn" onclick="deleteNotice()">삭제</button>
					</c:if>
					<button type="button" class="btn listBtn" onclick="location.href='/support/notice.prom'">목록</button>
				</div>

				<!-- 게시글 -->
				<div class="card post-card">
					<div class="card-header">
						<div class="card-header-title" title="${viewNotices.title}">${viewNotices.title}</div>
						<div class="card-header-info"><span>작성자 : ${viewNotices.writerID}</span><span>마지막 수정 일시 : ${viewNotices.updatedOn}</span></div>
					</div>
					<div class="card-body">
						<c:out value="${viewNotices.contents}" escapeXml="false" />
					</div>
				</div>

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

				<input type="hidden" value="${viewNotices.id}" id="id">
				<input type="hidden" value="${getPre.id}" id="preId">
				<input type="hidden" value="${getNext.id}" id="nextId">
			</div>
		</c:if>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">

		// 공지 변경
		function updateNotice() {
			var id = $('#id').val();

			location.href = '/support/editNotice.prom?id=' + id;
		}

		// 공지 삭제
		function deleteNotice() {
			var id = $('#id').val();

			// 삭제 확인
			if (confirm('공지를 삭제 하시겠습니까?') == true) {
				$.ajax({
					url: '/support/deleteNotice.do',
					type: 'POST',
					data: {
						id: id
					},
					success: function(data) {
						alert('공지 삭제가 완료되었습니다.');
						location.href = '/support/notice.prom';
					}
				});

			} else {
				return false;
			}
		}
		
		// 이전 게시글
		function pre() {
			var id = $('#preId').val();

			location.href = '/support/viewNotice.prom?id=' + id;
		}

		// 다음 게시글
		function next() {
			var id = $('#nextId').val();

			location.href = '/support/viewNotice.prom?id=' + id;
		}
	</script>
</body>

</html>