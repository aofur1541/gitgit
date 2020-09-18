<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			var global_order = null;
			$(document).ready(function() {
				if (sessionApproval <= CONTROLCHECK) {
					ftnlimited(3);
				}
				getTemplateList();
			});
	
			function templateUpdateEnterkey(id, name) {
				if (window.event.keyCode == 13) {
					templateUpdate(id, name);
				}
			}
	
			function getTemplateList() {
	
				var templateTable = $("#templateTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/config/selectVMTemplateList.do",
							"dataSrc": ""
						},
						columns: [
							{"data": "vmName"},
							{"data": "vmOS"},
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
							{"data": "description"},
							{"data": "templateOnoff",
								render: function(data, type, row) {
									if (data == 1) {
										data = '<span class="text-prom">ON</span>';
									} else if (data == 0) {
										data = '<span class="text-muted">OFF</span>';
									}
									return data;
								}
							},
							{"data": "vmID",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
	
									var name = "\'" + row.vmName + "\'";
									var ID = "\'" + data + "\'";
	
									if (sessionApproval != BanNumber && sessionApproval > CONTROLCHECK) {
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
										html += '<a href="#" class="dropdown-item" onclick="templateUpdateValidation(' + ID + ',' + name + ',' + 1 + ')"><i class="icon-file-text"></i>상세 보기</a>';
										html += '<a href="#" class="dropdown-item" onclick="templateUpdateValidation(' + ID + ',' + name + ',' + 2 + ')"><i class="icon-pencil7"></i>정보 변경</a>';
										html += '</div>';
									} else {
										html += '<i class="icon-lock2"></i>';
									}
									return html;
								}
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
									title: "템플릿 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "템플릿 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6]
									}
								}
							]
						}]
					});
			}
	
			function templateUpdateValidation(id, name, index) {
				$.ajax({
					data: {
						vmID: id
					},
					url: "/config/selectVMTemplate.do",
					success: function(data) {
	
						if (data.templateOnoff == 0) {
							$("input:radio[name='template_onoffup'][value='0']").prop("checked", true);
						} else if (data.templateOnoff == 1) {
							$("input:radio[name='template_onoffup'][value='1']").prop("checked", true);
						}
	
						btnStatusChk(id, name, index);
	
						$("#templateNameup").val(data.vmName);
						$("#OSNameup").val(data.vmOS);
						$("#Diskup").val(data.vmDisk);
						$("#Memoryup").val(data.vmMemory);
						$("#vCPUup").val(data.vmCPU);
						$("#descriptionup").val(data.description);
	
						$("#changeTemplate").modal("show");
					}
				})
			}
	
			function btnStatusChk(id, name, index) {
				var vm_ID = "\'" + id + "\'";
				var vm_name = "\'" + name + "\'";
	
				var header = '';
				var footer = '';
	
				if (index == 1) {
					header += '<h5 class="modal-title mb-0">' + name + ' 상세 보기</h5>';
					$("#modal-footer").hide();
	
				} else if (index == 2) {
					header += '<h5 class="modal-title mb-0">' + name + ' 정보 변경</h5>';
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="templateUpdate(' + vm_ID + ',' + vm_name + ')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
					$("#modal-footer").show();
				}
				header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	
				$("#modal-header").empty();
				$("#modal-header").append(header);
	
				$("#modal-footer").empty();
				$("#modal-footer").append(footer);
	
				$("#required-inputup").addClass("show");
				$("#select-inputup").addClass("show");
	
				if (index == 1) {
					$("#descriptionup").attr("disabled", true);
					$("#template_onup").attr("disabled", true);
					$("#template_offup").attr("disabled", true);
				} else if (index == 2) {
					$("#descriptionup").attr("disabled", false);
					$("#template_onup").attr("disabled", false);
					$("#template_offup").attr("disabled", false);
				}
	
			}
	
			function templateUpdate(id, name) {
				var description = $("#descriptionup").val();
				var template_onoff = $("input[type=radio][name=template_onoffup]:checked").val();
				
				$.ajax({
					type: "POST",
					data: {
						vmID: id,
						templateOnoff: template_onoff,
						description: description,
					},
					url: "/config/updateVMTemplate.do",
					success: function(data) {
						if (data == 1) {
							alert("템플릿 정보 변경이 완료되었습니다.");
							window.parent.location.reload();
						} else {
							alert("템플릿 정보 변경이 실패하였습니다.");
						}
					}
				})
			}
		</script>
	</head>
	<body>
		<div id="changeTemplate" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom" id="modal-header"></div>
					<div class="modal-body bg-light modal-type-1 modal-type-1-2">
						<div class="card mb-0">
							<div class="card-header bg-white">
								<a href="#required-inputup" data-toggle="collapse">
									<span class="h6 card-title"><i class="icon-checkbox-checked2 text-prom mr-2"></i>필수 입력 정보</span>
									<i class="icon-arrow-down12 text-prom"></i>
								</a>
							</div>
							<div id="required-inputup" class="collapse show">
								<div class="card-body bg-light">
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>템플릿명:</label>
												<input type="text" class="form-control form-control-modal" id="templateNameup" disabled>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>OS명:</label>
												<input type="text" class="form-control form-control-modal" id="OSNameup" disabled>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>Disk:</label>
												<input type="number" class="form-control form-control-modal" id="Diskup" disabled>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>vCPU:</label>
												<input type="number" class="form-control form-control-modal" id="vCPUup" disabled>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>Memory:</label>
												<input type="number" class="form-control form-control-modal" id="Memoryup" disabled>
											</div>
										</div>
									</div>
									<div class="row mt-1">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group form-check-inline">
												<div class="custom-control custom-radio mr-2-5">
													<input type="radio" class="custom-control-input" name="template_onoffup" id="template_onup" value="1">
													<label class="custom-control-label" for="template_onup">적용</label>
												</div>
												<div class="custom-control custom-radio">
													<input type="radio" class="custom-control-input" name="template_onoffup" id="template_offup" value="0">
													<label class="custom-control-label" for="template_offup">미적용</label>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="card mb-0">
							<div class="card-header bg-white">
								<a href="#select-inputup" data-toggle="collapse">
									<span class="h6 card-title"><i class="icon-checkbox-unchecked2 text-prom mr-2"></i>선택 입력 정보</span>
									<i class="icon-arrow-down12 text-prom"></i>
								</a>
							</div>
							<div id="select-inputup" class="collapse show">
								<div class="card-body bg-light">
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>설명:</label>
												<input type="text" class="form-control form-control-modal" placeholder="description" autocomplete="off" maxlength="50" id="descriptionup">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white" id="modal-footer"></div>
				</div>
			</div>
		</div>
		
		<div class="card bg-dark mb-0 table-type-5-6">
			<table id="templateTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>템플릿명</th>
						<th>OS명</th>
						<th>vCPU</th>
						<th>Memory</th>
						<th>Disk</th>
						<th>설명</th>
						<th>적용 여부</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>