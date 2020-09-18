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
				getOtherList();
			});
	
			function getOtherList() {
				var otherTable = $("#otherTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/config/selectBasicList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "displayName"},
							{"data": "value",
								render: function(data, type, row) {
									if (row.name == 'agentOnOff') {
										if (data == 1) {
											data = '<span class="text-prom">ON</span>';
										} else if (data == 0) {
											data = '<span class="text-muted">OFF</span>';
										}
	
									} else if (row.name == 'useOTP') {
										if (data == 1) {
											data = '<span class="text-prom">ON</span>';
										} else if (data == 0) {
											data = '<span class="text-muted">OFF</span>';
										}
	
									} else if (row.name == 'userVMCtrl') {
										if (data == 1) {
											data = '<span class="text-prom">ON</span>';
										} else if (data == 0) {
											data = '<span class="text-muted">OFF</span>';
										}
	
									} else if (row.name == 'reflashInterval' || row.name == 'autoScaleInterval') {
										data = data + ' 초';
	
									} else if (row.name == 'reflashInterval' || row.name == 'autoScaleInterval') {
										data = data + ' 초';
	
									} else if (row.name == 'pwExpiration') {
										data = data + ' 일';
	
									} else if (row.name == 'userAccessNetwork') {
										if (row.valueStr == null || row.valueStr == '') {
											data = '<span class="text-muted">없음</span>';
										} else {
											data = row.valueStr;
										}
									} else {
										data = data;
									}
									return data;
								}
							},
							{"data": "description"},
							{"data": "name",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
									var name = "\'" + data + "\'";
									var displayName = "\'" + row.displayName + "\'";
									var description = "\'" + row.description + "\'";
									var valueStr = "\'" + row.valueStr + "\'";
	
									if (sessionApproval != BanNumber && sessionApproval > CONTROLCHECK) {
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
										html += '<a href="#" class="dropdown-item" onclick="btnStatusChk(' + name + ', ' + displayName + ', ' + row.value + ', ' + valueStr + ', ' + description + ')"><i class="icon-pencil7"></i>정보 변경</a>';
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
									title: "기타 설정",
									exportOptions: {
										columns: [0, 1, 2]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "기타 설정",
									exportOptions: {
										columns: [0, 1, 2]
									}
								}
							]
						}]
					});
			}
	
			function btnStatusChk(nameup, displayName, value, valueStr, description) {
	
				$("#changeOther").modal("show");
	
				$("#settingNameup").val(displayName);
				$("#descriptionup").val(description);
	
				var name = "\'" + nameup + "\'";
	
				var header = '';
				var footer = '';
	
				header += '<h5 class="modal-title mb-0">설정값 변경</h5>';
				header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	
				if (nameup == 'userVMCtrl' || nameup == 'useOTP' || nameup == 'agentOnOff') {
					$("#serverOnOffDivup").show();
					$("#settingValueDivup").hide();
	
					if (value == 0) {
						$("input:radio[name='other_onoffup'][value='0']").prop("checked", true);
					} else if (value == 1) {
						$("input:radio[name='other_onoffup'][value='1']").prop("checked", true);
					}
				} else if (nameup == 'userAccessNetwork') {
					$("#settingValueup").attr("type", "text");
	
					$("#settingValueDivup").show();
					$("#serverOnOffDivup").hide();
	
					$("#settingValueup").val(valueStr);
	
				} else {
					$("#settingValueup").attr("type", "number");
	
					$("#settingValueDivup").show();
					$("#serverOnOffDivup").hide();
	
					$("#settingValueup").val(value);
				}
	
				footer += '<button type="button" class="btn bg-prom rounded-round" onclick="otherConfigUpdate(' + name + ')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
	
				$("#modal-header").empty();
				$("#modal-header").append(header);
	
				$("#modal-footer").empty();
				$("#modal-footer").append(footer);
	
				$("#required-inputup").addClass("show");
				$("#select-inputup").addClass("show");
			}
	
			function otherConfigUpdate(name) {
				var data = 0;
				var target = null;
				var dataStr = null;
	
				if (name == "reflashInterval") {
					data = $("#settingValueup").val();
	
					if (data > 300) {
						alert("새로 고침 주기를 300초를 초과하여 설정할 수 없습니다.");
						$("#settingValueup").focus();
						return false;
					}
	
					target = 'reflashInterval';
	
				} else if (name == "pwExpiration") {
					data = $("#settingValueup").val();
	
					if (data < 7 || data > 60) {
						alert("비밀번호 만료 주기는 최소 7일, 최대 60 일 까지 설정 가능합니다.");
						$("#settingValueup").focus();
						return false;
					}
	
					target = 'pwExpiration';
	
				} else if (name == 'userAccessNetwork') {
					dataStr = $("#settingValueup").val();
					target = 'userAccessNetwork';
	
				} else if (name == 'autoScaleInterval') {
					data = $("#settingValueup").val();
					target = 'autoScaleInterval';
	
				} else if (name == 'useOTP') {
					data = $("input[name='other_onoffup']:checked").val();
					target = 'useOTP';
	
				} else if (name == "agentOnOff") {
					data = $("input[name='other_onoffup']:checked").val();
					target = 'agentOnOff';
	
				} else if (name == 'userVMCtrl') {
					data = $("input[name='other_onoffup']:checked").val();
					target = 'userVMCtrl';
				}
	
				$.ajax({
					type: "POST",
					url: "/config/updateBasic.do",
					data: {
						name: target,
						value: data,
						valueStr: dataStr
					},
					success: function(update) {
						if (update == 1) {
							if (name == "agentOnOff" && data == 1) {
								alert("Agent 성능 데이터 사용이 ON 됐습니다.\n통계 리포트->성능 통계->가상머신 에이전트 통계에서 볼 수 있습니다.");
							} else {
								alert("설정값 변경이 완료되었습니다.");
							}
							location.reload();
						} else {
							alert("설정값 변경에 실패하였습니다.");
						}
					}
				})
			}
		</script>
	</head>
	<body>
		<div id="changeOther" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom" id="modal-header"></div>
					<div class="modal-body bg-light modal-type-4">
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
												<label>설정명:</label>
												<input type="text" class="form-control form-control-modal" id="settingNameup" disabled>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>설명:</label>
												<input type="text" class="form-control form-control-modal" id="descriptionup" disabled>
											</div>
										</div>
									</div>
									<div class="row" id="settingValueDivup">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>설정값:</label>
												<input type="text" class="form-control form-control-modal" placeholder="setting value" autocomplete="off" id="settingValueup">
											</div>
										</div>
									</div>
									<div class="row mt-1" id="serverOnOffDivup">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group form-check-inline">
												<div class="custom-control custom-radio mr-2-5">
													<input type="radio" class="custom-control-input" name="other_onoffup" id="other_onup" value="1">
													<label class="custom-control-label" for="other_onup">사용</label>
												</div>
												<div class="custom-control custom-radio">
													<input type="radio" class="custom-control-input" name="other_onoffup" id="other_offup" value="0">
													<label class="custom-control-label" for="other_offup">미사용</label>
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
		
		<div class="card bg-dark mb-0 table-type-5-6">
			<table id="otherTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>설정명</th>
						<th>설정값</th>
						<th>설명</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>