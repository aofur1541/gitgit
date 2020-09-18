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
		
			<!-- 기본 기능 모달 -->
			<div class="modal fade" id="basicModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">기능 설정</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<label>설명<span class="text-danger">*</span></label>
								<textarea class="form-control" id="basicModal_description" style="resize: none;" disabled></textarea>
								<div class="inputValueDiv">
									<label>설정 값<span class="text-danger">*</span></label>
									<input type="text" class="form-control mb-0" placeholder="설정 값" autocomplete="off" id="basicModal_value">
								</div>
								<div class="radioValueDiv">
									<div class="custom-control custom-radio custom-control-inline">
										<input type="radio" class="custom-control-input" id="basicModal_configOn" name="basicModal_useConfig" value="1">
										<label class="custom-control-label" for="basicModal_configOn">사용</label>
									</div>
									<div class="custom-control custom-radio custom-control-inline">
										<input type="radio" class="custom-control-input" id="basicModal_configOff" name="basicModal_useConfig" value="0" checked>
										<label class="custom-control-label" for="basicModal_configOff">미사용</label>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" id="basicBtn">변경</button>
							<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 기본 기능 테이블 -->
			<table id="tableBasic" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>설정</th>
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
			getBasicList();
		});

		// 기본 기능 테이블
		function getBasicList() {
			var tableBasic = $('#tableBasic').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/config/selectBasicList.do',
					type: 'POST',
					dataSrc: '',
				},
				columns: [
					{data: 'displayName'},
					{data: 'value', render: function(data, type, row) {
						if (row.name == 'agentOnOff' || row.name == 'useOTP' || row.name == 'userVMCtrl') {
							if (data == 1) {
								data = '<span class="text-on">ON</span>';
							
							} else if (data == 0) {
								data = '<span class="text-off">OFF</span>';
							}
						}
						
						if (row.name == 'reflashInterval' || row.name == 'autoScaleInterval') {
							data = data + ' 초';
						}
						
						if (row.name == 'pwExpiration') {
							data = data + ' 일';
						}
						
						if (row.name == 'userAccessNetwork') {
							row.valueStr == null || row.valueStr == '' ? data = '<span class="text-disabled">없음</span>' : data = row.valueStr;
						}
						
						return data;
					}},
					{data: 'description'}
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
						title: '기본 기능'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '기본 기능'
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
			
			tableBasicButton(tableBasic);
		}
		
		function tableBasicButton(tableBasic) {
			$('.manageB').html('<button type="button" class="btn manageBtn">관리</button>');
			
			$('.manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableBasic').on('click', 'tr', function() {
				var data = tableBasic.row(this).data();
				
				if (data != undefined){
					$(this).addClass('selected');
					$('#tableBasic tr').not(this).removeClass('selected');
					
					// 관리 버튼 활성화
					var html = '';
					
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown">관리</button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" id="updateBasic">기능 변경</a>';
					html += '</div>';
					
					$('.manageB').empty().append(html);
					
					$('#updateBasic').off('click').on('click', function() {
						updateBasic(data);
					});
				}
			});
		}
		
		// 변경 모달 설정
		function updateBasic(data) {
			$('#basicModal_description').val(data.description);
			
			if (data.name == 'agentOnOff' || data.name == 'useOTP' || data.name == 'userVMCtrl') {
				$('.radioValueDiv').removeClass('d-none');
				$('.inputValueDiv').addClass('d-none');
				
				if (data.value == 0) {
					$('input[name="basicModal_useConfig"][value="0"]').prop('checked', true);
				
				} else if (data.value == 1) {
					$('input[name="basicModal_useConfig"][value="1"]').prop('checked', true);
				}
				
			} else {
				$('.radioValueDiv').addClass('d-none');
				$('.inputValueDiv').removeClass('d-none');
				
				if (data.name == 'userAccessNetwork') {
					$('#basicModal_value').attr('type', 'text');
					$('#basicModal_value').val(data.valueStr);
				
				} else {
					$('#basicModal_value').attr('type', 'number');
					$('#basicModal_value').val(data.value);
				}
			}
			
			$('.modal-title').html('\'' + data.displayName + '\' 기능 변경');
			$('#basicBtn').attr('onclick', 'validationBasic("' + data.name + '")');
			
			$('#basicModal').modal('show');
			$('#basicModal').on('shown.bs.modal', function () {
				$('#basicModal_value').focus();
			})
		}
		
		// 유효성 검사
 		function validationBasic(name) {
 			var value = $('#basicModal_value').val();
 			var inputValue = '';
 			var inputTextValue = '';
 			
 			if (name == 'agentOnOff' || name == 'useOTP' || name == 'userVMCtrl') {
 				inputValue = $('input[name="basicModal_useConfig"]:checked').val();
				
			} else if (name == 'userAccessNetwork'){
				inputTextValue = $('#basicModal_value').val();
			
			} else {
				if (name == 'reflashInterval' && value > 300) {
	 				alert('새로고침 주기는 300 초까지 설정할 수 있습니다.');
					$('#basicModal_value').focus();
					return false;
	 			}
				
				if (name == 'pwExpiration' && (value < 7 || value > 60)) {
	 				alert('비밀번호 만료 주기는 최소 7 일, 최대 60 일까지 설정할 수 있습니다.');
					$('#basicModal_value').focus();
					return false;
	 			}
				
				inputValue = $('#basicModal_value').val();
			}
 			
 			$.ajax({
 				url: '/config/updateBasic.do',
				type: 'POST',
				data: {
					name: name,
					value: inputValue,
					valueStr: inputTextValue
				},
				success: function(data) {
					
					// 변경 성공
					if (data == 1) {
						alert('기능 변경이 완료 되었습니다.');
						location.reload();
						
					// 변경 실패
					} else {
						alert('기능 변경에 실패했습니다.');
						return false;
					} 
 				}
			})
		}
	</script>
</body>

</html>