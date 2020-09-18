<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			$(document).ready(function() {
				if (sessionApproval == BanNumber) {
					ftnlimited(1);
				}
				notApplyUserPWreset();
			});
	
			function notApplyUserPWreset() {
				var passwordResetTable = $("#passwordResetTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/approval/selectUserPWResetList.do",
							"dataSrc": "",
						},
						columns: [
							{"data": "sUserID"},
							{"data": "sName"},
							{"data": "dRdatetime"},
							{"data": "sUserID",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
									var sID = "\'" + data + "\'";
	
									if (sessionApproval != BanNumber && (sessionApproval > ADMINCHECK && sessionApproval != BanNumber2)) {
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
										html += '<a href="#" class="dropdown-item" onclick="modalControllApprove(' + sID + ', ' + row.resetNum + ', ' + row.id + ')"><i class="icon-googleplus5"></i>승인</a>';
										html += '<a href="#" class="dropdown-item" onclick="modalControllDelete(' + sID + ', ' + row.resetNum + ', ' + row.id + ')"><i class="icon-undo2"></i>반려</a>';
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
									title: "비밀번호 초기화",
									exportOptions: {
										columns: [0, 1, 2]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "비밀번호 초기화",
									exportOptions: {
										columns: [0, 1, 2]
									}
								}
							]
						}]
					});
			}
	
			function modalControllApprove(sID, resetNum, userPK) {
				var header = '';
				var footer = '';
				var sIDreplace = "\'" + sID + "\'";
	
				$("#PWApprove").modal("show");
				$("#approvePWreset").html(sID + '의 비밀번호 초기화를 승인하시겠습니까?');
	
				header += '<h5 class="modal-title mb-0">' + sID + ' 비밀번호 초기화 승인</h5>';
				header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	
				$("#approve-modal-header").empty();
				$("#approve-modal-header").append(header);
	
				footer += '<button type="button" class="btn bg-prom rounded-round" onclick="applyserviceDetail(' + resetNum + "," + sIDreplace + "," + userPK + ')">승인<i class="icon-checkmark2 ml-2"></i></button>';
	
				$("#approve-modal-footer").empty();
				$("#approve-modal-footer").append(footer);
			}
	
			function applyserviceDetail(resetNum, sID, userPK) {
				$.ajax({
					url: "/approval/approveUserPWReset.do",
					data: {
						resetNum: resetNum,
						id: userPK,
						sUserID: sID
					},
	
					success: function(data) {
						if (data == 1) {
							alert("비밀번호 초기화가 완료되었습니다.");
							window.parent.location.reload();
						} else {
							alert("비밀번호 초기화에 실패하였습니다.");
						}
					}
				})
			}
	
			function modalControllDelete(sID, resetNum, userPK) {
				var header = '';
				var footer = '';
				var sIDreplace = "\'" + sID + "\'";
	
				$("#PWDelete").modal("show");
				$("#approvePWreset").html(sID + '의 비밀번호 초기화를 반려하시겠습니까?');
	
				header += '<h5 class="modal-title mb-0">' + sID + ' 비밀번호 초기화 반려</h5>';
				header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
	
				$("#delete-modal-header").empty();
				$("#delete-modal-header").append(header);
	
				footer += '<button type="button" class="btn bg-prom rounded-round" onclick="deleteserviceDetail(' + resetNum + "," + sIDreplace + ')">반려<i class="icon-checkmark2 ml-2"></i></button>';
	
				$("#delete-modal-footer").empty();
				$("#delete-modal-footer").append(footer);
			}
			
			function deleteserviceDetail(resetNum, sID) {
				var pwReset = $("#pwResetComment").val();
				$.ajax({
					url: "/approval/rejectUserPWReset.do",
					data: {
						resetNum: resetNum,
						sUserID: sID,
						pwResetComment: pwReset
					},
					success: function(data) {
						if (data == 1) {
							alert("비밀번호 초기화 반려가 완료되었습니다.");
							window.parent.location.reload();
						} else {
							alert("비밀번호 초기화 반려가 실패하였습니다.");
						}
					}
				})
			}
		</script>
	</head>
	<body>
		<div id="PWApprove" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content" style="margin-top: 100px;">
					<div class="modal-header bg-prom" id="approve-modal-header"></div>
					<div class="modal-body modal-type-5 text-center">
						<div class="mb-2-5"><i class="icon-unlocked"></i></div>
						<div class="mb-2-5" id="approvePWreset"></div>
					</div>
					<div class="modal-footer bg-white" id="approve-modal-footer"></div>
				</div>
			</div>
		</div>
	
		<div id="PWDelete" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content" style="margin-top: 100px;">
					<div class="modal-header bg-prom" id="delete-modal-header"></div>
					<div class="modal-body modal-type-5">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>사유:</label>
									<textarea class="form-control form-control-modal" placeholder="reason for return password reset" autocomplete="off" maxlength="80" id="pwResetComment"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white" id="delete-modal-footer"></div>
				</div>
			</div>
		</div>
		<div class="card bg-dark mb-0 table-type-5-6">
			<table id="passwordResetTable" class="promTable hover" style="width:100%;">
				<thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>요청 일시</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>