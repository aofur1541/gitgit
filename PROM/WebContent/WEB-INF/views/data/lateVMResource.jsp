<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
		var overuseVMTable = '';
			$(document).ready(function() {
				var usevCPU = $("#usevCPU").val();
				var useMemory = $("#useMemory").val();
	
				if(sessionApproval == BanNumber){
				ftnlimited(5);
				}
				
				if (sessionApproval > ADMINCHECK) {
					$("#parentCluster").show();
					$("#parentTenants").hide();
					getClusterListCaseTwo();
					setTimeout(function(){
					lateVMlist(usevCPU, useMemory);
					},600)
				} else if (sessionApproval < ADMINCHECK) {
					$("#parentCluster").hide();
					$("#parentTenants").show();
					getUserTenants();
					userlateVMlist(usevCPU, useMemory);
				}
				
				$(document).on('change', '#categorySB', function() {

					var category = $("#categorySB option:selected").val();
					
					if ( category == 'clusterChoiceAll' ) {
						$("#parentCluster").show();
						$("#parentTenants").hide();
						getClusterListCaseTwo();
					} else if( category == 'tenantsChoiceAll' ) {
						$("#parentCluster").hide();
						$("#parentTenants").show();
						getTenantsCaseOne();
					}
					
				})
				
			})
			
			function getUserTenants(){
				
				$.ajax({
					url : "/tenant/getLoginUserTenantId.do",
					success:function(data){
						if(data > 0){
						getTenantsCaseOne(data);
						}
					}
				})
			}
	
			function usageSetting() {
	
				var usevCPU = $("#usevCPU").val();
				var useMemory = $("#useMemory").val();
	
				if (usevCPU < 0 || usevCPU > 100) {
					alert("vCPU 값은 0이상 100이하의 값만 설정 가능합니다.");
					$("#usevCPU").focus();
					return false;
				} else if (!usevCPU) {
					alert("vCPU 값을 설정 하십시오.");
					$("#usevCPU").focus();
					return false;
				} else if (!useMemory) {
					alert("Memory 값을 설정 하십시오.");
					$("#useMemory").focus();
					return false;
				} else if (useMemory < 0 || useMemory > 100) {
					alert("Memory 값은 0이상 100이하의 값만 설정 가능합니다.");
					$("#useMemory").focus();
					return false;
				} else {
					var overuseVMTable = $("#overuseVMTable").DataTable();
					overuseVMTable.destroy()

					 if (sessionApproval > ADMINCHECK) {
						lateVMlist(usevCPU, useMemory);
	
					} else if (sessionApproval < ADMINCHECK) {
						userlateVMlist(usevCPU, useMemory);
					} 
				}
			}
	
			function userlateVMlist(usevCPU, useMemory) {
				var overuseVMTable = $("#overuseVMTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/jquery/userlateVMlist.do",
							"dataSrc": "",
							"data": function(d) {
								d.usevCPU = usevCPU,
									d.useMemory = useMemory
							}
						},
						columns: [
							{"data": "usagevCPU",
								render: function(data, type, row) {
									var usevCPU = $("#usevCPU").val();
	
									data = usevCPU + ' %';
									return data;
								}
							},
							{"data": "usagevMemory",
								render: function(data, type, row) {
									var useMemory = $("#useMemory").val();
	
									data = useMemory + ' %';
									return data;
								}
							},
							{"data": "name",
								render: function(data, type, row) {
									var idReplace = "\'" + row.id + "\'";
									var parentToString = '';
									var childToString = '';
									var category = '';
									
									category = "\'" +$("#categorySB option:selected").val()+ "\'";
									
										parentToString =  row.tenants_id;
										childToString =  row.service_id;
										
										data = '<a href="#" onclick="usageStLink('+category+','+parentToString+','+childToString+','+ idReplace + ',' + 5 + ',' + row.timestamp + ')">' + data + '</a>';
	
									return data;
								}
							},
							{"data": "cpu",
								render: function(data, type, row) {
									var usevCPU = $("#usevCPU").val();
	
									if (data >= usevCPU) {
										data = '<span class="text-warning">' + data + ' %</span>';
									} else {
										data = data + ' %';
									}
									return data;
								}
							},
							{"data": "memory",
								render: function(data, type, row) {
									var useMemory = $("#useMemory").val();
	
									if (data >= useMemory) {
										data = '<span class="text-warning">' + data + ' %</span>';
									} else {
										data = data + ' %';
									}
									return data;
								}
							},
							{"data": "disk",
								render: function(data, type, row) {
									var disk_KBtoMB = Math.floor(data / 1024);
	
									if (disk_KBtoMB > 0) {
										data = disk_KBtoMB + ' MB';
									} else {
										data = data + ' KB';
									}
									return data;
								}
							},
							{"data": "network",
								render: function(data, type, row) {
									var network_KBtoMB = Math.floor(data / 1024);
	
									if (network_KBtoMB > 0) {
										data = network_KBtoMB + ' MB';
									} else {
										data = data + ' KB';
									}
									return data;
								}
							},
							{"data": "timeString"}
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
							},
							{
								visible: false,
								targets: 1
							},
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
									title: "과사용 가상머신",
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "과사용 가상머신",
								}
							]
						}]
					});
			};
	
			function lateVMlist(usevCPU, useMemory) {
				
				var category = $("#categorySB option:selected").val();
				var choiceValue = '';
				var index = 0;
				
				if ( category == 'clusterChoiceAll' ) {
					choiceValue = $("#defaultClusterSB option:selected").change().val();
					index = 0;
				} else if( category == 'tenantsChoiceAll' ) {
					choiceValue = $("#defaultTenantsSB option:selected").val();
					index = 1;
				}
				
				overuseVMTable = $("#overuseVMTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/jquery/lateVMlist.do",
							"dataSrc": "",
							"data": function(d) {
								d.usevCPU = usevCPU,
								d.useMemory = useMemory,
								d.choiceValue = choiceValue,
								d.index = index
							}
						},
						columns: [
							{"data": "usagevCPU",
								render: function(data, type, row) {
									var usevCPU = $("#usevCPU").val();
	
									data = usevCPU + ' %';
									return data;
								}
							},
							{"data": "usagevMemory",
								render: function(data, type, row) {
									var useMemory = $("#useMemory").val();
	
									data = useMemory + ' %';
									return data;
								}
							},
							{"data": "name",
								render: function(data, type, row) {
									var idReplace = "\'" + row.id + "\'";
									var parentToString = '';
									var childToString = '';
									var category = '';
									
									category = "\'" +$("#categorySB option:selected").val()+ "\'";
									
									if(row.clusterId != null) {
										parentToString = "\'" + row.clusterId + "\'";
										childToString = "\'" + row.hostName + "\'";
									} else if(row.tenants_id != null){
										parentToString =  row.tenants_id;
										childToString =  row.service_id;
									}
									
									if(sessionApproval == BanNumber){
									data = data;	
									} else {
									data = '<a href="#" onclick="usageStLink('+category+','+parentToString+','+childToString+','+ idReplace + ',' + 5 + ',' + row.timestamp + ')">' + data + '</a>';
									}
									
									return data;
								}
							},
							{"data": "cpu",
								render: function(data, type, row) {
									var usevCPU = $("#usevCPU").val();
	
									if (data >= usevCPU) {
										data = '<span class="text-warning">' + data + ' %</span>';
									} else {
										data = data + ' %';
									}
									return data;
								}
							},
							{"data": "memory",
								render: function(data, type, row) {
									var useMemory = $("#useMemory").val();
	
									if (data >= useMemory) {
										data = '<span class="text-warning">' + data + ' %</span>';
									} else {
										data = data + ' %';
									}
									return data;
								}
							},
							{"data": "disk",
								render: function(data, type, row) {
									var disk_KBtoMB = Math.floor(data / 1024);
	
									if (disk_KBtoMB > 0) {
										data = disk_KBtoMB + ' MB';
									} else {
										data = data + ' KB';
									}
									return data;
								}
							},
							{"data": "network",
								render: function(data, type, row) {
									var network_KBtoMB = Math.floor(data / 1024);
	
									if (network_KBtoMB > 0) {
										data = network_KBtoMB + ' MB';
									} else {
										data = data + ' KB';
									}
									return data;
								}
							},
							{"data": "timeString"}
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
							},
							{
								visible: false,
								targets: 1
							},
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
									title: "과사용 가상머신",
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "과사용 가상머신",
								}
							]
						}]
					});
			}
	
			function usageStLink(category,parent,child,id, timeset, timestamp) {
				window.parent.location.href = '/menu/statisticsManagement.do?ca='+category+'&pa='+parent+'&ch='+child+'&vn=' + id + '&ts=' + timeset + '&dt=' + timestamp+"#1";
			}
		</script>
</head>
<body>
	<div class="card bg-dark mb-0 table-type-3 table-type-5-4">
		<div class="table-filter-light">
			<div class="col-xl-2 col-sm-2">
				<select class="form-control select" id="categorySB" data-fouc>
					<c:if test="${sessionAppEL > ADMINCHECK}">
						<option value="clusterChoiceAll">클러스터별</option>
					</c:if>
					<option value="tenantsChoiceAll">테넌트별</option>
				</select>
			</div>
			<div class="col-xl-3 col-sm-3" id="parentCluster">
				<select class="form-control select-search" id="defaultClusterSB" data-fouc>
				</select>
			</div>
			<div class="col-xl-3 col-sm-3" id="parentTenants">
				<select class="form-control select-search" id="defaultTenantsSB" data-fouc>
				</select>
			</div>
			<div class="col-xl-2 col-sm-5">
				<div class="input-group">
					<span class="input-group-prepend"> <span
						class="input-group-text">vCPU</span>
					</span> <input type="number" class="form-control" min="0" max="100"
						value="70" id="usevCPU">
				</div>
			</div>
			<div class="col-xl-2 col-sm-5">
				<div class="input-group">
					<span class="input-group-prepend"> <span
						class="input-group-text">Memory</span>
					</span> <input type="number" class="form-control" min="0" max="100"
						value="70" id="useMemory">
				</div>
			</div>
			<div class="col-xl-1 col-sm-2 width-100">
				<button type="button" class="btn bg-prom col-md-12 filterBtn"
					onclick="usageSetting()">
					<i class="icon-filter3 mr-2"></i>결과 조회
				</button>
			</div>
		</div>
		<table id="overuseVMTable" class="promTable hover"
			style="width: 100%;">
			<thead>
				<tr>
					<th>기준 vCPU</th>
					<th>기준 Memory</th>
					<th>가상머신명</th>
					<th>vCPU</th>
					<th>Memory</th>
					<th>Disk</th>
					<th>Network</th>
					<th>일시 (peak time)</th>
				</tr>
			</thead>
		</table>
	</div>
</body>
</html>