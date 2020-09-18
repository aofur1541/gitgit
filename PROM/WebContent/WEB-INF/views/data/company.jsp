<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/adminCheck.js"></script>
		
		<script type="text/javascript">
			var global_companyOrder = null;
	
			$(document).ready(function() {
				getCompanyAllList();
				commonModalOpen("addCompany", "companyName");
	
				if (sessionApproval == BanNumber || sessionApproval == BanNumber2) {
					ftnlimited(1);
				}
			})
	
			function companyRegisterEnterkey() {
				if (window.event.keyCode == 13) {
					companyInputCheck();
				}
			}
	
			function companyUpdateEnterkey(id) {
				if (window.event.keyCode == 13) {
					selectCompanyUpdate(id);
				}
			}
	
			function companyInputCheck() {
	
				var companyName = $("#companyName").val();
				var blank_pattern = /[\s]/g;
				var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
	
				if (!companyName) {
					alert("회사명을 입력하십시오.");
					$("#companyName").focus();
					return false;
	
				} else if ($.isNumeric(companyName)) {
					alert("회사명을 숫자로만 입력할 수 없습니다.");
					$("#companyName").focus();
					return false;
	
				} else if (blank_pattern.test(companyName) == true) {
					alert("회사명에 띄어쓰기(공백)을 넣을 수 없습니다.");
					$("#companyName").focus();
					return false;
	
				} else if (special_pattern.test(companyName) == true) {
					alert("회사명에 특수문자를 넣을 수 없습니다.");
					$("#companyName").focus();
					return false;
				} else {
					companyRegister();
				}
			}
	
			function companyRegister() {
	
				var companyName = $("#companyName").val();
				var companyAddress = $("#companyAddress").val();
				var companyRGnumber = $("#companyRGnumber").val();
				var companyRP = $("#companyRP").val();
				var companyDescription = $("#companyDescription").val();
	
				$.ajax({
					data: {
						name: companyName,
						address: companyAddress,
						registrationNumber: companyRGnumber,
						representative: companyRP,
						description: companyDescription
					},
					url: "/user/insertCompany.do",
					type:'POST',
					success: function(data) {
						if (data == 1) {
							alert("회사 등록이 완료되었습니다.");
							window.parent.location.reload()
						} else if (data == 2) {
							alert("동일한 회사명이 있습니다.");
							$("#companyName").focus();
						}
					}
				})
			};
	
			function getCompanyAllList(order) {
	
				global_companyOrder = order;
	
				var companyTable = $("#companyTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/user/selectCompanyList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "name"},
							{"data": "representative"},
							{"data": "registrationNumber"},
							{"data": "address"},
							{"data": "description"},
							{"data": "id",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
									var name = "\'" + row.name + "\'";
									if (sessionApproval != BanNumber && sessionApproval != BanNumber2) {
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
										html += '<a href="#" class="dropdown-item" onclick="selectCompanyUpdateCheck(' + data + ', ' + name + ', ' + 'this' + ', ' + 1 + ')"><i class="icon-file-text"></i>상세 보기</a>';
										html += '<a href="#" class="dropdown-item" onclick="selectCompanyUpdateCheck(' + data + ', ' + name + ', ' + 'this' + ', ' + 2 + ')"><i class="icon-pencil7"></i>정보 변경</a>';
										html += '<a href="#" class="dropdown-item" onclick="selectCompanyDeleteCheck(' + data + ', ' + name + ')"><i class="icon-trash"></i>삭제</a>';
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
									title: "회사 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "회사 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4]
									}
								}
							]
						}]
					});
				$(".addModal").html('<button type="button" class="btn bg-prom" data-toggle="modal" data-target="#addCompany"><i class="icon-plus2"></i><span class="ml-2">회사 등록</span></button>');
			}
	
			function selectCompanyDeleteCheck(id, name) {
				if (confirm(name + " 회사를 삭제하시겠습니까?") == true) {
					selectCompanyDelete(id, name);
				} else {
					return false;
				}
			}
	
			function selectCompanyDelete(id, name) {
	
				$.ajax({
					data: {
						id: id,
						name: name
					},
					url: "/user/deleteCompany.do",
					type:'POST',
					success: function(data) {
						if (data == 1) {
							alert("삭제가 완료되었습니다.");
							window.parent.location.reload()
						} else if (data == 2) {
							if (confirm("회사에 등록된 사용자가 있어 삭제할 수 없습니다.\n사용자의 회사를 변경하시겠습니까? ") == true) {
								window.parent.location.href = '/menu/userSetting.do#3';
								window.parent.location.reload();
							} else {
								return false;
							}
						} else if (data == 3) {
							if (confirm("테넌트에 속한 회사입니다.\n테넌트의 회사를 변경하시겠습니까? ") == true) {
								window.parent.location.href = '/menu/tenantSetting.do#1';
							} else {
								return false;
							}
						} else if (data == 4) {
							if (confirm("부서가 존재하는 회사입니다.\n회사 부서를 삭제하시겠습니까? ") == true) {
								window.parent.location.href = '/menu/userSetting.do#2';
								window.parent.location.reload();
							} else {
								return false;
							}
						}
					}
				})
			}
	
			var saveID = 0;
	
			function selectCompanyUpdateCheck(id, name, tdID, index) {
				setTimeout(
					function() {
						$.ajax({
							data: {
								id: id
							},
							url: "/user/selectCompany.do",
							type:'POST',
							success: function(data) {
	
								btnStatusChk(id, name, index);
	
								$("#companyNameup").val(data.name);
								$("#companyRPup").val(data.representative);
								$("#companyRGnumberup").val(data.registrationNumber);
								$("#companyAddressup").val(data.address);
								$("#companyDescriptionup").val(data.description);
	
								$("#changeCompany").modal("show");
							}
						})
					}, 50
				)
			}
	
			function btnStatusChk(id, name, index) {
	
				var header = '';
				var footer = '';
	
				if (index == 1) {
					header += '<h5 class="modal-title mb-0">' + name + ' 상세 보기</h5>';
					$("#modal-footer").hide();
	
				} else if (index == 2) {
					header += '<h5 class="modal-title mb-0">' + name + ' 정보 변경</h5>';
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="selectCompanyUpdate(' + id + ')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
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
					$("#companyNameup").attr("disabled", true);
					$("#companyRPup").attr("disabled", true);
					$("#companyRGnumberup").attr("disabled", true);
					$("#companyAddressup").attr("disabled", true);
					$("#companyDescriptionup").attr("disabled", true);
				} else if (index == 2) {
					$("#companyNameup").attr("disabled", false);
					$("#companyRPup").attr("disabled", false);
					$("#companyRGnumberup").attr("disabled", false);
					$("#companyAddressup").attr("disabled", false);
					$("#companyDescriptionup").attr("disabled", false);
				}
			}
	
			function selectCompanyUpdate(id) {
	
				var name = $("#companyNameup").val();
				var representative = $("#companyRPup").val();
				var registration_number = $("#companyRGnumberup").val();
				var address = $("#companyAddressup").val();
				var description = $("#companyDescriptionup").val();
	
				var blank_pattern = /[\s]/g;
				var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
	
				if (!name) {
					alert("회사명을 입력하십시오.");
					$("#companyNameup").focus();
					return false;
				} else if ($.isNumeric(name)) {
					alert("회사명을 숫자로만 입력할 수 없습니다.");
					$("#companyNameup").focus();
					return false;
				} else if (blank_pattern.test(name) == true) {
					alert("회사명에 띄어쓰기(공백)을 넣을 수 없습니다.");
					$("#companyNameup").focus();
					return false;
				} else if (special_pattern.test(name) == true) {
					alert("회사명에 특수문자를 넣을 수 없습니다.");
					$("#companyNameup").focus();
					return false;
				} else {
	
					$.ajax({
						data: {
							id: id,
							name: name,
							address: address,
							description: description,
							registrationNumber: registration_number,
							representative: representative
						},
						url: "/user/updateCompany.do",
						type:'POST',
						success: function(data) {
							if (data == 1) {
								alert("수정이 완료되었습니다.");
								window.parent.location.reload()
							} else if (data == 2) {
								alert("동일한 회사명이 있습니다.");
								$("#companyNameup").focus();
							}
						}
					})
				}
			}
		</script>
	</head>
	<body>
		<div id="addCompany" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">회사 등록</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body bg-light modal-type-1 modal-type-1-1">
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
												<label>회사명:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="company name" autocomplete="off" maxlength="30" onkeyup="companyRegisterEnterkey()" id="companyName">
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
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>대표 이사: </label>
												<input type="text" class="form-control form-control-modal" placeholder="CEO" autocomplete="off" maxlength="15" onkeyup="companyRegisterEnterkey()" id="companyRP">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>사업자등록번호:</label>
												<input type="text" class="form-control form-control-modal" placeholder="company registration number" autocomplete="off" maxlength="30" onkeyup="companyRegisterEnterkey()" id="companyRGnumber">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>주소:</label>
												<input type="text" class="form-control form-control-modal" placeholder="company address" autocomplete="off" maxlength="70" onkeyup="companyRegisterEnterkey()" id="companyAddress">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>설명:</label>
												<input type="text" class="form-control form-control-modal" placeholder="description" autocomplete="off" maxlength="50" onkeyup="companyRegisterEnterkey()" id="companyDescription">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white">
						<button type="button" class="btn bg-prom rounded-round" onclick="companyInputCheck()">등록<i class="icon-checkmark2 ml-2"></i></button>
					</div>
				</div>
			</div>
		</div>
		
		<div id="changeCompany" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom" id="modal-header"></div>
					<div class="modal-body bg-light modal-type-1 modal-type-1-1">
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
												<label>회사명:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="company name" autocomplete="off" maxlength="30" id="companyNameup">
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
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>대표 이사: </label>
												<input type="text" class="form-control form-control-modal" placeholder="CEO" autocomplete="off" maxlength="15" id="companyRPup">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>사업자등록번호:</label>
												<input type="text" class="form-control form-control-modal" placeholder="company registration number" autocomplete="off" maxlength="30" id="companyRGnumberup">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>주소:</label>
												<input type="text" class="form-control form-control-modal" placeholder="company address" autocomplete="off" maxlength="70" id="companyAddressup">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>설명:</label>
												<input type="text" class="form-control form-control-modal" placeholder="description" autocomplete="off" maxlength="50" id="companyDescriptionup">
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
			<table id="companyTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>회사명</th>
						<th>대표이사</th>
						<th>사업자등록번호</th>
						<th>주소</th>
						<th>설명</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>