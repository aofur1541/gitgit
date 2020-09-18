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
						<button type="button" class="btn w-100 h-100" id="logFilterBtn">조회</button>
					</div>
				</div>
			</div>
			
			<!-- 가상머신 이력 테이블 -->
			<table id="tableVMLog" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th id="name1">클러스터</th>
						<th id="name2">호스트</th>
						<th>가상머신</th>
						<th>구분</th>
						<th>상세 내용</th>
						<th>결과</th>
						<th>시작 일시</th>
						<th>완료 일시</th>
						<th>수행 시간</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		var category = 'cluster';	
		
		// 사용자가 매핑된 테넌트 사용 여부 
		var isUserTenantMapping = 'false';

		$(document).ready(function() {
			
			// 클러스터별/서비스 그룹별 radio 변경 시
			$('input[name="clusterOrServiceGroup"]').change(function () {
				$('#page_loading').removeClass('d-none');
				
				// 클러스터별 선택 시
				if ($('#byCluster').is(':checked')) {
					category = "cluster";	
					
					$('.clusterDiv').removeClass('d-none');
					$('.serviceGroupDiv').addClass('d-none');
					$('#logFilterBtn').attr('onclick', 'logFilter("cluster")');
					
					selectClusterList();
				}
				
				// 서비스 그룹별 선택 시
				if ($('#byServiceGroup').is(':checked')) {
					category = "serviceGroup";	
					
					$('.clusterDiv').addClass('d-none');
					$('.serviceGroupDiv').removeClass('d-none');
					$('#logFilterBtn').attr('onclick', 'logFilter("serviceGroup")');
					
					sessionUserApproval > USER_CHECK ? selectServiceGroupList() : selectUserServiceGroupList();
				}
			});
			
			// 클러스터 셀렉트 박스 변경 시
			$('#selectCluster').change(function () {
				var clusterId = $('#selectCluster option:selected').val();
				selectHostList(clusterId);
			});
			
			// 서비스 그룹 셀렉트 박스 변경 시
			$('#selectServiceGroup').change(function () {
				var serviceGroupId = $('#selectServiceGroup option:selected').val();
				selectServiceList(serviceGroupId);
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
				url: "/tenant/selectClusterList.do",
				type: "POST",
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
					
					var clusterId = $('#selectCluster option:selected').val();
					selectHostList(clusterId);
				}
			})
		}

		// 호스트 목록
		function selectHostList(clusterId) {
			$.ajax({
				url: "/status/selectVMHostList.do",
				type: "POST",
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="0" selected disabled>호스트가 없습니니다.</option>';
					
					} else {
						html += '<option value="hostAll" selected>전체</option>';
						for (key in data) {
							html += '<option value="' + data[key].vmHID + '">' + data[key].vmHhostname + '</option>';
						}
					}
					
					$('#selectHost').empty().append(html);
					
					if (isFirstSearch) {
						logFilter('cluster');
						isFirstSearch = false;
					}
				}
			})
		}

		// 서비스 그룹 목록
		function selectServiceGroupList() {
			$.ajax({
				url: "/tenant/selectTenantList.do",
				type: "POST",
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
					
					var serviceGroupId = $('#selectServiceGroup option:selected').val();
					selectServiceList(serviceGroupId);
				}
			})
		}

		// 사용자 서비스 그룹 목록
		function selectUserServiceGroupList() {
			$.ajax({
				url: "/tenant/selectLoginUserTenantList.do",
				type: "POST",
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
					
					var serviceGroupId = $('#selectServiceGroup option:selected').val();
					selectServiceList(serviceGroupId);
				}
			})
		}

		// 서비스 목록
		function selectServiceList(serviceGroupId) {
			if (serviceGroupId == '-2') {
				var html =  '<option value="-2" selected disabled>서비스가 없습니다.</option>';
				
				$('#selectService').empty().append(html);
				
				if (isFirstSearch) {
					logFilter('serviceGroup');
					isFirstSearch = false;
				}
			
			} else {
				$.ajax({
					url: "/tenant/selectVMServiceListByTenantId.do",
					type: "POST",
					data: {
						tenantId: serviceGroupId,
						isUserTenantMapping : isUserTenantMapping
					},
					success: function(data) {
						var html = '';
						
						if (data == null || data == '') {
							html += '<option value="-2" selected disabled>서비스가 없습니다.</option>';
					
						} else if (serviceGroupId == -1) {
							html += '<option value="-1" selected disabled>미배치</option>';
							
						} else {
							html += '<option value="" selected>전체</option>';
							for (key in data) {
								html += '<option value="' + data[key].vmServiceID + '">' + data[key].vmServiceName + '</option>';
							}
						}
						
						$('#selectService').empty().append(html);
						
						if (isFirstSearch) {
							logFilter('serviceGroup');
							isFirstSearch = false;
						}
					}
				})
			}
		}

		// 가상머신 이력
		function getVMLogList(category1, category2) {
			var param = {};
			
			if (category == 'serviceGroup') {
				param = {tenantId : category1, serviceId : category2, isUserTenantMapping : isUserTenantMapping};
			
			} else {
				param = {clusterId : category1, hostId : category2};
			}
			
			var tableVMLog = $('#tableVMLog').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/log/selectVMLogList.do',
					type: 'POST',
					dataSrc: '',
					data : param,
				},
				columns: [
					{data: 'category1', render: function(data, type, row) {
						if (category == 'serviceGroup') {
							data = row.tenantName;
						} else {
							data = row.clusterName;
						}
						return data;
					}},
					{data: 'category2', render: function(data, type, row) {
						if (category == 'serviceGroup') {
							data = row.serviceName;
						} else {
							data = row.hostName;
						}
						return data;
					}},
					{data: 'vmName'},
					{data: 'distinction', render: function(data, type, row) {
						if (data == 1) {
							data = '생성';
						
						} else if (data == 2) {
							data = '변경';
						
						} else if (data == 3) {
							data = '삭제';
						}
						
						return data;
					}},
					{data: 'sErrorCode', render: function(data, type, row) {
						if( row.sErrorCode == null ){
							data = row.createStatus;
						
						} else {
							data = row.createStatus+'<br>'+data;
						}
						
						return data;
					}},
					{data: 'finishStatus', render: function(data, type, row) {
						if (data == 0) {
							data = '진행중';
						
						} else if (data == 1) {
							data = '성공';
						
						} else if (data == 3) {
							data = '비정상 종료';
						
						} else if (row.sErrorCode != null) {
							data = '실패';
						}
						
						return data;
					}},
					{data: 'dStartTime'},
					{data: 'dEndTime'},
					{data: 'finishStatus', render: function(data, type, row) {
						if (data == 1) {
							var startTime = new Date(row.dStartTime);
							var endTime = new Date(row.dEndTime);
							var result = (endTime.getTime() - startTime.getTime()) / 1000 / 60;

							if (result < 1) {
								data = result.toFixed(2) + ' 초';
							
							} else {
								data = Math.floor(result) + ' 분';
							}
						
						} else if (data == 2) {
							data = '에러 발생';
						
						} else {
							data = 'null';
						}
						
						return data;
					}},
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[5, 10, 25, 50, -1],	 ['5', '10', '25', '50', '전체']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '가상머신 이력'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '가상머신 이력'
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
		
		// 결과 조회
		function logFilter(category) {
			var tableVMLog = $('#tableVMLog').DataTable();
			tableVMLog.destroy();
			
			// 클러스터별
			if (category == 'cluster') {
				$('#name1').html('클러스터');
				$('#name2').html('호스트');
				
				var clusterId = $('#selectCluster option:selected').val();
				var hostId = $('#selectHost option:selected').val();
				
				getVMLogList(clusterId, hostId);
			}
			
			// 서비스 그룹별
			if (category == 'serviceGroup') {
				$('#name1').html('서비스 그룹');
				$('#name2').html('서비스');
				
				var serviceGroupId = $('#selectServiceGroup option:selected').val();
				var serviceId = $('#selectService option:selected').val();
				
				getVMLogList(serviceGroupId, serviceId)
			}
		}
	</script>
</body>

</html>