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
			<div class="card Inquire-card">
				<div class="row">
					<div class="col-xl-2 col-sm-6">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">주기</span></div>
							<select class="form-control no-search" id="selectCycle">
								<option value="1" selected>일간</option>
								<option value="2">주간</option>
								<option value="3">월간</option>
							</select>
						</div>
					</div>
					<div class="col-xl-2 col-sm-6">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">일자</span></div>
							<input type="date" class="form-control" id="inputDate">
						</div>
					</div>
					<div class="col-xl-3 col-sm-6 w-100 clusterDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">클러스터</span></div>
							<select class="form-control no-search" id="selectCluster"></select>
						</div>
					</div>
					<div class="col-xl-1 col-sm-12">
						<button type="button" class="btn w-100" onclick="reportFilter()">조회</button>
					</div>
				</div>
			</div>
			
			<!-- 호스트 보고서 테이블 -->
			<table id="tableReport" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th rowspan="2">클러스터</th>
						<th rowspan="2">호스트</th>
						<th rowspan="2">CPU</th>
						<th rowspan="2">Memory</th>
						<th rowspan="2">CPU 모델</th>
						<th rowspan="2">가상머신 수</th>
						<th rowspan="2">할당 vCPU</th>
						<th rowspan="2">할당 Memory</th>
						<th colspan="4" class="text-center">주간 ( AM 08 ~ PM 08 )</th>
						<th colspan="4" class="text-center">야간 ( PM 08 ~ AM 08 )</th>
					</tr>
					<tr>
						<th>평균 CPU</th>
						<th>평균 Memory</th>
						<th>최대 CPU</th>
						<th>최대 Memory</th>
						<th>평균 CPU</th>
						<th>평균 Memory</th>
						<th>최대 CPU</th>
						<th>최대 Memory</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script src="${path}/resource/js/hostReport.js"></script>
	
	<script type="text/javascript">
	
		// 호스트 보고서
		function getReport(cycle, clusterId, inputDate) {
			var tableReport = $('#tableReport').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/report/selectHostDayNightReportList.do',
					type: 'POST',
					dataSrc: '',
					data: {
						timeset : cycle,
						clusterName : clusterId,
						startDate : inputDate,
						endDate : inputDate
					}
				},
				columns: [
					{data: 'clusterName'},
					{data: 'hostName', render: function(data, type, row) {
						data = '<a href="/performance/hostPerformance.prom?cluster=' + clusterId + '&host=' + row.vmHID +'">' + data + '</a>';
						return data;
					}},
					{data: 'hostCPU'},
					{data: 'hostMemory', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'cpuModel'},
					{data: 'vmCount'},
					{data: 'sumCPU'},
					{data: 'sumMemory', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'avgCPU', render: function(data, type, row) {
						data = data == '' ? '' : data + ' %';
						return data;
					}},
					{data: 'avgMemory', render: function(data, type, row) {
						data = data == '' ? '' : data + ' %';
						return data;
					}},
					{data: 'maxCPU', render: function(data, type, row) {
						data = data == '' ? '' : data + ' %';
						return data;
					}},
					{data: 'maxMemory', render: function(data, type, row) {
						data = data == '' ? '' : data + ' %';
						return data;
					}},
					{data: 'nightAvgCPU', render: function(data, type, row) {
						data = data == '' ? '' : data + ' %';
						return data;
					}},
					{data: 'nightAvgMemory', render: function(data, type, row) {
						data = data == '' ? '' : data + ' %';
						return data;
					}},
					{data: 'nightMaxCPU', render: function(data, type, row) {
						data = data == '' ? '' : data + ' %';
						return data;
					}},
					{data: 'nightMaxMemory', render: function(data, type, row) {
						data = data == '' ? '' : data + ' %';
						return data;
					}}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '호스트 주야간 성능 보고서'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '호스트 주야간 성능 보고서'
					}]
				}, {
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}, {
					extend: 'colvis',
					text: '테이블 편집',
					className: 'btn colvisBtn'
				}]
			});
		}
	</script>
</body>

</html>