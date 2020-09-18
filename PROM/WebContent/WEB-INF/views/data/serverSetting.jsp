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
				getServerList();
				modalOpen();
			})
	
			function modalOpen() {
				$("#addServer1").on("shown.bs.modal", function() {
					$("#serverSelectBox").focus();
				})
				$("#addServer2").on("shown.bs.modal", function() {
					$("#serverName").focus();
	
					$(document).on('click', '#addServerPrevious', function() {
						$("#addServer1").modal("show");
						$("#addServer2").modal("hide");
					})
				})
			}
	
			function serverRegisterEnterkey() {
				if (window.event.keyCode == 13) {
					externalInsertCheck();
				}
			}
	
			function serverTypeSetting() {
	
				var serverType = $("#serverSelectBox option:selected").val();
				var serverTypeText = $('#serverSelectBox option:selected').text();
	
				if (serverType == '') {
					alert("연동 서버를 선택하십시오");
					$("#serverSelectBox").focus();
				} else {
					$("#addServer1").modal("hide");
					$("#addServer2").modal("show");
	
					$("#serverType").val(serverTypeText);
	
					$("#serverEmailportDiv").hide();
					$("#serverIDDiv").show();
					$("#ssl_onoffDiv").hide();
	
					$("#serverPasswordDiv").removeClass("col-sm-12 col-xl-12");
					$("#serverConnectDiv").addClass("col-sm-12 col-xl-12");
	
					if (serverType == 5) {
						$("#serverEmailportDiv").show();
						$("#serverIDDiv").show();
						$("#ssl_onoffDiv").show();
	
						$("#serverPasswordDiv").removeClass("col-sm-12 col-xl-12");
						$("#serverConnectDiv").removeClass("col-sm-12 col-xl-12");
						$("#serverEmailport").attr("placeholder", "use port (587)");
	
					} else if (serverType == 6) {
						$("#serverEmailportDiv").show();
						$("#serverIDDiv").hide();
						$("#ssl_onoffDiv").hide();
	
						$("#serverPasswordDiv").addClass("col-sm-12 col-xl-12");
						$("#serverConnectDiv").removeClass("col-sm-12 col-xl-12");
						$("#serverEmailport").attr("placeholder", "use port (1812)");
					} else {
	
					}
				}
			}
	
			function externalInsertCheck() {
	
				var serverName = $("#serverName").val();
				var connectString = $("#serverConnect").val();
				var password = $("#serverPassword").val();
				var description = $("#serverDescription").val();
				var serverType = $("#serverSelectBox option:selected").val();
	
				if (!serverName) {
					alert("서버명은 필수 기입 항목입니다.");
					$("#serverName").focus();
					return false;
				} else if (!connectString) {
					alert("연결정보는 필수 기입 항목입니다.");
					$("#serverConnect").focus();
					return false;
				} else if (!password) {
					alert("비밀번호는 필수 기입 항목입니다.");
					$("#serverPassword").focus();
					return false;
				} else {
					externalInsert();
				}
			}
	
			function externalInsert() {
				var serverName = $("#serverName").val();
				var connectString = $("#serverConnect").val();
				var account = $("#serverID").val();
				var password = $("#serverPassword").val();
				var description = $("#serverDescription").val();
				var serverType = $("#serverSelectBox option:selected").val();
				var emailport = 0;
	
				var isUse = $("input[name='server_onoff']:checked").val();
				var useSSL = $("input[name='ssl_onoff']:checked").val();
	
				if ($("#serverEmailport").val() == null || $("#serverEmailport").val() == '') {
					emailport = 0;
				} else {
					emailport = $("#serverEmailport").val();
				}
	
				$.ajax({
					data: {
						serverType: serverType,
						name: serverName,
						connectString: connectString,
						account: account,
						password: password,
						description: description,
						port: emailport,
						isUse: isUse,
						ssl: useSSL
					},
					type: "POST",
					url: "/config/insertExternalServer.do",
					success: function(data) {
						if (data == 1) {
							alert("연동 서버 등록이 완료되었습니다.");
							location.reload();
						} else if (data == 2) {
							alert("해당 연동 서버는 이미 등록되어 있습니다.");
						} else {
							alert("연동 서버 등록이 실패하였습니다.");
						}
					}
	
				})
			}
	
			function getServerList() {
	
				var serverTable = $("#serverTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/config/selectExternalServerList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "serverType",
								render: function(data, type, row) {
									data = serverTypeSW(data);
									return data;
								}
							},
							{"data": "name"},
							{"data": "connectString"},
							{"data": "account"},
							{"data": "password",
								render: function(data, type, row) {
									data = '*******';
									return data;
								}
							},
							{"data": "isUse",
								render: function(data, type, row) {
									if (data == 1) {
										data = '<span class="text-prom">ON</span>';
									} else if (data == 0) {
										data = '<span class="text-muted">OFF</span>';
									}
									return data;
								}
							},
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
										html += '<a href="#" class="dropdown-item" onclick="exServerUpdateValidation(' + data + ', ' + name + ', ' + row.serverType + ', ' + 1 + ')"><i class="icon-file-text"></i>상세 보기</a>';
										html += '<a href="#" class="dropdown-item" onclick="exServerUpdateValidation(' + data + ', ' + name + ', ' + row.serverType + ', ' + 2 + ')"><i class="icon-pencil7"></i>정보 변경</a>';
										html += '<a href="#" class="dropdown-item" onclick="exServerDeleteCheck(' + data + ', ' + name + ')"><i class="icon-trash"></i>삭제</a>';
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
									title: "연동 서버 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "연동 서버 정보",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5]
									}
								}
							]
						}]
					});
				$(".addModal").html('<button type="button" class="btn bg-prom" data-toggle="modal" data-target="#addServer1"><i class="icon-plus2"></i><span class="ml-2">연동 서버 등록</span></button>');
			}
	
			function exServerUpdateValidation(id, name, serverType, index) {
				$.ajax({
	
					data: {
						id: id,
						serverType: serverType
					},
					url: "/config/selectExternalServer.do",
					success: function(data) {
						btnStatusChk(id, name, serverType, index);
	
						if (data.serverType == 5) {
							$("#serverEmailportDivup").show();
							$("#serverIDDivup").show();
							$("#ssl_onoffDivup").show();
	
							$("#serverPasswordDivup").removeClass("col-sm-12 col-xl-12");
							$("#serverConnectDivup").removeClass("col-sm-12 col-xl-12");
							$("#serverEmailportup").attr("placeholder", "use port (587)");
	
						} else if (data.serverType == 6) {
							$("#serverEmailportDivup").show();
							$("#serverIDDivup").hide();
							$("#ssl_onoffDivup").hide();
	
							$("#serverPasswordDivup").addClass("col-sm-12 col-xl-12");
							$("#serverConnectDivup").removeClass("col-sm-12 col-xl-12");
							$("#serverEmailportup").attr("placeholder", "use port (1812)");
						} else {
							$("#serverEmailportDivup").hide();
							$("#serverIDDivup").show();
							$("#ssl_onoffDivup").hide();
	
							$("#serverPasswordDivup").removeClass("col-sm-12 col-xl-12");
							$("#serverConnectDivup").addClass("col-sm-12 col-xl-12");
						}
	
						$("#serverTypeup").val(serverTypeSW(data.serverType));
						$("#serverNameup").val(data.name);
						$("#serverConnectup").val(data.connectString);
						$("#serverEmailportup").val(data.port);
						$("#serverIDup").val(data.account);
						$("#serverPasswordup").val(data.password);
						$("#serverDescriptionup").val(data.description);
	
						if (data.isUse == 0) {
							$("input:radio[name='server_onoffup'][value='0']").prop("checked", true);
						} else if (data.isUse == 1) {
							$("input:radio[name='server_onoffup'][value='1']").prop("checked", true);
						}
	
						if (data.ssl == 0) {
							$("input:radio[name='ssl_onoffup'][value='0']").prop("checked", true);
						} else if (data.sSL == 1) {
							$("input:radio[name='ssl_onoffup'][value='1']").prop("checked", true);
						}
	
						$("#changeServer").modal("show");
					}
				})
			}
	
			function btnStatusChk(id, name, serverType, index) {
				var header = '';
				var footer = '';
	
				if (index == 1) {
					header += '<h5 class="modal-title mb-0">' + name + ' 상세 보기</h5>';
					$("#modal-footer").hide();
	
				} else if (index == 2) {
					header += '<h5 class="modal-title mb-0">' + name + ' 정보 변경</h5>';
					footer += '<button type="button" class="btn bg-prom rounded-round" onclick="dynamicUpdate(' + id + ', ' + serverType + ')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
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
					$("#serverNameup").attr("disabled", true);
					$("#serverConnectup").attr("disabled", true);
					$("#serverEmailportup").attr("disabled", true);
					$("#serverIDup").attr("disabled", true);
					$("#serverPasswordup").attr("disabled", true);
					$("#serverDescriptionup").attr("disabled", true);
					$("#server_onup").attr("disabled", true);
					$("#server_offup").attr("disabled", true);
					$("#ssl_onup").attr("disabled", true);
					$("#ssl_offup").attr("disabled", true);
	
				} else if (index == 2) {
					$("#serverNameup").attr("disabled", false);
					$("#serverConnectup").attr("disabled", false);
					$("#serverEmailportup").attr("disabled", false);
					$("#serverIDup").attr("disabled", false);
					$("#serverPasswordup").attr("disabled", false);
					$("#serverDescriptionup").attr("disabled", false);
					$("#server_onup").attr("disabled", false);
					$("#server_offup").attr("disabled", false);
					$("#ssl_onup").attr("disabled", false);
					$("#ssl_offup").attr("disabled", false);
	
				}
			}
	
			function serverTypeSW(type) {
				switch (type) {
					case 1:
						return "vCenter";
						break;
					case 2:
						return "vRealize Orchestrator";
						break;
					case 3:
						return "vRealize Operations";
						break;
					case 4:
						return "vRealize Automation";
						break;
					case 5:
						return "Email";
						break;
					case 6:
						return "OTP Server";
						break;
					default:
						return "";
				}
			}
	
			function dynamicUpdate(id, serverType) {
	
				var serverName = $("#serverNameup").val();
				var serverConnect = $("#serverConnectup").val();
				var serverID = $("#serverIDup").val();
				var serverPassword = $("#serverPasswordup").val();
				var serverDescription = $("#serverDescriptionup").val();
				var serverInType = serverType;
	
				var emailport = 0;
				if ($("#serverEmailportup").val() == null || $("#serverEmailportup").val() == '') {
					emailport = 0;
				} else {
					emailport = $("#serverEmailportup").val();
				}
	
				if ($("#serverIDup").val() == null || $("#serverIDup").val() == '') {
					serverID = "";
				} else {
					serverID = $("#serverIDup").val();
				}
	
				var isUse = $("input[name='server_onoffup']:checked").val();
				var useSSL = $("input[name='ssl_onoffup']:checked").val();
	
				if (!serverName) {
					alert("서버명은 필수 기입 항목입니다.");
					$("#serverNameup").focus();
					return false;
				} else if (!serverConnect) {
					alert("연결정보는 필수 기입 항목입니다.");
					$("#serverConnectup").focus();
					return false;
				} else if (!serverPassword) {
					alert("비밀번호는 필수 기입 항목입니다.");
					$("#serverPasswordup").focus();
					return false;
				} else {
					$.ajax({
						type: "POST",
						url: "/config/updateExternalServer.do",
						data: {
							id: id,
							name: serverName,
							serverType: serverInType,
							connectString: serverConnect,
							account: serverID,
							password: serverPassword,
							description: serverDescription,
							isUse: isUse,
							ssl: useSSL,
							port: emailport
						},
						success: function(data) {
							if (data == 1) {
								alert("연동 서버 변경이 완료되었습니다.");
								location.reload();
							} else if (data == 2) {
								alert("서버 종류는 변경할 수 없습니다.");
							} else {
								alert("연동 서버 변경이 실패하였습니다.");
							}
						}
					})
				}
			}
	
	
	
			function exServerDeleteCheck(id, name) {
	
				if (confirm(name + " 등록 서버를 삭제하시겠습니까?\n서버 삭제 시 제대로 동작하지 않을 수 있습니다.") == true) {
					exServerDelete(id, name);
				} else {
					return false;
				}
			}
	
			function exServerDelete(id, name) {
	
				$.ajax({
					type: "POST",
					url: "/config/deleteExternalServer.do",
					data: {
						id: id,
						name: name
					},
					success: function(data) {
						if (data == 1) {
							alert("삭제가 완료되었습니다.");
							location.reload();
						} else {
							alert("삭제가 실패하였습니다.");
						}
					}
				})
			}
		</script>
	</head>
	<body>
		<div id="addServer1" class="modal fade">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">연동 서버 등록</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body modal-type-5">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>서버 종류:<span class="text-prom ml-2">(필수)</span></label>
									<select class="form-control select-search" id="serverSelectBox" data-fouc>
										<option value="" selected disabled>:: 서버를 선택하십시오. ::</option>
										<option value="1">vCenter</option>
										<option value="2">vRealize Orchestrator</option>
										<option value="3">vRealize Operations</option>
										<option value="4">vRealize Automation</option>
										<option value="5">Email</option>
										<option value="6">OTP Server</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white">
						<button type="button" class="btn bg-prom rounded-round" onclick="serverTypeSetting()">다음<i class="icon-arrow-right13 ml-2"></i></button>
					</div>
				</div>
			</div>
		</div>
		
		<div id="addServer2" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">연동 서버 등록</h5>
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
												<label>서버 종류:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" id="serverType" disabled>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>서버명:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="sercer name" autocomplete="off" maxlength="50" onkeyup="serverRegisterEnterkey()" id="serverName">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6" id="serverConnectDiv">
											<div class="form-group">
												<label>연결 정보:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="connection information" autocomplete="off" maxlength="50" onkeyup="serverRegisterEnterkey()" id="serverConnect">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6" id="serverEmailportDiv">
											<div class="form-group">
												<label>사용 포트:<span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" id="serverEmailport">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6" id="serverIDDiv">
											<div class="form-group">
												<label>계정 아이디:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="ID" autocomplete="off" maxlength="50" onkeyup="serverRegisterEnterkey()" id="serverID">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6" id="serverPasswordDiv">
											<div class="form-group">
												<label>비밀번호:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="password" autocomplete="off" maxlength="50" onkeyup="serverRegisterEnterkey()" id="serverPassword">
											</div>
										</div>
									</div>
									<div class="row mt-1">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group form-check-inline">
												<div class="custom-control custom-radio mr-2-5">
													<input type="radio" class="custom-control-input" name="server_onoff" id="server_on" value="1" checked>
													<label class="custom-control-label" for="server_on">사용</label>
												</div>
												<div class="custom-control custom-radio">
													<input type="radio" class="custom-control-input" name="server_onoff" id="server_off" value="0">
													<label class="custom-control-label" for="server_off">미사용</label>
												</div>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6" id="ssl_onoffDiv">
											<div class="form-group form-check-inline">
												<div class="custom-control custom-radio mr-2-5">
													<input type="radio" class="custom-control-input" name="ssl_onoff" id="ssl_on" value="1">
													<label class="custom-control-label" for="ssl_on">SSL 사용</label>
												</div>
												<div class="custom-control custom-radio">
													<input type="radio" class="custom-control-input" name="ssl_onoff" id="ssl_off" value="0" checked>
													<label class="custom-control-label" for="ssl_off">SSL 미사용</label>
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
												<input type="text" class="form-control form-control-modal" placeholder="description" autocomplete="off" maxlength="50" onkeyup="serverRegisterEnterkey()" id="serverDescription">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white justify-content-between">
						<button type="button" class="btn btn-outline bg-prom text-prom border-prom border-2 rounded-round" id="addServerPrevious"><i class="icon-arrow-left12"></i>이전</button>
						<button type="button" class="btn bg-prom rounded-round" onclick="externalInsertCheck()">등록<i class="icon-checkmark2 ml-2"></i></button>
					</div>
				</div>
			</div>
		</div>
		
		<div id="changeServer" class="modal fade" tabindex="-1">
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
												<label>서버 종류:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" id="serverTypeup" disabled>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>서버명:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="server name" autocomplete="off" maxlength="50" id="serverNameup">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6" id="serverConnectDivup">
											<div class="form-group">
												<label>연결 정보:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="connection information" autocomplete="off" maxlength="50" id="serverConnectup">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6" id="serverEmailportDivup">
											<div class="form-group">
												<label>사용 포트:<span class="text-prom ml-2">(필수)</span></label>
												<input type="number" class="form-control form-control-modal" id="serverEmailportup">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6" id="serverIDDivup">
											<div class="form-group">
												<label>계정 아이디:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="ID" autocomplete="off" maxlength="50" id="serverIDup">
											</div>
										</div>
										<div class="col-sm-6 col-xl-6" id="serverPasswordDivup">
											<div class="form-group">
												<label>비밀번호:<span class="text-prom ml-2">(필수)</span></label>
												<input type="text" class="form-control form-control-modal" placeholder="password" autocomplete="off" maxlength="50" id="serverPasswordup">
											</div>
										</div>
									</div>
									<div class="row mt-1">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group form-check-inline">
												<div class="custom-control custom-radio mr-2-5">
													<input type="radio" class="custom-control-input" name="server_onoffup" id="server_onup" value="1">
													<label class="custom-control-label" for="server_onup">사용</label>
												</div>
												<div class="custom-control custom-radio">
													<input type="radio" class="custom-control-input" name="server_onoffup" id="server_offup" value="0">
													<label class="custom-control-label" for="server_offup">미사용</label>
												</div>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6" id="ssl_onoffDivup">
											<div class="form-group form-check-inline">
												<div class="custom-control custom-radio mr-2-5">
													<input type="radio" class="custom-control-input" name="ssl_onoffup" id="ssl_onup" value="1">
													<label class="custom-control-label" for="ssl_onup">SSL 사용</label>
												</div>
												<div class="custom-control custom-radio">
													<input type="radio" class="custom-control-input" name="ssl_onoffup" id="ssl_offup" value="0">
													<label class="custom-control-label" for="ssl_offup">SSL 미사용</label>
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
												<input type="text" class="form-control form-control-modal" placeholder="description" autocomplete="off" maxlength="50" id="serverDescriptionup">
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
			<table id="serverTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>서버 종류</th>
						<th>서버명</th>
						<th>연결 정보</th>
						<th>아이디 (메일 주소)</th>
						<th>비밀번호</th>
						<th>사용 여부</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>