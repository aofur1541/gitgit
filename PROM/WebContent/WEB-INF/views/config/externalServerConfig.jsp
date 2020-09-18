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
		
			<!-- 서버 모달 -->
			<div class="modal fade" id="serverModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">서버 등록</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<div class="row">
									<div class="col-6">
										<label>서버 <span class="text-danger">*</span></label>
										<select class="form-control" id="serverModal_serverType">
											<option value="1">vCenter</option>
											<option value="2">vRealize Orchestrator</option>
											<option value="3">vRealize Operations</option>
											<option value="4">vRealize Automation</option>
											<option value="5">Email</option>
											<option value="6">OTP Server</option>
										</select>
									</div>
									<div class="col-6">
										<label>이름 <span class="text-danger">*</span></label>
										<input type="text" class="form-control" placeholder="서버 이름" autocomplete="off" maxlength="30" id="serverModal_name">
									</div>
								</div>
								<div class="row">
									<div class="col-12 connectDiv">
										<label>연결 정보 <span class="text-danger">*</span></label>
										<input type="text" class="form-control" placeholder="연결 정보" autocomplete="off" maxlength="50" id="serverModal_connect">
									</div>
									<div class="col-6 portDiv d-none">
										<label>사용 포트 <span class="text-danger">*</span></label>
										<input type="number" class="form-control" placeholder="사용 포트(587)" id="serverModal_port">
									</div>
								</div>
								<div class="row">
									<div class="col-6 idDiv">
										<label>아이디 <span class="text-danger">*</span></label>
										<input type="text" class="form-control" placeholder="아이디" autocomplete="off" maxlength="30" id="serverModal_id">
									</div>
									<div class="col-6 passwordDiv">
										<label>비밀번호 <span class="text-danger">*</span></label>
										<input type="text" class="form-control" placeholder="비밀번호" autocomplete="off" maxlength="30" id="serverModal_password">
									</div>
								</div>
								<div class="row">
									<div class="col-6">
										<div class="custom-control custom-radio custom-control-inline">
											<input type="radio" class="custom-control-input" id="serverModal_serverOn" name="serverModal_useServer" value="1" checked>
											<label class="custom-control-label" for="serverModal_serverOn">사용</label>
										</div>
										<div class="custom-control custom-radio custom-control-inline">
											<input type="radio" class="custom-control-input" id="serverModal_serverOff" name="serverModal_useServer" value="0">
											<label class="custom-control-label" for="serverModal_serverOff">미사용</label>
										</div>
									</div>
									<div class="col-6 useSSLDiv d-none">
										<div class="custom-control custom-radio custom-control-inline">
											<input type="radio" class="custom-control-input" id="serverModal_sslOn" name="serverModal_useSSL" value="1">
											<label class="custom-control-label" for="serverModal_sslOn">SSL 사용</label>
										</div>
										<div class="custom-control custom-radio custom-control-inline">
											<input type="radio" class="custom-control-input" id="serverModal_sslOff" name="serverModal_useSSL" value="0" checked>
											<label class="custom-control-label" for="serverModal_sslOff">SSL 미사용</label>
										</div>
									</div>
								</div>
							</div>
							<div class="modal-card">
								<label>설명</label>
								<input type="text" class="form-control mb-0" placeholder="서버 설명" autocomplete="off" maxlength="40" id="serverModal_description">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" id="serverBtn" onclick="createServer()">등록</button>
							<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 서버 테이블 -->
			<table id="tableServer" class="cell-border hover" style="width: 100%">
				<thead>
					<tr>
						<th>서버</th>
						<th>이름</th>
						<th>연결 정보</th>
						<th>아이디</th>
						<th>비밀번호</th>
						<th>설명</th>
						<th>사용</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			getServerList();
		});
		
		// 서버 테이블
		function getServerList() {
			var tableServer = $('#tableServer').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"createB"><"manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/config/selectExternalServerList.do',
					type: 'POST',
					dataSrc: ''
				},
				columns: [
					{data: 'serverType', render: function(data, type, row) {
						data = serverType(data);
						
						return data;
					}},
					{data: 'name'},
					{data: 'connectString'},
					{data: 'account'},
					{data: 'password', render: function(data, type, row) {
						data = '*******';
						
						return data;
					}},
					{data: 'description'},
					{data: 'isUse', render: function(data, type, row) {
						if (data == 1) {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 0) {
							data = '<span class="text-off">OFF</span>';
						}
						
						return data;
					}}
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
						title: '서버 정보'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '서버 정보'
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
			
			tableServerButton(tableServer);
		}
		
		// 관리 버튼 설정
		function tableServerButton(tableServer){
			$('.createB').html('<button type="button" class="btn createBtn" onclick="insertServer()">등록</button>');
			$('.manageB').html('<button type="button" class="btn manageBtn">관리</button>');
			
			$('.manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableServer').on('click', 'tr', function() {
				var data = tableServer.row(this).data();
				
				if (data != undefined){
					$(this).addClass("selected");
					$("#tableServer tr").not(this).removeClass("selected");
					
					// 관리 버튼 활성화
					var html = '';
					
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown">관리</button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" id="updateServer">서버 정보 변경</a>';
					html += '<a href="#" class="dropdown-item" id="deleteServer">서버 삭제</a>';
					html += '</div>';
					
					$('.manageB').empty().append(html);
					
					$('#updateServer').off('click').on('click', function() {
						updateServer(data);
					});
					
					$('#deleteServer').off('click').on('click', function() {
						deleteServer(data);
					});
				}
			});
		}
		
		// 서버 등록/수정 화면의 값 초기화
		function clearModal() {
			
			// selectbox 설정
			$('#serverModal_serverType').attr('disabled', false);
			
			// 값 초기화
			$('#serverModal_name').val('');
			$('#serverModal_connect').val('');
			$('#serverModal_port').val('');
			$('#serverModal_id').val('');
			$('#serverModal_password').val('');
			$('#serverModal_description').val('');
			
			$('input[name="serverModal_useServer"][value="1"]').prop('checked', true);
			$('input[name="serverModal_useSSL"][value="0"]').prop('checked', true);
		}
		
		// 서버 등록 창 열기
		function insertServer() {
			
			// modal 초기화
			$('#serverModal_serverType option:eq(0)').prop('selected', true);
			clearModal();
			
			$('.modal-title').html('서버 등록');
			$('#serverBtn').html('등록');
			$('#serverBtn').attr('onclick', 'createServer()');
			
			$('#serverModal').modal('show');
			
			// 등록 창 열리면 첫번째 폼 포커스
			$('#serverModal').on('shown.bs.modal', function () {
				$('#serverModal_serverType').focus();
			})
			
			// 서버 변경 시
			$('#serverModal_serverType').change(function () {
				clearModal();
				
				var serverType = $('#serverModal_serverType').val();
				serverTypeChange(serverType);
			})
		}
		
		// 서버 등록
		function createServer() {
			var serverType = $('#serverModal_serverType option:selected').val();
			var name = $('#serverModal_name').val();
			var connect = $('#serverModal_connect').val();
			var serverId = $('#serverModal_id').val();
			var password = $('#serverModal_password').val();
			var description = $('#serverModal_description').val();
			var useServer = $('input[name="serverModal_useServer"]:checked').val();
			var useSSL = $('input[name="serverModal_useSSL"]:checked').val();
			var port = $('#serverModal_port').val();
			port = port == null || port == '' ? 0 : port;
			
			// 입력 체크
			if (!name) {
				alert('서버 이름을 입력해 주세요.');
				$('#serverModal_name').focus();
				return false;
			}
			
			if (!connect) {
				alert('연결 정보를 입력해 주세요.');
				$('#serverModal_connect').focus();
				return false;
			}
			
			if (serverType == 5 || serverType == 6) {
				if (!port) {
					alert('포트를 입력해 주세요.');
					$('#serverModal_port').focus();
					return false;
				}
			}
			
			if (serverType == 1 || serverType == 2 || serverType == 3 || serverType == 4 || serverType == 5) {
				if (!serverId) {
					alert('아이디를 입력해 주세요.');
					$('#serverModal_id').focus();
					return false;
				}
			}
			
			if (!password) {
				alert('비밀번호를 입력해 주세요.');
				$('#serverModal_password').focus();
				return false;
			}
			
			$.ajax({
				url: '/config/insertExternalServer.do',
				type: 'POST',
				data: {
					serverType: serverType,
					name: name,
					connectString: connect,
					account: serverId,
					password: password,
					description: description,
					port: port,
					isUse: useServer,
					ssl: useSSL
				},
				success: function(data) {
					
					// 등록 성공
					if (data == 1) {
						alert('서버 등록이 완료되었습니다.');
						location.reload();
					
					// 등록 실패
					} else if (data == 2) {
						alert('동일한 서버가 있습니다. 다시 입력해 주세요.');
						$('#serverModal_serverType').focus();
						return false;
					
					} else {
						alert('서버 등록에 실패했습니다.');
						return false;
					}
				}
			})
		}
		
		// 서버 변경
		function updateServer(data) {
			$.ajax({
				url: '/config/selectExternalServer.do',
				type: 'POST',
				data: {
					id: data.id,
					serverType: data.serverType
				},
				success: function(data) {
					serverTypeChange(data.serverType);
					
					// 서버 정보
					$('#serverModal_serverType').val(data.serverType).attr('disabled', true);
					$('#serverModal_name').val(data.name);
					$('#serverModal_connect').val(data.connectString);
					$('#serverModal_port').val(data.port);
					$('#serverModal_id').val(data.account);
					$('#serverModal_password').val(data.password);
					$('#serverModal_description').val(data.description);
					
					if (data.isUse == 0) {
						$('input[name="serverModal_useServer"][value="0"]').prop('checked', true);
					
					} else if (data.isUse == 1) {
						$('input[name="serverModal_useServer"][value="1"]').prop('checked', true);
					}

					if (data.ssl == 0) {
						$('input[name="serverModal_useSSL"][value="0"]').prop('checked', true);
					
					} else if (data.ssl == 1) {
						$('input[name="serverModal_useSSL"][value="1"]').prop('checked', true);
					}
					
					$('.modal-title').html('\'' + data.name + '\' 서버 정보 변경');
					$('#serverBtn').html('변경');
					$('#serverBtn').attr('onclick', 'updateServerCheck(' + data.id + ', ' + data.serverType + ')');
					
					$('#serverModal').modal('show');
				}
			})
		}
		
		// 서버 변경 체크
		function updateServerCheck(id, serverType) {
			var serverType = $('#serverModal_serverType option:selected').val();
			var name = $('#serverModal_name').val();
			var connect = $('#serverModal_connect').val();
			var serverId = $('#serverModal_id').val();
			var password = $('#serverModal_password').val();
			var description = $('#serverModal_description').val();
			var useServer = $('input[name="serverModal_useServer"]:checked').val();
			var useSSL = $('input[name="serverModal_useSSL"]:checked').val();
			var port = $('#serverModal_port').val();
			port = port == null || port == '' ? 0 : port;
			
			// 입력 체크
			if (!name) {
				alert('서버 이름을 입력해 주세요.');
				$('#serverModal_name').focus();
				return false;
			}
			
			if (!connect) {
				alert('연결 정보를 입력해 주세요.');
				$('#serverModal_connect').focus();
				return false;
			}
			
			if (serverType == 5 || serverType == 6) {
				if (!port) {
					alert('포트를 입력해 주세요.');
					$('#serverModal_port').focus();
					return false;
				}
			}
			
			if (serverType == 1 || serverType == 2 || serverType == 3 || serverType == 4 || serverType == 5) {
				if (!serverId) {
					alert('아이디를 입력해 주세요.');
					$('#serverModal_id').focus();
					return false;
				}
			}
			
			if (!password) {
				alert('비밀번호를 입력해 주세요.');
				$('#serverModal_password').focus();
				return false;
			}
			
			$.ajax({
				url: '/config/updateExternalServer.do',
				type: 'POST',
				data: {
					id: id,
					serverType: serverType,
					name: name,
					connectString: connect,
					account: serverId,
					password: password,
					description: description,
					port: port,
					isUse: useServer,
					ssl: useSSL
				},
				success: function(data) {
					
					// 변경 성공
					if (data == 1) {
						alert('서버 변경이 완료되었습니다.');
						location.reload();
					
					// 변경 실패
					} else if (data == 2) {
						alert('서버 종류는 변경할 수 없습니다. 다시 입력해 주세요.');
						$('#serverModal_serverType').focus();
						return false;
					
					} else {
						alert('서버 변경에 실패했습니다.');
						return false;
					}
				}
			})
		}
		
		// 서버 삭제
		function deleteServer(data) {
			// 삭제 확인
			if (confirm('\'' + data.name + ' (' + serverType(data.serverType) + ')\' 서버를 삭제하시겠습니까?\n서버 삭제 시 제대로 동작하지 않을 수 있습니다.') == true) {
				$.ajax({
					url: '/config/deleteExternalServer.do',
					type: 'POST',
					data: {
						id: data.id,
						name: data.name
					},
					success: function(data) {
						// 삭제 성공
						if (data == 1) {
							alert('서버 삭제가 완료되었습니다.');
							location.reload();

						// 삭제 실패
						} else {
							alert('서버 삭제에 실패했습니다.');
							return false;
						}
					}
				})
			} else {
				return false;
			}
		}
		
		// 서버 종류 설정
		function serverType(data) {
			switch (data) {
				case 1:
					return "vCenter";
					break;
				case 2:
					return "vRealize Orchestrator";
					break;
				case 3:
					return "vRealize Operations";
					break;
				case 4:
					return "vRealize Automation";
					break;
				case 5:
					return "Email";
					break;
				case 6:
					return "OTP Server";
					break;
				default:
					return "";
			}
		}
		
		// 서버 종류에 따라 모달 입력 내용이 바뀜
		function serverTypeChange(serverType) {
			if (serverType == 1 || serverType == 2 || serverType == 3 || serverType == 4) {
				$('.portDiv').addClass('d-none');
				$('.connectDiv').addClass(' col-12').removeClass('col-6');
				$('.idDiv').removeClass('d-none');
				$('.passwordDiv').addClass('col-6').removeClass('col-12');
				$('.useSSLDiv').addClass('d-none');
			}

			if (serverType == 5) {
				$('.portDiv').removeClass('d-none');
				$('.connectDiv').addClass('col-6').removeClass(' col-12');
				$('.idDiv').removeClass('d-none');
				$('.passwordDiv').addClass('col-6').removeClass('col-12');
				$('.useSSLDiv').removeClass('d-none');
				$('#serverModal_port').attr('placeholder', '사용 포트(587)');
			}

			if (serverType == 6) {
				$('.portDiv').removeClass('d-none');
				$('.connectDiv').addClass('col-6').removeClass(' col-12');
				$('.idDiv').addClass('d-none');
				$('.passwordDiv').addClass('col-12').removeClass('col-6');
				$('.useSSLDiv').addClass('d-none');
				$('#serverModal_port').attr('placeholder', '사용 포트(1812)');
			}
		}
	</script>
</body>

</html>