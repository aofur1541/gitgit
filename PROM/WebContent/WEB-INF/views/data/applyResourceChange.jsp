<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/commonApply.js"></script>
		<script src="${path}/resources/PROM_JS/commonVMResourceChange.js"></script>
		<script type="text/javascript">
		var category = "변경";
			$(document).ready(function() {
				if (sessionApproval == BanNumber) {
					ftnlimited(1);
				}
				if (sessionApproval == USER_NAPP) {
					getUserNotapplyVMList();
				} else if (sessionApproval >= USER_HEAD_NAPP) {
					getVMResourceChangeLsit();
				}
				
				modalOpen(2);
			});
	
			function getUserNotapplyVMList() {
				var applyLevel = 2;
				var vmChangeTable = $("#vmChangeTable")
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
							{"data": "vmCPU", // 기존 정보
								render: function(data, type, row) {
									
									if(row.crDisk > 0){
										data = "";
									} else if( row.crDisk == null && row.crTemplet == null && row.crCPU == null) {
										data = "";
									} else if( row.crTemplet != null ){
										data = "";
									} else {
										if(data == 0){
											data = 'vCPU: NA / Memory: NA GB';
										}else {
											data = 'vCPU: ' + data + ' / Memory: ' + row.vmMemory + ' GB';
										}
									}
									
										return data;
								}
							},
							{"data": "crCPU", // 변경 정보
								render: function(data, type, row) {
									if(row.crDisk > 0){
										data = 'Disk 추가 '+row.crDisk+"GB";
									} else if( row.crDisk == null && row.crTemplet == null && data == null ) {
										data = 'vNic 추가 ';
									} else if( row.crTemplet != null ){
										data = 'CD-ROM 연결';
									} else {
										if(data == 0){
											data = 'vCPU: NA / Memory: NA GB';
										}else {
											data = 'vCPU: ' + data + ' / Memory: ' + row.crMemory + ' GB';
										}
									}
									return data;
								}
							},
							{"data": "crDatetime"},
							{"data": "crApproval",
								render: function(data, type, row) {
									if(type == 'display'){
										
										if(data == 10){
											data = '신청 취소';				
										}else if (data == 1) {
											data = '신청';
										}else if (data == 2) {
											data = '결재 완료';
										}else if (data == 3) {
											data = '검토 완료';
										}else if (data == 4) {
											data = '승인 완료';
										}else if(data == 5){
											data = '작업 완료';	
										}else if (data == 6) {
											data = '보류';
										}else if (data == 7) {
											data = '반려';
										}else if(data == 8){
											data = '완료';
										}
										
										}else {
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
	
									if(row.crUserID == sessionUserID && (row.crApproval != 5 && row.crApproval != 7 && row.crApproval != 8 && row.crApproval != 10)){
									html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
									html += '<i class="icon-menu9"></i>';
									html += '</a>';
									html += '<div class="dropdown-menu">';
									html += '<a href="#" class="dropdown-item" onclick="userApplyCancel(' + data + ')"><i class="icon-reply-all"></i>신청 취소</a>';
									html += '</div>';
									}else {
									html += '<i class="icon-lock2"></i>';
									}
									return html;
								}
							}
						],
						order : [ [ 8,'asc' ],[ 7,'asc' ]],
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
									title: "가상머신 자원 변경 신청",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7, 8]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "가상머신 자원 변경 신청",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7, 8]
									}
								}
							]
						}]
					});
				$('#vmChangeTable tbody').on('click', 'tr', function() {
					var data = vmChangeTable.row(this).data();
					if (data != undefined) {
						$(this).addClass("selectedTr");
						$("#vmChangeTable tr").not(this).removeClass("selectedTr");
						
						getApprovalProgress(data);
					}
				});
			}
	
			// 관리자 테이블
			function getVMResourceChangeLsit() {
				
				var applyLevel = 2;
			
				
				
				var vmChangeTable = $("#vmChangeTable")
					.addClass("nowrap")
					.DataTable({
						ajax: {
							"url": "/approval/selectApplyVMList.do",
							"dataSrc": "",
							"data": {
								applyLevel: applyLevel
							}
						},
						columns: [
							{"data": "crUserID"},
							{"data": "userName"},
							{"data": "tenantName"},
							{"data": "serviceName"},
							{"data": "crVMName"},
							{"data": "vmCPU", // 기존 정보
								render: function(data, type, row) {
									
									if(row.crDisk > 0){
										data =  "";
									} else if( row.crDisk == null && row.crTemplet == null && row.crCPU == null) {
										data =  "";
									} else if( row.crTemplet != null ){
										data =  "";
									} else {
										if(data == 0){
											data = 'vCPU: NA / Memory: NA GB';
										}else {
											data = 'vCPU: ' + data + ' / Memory: ' + row.vmMemory + ' GB';
										}
									}
									return data;
								}
							},
							{"data": "crCPU", // 변경 정보
								render: function(data, type, row) {
									
									if(row.crDisk > 0){
										data = 'Disk 추가 '+row.crDisk+"GB";
									} else if( row.crDisk == null && row.crTemplet == null && data == null ) {
										data = 'vNic 추가 ';
									} else if( row.crTemplet != null ){
										data = 'CD-ROM 연결';
									} else {
										if(data == 0){
											data = 'vCPU: NA / Memory: NA GB';
										}else {
											data = 'vCPU: ' + data + ' / Memory: ' + row.crMemory + ' GB';
										}
									}
									return data;
								}
							},
							{"data": "crDatetime"},
							{"data": "crApproval",
								render: function(data, type, row) {
									if(type == 'display'){
										
										if(data == 10){
											data = '신청 취소';				
										}else if (data == 1) {
											data = '신청';
										}else if (data == 2) {
											data = '결재 완료';
										}else if (data == 3) {
											data = '검토 완료';
										}else if (data == 4) {
											data = '승인 완료';
										}else if(data == 5){
											data = '작업 완료';	
										}else if (data == 6) {
											data = '보류';
										}else if (data == 7) {
											data = '반려';
										}else if(data == 8){
											data = '완료';
										}
										
										}else {
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
									var originallyHost = "\'" + row.vmHost + "\'";
									var vmIdToString = "\'" + row.vmID + "\'";
									var templateToString = "\'" + row.crTemplet + "\'";
									var category = 'empty';
									if(row.crDisk > 0){
										category = "\'"+'addDisk'+"\'";
									} else if( row.crDisk == null && row.crTemplet == null && row.crCPU == null) {
										category = "\'"+'addvNic'+"\'";
									} else if( row.crCPU == null && row.crTemplet != null ){
										category = "\'"+'addCDROM'+"\'";
									} else {
										category = 'empty';
									}
									
									if ((getStage(sessionApproval) == row.crApproval || ((row.crApproval == 7) || row.crApproval == 8)) || getStage(sessionApproval) < row.stage || row.crApproval == 0 ) {
										html += '<i class="icon-lock2"></i>';
									}else {
										
										html += '<a href="#" class="list-icons-item" data-toggle="dropdown">';
										html += '<i class="icon-menu9"></i>';
										html += '</a>';
										html += '<div class="dropdown-menu">';

										if (sessionApproval != BanNumber && sessionApproval > CONTROLCHECK) {
											if(category == 'empty'){
											html += '<a href="#" class="dropdown-item" onclick="modalControllApprovalAdmin(' + data + ', ' + name + ', ' + userId + ',' + row.crSorting +')"><i class="icon-googleplus5"></i>작업자 승인</a>';
											} else if(category != 'empty'){
											html += '<a href="#" class="dropdown-item" onclick="modalControlladdApprovalAdmin(' + data + ', ' + name +','+category+','+originallyHost+','+vmIdToString+','+row.crDisk+','+templateToString+')"><i class="icon-googleplus5"></i>작업자 승인</a>';
											}
											
											html += '<a href="#" class="dropdown-item" onclick="modalControllDelete(' + data + ', ' + name +')"><i class="icon-undo2"></i>반려</a>';
											if( row.crApproval != 6 ){
											html += '<a href="#" class="dropdown-item" onclick="modalControllHold(' + data + ', ' + name +  ')"><i class="icon-comments"></i>보류</a>';
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
						order : [ [ 8,'asc' ],[ 7,'asc' ]],
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
									title: "가상머신 자원 변경 신청",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7, 8]
									}
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "가상머신 자원 변경 신청",
									exportOptions: {
										columns: [0, 1, 2, 3, 4, 5, 6, 7, 8]
									}
								}
							]
						}]
					});
				$('#vmChangeTable tbody').on('click', 'tr', function() {
					var data = vmChangeTable.row(this).data();
					if (data != undefined) {
						$(this).addClass("selectedTr");
						$("#vmChangeTable tr").not(this).removeClass("selectedTr");
						
						getApprovalProgress(data);
					}
				});
			}
			
			function applyVMDetail(cr_num, cr_sorting,cpuHot,memoryHot) {
				var description = $("#approvalVMReasonAdmin").val();
				
				if (cpuHot == true && memoryHot == true) {
					alert("vCPU / Memory 핫 플러그 기능이 켜져있기 때문에\n해당 가상머신은 재부팅 없이 자원이 변경됩니다." );
				} else {
					if (confirm("해당 가상머신의 핫 플러그 기능이 꺼져있기 때문에\n해당 가상머신이 재부팅 됩니다 그대로 진행하시겠습니까?") == true) {
					} else {
						return false;
					}
				}
				
				$.ajax({
					url: "/approval/approvalVMCreate.do",
					data: {
						crNum: cr_num,
						crSorting : cr_sorting,
						description : description
					},
					beforeSend: function() {
						var footer = '';
	
						footer += '<button type="button" class="btn bg-prom rounded-round" >가상머신 자원 변경중...<i class="icon-spinner2 spinner ml-2"></i></button>';
						$("#vmApproveAdminl-modal-footer").empty();
						$("#vmApproveAdminl-modal-footer").append(footer);
					},
					success: function(data) {
						if(data == 2){
							alert("변경하려는 가상머신이 존재하지 않으므로\n작업 승인이 불가합니다.");
						}
						window.parent.location.reload();
					},
					error : function() {
						alert("가상머신 변경 도중 예기치 않은 예외 발생");
					}
				})
			}
			
		</script>
	</head>
	<body>
		<div id="addVMInfo" class="modal fade">
		<div class="modal-dialog modal-sm">
			<div class="modal-content" style="margin-top: 100px;">
				<div class="modal-header bg-prom" id="modal-header"></div>
				<div class="modal-body modal-type-5">
					
					<!-- Disk -->
					<div>
						<!-- <div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label id="changeTitle"></label>
									<input type="text" class="form-control form-control-modal" id="commonNum" disabled>
								</div>
							</div>
						</div> -->
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label id="changeSub"></label>
									<select class="form-control select-search" id="commonSB" data-fouc></select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer bg-white" id="modal-footer"></div>
			</div>
		</div>
	</div>
	
		<!-- 작업자 승인 -->
		<div id="vmApproveAdmin" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-prom" id="vmApproveAdmin-modal-header"></div>
					<div class="modal-body bg-light modal-type-1 modal-type-1-2">
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
												<label>가상머신명:</label>
												<input type="text" class="form-control form-control-modal" id="subjectVMname" disabled>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>변경 전 vCPU:</label>
												<input type="text" class="form-control form-control-modal" placeholder="vCPU" min="1" max="32" id="beforevCPU" disabled>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>변경 전 Memory:</label>
												<input type="text" class="form-control form-control-modal" placeholder="memory" min="1" max="32" id="beforeMemory" disabled>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>변경 후 vCPU:</label>
												<input type="text" class="form-control form-control-modal" placeholder="vCPU" min="1" max="32" id="aftervCPU" disabled>
											</div>
										</div>
										<div class="col-sm-6 col-xl-6">
											<div class="form-group">
												<label>변경 후 Memory:</label>
												<input type="text" class="form-control form-control-modal" placeholder="memory" min="1" max="32" id="afterMemory" disabled>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12 col-xl-12">
											<div class="form-group">
												<label>의견:</label>
												<textarea class="form-control form-control-modal" placeholder="comment for approval VM " autocomplete="off" maxlength="80" id="approvalVMReasonAdmin"></textarea>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="card mb-0">
							<div class="card-header bg-white">
								<a href="#warning-info" data-toggle="collapse">
									<span class="h6 card-title"><i class="icon-warning22 text-prom mr-2"></i>주의 사항</span>
									<i class="icon-arrow-down12 text-prom"></i>
								</a>
							</div>
							<div id="warning-info" class="collapse show">
								<div class="card-body bg-light">
									<p>
										1. 핫플러그가 OFF인 경우, 가상머신이 재시작 됩니다.<br>
										<span class="text-prom ml-2">* </span>현재 CPU 핫플러그: <span class="text-prom" id="vCPUhotAddState"></span>, Memory 핫플러그: <span class="text-prom" id="memoryhotAddState"></span>
									</p>
									<p>
										2. 활성 메모리 크기보다 작게 축소할 수 없습니다.
									</p>
									<p>
										3. 핫 플러그 활성화 가상머신의 메모리가 3 GB 이하일 경우 자원 변경 기능이 작동하지 않습니다.
									</p>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white" id="vmApproveAdminl-modal-footer"></div>
				</div>
			</div>
		</div>
		
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
		
		<!-- 보류  -->
		<div id="vmHold" class="modal fade" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content" style="margin-top: 100px;">
					<div class="modal-header bg-prom" id="vmHold-modal-header"></div>
					<div class="modal-body modal-type-5">
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>가상머신명:</label>
									<input type="text" class="form-control form-control-modal" id="holdVMName" disabled>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-xl-12">
								<div class="form-group">
									<label>사유:</label>
									<textarea class="form-control form-control-modal" placeholder="reason for hold VM" autocomplete="off" maxlength="80" id="holdVMReason"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer bg-white" id="vmHold-modal-footer"></div>
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
			<table id="vmChangeTable" class="promTable hover cpointer" style="width:100%;">
				<thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>테넌트명</th>
						<th>서비스명</th>
						<th>가상머신명</th>
						<th>기존 정보</th>
						<th>변경 정보</th>
						<th>요청 일시</th>
						<th>상태</th>
						<th>관리</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
</html>