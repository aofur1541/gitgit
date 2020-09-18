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
			
			<!-- auto scale up 테이블 -->
			<table id="tableAutoScaleUp" class="cell-border hover" style="width: 100%">
				<thead>
					<tr>
						<th rowspan="2">서비스</th>
						<th colspan="2" class="text-center">Up 임계치</th>
						<th colspan="2" class="text-center">Up 단위</th>
						<th rowspan="2">사용</th>
					</tr>
					<tr>
						<th>CPU (%)</th>
						<th>Memory (%)</th>
						<th>vCPU</th>
						<th style="border-right: 1px solid #E0E0E0;">Memory (GB)</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			getAutoScaleUpList();
		});
		
		// auto scale up 테이블
		function getAutoScaleUpList() {
			var tableAutoScaleUp = $('#tableAutoScaleUp').addClass('nowrap').DataTable({
				dom: "<'datatables-header'<'createB'><'manageB'>B>" + "<'datatables-body'rt>" + "<'datatables-footer'ifp>",
				ajax: {
					url: "/environ/getAutoScaleUpList.do",
					type: "POST",
					dataSrc: ""
				},
				columns: [
					{data: "service_ids"},
					{data: "cpuUp", render: function(data, type, row) {
						data = data + ' %';
						
						return data;
					}},
					{data: "memoryUp", render: function(data, type, row) {
						data = data + ' %';
						
						return data;
					}},
					{data: "cpuAdd"},
					{data: "memoryAdd"},
					{data: "isUse", render: function(data, type, row) {
						if (data == 1) {
							data = '<span class="text-on">ON</span>';
						
						} else if (data == 0) {
							data = '<span class="text-off">OFF</span>';
						}
						
						return data;
					}},
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
				buttons: [{
					extend: "collection",
					text: "<i class='fas fa-download'></i><span>내보내기</span>",
					className: "btn exportBtn",
					buttons: [{
							extend: "csvHtml5",
							charset: "UTF-8",
							bom: true,
							text: "CSV",
							title: "Auto Scale Up 정보"
						},
						{
							extend: "excelHtml5",
							text: "Excel",
							title: "Auto Scale Up 정보"
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
			
			tableAutoScaleUpButton(tableAutoScaleUp);
		}
		
		// 관리 버튼 설정
		function tableAutoScaleUpButton(tableAutoScaleUp){
			$('.createB').html('<button type="button" class="btn createBtn"><i class="fas fa-plus"></i><span>등록</span></button>');
			$('.manageB').html('<button type="button" class="btn manageBtn"><i class="fas fa-ellipsis-h"></i><span>관리</span></button>');
			
			$('.manageBtn').click(function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableAutoScaleUp').on('click', 'tr', function() {
				var data = tableAutoScaleUp.row(this).data();
				
				if (data != undefined){
					$(this).addClass('selected');
					$('#tableAutoScaleUp tr').not(this).removeClass('selected');
					
					// 관리 버튼 활성화
					var html = '';
					
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown"><i class="fas fa-ellipsis-h"></i><span>관리</span></button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item">Auto Scale Up 정보 변경</a>';
					html += '<a href="#" class="dropdown-item">Auto Scale Up 삭제</a>';
					html += '<a href="#" class="dropdown-item">Auto Scale Up 사용</a>';
					html += '</div>';
					
					$('.manageB').empty().append(html);
				}
			});
		}
	</script>
</body>

</html>