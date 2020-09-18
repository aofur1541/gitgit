<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>

	<link href="${path}/resource/css/license.css" rel="stylesheet" type="text/css">
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">

		<!-- 본문 시작 -->
		<div class="content d-none">
		
			<!-- 필터 -->
			<div class="card Inquire-card">
				<div class="row">
					<div class="col-xl-2">
						<div class="input-group select-group">
							<div class="input-group-prepend"><span class="input-group-text">주기</span></div>
							<select class="form-control" id="selectCycle">
								<option value="Month">30일</option>
								<option value="Year" selected>1년</option>
							</select>
						</div>
					</div>
				</div>
			</div>
		
			<!-- 라이선스 테이블 -->
			<table id="tableLicense" class="cell-border hover" style="width: 100%;">
				<thead>
					<tr>
						<th>라이선스 키</th>
						<th>기간</th>
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
			var access = prompt('비밀번호를 입력해 주세요.');
			
			if (access == 'VMware1!') {
				$('.content').removeClass('d-none');
				getLicenseList();
			
			} else {
				alert('접근 권한이 없습니다.');
				location.href = '/dash/dashboard.prom';
			}
		});
		
		// 라이선스 목록
		function getLicenseList() {
			var tableLicense = $('#tableLicense').addClass('nowrap').DataTable({
				dom: "<'datatables-header'<'createB'>B>" + "<'datatables-body'rt>" + "<'datatables-footer'ifp>",
				ajax: {
					url: "/support/selectLicenseList.do",
					type: "POST",
					dataSrc: ""
				},
				columns: [
					{data: "sSerialKey", render: function(data, type, row) {
						if (row.sSerialuseCheck == 1) {
							data = '<span class="text-muted">' + data.substring(0, 8) + '-' + data.substring(8, 12) + '-' + data.substring(12, 16) + '-' + data.substring(16, 20) + '-' + data.substring(20, 32) + '</span>';
						
						} else if (row.sSerialuseCheck == 0) {
							data = data.substring(0, 8) + '-' + data.substring(8, 12) + '-' + data.substring(12, 16) + '-' + data.substring(16, 20) + '-' + data.substring(20, 32);
						}
						
						return data;
					}},
					{data: "sSerialCategory", render: function(data, type, row) {
						data = data == 'Month' ? '30일' : '1년';
						
						if (row.sSerialuseCheck == 1) {
							data = '<span class="text-muted">' + data + '</span>';
						
						} else if (row.sSerialuseCheck == 0) {
							data = data;
						}
						
						return data;
					}},
					{data: "sSerialuseCheck", render: function(data, type, row) {
						if (data == 1) {
							data = '<span class="text-muted">사용</span>';
						
						} else if (data == 0) {
							data = '미사용';
						}
						
						return data;
					}}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1],	 ['10', '25', '50', '전체']],
				buttons: [{
					extend: "collection",
					text: "내보내기",
					className: "btn exportBtn",
					buttons: [{
							extend: "csvHtml5",
							charset: "UTF-8",
							bom: true,
							text: "CSV",
							title: "라이선스 목록"
						}, {
							extend: "excelHtml5",
							text: "Excel",
							title: "라이선스 목록"
						}
					]
				}, {
					extend: "pageLength",
					className: "btn pageLengthBtn",
				}, {
					extend: 'colvis',
					text: '테이블 편집',
					className: 'btn colvisBtn'
				}]
			});
			tableLicenseButton(tableLicense);
		}
		
		function tableLicenseButton(tableLicense) {
			$('.createB').html('<button type="button" class="btn createBtn" onclick="createLicense()">라이선스 생성</button>');
		}
	
		function createLicense() {
			var cycle = $("#selectCycle option:selected").val();
			
			$.ajax({
				url: "/support/insertLicense.do",
				data: {
					sSerialCategory: cycle
				},
				success: function(data) {
					
					// 생성 성공
					if (data == 1) {
						alert('라이선스 생성이 완료되었습니다.');
						location.reload();
					
					// 생성 실패
					} else {
						alert('라이선스 생성에 실패했습니다.');
						return false;
					}
				}
			})
		}
	</script>
</body>

</html>