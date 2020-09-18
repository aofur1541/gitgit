<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>
		
		<!-- 본문 시작 -->
		<div class="content">

			<!-- 부서 모달 -->
			<div class="modal fade" id="departmentModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">부서 등록</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<div class="row">
									<div class="col-6">
										<label>회사 <span class="text-danger">*</span></label>
										<select class="form-control" id="departmentModal_company"></select>
									</div>
									<div class="col-6">
										<label>상위 부서 <span class="text-danger">*</span></label>
										<select class="form-control" id="departmentModal_upperDepartment"></select>
									</div>
								</div>
								<div class="row">
									<div class="col-6">
										<label>부서 코드 <span class="text-danger">*</span></label>
										<input type="text" class="form-control" placeholder="부서 코드" autocomplete="off" maxlength="20" id="departmentModal_departmentCode">
									</div>
									<div class="col-6">
										<label>부서 <span class="text-danger">*</span></label>
										<input type="text" class="form-control" placeholder="부서 이름" autocomplete="off" maxlength="20" id="departmentModal_department">
									</div>
								</div>
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" class="custom-control-input" id="departmentModal_departmentOn" name="departmentModal_departmentOnOff" value="1" checked>
									<label class="custom-control-label" for="departmentModal_departmentOn">사용</label>
								</div>
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" class="custom-control-input" id="departmentModal_departmentOff" name="departmentModal_departmentOnOff" value="0">
									<label class="custom-control-label" for="departmentModal_departmentOff">미사용</label>
								</div>
							</div>
							<div class="modal-card">
								<label>설명</label>
								<input type="text" class="form-control mb-0" placeholder="부서 설명" autocomplete="off" maxlength="40" id="departmentModal_description">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" id="departmentBtn">등록</button>
							<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 부서 테이블 -->
			<table id="tableDepartment" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>회사</th>
						<th>부서</th>
						<th>부서 코드</th>
						<th>상위 부서</th>
						<th>사용</th>
						<th>설명</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>
	
	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			getDepartmentList();
			
			// 회사 셀렉트 박스 변경 시
			$('#departmentModal_company').change(function () {
				var companyId = $('#departmentModal_company option:selected').val();
				selectDepartmentList(companyId);
			});
		});
		
		// 부서 테이블
		function getDepartmentList() {
			var tableDepartment = $('#tableDepartment').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"createB"><"manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/user/selectDeptList.do',
					type: 'POST',
					dataSrc: ''
				},
				columns: [
					{data: 'companyName'},
					{data: 'name'},
					{data: 'deptId'},
					{data: 'upperdeptName', render: function(data, type, row) {
						data = data == null ? '최상위 부서' : data;
						return data;
					}},
					{data: 'isUse', render: function(data, type, row) {
						if (data == 1) {
							data = '<span class="text-on">ON</span>'
						
						} else if (data == 0) {
							data = '<span class="text-off">OFF</span>';
						}
						
						return data;
					}},
					{data: 'description'}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				order: [	[1, 'asc']],
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
						title: '부서 정보'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '부서 정보'
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
			
			tableDepartmentButton(tableDepartment);
		}
		
		// 등록, 관리 버튼 설정
		function tableDepartmentButton(tableDepartment) {
			$('.createB').html('<button type="button" class="btn createBtn" onclick="insertDepartment()">등록</button>');
			$('.manageB').html('<button type="button" class="btn manageBtn">관리</button>');
			
			$('.manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableDepartment tbody').on('click', 'tr', function() {
				var data = tableDepartment.row(this).data();
				
				if (data != undefined){
					$(this).addClass('selected');
					$('#tableDepartment tr').not(this).removeClass('selected');
					
					// 관리 버튼 활성화
					var html = '';
					
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown">관리</button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" id="updateDepartment">부서 정보 변경</a>';
					html += '<a href="#" class="dropdown-item" id="deleteDepartment">부서 삭제</a>';
					html += '</div>';
					
					$('.manageB').empty().append(html);
					
					$('#updateDepartment').off('click').on('click', function() {
						updateDepartment(data);
					});
					
					$('#deleteDepartment').off('click').on('click', function() {
						deleteDepartment(data);
					});
				}
			});
		}
		
		// 회사 목록
		function selectCompanyList(companyId, departmentId) {
			$.ajax({
				url: '/user/selectCompanyList.do',
				type: 'POST',
				success: function(data) {
					var html = '';
					
					for (key in data) {
						if (companyId && companyId == data[key].id) {
							html += '<option value="' + data[key].id + '" selected>' + data[key].name + '</option>';
						
						} else {
							html += '<option value="' + data[key].id + '">' + data[key].name + '</option>';
						}
					}
					
					$('#departmentModal_company').empty().append(html);
					
					companyId = !companyId ? $('#departmentModal_company option:selected').val() : companyId;
					selectDepartmentList(companyId, departmentId);
				}
			})
		}
		
		// 부서 목록
		function selectDepartmentList(companyId, departmentId) {
			$.ajax({
				url: '/user/selectDeptList.do',
				type: 'POST',
				data: {
					companyId: companyId,
					isUse: 1
				},
				success: function(data) {
					var html = '';
					
					if (data == null || data == '') {
						html += '<option value="0">최상위 부서</option>';

					} else {
						html += '<option value="0">최상위 부서</option>';
						for (key in data) {
							if (departmentId && departmentId == data[key].deptId) {
								html += '<option value="' + data[key].deptId + '" selected>' + data[key].name + '</option>';
							
							} else {
								html += '<option value="' + data[key].deptId + '">' + data[key].name + '</option>';
							}
						}
					}
					
					$('#departmentModal_upperDepartment').empty().append(html);
				}
			})
		}
		
		// 등록/변경 모달 값 초기화
		function clearModal() {
			
			// 셀렉트 박스 초기화
			selectCompanyList();

			// 값 초기화
			$('#departmentModal_company').attr('disabled', false);
			$('#departmentModal_upperDepartment').attr('disabled', false);
			$('#departmentModal_departmentCode').val('').attr('disabled', false);
			$('#departmentModal_department').val('');
			$('#departmentModal_description').val('');
			
			$('input[name="departmentModal_departmentOnOff"][value="1"]').prop('checked', true);
		}
		
		// 등록 모달 설정
		function insertDepartment() {
			
			// modal 초기화
			clearModal();
			
			$('.modal-title').html('부서 등록');
			$('#departmentBtn').html('등록');
			$('#departmentBtn').attr('onclick', 'validationDepartment("create")');
			
			$('#departmentModal').modal('show');
			
			// 등록 모달 열리면 첫번째 폼 포커스
			$('#departmentModal').on('shown.bs.modal', function () {
				$('#departmentModal_company').focus();
			})
		}
		
		// 변경 모달 설정
		function updateDepartment(data) {
			selectCompanyList(data.companyId, data.deptId);
			
			$('#departmentModal_company').attr('disabled', true);
			$('#departmentModal_upperDepartment').attr('disabled', true);
			$('#departmentModal_departmentCode').val(data.deptId).attr('disabled', true);
			$('#departmentModal_department').val(data.name);
			$('#departmentModal_description').val(data.description);
			
			if (data.isUse == 0) {
				$('input[name="departmentModal_departmentOnOff"][value="0"]').prop('checked', true);

			} else if (data.isUse == 1) {
				$('input[name="departmentModal_departmentOnOff"][value="1"]').prop('checked', true);
			}

			$('.modal-title').html('\'' + data.name + '\' 부서 정보 변경');
			$('#departmentBtn').html('변경');
			$('#departmentBtn').attr('onclick', 'validationDepartment("update"' + ', "' + data.id + '")');
			
			$('#departmentModal').modal('show');
		}
		
		// 유효성 검사
		function validationDepartment(category, id) {
			var companyId = $('#departmentModal_company option:selected').val();
			var companyName = $('#departmentModal_company option:selected').text();
			var upperDepartmentId = $('#departmentModal_upperDepartment option:selected').val();
			var upperDepartmentName = $('#departmentModal_upperDepartment option:selected').text();
			var department = $('#departmentModal_department').val();
			var departmentCode = $('#departmentModal_departmentCode').val();
			var description = $('#departmentModal_description').val();
			var useDepartment = $('input[name="departmentModal_departmentOnOff"]:checked').val();

			// 입력 체크
			if (!departmentCode) {
				alert('부서 코드를 입력해 주세요.');
				$('#departmentModal_departmentCode').focus();
				return false;
			}
			
			if (!department) {
				alert('부서 이름을 입력해 주세요.');
				$('#departmentModal_department').focus();
				return false;
			}

			if (pattern_kor.test(departmentCode)) {
				alert('부서 코드에 한글은 사용할 수 없습니다. 다시 입력해 주세요.');
				$('#departmentModal_departmentCode').focus();
				return false;
			}

			if (pattern_blank.test(departmentCode)) {
				alert('부서 코드에 공백은 사용할 수 없습니다. 다시 입력해 주세요.');
				$('#departmentModal_departmentCode').focus();
				return false;
			}

			// 등록
			if (category == 'create' && !id) {
				$.ajax({
					url: '/user/insertDept.do',
					type: 'POST',
					data: {
						companyId: companyId,
						companyName: companyName,
						upperdeptId: upperDepartmentId,
						upperdeptName: upperDepartmentName,
						name: department,
						deptId: departmentCode,
						description: description,
						isUse: useDepartment
					},
					success: function(data) {
						
						// 등록 성공
						if (data == 1) {
							alert('부서 등록이 완료되었습니다.');
							location.reload();
						
						// 등록 실패
						} else if (data == 2) {
							alert('동일한 부서 코드가 있습니다. 다시 입력해 주세요.');
							$('#departmentModal_departmentCode').focus();
							return false;
						
						} else if (data == 3) {
							alert('동일한 부서 이름 있습니다. 다시 입력해 주세요.');
							$('#departmentModal_department').focus();
							return false;
						
						} else {
							alert('부서 등록에 실패했습니다.');
							return false;
						}
					}
				})
			}
			
			// 변경
			if (category == 'update' && id) {
				$.ajax({
					url: '/user/updateDept.do',
					type: 'POST',
					data: {
						id: id,
						companyId: companyId,
						companyName: companyName,
						upperdeptId: upperDepartmentId,
						upperdeptName: upperDepartmentName,
						name: department,
						deptId: departmentCode,
						description: description,
						isUse: useDepartment
					},
					success: function(data) {
						
						// 변경 성공
						if (data == 1) {
							alert('변경이 완료되었습니다.');
							location.reload();
						
						// 변경 실패
						} else if (data == 2) {
							alert('동일한 부서 이름이 있습니다. 다시 입력해 주세요.');
							$('#departmentModal_department').focus();
							return false;
						
						} else if (data == 3) {
							if (confirm('해당 부서는 서비스 그룹에 속해 있으므로 미사용으로 변경할 수 없습니다.\n서비스 그룹의 부서를 변경하러 가시겠습니까?') == true) {
								location.href = "/menu/tenantSetting.do#1";
							
							} else {
								return false;
							}
						
						} else {
							alert('부서 변경에 실패했습니다.');
							return false;
						}
					}
				})
			}
		}

		// 부서 삭제
		function deleteDepartment(data) {
			
			// 삭제 확인
			if (confirm('\'' + data.name + '\' 부서를 삭제하시겠습니까?') == true) {
				$.ajax({
					url: '/user/deleteDept.do',
					type: 'POST',
					data: {
						id: data.id,
						companyId: data.companyId,
						name: data.name,
						deptId: data.deptId
					},
					success: function(data) {
						
						// 삭제 성공
						if (data == 1) {
							alert('부서 삭제가 완료되었습니다.');
							location.reload();
						
						// 삭제 실패
						} else if (data == 2) {
							alert('해당 부서는 하위 부서가 있어 삭제할 수 없습니다.');
							return false;
						
						} else if (data == 3) {
							if (confirm('해당 부서는 서비스 그룹에 소속되어 있어 삭제할 수 없습니다.\n서비스 그룹의 부서를 변경하시겠습니까?') == true) {
								location.href = "/menu/tenantSetting.do#1";
							} else {
								return false;
							}
						
						} else if (data == 4) {
							alert('해당 부서는 사용자가 있어 삭제할 수 없습니다.');
							return false;
						
						} else {
							alert('부서 삭제에 실패했습니다.');
							return false;
						}
					}
				})
			} else {
				return false;
			}
		}
	</script>
</html>