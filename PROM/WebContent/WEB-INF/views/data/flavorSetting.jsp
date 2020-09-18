<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			$(document).ready(function() {
				if (sessionApproval <= CONTROLCHECK) {
					ftnlimited(3);
				}
				getFlavorList();
				commonModalOpen("addFlavor", "flavorName");
			})
	
			function flavorRegisterEnterkey() {
				if (window.event.keyCode == 13) {
					flavorRegisterCheck();
				}
			}
	
			function flavorUpdateEnterkey(id) {
				if (window.event.keyCode == 13) {
					flavorDynamicUpdate(id);
				}
			}
	
			function flavorRegisterCheck() {
	
				var flavorName = $("#flavorName").val();
				var vCPU = $("#vCPU").val();
				var memory = $("#memory").val();
	
				var blank_pattern = /[\s]/g;
				var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
	
				if (!flavorName) {
					alert("Flavor명은 필수기입 항목입니다.");
					$("#flavorName").focus();
					return false;
				} else if (blank_pattern.test(flavorName)) {
					alert("Flavor명에 띄어쓰기(공백)을 넣을 수 없습니다.");
					$("#flavorName").focus();
					return false;
				} else if (special_pattern.test(flavorName) == true) {
					alert("Flavor명을 특수문자로 구성할 수 없습니다.");
					$("#flavorName").focus();
					return false;
				} else if (!vCPU) {
					alert("vCPU 개수는 필수기입 항목입니다.");
					$("#vCPU").focus();
					return false;
				} else if (vCPU > 32 || vCPU < 1) {
					alert("vCPU는 1~32개까지만 지원합니다.");
					$("#vCPU").focus();
					return false;
				} else if (!memory) {
					alert("memory 수량은 필수기입 항목입니다.");
					$("#memory").focus();
					return false;
				} else if (memory > 64 || memory < 1) {
					alert("memory는 1~64 GB까지만 지원합니다.");
					$("#memory").focus();
					return false;
				} else {
					flavorRegister();
				}
			}
	
			function flavorRegister() {
				var flavorName = $("#flavorName").val();
				var vCPU = $("#vCPU").val();
				var memory = $("#memory").val();
				var description = $("#description").val();
	
				$.ajax({
					data: {
						name: flavorName,
						vCPU: vCPU,
						memory: memory,
						description: description
					},
					type: "POST",
					url: "/config/insertFlavor.do",
					success: function(data) {
						if (data == 1) {
							alert("Flavor 등록이 완료되었습니다.");
							location.reload();
						} else if (data == 2) {
							alert("동일한 Flavor명이 있습니다.");
							return false;
						} else {
							alert("Flavor 등록에 실패하였습니다.");
							return false;
						}
					}
				})
			};
	
			function getFlavorList() {
				var flavorTable = $("#flavorTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/config/selectFlavorList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "name"},
							{"data": "vCPU"},
							{"data": "memory",
								render: function(data, type, row) {
									data = data + ' GB';
									return data;
								}
							},
							{"data": "description"},
							{"data": "id",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
									var name = "\'" + row.name + "\'";
									if (sessionApproval != BanNumber && sessionApproval > CONTROLCHECK) {
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
										html += '<a href="#" class="dropdown-item" onclick="flavorUpdateValidation(' + data + ', ' + name + ', ' + 1 + ')"><i class="icon-file-text"></i>상세 보기</a>';
										html += '<a href="#" class="dropdown-item" onclick="flavorUpdateValidation(' + data + ', ' + name + ', ' + 2 + ')"><i class="icon-pencil7"></i>정보 변경</a>';
										html += '<a href="#" class="dropdown-item" onclick="flavorDeleteCheck(' + data + ', ' + name + ')"><i class="icon-trash"></i>삭제</a>';
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
						dom: "<'datatables-header'<'row-padding-0'lf><'row-padding-0'B<'addModal'>>>" + "<'datatables-body'rt>" + "<'datatables-footer'ip>",
						buttons: [{
							extend: "collection",
							text: "<i class='icon-import'></i><span class='ml-2'>내보내기</span>",
							className: "btn bg-prom dropdown-toggle",
							buttons: [{
									extend: "csvHtml5",
									charset: "UTF-8",
									bom: true,
									text: "CSV",
									title: "Flavor 정보",
									exportOptions: {
										columns: [0, 1, 2, 3]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "Flavor 정보",
									exportOptions: {
										columns: [0, 1, 2, 3]
									}
								}
							]
						}]
					});
				$(".addModal").html('<button type="button" class="btn bg-prom" data-toggle="modal" data-target="#addFlavor"><i class="icon-plus2"></i><span class="ml-2">Flavor 등록</span></button>');
			}
	
			function flavorUpdateValidation(id, name, index) {
				setTimeout(function() {
					$.ajax({
						data: {
							id: id
						},
						url: "/config/selectFlavor.do",
						success: function(data) {
							btnStatusChk(id, name, index);
	
							$("#flavorNameup").val(data.name);
							$("#vCPUup").val(data.vCPU);
							$("#memoryup").val(data.memory);
							$("#descriptionup").val(data.description);
							$("#changeFlavor").modal("show");
						}
					})
				}, 100);
			}
	
			function btnStatusChk(id, name, index) {
	
				var header = '';
				var footer = '';
	
				if (index == 1) {
					header += '<h5 class="modal-title mb-0">' + name + ' 상세 보기</h5>';
					$("#modal-footer").hide();
	
				} else if (index == 2) {
					header += '<h5 class="modal-title mb-0">' + name + ' 정보 변경</h5>';
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="flavorDynamicUpdate(' + id + ')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
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
					$("#flavorNameup").attr("disabled", true);
					$("#vCPUup").attr("disabled", true);
					$("#memoryup").attr("disabled", true);
					$("#descriptionup").attr("disabled", true);
	
				} else if (index == 2) {
					if (name == 'Tiny' || name == 'Small' || name == 'Middle' || name == 'Large' || name == 'Custom') {
						$("#flavorNameup").attr("disabled", true);
					} else {
						$("#flavorNameup").attr("disabled", false);
					}
					$("#vCPUup").attr("disabled", false);
					$("#memoryup").attr("disabled", false);
					$("#descriptionup").attr("disabled", false);
				}
			}
	
			function flavorDynamicUpdate(id) {
	
				var flavorName = $("#flavorNameup").val();
				var vCPU = $("#vCPUup").val();
				var memory = $("#memoryup").val();
				var description = $("#descriptionup").val();
	
				var blank_pattern = /[\s]/g;
				var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
	
				if (!flavorName) {
					alert("Flavor명은 필수기입 항목입니다.");
					$("#flavorNameup").focus();
					return false;
				} else if (blank_pattern.test(flavorName)) {
					alert("Flavor명에 띄어쓰기(공백)을 넣을 수 없습니다.");
					$("#flavorNameup").focus();
					return false;
				} else if (special_pattern.test(flavorName) == true) {
					alert("Flavor명을 특수문자로 구성할 수 없습니다.");
					$("#flavorNameup").focus();
					return false;
				} else if (!vCPU) {
					alert("vCPU 개수는 필수기입 항목입니다.");
					$("#vCPUup").focus();
					return false;
				} else if (vCPU > 32 || vCPU < 1) {
					alert("vCPU는 1~32개까지만 지원합니다.");
					$("#vCPUup").focus();
					return false;
				} else if (!memory) {
					alert("memory 수량은 필수기입 항목입니다.");
					$("#memoryup").focus();
					return false;
				} else if (memory > 64 || memory < 1) {
					alert("memory는 1~64 GB까지만 지원합니다.");
					$("#memoryup").focus();
					return false;
				} else {
					$.ajax({
						type: "POST",
						data: {
							id: id,
							name: flavorName,
							vCPU: vCPU,
							memory: memory,
							description: description
						},
						url: "/config/updateFlavor.do",
						success: function(data) {
							if (data == 1) {
								alert("Flavor 정보 변경이 완료되었습니다.");
								window.parent.location.reload();
							} else if (data == 2) {
								alert("동일한 Flavor명이 있습니다.");
								return false;
							}
						}
					})
				}
			}
	
			function flavorDeleteCheck(id, name) {
				if (confirm(name + " Flavor를 삭제하시겠습니까?") == true) {
					flavorDelete(id, name);
				} else {
					return false;
				}
			}
	
			function flavorDelete(id, name) {
				$.ajax({
					type: "POST",
					data: {
						id: id,
						name: name
					},
					url: "/config/deleteFlavor.do",
					success: function(data) {
						if (data == 1) {
							alert("Flavor 삭제가 완료되었습니다.");
							window.parent.location.reload();
						} else {
							alert("Flavor 삭제에 실패하였습니다.");
						}
					}
				})
			}
		</script>
	</head>
	<body>
		<div id="addFlavor" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">Flavor 등록</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body bg-light modal-type-1 modal-type-1-2">
						<div class="card mb-0">
							<div class="card-header bg-white">
								<a href="#required-input" data-toggle="collapse">
									<span class="h6 card-title"><i class="icon-checkbox-checked2 text-prom mr-2"></i>필수 입력 정보</span>
									<i class="icon-arrow-down12 text-prom"></i>
								</a>
							</div>
							<div id="required-input" class="collapse show">
								<div class="card-body bg-light">
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>Flavor명:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="flavor name" autocomplete="off" maxlength="30" onkeyup="flavorRegisterEnterkey()" id="flavorName">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>vCPU:<span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" placeholder="vCPU" min="1" max="32" onkeyup="flavorRegisterEnterkey()" id="vCPU">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>Memory:<span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" placeholder="memory" min="1" max="32" onkeyup="flavorRegisterEnterkey()" id="memory">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="card mb-0">
							<div class="card-header bg-white">
								<a href="#select-input" data-toggle="collapse">
									<span class="h6 card-title"><i class="icon-checkbox-unchecked2 text-prom mr-2"></i>선택 입력 정보</span>
									<i class="icon-arrow-down12 text-prom"></i>
								</a>
							</div>
							<div id="select-input" class="collapse show">
								<div class="card-body bg-light">
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>설명:</label>
												<input type="text" class="form-control form-control-modal" placeholder="description" autocomplete="off" maxlength="50" onkeyup="flavorRegisterEnterkey()" id="description">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white">
						<button type="button" class="btn bg-prom rounded-round" onclick="flavorRegisterCheck()">등록<i class="icon-checkmark2 ml-2"></i></button>
					</div>
				</div>
			</div>
		</div>
		
		<div id="changeFlavor" class="modal fade" tabindex="-1">
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
												<label>Flavor명:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="flavor name" autocomplete="off" maxlength="30" id="flavorNameup">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>vCPU:<span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" placeholder="vCPU" min="1" max="32" id="vCPUup">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>Memory:<span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" placeholder="memory" min="1" max="32" id="memoryup">
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
			<table id="flavorTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>Flavor명</th>
						<th>vCPU</th>
						<th>Memory</th>
						<th>설명</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>