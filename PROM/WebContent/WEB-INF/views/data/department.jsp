<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
	
		<script type="text/javascript">
			$(document).ready(function() {
	
				$(document).on('change', '#companyChoiceSB', function() {
					getCompanyInDept();
				})
	
				$(document).on('change', '#companyChoiceSBUp', function() {
					var company_idup = $("#companyChoiceSBUp option:selected").val();
					var companyInDeptup = $("#companyInDeptSBUp option:selected").val();
					getCompanyInDeptUp(company_idup, companyInDeptup);
				})
	
				if (sessionApproval == BanNumber || sessionApproval == BanNumber2) {
					ftnlimited(1);
				}
	
				getDepartmentList();
				getCompanyAllList();
				commonModalOpen("addDepartment", "companyChoiceSB");
			});
			
			function departmentRegisterEnterkey() {
				if (window.event.keyCode == 13) {
					deptRegister();
				}
			}
	
			function departmentUpdateEnterkey(id) {
				if (window.event.keyCode == 13) {
					deptUpdate(id);
				}
			}
	
			function getCompanyAllList() {
	
				$.ajax({
	
					url: "/user/selectCompanyList.do",
					success: function(data) {
						var html = '';
						html += '<option value=0 selected disabled>:: 회사를 선택하십시오. ::</option>';
						for (key in data) {
							html += '<option value=' + data[key].id + '>' + data[key].name + '</option>';
						}
	
						$("#companyChoiceSB").empty();
						$("#companyChoiceSB").append(html);
					}
				})
			}
	
			function getCompanyInDept() {
	
				var company_id = $("#companyChoiceSB option:selected").val();
	
				$.ajax({
	
					data: {
						company_id: company_id
					},
					url: "/jquery/getCompanyInDept.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html += '<option value=0>최상위 부서</option>';
						} else {
							html += '<option value=0>최상위 부서</option>';
							for (key in data) {
								html += '<option value=' + data[key].dept_id + '>' + data[key].name + '</option>';
							}
						}
						$("#companyInDeptSB").empty();
						$("#companyInDeptSB").append(html);
					}
				})
			}
	
			function getDepartmentList() {
				var departmentTable = $("#departmentTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/user/selectDeptList.do",
							"dataSrc": ""
						},
						columns: [
							{"data": "companyName"},
							{"data": "name"},
							{"data": "deptId"},
							{"data": "upperdeptName",
								render: function(data, type, row) {
									if (data == null) {
										data = '최상위 부서';
									} else {
										data = data;
									}
									return data;
								}
							},
							{"data": "isUse",
								render: function(data, type, row) {
									if (data == 1) {
										data = '<span class="text-prom">ON</span>'
									} else if (data == 0) {
										data = '<span class="text-muted">OFF</span>';
									}
									return data;
								}
							},
							{"data": "description"},
							{"data": "id",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
									var companyID = "\'" + row.company_id + "\'";
									var departmentID = "\'" + row.dept_id + "\'";
									var departmentName = "\'" + row.name + "\'";
									if (sessionApproval != BanNumber && sessionApproval != BanNumber2) {
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
										html += '<a href="#" class="dropdown-item" onclick="getDeptOne(' + companyID + ', ' + departmentID + ', ' + data + ', ' + departmentName + ', ' + 1 + ')"><i class="icon-file-text"></i>상세 보기</a>';
										html += '<a href="#" class="dropdown-item" onclick="getDeptOne(' + companyID + ', ' + departmentID + ', ' + data + ', ' + departmentName + ', ' + 2 + ')"><i class="icon-pencil7"></i>정보 변경</a>';
										html += '<a href="#" class="dropdown-item" onclick="deptDelete(' + companyID + ', ' + departmentID + ', ' + data + ', ' + departmentName + ')"><i class="icon-trash"></i>삭제</a>';
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
									title: "부서 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "부서 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5]
									}
								}
							]
						}]
					});
				$(".addModal").html('<button type="button" class="btn bg-prom" data-toggle="modal" data-target="#addDepartment"><i class="icon-plus2"></i><span class="ml-2">부서 등록</span></button>');
			}
	
			function getDeptOne(company_id, dept_id, id, name, index) {
	
	
				$.ajax({
	
					url: "/jquery/getDeptOne.do",
					data: {
						dept_id: dept_id,
						company_id: company_id
					},
					success: function(data) {
						btnStatusChk(id, name, index);
	
						$("#deptNameUp").val(data.name);
						$("#dept_idUp").val(data.dept_id);
						$("#descriptionUp").val(data.description);
						getCompanyAllListUp(data.company_id, data.upperdept_id);
						getCompanyInDeptUp(data.company_id, data.upperdept_id);
	
						if (data.isUse == 0) {
							$("input:radio[name='deptOnoffUp'][value='0']").prop("checked", true);
						} else if (data.isUse == 1) {
							$("input:radio[name='deptOnoffUp'][value='1']").prop("checked", true);
						}
	
						$("#changeDepartment").modal("show");
					}
				})
			}
	
			function btnStatusChk(id, name, index) {
	
				var header = '';
				var footer = '';
	
				if (index == 1) {
					header += '<h5 class="modal-title mb-0">' + name + ' 상세 보기</h5>';
					$("#modal-footer").hide();
	
				} else if (index == 2) {
					header += '<h5 class="modal-title mb-0">' + name + ' 정보 변경</h5>';
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="deptUpdate(' + id + ')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
					$("#modal-footer").show();
				}
	
				header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	
				$("#required-inputup").addClass("show");
				$("#select-inputup").addClass("show");
	
				$("#modal-header").empty();
				$("#modal-header").append(header);
	
				$("#modal-footer").empty();
				$("#modal-footer").append(footer);
	
				if (index == 1) {
					$("#companyChoiceSBUp").attr("disabled", true);
					$("#companyInDeptSBUp").attr("disabled", true);
					$("#deptNameUp").attr("disabled", true);
					$("#dept_idUp").attr("disabled", true);
					$("#deptOnUp").attr("disabled", true);
					$("#deptOffUp").attr("disabled", true);
					$("#descriptionUp").attr("disabled", true);
				} else if (index == 2) {
					$("#companyChoiceSBUp").attr("disabled", true);
					$("#companyInDeptSBUp").attr("disabled", true);
					$("#deptNameUp").attr("disabled", false);
					$("#dept_idUp").attr("disabled", false);
					$("#deptOnUp").attr("disabled", false);
					$("#deptOffUp").attr("disabled", false);
					$("#descriptionUp").attr("disabled", false);
				}
			}
			
			function deptUpdate(id) {
				
				var hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	
				var deptNameUp = $("#deptNameUp").val();
				var dept_idUp = $("#dept_idUp").val();
				var descriptionUp = $("#descriptionUp").val();
				var company_idup = $("#companyChoiceSBUp option:selected").val();
				var company_idsup = $("#companyChoiceSBUp option:selected").text();
				var companyInDeptsup = $("#companyInDeptSBUp option:selected").text();
				var companyInDeptup = $("#companyInDeptSBUp option:selected").val();
	
				var isUseUp = $("input[name='deptOnoffUp']:checked").val();
	
				if (!company_idup) {
					alert("회사를 선택하십시오.");
					$("#companyChoiceSBUp").focus();
					return false;
				} else if (!companyInDeptup) {
					alert("상위 부서를 선택하십시오.");
					$("#companyInDeptSBUp").focus();
					return false;
				} else if (!deptNameUp) {
					alert("부서명을 입력하십시오.");
					$("#deptNameUp").focus();
					return false;
				} else if (!dept_idUp) {
					alert("부서 코드를 입력하십시오.");
					$("#dept_idUp").focus();
					return false;
				} else if (hangulcheck.test(dept_idUp)) {
					alert("부서 코드에 한글을 포함할 수 없습니다.");
					$("#dept_idUp").focus();
					return false;
				} else if (dept_idUp.search(/\s/) != -1) {
					alert("부서 코드에 공백을 포함할 수 없습니다.");
					$("#dept_idUp").focus();
					return false;
				} else {
	
					$.ajax({
	
						url: "/jquery/deptUpdate.do",
						data: {
							id: id,
							name: deptNameUp,
							dept_id: dept_idUp,
							company_id: company_idup,
							companyName: company_idsup,
							upperdept_id: companyInDeptup,
							upperdeptName: companyInDeptsup,
							isUse: isUseUp,
							description: descriptionUp,
						},
						success: function(data) {
	
							if (data == 1) {
								alert("변경이 완료되었습니다.");
								window.parent.location.reload();
							} else if (data == 2) {
								alert("해당 부서 코드의 하위 부서가 존재함으로 변경할 수 없습니다.");
								return false;
							} else if (data == 3) {
								alert("해당 부서 코드는 회사에 이미 존재합니다.");
								return false;
							} else if (data == 4) {
								if (confirm("해당 부서는 테넌트에 속해 있으므로 미사용으로 변경할 수 없습니다.\n테넌트의 부서를 변경하러 가시겠습니까?") == true) {
									window.parent.location.href = "/menu/tenantSetting.do#1";
								} else {
									return false;
								}
							}
						}
					})
				}
			}
	
	
			//Up
			function getCompanyAllListUp(companyId) {
	
				$.ajax({
	
					url: "/user/selectCompanyList.do",
					success: function(data) {
						var html = '';
						for (key in data) {
							if (companyId != data[key].id) {
								html += '<option value=' + data[key].id + '>' + data[key].name + '</option>';
							} else {
								html += '<option value=' + data[key].id + ' selected>' + data[key].name + '</option>';
							}
						}
	
						$("#companyChoiceSBUp").empty();
						$("#companyChoiceSBUp").append(html);
					}
				})
			}
			//Up
			function getCompanyInDeptUp(companyId, upperdept_id) {
				$.ajax({
	
					data: {
						company_id: companyId
					},
					url: "/jquery/getCompanyInDept.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '' || upperdept_id == 0) {
							html += '<option value=0 selected>최상위 부서</option>';
						} else {
							for (key in data) {
								if( upperdept_id != data[key].dept_id  ){
								html += '<option value=' + data[key].dept_id + '>' + data[key].name + '</option>';
								} else {
								html += '<option value=' + data[key].dept_id + ' selected>' + data[key].name + '</option>';
								}
							}
	
						}
						$("#companyInDeptSBUp").empty();
						$("#companyInDeptSBUp").append(html);
					}
				})
	
			}
	
			function deptRegister() {
	
				var hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	
				var deptName = $("#deptName").val();
				var dept_id = $("#dept_id").val();
				var description = $("#description").val();
				var company_id = $("#companyChoiceSB option:selected").val();
				var company_ids = $("#companyChoiceSB option:selected").text();
				var companyInDept = $("#companyInDeptSB option:selected").val();
				var isUse = $("input[name='deptOnoff']:checked").val();
	
				if (!company_id) {
					alert("회사를 선택하십시오.");
					$("#companyChoiceSB").focus();
					return false;
				} else if (!companyInDept) {
					alert("상위 부서를 선택하십시오.");
					$("#companyInDeptSB").focus();
					return false;
				} else if (!deptName) {
					alert("부서명을 입력하십시오.");
					$("#deptName").focus();
					return false;
				} else if (!dept_id) {
					alert("부서 코드를 입력하십시오.");
					$("#dept_id").focus();
					return false;
				} else if (hangulcheck.test(dept_id)) {
					alert("부서 코드에 한글을 포함할 수 없습니다.");
					$("#dept_id").focus();
					return false;
				} else if (dept_id.search(/\s/) != -1) {
					alert("부서 코드에 공백을 포함할 수 없습니다.");
					$("#dept_id").focus();
					return false;
				} else {
					$.ajax({
						url: "/jquery/deptRegister.do",
						data: {
							name: deptName,
							dept_id: dept_id,
							companyName: company_ids,
							company_id: company_id,
							upperdept_id: companyInDept,
							isUse: isUse,
							description: description
						},
						success: function(data) {
							if (data == 1) {
								alert("등록이 완료되었습니다.");
								window.parent.location.reload();
							} else if (data == 2) {
								alert("해당 부서코드는 회사에 이미 존재 합니다.");
								return false;
							}
						}
					})
				}
			}
	
			function deptDelete(company_id, dept_id, id, name) {
	
				if (confirm(name + " 부서를 삭제하시겠습니까?") == true) {
	
					$.ajax({
						url: "/jquery/deptDelete.do",
						data: {
							company_id: company_id,
							dept_id: dept_id,
							name: name,
							id: id
						},
						success: function(data) {
							if (data == 1) {
								alert("부서 삭제 완료");
								window.parent.location.reload();
							} else if (data == 2) {
								alert("해당 부서코드는 하위 부서를 가지고 있습니다.");
								return false;
							} else if (data == 3) {
								if (confirm("해당 부서는 테넌트에 속해 있으므로 삭제할 수 없습니다.\n테넌트의 부서를 변경하러 가시겠습니까?") == true) {
									window.parent.location.href = "/menu/tenantSetting.do#1";
								} else {
									return false;
								}
							} else if (data == 4) {
								if (confirm("해당 부서에 소속된 사용자가 있어 삭제할 수 없습니다.\n사용자의 부서를 변경하러 가시겠습니까?") == true) {
									window.parent.location.href = '/menu/userSetting.do#3';
								} else {
									return false;
								}
							}
	
						}
					})
	
				} else {
					return false;
				}
			}
		</script>
	</head>
	
	<body>
		<div id="addDepartment" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">부서 등록</h5>
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
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>회사:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="companyChoiceSB" data-fouc></select>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>상위 부서:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="companyInDeptSB" data-fouc>
													<option value="" selected disabled>:: 회사 선택 후 선택할 수 있습니다. ::</option>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>부서명:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="department name" autocomplete="off" maxlength="20" id="deptName" onkeyup="departmentRegisterEnterkey()">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>부서 코드:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="department number" autocomplete="off" maxlength="20" id="dept_id" onkeyup="departmentRegisterEnterkey()">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group form-check-inline">
												<div class="custom-control custom-radio mr-2-5">
													<input type="radio" class="custom-control-input" name="deptOnoff" id="deptOn" value="1" checked>
													<label class="custom-control-label" for="deptOn">사용</label>
												</div>
												<div class="custom-control custom-radio">
													<input type="radio" class="custom-control-input" name="deptOnoff" id="deptOff" value="0">
													<label class="custom-control-label" for="deptOff">미사용</label>
												</div>
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
												<input type="text" class="form-control form-control-modal" placeholder="description" autocomplete="off" maxlength="40" id="description"  onkeyup="departmentRegisterEnterkey()">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white">
						<button type="button" class="btn bg-prom rounded-round" onclick="deptRegister()">등록<i class="icon-checkmark2 ml-2"></i></button>
					</div>
				</div>
			</div>
		</div>
	
		<div id="changeDepartment" class="modal fade">
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
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>회사:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="companyChoiceSBUp" data-fouc></select>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>상위 부서:<span class="text-prom ml-2">(필수)</span></label>
												<select class="form-control select-search" id="companyInDeptSBUp" data-fouc></select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>부서명:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="department name" autocomplete="off" maxlength="20" id="deptNameUp">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>부서 코드:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="department number" autocomplete="off" maxlength="20" id="dept_idUp">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group form-check-inline">
												<div class="custom-control custom-radio mr-2-5">
													<input type="radio" class="custom-control-input" name="deptOnoffUp" id="deptOnUp" value="1" checked>
													<label class="custom-control-label" for="deptOnUp">사용</label>
												</div>
												<div class="custom-control custom-radio">
													<input type="radio" class="custom-control-input" name="deptOnoffUp" id="deptOffUp" value="0">
													<label class="custom-control-label" for="deptOffUp">미사용</label>
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
												<input type="text" class="form-control form-control-modal" placeholder="description" autocomplete="off" maxlength="40" id="descriptionUp">
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
			<table id="departmentTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>회사명</th>
						<th>부서명</th>
						<th>부서 코드</th>
						<th>상위 부서</th>
						<th>사용 여부</th>
						<th>설명</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>