<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			$(document).ready(function() {
				//내 계정관리 들어가면 자동으로 자기 정보가 열리는 GET 메서드
				/*  if('${ad}' != ''){
					selectUserUpdateCheck('${ad}');
				}  */
	
				getCompanyList();
	
				if (sessionApproval == BanNumber) {
					ftnlimited(1);
				} else if (sessionApproval == BanNumber2) {
					ftnlimited(4);
				}
	
				if (sessionApproval > ADMINCHECK) {
	
					getuserList();
	
					$(document).on('change', '#tenantSB', function() {
						serviceInTenant();
					})
	
					$(document).on('change', '#sCompanySB', function() {
						getCompanyInDept();
						getTenantList();
					})
	
					$(document).on('change', '#tenantSBup', function() {
						serviceInTenantUp();
					})
	
					$(document).on('change', '#sCompanySBup', function() {
						var sCompanySBup = $("#sCompanySBup option:selected").val();
						getCompanyInDeptUp(sCompanySBup);
						getTenantListUp();
					})
	
				} else if (sessionApproval < ADMINCHECK) {
					getUserTenantMembersList();
					getUserTenantList();
				}
				getUserMyInfo();
	
				commonModalOpen("addUser", "sName");
			});
	
	
			function userRegisterEnterkey() {
				if (window.event.keyCode == 13) {
					usercreate();
				}
			}
	
			function userUpdateEnterkey(id) {
				if (window.event.keyCode == 13) {
					selectUserUpdateValidation(id);
				}
			}
	
			function getCompanyInDept() {
	
				var company_id = $("#sCompanySB option:selected").val();
	
				$.ajax({
	
					data: {
						companyId: company_id,
						isUse: 1
					},
					url: "/user/selectDeptList.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html += '<option value="">부서가 존재하지 않습니다.</option>';
						} else {
							for (key in data) {
								html += '<option value=' + data[key].deptId + '>' + data[key].name + '</option>';
							}
						}
						$("select#sDepartment option").remove();
						$("#sDepartment").append(html);
					}
				})
			}
	
			function getCompanyInDeptUp(company_id, sDepartment) {
				$.ajax({
	
					data: {
						companyId: company_id,
						isUse: 1
					},
					url: "/user/selectDeptList.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html += '<option value="">부서가 존재하지 않습니다.</option>';
						} else {
							for (key in data) {
								if (sDepartment != data[key].deptId) {
									html += '<option value=' + data[key].deptId + '>' + data[key].name + '</option>';
								} else {
									html += '<option value=' + data[key].deptId + ' selected>' + data[key].name + '</option>';
								}
							}
						}
						$("#sDepartmentup option").remove();
						$("#sDepartmentup").append(html);
					}
				})
			}
	
			function userAuth(nApproval) {
				switch (nApproval) {
					case USER_NAPP:
						return USER_NAME;
						break;
					case USER_HEAD_NAPP:
						return USER_HEAD_NAME;
						break;
					case MANAGER_NAPP:
						return MANAGER_NAME;
						break;
					case MANAGER_HEAD_NAPP:
						return MANAGER_HEAD_NAME;
						break;
					case OPERATOR_NAPP:
						return OPERATOR_NAME;
						break;
					case CONTROL_OPERATOR_NAPP:
						return CONTROL_OPERATOR_NAME;
						break;
					case ADMIN_NAPP:
						return ADMIN_NAME;
						break;
	
				}
			}
	
			function getUserMyInfo() {
	
				var sessionId = '${sessionScope.loginUser.id}';
	
				$.ajax({
					url: "/user/selectUser.do",
					data: {
						id: sessionId
					},
					success: function(data) {
						var html = '';
						var value3 = "\'" + data.sUserID + "\'";
						var value2 = "\'" + data.sName + "\'";
						var value1 = data.id;
	
						html += '<tr>';
	
						html += '<td>' + data.companyName + '</td>';
						html += '<td>' + data.sDepartmentName + '</td>';
						html += '<td>' + data.sName + '</td>';
						html += '<td>' + data.sUserID + '</td>';
						html += '<td>' + data.sEmailAddress + '</td>';
						html += '<td>' + userAuth(data.nApproval) + '</td>';
	
						html += '<td>' + data.sTenantName + '</td>';
						html += '<td>' + data.sServiceName + '</td>';
	
						html += '<td>';
						if (sessionApproval != BanNumber) {
							html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
							html += '<i class="icon-menu9"></i>';
							html += '</a>';
							html += '<div class="dropdown-menu">';
							html += '<a href="#" class="dropdown-item" onclick="selectUserUpdateCheck(' + value1 + ',' + value2 + ',' + 1 + ')"><i class="icon-file-text"></i>상세 보기</a>';
							html += '<a href="#" class="dropdown-item" onclick="selectUserUpdateCheck(' + value1 + ',' + value2 + ',' + 2 + ')"><i class="icon-pencil7"></i>정보 변경</a>';
							html += '<a href="#" class="dropdown-item" onclick="userProDetail(' + value3 + ')"><i class="icon-lock"></i>비밀번호 변경</a>';
							html += '</div>';
						} else {
							html += '<i class="icon-lock2"></i>';
						}
						html += '</td>';
						html += '</tr>';
	
						$("#superUser").empty();
						$("#superUser").append(html);
					}
				})
			}
	
			function getUserTenantMembersList() {
				var userTable = $("#userTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/user/selectUserTenantMembersList.do",
							"dataSrc": ""
						},
						columns: [
							{"data": "companyName"},
							{"data": "sDepartmentName"},
							{"data": "sName"},
							{"data": "sUserID"},
							{"data": "sEmailAddress"},
							{"data": "nApproval",
								render: function(data, type, row) {
									data = userAuth(data);
	
									return data;
								}
							},
							{"data": "sTenantName",
								render: function(data, type, row) {
									if (data == null) {
										data = '';
									} else {
										data;
									}
									return data;
								}
							},
							{"data": "sServiceName",
								render: function(data, type, row) {
									if (data == null) {
										data = '';
									} else {
										data;
									}
									return data;
								}
							},
							{"data": "id",
								"orderable": false,
								render: function(data, type, row) {
									var userID = "\'" + row.sUserID + "\'";
									var name = "\'" + row.sName + "\'";
	
									var html = '';
	
									html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
									html += '<i class="icon-menu9"></i>';
									html += '</a>';
									html += '<div class="dropdown-menu">';
									html += '<a href="#" class="dropdown-item" onclick="selectUserUpdateCheck(' + data + ', ' + name + ', ' + 1 + ')"><i class="icon-file-text"></i>상세 보기</a>';
									html += '</div>';
	
									return html;
								}
							}
						],
						scrollY: "336px", 
						scrollCollapse: true,
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
									title: "사용자 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "사용자 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7]
									}
								}
							]
						}]
					});
			}
	
			function getuserList() {
				var userTable = $("#userTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/user/selectUserList.do",
							"dataSrc": ""
						},
						columns: [
							{"data": "companyName"},
							{"data": "sDepartmentName"},
							{"data": "sName"},
							{"data": "sUserID"},
							{"data": "sEmailAddress"},
							{"data": "nApproval",
								render: function(data, type, row) {
									data = userAuth(data);
	
									return data;
								}
							},
							{"data": "sTenantName",
								render: function(data, type, row) {
									if (data == null) {
										data = '';
									} else {
										data;
									}
									return data;
								}
							},
							{"data": "sServiceName",
								render: function(data, type, row) {
									if (data == null) {
										data = '';
									} else {
										data;
									}
									return data;
								}
							},
							{"data": "id",
								"orderable": false,
								render: function(data, type, row) {
									var userID = "\'" + row.sUserID + "\'";
									var name = "\'" + row.sName + "\'";
									var html = '';
									if (sessionApproval != BanNumber && sessionApproval != BanNumber2) {
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
										html += '<a href="#" class="dropdown-item" onclick="selectUserUpdateCheck(' + data + ', ' + name + ', ' + 1 + ')"><i class="icon-file-text"></i>상세 보기</a>';
										html += '<a href="#" class="dropdown-item" onclick="selectUserUpdateCheck(' + data + ', ' + name + ', ' + 2 + ')"><i class="icon-pencil7"></i>정보 변경</a>';
										html += '<a href="#" class="dropdown-item"onclick="selectUserResetconfirm(' + data + ', ' + name + ', ' + userID + ')"><i class="icon-lock"></i>비밀번호 초기화</a>';
										if (row.nApproval != BanNumber) {
											html += '<a href="#" class="dropdown-item" onclick="selectUserDeleteCheck(' + data + ', ' + name + ', ' + userID + ')"><i class="icon-trash"></i>삭제</a>';
										}
										html += '</div>';
									} else {
										html += '<i class="icon-lock2"></i>';
									}
									return html;
								}
							}
						],
						scrollY: "336px", 
						scrollCollapse: true,
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
									title: "사용자 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "사용자 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7]
									}
								}
							]
						}]
					});
				$(".addModal").html('<button type="button" class="btn bg-prom" data-toggle="modal" data-target="#addUser"><i class="icon-plus2"></i><span class="ml-2">사용자 등록</span></button>');
			}
	
			function selectUserDeleteCheck(id, name, userID) {
				if (confirm(userID + "(" + name + ")" + " 사용자를 삭제하시겠습니까?") == true) {
					selectUserDelete(id, userID, name);
				} else {
					return false;
				}
			}
	
			function selectUserDelete(id, userID, name) {
				$.ajax({
					data: {
						id: id,
						sUserID: userID,
						sName: name
					},
					type:'POST',
					url: "/user/deleteUser.do",
					success: function(data) {
						if (data == 1) {
							alert("삭제가 완료되었습니다.");
							window.parent.location.reload();
						} else if (data == 2) {
							if (confirm("해당 사용자는 테넌트 관리자입니다.\n테넌트 관리자를 변경하시겠습니까?") == true) {
								window.parent.location.href = '/menu/tenantSetting.do#1';
							} else {
								return false;
							}
						} else if (data == 3) {
							if (confirm("해당 사용자는 서비스 관리자입니다.\n서비스 관리자를 변경하시겠습니까?") == true) {
								window.parent.location.href = '/menu/tenantSetting.do#2';
							} else {
								return false;
							}
						} else {
							alert("삭제가 실패하였습니다.");
							return false;
						}
					}
				})
			}
	
			function selectUserInCompanyList(sCompany) {
				$.ajax({
					url: "/user/selectCompanyList.do",
					success: function(data) {
						var html = '';
						for (key in data) {
							if (sCompany != data[key].id) {
								html += '<option value=' + data[key].id + ' value2=' + data[key].name + ' id=' + data[key].id + '>' + data[key].name + '</option>';
							} else {
								html += '<option value=' + sCompany + ' value2=' + data[key].name + ' id=' + sCompany + ' selected>' + data[key].name + '</option>';
							}
						}
						$("#sCompanySBup").empty();
						$("#sCompanySBup").append(html);
					}
				})
			}
	
			function selectUserResetconfirm(id, userName, userID) {
				if (confirm(userID + '(' + userName + ')' + " 사용자 비밀번호를 초기화 하시겠습니까?") == true) {
					selectUserReset(id, userID);
				} else {
					return false;
				}
			}
	
			function selectUserReset(id, userID) {
				$.ajax({
					data: {
						id: id,
						sUserID: userID
					},
					type:'POST',
					url: "/user/resetPassword.do",
					success: function(data) {
						if (data == 1) {
							alert("초기화가 완료되었습니다.");
							location.reload();
						} else {
							alert("초기화에 실패하였습니다.");
							return;
						}
					}
				})
			}
	
			function getEmploymentup(data) {
	
				var html = '';
	
				if (data == 11) {
					html += '<option value="11" selected>재직</option>';
					html += '<option value="55">휴직</option>';
					html += '<option value="99">퇴직</option>';
				} else if (data == 55) {
					html += '<option value="11">재직</option>';
					html += '<option value="55" selected>휴직</option>';
					html += '<option value="99">퇴직</option>';
				} else if (data == 99) {
					html += '<option value="11">재직</option>';
					html += '<option value="55">휴직</option>';
					html += '<option value="99" selected>퇴직</option>';
				} else {
					html += '<option value="0" disabled selected>없음</option>';
					html += '<option value="11">재직</option>';
					html += '<option value="55">휴직</option>';
					html += '<option value="99">퇴직</option>';
				}
	
				$("#employmentup").empty();
				$("#employmentup").append(html);
	
			}
	
			function getApprovalup(data) {
	
				var html = '';
	
				html += '<option value=' + USER_NAPP + '>' + USER_NAME + '</option>';
				html += '<option value=' + USER_HEAD_NAPP + '>' + USER_HEAD_NAME + '</option>';
				html += '<option value=' + MANAGER_NAPP + '>' + MANAGER_NAME + '</option>';
				html += '<option value=' + MANAGER_HEAD_NAPP + '>' + MANAGER_HEAD_NAME + '</option>';
				html += '<option value=' + OPERATOR_NAPP + '>' + OPERATOR_NAME + '</option>';
				if (data == ADMIN_NAPP) {
					html = '<option value=' + ADMIN_NAPP + ' selected disabled>' + ADMIN_NAME + '</option>';
				}
	
				if (data == CONTROL_OPERATOR_NAPP) {
					html = '<option value=' + CONTROL_OPERATOR_NAPP + ' selected disabled>' + CONTROL_OPERATOR_NAME + '</option>';
				}
	
				$("#nApprovalSBup").empty();
				$("#nApprovalSBup").append(html);
	
				if (data == USER_NAPP) {
					$("#nApprovalSBup option:eq(0)").attr("selected", "selected");
				} else if (data == USER_HEAD_NAPP) {
					$("#nApprovalSBup option:eq(1)").attr("selected", "selected");
				} else if (data == MANAGER_NAPP) {
					$("#nApprovalSBup option:eq(2)").attr("selected", "selected");
				} else if (data == MANAGER_HEAD_NAPP) {
					$("#nApprovalSBup option:eq(3)").attr("selected", "selected");
				} else if (data == OPERATOR_NAPP) {
					$("#nApprovalSBup option:eq(4)").attr("selected", "selected");
				} 
			}
	
			function getTenantListUp(tenant_id, service_id) {
				var sCompany = $("#sCompanySBup option:selected").val();
				$.ajax({
					url: "/tenant/selectTenantListByCompanyId.do",
					data: {
						companyId: sCompany
					},
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value=-1 selected disabled>테넌트 미지정</option>';
						} else {
							html += '<option value=-1>테넌트 미지정</option>';
							for (key in data) {
								if (tenant_id != data[key].id) {
									html += '<option value=' + data[key].id + ' value2=' + data[key].dhcpOnoff + '>' + data[key].name + '</option>';
								} else {
									html += '<option value=' + data[key].id + ' value2=' + data[key].dhcpOnoff + ' selected>' + data[key].name + '</option>';
								}
							}
						}
						$("#tenantSBup").empty();
						$("#tenantSBup").append(html);
						serviceInTenantUp(service_id);
					}
				})
			}
	
			function serviceInTenantUp(service_id) {
				var tenantsID = $("#tenantSBup option:selected").val();
				$.ajax({
					data: {
						tenantId: tenantsID
					},
					url: "/tenant/selectVMServiceListByTenantId.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value=0 value2=0 selected disabled>서비스 미지정</option>';
						} else {
							html += '<option value=0 value2=0>서비스 미지정</option>';
							for (key in data) {
								if (service_id != data[key].vmServiceID) {
									html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].dhcpOnoff + '>' + data[key].vmServiceName + '</option>';
								} else {
									html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].dhcpOnoff + ' selected>' + data[key].vmServiceName + '</option>';
								}
							}
						}
						$("#tenantInServiceSBup").empty();
						$("#tenantInServiceSBup").append(html);
					}
				})
			}
	
			//기본 Date 형식 yyyy-MM-dd 로 변경하기 ("Thu Jun 09 2011 00:00:00 GMT+0530 (India Standard Time)")
			function convert(str) {
				var date = new Date(str),
					month = ("0" + (date.getMonth() + 1)).slice(-2),
					day = ("0" + date.getDate()).slice(-2);
				return [date.getFullYear(), month, day].join("-");
			}
	
			//String to Date type 
			function str_to_date(date_str) {
				var yyyyMMdd = String(date_str);
				var sYear = yyyyMMdd.substring(0, 4);
				var sMonth = yyyyMMdd.substring(5, 7);
				var sDate = yyyyMMdd.substring(8, 10);
	
				return new Date(Number(sYear), Number(sMonth) - 1, Number(sDate));
			}
	
			//상세 보기,업데이트 모달 창
			function selectUserUpdateCheck(id, name, index) {
				$.ajax({
					data: {
						id: id
					},
					url: "/user/selectUser.do",
					success: function(data) {
						var html = '';
						var company = '';
						var employment = '';
						var date = new Date(data.dStartday);
	
						$("#sEngNameup").val(data.sNameEng);
						$("#sRankup").val(data.sJobCode);
						$("#startDateup").val(convert(date));
						$("#sUserIPup").val(data.sUserIP);
	
						$("#sNameup").val(data.sName);
						$("#sUserIDup").val(data.sUserID);
						$("#nNumberup").val(data.nNumber);
						$("#sEmailAddressup").val(data.sEmailAddress);
	
						selectUserInCompanyList(data.sCompany);
	
						getCompanyInDeptUp(data.sCompany, data.sDepartment);
	
						btnStatusChk(id, name, index);
	
						setTimeout(function() {
							if (sessionApproval < ADMINCHECK) {
								getUserTenantList(data.nTenantId, data.nServiceId);
							} else if(sessionApproval > ADMINCHECK){
								getTenantListUp(data.nTenantId, data.nServiceId);
							}
							
						}, 100)
	
						getEmploymentup(data.sTenureCode);
	
						if (sessionUserPK == id) {
							$("#nApprovalSBup").attr("disabled", true);
						}
						
						getApprovalup(data.nApproval);
	
						if (data.sPhoneNumber == null || data.sPhoneNumber == '') {
							$("#sPhoneNumberup").val('');
						} else {
							$("#sPhoneNumberup").val(data.sPhoneNumber);
						}
	
						if (data.nApproval == 3) {
							$("#tenantDiv").empty();
						} else {
							$("#tenantSBup option:selected").val();
							$("#tenantInServiceSBup option:selected").val();
						}
						$("#changeUser").modal("show");
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
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="selectUserUpdateValidation(' + id + ')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
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
					$("#sCompanySBup").attr("disabled", true);
					$("#sDepartmentup").attr("disabled", true);
					$("#sNameup").attr("disabled", true);
					$("#sEngNameup").attr("disabled", true);
					$("#sUserIDup").attr("disabled", true);
					$("#nNumberup").attr("disabled", true);
					$("#sRankup").attr("disabled", true);
					$("#sPhoneNumberup").attr("disabled", true);
					$("#sEmailAddressup").attr("disabled", true);
					$("#startDateup").attr("disabled", true);
					$("#employmentup").attr("disabled", true);
					$("#nApprovalSBup").attr("disabled", true);
					$("#sUserIPup").attr("disabled", true);
					$("#tenantSBup").attr("disabled", true);
					$("#tenantInServiceSBup").attr("disabled", true);
	
				} else if (index == 2) {
					$("#sCompanySBup").attr("disabled", false);
					$("#sDepartmentup").attr("disabled", false);
					$("#sNameup").attr("disabled", false);
					$("#sEngNameup").attr("disabled", false);
					$("#nNumberup").attr("disabled", false);
					$("#sRankup").attr("disabled", false);
					$("#sPhoneNumberup").attr("disabled", false);
					$("#sEmailAddressup").attr("disabled", false);
					$("#startDateup").attr("disabled", false);
					$("#employmentup").attr("disabled", false);
					$("#nApprovalSBup").attr("disabled", false);
					$("#sUserIPup").attr("disabled", false);
					$("#tenantSBup").attr("disabled", false);
					$("#tenantInServiceSBup").attr("disabled", false);
				}
			}
	
			function selectUserUpdateValidation(id) {
	
				var startDate = $("#startDateup").val();
				var sCompanyName = $("#sCompanySBup option:selected").text();
				var sUserIP = $("#sUserIPup").val();
				var sCompany = $("#sCompanySBup option:selected").val();
				var sDepartment = $("#sDepartmentup option:selected").val();
				var sDepartmentName = $("#sDepartmentup option:selected").text();
				var sName = $("#sNameup").val();
				var nNumber = $("#nNumberup").val();
				var sPhoneNumber = $("#sPhoneNumberup").val();
				var sEmailAddress = $("#sEmailAddressup").val();
				var nApproval = $("#nApprovalSBup option:selected").val();
				var approvalName = $("#nApprovalSBup option:selected").text();
				var sTenureCode = $("#employmentup option:selected").val();
				var sTenureName = $("#employmentup option:selected").text();
				var tenantSBval = $("#tenantSBup option:selected").val();
				var serviceSBval = $("#tenantInServiceSBup option:selected").val();
				var sEngName = $("#sEngNameup").val(); //sNameEng
				var sRank = $("#sRankup").val();//sJobCode
				var tenantSBs = $("#tenantSBup option:selected").text();
				var serviceSBs = $("#tenantInServiceSBup option:selected").text();
	
				var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
				var blank_pattern = /[\s]/g;
				var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
				var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
				var filter = /^([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\.([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])){3}$/;
	
				if (!sName) {
					alert("이름을 입력하십시오.");
					$("#sNameup").focus();
					return false;
				} else if ($.isNumeric(sName)) {
					$("#sNameup").focus();
					alert("이름에 숫자를 넣을 수 없습니다.");
					return false;
				} else if (!sDepartment) {
					alert("부서를 선택하십시오.");
					$("#sDepartmentup").focus();
					return false;
				} else if (!employment) {
					alert("재직 여부를 선택하십시오.");
					$("#employmentup").focus();
					return false;
				} else if (sEmailAddress.match(regExp) == null && sEmailAddress != null && sEmailAddress != '') {
					$("#sEmailAddressup").focus();
					alert("이메일 형식이 올바르지 않습니다.");
					return false;
				} else {
	
					$.ajax({
						data: {
							companyName: sCompanyName,
							id: id,
							sUserIP: sUserIP,
							sCompany: sCompany,
							sDepartment: sDepartment,
							sDepartmentName: sDepartmentName,
							sName: sName,
							nNumber: nNumber,
							sPhoneNumber: sPhoneNumber,
							sEmailAddress: sEmailAddress,
							nApproval: nApproval,
							approvalName: approvalName,
							sTenureCode: sTenureCode,
							tenureName: sTenureName,
							nTenantId: tenantSBval,
							nServiceId: serviceSBval,
							sNameEng: sEngName,
							sJobCode: sRank,
							dStartday: startDate,
							sTenantName: tenantSBs,
							sServiceName: serviceSBs
						},
						url: "/user/updateUser.do",
						type:'POST',
						success: function(data) {
							if (data == 1) {
								alert("변경이 완료되었습니다.");
								window.parent.location.reload();
							} else if (data == 2) {
								if (confirm("해당 사용자는 테넌트 관리자입니다.\n테넌트 관리자를 변경하시겠습니까?") == true) {
									window.parent.location.href = '/menu/tenantSetting.do#1';
								} else {
									return false;
								}
							} else if (data == 3) {
								if (confirm("해당 사용자는 서비스 관리자입니다.\n서비스 관리자를 변경하시겠습니까?") == true) {
									window.parent.location.href = '/menu/tenantSetting.do#2';
								} else {
									return false;
								}
							} else {
								alert("변경이 실패하였습니다.");
								return false;
							}
						}
					})
	
				}
			}
	
			function getCompanyList() {
	
				$.ajax({
					url: "/user/selectCompanyList.do",
					success: function(data) {
						var html = '';
						html += '<option value=0 selected disabled>:: 회사를 선택하십시오. ::</option>';
						for (key in data) {
							html += '<option value=' + data[key].id + '>' + data[key].name + '</option>';
						}
						$("#sCompanySB").empty();
						$("#sCompanySB").append(html);
					}
				})
			}
	
			//생성
			function usercreate() {
				var tenantSBval = $("#tenantSB option:selected").val();
				var serviceSBval = $("#tenantInServiceSB option:selected").val();
				var user_id = $("#sUserID").val();
				var user_name = $("#sName").val();
				var user_IP = $("#sUserIP").val();
				var emailAddr = $("#sEmailAddress").val();
				var companySB = $('select#sCompanySB').val();
				var approvalSB = $('select#nApprovalSB').val();
				var phoneNumber = $("#sPhoneNumber").val();
	
				var employment = $('#employment option:selected').val();
				var department = $("#sDepartment option:selected").val();
	
				var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
				var blank_pattern = /[\s]/g;
				var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
				var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
				var filter = /^([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\.([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])){3}$/;

				if (!user_name) {
					alert("이름을 입력하십시오.");
					$("#sName").focus();
					return false;
				} else if ($.isNumeric(user_name)) {
					$("#sName").focus();
					alert("이름에 숫자를 포함할 수 없습니다.");
					return false;
				} else if (!user_id) {
					alert("아이디을 입력하십시오.");
					$("#sUserID").focus();
					return false;
				} else if (blank_pattern.test(user_id) == true) {
					alert("아이디에 공백을 포함할 수 없습니다.");
					$("#sUserID").focus();
					return false;
				} else if (check.test(user_id)) {
					$("#sUserID").focus();
					alert("아이디에 한글을 포함할 수 없습니다.");
					return false;
				} else if (!companySB) {
					$("#sCompanySB").focus();
					alert("회사를 선택하십시오.");
					return false;
				} else if (!department) {
					alert("부서를 선택하십시오.");
					$("#sDepartment").focus();
					return false;
				} else if (!approvalSB) {
					alert("권한을 선택하십시오.");
					$("#nApprovalSB").focus();
					return false;
				} else if (!employment) {
					alert("재직 여부를 선택하십시오.");
					$("#employment").focus();
					return false;
				} else if (emailAddr.match(regExp) == null && emailAddr != null && emailAddr != '') {
					$("#sEmailAddress").focus();
					alert("이메일 형식이 올바르지 않습니다.");
					return false;
				} else if (tenantSBval && !serviceSBval) {
					alert("테넌트만 선택 할 수 없습니다.\n서비스를 선택하십시오.");
					$("#tenantInServiceSB").focus();
				} else {
					insert_userCreate();
				}
			}
	
			function insert_userCreate() {
				var user_id = $("#sUserID").val();
				var user_name = $("#sName").val();
				var user_IP = $("#sUserIP").val();
				var sEngName = $("#sEngName").val();
				var sRank = $("#sRank").val();
				var companySB = $('#sCompanySB option:selected').val();
				var companySBs = $('#sCompanySB option:selected').text();
				var tenantSB = $('#tenantSB option:selected').val();
				var tenantSBs = $('#tenantSB option:selected').text();
				var tenantInServiceSB = $('#tenantInServiceSB option:selected').val();
				var tenantInServiceSBs = $('#tenantInServiceSB option:selected').text();
				var employment = $('#employment option:selected').val();
				var employmentName = $('#employment option:selected').text();
				var approvalSB = $('select#nApprovalSB').val();
				var approvalName = $('#nApprovalSB option:selected').text();
				var user_nNumber = $("#nNumber").val();
				var user_Depart = $("#sDepartment option:selected").val();
				var user_DepartName = $("#sDepartment option:selected").text();
				var emailAddr = $("#sEmailAddress").val();
				var phoneNumber = $("#sPhoneNumber").val();
				var startDate = $("#startDate").val();
				
				$.ajax({
					data: {
						companyName: companySBs,
						sUserID: user_id,
						sName: user_name,
						sDepartment: user_Depart,
						sDepartmentName: user_DepartName,
						nApproval: approvalSB,
						approvalName: approvalName,
						nNumber: user_nNumber,
						sCompany: companySB,
						sEmailAddress: emailAddr,
						sPhoneNumber: phoneNumber,
						sUserIP: user_IP,
						nTenantId: tenantSB,
						nServiceId: tenantInServiceSB,
						sTenureCode: employment,
						tenureName: employmentName,
						sJobCode: sRank,
						sNameEng: sEngName,
						dStartday: startDate,
						sTenantName: tenantSBs,
						sServiceName: tenantInServiceSBs
					},
					url: "/user/insertUser.do",
					type:'POST',
					success: function(data) {
						if (data == 1) {
							alert("등록이 완료되었습니다.");
							window.parent.location.reload();
						} else if (data == 2) {
							alert("동일한 아이디가 있습니다.\n다른 아이디를 사용해 주십시오.");
							return;
						} else {
							alert("등록에 실패하였습니다.");
							return;
						}
					}
				})
			}
	
			function getUserTenantList(tenants_id, service_id) {
				$.ajax({
					url: "/tenant/selectLoginUserTenantList.do",
					success: function(data) {
						var html = '';
						for (key in data) {
							if( tenants_id != data[key].id ){
							html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
							} else {
							html += '<option value=' + data[key].id + ' value2=' + data[key].name + ' selected>' + data[key].name + '</option>';
							}
						}
						$("#tenantSBup").empty();
						$("#tenantSBup").append(html);
						serviceInTenantUp(service_id);
						
					}
				})
			}
	
			function getTenantList() {
	
				var sCompany = $("#sCompanySB option:selected").val();
	
				$.ajax({
					url: "/tenant/selectTenantListByCompanyId.do",
					data: {
						companyId: sCompany
					},
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value=-1 selected disabled>:: 테넌트가 없습니다. ::</option>';
						} else {
							html += '<option value=-1>지정 안함</option>';
							for (key in data) {
								html += '<option value=' + data[key].id + ' value2=' + data[key].dhcpOnoff + '>' + data[key].name + '</option>';
							}
						}
						$("#tenantSB").empty();
						$("#tenantSB").append(html);
						serviceInTenant();
					}
				})
	
			}
	
			function serviceInTenant() {
				var tenantsID = $("#tenantSB option:selected").val();
				
				$.ajax({
					data: {
						tenantId: tenantsID
					},
					url: "/tenant/selectVMServiceListByTenantId.do",
					success: function(data) {
						var html = '';
						if (data == null || data == '') {
							html = '<option value=0 selected disabled>지정 안함</option>';
						} else {
							html += '<option value=0>지정 안함</option>';
							for (key in data) {
								html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].dhcpOnoff + '>' + data[key].vmServiceName + '</option>';
							}
						}
						$("#tenantInServiceSB").empty();
						$("#tenantInServiceSB").append(html);
					}
				})
			}
	
			function userProDetail(sUserID) {
				$.ajax({
					url: "/user/selectUserBySUserID.do",
					data: {
						sUserID: sUserID
					},
					success: function(data) {
						var html = "";
						var footer = "";
						var value = "\'" + data.sUserID + "\'";
						var userPK = data.nNumber;
	
						html += '<div class="form-group row">';
						html += '<label class="col-form-label col-md-4">이름:</label>';
						html += '<div class="col-md-8">';
						html += '<input type="text" class="form-control form-control-modal" placeholder="이름" id="sName" value=' + data.sName + ' disabled>';
						html += '</div>';
						html += '</div>';
	
						html += '<div class="form-group row">';
						html += '<label class="col-form-label col-md-4">아이디:</label>';
						html += '<div class="col-md-8">';
						html += '<input type="hidden" id="nNumber" value=' + data.nNumber + '>';
						html += '<input type="text" class="form-control form-control-modal" id="sUserID" value=' + data.sUserID + ' disabled>';
						html += '</div>';
						html += '</div>';
	
						html += '<div class="form-group row">';
						html += '<label class="col-form-label col-md-4">사번:</label>';
						html += '<div class="col-md-8">';
						html += '<input type="text" class="form-control form-control-modal" id="sUserNumber" value="' + data.nNumber + '" disabled>';
						html += '</div>';
						html += '</div>';
	
						html += '<div class="form-group row">';
						html += '<label class="col-form-label col-md-4">부서:</label>';
						html += '<div class="col-md-8">';
						html += '<input type="text" class="form-control form-control-modal" id="sDepartment" value=' + data.sDepartmentName + ' disabled>';
						html += '</div>';
						html += '</div>';
	
						html += '<div class="form-group row">';
						html += '<label class="col-form-label col-md-4">기존 비밀번호:</label>';
						html += '<div class="col-md-8">';
						html += '<input type="password" class="form-control form-control-modal" placeholder="기존 비밀번호" id="nowPW">';
						html += '</div>';
						html += '</div>';
	
						html += '<div id="newPWappend"></div>';
	
						footer += '<button type="button" class="btn bg-prom rounded-round" onclick="userPasswordupdate(' + data.id + "," + value + ')">확인</button>';
	
						$("#passwordChange-modal-body").empty();
						$("#passwordChange-modal-body").append(html);
	
						$("#passwordChange-modal-footer").empty();
						$("#passwordChange-modal-footer").append(footer);
	
						$("#passwordChange").modal("show");
	
						$('#passwordChange').on('shown.bs.modal', function() {
							$('#nowPW').focus();
						})
	
						$(document).on('keydown', '#nowPW', function(event) {
							if (event.keyCode == 13) {
								userPasswordupdate(data.id, value);
							}
						})
					}
				})
			}
	
			function userPasswordupdate(id, userid) {
				var nowPW = $("#nowPW").val();
				var sUserID = $("#sUserID").val();
	
				$.ajax({
					url: "/user/verifyPassword.do",
					data: {
						sUserPW: nowPW,
						sUserID: sUserID,
					},
					type:'POST',
					success: function(data) {
						if (data == 0) {
							alert("기존 비밀번호가 일치하지 않습니다. 다시 확인해 주십시오.");
							$('#nowPW').focus();
							return false;
						} else if (data == 1) {
							var html = '';
							var footer = '';
							var value = "\'" + sUserID + "\'";
	
							html += '<div class="form-group row">';
							html += '<label class="col-form-label col-md-4">새 비밀번호:</label>';
							html += '<div class="col-md-8">';
							html += '<input type="password" class="form-control form-control-modal" placeholder="새 비밀번호" id="NewPW">';
							html += '</div>';
							html += '</div>';
	
							html += '<div class="form-group row">';
							html += '<label class="col-form-label col-md-4">새 비밀번호 확인:</label>';
							html += '<div class="col-md-8">';
							html += '<input type="password" class="form-control form-control-modal" placeholder="새 비밀번호 확인" id="NewPWconfirm">';
							html += '</div>';
							html += '</div>';
	
							footer += '<button type="button" class="btn bg-prom rounded-round" onclick="userNewPasswordupdate(' + id + ',' + value + ')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
	
							$("#newPWappend").empty();
							$("#newPWappend").append(html);
	
							$("#passwordChange-modal-footer").empty();
							$("#passwordChange-modal-footer").append(footer);
	
							$('#NewPW').focus();
	
							$(document).on('keydown', '#NewPW', function(event) {
								if (event.keyCode == 13) {
									userNewPasswordupdate(id, value);
								}
							})
							
							$(document).on('keydown', '#NewPWconfirm', function(event) {
								if (event.keyCode == 13) {
									userNewPasswordupdate(id, value);
								}
							})
						}
					}
				})
			}
	
			function userNewPasswordupdate(id, userId) {
				var NewPW = $("#NewPW").val();
				var NewPWconfirm = $("#NewPWconfirm").val();
	
				var pw = NewPW;
				var num = pw.search(/[0-9]/g);
				var eng = pw.search(/[a-z]/ig);
				var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
				var lowerchk = NewPW.toLowerCase();
				var upperchk = NewPW.toUpperCase();
				if (pw.length < 8 || pw.length > 20) {
					alert("8자리 ~ 20자리 이내로 입력해 주십시오.");
					return false;
	
				} else if (pw.search(/₩s/) != -1) {
					alert("공백 없이 입력해 주십시오.");
					return false;
				} else {
	
					$.ajax({
						url: "/user/upateNewPassword.do",
						data: {
							newPW: NewPW,
							newPWconfirm: NewPWconfirm,
							id: id,
							sUserID: userId
						},
						type:'POST',
						success: function(data) {
							if (data == 1) {
								alert("비밀번호 변경 완료");
								location.reload();
							} else if (data == 0) {
								alert("새 비밀번호가 일치하지 않습니다. 다시 확인해 주십시오.");
								$("#NewPW").focus();
							} else if (data == 2) {
								alert("특수문자, 영문 대소문자, 숫자 조합을 넣으십시오.");
								$("#NewPW").focus();
							} else if ( data == 3 ){
								alert("기존 비밀번호와 같은 비밀번호를 사용할 수 없습니다.");
								$("#NewPW").focus();
							}
						}
					})
				}
			}
		</script>
	</head>
	
	<body>
	<div id="sdf">
	</div>
		<div id="passwordChange" class="modal fade" tabindex="-1">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">비밀번호 변경</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body modal-type-5" id="passwordChange-modal-body"></div>
					<div class="modal-footer bg-white" id="passwordChange-modal-footer"></div>
				</div>
			</div>
		</div>
	
		<div id="addUser" class="modal fade">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">사용자 등록</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body bg-light modal-type-2">
						<div class="row-padding-0">
							<div class="col-sm-6 col-xl-6 padding-0">
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
														<label>이름:<span class="text-prom ml-2">(필수)</span></label>
														<input type="text" class="form-control form-control-modal" placeholder="name" autocomplete="off" maxlength="20" onkeyup="userRegisterEnterkey()" id="sName">
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>아이디:<span class="text-prom ml-2">(필수)</span></label>
														<input type="text" class="form-control form-control-modal" placeholder="ID" autocomplete="off" maxlength="15" onkeyup="userRegisterEnterkey()" id="sUserID">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>회사:<span class="text-prom ml-2">(필수)</span></label>
														<select class="form-control select-search" id="sCompanySB" data-fouc></select>
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>부서:<span class="text-prom ml-2">(필수)</span></label>
														<select class="form-control select-search" id="sDepartment" data-fouc>
															<option value=0 selected disabled>:: 회사 선택 후 선택할 수 있습니다. ::</option>
														</select>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>권한:<span class="text-prom ml-2">(필수)</span></label>
														<select class="form-control select" id="nApprovalSB" data-fouc>
															<option value="" selected disabled>:: 권한을 선택하십시오. ::</option>
															<option value="${USER_NAPP}">${USER_NAME}</option>
															<option value="${USERHEAD_NAPP}">${USERHEAD_NAME}</option>
															<option value="${MANAGER_NAPP}">${MANAGER_NAME}</option>
															<option value="${MANAGERHEAD_NAPP}">${MANAGERHEAD_NAME}</option>
															<option value="${OPERATOR_NAPP}">${OPERATOR_NAME}</option>
														</select>
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>재직 여부:<span class="text-prom ml-2">(필수)</span></label>
														<select class="form-control select" id="employment" data-fouc>
															<option value="" selected disabled>:: 재직 여부를 선택하십시오. ::</option>
															<option value="11">재직</option>
															<option value="55">휴직</option>
															<option value="99">퇴직</option>
														</select>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-6 col-xl-6 padding-0">
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
														<label>영문 이름: </label>
														<input type="text" class="form-control form-control-modal" placeholder="english name" autocomplete="off" maxlength="20" onkeyup="userRegisterEnterkey()" id="sEngName">
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>직급: </label>
														<input type="text" class="form-control form-control-modal" placeholder="position" autocomplete="off" maxlength="10" onkeyup="userRegisterEnterkey()" id="sRank">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>이메일:</label>
														<input type="text" class="form-control form-control-modal" placeholder="email" autocomplete="off" maxlength="25" onkeyup="userRegisterEnterkey()" id="sEmailAddress">
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>전화번호:</label>
														<input type="text" class="form-control form-control-modal" placeholder="XXX-XXXX-XXXX" autocomplete="off" maxlength="20" onKeyup="userRegisterEnterkey();" id="sPhoneNumber">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>입사일:</label>
														<input type="date" class="form-control form-control-modal" onkeyup="userRegisterEnterkey()" id="startDate">
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>사번:</label>
														<input type="text" class="form-control form-control-modal" placeholder="employee number" autocomplete="off" maxlength="15" onKeyup="userRegisterEnterkey();" id="nNumber">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-12 col-xl-12">
													<div class="form-group">
														<label>IP 주소:</label>
														<input type="text" class="form-control form-control-modal" placeholder="IP address" autocomplete="off" onkeyup="userRegisterEnterkey()" id="sUserIP">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>테넌트:</label>
														<select class="form-control select-search" id="tenantSB" data-fouc>
															<option value="" selected disabled>:: 테넌트를 선택하십시오. ::</option>
														</select>
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>서비스:</label>
														<select class="form-control select-search" id="tenantInServiceSB" data-fouc>
															<option value="" selected disabled>:: 테넌트 선택후 선택할 수 있습니다. ::</option>
														</select>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white">
						<button type="button" class="btn rounded-round bg-prom" onclick="usercreate()">등록<i class="icon-checkmark2 ml-2"></i></button>
					</div>
				</div>
			</div>
		</div>
	
		<div id="changeUser" class="modal fade">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header bg-prom" id="modal-header"></div>
					<div class="modal-body bg-light modal-type-2">
						<div class="row-padding-0">
							<div class="col-sm-6 col-xl-6 padding-0">
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
														<label>이름:<span class="text-prom ml-2">(필수)</span></label>
														<input type="text" class="form-control form-control-modal" autocomplete="off" maxlength="20" onkeyup="userUpdateEnterkey()" id="sNameup">
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>아이디:<span class="text-prom ml-2">(필수)</span></label>
														<input type="text" class="form-control form-control-modal" autocomplete="off" maxlength="15" onkeyup="userUpdateEnterkey()" id="sUserIDup" disabled>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>회사:<span class="text-prom ml-2">(필수)</span></label>
														<select class="form-control select-search" id="sCompanySBup" data-fouc></select>
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>부서:<span class="text-prom ml-2">(필수)</span></label>
														<select class="form-control select-search" id="sDepartmentup" data-fouc></select>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>권한:<span class="text-prom ml-2">(필수)</span></label>
														<select class="form-control select" id="nApprovalSBup" data-fouc></select>
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>재직 여부:<span class="text-prom ml-2">(필수)</span></label>
														<select class="form-control select" id="employmentup" data-fouc>
															<option value="" selected disabled>:: 재직 여부를 선택하십시오. ::</option>
															<option value="11">재직</option>
															<option value="55">휴직</option>
															<option value="99">퇴직</option>
														</select>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-6 col-xl-6 padding-0">
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
														<label>영문 이름: </label>
														<input type="text" class="form-control form-control-modal" autocomplete="off" maxlength="20" onkeyup="userUpdateEnterkey()" id="sEngNameup">
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>직급: </label>
														<input type="text" class="form-control form-control-modal" autocomplete="off" maxlength="10" onkeyup="userUpdateEnterkey()" id="sRankup">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>이메일:</label>
														<input type="text" class="form-control form-control-modal" autocomplete="off" maxlength="25" onkeyup="userUpdateEnterkey()" id="sEmailAddressup">
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>전화번호:</label>
														<input type="text" class="form-control form-control-modal" autocomplete="off" maxlength="20" onKeyup="userUpdateEnterkey();" id="sPhoneNumberup">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>입사일:</label>
														<input type="date" class="form-control form-control-modal" onkeyup="userUpdateEnterkey()" id="startDateup">
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>사번:</label>
														<input type="text" class="form-control form-control-modal" autocomplete="off" maxlength="15" onKeyup="userUpdateEnterkey();" id="nNumberup">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-12 col-xl-12">
													<div class="form-group">
														<label>IP 주소:</label>
														<input type="text" class="form-control form-control-modal" autocomplete="off" onkeyup="userUpdateEnterkey()" id="sUserIPup">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>테넌트:</label>
														<select class="form-control select-search" id="tenantSBup" data-fouc>
															<option value="" selected disabled>:: 테넌트를 선택하십시오. ::</option>
														</select>
													</div>
												</div>
												<div class="col-sm-6 col-xl-6">
													<div class="form-group">
														<label>서비스:</label>
														<select class="form-control select-search" id="tenantInServiceSBup" data-fouc>
															<option value="" selected disabled>:: 테넌트 선택후 선택할 수 있습니다. ::</option>
														</select>
													</div>
												</div>
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
	
		<div class="card bg-dark mb-0 border-bottom-light">
			<table id="userTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>회사명</th>
						<th>부서명</th>
						<th>이름</th>
						<th>아이디</th>
						<th>이메일</th>
						<th>권한</th>
						<th>테넌트명</th>
						<th>서비스명</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
		
		<div class="card bg-dark mb-0 table-type-1 table-type-2">
			<div class="table-title-dark">
				<h6 class="card-title mb-0">내 정보</h6>
			</div>
			<div class="datatables-body">
				<table class="promTable hover" style="width:100%;">
					<thead>
						<tr>
							<th>회사명</th>
							<th>부서명</th>
							<th>이름</th>
							<th>아이디</th>
							<th>이메일</th>
							<th>권한</th>
							<th>테넌트명</th>
							<th>서비스명</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody id="superUser"></tbody>
				</table>
			</div>
		</div>
	</body>
</html>