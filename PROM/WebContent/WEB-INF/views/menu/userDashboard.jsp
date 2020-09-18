<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Refresh" content="60">
	</head>
	<body>
		<div class="row">
			<div class="col-sm-6 col-xl-3">
				<div class="card bg-dark border-bottom-prom rounded-bottom-0 dashWidget-type-3">
					<div class="card-header bg-prom">
						<h5 class="card-title">테넌트: <span id="tenantID"></span></h5>
					</div>
					<div class="card-body d-flex justify-content-between align-items-center">
						<div>
							<h6 class="mb-0">테넌트에 포함된 서비스 개수</h6>
							<div class="text-muted">Services included in the tenant</div>
						</div>
						<h1 class="mb-0"><b id="tenantInServiceNum">0</b></h1>
					</div>
				</div>
			</div>
			
			<div class="col-sm-6 col-xl-3">
				<div class="row">
					<div class="col-12">
						<div class="card bg-dark cpointer dashWidget-type-5" onclick="location.href='/menu/inventoryStatus.do#1.do#1'">
							<div class="card-body d-flex justify-content-between align-items-center">
								<h6 class="mb-0">운영 중인 가상머신 개수</h6>
								<h1 class="mb-0"><b id="vmOnNum">0</b><span class="font-size-base ml-2">VMs</span></h1>
							</div>
						</div>
					</div>
					<div class="col-12">
						<div class="card bg-dark cpointer dashWidget-type-5" onclick="location.href='/menu/inventoryStatus.do#1'">
							<div class="card-body d-flex justify-content-between align-items-center">
								<h6 class="mb-0">전원이 꺼진 가상머신 개수</h6>
								<h1 class="mb-0"><b id="vmOffNum">0</b><span class="font-size-base ml-2">VMs</span></h1>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm-6 col-xl-3">
				<div class="card bg-dark dashWidget-type-2">
					<div class="card-header cpointer" onclick="location.href='/menu/inventoryStatus.do#1'">
						<h5 class="card-title mb-0">
							가상머신 할당 현황<span>Virtual machine resource quotas</span>
						</h5>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-3">
								<span class="text-muted">vCPU</span>
								<h3 class="mb-0" id="vmUseCpu"></h3>
							</div>
							<div class="col-4">
								<span class="text-muted">Memory</span>
								<h3 class="mb-0" id="vmUseMemory"></h3>
							</div>
							<div class="col-5">
								<span class="text-muted">Storage</span>
								<h3 class="mb-0" id="vmUseDisk"></h3>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm-6 col-xl-3">
				<div class="card bg-dark dashWidget-type-2">
					<div class="card-header cpointer" onclick="location.href='/menu/approvalManage.do#1'">
						<h5 class="card-title mb-0">승인 신청 현황<span>Application approval status</span>
						</h5>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-4">
								<span class="text-muted">신규</span>
								<h3 class="mb-0" id="approvalcreateCnt" onclick="location.replace('/menu/approvalManage.do#1')">0</h3>
							</div>
	
							<div class="col-4">
								<span class="text-muted">변경</span>
								<h3 class="mb-0" id="approvalupdateCnt" onclick="location.replace('/menu/approvalManage.do#2')">0</h3>
							</div>
	
							<div class="col-4">
								<span class="text-muted">반환</span>
								<h3 class="mb-0" id="approvalreturnCnt" onclick="location.replace('/menu/approvalManage.do#3')">0</h3>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-6 col-xl-6">
				<div class="card bg-dark dashWidget-type-4 dashWidget-type-4-1">
					<div class="card-header">
						<h6 class="card-title mb-0">
							vCPU 사용량 TOP 5<span>데이터 로딩 시간 : <span id="vmUseTimeCPU"></span></span>
						</h6>
					</div>
					<div class="card bg-dark mb-0 table-type-2 table-type-5-7">
						<div class="datatables-body">
							<table class="promTable hover" style="width:100%;">
								<thead>
									<tr>
										<th>이름</th>
										<th>vCPU</th>
										<th>Memory</th>
										<th>Disk</th>
										<th>Network</th>
									</tr>
								</thead>
								<tbody id="vmRankingCPUTop5">
									<tr>
										<td class="text-center" colspan="5">데이터가 없습니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-6 col-xl-6">
				<div class="card bg-dark dashWidget-type-4 dashWidget-type-4-2">
					<div class="card-header">
						<h6 class="card-title mb-0">
							Memory 사용량 TOP 5<span>데이터 로딩 시간 : <span id="vmUseTimeMemory"></span></span>
						</h6>
					</div>
					<div class="card bg-dark mb-0 table-type-2 table-type-5-7">
						<div class="datatables-body">
							<table class="promTable hover" style="width:100%;">
								<thead>
									<tr>
										<th>이름</th>
										<th>vCPU</th>
										<th>Memory</th>
										<th>Disk</th>
										<th>Network</th>
									</tr>
								</thead>
								<tbody id="vmRankingMemoryTop5">
									<tr>
										<td class="text-center" colspan="5">데이터가 없습니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-6 col-xl-6">
				<div class="card bg-dark dashWidget-type-4 dashWidget-type-4-3">
					<div class="card-header">
						<h6 class="card-title mb-0">
							Disk 사용량 TOP 5<span>데이터 로딩 시간 : <span id="vmUseTimeDisk"></span></span>
						</h6>
					</div>
					<div class="card bg-dark mb-0 table-type-2 table-type-5-7">
						<div class="datatables-body">
							<table class="promTable hover" style="width:100%;">
								<thead>
									<tr>
										<th>이름</th>
										<th>vCPU</th>
										<th>Memory</th>
										<th>Disk</th>
										<th>Network</th>
									</tr>
								</thead>
								<tbody id="vmRankingDiskTop5">
									<tr>
										<td class="text-center" colspan="5">데이터가 없습니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-6 col-xl-6">
				<div class="card bg-dark dashWidget-type-4 dashWidget-type-4-4">
					<div class="card-header">
						<h6 class="card-title mb-0">
							Network 사용량 TOP 5<span>데이터 로딩 시간 : <span id="vmUseTimeNetwork"></span></span>
						</h6>
					</div>
					<div class="card bg-dark mb-0 table-type-2 table-type-5-7">
						<div class="datatables-body">
							<table class="promTable hover" style="width:100%;">
								<thead>
									<tr>
										<th>이름</th>
										<th>vCPU</th>
										<th>Memory</th>
										<th>Disk</th>
										<th>Network</th>
									</tr>
								</thead>
								<tbody id="vmRankingNetworkTop5">
									<tr>
										<td class="text-center" colspan="5">데이터가 없습니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			$(document).ready(function() {
				vmRanking('cpu');
				vmRanking('memory');
				vmRanking('disk');
				vmRanking('network');
				getUserDashServiceNotApplyList();
				getTenantlowerRank();
				getTenantVM();
				getTenantInfo();
				dashboardReflash();
			});
	
			function dashboardReflash() {
				var targetName = 'reflashInterval';
				$.ajax({
					url: "/config/selectBasic.do",
					data: {
						targetName: targetName
					},
					success: function(data) {
						if (data == null || data == '') {
							var reflashUpdate = $('meta[http-equiv="Refresh"]').attr('content', 20);
						} else {
							var reflashUpdate = $('meta[http-equiv="Refresh"]').attr('content', data.value);
						}
					}
				})
			}
	
			function getTenantVM() {
				$.ajax({
					url: "/jquery/getTenantVM.do",
					success: function(data) {
						var poweredOn = '';
						var poweredOff = '';
						var vCPU = '';
						var memory = '';
						var disk = '';
						if (data['powerOn'] != null) {
							poweredOn = data['powerOn'];
						} else {
							poweredOn = 0;
						}
						if (data['powerOff'] != null) {
							poweredOff = data['powerOff'];
						} else {
							poweredOff = 0;
						}
						if (data['cpu'] != null) {
							vCPU = data['cpu'];
						} else {
							vCPU = '0';
						}
						if (data['memory'] != null) {
							memory = data['memory'];
						} else {
							memory = '0';
						}
						if (data['disk'] != null) {
							disk = data['disk'];
						} else {
							disk = '0';
						}
						$("#vmOnNum").html(poweredOn);
						$("#vmOffNum").html(poweredOff);
						
						$("#vmUseCpu").html(vCPU);
						$("#vmUseMemory").html(memory + ' GB');
						$("#vmUseDisk").html(disk + ' GB');
					}
				})
			}
	
			function getTenantInfo() {
				$.ajax({
					url: "/tenant/selectTenantByLoginUserTenantId.do",
					success: function(data) {
						var tenant = '';
						if (data == null || data == '') {
							tenant = '미지정';
						} else {
							tenant = data.name;
						}
						$("#tenantID").empty();
						$("#tenantID").append(tenant);
					}
				})
			}
	
			function getTenantlowerRank() {
				$.ajax({
					url: "/jquery/getTenantlowerRank.do",
					success: function(data) {
						var service = '';
						service += data.length;
						$("#tenantInServiceNum").empty();
						$("#tenantInServiceNum").append(service);
					}
				})
			}
	
			function getUserDashServiceNotApplyList() {
				$.ajax({
					url: "/dash/getOneTenantsApprovalCheckcnt.do",
					success: function(data) {
						var html = '';
						for (key in data) {
							$("#approval" + key).empty();
							if (data[key] > 0) {
								$("#approval" + key).attr('class', "mb-0 text-prom cpointer");
							} else {
								$("#approval" + key).attr('class', "mb-0 text-white");
							}
							$("#approval" + key).append(data[key]);
						}
					}
				})
			}
	
			function vmRanking(target) {
				var orderKey = target;
				$.ajax({
					url: "/jquery/getUserVMRanking.do",
					data: {
						orderKey: orderKey
					},
					success: function(data) {
						var html = '';
						for (key in data) {
							var disk_KBtoMB = Math.floor(data[key].disk / 1024);
							var network_KBtoMB = Math.floor(data[key].network / 1024);
							if (data[key].tenants_id == 0) {
								ten = 'De';
							} else {
								ten = data[key].tenants_id;
							}
							var vmLink = "\'" + '/menu/monitoring.do?vn=' + data[key].id + '&ten=' + ten + '' + "#1\'";
							html += '<tr class="cpointer" onclick="javascript:window.parent.location.href=' + vmLink + '">';
							html += '<td>' + data[key].name + '</td>';
							if (data[key].cpu > 90) {
								html += '<td class="text-danger">' + data[key].cpu + '%</td>';
							} else if (data[key].cpu > 80) {
								html += '<td class="text-warning">' + data[key].cpu + '%</td>';
							} else if (data[key].cpu > 70) {
								html += '<td class="text-orange">' + data[key].cpu + '%</td>';
							} else {
								html += '<td>' + data[key].cpu + '%</td>';
							}
							if (data[key].memory > 90) {
								html += '<td class="text-danger">' + data[key].memory + '%</td>';
							} else if (data[key].memory > 80) {
								html += '<td class="text-warning">' + data[key].memory + '%</td>';
							} else if (data[key].memory > 70) {
								html += '<td class="text-orange">' + data[key].memory + '%</td>';
							} else {
								html += '<td>' + data[key].memory + '%</td>';
							}
							if (disk_KBtoMB > 0) {
								html += '<td>' + disk_KBtoMB + 'MB</td>';
							} else {
								html += '<td>' + data[key].disk + 'KB</td>';
							}
							if (network_KBtoMB > 0) {
								html += '<td>' + network_KBtoMB + 'MB</td>';
							} else {
								html += '<td>' + data[key].network + 'KB</td>';
							}
							html += '</tr>';
						}
						$("#vmUseTimeCPU").empty();
						$("#vmUseTimeMemory").empty();
						$("#vmUseTimeDisk").empty();
						$("#vmUseTimeNetwork").empty();
						if (data.length > 0) {
							$("#vmUseTimeCPU").append(data[0].timeString);
							$("#vmUseTimeMemory").append(data[0].timeString);
							$("#vmUseTimeDisk").append(data[0].timeString);
							$("#vmUseTimeNetwork").append(data[0].timeString);
							if (target == 'cpu') {
								$("#vmRankingCPUTop5").empty();
								$("#vmRankingCPUTop5").append(html);
							} else if (target == 'memory') {
								$("#vmRankingMemoryTop5").empty();
								$("#vmRankingMemoryTop5").append(html);
							} else if (target == 'disk') {
								$("#vmRankingDiskTop5").empty();
								$("#vmRankingDiskTop5").append(html);
							} else if (target == 'network') {
								$("#vmRankingNetworkTop5").empty();
								$("#vmRankingNetworkTop5").append(html);
							}
						}
					},
					error: function() {
						console.log("vmRanking error");
					}
				})
			}
		</script>
	</body>
</html>