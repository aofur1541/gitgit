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
					<div class="col-xl-4 col-sm-12">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">클러스터</span></div>
							<select class="form-control" id="selectCluster"></select>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 호스트 테이블 -->
			<table id="tableHost" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>클러스터</th>
						<th>호스트</th>
						<th>CPU</th>
						<th>Memory</th>
						<th>ESXi 버전</th>
						<th>제조사</th>
						<th>모델명</th>
						<th>IP 주소</th>
						<th>UPtime</th>
						<th>가상머신 수</th>
						<th>CPU (%)</th>
						<th>Memory (%)</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>
	
	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			selectClusterList();
			
			// 클러스터 변경 시
			$('#selectCluster').change(function() {
				tableReload();
			});
		});

		// 클러스터 목록
		function selectClusterList() {
			$.ajax({
				url: "/tenant/selectClusterList.do",
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="0" selected disabled>클러스터가 없습니다.</option>';
					
					} else {
						html += '<option value="clusterAll" selected>전체</option>';
						for (key in data) {
							html += '<option value="' + data[key].clusterID + '">' + data[key].clusterName + '</option>';
						}
					}
					
					$('#selectCluster').empty().append(html);
					getHostList('clusterAll');
				}
			})
		}

		// 호스트 테이블
		function getHostList(clusterId) {
			var tableHost = $('#tableHost').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/status/selectVMHostList.do',
					type: 'POST',
					dataSrc: '',
					data: {
						clusterId: clusterId
					},
				},
				columns: [
					{data: 'hostParent'},
					{data: 'vmHhostname', render: function(data, type, row) {
						data = '<a href="/performance/hostPerformance.prom?cluster=' + clusterId + '&host=' + row.vmHID +'">' + data + '</a>';
						return data;
					}},
					{data: 'vmHcpu'},
					{data: 'vmHmemory'},
					{data: 'vmHverBu'},
					{data: 'vmHvendor'},
					{data: 'hostModel'},
					{data: 'vmHIP'},
					{data: 'vmHuptime', render: function(data, type, row) {
						data = data + ' 일';
						return data;
					}},
					{data: 'vmHvmCount', render: function(data, type, row) {
						data = data + ' 개';
						return data;
					}},
					{data: 'sumCPU', render: function(data, type, row) {
						data = data + ' %';
						return data;
					}},
					{data: 'sumMemory', render: function(data, type, row) {
						data = data + ' %';
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
						title: '호스트 현황'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '호스트 현황'
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

		// 테이블 새로고침
		function tableReload() {
			var tableHost = $('#tableHost').DataTable();
			tableHost.destroy();
			
			var clusterId = $('#selectCluster option:selected').val();
			getHostList(clusterId);
		}
	</script>
</body>

</html>