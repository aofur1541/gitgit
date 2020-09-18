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
			
			<!-- 필터 -->
			<div class=" row">
				<div class="col-2">
					<div class="input-group search-group">
						<input type="search" class="form-control " placeholder="SEARCH">
						<div class="input-group-append"><span class="input-group-text"><i class="fas fa-search"></i></span></div>
					</div>
				</div>
				<div class="col-xl-10 text-right">
					<button type="button" class="btn sortingBtn" data-toggle="dropdown">오름차순으로 보기</button>
					<div class="dropdown-menu">
						<a href="#" class="dropdown-item" id="ASC">오름차순</a>
						<a href="#" class="dropdown-item" id="DESC">내림차순</a>
					</div>
				</div>
			</div>
			
			<!-- 템플릿 카드 -->
			<div class="row" id="appendContent"></div>
			
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			getTemplateList();
		})
		
		function getTemplateList() {
			var html = '';
		
			$.ajax({
				data: {
					sorting: 'ASC'
				},
				url: "/apply/selectVMTemplateOnList.do",
				success: function(data) {
					for (key in data) {
						html += '<div class="col-xl-3 col-sm-6">';
						html += '<div class="card template-card">';
						html += '<div class="card-header">' + data[key].vmName + '</div>';
						html += '<div class="card-body">';
						html += '<ul>';
						html += '<li><span>OS</span><span>' + data[key].vmOS + '</span></li>';
						html += '<li><span>Disk</span><span>' + data[key].vmDisk + ' GB</span></li>';
						
						if (data[key].description == null || data[key].description == '') {
							html += '<li><span>설명</span><span class="text-muted">설명이 없습니다.</span></li>';
						} else {
							html += '<li><span>설명</span><span>' + data[key].description + '</span></li>';
						}
						
						html += '</ul>';
						html += '<div class="d-flex justify-content-end"><button type="button" class="btn">생성</button></div>';
						html += '</div>';
						html += '</div>';
						html += '</div>';
					}
					
					$('#appendContent').empty().append(html);
				}
			})
		}
	</script>
</body>

</html>