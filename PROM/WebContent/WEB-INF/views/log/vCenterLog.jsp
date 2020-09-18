<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
	
	<style type="text/css">
		.table-body {
			margin-bottom: 50px;
		}
	</style>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>
		
		<!-- 본문 시작 -->
		<div class="content">
			<div class="row log-table">
			
				<!-- 가상머신 알림 테이블 -->
				<div class="col-xl-6 col-sm-12">
					<div class="table-header"><h6><i class="fas fa-cube"></i>가상머신 알림</h6></div>
					<div class="table-body">
						<table id="tableVMLog" class="cell-border hover" style="width: 100%;">
							<thead>
								<tr>
									<th class="text-center">단계</th>
									<th>대상</th>
									<th>내용</th>
									<th>발생 일시</th>
								</tr>
							</thead>
							<tbody><tr><td class="text-center" colspan="4">데이터가 없습니다.</td></tr></tbody>
						</table>
					</div>
				</div>
				
				<!-- 호스트 알림 테이블 -->
				<div class="col-xl-6 col-sm-12">
					<div class="table-header"><h6><i class="fas fa-server"></i>호스트 알림</h6></div>
					<div class="table-body">
						<table id="tableHostLog" class="cell-border hover" style="width: 100%;">
							<thead>
								<tr>
									<th class="text-center">단계</th>
									<th>대상</th>
									<th>내용</th>
									<th>발생 일시</th>
								</tr>
							</thead>
							<tbody><tr><td class="text-center" colspan="4">데이터가 없습니다.</td></tr></tbody>
						</table>
					</div>
				</div>
				
				<!-- 데이터스토어 알림 테이블 -->
				<div class="col-xl-6 col-sm-12">
					<div class="table-header"><h6><i class="fas fa-database"></i>데이터스토어 알림</h6></div>
					<div class="table-body">
						<table id="tableDatastoreLog" class="cell-border hover" style="width: 100%;">
							<thead>
								<tr>
									<th class="text-center">단계</th>
									<th>대상</th>
									<th>내용</th>
									<th>발생 일시</th>
								</tr>
							</thead>
							<tbody><tr><td class="text-center" colspan="4">데이터가 없습니다.</td></tr></tbody>
						</table>
					</div>
				</div>
				
				<!-- 기타 알림 테이블 -->
				<div class="col-xl-6 col-sm-12">
					<div class="table-header"><h6><i class="far fa-comment-dots"></i>기타 알림</h6></div>
					<div class="table-body">
						<table id="tableOtherLog" class="cell-border hover" style="width: 100%;">
							<thead>
								<tr>
									<th class="text-center">단계</th>
									<th>대상</th>
									<th>내용</th>
									<th>발생 일시</th>
								</tr>
							</thead>
							<tbody><tr><td class="text-center" colspan="4">데이터가 없습니다.</td></tr></tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			vCenterLog();
		});

		function vCenterLog() {
			$.ajax({
				url: '/log/selectVCenterLogList.do',
				type: 'POST',
				success: function(data) {
					var vm = '';
					var host = '';
					var datastore = '';
					var other = '';
					
					for (key in data) {
						var vcAlertPK = "\'" + data[key].vcAlertPK + "\'";
						
						// 가상머신 알림
						if (data[key].vcAlertPK.indexOf('vm') != -1) {
							
							data[key].nAlertCheck == 2 ? vm += '<tr class="alert-check" onclick="vCenterAlertCheck(' + vcAlertPK + ')">' : vm += '<tr>';

							if (data[key].sAlertColor == 'red') {
								vm += '<td class="text-center"><i class="fas fa-exclamation-circle text-danger"></i></td>';
							
							} else if (data[key].sAlertColor == 'yellow') {
								vm += '<td class="text-center"><i class="fas fa-exclamation-triangle text-caution"></i></td>';
							}

							vm += '<td>' + data[key].sTarget + '</td>';
							vm += '<td>' + data[key].sVcMessage + '</td>';
							vm += '<td>' + data[key].dAlertTime + '</td>';

							vm += '</tr>';
							
							$('#tableVMLog tbody').empty().append(vm);
						
						// 호스트 알림
						} else if (data[key].vcAlertPK.indexOf('host') != -1) {
							
							data[key].nAlertCheck == 2 ? host += '<tr class="alert-check" onclick="vCenterAlertCheck(' + vcAlertPK + ')">' : host += '<tr>';

							if (data[key].sAlertColor == 'red') {
								host += '<td class="text-center"><i class="fas fa-exclamation-circle text-danger"></i></td>';
							
							} else if (data[key].sAlertColor == 'yellow') {
								host += '<td class="text-center"><i class="fas fa-exclamation-triangle text-caution"></i></td>';
							}

							host += '<td>' + data[key].sTarget + '</td>';
							host += '<td>' + data[key].sVcMessage + '</td>';
							host += '<td>' + data[key].dAlertTime + '</td>';

							host += '</tr>';
							
							$('#tableHostLog tbody').empty().append(host);
							
						// 데이터스토어 알림
						} else if (data[key].vcAlertPK.indexOf('datastore') != -1) {
							
							data[key].nAlertCheck == 2 ? datastore += '<tr class="alert-check" onclick="vCenterAlertCheck(' + vcAlertPK + ')">' : datastore += '<tr>';

							if (data[key].sAlertColor == 'red') {
								datastore += '<td class="text-center"><i class="fas fa-exclamation-circle text-danger"></i></td>';
							
							} else if (data[key].sAlertColor == 'yellow') {
								datastore += '<td class="text-center"><i class="fas fa-exclamation-triangle text-caution"></i></td>';
							}

							datastore += '<td>' + data[key].sTarget + '</td>';
							datastore += '<td>' + data[key].sVcMessage + '</td>';
							datastore += '<td>' + data[key].dAlertTime + '</td>';

							datastore += '</tr>';
							
							$('#tableDatastoreLog tbody').empty().append(datastore);
							
						// 기타 알림
						} else {
							
							data[key].nAlertCheck == 2 ? other += '<tr class="alert-check" onclick="vCenterAlertCheck(' + vcAlertPK + ')">' : other += '<tr>';

							if (data[key].sAlertColor == 'red') {
								other += '<td class="text-center"><i class="fas fa-exclamation-circle text-danger"></i></td>';
							
							} else if (data[key].sAlertColor == 'yellow') {
								other += '<td class="text-center"><i class="fas fa-exclamation-triangle text-caution"></i></td>';
							}

							other += '<td>' + data[key].sTarget + '</td>';
							other += '<td>' + data[key].sVcMessage + '</td>';
							other += '<td>' + data[key].dAlertTime + '</td>';

							other += '</tr>';
							
							$('#tableOtherLog tbody').empty().append(other);
						}
					}
				}
			})
		}
		
		// 경고 알림 확인
		function vCenterAlertCheck(vcAlertPK) {
			
			// 알림 확인
			if (confirm('해당 vCenter 알림을 확인 하시겠습니까?') == true) {
				$.ajax({
					url: '/log/updateVCenterAlertConfirm.do',
					type: 'POST',
					data: {
						vcAlertPK: vcAlertPK
					},
					success: function(data) {
						
						// 확인 성공
						if (data == 1) {
							alert('알림 확인이 완료되었습니다.');
							location.reload();

						// 확인 실패
						} else {
							alert('알림 확인에 실패했습니다.');
							return false;
						}
					}
				});
		
			} else {
				return false;
			}
		}
	</script>
</body>

</html>