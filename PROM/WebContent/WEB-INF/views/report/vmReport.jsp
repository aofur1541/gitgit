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
					<div class="col-12 clusterOrServiceGroupDiv">
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" class="custom-control-input" id="byCluster" name="clusterOrServiceGroup">
							<label class="custom-control-label" for="byCluster">클러스터별</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" class="custom-control-input" id="byServiceGroup" name="clusterOrServiceGroup">
							<label class="custom-control-label" for="byServiceGroup">서비스 그룹별</label>
						</div>
					</div>
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
					<div class="col-xl-3 col-sm-6 clusterDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">클러스터</span></div>
							<select class="form-control" id="selectCluster"></select>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6 clusterDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">호스트</span></div>
							<select class="form-control" id="selectHost"></select>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6 serviceGroupDiv d-none">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">서비스 그룹</span></div>
							<select class="form-control" id="selectServiceGroup"></select>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6 serviceGroupDiv d-none">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">서비스</span></div>
							<select class="form-control" id="selectService"></select>
						</div>
					</div>
					<div class="col-xl-1 col-sm-12">
						<button type="button" class="btn w-100 h-100" id="reportFilterBtn">조회</button>
					</div>
				</div>
			</div>
			
			<!-- 가상머신 보고서 테이블 -->
			<table id="tableReport" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th id="name1">클러스터</th>
						<th id="name2">호스트</th>
						<th>가상머신</th>
						<th>vCPU</th>
						<th>Memory</th>
						<th>총 Disk</th>
						<th>OS</th>
						<th>평균 vCPU</th>
						<th>평균 Memory</th>
						<th>최대 vCPU</th>
						<th>최대 Memory</th>
						<th>평균 Disk</th>
						<th>평균 Network</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script src="${path}/resource/js/vmReport.js"></script>
	
	<script type="text/javascript">

		// 클러스터별 가상머신 보고서
		function getReportCluster(cycle, clusterId, hostId, inputDate) {
			var tableReport = $('#tableReport').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/report/selectVMReportList.do',
					type: 'POST',
					dataSrc: '',
					data: {
						timeset : cycle,
						clusterName : clusterId,
						hostName : hostId,
						category : 'cluster',
						startDate : inputDate,
						endDate : inputDate
					}
				},
				columns: [
					{data: 'clusterName'},
					{data: 'hostName'},
					{data: 'vmName', render: function(data, type, row) {
						data = '<a href="/performance/vmPerformance.prom?cluster=' + clusterId + '&host=' + hostId + '&vm=' + row.vmID +'">' + data + '</a>';
						return data;
					}},
					{data: 'vmCPU'},
					{data: 'vmMemory', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'vmDisk', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'vmOS'},
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
					{data: 'avgDisk', render: function(data, type, row) {
						data = data == '' ? '' : data + ' KB';
						return data;
					}},
					{data: 'avgNetwork', render: function(data, type, row) {
						data = data == '' ? '' : data + ' KB';
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
						title: '가상머신 성능 보고서'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '가상머신 성능 보고서'
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
		
		// 서비스 그룹별 가상머신 보고서
		function getReportserviceGroup(cycle, serviceGroupId, serviceId, inputDate) {
			var tableReport = $('#tableReport').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/report/selectVMReportList.do',
					type: 'POST',
					dataSrc: '',
					data: {
						timeset : cycle,
						tenantId : serviceGroupId,
						serviceId : serviceId,
						startDate : inputDate,
						endDate : inputDate,
						category : 'serviceGroup',
						isUserTenantMapping : isUserTenantMapping
					}
				},
				columns: [
					{data: 'tenantName'},
					{data: 'serviceName'},
					{data: 'vmName', render: function(data, type, row) {
						data = '<a href="/performance/vmPerformance.prom?serviceGroup=' + serviceGroupId + '&service=' + serviceId + '&vm=' + row.vmID +'">' + data + '</a>';
						return data;
					}},
					{data: 'vmCPU'},
					{data: 'vmMemory', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'vmDisk', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'vmOS'},
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
					{data: 'avgDisk', render: function(data, type, row) {
						data = data == '' ? '' : data + ' KB';
						return data;
					}},
					{data: 'avgNetwork', render: function(data, type, row) {
						data = data == '' ? '' : data + ' KB';
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
						title: '가상머신 성능 보고서'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '가상머신 성능 보고서'
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