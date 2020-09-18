<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/commonApply.js"></script>
		<script type="text/javascript">
			var category = "반환";
			$(document).ready(function() {
				if (sessionApproval == BanNumber) {
					ftnlimited(1);
				}
	
				if (sessionApproval == USER_NAPP) {
					getUserNotapplyVMList();
				} else if (sessionApproval >= USER_HEAD_NAPP) {
					getUserUnApplyList();
				}
	
				modalOpen(3);
	
			});
	
			function getUserNotapplyVMList() {
				var applyLevel = 3;
				var vmReturnTable = $("#vmReturnTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/approval/selectApplyVMListByUserMapping.do",
							"dataSrc": "",
							data: {
								applyLevel: applyLevel
							}
						},
						columns: [
							{"data": "crUserID"},
							{"data": "userName"},
							{"data": "tenantName"},
							{"data": "serviceName"},
							{"data": "crVMName"},
							{"data": "crDatetime"},
							{"data": "crApproval",
								render: function(data, type, row) {
									if (type == 'display') {
	
										if (data == 10) {
											data = '신청 취소';
										} else if (data == 1) {
											data = '신청';
										} else if (data == 2) {
											data = '결재 완료';
										} else if (data == 3) {
											data = '검토 완료';
										} else if (data == 4) {
											data = '승인 완료';
										} else if (data == 5) {
											data = '작업 완료';
										} else if (data == 6) {
											data = '보류';
										} else if (data == 7) {
											data = '반려';
										} else if (data == 8) {
											data = '완료';
										}
	
									} else {
										return data;
									}
	
									return data;
								}
							},
							{"data": "crNum",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
									var name = "\'" + row.crVMName + "\'";
	
									if (row.crUserID == sessionUserID && (row.crApproval != 5 && row.crApproval != 7 && row.crApproval != 8 && row.crApproval != 10)) {
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
										html += '<a href="#" class="dropdown-item" onclick="userApplyCancel(' + data + ')"><i class="icon-reply-all"></i>신청 취소</a>';
										html += '</div>';
									} else {
										html += '<i class="icon-lock2"></i>';
									}
									return html;
								}
							}
						],
						order: [
							[6, 'asc'],
							[5, 'asc']
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
						}, {
							responsivePriority: 3,
							targets: -2
						}, {
							responsivePriority: 4,
							targets: -3
						}, {
							responsivePriority: 5,
							targets: -4
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
								title: "가상머신 반환 신청",
								exportOptions: {
									columns: [0, 1, 2, 3, 4, 5, 6]
								}
							}, {
								extend: "excelHtml5",
								text: "Excel",
								title: "가상머신 반환 신청",
								exportOptions: {
									columns: [0, 1, 2, 3, 4, 5, 6]
								}
							}]
						}]
					});
				$('#vmReturnTable tbody').on('click', 'tr', function() {
					var data = vmReturnTable.row(this).data();
					if (data != undefined) {
						$(this).addClass("selectedTr");
						$("#vmReturnTable tr").not(this).removeClass("selectedTr");
						
						getApprovalProgress(data);
					}
				});
			}
	
	
			// 관리자 테이블
			function getUserUnApplyList() {
	
				var applyLevel = 3;
	
				var vmReturnTable = $("#vmReturnTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/approval/selectApplyVMList.do",
							"dataSrc": "",
							data: {
								applyLevel: applyLevel,
							}
						},
						columns: [
							{"data": "crUserID"},
							{"data": "userName"},
							{"data": "tenantName"},
							{"data": "serviceName"},
							{"data": "crVMName"},
							{"data": "crDatetime"},
							{"data": "crApproval",
								render: function(data, type, row) {
									if (type == 'display') {
	
										if (data == 10) {
											data = '신청 취소';
										} else if (data == 1) {
											data = '신청';
										} else if (data == 2) {
											data = '결재 완료';
										} else if (data == 3) {
											data = '검토 완료';
										} else if (data == 4) {
											data = '승인 완료';
										} else if (data == 5) {
											data = '작업 완료';
										} else if (data == 6) {
											data = '보류';
										} else if (data == 7) {
											data = '반려';
										} else if (data == 8) {
											data = '완료';
										}
	
									} else {
										return data;
									}
	
									return data;
								}
							},
							{"data": "crNum",
								"orderable": false,
								render: function(data, type, row) {
									var html = '';
									var name = "\'" + row.crVMName + "\'";
									var userId = "\'" + row.crUserID + "\'";
	
									if ((getStage(sessionApproval) == row.crApproval || ((row.crApproval == 7) || row.crApproval == 8)) || getStage(sessionApproval) < row.stage || row.crApproval == 0) {
										html += '<i class="icon-lock2"></i>';
									} else {
	
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';
	
										if (sessionApproval != BanNumber && sessionApproval > CONTROLCHECK) {
	
											html += '<a href="#" class="dropdown-item" onclick="applyVMDetail(' + data + ', ' + name + ', ' + row.crSorting + ')"><i class="icon-googleplus5"></i>작업자 승인</a>';
											html += '<a href="#" class="dropdown-item" onclick="modalControllDelete(' + data + ', ' + name + ')"><i class="icon-undo2"></i>반려</a>';
											if (row.crApproval != 6) {
												html += '<a href="#" class="dropdown-item" onclick="modalControllHold(' + data + ', ' + name + ')"><i class="icon-comments"></i>보류</a>';
											}
	
										} else if (sessionApproval != BanNumber && sessionApproval < CONTROLCHECK) {
	
											if (row.crUserID == sessionUserID) {
												html += '<a href="#" class="dropdown-item" onclick="userApplyCancel(' + data + ')"><i class="icon-reply-all"></i>신청 취소</a>';
											} else {
												html += '<a href="#" class="dropdown-item" onclick="modalControllApprove(' + data + ', ' + name + ', ' + userId + ')"><i class="icon-googleplus5"></i>승인</a>';
												html += '<a href="#" class="dropdown-item" onclick="modalControllDelete(' + data + ', ' + name + ')"><i class="icon-undo2"></i>반려</a>';
											}
										}
	
										html += '</div>';
	
									}
	
									return html;
								}
							}
						],
						order: [
							[6, 'asc'],
							[5, 'asc']
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
						}, {
							responsivePriority: 3,
							targets: -2
						}, {
							responsivePriority: 4,
							targets: -3
						}, {
							responsivePriority: 5,
							targets: -4
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
								title: "가상머신 반환 신청",
								exportOptions: {
									columns: [0, 1, 2, 3, 4, 5, 6]
								}
							}, {
								extend: "excelHtml5",
								text: "Excel",
								title: "가상머신 반환 신청",
								exportOptions: {
									columns: [0, 1, 2, 3, 4, 5, 6]
								}
							}]
						}]
					});
				$('#vmReturnTable tbody').on('click', 'tr', function() {
					var data = vmReturnTable.row(this).data();
					if (data != undefined) {
						$(this).addClass("selectedTr");
						$("#vmReturnTable tr").not(this).removeClass("selectedTr");
		
						getApprovalProgress(data);
					}
				});
			}
	
			function applyVMDetail(cr_num, cr_vmName, cr_sorting) {
	
				if (confirm("가상머신 반환을 승인 하시겠습니까?") == true) {
	
					$.ajax({
						url: "/approval/approvalVMCreate.do",
						data: {
							crNum: cr_num,
							crVMName: cr_vmName,
							crSorting: cr_sorting
						},
						success: function(data) {
							alert("가상머신 반환 신청 승인이 완료되었습니다.");
							window.parent.location.reload();
						}
					})
	
				} else {
					return false;
				}
	
			}
		</script>
	</head>
	<body>
		<!-- 사유  -->
		<div id="vmReason" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content" style="margin-top: 100px;">
					<div class="modal-header bg-prom" id="vmReason-modal-header"></div>
					<div class="modal-body modal-type-5">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>가상머신명:</label>
									<input type="text" class="form-control form-control-modal" id="reasonVMName" disabled>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>사유:</label>
									<textarea class="form-control form-control-modal" id="commentVMReason" disabled></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 승인  -->
		<div id="vmApprove" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content" style="margin-top: 100px;">
					<div class="modal-header bg-prom" id="vmApprove-modal-header"></div>
					<div class="modal-body modal-type-5">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>가상머신명:</label>
									<input type="text" class="form-control form-control-modal" id="approveVMName" disabled>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>사유:</label>
									<textarea class="form-control form-control-modal" placeholder="reason for return VM" autocomplete="off" maxlength="80" id="aproveVMReason"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white" id="vmApprove-modal-footer"></div>
				</div>
			</div>
		</div>
		
		<!-- 반려  -->
		<div id="vmDelete" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content" style="margin-top: 100px;">
					<div class="modal-header bg-prom" id="vmDelete-modal-header"></div>
					<div class="modal-body modal-type-5">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>가상머신명:</label>
									<input type="text" class="form-control form-control-modal" id="deleteVMName" disabled>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>사유:</label>
									<textarea class="form-control form-control-modal" placeholder="reason for return VM" autocomplete="off" maxlength="80" id="deleteVMReason"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white" id="vmDelete-modal-footer"></div>
				</div>
			</div>
		</div>
		
		<div class="card bg-dark mb-0 table-type-2 table-type-7">
			<div><h6 class="card-title mb-0">결재 진행 상태</h6></div>
			<div class="datatables-body">
				<table class="promTable text-center" style="width:100%;">
					<thead>
						<tr>
							<th width="9%">-</th>
							<th width="15%">신청</th>
							<th width="4%"></th>
							<th width="15%">결재</th>
							<th width="4%"></th>
							<th width="15%">검토</th>
							<th width="4%"></th>
							<th width="15%">검토 승인</th>
							<th width="4%"></th>
							<th width="15%">작업</th>
						</tr>
					</thead>
					<tbody id="approvalProcessList">
						<tr>
							<th>상태</th>
							<td></td>
							<td class="bg-process" rowspan="4"><i class="icon-arrow-right16 icon-2x text-muted mb-3"></i></td>
							<td></td>
							<td class="bg-process" rowspan="4"><i class="icon-arrow-right16 icon-2x text-muted mb-3"></i></td>
							<td></td>
							<td class="bg-process" rowspan="4"><i class="icon-arrow-right16 icon-2x text-muted mb-3"></i></td>
							<td></td>
							<td class="bg-process" rowspan="4"><i class="icon-arrow-right16 icon-2x text-muted mb-3"></i></td>
							<td></td>
						</tr>
						<tr>
							<th>이름</th>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>일시</th>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>사유</th>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="card bg-dark mb-0 table-type-5-8">
			<table id="vmReturnTable" class="promTable hover cpointer" style="width:100%;">
				<thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>테넌트명</th>
						<th>서비스명</th>
						<th>가상머신명</th>
						<th>요청 일시</th>
						<th>상태</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>