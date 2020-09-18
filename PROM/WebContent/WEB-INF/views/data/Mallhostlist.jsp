<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/adminCheck.js"></script>
	
		<script type="text/javascript">
			$(document).on('change', '#defaultClusterSB', function() {
				getHostsInClusterRefresh();
			})
	
			$(document).ready(function() {
				getDefaultClusterList();
			})
	
			function getHostsInCluster() {
				var clusterID = $("#defaultClusterSB option:selected").val();
				var hostTable = $("#hostTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/status/getHostsInCluster.do",
							"dataSrc": "",
							"data": function(d) {
								d.clusterId = clusterID
							},
						},
						columns: [
							{"data": "hostParent"},
							{"data": "vm_Hhostname",
								render: function(data, type, row) {
									if (type == 'display') {
										var hostLink = hostMonitoringLink(clusterID, data);
										data = '<a href="#" onclick="javascript:window.parent.location.href=' + hostLink + '">' + data + '</a>';
									}
									return data;
								}
							},
							{"data": "vm_Hcpu"},
							{"data": "vm_Hmemory"},
							{"data": "vm_Hver_bu"},
							{"data": "vm_Hvendor"},
							{"data": "host_model"},
							{"data": "vm_HIP"},
							{"data": "vm_Huptime",
								render: function(data, type, row) {
									data = data + '일';
									return data;
								}
							},
							{"data": "vm_HvmCount",
								render: function(data, type, row) {
									data = data + '개';
									return data;
								}
							},
							{"data": "sumCPU",
								render: function(data, type, row) {
									data = data + '%';
									return data;
								}
							},
							{"data": "sumMemory",
								render: function(data, type, row) {
									data = data + '%';
									return data;
								}
							},
						],
						lengthMenu: [
							[5, 10, 25, 50, -1],
							[5, 10, 25, 50, "All"]
						],
						pageLength: 10,
						responsive: true,
						columnDefs: [{
							visible: false,
							targets: 0
						}, {
							responsivePriority: 1,
							targets: -1
						}],
						order: [
							[0, "asc"],
							[1, "asc"]
						],
						dom: "<'datatables-header'<'row-padding-0'lf><'row-padding-0'B>>" + "<'datatables-body'rt>" + "<'datatables-footer'ip>",
						buttons: [{
							extend: "collection",
							text: "<i class='icon-import'></i><span class='ml-2'>내보내기</span>",
							className: "btn bg-prom dropdown-toggle",
							buttons: [{
									extend: "csvHtml5",
									charset: "UTF-8",
									bom: true,
									text: "CSV",
									title: "호스트 정보",
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "호스트 정보",
								}
							]
						}]
					});
			}
	
			function getDefaultClusterList() {
				$.ajax({
	
					url: "/tenant/selectClusterList.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html += '<option value=0 selected disabled>:: 클러스터가 존재하지 않습니다. ::</option>';
						} else {
	
							html += '<option value="clusterAll" selected>클러스터 전체</option>';
							for (key in data) {
								html += '<option value=' + data[key].clusterID + '>' + data[key].clusterName + '</option>';
							}
	
							$("#defaultClusterSB").empty();
							$("#defaultClusterSB").append(html);
							getHostsInClusterRefresh();
						}
					}
				})
			}
	
			function getHostsInClusterRefresh() {
				setTimeout(function() {
					var hostTable = $('#hostTable').DataTable();
					hostTable.destroy();
	
					getHostsInCluster();
				}, 50)
			}
		</script>
	</head>
	
	<body>
		<div class="card bg-dark mb-0 table-type-3 table-type-5-2">
			<div class="table-filter-light">
				<div class="col-xl-3 col-sm-6 width-100">
					<select class="form-control select-search" id="defaultClusterSB" data-fouc></select>
				</div>
			</div>
			<table id="hostTable" class="promTable hover" style="width:100%;">
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
						<th>가상머신 개수</th>
						<th>CPU (%)</th>
						<th>Memory (%)</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>