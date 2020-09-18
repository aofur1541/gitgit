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
		
		
		<!-- 본문 시작 -->
		<div class="content">
			
			<!-- 필터 -->
			<div class="card Inquire-card">
				<div class="row">
					<div class="col-group w-100 clusterOrServiceGroupDiv">
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" class="custom-control-input" id="byCluster" name="clusterOrServiceGroup">
							<label class="custom-control-label" for="byCluster">클러스터별</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
							<input type="radio" class="custom-control-input" id="byServiceGroup" name="clusterOrServiceGroup">
							<label class="custom-control-label" for="byServiceGroup">서비스 그룹별</label>
						</div>
					</div>
					<div class="col-group w-100 clusterDiv">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">클러스터</span></div>
							<select class="form-control" id="selectCluster"></select>
						</div>
					</div>
					<div class="col-group w-100 serviceGroupDiv d-none">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">서비스 그룹</span></div>
							<select class="form-control" id="selectServiceGroup"></select>
						</div>
					</div>
					<div class="col-group w-50">
						<div class="input-group">
							<div class="input-group-prepend"><span class="input-group-text">CPU</span></div>
							<input type="number" class="form-control" min="0" max="100" placeholder="입력" value="70" id="inputCPU">
						</div>
					</div>
				
					<div class="col-group w-50">
						<button type="button" class="btn w-100" id="performanceFilterBtn" >조회</button>
					</div>
				</div>
			</div>
			
			<!-- 자원 기준 성능 테이블 -->
			<table id="tableResourcePerformance" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
					<th id="name1">클러스터</th>
						<th>기준 CPU</th>
						<th>기준 Memory</th>
						<th>가상머신</th>
						<th>CPU</th>
						<th>Memory</th>
						<th>Disk</th>
						<th>Network</th>
						<th>피크타임</th>
						<th>시작시간</th>
						<th>종료시간</th>
						<th>기간</th>
						<th>1일 횟수</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		
		// 사용자가 매핑된 테넌트 사용 여부 
		var isUserTenantMapping = 'false';
		
		$(document).ready(function() {
			
			// 클러스터별/서비스 그룹별 radio 변경 시
			$('input[name="clusterOrServiceGroup"]').change(function () {
				$('#page_loading').removeClass('d-none');
				
				// 클러스터별 선택 시
				if ($('#byCluster').is(':checked')) {
					$('.clusterDiv').removeClass('d-none');
					$('.serviceGroupDiv').addClass('d-none');
					$('#performanceFilterBtn').attr('onclick', 'performanceFilter("cluster")');
					
					selectClusterList();
				}
				
				// 서비스 그룹별 선택 시
				if ($('#byServiceGroup').is(':checked')) {
					$('.clusterDiv').addClass('d-none');
					$('.serviceGroupDiv').removeClass('d-none');
					$('#performanceFilterBtn').attr('onclick', 'performanceFilter("serviceGroup")');
					
					sessionUserApproval > USER_CHECK ? selectServiceGroupList() : selectUserServiceGroupList();
				}
			});

			// 처음 실행 시 관리자면 클러스터별 보기, 사용자면 서비스 그룹별 보기 실행
			// 사용자는 서비스 그룹별로만 볼 수 있음 (클러스터별/서비스 그룹별 radio 숨김)
			if (sessionUserApproval > USER_CHECK) {
				isUserTenantMapping = 'false';
				
				$('.clusterOrServiceGroupDiv').removeClass('d-none');
				$('#byCluster').click();
			
			} else {
				isUserTenantMapping = 'true';
				
				$('.clusterOrServiceGroupDiv').addClass('d-none');
				$('#byServiceGroup').click();
			}
		});
		
		var isFirstSearch = true;
		
		// 클러스터 목록
		function selectClusterList() {
			$.ajax({
				url: '/tenant/selectClusterList.do',
				type: 'POST',
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
					
					if (isFirstSearch) {
						performanceFilter('cluster');
						isFirstSearch = false;
					}
				}
			})
		}

		// 서비스 그룹 목록
		function selectServiceGroupList() {
			$.ajax({
				url: '/tenant/selectTenantList.do',
				type: 'POST',
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="-2" selected disabled>서비스 그룹이 없습니다.</option>';
					
					} else {
						html += '<option value="" selected>전체</option>';
						for (key in data) {
								html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
						}
						html += '<option value="-1">미배치</option>';
					}
					
					$('#selectServiceGroup').empty().append(html);
					
					if (isFirstSearch) {
						performanceFilter('serviceGroup');
						isFirstSearch = false;
					}
				}
			})
		}

		// 사용자 서비스 그룹 목록
		function selectUserServiceGroupList() {
			$.ajax({
				url: '/tenant/selectLoginUserTenantList.do',
				type: 'POST',
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="-2" selected disabled>서비스 그룹이 없습니다.</option>';
					
					} else {
						html += '<option value="" selected>전체</option>';
						for (key in data) {
							html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
						}
					}
					
					$('#selectServiceGroup').empty().append(html);
					
					if (isFirstSearch) {
						performanceFilter('serviceGroup');
						isFirstSearch = false;
					}
				}
			})
		}

		// cpu 기준 성능
		function getCustomResourceList(cpu,memory, clusterId, clusterName, serviceGroupId, serviceGroupName, category) {
			var tableResourcePerformance = $('#tableResourcePerformance').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/performance/selectVMOvercpuList.do',
					type: 'POST',
					dataSrc: '',
					data: {
						cpu : cpu,
						clusterId : clusterId,
						tenantId : serviceGroupId,
						category : category,
						isUserTenantMapping: isUserTenantMapping
					
					}
				},
				columns: [
					{data: 'vmName', render: function(data, type, row) {
						if(category == 'cluster') {
							data = clusterName;
						} else {
							data = serviceGroupName;
						}
						return data;
					}},
					{data: 'cpu', render: function(data, type, row) {
						data = cpu + ' %';
						return data;
					}},
					{data: 'memory', render: function(data, type, row) {
						data = memory + ' %';
						return data;
					}},
					{data: 'vmName'},
					{data: 'cpu', render: function(data, type, row) {
						data = data + ' %';
						return data;
					}},
					{data: 'memory', render: function(data, type, row) {
						data = data + ' %';
						return data;
					}},
					{data: 'disk', render: function(data, type, row) {
						data = data + ' KB';
						return data;
					}},
					{data: 'network', render: function(data, type, row) {
						data = data + ' KB';
						return data;
					}},
					{data: 'dispTimestamp'},
					{data: 'startDate'},
					{data: 'endDate'},
					{data: 'cnt', render: function(data,type,row){
						data= data * 5 + '분';
						return data;
					}},
					{data: 'co'},
					
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
				columnDefs: [{visible: false, targets: 1}, {visible: false, targets: 2}],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '자원 기준 성능'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '자원 기준 성능'
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
		
		//테이블 조회
		function performanceFilter(category) {
			var cpu = $('#inputCPU').val();
			var memory = $('#inputMemory').val();
			
			var tableResourcePerformance = $('#tableResourcePerformance').DataTable();
			tableResourcePerformance.destroy();
			
			var clusterId = $('#selectCluster option:selected').val();
			var clusterName = $('#selectCluster option:selected').text();
			var serviceGroupId = $('#selectServiceGroup option:selected').val();
			var serviceGroupName = $('#selectServiceGroup option:selected').text();
			
			// 클러스터별
			if (category == 'cluster') {
				$('#name1').html('클러스터');
			}
			
			// 서비스 그룹별
			if (category == 'serviceGroup') {
				$('#name1').html('서비스 그룹');
			}
			
			getCustomResourceList(cpu, memory, clusterId, clusterName, serviceGroupId, serviceGroupName, category);
		}
	</script>
</body>

</html>