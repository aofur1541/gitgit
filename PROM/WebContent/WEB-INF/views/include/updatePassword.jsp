<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 비밀번호 변경 모달 -->
<div class="modal fade" id="passowrdModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">비밀번호 변경</span>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-xl-6">
						<div class="modal-card">
							<label>아이디</label>
							<input type="text" class="form-control" id="passowrdModal_ID" disabled>
							<label>이름</label>
							<input type="text" class="form-control" id="passowrdModal_name" disabled>
							<label>부서</label>
							<input type="text" class="form-control mb-0" id="passowrdModal_department" disabled>
						</div>
					</div>
					<div class="col-xl-6">
						<div class="modal-card">
							<label>현재 비밀번호 <span class="text-danger">*</span></label>
							<input type="password" class="form-control" id="passowrdModal_currentPassowrd">
							<label>새 비밀번호 <span class="text-danger">*</span></label>
							<input type="password" class="form-control" id="passowrdModal_newPassowrd">
							<label>새 비밀번호 확인 <span class="text-danger">*</span></label>
							<input type="password" class="form-control mb-0" id="passowrdModal_newPassowrdCheck">
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn" id="updatePassowrdBtn">변경</button>
				<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	
	// 비밀번호 변경
	function updatePassword(userId) {
		$('#passowrdModal').modal('show');
		$('#passowrdModal').on('shown.bs.modal', function() {
			$('#passowrdModal_currentPassowrd').focus();
		});
	
		$.ajax({
			url: "/user/selectUserBySUserID.do",
			type: "POST",
			data: {
				sUserID: userId
			},
			success: function(data) {
				var userId = '\"' + data.sUserID + '\"';
	
				$('#passowrdModal_ID').val(data.sUserID);
				$('#passowrdModal_name').val(data.sName);
				$('#passowrdModal_department').val(data.sDepartmentName);
	
				$('#updatePassowrdBtn').attr('onclick', 'updatePasswordCheck(' + data.id + ', ' + userId + ');');
	
				// Enter 키 입력
				$(document).on('keydown', '#passowrdModal_currentPassowrd', function(event) {
					if (event.keyCode == 13) {
						$('#updatePassowrdBtn').trigger('click');
					}
				})
	
				$(document).on('keydown', '#passowrdModal_newPassowrd', function(event) {
					if (event.keyCode == 13) {
						$('#updatePassowrdBtn').trigger('click');
					}
				})
	
				$(document).on('keydown', '#passowrdModal_newPassowrdCheck', function(event) {
					if (event.keyCode == 13) {
						$('#updatePassowrdBtn').trigger('click');
					}
				})
			}
		})
	}
	
	// 비밀번호 변경 체크
	function updatePasswordCheck(id, userId) {
		var currentPassowrd = $('#passowrdModal_currentPassowrd').val();
		var newPassowrd = $('#passowrdModal_newPassowrd').val();
		var newPassowrdCheck = $('#passowrdModal_newPassowrdCheck').val();
	
		// 입력 체크
		if (!currentPassowrd) {
			alert('비밀번호를 입력해 주세요.');
			$('#passowrdModal_currentPassowrd').focus();
			return false;
		}
	
		if (!newPassowrd) {
			alert('새 비밀번호를 입력해 주세요.');
			$('#passowrdModal_newPassowrd').focus();
			return false;
		}
		
		if (newPassowrd.length < 8 || newPassowrd.length > 20) {
			alert('최소 8자 ~ 최대 20자 이내로 입력해 주세요.');
			$('#passowrdModal_newPassowrd').focus();
			return false;
		}
	
		if (newPassowrd.search(/₩s/) != -1) {
			alert('공백은 사용할 수 없습니다.');
			$('#passowrdModal_newPassowrd').focus();
			return false;
		}
		
		if (!newPassowrdCheck) {
			alert('새 비밀번호 확인을 입력해 주세요.');
			$('#passowrdModal_newPassowrdCheck').focus();
			return false;
		}
	
		$.ajax({
			url: "/user/upateNewPassword.do",
			data: {
				id: id,
				newPW: newPassowrd,
				newPWconfirm: newPassowrdCheck,
				currentPW: currentPassowrd,
				sUserID: userId
			},
			type: 'POST',
			success: function(data) {
				
				// 변경 성공
				if (data == 1) {
					alert('비밀번호 변경이 완료되었습니다. 다시 로그인해 주세요.');
					window.location.href = "/index.jsp";
				
				// 변경 실패
				} else if (data == 0) {
					alert('새 비밀번호가 일치하지 않습니다. 다시 입력해 주세요.');
					$('#passowrdModal_newPassowrd').focus();
					return false;
				
				} else if (data == 2) {
					alert('영문 대소문자, 숫자, 특수문자를 혼합하여 입력해 주세요.');
					$('#passowrdModal_newPassowrd').focus();
					return false;
				
				} else if (data == 3) {
					alert('현재 비밀번호와 동일한 비밀번호로 변경할 수 없습니다.');
					$('#passowrdModal_newPassowrd').focus();
					return false;
				
				} else if (data == 4) {
					alert('비밀번호를 잘못 입력하셨습니다. 다시 입력해 주세요.');
					$('#passowrdModal_currentPassowrd').focus();
					return false;
				
				} else {
					alert('비밀번호 변경에 실패했습니다.');
					$('#passowrdModal_currentPassowrd').focus();
					return false;
				}
			}
		})
	}
</script>