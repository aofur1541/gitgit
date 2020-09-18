<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
</head>

<body>
	<%-- <%@ include file="/WEB-INF/views/include/loading.jsp"%> --%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>
		
		<!-- 본문 시작 -->
		<div class="content">
		
			<!-- 필터 -->
			<div class="card Inquire-card">
				<div class="row">
					<div class="col-xl-3">
						<div class="input-group select-group">
							<div class="input-group-prepend"><span class="input-group-text">가상머신</span></div>
							<select class="form-control" id="selectVM"></select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xl-2">
						<div class="input-group select-group">
							<div class="input-group-prepend"><span class="input-group-text">보기 단위</span></div>
							<select class="form-control" id="selectDateType">
								<option value="1" selected>5분</option>
							</select>
						</div>
					</div>
					<div class="col-xl-2 startDateDiv">
						<div class="input-group select-group">
							<div class="input-group-prepend"><span class="input-group-text">일자</span></div>
							<input type="date" class="form-control" id="startDate">
						</div>
					</div>
					<div class="col-xl-2 startTimeDiv">
						<div class="input-group select-group">
							<div class="input-group-prepend"><span class="input-group-text">시간</span></div>
							<input type="time" class="form-control" value="00:00" id="startTime">
						</div>
					</div>
					<div class="col-gorup tilde"><span>~</span></div>
					<div class="col-xl-2 endDateDiv">
						<div class="input-group select-group">
							<div class="input-group-prepend"><span class="input-group-text">일자</span></div>
							<input type="date" class="form-control" id="endDate">
						</div>
					</div>
					<div class="col-xl-2 endTimeDiv">
						<div class="input-group select-group">
							<div class="input-group-prepend"><span class="input-group-text">시간</span></div>
							<input type="time" class="form-control" value="23:59" id="endTime">
						</div>
					</div>
					<div class="col-xl-1">
						<button type="button" class="btn h-100" id="performanceFilterBtn">조회</button>
					</div>
				</div>
			</div>
			
			<!-- OS 기준 성능 차트  -->
			<div class="customPerformance">
				<div class="loading-background card-loading"><div class="spinner-border" role="status"></div></div>
				<span class="empty-chart d-none">현재 선택한 메트릭에 사용할 수 있는 성능 데이터가 없습니다.</span>
				<div class="performance-chart d-none" id="vmPerformance"></div>
			</div>
			
			<!-- OS 기준 성능 테이블 -->
			<table id="tableOSPerformance" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>가상머신</th>
						<th>vCPU</th>
						<th>Memory</th>
						<th>Disk</th>
						<th>Network</th>
						<th>일시</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		
	</script>
</body>

</html>