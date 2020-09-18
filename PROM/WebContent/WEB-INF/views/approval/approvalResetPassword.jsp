<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
</head>

<body>
	<!--  <%@ include file="/WEB-INF/views/include/loading.jsp"%> -->
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>
		
		<!-- 본문 시작 -->
		<div class="content">
			<div class="row">
				<div class="col-4">
					<div class="card card-body" style="width:100%">
						
						<div class="shoulderwrapper" style="margin:-15px; border:1px solid lightgrey">
							
							<div class="left-shoulder" style="width:40%; float:left; height:220px;  background-color:#6799FF; color:white;">
								<h6> DEV-ID</h6>
								<h6> DEV-TEST01</h6>
							</div>
							
							<div class="right-shoulder" style="width:60%; float:left; height:220px;">
								<table>
							      <thead>
							        <tr>
							          <th>상태</th><th>일시</th><th>담당자</th>
							        </tr>
							      </thead>
							      
							      <tbody>
							        <tr>
							          <td>초기화 완료</td><td>7월 21일</td><td>administrator</td>
							        </tr>
							     
							      
							      </tbody>
							    </table>
							    
							    
							    <table>
							      <thead>
							        <tr>
							          <th>내용</th>
							        </tr>
							      </thead>
							      
							      <tbody>
							        <tr>
							          <td>현재 초기화 완료된 가상머신 신청입니다.</td>
							        </tr>
							    
							      </tbody>
							    </table>
							    
							    
							    
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-8">
					<div class="card card-body">
						<div>
							
							<div class="w3-light-grey">
							
									<div class="w3-green " style="height:30px; width:50%">
									<!-- <div style="position:relative; bottom:7px; right:10px; width:20px; height:20px; border-radius:30px; background-color:lightblue"></div>
									<div style="position:relative;  bottom:27px; left:179px; width:20px; height:20px; border-radius:30px; background-color:lightblue"></div>
									<div style="position:relative;  bottom:48px; left:368px; width:20px; height:20px; border-radius:30px; background-color:lightblue"></div>
									<div style="position:relative; bottom:69px; left:557px; width:20px; height:20px; border-radius:30px; background-color:lightblue"></div>
									<div style="position:relative; bottom:85px; left:760px; width:20px; height:20px; border-radius:30px; background-color:lightblue"></div> -->
							</div>
						</div>
					
						<table class="djfudns">
							<tbody>
								<tr>
									<th>신청</th>
									
									
									<th>승인</th>
									
								</tr>
								<tr>
									<td>신청 완료</td>
									<td>승인 완료</td>
									
								</tr>
								<tr>
									<td>날짜 부분</td>
									<td>날짜 부분</td>
									
								</tr>
								<tr>
									<td>사람 부분</td>
									<td>사람 부분</td>
									
								</tr>
								<tr>
									<td>내용 보기</td>
									<td>내용 보기</td>
								
								</tr>
							</tbody>
						</table>
						
						
						
					</div>
				</div>
			</div>	
		</div>
		
		<!-- 데이타 테이블 -->	
		<table id="passwordResetTable" class="cell-border hover" style="width: 100%">
				<thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>서비스 그룹</th>
						<th>서비스</th>
						<th>가상머신</th>
						<th>상세 내용</th>
						<th>사유</th>
						<th>요청 일시</th>
						<th>결과</th>
					</tr>
				</thead>
			</table>
			</div>
			
	
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
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
						dom: "<'datatables-header'B>" + "<'datatables-body'rt>" + "<'datatables-footer'ifp>",
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
						language: datatables_lang,
						colReorder: true,
						stateSave: true,
						lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
						buttons: [{
							extend: "collection",
							text: "<i class='fas fa-download'></i><span>내보내기</span>",
							className: "btn exportBtn",
							buttons: [{
									extend: "csvHtml5",
									charset: "UTF-8",
									bom: true,
									text: "CSV",
									title: "가상머신 생성 승인"
								},
								{
									extend: "excelHtml5",
									text: "Excel",
									title: "가상머신 설정 변경 승인"
								}
							]
						}, {
							extend: "pageLength",
							className: "btn pageLengthBtn",
						}, {
							extend: 'colvis',
							text: '테이블 편집',
							className: 'btn colvisBtn'
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
</body>

</html>