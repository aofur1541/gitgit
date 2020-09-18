<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/adminCheck.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				vCenterLog();
			});
	
			function vCenterLog() {

				$.ajax({
					url: "/log/selectVCenterLogList.do",

					success: function(data) {
						var html = '';
						var vm = '';
						var host = '';
						var dataStore = '';

						for (key in data) {
							var vc_alert_PK = "\'" + data[key].vcAlertPK + "\'";

							if (data[key].vcAlertPK.indexOf("vm") != -1) {
								if (data[key].nAlertCheck == 2) {
									vm += '<tr class="bg-alertCheck cpointer" onclick="dayVcenterAlertConfirm(' + vc_alert_PK + ')">';
								} else {
									vm += '<tr>';
								}

								if (data[key].sAlertColor == 'red') {
									vm += '<td class="text-center"><i class="icon-spam text-danger"></i></td>';
								} else if (data[key].sAlertColor == 'yellow') {
									vm += '<td class="text-center"><i class="icon-warning22 text-warning"></i></td>';
								}

								vm += '<td>' + data[key].sTarget + '</td>';
								vm += '<td>' + data[key].sVcMessage + '</td>';
								vm += '<td>' + data[key].dAlertTime + '</td>';

								vm += '</tr>';
								$("#vmlog").empty();
								$("#vmlog").append(vm);
							
							} else if (data[key].vcAlertPK.indexOf("host") != -1) {
								if (data[key].nAlertCheck == 2) {
									host += '<tr class="bg-alertCheck cpointer" onclick="dayVcenterAlertConfirm(' + vc_alert_PK + ')">';
								} else {
									host += '<tr>';
								}

								if (data[key].sAlertColor == 'red') {
									host += '<td class="text-center"><i class="icon-spam text-danger"></i></td>';
								} else if (data[key].sAlertColor == 'yellow') {
									host += '<td class="text-center"><i class="icon-warning22 text-warning"></i></td>';
								}

								host += '<td>' + data[key].sTarget + '</td>';
								host += '<td>' + data[key].sVcMessage + '</td>';
								host += '<td>' + data[key].dAlertTime + '</td>';

								host += '</tr>';
								$("#hostlog").empty();
								$("#hostlog").append(host);

							} else if (data[key].vcAlertPK.indexOf("datastore") != -1) {
								if (data[key].nAlertCheck == 2) {
									dataStore += '<tr class="bg-alertCheck cpointer" onclick="dayVcenterAlertConfirm(' + vc_alert_PK + ')">';
								} else {
									dataStore += '<tr>';
								}
								if (data[key].sAlertColor == 'red') {
									dataStore += '<td class="text-center"><i class="icon-spam text-danger"></i></td>';
								} else if (data[key].sAlertColor == 'yellow') {
									dataStore += '<td class="text-center"><i class="icon-warning22 text-warning"></i></td>';
								}

								dataStore += '<td>' + data[key].sTarget + '</td>';
								dataStore += '<td>' + data[key].sVcMessage + '</td>';
								dataStore += '<td>' + data[key].dAlertTime + '</td>';

								dataStore += '</tr>';
								$("#dataStorelog").empty();
								$("#dataStorelog").append(dataStore);
							
							} else {
								if (data[key].nAlertCheck == 2) {
									html += '<tr class="bg-alertCheck cpointer" onclick="dayVcenterAlertConfirm(' + vc_alert_PK + ')">';
								} else {
									html += '<tr>';
								}
								if (data[key].sAlertColor == 'red') {
									html += '<td class="text-center"><i class="icon-spam text-danger"></i></td>';
								} else if (data[key].sAlertColor == 'yellow') {
									html += '<td class="text-center"><i class="icon-warning22 text-warning"></i></td>';
								}
								html += '<td>' + data[key].sTarget + '</td>';
								html += '<td>' + data[key].sVcMessage + '</td>';
								html += '<td>' + data[key].dAlertTime + '</td>';

								html += '</tr>';
								$("#otherlog").empty();
								$("#otherlog").append(html);
							}
						}
					}
				})
			}
	
			function dayVcenterAlertConfirm(vc_alert_PK) {
				if (sessionApproval != BanNumber) {
					if (confirm("오늘 자 vCenter의 경고를 확인 하셨습니까?\n확인시 더 이상 상단에 경고창이 뜨지 않습니다.") == true) {
						$.ajax({
							data: {
								vcAlertPK: vc_alert_PK
							},
							url: "/log/updateVCenterAlertConfirm.do",
							success: function(data) {
								if (data == 1) {
									alert("확인이 완료되었습니다.");
									window.parent.location.reload();
								} else {
									alert("vCenter의 경고 확인에 실패하였습니다.");
								}
							},
							error: function() {
								alert("에러 : 연결 상태를 확인 해주십시오.");
							}
						})
					} else {
						return false;
					}
				} else {
					return false;
				};
			}
		</script>
	</head>
	<body>
		<div class="card mb-0 bg-dark mLogList table-type-4">
			<div class="row-padding-0">
				<div class="col-sm-12 col-xl-12 padding-0">
					<div class="card bg-dark mb-0 table-type-1">
						<div class="table-title-light">
							<h6 class="card-title mb-0">vCenter 로그</h6>
							<div class="d-flex">
								<div class="mr-2-5"><i class="icon-spam text-danger mr-2"></i>위험</div>
								<div><i class="icon-warning22 text-warning mr-2"></i>경고</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row-padding-0">
				<div class="col-sm-6 col-xl-6 padding-0 border-bottom-light">
					<div class="card bg-dark mb-0 table-type-1 table-type-2">
						<div class="table-title-dark">
							<h6 class="card-title mb-0">가상머신 로그</h6>
						</div>
						<div class="datatables-body">
							<table class="promTable hover" style="width:100%;">
								<thead>
									<tr>
										<th class="text-center">단계</th>
										<th>알림 대상</th>
										<th>알림 내용</th>
										<th>발생 일시</th>
									</tr>
								</thead>
								<tbody id="vmlog">
									<tr>
										<td class="text-center" colspan="4">데이터가 없습니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-xl-6 padding-0 border-bottom-light">
					<div class="card bg-dark mb-0 table-type-1 table-type-2">
						<div class="table-title-dark">
							<h6 class="card-title mb-0">호스트 로그</h6>
						</div>
						<div class="datatables-body">
							<table class="promTable hover" style="width:100%;">
								<thead>
									<tr>
										<th class="text-center">단계</th>
										<th>알림 대상</th>
										<th>알림 내용</th>
										<th>발생 일시</th>
									</tr>
								</thead>
								<tbody id="hostlog">
									<tr>
										<td class="text-center" colspan="4">데이터가 없습니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="row-padding-0">
				<div class="col-sm-6 col-xl-6 padding-0 border-bottom-light">
					<div class="card bg-dark mb-0 table-type-1 table-type-2">
						<div class="table-title-dark">
							<h6 class="card-title mb-0">데이터스토어 로그</h6>
						</div>
						<div class="datatables-body">
							<table id="datastoreLogTable" class="promTable hover" style="width:100%;">
								<thead>
									<tr>
										<th class="text-center">단계</th>
										<th>알림 대상</th>
										<th>알림 내용</th>
										<th>발생 일시</th>
									</tr>
								</thead>
								<tbody id="dataStorelog">
									<tr>
										<td class="text-center" colspan="4">데이터가 없습니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-xl-6 padding-0">
					<div class="card bg-dark mb-0 table-type-1 table-type-2">
						<div class="table-title-dark">
							<h6 class="card-title mb-0">기타 로그</h6>
						</div>
						<div class="datatables-body">
							<table class="promTable hover" style="width:100%;">
								<thead>
									<tr>
										<th class="text-center">단계</th>
										<th>알림 대상</th>
										<th>알림 내용</th>
										<th>발생 일시</th>
									</tr>
								</thead>
								<tbody id="otherlog">
									<tr>
										<td class="text-center" colspan="4">데이터가 없습니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>