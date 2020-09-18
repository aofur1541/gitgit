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
		
			<!-- 카탈로그 모달 -->
			<div class="modal fade" id="catalogModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<span class="modal-title">카탈로그 등록</span>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							<div class="modal-card">
								<label>카탈로그 <span class="text-danger">*</span></label>
								<input type="text" class="form-control" placeholder="카탈로그 이름" autocomplete="off" maxlength="30" id="catalogModal_catalog">
								<div class="row">
									<div class="col-6">
										<label>vCPU <span class="text-danger">*</span></label>
										<input type="number" class="form-control mb-0" placeholder="vCPU" autocomplete="off" min="1" max="32" id="catalogModal_vCPU">
									</div>
									<div class="col-6">
										<label>Memory <span class="text-danger">*</span></label>
										<input type="number" class="form-control mb-0" placeholder="Memory" autocomplete="off" min="1" max="32" id="catalogModal_memory">
									</div>
								</div>
							</div>
							<div class="modal-card">
								<label>설명</label>
								<input type="text" class="form-control mb-0" placeholder="카탈로그 설명" autocomplete="off" maxlength="40" id="catalogModal_description">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn" id="catalogBtn">등록</button>
							<button type="button" class="btn cancelBtn" data-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 카탈로그 테이블 -->
			<table id="tableCatalog" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>카탈로그</th>
						<th>vCPU</th>
						<th>Memory</th>
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
			getCatalogList();
		});
		
		// 카탈로그 테이블
		function getCatalogList() {
			var tableCatalog = $('#tableCatalog').addClass('nowrap').DataTable({
				dom: '<"datatables-header"<"createB"><"manageB">B>' + '<"datatables-body"rt>' + '<"datatables-footer"ifp>',
				ajax: {
					url: '/config/selectFlavorList.do',
					type: 'POST',
					dataSrc: ''
				},
				columns: [
					{data: 'name'},
					{data: 'vCPU'},
					{data: 'memory', render: function(data, type, row) {
						data = data + ' GB';
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
						title: '카탈로그 정보'
					}, {
						extend: 'excelHtml5',
						text: 'Excel',
						title: '카탈로그 정보'
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
			
			tableCatalogButton(tableCatalog);
		}
		
		// 관리 버튼 설정
		function tableCatalogButton(tableCatalog) {
			$('.createB').html('<button type="button" class="btn createBtn" onclick="insertCatalog()">등록</button>');
			$('.manageB').html('<button type="button" class="btn manageBtn">관리</button>');
			
			$('.manageBtn').off('click').on('click', function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableCatalog').on('click', 'tr', function() {
				var data = tableCatalog.row(this).data();
				
				if (data != undefined){
					$(this).addClass('selected');
					$('#tableCatalog tr').not(this).removeClass('selected');
					
					// 관리 버튼 활성화
					var html = '';
					
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown">관리</button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" id="updateCatalog">카탈로그 정보 변경</a>';
					html += '<a href="#" class="dropdown-item" id="deleteCatalog">카탈로그 삭제</a>';
					html += '</div>';
					
					$('.manageB').empty().append(html);
					
					$('#updateCatalog').off('click').on('click', function() {
						updateCatalog(data);
					});
					
					$('#deleteCatalog').off('click').on('click', function() {
						deleteCatalog(data);
					});
				}
			});
		}
		
		// 등록/변경 모달 값 초기화
		function clearModal() {

			// 값 초기화
			$('#catalogModal_catalog').val('').attr('disabled', false);
			$('#catalogModal_vCPU').val('');
			$('#catalogModal_memory').val('');
			$('#catalogModal_description').val('');
		}
		
		// 등록 모달 설정
		function insertCatalog() {
			
			// 모달 초기화
			clearModal();

			$('.modal-title').html('카탈로그 등록');
			$('#catalogBtn').html('등록');
			$('#catalogBtn').attr('onclick', 'validationCatalog("create");');
			
			$('#catalogModal').modal('show');
			
			// 등록 창 열리면 첫번째 폼 포커스
			$('#catalogModal').on('shown.bs.modal', function () {
				$('#catalogModal_catalog').focus();
			})
		}
		
		// 변경 모달 설정
		function updateCatalog(data) {
			$('#catalogModal_catalog').val(data.name);
			if (data.name == 'Tiny' || data.name == 'Small' || data.name == 'Middle' || data.name == 'Large' || data.name == 'Custom') {
				$('#catalogModal_catalog').attr('disabled', true);
			}
			
			$('#catalogModal_vCPU').val(data.vCPU);
			$('#catalogModal_memory').val(data.memory);
			$('#catalogModal_description').val(data.description);
	
			$('.modal-title').html('\'' + data.name + '\' 카탈로그 정보 변경');
			$('#catalogBtn').html('변경');
			$('#catalogBtn').attr('onclick', 'validationCatalog("update", "' + data.id + '")');
			
			$('#catalogModal').modal('show');
		}
		
		// 유효성 검사
		function validationCatalog(category, id) {
			var catalog = $('#catalogModal_catalog').val();
			var vCPU = $('#catalogModal_vCPU').val();
			var memory = $('#catalogModal_memory').val();
			var description = $('#catalogModal_description').val();
			
			// 이름 체크
			if (!catalog) {
				alert('카탈로그 이름을 입력해 주세요.');
				$('#catalogModal_catalog').focus();
				return false;
			}
			
			if (pattern_blank.test(catalog)) {
				alert('이름에 공백은 사용할 수 없습니다. 다시 입력해 주세요.');
				$('#catalogModal_catalog').focus();
				return false;
			}
			
			if (pattern_spc.test(catalog)) {
				alert('이름에 특수문자는 사용할 수 없습니다. 다시 입력해 주세요.');
				$('#catalogModal_catalog').focus();
				return false;
			}
			
			// vCPU 체크
			if (!vCPU) {
				alert('vCPU 값을 입력해 주세요.');
				$('#catalogModal_vCPU').focus();
				return false;
			}
			
			if (vCPU > 32 || vCPU < 1) {
				alert('vCPU는 최소 1 개, 최대 32 개까지 입력할 수 있습니다. 다시 입력해 주세요.');
				$('#catalogModal_vCPU').focus();
				return false;
			}
			
			// memory 체크
			if (!memory) {
				alert('Memory 값을 입력해 주세요.');
				$('#catalogModal_memory').focus();
				return false;
			}
			
			if (memory > 64 || memory < 1) {
				alert('Memory는 최소 1 GB, 최대 64 GB까지 입력할 수 있습니다. 다시 입력해 주세요.');
				$('#catalogModal_memory').focus();
				return false;
			}
			
			// 등록
			if (category == 'create' && !id) {
				$.ajax({
					url: "/config/insertFlavor.do",
					type: "POST",
					data: {
						name: catalog,
						vCPU: vCPU,
						memory: memory,
						description: description
					},
					success: function(data) {
						
						// 등록 성공
						if (data == 1) {
							alert('카탈로그 등록이 완료되었습니다.');
							location.reload();
						
						// 등록 실패
						} else if (data == 2) {
							alert('동일한 카탈로그 이름이 있습니다. 다시 입력해 주세요.');
							$('#catalogModal_catalog').focus();
							return false;
						
						} else {
							alert('카탈로그 등록에 실패했습니다.');
							return false;
						}
					}
				})
			}
			
			// 변경
			if (category == 'update' && id) {
				$.ajax({
					url: "/config/updateFlavor.do",
					type: "POST",
					data: {
						id: id,
						name: catalog,
						vCPU: vCPU,
						memory: memory,
						description: description
					},
					success: function(data) {
						
						// 변경 성공
						if (data == 1) {
							alert('카탈로그 변경이 완료되었습니다.');
							location.reload();
						
						// 변경 실패
						} else if (data == 2) {
							alert('동일한 카탈로그 이름이 있습니다. 다시 입력해 주세요.');
							$('#catalogModal_catalog').focus();
							return false;
						
						} else {
							alert('카탈로그 변경에 실패했습니다.');
							return false;
						}
					}
				})
			}
		}
		
		// 카탈로그 삭제
		function deleteCatalog(data) {
			
			// 삭제 확인
			if (confirm('\'' + data.name + '\' 카탈로그를 삭제하시겠습니까?') == true) {
				$.ajax({
					url: '/config/deleteFlavor.do',
					type: 'POST',
					data: {
						id: data.id,
						name: data.name
					},
					success: function(data) {
						
						// 삭제 성공
						if (data == 1) {
							alert('카탈로그 삭제가 완료되었습니다.');
							location.reload();

						// 삭제 실패
						} else {
							alert('카탈로그 삭제에 실패했습니다.');
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