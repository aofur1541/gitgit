<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script>
			$(document).ready(function() {
				if (sessionApproval == BanNumber || sessionApproval == BanNumber2) {
					ftnlimited(1);
				}
	
				$("#tenantSelectBox").change(function() {
					tenantInservice();
				})
				getArrangementVMList();
				getUndeployedVMList();
				getTenantList();
	
				arrangementCheckboxCheck();
			});
	
			function arrangementCheckboxCheck() {
				$("input[name='arrangementCB']").click(function() {
					var arrangement = $("input:checkbox[name='arrangementCB']").is(":checked");
					if (arrangement == true) {
						$("input[name=serviceINVMCB]").prop("checked", true);
					} else {
						$("input[name=serviceINVMCB]").prop("checked", false);
					}
				});
	
				$("input[name='unArrangementCB']").click(function() {
					var unArrangement = $("input:checkbox[name='unArrangementCB']").is(":checked");
					if (unArrangement == true) {
						$("input[name=vmChoiceCB]").prop("checked", true);
					} else {
						$("input[name=vmChoiceCB]").prop("checked", false);
					}
				});
			}
	
			function modelValidation() {
				var vmChoiceCB = $("input[name='vmChoiceCB']:checked").val();
				if (!vmChoiceCB) {
					alert("서비스에 넣을 가상머신을 선택하십시오.");
					return false;
				} else {
					$("#modelStartBtn").trigger("click");
					$("#serviceArrangement").modal("show");
				}
			}
	
			function vmServiceExit() {
				var inVMList = [];
				var inVMListname = [];
				$("input[name='serviceINVMCB']:checked").each(function() {
					inVMList.push($(this).val());
				})
				$("input[name='serviceINVMCB']:checked").each(function() {
					inVMListname.push($(this).attr("value2"));
				})
				if (inVMList == '' || inVMList == null) {
					alert("내보낼 가상머신을 선택하십시오.");
					return false;
				} else {
					$.ajax({
						data: {
							vmIDList: inVMList,
							vmNameList: inVMListname,
						},
						url: "/tenant/unarrangeVM.do",
						traditional: true,
						type: 'POST',
						async: false,
						success: function(data) {
							window.parent.location.reload();
						}
					})
				}
			}
	
			function vmStatusUpdateValidation() {
				var vmChoicelist = [];
				var vmChoicelistName = [];
				var vmChoiceCB = $("input[name='vmChoiceCB']:checked").val();
				var tenantsID = $("#tenantSelectBox option:selected").val();
				var tenantsName = $("#tenantSelectBox option:selected").attr("value2");
				var serviceSelectBox = $("#serviceSelectBox option:selected").val();
				var serviceSelectBoxName = $("#serviceSelectBox option:selected").attr("value2");
	
				if (!vmChoiceCB) {
					alert("서비스에 넣을 가상머신을 선택하십시오.");
					return false;
				} else if (!tenantsID) {
					alert("테넌트를 선택하십시오.");
					return false;
				} else if (!serviceSelectBox || serviceSelectBox == 0) {
					alert("서비스를 선택하십시오.");
					return false;
				} else {
	
					$("input[name='vmChoiceCB']:checked").each(function() {
						vmChoicelist.push($(this).val());
					})
					$("input[name='vmChoiceCB']:checked").each(function() {
						vmChoicelistName.push($(this).attr("value2"));
					})
					$.ajax({
						data: {
							vmIDList: vmChoicelist,
							vmNameList: vmChoicelistName,
							vmServiceID: serviceSelectBox,
							tenantName: tenantsName,
							vmServiceName: serviceSelectBoxName
						},
						url: "/tenant/arrangeVM.do",
						type: "POST",
						traditional: true,
						async: false,
						success: function(data) {
							window.parent.location.reload();
	
						}
					})
				}
			}
	
			function getTenantList() {
				$.ajax({
	
					url: "/tenant/selectTenantList.do",
					success: function(data) {
						var html = '';
						html += '<option value=0 selected disabled>:: 테넌트를 선택하십시오. ::</option>';
						for (key in data) {
							html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
						}
						$("#tenantSelectBox").empty();
						$("#tenantSelectBox").append(html);
					}
				})
			}
	
			function tenantInservice() {
				var tenantsID = $("#tenantSelectBox option:selected").val();
				$.ajax({
					data: {
						tenantId: tenantsID
					},
					url: "/tenant/selectVMServiceListByTenantId.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value=0 selected disabled>:: 해당 테넌트에 포함된 서비스가 없습니다. ::</option>';
						} else {
							for (key in data) {
								html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].vmServiceName + '>' + data[key].vmServiceName + '</option>';
							}
						}
						$("#serviceSelectBox").empty();
						$("#serviceSelectBox").append(html);
					}
				})
			}
	
			function clickONcheck(value) {
				if (!$("#" + value).is(":checked")) {
					$('input:checkbox[id=' + value + ']').prop("checked", true);
				} else {
					$('input:checkbox[id=' + value + ']').prop("checked", false);
				}
			}
	
			function getArrangementVMList() {
				var arrangementTable = $("#arrangementTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/tenant/selectArrangedVMList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "tenantName"},
							{"data": "vmServiceName"},
							{"data": "vmName"},
							{"data": "vmCPU"},
							{"data": "vmMemory",
								render: function(data, type, row) {
									data = data + ' GB';
									return data;
								}
							},
							{"data": "vmDisk",
								render: function(data, type, row) {
									data = data + ' GB';
									return data;
								}
							},
							{"data": "vmID",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
	
									html += '<div class="custom-control custom-checkbox ml-4">';
									html += '<input type="checkbox" class="custom-control-input" value="' + data + '" value2="' + row.vmName + '" name="serviceINVMCB" id="vmArrangementCB' + data + '">';
									html += '<label class="custom-control-label" for="vmArrangementCB' + data + '">&nbsp;</label>';
									html += '</div>';
	
									return html;
								},
								className: "text-center"
							}
						],
						lengthMenu: [
							[5, 10, 25, 50, -1],
							[5, 10, 25, 50, "All"]
						],
						pageLength: 10,
						responsive: true,
						columnDefs: [{
							responsivePriority: 1,
							targets: 0
						}, {
							responsivePriority: 2,
							targets: -1
						}],
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
									title: "서비스 배치 가상머신",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "서비스 배치 가상머신",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5]
									}
								}
							]
						}]
					});
			}
	
			function getUndeployedVMList() {
				var unArrangementTable = $("#unArrangementTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/tenant/selectUnarrangedVMList.do",
							"dataSrc": ""
						},
						columns: [
							{"data": "vmName"},
							{"data": "vmCPU"},
							{"data": "vmMemory",
								render: function(data, type, row) {
									data = data + ' GB';
									return data;
								}
							},
							{"data": "vmDisk",
								render: function(data, type, row) {
									data = data + ' GB';
									return data;
								}
							},
							{"data": "vmID",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
	
									html += '<div class="custom-control custom-checkbox ml-4">';
									html += '<input type="checkbox" class="custom-control-input" value="' + data + '" value2="' + row.vmName + '" name="vmChoiceCB" id="vmundeployCB' + data + '">';
									html += '<label class="custom-control-label" for="vmundeployCB' + data + '">&nbsp;</label>';
									html += '</div>';
	
									return html;
								},
								className: "text-center"
							}
						],
						lengthMenu: [
							[5, 10, 25, 50, -1],
							[5, 10, 25, 50, "All"]
						],
						pageLength: 10,
						responsive: true,
						columnDefs: [{
							responsivePriority: 1,
							targets: 0
						}, {
							responsivePriority: 2,
							targets: -1
						}],
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
									title: "서비스 미배치 가상머신",
									exportOptions: {
										columns: [0, 1, 2, 3]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "서비스 미배치 가상머신",
									exportOptions: {
										columns: [0, 1, 2, 3]
									}
								}
							]
						}]
					});
			}
		</script>
	</head>
	
	<body>
		<div id="serviceArrangement" class="modal fade" tabindex="-1">
			<div class="modal-dialog modal-sm">
				<div class="modal-content" style="margin-top: 100px">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">가상머신 배치하기</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body modal-type-5">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>테넌트:<span class="text-prom ml-2">(필수)</span></label>
									<select class="form-control form-control-select2" id="tenantSelectBox" data-fouc></select>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>서비스:<span class="text-prom ml-2">(필수)</span></label>
									<select class="form-control form-control-select2" id="serviceSelectBox" data-fouc>
										<option value="" selected disabled>:: 테넌트 선택 후 선택할 수 있습니다. ::</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white">
						<button type="button" class="btn bg-prom rounded-round" onclick="vmStatusUpdateValidation()">완료<i class="icon-checkmark2 ml-2"></i></button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="card mb-0 bg-dark table-type-4">
			<div class="row-padding-0">
				<div class="col-xl-6 padding-0 border-bottom-light">
					<div class="card bg-dark mb-0 table-type-1 table-type-5-2">
						<div class="table-title-light">
							<h6 class="card-title mb-0">서비스 배치 가상머신</h6>
							<div>
								<span>제외하기</span>
								<button type="button" class="btn btn-outline bg-prom border-prom text-prom btn-icon rounded-round border-2 ml-2" onclick="vmServiceExit()"><i class="icon-arrow-right8"></i></button>
							</div>
						</div>
						<table id="arrangementTable" class="promTable hover border-0" style="width:100%;">
							<thead>
								<tr>
									<th>테넌트명</th>
									<th>서비스명</th>
									<th>가상머신명</th>
									<th>vCPU</th>
									<th>Memory</th>
									<th>Disk</th>
									<th>
										<div class="custom-control custom-checkbox ml-4">
											<input type="checkbox" class="custom-control-input" name="arrangementCB" id="arrangementCB">
											<label class="custom-control-label" for="arrangementCB">&nbsp;</label>
										</div>
									</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				<div class="col-xl-6 padding-0">
					<div class="card bg-dark mb-0 table-type-1 table-type-5-2">
						<div class="table-title-light">
							<h6 class="card-title mb-0">서비스 미배치 가상머신</h6>
							<div>
								<span>배치하기</span>
								<button type="button" class="btn btn-outline bg-prom border-prom text-prom btn-icon rounded-round border-2 ml-2" onclick="modelValidation()"><i class="icon-arrow-left8"></i></button>
							</div>
						</div>
						<table id="unArrangementTable" class="promTable hover" style="width:100%;">
							<thead>
								<tr>
									<th>가상머신명</th>
									<th>vCPU</th>
									<th>Memory</th>
									<th>Disk</th>
									<th>
										<div class="custom-control custom-checkbox ml-4">
											<input type="checkbox" class="custom-control-input" name="unArrangementCB" id="unArrangementCB">
											<label class="custom-control-label" for="unArrangementCB">&nbsp;</label>
										</div>
									</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>