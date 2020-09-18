<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<script src="${path}/resources/PROM_JS/adminCheck.js"></script>
	<meta http-equiv="Refresh" content="3300">
</head>

<body>
	<div class="mb-2 text-white"><h4 class="mb-0">데이터 센터 현황</h4></div>
	<div class="row">
		<div class="col-sm-6 col-xl-6 nolink">
			<div class="row">
				<div class="col-3">
					<div class="card bg-orange-300 dashWidget-type-1">
						<span>클러스터</span>
						<span id="dashTopcluAll">0</span>
					</div>
				</div>
				<div class="col-3">
					<div class="card bg-orange-300 cpointer dashWidget-type-1" onclick="location.href='/menu/inventoryStatus.do#3'">
						<span>호스트</span>
						<span id="dashTophostAll">0</span>
					</div>
				</div>
				<div class="col-3">
					<div class="card bg-green cpointer dashWidget-type-1" onclick="location.href='/menu/inventoryStatus.do#1'">
						<span>가상머신</span>
						<span id="dashTopvmAll">0</span>
					</div>
				</div>
				<div class="col-3">
					<div class="card bg-green cpointer dashWidget-type-1" onclick="location.href='/menu/Preferences.do#1'">
						<span>템플릿</span>
						<span id="dashToptemplateAll">0</span>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-xl-6 nolink">
			<div class="row">
				<div class="col-3">
					<div class="card bg-danger-300 cpointer dashWidget-type-1" onclick="location.href='/menu/tenantSetting.do#1'">
						<span>테넌트</span>
						<span class="font-size-lage" id="dashToptenAll">0</span>
					</div>
				</div>
				<div class="col-3">
					<div class="card bg-danger-300 cpointer dashWidget-type-1" onclick="location.href='/menu/tenantSetting.do#2'">
						<span>서비스</span>
						<span class="font-size-lage" id="dashTopserviceAll">0</span>
					</div>
				</div>
				<div class="col-3">
					<div class="card bg-blue-300 cpointer dashWidget-type-1" onclick="location.href='/menu/userSetting.do#2'">
						<span>부서</span>
						<span class="font-size-lage" id="dashTopdeptAll">0</span>
					</div>
				</div>
				<div class="col-3">
					<div class="card bg-blue-300 cpointer dashWidget-type-1" onclick="location.href='/menu/userSetting.do#3'">
						<span>사용자</span>
						<span class="font-size-lage" id="dashTopuserAll">0</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-4 col-xl-4 nolink">
			<div class="card bg-dark border-top-2 border-top-orange-300 border-bottom-2 border-bottom-orange-300 rounded-0 dashWidget-type-2">
				<div class="card-header cpointer" onclick="location.href='/menu/inventoryStatus.do#3'">
					<h5 class="card-title mb-0">물리 자원 현황<span>Physical resource status</span></h5>
				</div>
				<div class="card-body">
					<div class="row">
						<div class="col-2">
							<span class="text-muted">Core</span>
							<h3 class="mb-0" id="dashTopResourcePhysicssumCPU">0</h3>
						</div>
						<div class="col-3">
							<span class="text-muted">Memory</span>
							<h3 class="mb-0" id="dashTopResourcePhysicssumMemory">0 GB</h3>
						</div>
						<div class="col-3">
							<span class="text-muted">Storage</span>
							<h3 class="mb-0" id="dashTopResourcePhysicsall">0 GB</h3>
						</div>
						<div class="col-4">
							<span class="text-muted">여유 Storage</span>
							<h3 class="mb-0 text-orange-300" id="dashTopResourcePhysicsspace">0 GB</h3>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-4 col-xl-4 nolink">
			<div class="card bg-dark border-top-2 border-top-green border-bottom-2 border-bottom-green rounded-0 dashWidget-type-2">
				<div class="card-header cpointer" onclick="location.href='/menu/inventoryStatus.do#1'">
					<h5 class="card-title mb-0">가상머신 할당 현황<span>Virtual Machine Allocation Status</span></h5>
				</div>
				<div class="card-body">
					<div class="row">
						<div class="col-3">
							<span class="text-muted">vCPU</span>
							<h3 class="mb-0" id="dashTopResourcesumCPU">0</h3>
						</div>
						<div class="col-4">
							<span class="text-muted">Memory</span>
							<h3 class="mb-0" id="dashTopResourcesumMemory">0 GB</h3>
						</div>
						<div class="col-5">
							<span class="text-muted">Storage</span>
							<h3 class="mb-0" id="dashTopResourcesumDisk">0 GB</h3>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-4 col-xl-4 nolink">
			<div class="card bg-dark dashWidget-type-2">
				<div class="card-header cpointer" onclick="location.href='/menu/approvalManage.do#1'">
					<h5 class="card-title mb-0">신청 승인 현황<span>Application approval status</span></h5>
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

	<div class="mb-2 text-white"><h4 class="mb-0">클러스터별 현황</h4></div>
	
	<div class="row">
		<div class="col-sm-12 col-xl-12">
			<iframe src="/data/dashClusterWidget.do" width="100%" height="500" seamless></iframe>
		</div>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			getAllCountList();
			getAllResourceVMs();
			getAllResourcePhysics();
			getDashApprovalCheckcount();
			
			if(sessionApproval == BanNumber){
				ftnlimited(99);
				$( 'div' ).removeClass( 'cpointer' );
				$( 'h3' ).removeClass( 'cpointer' );
			}
			
		})

		function getAllCountList() {

			$.ajax({

				url: "/dash/getAllCountList.do",
				success: function(data) {
					for (key in data) {
						$("#dashTop" + key).empty();
						$("#dashTop" + key).append(numberWithCommas(data[key]));
					}
				}
			})
		}

		function getAllResourceVMs() {

			$.ajax({

				url: "/dash/getAllResourceVMs.do",
				success: function(data) {
					for (key in data) {

						$("#dashTopResource" + key).empty();
						if (key == 'sumMemory' || key == 'sumDisk') {
							$("#dashTopResource" + key).append(numberWithCommas(data[key]) + ' GB');
						} else {
							$("#dashTopResource" + key).append(numberWithCommas(data[key]));
						}

					}
				}
			})

		}

		function getAllResourcePhysics() {

			$.ajax({

				url: "/dash/getAllResourcePhysics.do",
				success: function(data) {

					for (key in data) {

						$("#dashTopResourcePhysics" + key).empty();
						if (key == 'sumMemory' || key == 'all' || key == 'space') {
							$("#dashTopResourcePhysics" + key).append(numberWithCommas(data[key]) + ' GB');
						} else {
							$("#dashTopResourcePhysics" + key).append(numberWithCommas(data[key]));
						}

					}
				}
			})
		}

		function getDashApprovalCheckcount() {

			$.ajax({

				url: "/dash/getAllApprovalCheckcnt.do",
				success: function(data) {
					var html = '';

					for (key in data) {

						$("#approval" + key).empty();
						if (data[key] > 0) {
							if(sessionApproval == BanNumber){ $("#approval" + key).attr('class', "mb-0 text-prom"); }
							else { $("#approval" + key).attr('class', "mb-0 text-prom cpointer"); }
							
						} else {
							$("#approval" + key).attr('class', "mb-0 text-white");
						}

						$("#approval" + key).append(numberWithCommas(data[key]));
					}
				}
			})
		}
	</script>
</body>

</html>