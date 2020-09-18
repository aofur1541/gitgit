<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 사용자 모달 -->
<div class="modal fade" id="userModal" tabindex="-1">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">사용자 등록</span>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-xl-6">
						<div class="modal-card">
							<div class="row">
								<div class="col-6">
									<label>아이디 <span class="text-danger">*</span></label>
									<input type="text" class="form-control" placeholder="아이디" autocomplete="off" maxlength="15" id="userModal_id">
								</div>
								<div class="col-6">
									<label>이름 <span class="text-danger">*</span></label>
									<input type="text" class="form-control" placeholder="이름" autocomplete="off" maxlength="20" id="userModal_name">
								</div>
							</div>
							<div class="row">
								<div class="col-6">
									<label>회사 <span class="text-danger">*</span></label>
									<select class="form-control" id="userModal_company"></select>
								</div>
								<div class="col-6">
									<label>부서 <span class="text-danger">*</span></label>
									<select class="form-control" id="userModal_department"></select>
								</div>
							</div>
							<div class="row">
								<div class="col-6">
									<label>권한 <span class="text-danger">*</span></label>
									<select class="form-control mb-0" id="userModal_authority"></select>
								</div>
								<div class="col-6">
									<label>재직 여부 <span class="text-danger">*</span></label>
									<select class="form-control no-search mb-0" id="userModal_employment">
										<option value="11" selected>재직</option>
										<option value="55">휴직</option>
										<option value="99">퇴직</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-6">
						<div class="modal-card">
							<div class="row">
								<div class="col-6">
									<label>영문 이름</label>
									<input type="text" class="form-control" placeholder="영문 이름" autocomplete="off" maxlength="20" id="userModal_englishName">
								</div>
								<div class="col-6">
									<label>직급</label>
									<input type="text" class="form-control" placeholder="직급" autocomplete="off" maxlength="8" id="userModal_rank">
								</div>
							</div>
							<div class="row">
								<div class="col-6">
									<label>이메일</label>
									<input type="text" class="form-control" placeholder="이메일" autocomplete="off" maxlength="25" id="userModal_email">
								</div>
								<div class="col-6">
									<label>전화번호</label>
									<input type="text" class="form-control" placeholder="전화번호(000-0000-0000)" autocomplete="off" maxlength="13" id="userModal_phoneNumber">
								</div>
							</div>
							<div class="row">
								<div class="col-6">
									<label>입사일</label>
									<input type="date" class="form-control" id="userModal_startDate">
								</div>
								<div class="col-6">
									<label>사번</label>
									<input type="text" class="form-control" placeholder="사번" autocomplete="off" maxlength="10" id="userModal_employeeNumber">
								</div>
							</div>
							<label>IP 주소</label>
							<input type="text" class="form-control mb-0" placeholder="IP 주소" autocomplete="off" id="userModal_ipAddress">
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn" onclick="createUser()" id="userBtn">등록</button>
				<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

	// 권한 셀렉트 박스 설정
	function selectAuthorityList(data) {
		var html = '';
		
		if (data) {
			
			// 관리자
			if (data == SUPER_ADMIN_NUMBER) {
				html = '<option value="' + SUPER_ADMIN_NUMBER + '" selected>' + SUPER_ADMIN_NAME + '</option>';
				$('#userModal_authority').empty().append(html);
				
			// 관제 OP
			} else if (data == CONTROL_NUMBER) {
				html = '<option value="' + CONTROL_NUMBER + '" selected>' + CONTROL_NAME + '</option>';
				$('#userModal_authority').empty().append(html);
				
			// 그 외
			} else {
				html += '<option value="' + USER_NUMBER + '" selected>' + USER_NAME + '</option>';
				html += '<option value="' + TEANT_ADMIN_NUMBER + '">' + TEANT_ADMIN_NAME + '</option>';
				html += '<option value="' + INFRA_ADMIN_NUMBER + '">' + INFRA_ADMIN_NAME + '</option>';
				
				$('#userModal_authority').empty().append(html);
				$('#userModal_authority option[value="' + data + '"]').attr('selected', 'selected');
			}
		
		// 권한 셀렉트 박스 기본 설정
		} else {
			html += '<option value="' + USER_NUMBER + '" selected>' + USER_NAME + '</option>';
			html += '<option value="' + TEANT_ADMIN_NUMBER + '">' + TEANT_ADMIN_NAME + '</option>';
			html += '<option value="' + INFRA_ADMIN_NUMBER + '">' + INFRA_ADMIN_NAME + '</option>';
			
			$('#userModal_authority').empty().append(html);
		}
	}
	
	// 사용자 권한 코드
	function userAuthority(data) {
		switch (data) {
			case USER_NUMBER:
				return USER_NAME;
				break;
			case CONTROL_NUMBER:
				return CONTROL_NAME;
				break;
			case TEANT_ADMIN_NUMBER:
				return TEANT_ADMIN_NAME;
				break;
			case INFRA_ADMIN_NUMBER:
				return INFRA_ADMIN_NAME;
				break;
			case SUPER_ADMIN_NUMBER:
				return SUPER_ADMIN_NAME;
				break;
		}
	}

	// 사용자 재직 여부 코드
	function userEmployment(data) {
		switch (data) {
			case 11:
				return '재직';
				break;
			case 55:
				return '휴직';
				break;
			case 99:
				return '퇴직';
				break;
		}
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
				
				$('#userModal_company').empty().append(html);

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
					html += '<option value="">부서가 없습니다.</option>';

				} else {
					for (key in data) {
						if (departmentId && departmentId == data[key].deptId) {
							html += '<option value="' + data[key].deptId + '" selected>' + data[key].name + '</option>';
						
						} else {
							html += '<option value="' + data[key].deptId + '">' + data[key].name + '</option>';
						}
					}
				}
				
				$('#userModal_department').empty().append(html);
			}
		})
	}
	
	// 등록/변경 모달 값 초기화
	function clearModal() {

		// 셀렉트 박스 설정
		selectCompanyList();
		selectAuthorityList();

		// 값 초기화
		$('#userModal_id').val('').attr('disabled', false);
		$('#userModal_name').val('');

		$('#userModal_englishName').val('');
		$('#userModal_rank').val('');
		$('#userModal_email').val('');
		$('#userModal_phoneNumber').val('');
		$('#userModal_startDate').val('');
		$('#userModal_employeeNumber').val('');
		$('#userModal_ipAddress').val('');
	}
	
	// 변경 모달 설정
	function updateUser(data) {
		$('#userModal_name').val(data.sName);
		$('#userModal_id').val(data.sUserID).attr('disabled', true);

		selectCompanyList(data.sCompany, data.sDepartment, data.nTenantId, data.nServiceId);
		selectAuthorityList(data.nApproval);
		
		$('#userModal_employment').val(data.sTenureCode);
		$('#userModal_englishName').val(data.sNameEng);
		$('#userModal_rank').val(data.sJobCode);
		$('#userModal_email').val(data.sEmailAddress);
		$('#userModal_phoneNumber').val(data.sPhoneNumber);
		$('#userModal_startDate').val(data.dStartday);
		$('#userModal_employeeNumber').val(data.nNumber);
		$('#userModal_ipAddress').val(data.sUserIP);

		$('.modal-title').html('\'' + data.sUserID + ' (' + data.sName + ')\' 사용자 정보 변경');
		$('#userBtn').html('변경');
		$('#userBtn').attr('onclick', 'validationUser("update"' + ', "' + data.id + '")');

		$('#userModal').modal('show');
	}
	
	// 유효성 검사
	function validationUser(category, id) {
		var userId = $('#userModal_id').val();
		var name = $('#userModal_name').val();
		var company = $('#userModal_company option:selected').val();
		var companyName = $('#userModal_company option:selected').text();
		var department = $('#userModal_department option:selected').val();
		var departmentName = $('#userModal_department option:selected').text();
		var authority = $('#userModal_authority option:selected').val();
		var authorityName = $('#userModal_authority option:selected').text();
		var employment = $('#userModal_employment option:selected').val();
		var employmentName = $('#userModal_employment option:selected').text();

		var englishName = $('#userModal_englishName').val();
		var rank = $('#userModal_rank').val();
		var email = $('#userModal_email').val();
		var phoneNumber = $('#userModal_phoneNumber').val();
		var startDate = $('#userModal_startDate').val();
		var employeeNumber = $('#userModal_employeeNumber').val();
		var ipAddress = $('#userModal_ipAddress').val();

		// 아이디 체크
		if (!userId) {
			alert('아이디을 입력해 주세요.');
			$('#userModal_id').focus();
			return false;
		}

		if (pattern_blank.test(userId)) {
			alert('아이디에 공백은 사용할 수 없습니다. 다시 입력해 주세요.');
			$('#userModal_id').focus();
			return false;
		}

		if (pattern_kor.test(userId)) {
			alert('아이디에 한글은 사용할 수 없습니다. 다시 입력해 주세요.');
			$('#userModal_id').focus();
			return false;
		}
		
		// 이름 체크
		if (!name) {
			alert('이름을 입력해 주세요.');
			$('#userModal_name').focus();
			return false;
		}

		if ($.isNumeric(name)) {
			alert('이름에 숫자는 사용할 수 없습니다. 다시 입력해 주세요.');
			$('#userModal_name').focus();
			return false;
		}

		// 이메일을 입력했을 때 체크
		if (email) {
			if (!pattern_email.test(email)) {
				alert('올바른 이메일 형식이 아닙니다. 다시 입력해 주세요.');
				$('#userModal_email').focus();
				return false;
			}
		}

		// 전화번호를 입력했을 때 체크
		if (phoneNumber) {
			if (!pattern_phoneNum.test(phoneNumber)) {
				alert('올바른 전화번호 형식이 아닙니다. 다시 입력해 주세요.');
				$('#userModal_phoneNumber').focus();
				return false;
			}
		}
		
		// 등록
		if (category == 'create' && !id) {
			$.ajax({
				url: '/user/insertUser.do',
				type: 'POST',
				data: {
					sName: name,
					sUserID: userId,
					sCompany: company,
					companyName: companyName,
					sDepartment: department,
					sDepartmentName: departmentName,
					nApproval: authority,
					approvalName: authorityName,
					sTenureCode: employment,
					tenureName: employmentName,
					sNameEng: englishName,
					sJobCode: rank,
					sEmailAddress: email,
					sPhoneNumber: phoneNumber,
					dStartday: startDate,
					nNumber: employeeNumber,
					sUserIP: ipAddress
				},
				success: function(data) {
				
					// 등록 성공
					if (data == 1) {
						alert('사용자 등록이 완료되었습니다.');
						location.reload();

					// 등록 실패
					} else if (data == 2) {
						alert('동일한 아이디가 있습니다. 다시 입력해 주세요.');
						$("#userModal_id").focus();
						return false;

					} else {
						alert('사용자 등록에 실패했습니다.');
						return false;
					}
				}
			})
		}
		
		// 변경
		if (category == 'update' && id) {
			$.ajax({
				data: {
					id: id,
					sName: name,
					sCompany: company,
					companyName: companyName,
					sDepartment: department,
					sDepartmentName: departmentName,
					sTenureCode: employment,
					tenureName: employmentName,
					nApproval: authority,
					approvalName: authorityName,
					sNameEng: englishName,
					sJobCode: rank,
					sEmailAddress: email,
					sPhoneNumber: phoneNumber,
					dStartday: startDate,
					nNumber: employeeNumber,
					sUserIP: ipAddress
				},
				url: '/user/updateUser.do',
				type: 'POST',
				success: function(data) {
				
					// 변경 성공
					if (data == 1) {
						alert('사용자 변경이 완료되었습니다.');
						location.reload();
					
					// 변경 실패
					} else {
						alert('사용자 변경에 실패했습니다.');
						return false;
					}
				}
			})
		}
	}
</script>