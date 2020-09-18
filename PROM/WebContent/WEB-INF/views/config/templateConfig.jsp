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
			
			<!-- 템플릿 모달 -->
			<div class="modal fade" id="templateModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">템플릿 정보 변경</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<label>템플릿 <span class="text-danger">*</span></label>
								<input type="text" class="form-control" id="templateModal_template" disabled>
								<div class="row">
									<div class="col-6">
										<label>vCPU<span class="text-danger">*</span></label>
										<input type="number" class="form-control" id="templateModal_vCPU" disabled>
									</div>
									<div class="col-6">
										<label>Memory <span class="text-danger">*</span></label>
										<input type="number" class="form-control" id="templateModal_memory" disabled>
									</div>
								</div>
								<div class="row">
									<div class="col-6">
										<label>OS <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="templateModal_os" disabled>
									</div>
									<div class="col-6">
										<label>Disk <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="templateModal_disk" disabled>
									</div>
								</div>
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" class="custom-control-input" id="templateModal_templateOn" name="templateModal_useTemplate" value="1">
									<label class="custom-control-label" for="templateModal_templateOn">사용</label>
								</div>
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" class="custom-control-input" id="templateModal_templateOff" name="templateModal_useTemplate" value="0">
									<label class="custom-control-label" for="templateModal_templateOff">미사용</label>
								</div>
							</div>
							<div class="modal-card">
								<label>설명</label>
								<input type="text" class="form-control mb-0" placeholder="템플릿 설명" autocomplete="off" maxlength="40" id="templateModal_description">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" id="templateBtn">변경</button>
							<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 템플릿 테이블 -->
			<table id="tableTemplate" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>템플릿</th>
						<th>OS</th>
						<th>vCPU</th>
						<th>Memory</th>
						<th>Disk</th>
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
			getTemplateList();
		});
		
		// 템플릿 테이블
		function getTemplateList() {
			var tableTemplate = $('#tableTemplate').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/config/selectVMTemplateList.do',
					type: 'POST',
					dataSrc: ''
				},
				columns: [
					{data: 'vmName'},
					{data: 'vmOS'},
					{data: 'vmCPU'},
					{data: 'vmMemory', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'vmDisk', render: function(data, type, row) {
						data = data + ' GB';
						return data;
					}},
					{data: 'description'},
					{data: 'templateOnoff', render: function(data, type, row) {
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
						title: '템플릿 정보'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '템플릿 정보'
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
			
			tableTemplateButton(tableTemplate);
		}
		
		// 관리 버튼 설정
		function tableTemplateButton(tableTemplate){
			$('.manageB').html('<button type="button" class="btn manageBtn">관리</button>');
			
			$('.manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableTemplate').on('click', 'tr', function() {
				var data = tableTemplate.row(this).data();
				
				if (data != undefined){
					$(this).addClass('selected');
					$('#tableTemplate tr').not(this).removeClass('selected');
					
					// 관리 버튼 활성화
					var html = '';
					
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown">관리</button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" id="updateTemplate">템플릿 정보 변경</a>';
					html += '</div>';
					
					$('.manageB').empty().append(html);
					
					$('#updateTemplate').off('click').on('click', function() {
						updateTemplate(data);
					});
				}
			});
		}
		
		// 변경 모달 설정
		function updateTemplate(data) {
			$('#templateModal_template').val(data.vmName);
			$('#templateModal_vCPU').val(data.vmCPU);
			$('#templateModal_memory').val(data.vmMemory);
			$('#templateModal_os').val(data.vmOS);
			$('#templateModal_disk').val(data.vmDisk);
			$('#templateModal_description').val(data.description);
			
			if (data.templateOnoff == 0) {
				$('input[name="templateModal_useTemplate"][value="0"]').prop('checked', true);

			} else if (data.templateOnoff == 1) {
				$('input[name="templateModal_useTemplate"][value="1"]').prop('checked', true);
			}
			
			$('.modal-title').html('\'' + data.vmName + '\' 템플릿 정보 변경');
			$('#templateBtn').attr('onclick', 'validationTemplate("' + data.vmID + '");');
			
			$('#templateModal').modal('show');
		}
		
		// 변경 체크
		function validationTemplate(id) {
			var useTemplate = $('input[name="templateModal_useTemplate"]:checked').val();
			var description = $('#templateModal_description').val();
			
			$.ajax({
				url: '/config/updateVMTemplate.do',
				type: 'POST',
				data: {
					vmID: id,
					templateOnoff: useTemplate,
					description: description
				},
				success: function(data) {
					
					// 변경 성공
					if (data == 1) {
						alert('템플릿 변경이 완료되었습니다.');
						location.reload();
					
					// 변경 실패
					} else {
						alert('템플릿 변경에 실패했습니다.');
						return false;
					}
				}
			})
		}
	</script>
</body>

</html>