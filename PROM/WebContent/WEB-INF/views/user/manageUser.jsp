<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
	
	<style type="text/css">
		#arrangeModal .modal-body{
			min-height: 450px;
		}
		
		#tableServiceGroup_wrapper .datatables-body {
			margin-bottom: 0;
		}
	</style>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>

		<!-- 본문 시작 -->
		<div class="content">

			<!-- 사용자 변경 -->
			<%@ include file="/WEB-INF/views/include/updateUser.jsp"%>
			
			<!-- 서비스 그룹 배치 모달 -->
			<div class="modal fade" id="arrangeModal" tabindex="-1">
				<div class="modal-dialog modal-xl modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">서비스 그룹 배치</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="loading-background card-loading modal-loading"><div class="spinner-border" role="status"></div></div>
							<div class="modal-card modal-card-title">
								<b>사용자 배치</b><span class="text-disabled">해당 사용자를 배치할 서비스 그룹을 선택해 주세요.</span>
							</div>
							<div class="modal-card">
								
								<!-- 서비스 그룹 테이블 -->
								<table id="tableServiceGroup" class="cell-border hover arrange-table" style="width: 100%;">
									<thead>
										<tr>
											<th class="selecteAll"><span></span></th>
											<th>서비스 그룹</th>
											<th>관리자 여부</th>
											<th>서비스 관리자 여부</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<div><button type="button" class="btn" id="arrangeBtn">배치</button></div>
							<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 사용자 테이블 -->
			<table id="tableUser" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>회사</th>
						<th>부서</th>
						<th>아이디</th>
						<th>이름</th>
						<th>권한</th>
						<th>재직</th>
						<th>영문 이름</th>
						<th>직급</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>입사일</th>
						<th>사번</th>
						<th>IP 주소</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			if (sessionUserApproval > USER_CHECK) {
				getUserList();
				
				// 회사 셀렉트 박스 변경 시
				$('#userModal_company').change(function () {
					var companyId = $('#userModal_company option:selected').val();
					selectDepartmentList(companyId);
				});

			} else {
				getServiceGroupUserList();
			}
		});

		// 전체 사용자 테이블
		function getUserList() {
			var tableUser = $('#tableUser').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"createB"><"manageB"><"arrangeB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/user/selectUserList.do',
					type: 'POST',
					dataSrc: ''
				},
				columns: [
					{data: 'companyName'},
					{data: 'sDepartmentName'},
					{data: 'sUserID'},
					{data: 'sName'},
					{data: 'nApproval', render: function(data, type, row) {
						data = userAuthority(data);
						return data;
					}},
					{data: 'sTenureCode', render: function(data, type, row) {
						data = userEmployment(data);
						return data;
					}},
					{data: 'sNameEng'},
					{data: 'sJobCode'},
					{data: 'sEmailAddress'},
					{data: 'sPhoneNumber'},
					{data: 'dStartday'},
					{data: 'nNumber'},
					{data: 'sUserIP'},
					{data: 'id'}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				order: [[2, 'asc']],
				lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
				columnDefs: [{targets: 13, visible: false, searchable: false, className: 'noVis'}],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '사용자 정보',
						exportOptions: {
							columns: ':not(.noVis)'
						}
					},{
						extend: 'excelHtml5',
						text: 'Excel',
						title: '사용자 정보',
						exportOptions: {
							columns: ':not(.noVis)'
						}
					}]
				}, {
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}, {
					extend: 'colvis',
					text: '테이블 편집',
					className: 'btn colvisBtn',
					columns: ':not(.noVis)'
				}]
			});

			tableUserButton(tableUser);
		}

		// 서비스 그룹에 소속된 사용자 테이블
		function getServiceGroupUserList() {
			var tableUser = $('#tableUser').addClass('nowrap').DataTable({
				dom: '<"datatables-header"B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/user/selectUserTenantMembersList.do',
					type: 'POST',
					dataSrc: ''
				},
				columns: [
					{data: 'companyName'},
					{data: 'sDepartmentName'},
					{data: 'sUserID'},
					{data: 'sName'},
					{data: 'nApproval', render: function(data, type, row) {
						data = userAuthority(data);
						return data;
					}},
					{data: 'sTenureCode', render: function(data, type, row) {
						data = userEmployment(data);
						return data;
					}},
					{data: 'sNameEng'},
					{data: 'sJobCode'},
					{data: 'sEmailAddress'},
					{data: 'sPhoneNumber'},
					{data: 'dStartday'},
					{data: 'nNumber'},
					{data: 'sUserIP'}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				order: [[2, 'asc']],
				lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
				buttons: [{
					extend: 'collection',
					text: '내보내기',
					className: 'btn exportBtn',
					buttons: [{
						extend: 'csvHtml5',
						charset: 'UTF-8',
						bom: true,
						text: 'CSV',
						title: '사용자 정보'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '사용자 정보'
					}]
				}, {
					extend: 'pageLength',
					className: 'btn pageLengthBtn',
				}, {
					extend: 'colvis',
					text: '테이블 편집',
					className: 'btn colvisBtn'
				}]
			});
		}

		// 등록, 관리 버튼 설정
		function tableUserButton(tableUser) {
			$('.createB').html('<button type="button" class="btn createBtn" onclick="insertUser()">등록</button>');
			$('.manageB').html('<button type="button" class="btn manageBtn">관리</button>');
			$('.arrangeB').html('<button type="button" class="btn arrangeBtn">서비스 그룹 배치</button>');

			$('.manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});
			
			$('.arrangeBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});

			// 행 선택 시
			$('#tableUser tbody').on('click', 'tr', function() {
				var data = tableUser.row(this).data();

				if (data != undefined) {
					$(this).addClass('selected');
					$('#tableUser tr').not(this).removeClass('selected');

					// 관리 버튼 활성화
					var html = '';

					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown">관리</button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" id="updateUser">사용자 정보 변경</a>';
					
					// 관제 OP는 삭제할 수 없음
					if (data.nApproval != CONTROL_CHECK) {
						html += '<a href="#" class="dropdown-item" id="deleteUser">사용자 삭제</a>';
					}
					
					html += '<a href="#" class="dropdown-item" id="resetPassword">비밀번호 초기화</a>';
					html += '</div>';

					$('.manageB').empty().append(html);
					
					// 사용자만 서비스 그룹에 배치할 수 있음
					if (data.nApproval < USER_CHECK) {
						$('.arrangeB').html('<button type="button" class="btn arrangeBtn">서비스 그룹 배치</button>');
					
					} else {
						$('.arrangeB').html('');
					}
					
					// 서비스 그룹 배치 활성화
					$('.arrangeBtn').off('click').on('click', function() {
						arrangeUser(data);
					});
					
					$('#updateUser').off('click').on('click', function() {
						updateUser(data);
					});
					
					$('#deleteUser').off('click').on('click', function() {
						deleteUser(data);
					});
					
					$('#resetPassword').off('click').on('click', function() {
						resetPassword(data);
					});
				}
			});
		}
		
		// 서비스 그룹 배치
		function arrangeUser(data) {
			$('.card-loading').removeClass('d-none');
			$('.modal-title').html('\'' + data.sUserID + ' (' + data.sName + ')\' 사용자 서비스 그룹 배치');
			
			$('#arrangeModal').modal('show');
			$('#arrangeModal').off('shown.bs.modal').on('shown.bs.modal', function() {
				var tableServiceGroup = $('#tableServiceGroup').DataTable();
				tableServiceGroup.destroy();
				
				getServiceGroupList(data.id, data.sUserID);
			});
		}
		
		// 서비스 그룹 테이블
		function getServiceGroupList(id, sUserID) {
			var tableServiceGroup = $('#tableServiceGroup').addClass('nowrap').DataTable({
				dom: '<"datatables-body"rt>',
				ajax: {
					url: '/tenant/selectTenantArrangeList.do',
					type: 'POST',
					dataSrc: '',
					data: {
						userId: id
					},
				},
				columns: [
					{data: 'id', orderable: false, render: function(data, type, row) {
						data = '<div id=' + data + '></div>';
						return data;
					}, className: 'select-checkbox'},
					{data: 'name'},
					{data: 'isTenantAdmin', render: function(data, type, row) {
						data = data == null || data == '' || data == 'false' ? '<span class="text-disabled">관리자 아님</span>' : '관리자';
						
						return data;
					}},
					{data: 'isServiceAdmin', render: function(data, type, row) {
						data = data == null || data == '' || data == 'false' ? '<span class="text-disabled">관리자 아님</span>' : '관리자';
						
						return data;
					}}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[-1]],
		        select: {style: 'multi', selector: 'tr'},
		        order: [[1, 'ase']],
		        scrollY: '300px',
		        scrollX: true,
		        scrollCollapse: true,
				initComplete: function(settings, data) {
					for (key in data) {
						
						// 선택한 사용자가 서비스 그룹에 포함되어있으면 해당 서비스 그룹 선택
						if (data[key].isInclude == 'true') {
							$('#' + data[key].id).closest('tr').addClass('selected');
							tableServiceGroup.rows('.selected').select();
						}
						
						// 선택한 사용자가 서비스 그룹 관리자면 해당 서비스 그룹 선택 해제 불가
						data[key].isTenantAdmin == 'true' || data[key].isServiceAdmin == 'true' ? $('#' + data[key].id).closest('tr').addClass('isAdmin').css('pointer-events', 'none') : $('#' + data[key].id).closest('tr').addClass('noAdmin');
					}
					
					// 테이블 로딩 완료 시 모달 로딩 해제
					$('.card-loading').addClass('d-none');
					
					// 서비스 그룹에 배치 버튼 클릭 시
					$('#arrangeBtn').off('click').on('click', function() {
						
						// 선택된 서비스 그룹 id 출력
						var serviceGroupData = tableServiceGroup.rows('.selected').data();
						var serviceGroupId = new Array();
						var serviceGroupName = new Array();
						
						for (var i = 0; i < serviceGroupData.length; i ++) {
							serviceGroupId[i] = serviceGroupData[i].id;
							serviceGroupName[i] = serviceGroupData[i].name;
						}
						
						$.ajax({
							url: '/user/arrangeTenant.do',
							type: 'POST',
							traditional : true,
							data: {
								id: id,
								sUserID: sUserID,
								tenantIds: serviceGroupId,
								tenantNames: serviceGroupName
							},
							success: function(data) {
								
								// 배치 성공
								if (data == 1) {
									alert('사용자 그룹 배치가 완료되었습니다.');
									location.reload();

								// 배치 실패
								} else {
									alert('사용자 그룹 배치에 실패했습니다.');
									return false;
								}
							}
						})
					});
					
					// 서비스 그룹 전체 선택/전체 해제 설정
					var serviceGroupData = tableServiceGroup.rows('.selected').data();
					serviceGroupData.length == data.length ? $('.selecteAll').addClass('checked') : $('.selecteAll').removeClass('checked');
					
					$('.selecteAll').off('click').on('click', function() {
						$('.selecteAll').toggleClass('checked');
						$('.selecteAll').hasClass('checked') ? tableServiceGroup.rows().select() : tableServiceGroup.rows('.noAdmin').deselect();
					})
					
					$('#tableServiceGroup tbody').on('click', 'tr', function() {
						$(this).toggleClass('selected');
						
						var serviceGroupData = tableServiceGroup.rows('.selected').data();
						serviceGroupData.length == data.length ? $('.selecteAll').addClass('checked') : $('.selecteAll').removeClass('checked');
					})
				}
			});
		}
		
		// 등록 모달 설정
		function insertUser() {

			// modal 초기화
			clearModal();

			$('.modal-title').html('사용자 등록');
			$('#userBtn').html('등록');
			$('#userBtn').attr('onclick', 'validationUser("create")');

			$('#userModal').modal('show');
			
			// 등록 모달 열리면 첫번째 폼 포커스
			$('#userModal').on('shown.bs.modal', function () {
				$('#userModal_id').focus();
			})
		}

		// 사용자 삭제
		function deleteUser(data) {
		
			// 삭제 확인
			if (confirm('\'' + data.sUserID + ' (' + data.sName + ')\' 사용자를 삭제하시겠습니까?') == true) {
				$.ajax({
					type: 'POST',
					url: '/user/deleteUser.do',
					data: {
						id: data.id,
						sUserID: data.sUserID,
						sName: data.sName
					},
					success: function(data) {
						
						// 삭제 성공
						if (data == 1) {
							alert('사용자 삭제가 완료되었습니다.');
							location.reload();

						// 삭제 실패
						} else if (data == 2) {
							if (confirm('해당 사용자는 서비스 그룹 관리자이므로 삭제할 수 없습니다.\n서비스 그룹 관리자를 변경하시겠습니까?') == true) {
								location.href = '/serviceGroup/manageServiceGroup.prom';

							} else {
								return false;
							}

						} else if (data == 3) {
							if (confirm('해당 사용자는 서비스 관리자이므로 삭제할 수 없습니다.\n서비스 관리자를 변경하시겠습니까?') == true) {
								location.href = '/serviceGroup/manageService.prom';

							} else {
								return false;
							}

						} else {
							alert('사용자 삭제에 실패했습니다.');
							return false;
						}
					}
				})
			
			} else {
				return false;
			}
		}

		// 사용자 비밀번호 초기화
		function resetPassword(data) {
			
			// 초기화 확인
			if (confirm('\'' + data.sUserID + ' (' + data.sName + ')\' 사용자의 비밀번호를 초기화하시겠습니까?') == true) {
				$.ajax({
					url: '/user/resetPassword.do',
					type: 'POST',
					data: {
						id: data.id,
						sUserID: data.sUserID
					},
					success: function(data) {
						
						// 초기화 성공
						if (data == 1) {
							alert('비밀번호 초기화가 완료되었습니다.');
							location.reload();

							
						// 초기화 실패
						} else {
							alert('비밀번호 초기화에 실패했습니다.');
							return false;
						}
					}
				})

			} else {
				return false;
			}
		}
	</script>
</body>

</html>