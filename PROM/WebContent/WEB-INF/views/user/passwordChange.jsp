<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			function userProDetail(sUserID) {
				$.ajax({
					url: "/user/selectUserBySUserID.do",
					data: {
						sUserID: sUserID
					},
					success: function(data) {
						var html = "";
						var footer = "";
						var value = "\'" + data.sUserID + "\'";
						var userPK = data.nNumber;
	
						html += '<div class="form-group row">';
						html += '<label class="col-form-label col-md-4">이름:</label>';
						html += '<div class="col-md-8">';
						html += '<input type="text" class="form-control form-control-modal" placeholder="이름" id="sName" value="' + data.sName + '" disabled>';
						html += '</div>';
						html += '</div>';
	
						html += '<div class="form-group row">';
						html += '<label class="col-form-label col-md-4">아이디:</label>';
						html += '<div class="col-md-8">';
						html += '<input type="hidden" id="nNumber" value=' + data.nNumber + '>';
						html += '<input type="text" class="form-control form-control-modal" id="sUserID" value="' + data.sUserID + '" disabled>';
						html += '</div>';
						html += '</div>';
	
						html += '<div class="form-group row">';
						html += '<label class="col-form-label col-md-4">사번:</label>';
						html += '<div class="col-md-8">';
						html += '<input type="text" class="form-control form-control-modal" id="sUserNumber" value="' + data.nNumber + '" disabled>';
						html += '</div>';
						html += '</div>';
	
						html += '<div class="form-group row">';
						html += '<label class="col-form-label col-md-4">부서:</label>';
						html += '<div class="col-md-8">';
						html += '<input type="text" class="form-control form-control-modal" id="sDepartment" value="' + data.sDepartmentName + '" disabled>';
						html += '</div>';
						html += '</div>';
	
						html += '<div class="form-group row">';
						html += '<label class="col-form-label col-md-4">기존 비밀번호:</label>';
						html += '<div class="col-md-8">';
						html += '<input type="password" class="form-control form-control-modal" placeholder="기존 비밀번호" id="nowPW">';
						html += '</div>';
						html += '</div>';
	
						html += '<div id="newPWappend"></div>';
	
						footer += '<button type="button" class="btn bg-prom rounded-round" onclick="userPasswordupdate(' + data.id + ', ' + value + ')">확인</button>';
	
						$("#passwordChange-modal-body").empty();
						$("#passwordChange-modal-body").append(html);
	
						$("#passwordChange-modal-footer").empty();
						$("#passwordChange-modal-footer").append(footer);
	
						$('#passwordChange').on('shown.bs.modal', function() {
							$('#nowPW').focus();
						})
	
						$(document).on('keydown', '#nowPW', function(event) {
							if (event.keyCode == 13) {
								userPasswordupdate(data.id, value);
							}
						})
					}
				})
			}
	
			function userPasswordupdate(id, userid) {
				var nowPW = $("#nowPW").val();
				var sUserID = $("#sUserID").val();
	
				$.ajax({
					url: "/login/verifyPassword.do",
					data: {
						sUserPW: nowPW,
						sUserID: sUserID,
					},
					success: function(data) {
						if (data == 0) {
							alert("기존 비밀번호가 일치하지 않습니다. 다시 확인해 주십시오.");
							$('#nowPW').focus();
							return false;
	
						} else if (data == 1) {
							var html = '';
							var footer = '';
							var value = "\'" + sUserID + "\'";
	
							html += '<div class="form-group row">';
							html += '<label class="col-form-label col-md-4">새 비밀번호:</label>';
							html += '<div class="col-md-8">';
							html += '<input type="password" class="form-control form-control-modal" placeholder="새 비밀번호" id="NewPW">';
							html += '</div>';
							html += '</div>';
	
							html += '<div class="form-group row">';
							html += '<label class="col-form-label col-md-4">새 비밀번호 확인:</label>';
							html += '<div class="col-md-8">';
							html += '<input type="password" class="form-control form-control-modal" placeholder="새 비밀번호 확인" id="NewPWconfirm">';
							html += '</div>';
							html += '</div>';
	
							footer += '<button type="button" class="btn bg-prom rounded-round" onclick="userNewPasswordupdate(' + id + ', ' + value + ')">확인</button>';
	
							$("#newPWappend").empty();
							$("#newPWappend").append(html);
	
							$("#passwordChange-modal-footer").empty();
							$("#passwordChange-modal-footer").append(footer);
	
							$('#NewPW').focus();
	
							$(document).on('keydown', '#NewPWconfirm', function(event) {
								if (event.keyCode == 13) {
									userNewPasswordupdate(id, value);
								}
							})
						}
					}
				})
			}
	
			function userNewPasswordupdate(id, userId) {
				var NewPW = $("#NewPW").val();
				var NewPWconfirm = $("#NewPWconfirm").val();
	
				var pw = NewPW;
				var num = pw.search(/[0-9]/g);
				var eng = pw.search(/[a-z]/ig);
				var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
				var lowerchk = NewPW.toLowerCase();
				var upperchk = NewPW.toUpperCase();
	
				if (pw.length < 8 || pw.length > 20) {
					alert("8자리 ~ 20자리 이내로 입력해 주십시오.");
					return false;
	
				} else if (pw.search(/₩s/) != -1) {
					alert("공백 없이 입력해 주십시오.");
					return false;
				} else {
	
					$.ajax({
						url: "/login/upateNewPassword.do",
						data: {
							newPW: NewPW,
							newPWconfirm: NewPWconfirm,
							id: id,
							sUserID: userId
						},
						success: function(data) {
							if (data == 1) {
								alert("비밀번호 변경이 완료되었습니다. \n다시 로그인해 주십시오.");
								window.location.href = "/index.jsp";
							} else if (data == 0) {
								alert("새 비밀번호가 일치하지 않습니다. 다시 확인해 주십시오.");
								$("#NewPW").focus();
							} else if (data == 2) {
								alert("특수문자, 영문 대소문자, 숫자 조합을 넣으십시오.");
								$("#NewPW").focus();
							} else if (data == 3) {
								alert("기존 비밀번호를 새 비밀번호로 설정할 수 없습니다.");
								$("#NewPW").focus();
							}
						}
					})
				}
			}
		</script>
	</head>
	<body>
		<div id="passwordChange" class="modal fade" tabindex="-1">
			<div class="modal-dialog modal-sm">
				<div class="modal-content" style="margin-top: 200px;">
					<div class="modal-header bg-prom">
						<h5 class="modal-title">비밀번호 변경</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body modal-type-5" id="passwordChange-modal-body"></div>
					<div class="modal-footer bg-white" id="passwordChange-modal-footer"></div>
				</div>
			</div>
		</div>
	</body>
</html>