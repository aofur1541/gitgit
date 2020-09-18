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

			<!-- 회사 모달 -->
			<div class="modal fade" id="companyModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">회사 등록</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<label>회사 <span class="text-danger">*</span></label>
								<input type="text" class="form-control mb-0" placeholder="회사 이름" autocomplete="off" maxlength="20" id="companyModal_company">
							</div>
							<div class="modal-card">
								<div class="row">
									<div class="col-6">
										<label>대표이사</label>
										<input type="text" class="form-control" placeholder="대표이사" autocomplete="off" maxlength="20" id="companyModal_ceo">
									</div>
									<div class="col-6">
										<label>사업자등록번호</label>
										<input type="text" class="form-control" placeholder="사업자등록번호" autocomplete="off" maxlength="20" id="companyModal_registrationNumber">
									</div>
								</div>
								<label>주소</label>
								<input type="text" class="form-control" placeholder="회사 주소" autocomplete="off" maxlength="20" id="companyModal_address">
								<label>설명</label>
								<input type="text" class="form-control mb-0" placeholder="회사 설명" autocomplete="off" maxlength="40" id="companyModal_description">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" id="companyBtn">등록</button>
							<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 회사 테이블 -->
			<table id="tableCompany" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>회사</th>
						<th>대표이사</th>
						<th>사업자등록번호</th>
						<th>주소</th>
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
			getCompanyList();
		})
		
		// 회사 테이블
		function getCompanyList() {
			var tableCompany = $('#tableCompany').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"createB"><"manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/user/selectCompanyList.do',
					type: 'POST',
					dataSrc: '',
				},
				columns: [
					{data: 'name'},
					{data: 'representative'},
					{data: 'registrationNumber'},
					{data: 'address'},
					{data: 'description'},
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
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
						title: '회사 정보'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '회사 정보'
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
			
			tableCompanyButton(tableCompany);
		}
		
		// 테이블 버튼 설정
		function tableCompanyButton(tableCompany) {
			$('.createB').html('<button type="button" class="btn createBtn" onclick="insertCompnay()">등록</button>');
			$('.manageB').html('<button type="button" class="btn manageBtn">관리</button>');

			$('.manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});

			// 행 선택 시
			$('#tableCompany tbody').on('click', 'tr', function() {
				var data = tableCompany.row(this).data();

				if (data != undefined) {
					$(this).addClass('selected');
					$('#tableCompany tr').not(this).removeClass('selected');

					// 관리 버튼 활성화
					var html = '';

					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown">관리</button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" id="updateCompany">회사 정보 변경</a>';
					html += '<a href="#" class="dropdown-item" id="deleteCompany">회사 삭제</a>';
					html += '</div>';

					$('.manageB').empty().append(html);
					
					$('#updateCompany').off('click').on('click', function() {
						updateCompany(data);
					});
					
					$('#deleteCompany').off('click').on('click', function() {
						deleteCompany(data);
					});
				}
			});
		}
		
		// 등록/수정 모달 값 초기화
		function clearModal() {

			// 값 초기화
			$('#companyModal_company').val('');
			$('#companyModal_ceo').val('');
			$('#companyModal_registrationNumber').val('');
			$('#companyModal_address').val('');
			$('#companyModal_description').val('');
		}
		
		// 등록 모달 설정
		function insertCompnay() {
			
			// 모달 초기화
			clearModal();
			
			$('.modal-title').html('회사 등록');
			$('#companyBtn').html('등록');
			$('#companyBtn').attr('onclick', 'validationCompany("create")');
			
			$('#companyModal').modal('show');
			
			// 등록 모달 열리면 첫번째 폼 포커스
			$('#companyModal').on('shown.bs.modal', function () {
				$('#companyModal_company').focus();
			})
		}
		
		// 변경 모달 설정
		function updateCompany(data) {
			$('#companyModal_company').val(data.name);
			$('#companyModal_ceo').val(data.representative);
			$('#companyModal_registrationNumber').val(data.registrationNumber);
			$('#companyModal_address').val(data.address);
			$('#companyModal_description').val(data.description);

			$('.modal-title').html('\'' + data.name + '\' 회사 정보 변경');
			$('#companyBtn').html('변경');
			$('#companyBtn').attr('onclick', 'validationCompany("update"' + ', "' + data.id + '")');
			
			$('#companyModal').modal('show');
		}
		
		// 유효성 검사
		function validationCompany(category, id) {
			var company = $('#companyModal_company').val();
			var ceo = $('#companyModal_ceo').val();
			var registrationNumber = $('#companyModal_registrationNumber').val();
			var address = $('#companyModal_address').val();
			var description = $('#companyModal_description').val();
			
			// 입력 체크
			if (!company) {
				alert('회사를 입력해 주세요.');
				$('#companyModal_company').focus();
				return false;
			}

			// 회사 체크
			if ($.isNumeric(company)) {
				alert('회사 이름에 숫자만 입력할 수 없습니다. 다시 입력해 주세요.');
				$('#companyModal_company').focus();
				return false;
			}

			if (pattern_blank.test(company)) {
				alert('회사 이름에 공백은 사용할 수 없습니다. 다시 입력해 주세요.');
				$('#companyModal_company').focus();
				return false;
			}

			if (pattern_spc.test(company)) {
				alert('회사 이름에 특수문자는 사용할 수 없습니다. 다시 입력해 주세요.');
				$('#companyModal_company').focus();
				return false;
			}
			
			// 등록
			if (category == 'create' && !id) {
				$.ajax({
					url: "/user/insertCompany.do",
					type: 'POST',
					data: {
						name: company,
						representative: ceo,
						registrationNumber: registrationNumber,
						address: address,
						description: description
					},
					success: function(data) {
						
						// 등록 성공
						if (data == 1) {
							alert('회사 등록이 완료되었습니다.');
							location.reload();

						// 등록 실패
						} else if (data == 2) {
							alert('동일한 회사 이름이 있습니다. 다시 입력해 주세요.');
							$('#companyModal_company').focus();
							return false;

						} else {
							alert('회사 등록에 실패했습니니다.');
							return false;
						}
					}
				})
			}
			
			// 변경
			if (category == 'update' && id) {
				$.ajax({
					url: "/user/updateCompany.do",
					type: 'POST',
					data: {
						id: id,
						name: company,
						representative: ceo,
						registrationNumber: registrationNumber,
						address: address,
						description: description
					},
					success: function(data) {
						
						// 변경 성공
						if (data == 1) {
							alert('회사 변경이 완료 되었습니다.');
							location.reload()

						// 변경 실패
						} else if (data == 2) {
							alert('동일한 회사 이름이 있습니다. 다시 입력해 주세요.');
							$('#companyModal_company').focus();
							return false;

						} else {
							alert('회사 변경에 실패했습니다.');
							return false;
						}
					}
				})
			}
		}

		// 회사 삭제
		function deleteCompany(data) {
			
			// 삭제 확인
			if (confirm('\'' + data.name + '\' 회사를 삭제하시겠습니까?') == true) {
				$.ajax({
					url: "/user/deleteCompany.do",
					type: 'POST',
					data: {
						id: data.id,
						name: data.name
					},
					success: function(data) {
						
						// 삭제 성공
						if (data == 1) {
							alert('회사 삭제가 완료되었습니다.');
							location.reload()

						// 삭제 실패
						} else if (data == 2) {
							if (confirm('회사에 등록된 사용자가 있어 삭제할 수 없습니다.\n사용자의 회사를 변경하시겠습니까?') == true) {
								location.href = '/user/manageUser.prom';

							} else {
								return false;
							}

						} else if (data == 3) {
							if (confirm('서비스 그룹에 속한 회사입니다.\n서비스 그룹의 회사를 변경하시겠습니까?') == true) {
								location.href = '/menu/tenantSetting.do#1';

							} else {
								return false;
							}

						} else if (data == 4) {
							if (confirm('회사에 부서가 있습니니다.\n회사의 부서를 삭제하시겠습니까?') == true) {
								location.href = '/user/manageDepartment.prom';

							} else {
								return false;
							}

						} else {
							alert('회사 삭제에 실패했습니다.');
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