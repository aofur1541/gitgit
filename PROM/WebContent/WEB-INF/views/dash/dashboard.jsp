<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>

	<script type="text/javascript" src="${path}/resource/plugin/jQuery-ScrollTabs-2.0.0/jquery.mousewheel.js"></script>
	<script type="text/javascript" src="${path}/resource/plugin/jQuery-ScrollTabs-2.0.0/jquery.scrolltabs.js"></script>
	<link href="${path}/resource/plugin/jQuery-ScrollTabs-2.0.0/scrolltabs.css" rel="stylesheet" type="text/css">

	<!-- 대시보드 새로고침 -->
	<meta http-equiv="Refresh" content="">
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">

		<!-- 본문 시작 -->
		<div class="content">

			<!-- 위젯 리스트 카드 -->
			<button type="button" class="btn widgetList-toggle" id="widgetListToggle"><i class="fas fa-cog"></i></button>

			<div class="card widgetList-card">
				<ul class="widget-list" id="integrateWidgetList">
					<li class="list-title">통합 데이터센터 현황</li>
					<li id="allCount_list"><span class="widget-title">통합 운영 현황</span></li>
					<li id="vCenterAlert_list"><span class="widget-title">vCenter 통합 알림</span></li>
					<li id="nsxtCluster_list"><span class="widget-title">NSX-T 클러스터</span></li>
					<li id="allResourceVMs_list"><span class="widget-title">가상머신 할당 현황</span></li>
					<li id="allResourcePhysics_list"><span class="widget-title">물리 할당 현황</span></li>
				</ul>
				<ul class="widget-list" id="clusterWidgetList">
					<li class="list-title">클러스터별 현황</li>
					<li id="status_list"><span class="widget-title">운영 현황</span></li>
					<li id="clusterResourceVMs_list"><span class="widget-title">가상머신 할당 현황</span></li>
					<li id="clusterResourcePhysics_list"><span class="widget-title">물리 자원 현황</span></li>
					<li id="vmRank_list"><span class="widget-title">가상머신 TOP 5</span></li>
					<li id="hostRank_list"><span class="widget-title">호스트 TOP 5</span></li>
					<li id="usage_list"><span class="widget-title">평균 사용량</span></li>
				</ul>
				<div class="widgetListButtonGroup">
					<button type="button" class="btn" id="saveDashboard">대시보드 저장</button>
				</div>
			</div>

			<div class="row" style="margin-right: -15px; margin-left: -15px;">
				<div class="col-xl-3 col-sm-12" id="integrateWidgetContainer">
					<div class="integrateWidgetTitle">
						통합 데이터센터 현황
					</div>

					<!-- 통합 위젯 카드 -->
					<div class="row" id="integrateWidgetWrapper">
						<div class="col-xl-12 col-sm-6 d-none" id="allCount_widget">
							<div class="card widget-card">
								<div class="card-header">통합 운영 현황</div>
								<div class="card-body widget001">
									<div class="row h-100">
										<div class="col-6">
											<div class="row">
												<div class="col-6"><span>클러스터</span><b id="cluAll">0</b></div>
												<div class="col-6"><span>호스트</span><b id="hostAll">0</b></div>
											</div>
											<div class="row">
												<div class="col-6"><span>가상머신</span><b id="vmAll">0</b></div>
												<div class="col-6"><span>템플릿</span><b id="templateAll">0</b></div>
											</div>
										</div>
										<div class="col-6">
											<div class="row">
												<div class="col-6"><span>서비스 그룹</span><b id="tenAll">0</b></div>
												<div class="col-6"><span>서비스</span><b id="serviceAll">0</b></div>
											</div>
											<div class="row">
												<div class="col-6"><span>부서</span><b id="deptAll">0</b></div>
												<div class="col-6"><span>사용자</span><b id="userAll">0</b></div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-12 col-sm-6 d-none" id="vCenterAlert_widget">
							<div class="card widget-card">
								<div class="card-header">vCenter 통합 알림</div>
								<div class="card-body widget004">
									<div class="table-body">
										<table id="tablevCenterLog" class="cell-border hover" style="width: 100%;">
											<tbody></tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-12 col-sm-6 d-none" id="nsxtCluster_widget">
							<div class="card widget-card">
								<div class="card-header">NSX-T 클러스터</div>
								<div class="card-body widget004">
									<ul id="clusterStatusList">
										<li>Control Cluster: <span class="text-on">정상</span></li>
										<li>Mgmt Cluster: <span class="text-off">비정상</span></li>
									</ul>
									<div class="table-body">
										<table id="tableNode" class="cell-border hover" style="width: 100%;">
											<thead></thead>
											<tbody></tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-12 col-sm-6 d-none" id="allResourceVMs_widget">
							<div class="card widget-card">
								<div class="card-header">가상머신 할당 현황</div>
								<div class="card-body widget002">
									<ul>
										<li><span>vCPU</span><div></div><div><h5 id="sumCPUVM">0</h5>EA</div></li>
										<li><span>Memory</span><div></div><div><h5 id="sumMemoryVM">0</h5>GB</div></li>
										<li><span>데이터스토어</span><div></div><div><h5 id="sumDiskVM">0</h5>TB</div></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="col-xl-12 col-sm-6 d-none" id="allResourcePhysics_widget">
							<div class="card widget-card">
								<div class="card-header">물리 할당 현황</div>
								<div class="card-body widget002">
									<ul>
										<li><span>Core</span><div></div><div><h5 id="sumCPU">0</h5>개</div></li>
										<li><span>Memory</span><div></div><div><h5 id="sumMemory">0</h5>GB</div></li>
										<li><span>Storage</span><div></div><div><h5 id="all">0</h5>TB</div></li>
										<li><span>여유 Storage</span><div></div><div><h5 id="space">0</h5>TB</div></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-xl-9" id="clusterWidgetContainer">

					<!-- 클러스터별 탭 -->
					<div class="row" id="clusterTabRow">
						<div class="col-9">
							<ul id="clusterTab" class="scroll-tab">
								<li>클러스터탭</li>
							</ul>
						</div>
						<div class="col-3">
							<button class="btn autoRolling-toggle" id="autoRollingToggle">자동 롤링 <b><span class="spinner-border spinner-border-sm mr-2" role="status"></span></b></button>
						</div>
					</div>

					<!-- 클러스터별 위젯 카드 -->
					<div class="row" id="clusterWidgetWrapper">
						<div class="col-xl-4 col-sm-12 d-none" id="status_widget">
							<div class="card widget-card widgetGroup-card">
								<div class="card-header">운영 현황</div>
								<div class="card-body widget003">
									<div class="row h-100">
										<div class="col-4">
											<span>가상머신</span>
											<div><h5 id="vmStatus"><b>0</b> / 0</h5><div>VMs</div></div>
										</div>
										<div class="col-4">
											<span>호스트</span>
											<div><h5 id="hostStatus"><b>0</b> / 0</h5><div>Hosts</div></div>
										</div>
										<div class="col-4">
											<span>데이터스토어</span>
											<div><h5 id="datastoreStatus"><b>0</b> / 0</h5><div>TB</div></div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-4 col-sm-6 d-none" id="clusterResourceVMs_widget">
							<div class="card widget-card">
								<div class="card-header">
									<div class="card-header-title">가상머신 할당 현황</div>
								</div>
								<div class="card-body widget002">
									<ul>
										<li><span>vCPU</span><div></div><div><h5 id="sumCPUVMCluster">0</h5>개</div></li>
										<li><span>Memory</span><div></div><div><h5 id="sumMemoryVMCluster">0</h5>GB</div></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="col-xl-4 col-sm-6 d-none" id="clusterResourcePhysics_widget">
							<div class="card widget-card">
								<div class="card-header">물리 자원 현황</div>
								<div class="card-body widget002">
									<ul>
										<li><span>Core</span><div></div><div><h5 id="sumCPUCluster">0</h5>개</div></li>
										<li><span>Memory</span><div></div><div><h5 id="sumMemoryCluster">0</h5>GB</div></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="col-xl-4 col-sm-6 d-none" id="vmRank_widget">
							<div class="card widget-card">
								<div class="card-header">가상머신 TOP 5
									<div class="btn-group btn-group-toggle" data-toggle="buttons">
										<label class="btn"><input type="radio" name="vmRankBtn" value="cpu">CPU</label>
										<label class="btn"><input type="radio" name="vmRankBtn" value="memory">Memory</label>
									</div>
								</div>
								<div class="card-body" style="padding-bottom: 0;">
									<div class="chart" id="vmRank"></div>
								</div>
								<div class="card-footer">
									<div class="chartTimeDiv" id="vmRankTime">0000-00-00 00:00:00</div>
								</div>
							</div>
						</div>
						<div class="col-xl-4 col-sm-6 d-none" id="hostRank_widget">
							<div class="card widget-card">
								<div class="card-header">호스트 TOP 5
									<div class="btn-group btn-group-toggle" data-toggle="buttons">
										<label class="btn"><input type="radio" name="hostRankBtn" value="cpu">CPU</label>
										<label class="btn"><input type="radio" name="hostRankBtn" value="memory">Memory</label>
									</div>
								</div>
								<div class="card-body" style="padding-bottom: 0;">
									<div class="chart" id="hostRank"></div>
								</div>
								<div class="card-footer">
									<div class="chartTimeDiv" id="hostRankTime">0000-00-00 00:00:00</div>
								</div>
							</div>
						</div>
						<div class="col-xl-8 col-sm-12 d-none" id="usage_widget">
							<div class="card widget-card widgetGroup-card">
								<div class="card-header">평균 사용량</div>
								<div class="card-body">
									<div class="row-padding-0 h-100">
										<div class="col-6">
											<div class="row-padding-0 h-100">
												<div class="col-4 chartTitleDiv">CPU 사용량</div>
												<div class="col-4">
													<div class="chart" id="cpuUsage"></div>
												</div>
												<div class="col-4 chartTimeDiv usageTime">0000-00-00 00:00:00</div>
											</div>
										</div>
										<div class="col-6">
											<div class="row-padding-0 h-100">
												<div class="col-4 chartTitleDiv">Memory 사용량</div>
												<div class="col-4">
													<div class="chart" id="memoryUsage"></div>
												</div>
												<div class="col-4 chartTimeDiv usageTime">0000-00-00 00:00:00</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		var global_integrateWidgetList = [];
		var global_clusterWidgetList = [];
		var global_integrateWidgetOrder = [];
		var global_clusterWidgetOrder = [];

		$(document).ready(function() {

			// 대시보드 새로고침
			refreshDashboard();

			// 위젯
			widgetList();
			widgetOrder();

			// 위젯 리스트 카드 설정
			$('#widgetListToggle').off('click').on('click', function() {
				$('.card.widgetList-card').toggleClass('active');
				$('.card.widgetList-card').hasClass('active') ? $('.card.widgetList-card').animate({width: '225px'}) : $('.card.widgetList-card').animate({width: '0'});
			});

			// 대시보드 저장
			$('#saveDashboard').off('click').on('click', function() {
				
				// @박한수
				// global_integrateWidgetList, global_clusterWidgetList 값 중 하나가 빈 값일 때 저장 실행이 안됨
				// 위젯 리스트 저장
				$.ajax({
					url: '/dash/saveWidgetCustomization.do',
					type: 'POST',
					data: {
						integrateWidgetList: global_integrateWidgetList,
						clusterWidgetListId: global_clusterWidgetList
					}
				});

				// 위젯 순서 저장
				$.ajax({
					url: '/dash/saveWidgetOrderCustomization.do',
					type: 'POST',
					data: {
						integrateWidgetOrder: global_integrateWidgetOrder,
						clusterWidgetOrder: global_clusterWidgetOrder
					}
				});
			});
		});

		// 대시보드 새로고침 주기
		function refreshDashboard() {
			$.ajax({
				url: '/config/selectBasic.do',
				type: 'POST',
				data: {
					targetName: 'reflashInterval'
				},
				success: function(data) {

					// 기본 새로고침 주기는 20초
					if (data == null || data == '') {
						$('meta[http-equiv="Refresh"]').attr('content', 20);

					// [인프라 관리>기본 기능]에서 설정한 대시보드 새로고침 주기 값
					} else {
						$('meta[http-equiv="Refresh"]').attr('content', data.value);
					}
				}
			});
		}

		// 위젯 리스트
		function widgetList() {

			// 위젯 리스트 업데이트
			updateWidgetList();

			// 통합 위젯 리스트 선택
			$('#integrateWidgetList li:not(.list-title)').off('click').on('click', function() {

				// active 클래스 추가/삭제 (토글)
				$(this).toggleClass('active');

				// 해당 리스트가 active 클래스를 가졌을 때
				// 통합 위젯 Show/Hide 업데이트, 위젯 데이터 실행
				var widget = $('#' + $(this).attr('id').replace('_list', '_widget'));

				if ($(this).hasClass('active')) {
					widget.removeClass('d-none');
					integrateData($(this).attr('id'));

				} else {
					widget.addClass('d-none');
				}

				// 통합 위젯 크기
				integrateWidgetSizeCheck();

				// 통합 위젯 리스트 저장
				global_integrateWidgetList = [];
				$($('#integrateWidgetList li.active')).each(function(index, item) {
					global_integrateWidgetList.push($(item).attr('id'));
				});
			});

			// 클러스터 위젯 리스트 선택
			$('#clusterWidgetList li:not(.list-title)').off('click').on('click', function() {

				// active 클래스 추가/삭제 (토글)
				$(this).toggleClass('active');

				// 해당 리스트가 active 클래스를 가졌을 때
				// 클러스터 위젯 Show/Hide 업데이트, 위젯 데이터 실행, 위젯 리스트 탭 실행
				var widget = $('#' + $(this).attr('id').replace('_list', '_widget'));

				if ($(this).hasClass('active')) {
					widget.removeClass('d-none');
					clusterData($(this).attr('id'));
					getClusterList();

				} else {
					widget.addClass('d-none');
				}

				// 자동 롤링 OFF
				localStorage.setItem(sessionUserId + '_autoRolling', 'OFF');
				updateAutoRolling();

				// 클러스터 위젯 크기
				clusterWidgetSizeCheck();

				// 클러스터 위젯 리스트 저장
				global_clusterWidgetList = [];
				$($('#clusterWidgetList li.active')).each(function(index, item) {
					global_clusterWidgetList.push($(item).attr('id'));
				});
			});
		}

		// 위젯 리스트 업데이트
		function updateWidgetList() {
			$.ajax({
				url: '/dash/selectWidgetList.do',
				type: 'GET',
				async: false,
				success: function(data) {
					if(data.getIntegrateWidgetList != null || data.getClusterWidgetListId != null){
					// 통합 위젯 리스트가 있으면 업데이트 실행
					if (data.getIntegrateWidgetList != null) {
						var integrateWidgetList = data.getIntegrateWidgetList.split(',');
						global_integrateWidgetList = integrateWidgetList;
						
						$(integrateWidgetList).each(function(index, item) {
							$('#' + item).addClass('active');
							$('#' + item.replace('_list', '_widget')).removeClass('d-none');

							integrateData(item);
						});
					}

					// 클러스터 위젯 리스트가 있으면 업데이트 실행
					if (data.getClusterWidgetListId != null) {
						var clusterWidgetList = data.getClusterWidgetListId.split(',');
						global_clusterWidgetList = clusterWidgetList;

						$(clusterWidgetList).each(function(index, item) {
							$('#' + item).addClass('active');
							$('#' + item.replace('_list', '_widget')).removeClass('d-none');
						});

						getClusterList(clusterWidgetList);
						}
					}else{
						
					}
				}
			});

			// 위젯 크기
			integrateWidgetSizeCheck();
			clusterWidgetSizeCheck();
		}

		// 통합 위젯 크기
		function integrateWidgetSizeCheck() {
			if ($('#integrateWidgetList li.active').length == 0) {
				$('#integrateWidgetContainer').addClass('d-none');

				$('#clusterWidgetContainer').removeClass('col-xl-9').addClass('col-xl-12');
				$('#clusterWidgetContainer>#clusterWidgetWrapper>div.col-xl-4').removeClass('col-xl-4').addClass('col-xl-3');
				$('#clusterWidgetContainer>#clusterWidgetWrapper>div.col-xl-8').removeClass('col-xl-8').addClass('col-xl-6');

			} else {
				$('#integrateWidgetContainer').removeClass('d-none');

				$('#clusterWidgetContainer').removeClass('col-xl-12').addClass('col-xl-9');
				$('#clusterWidgetContainer>#clusterWidgetWrapper>div.col-xl-3').removeClass('col-xl-3').addClass('col-xl-4');
				$('#clusterWidgetContainer>#clusterWidgetWrapper>div.col-xl-6').removeClass('col-xl-6').addClass('col-xl-8');
			}
		}

		// 클러스터 위젯 크기
		function clusterWidgetSizeCheck() {
			if ($('#clusterWidgetList li.active').length == 0) {
				$('#clusterWidgetContainer').addClass('d-none');

				$('#integrateWidgetContainer').removeClass('col-xl-3').addClass('col-xl-12');
				$('#integrateWidgetContainer>#integrateWidgetWrapper>div').removeClass('col-xl-12').addClass('col-xl-3');

			} else {
				$('#clusterWidgetContainer').removeClass('d-none');

				$('#integrateWidgetContainer').removeClass('col-xl-12').addClass('col-xl-3');
				$('#integrateWidgetContainer>#integrateWidgetWrapper>div').removeClass('col-xl-3').addClass('col-xl-12');
			}
		}

		// 위젯 순서
		function widgetOrder() {

			// 위젯 순서 업데이트
			updateWidgetOrder();

			// 통합 위젯 드래그 앤 드랍
			$('#integrateWidgetWrapper').sortable({
				containment: '.content-wrapper',
				handle: '.card.widget-card>.card-header',
				update: function(event, ui) {

					// 통합 위젯 순서 저장
					global_integrateWidgetOrder = $('#integrateWidgetWrapper').sortable('toArray');
				}
			});

			// 클러스터 위젯 드래그 앤 드랍
			$('#clusterWidgetWrapper').sortable({
				containment: '.content-wrapper',
				handle: '.card.widget-card>.card-header',
				update: function(event, ui) {

					// 클러스터 위젯 순서 저장
					global_clusterWidgetOrder = $('#clusterWidgetWrapper').sortable('toArray');
				}
			});
		}

		// 위젯 순서 업데이트
		function updateWidgetOrder() {
			$.ajax({
				url: '/dash/selectWidgetOrderList.do',
				type: 'GET',
				async: false,
				success: function(data) {

					// 통합 위젯 순서가 있으면 업데이트 실행
					if (data.getIntegrateWidgetOrder !== null) {
						var integrateWidgetOrder = data.getIntegrateWidgetOrder.split(',');

						$(integrateWidgetOrder).each(function(index, item) {
							$('#integrateWidgetWrapper').append($('#integrateWidgetWrapper').find('#' + item));
						});
					}

					// 클러스터 위젯 순서가 있으면 업데이트 실행
					if (data.getclusterWidgetOrder !== null) {
						var clusterWidgetOrder = data.getclusterWidgetOrder.split(',');

						$(clusterWidgetOrder).each(function(index, item) {
							$('#clusterWidgetWrapper').append($('#clusterWidgetWrapper').find('#' + item));
						});
					}
				}
			});
		}

		// 통합 현황 데이터 실행
		function integrateData(widgetListId) {
			if (widgetListId == 'allCount_list') getAllCount();
			if (widgetListId == 'vCenterAlert_list') getvCenterLog();
			if (widgetListId == 'nsxtCluster_list') getNSXTClusterList();
			if (widgetListId == 'allResourceVMs_list') getAllResourceVMs();
			if (widgetListId == 'allResourcePhysics_list') getAllResourcePhysics();
		}

		// 통합 운영 현황
		function getAllCount() {
			$.ajax({
				url: '/dash/selectAllCountList.do',
				type: 'POST',
				success: function(data) {
					for (key in data) {
						$('#' + key).html(data[key]);
					}
				}
			});
		}

		// vCenter 통합 알림
		function getvCenterLog() {
			$.ajax({
				url: '/log/selectVCenterLogList.do',
				type: 'POST',
				success: function(data) {
					var html = '';

					if (data == null || data == '') {
						html += '<td colspan="5">데이터가 없습니다.</td>';

					} else {
						for (key in data) {
							html += '<tr>'
							
							if (data[key].sAlertColor == 'red') {
								html += '<td class="text-center"><i class="fas fa-exclamation-circle text-danger"></i></td>';

							} else if (data[key].sAlertColor == 'yellow') {
								html += '<td class="text-center"><i class="fas fa-exclamation-triangle text-caution"></i></td>';
							}

							html += '<td>' + data[key].sTarget + '</td>';
							html += '<td>' + data[key].sVcMessage + '</td>';
							html += '</tr>';
						}
					}

					$('#tablevCenterLog tbody').empty().append(html);
				}
			});
		}
		
		// NSX-T 클러스터
		function getNSXTClusterList() {
			$.ajax({
				url: '/dash/getNSXTClusterList.do',
				type: 'GET',
				success: function(data) {
					var list = '';
					var table = '';

					// 리스트 - Control Cluster
					list += '<li>Control Cluster: ';
					
					if (data[0].controlClusterStatus == 'STABLE') {
						list += '<span class="text-on">정상</span>'
					
					} else if (data[0].controlClusterStatus == 'unknown') {
						list += '<span class="text-off">연결 끊김</span>'
					
					} else {
						list += '<span class="text-off">비정상</span>'
					}
					list += '</li>';

					// 리스트 - Mgmt Cluster
					list += '<li>Mgmt Cluster: ';
					
					if (data[0].mgmtClusterStatusStaus == 'STABLE') {
						list += '<span class="text-on">정상</span>'
					
					} else if (data[0].mgmtClusterStatusStaus == 'unknown') {
						list += '<span class="text-off">연결 끊김</span>'
					
					} else {
						list += '<span class="text-off">비정상</span>'
					}
					
					list += '</li>';
					
					// 테이블
					for (key in data) {
						table += '<tr>'
						table += '<td>' + data[key].mgmtClusterListenIpAddress + '</td>';
						table += '<td>';
						table += data[0].status == 1 ? '<span class="text-on">정상</span>' : '<span class="text-off"> 비정상</span>'
						table += '</td>';
						table += '</tr>';
					}

					$('#clusterStatusList').empty().append(list);
					$('#tableNode tbody').empty().append(table);
				}
			});
		}

		// 가상머신 할당 현황
		function getAllResourceVMs() {
			$.ajax({
				url: '/dash/selectAllResourceVMs.do',
				type: 'POST',
				success: function(data) {
					for (key in data) {
						$('#' + key + 'VM').html(data[key]);

						if (key == 'sumDisk') {
							dataUnitTB = parseFloat(data[key]);
							dataUnitTB = (dataUnitTB / 1024).toFixed(1);

							$('#' + key + 'VM').html(dataUnitTB);
						}
					}
				}
			});
		}

		// 물리 자원 현황
		function getAllResourcePhysics() {
			$.ajax({
				url: '/dash/selectAllResourcePhysics.do',
				type: 'POST',
				success: function(data) {
					for (key in data) {
						$('#' + key).html(data[key]);

						if (key == 'all' || key == 'space') {
							dataUnitTB = parseFloat(data[key]);
							dataUnitTB = (dataUnitTB / 1024).toFixed(1);

							$('#' + key).html(dataUnitTB);
						}
					}
				}
			});
		}

		// 클러스터 리스트 탭
		function getClusterList(clusterWidgetList) {
			$.ajax({
				url: '/tenant/selectClusterList.do',
				type: 'POST',
				success: function(data) {
					var html = '';

					// 데이터 없을 때
					if (data == null || data == '') {
						html += '<li>클러스터가 없습니다.</li>';

						$('#clusterTab').empty().append(html).scrollTabs();

					// 데이터 있을 때
					} else {
						for (key in data) {
							html += '<li class="item' + key + '" id="' + data[key].clusterID + '">' + data[key].clusterName + '</li>';
						}

						$('#clusterTab').empty().append(html).scrollTabs();

						// 클러스터 리스트 탭 기능
						clusterTabOption();

						// 클러스터 리스트 탭 클릭
						$('#clusterTab li').on('click', function() {
							var clusterId = $(this).attr('id');

							// 클러스터 위젯 데이터 실행
							$($('#clusterWidgetList li.active')).each(function(index, item) {
								clusterData($(item).attr('id'), clusterId);
							});

							// 로컬 스토리지에 현재 활성화된 탭 아이디를 저장
							localStorage.setItem(sessionUserId + '_activeTab', $(this).attr('id'));
						});

						if (clusterWidgetList) {
							var clusterId = localStorage.getItem(sessionUserId + '_activeTab');
							clusterId = !clusterId ? $('#clusterTab li:first-child').attr('id') : clusterId;

							// 클러스터 위젯 데이터 실행
							$(clusterWidgetList).each(function(index, item) {
								clusterData(item, clusterId);
							});
						}
					}
				}
			});
		}

		// 클러스터별 현황 데이터 실행
		function clusterData(widgetListId, clusterId) {
			if (widgetListId == 'clusterResourceVMs_list') getClusterResourceVMs(clusterId);
			if (widgetListId == 'clusterResourcePhysics_list') getClusterResourcePhysics(clusterId);
			if (widgetListId == 'status_list') {
				getVMStatus(clusterId);
				getHostStatus(clusterId);
				getDatastoreStatus(clusterId);
			}
			if (widgetListId == 'vmRank_list') {
				$('input[name="vmRankBtn"][value="cpu"]').click();
				$('input[name="vmRankBtn"]').change(function() {
					getVMRank(clusterId, $('input[name="vmRankBtn"]:checked').val());
				});

				getVMRank(clusterId, 'cpu');
			}
			if (widgetListId == 'hostRank_list') {
				$('input[name="hostRankBtn"][value="cpu"]').click();
				$('input[name="hostRankBtn"]').change(function() {
					getHostRank(clusterId, $('input[name="hostRankBtn"]:checked').val());
				});

				getHostRank(clusterId, 'cpu');
			}
			if (widgetListId == 'usage_list') getUsage(clusterId);
		}

		// 클러스터별 가상머신 할당 현황
		function getClusterResourceVMs(clusterId) {
			$.ajax({
				url: '/dash/selectClusterResourceVMs.do',
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					for (key in data) {
						$('#' + key + 'VMCluster').html(data[key]);
					}
				}
			});
		}

		// 클러스터별 물리 자원 현황
		function getClusterResourcePhysics(clusterId) {
			$.ajax({
				url: '/dash/selectClusterResourcePhysics.do',
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					for (key in data) {
						$('#' + key + 'Cluster').html(data[key]);
					}
				}
			});
		}

		// 운영 현황 - 가상머신
		function getVMStatus(clusterId) {
			$.ajax({
				url: '/dash/selectVMState.do',
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					if (data != null || data != '') {
						var allVM = 0;

						allVM = parseFloat(data.vmPowerOn + data.vmPowerOff);
						$('#vmStatus').html('<h5><b>' + data.vmPowerOn + '</b> / ' + allVM + '</h5>');
					}
				}
			});
		}

		// 운영 현황 - 호스트
		function getHostStatus(clusterId) {
			$.ajax({
				url: '/dash/selectHostsState.do',
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					if (data != null || data != '') {
						$('#hostStatus').html('<h5><b>' + data.powerOn + '</b> / ' + data.allCtn + '</h5>');
					}
				}
			});
		}

		// 운영 현황 - 데이터스토어
		function getDatastoreStatus(clusterId) {
			$.ajax({
				url: '/dash/selectDataStoreState.do',
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					if (data != null || data != '') {
						var allDatastore = 0;
						var useDatastore = 0;

						for (key in data) {
							allDatastore += parseFloat(data[key].stAllca);
							useDatastore += parseFloat(data[key].stUseca);
						}

						allDatastore = (allDatastore / 1024).toFixed(1);
						useDatastore = (useDatastore / 1024).toFixed(1);

						$('#datastoreStatus').html('<h5><b>' + useDatastore + '</b> / ' + allDatastore + '</h5>');
					}
				}
			});
		}

		// 가상머신 TOP 5
		function getVMRank(clusterId, orderKey) {
			$.ajax({
				url: '/dash/selectVMPerformanceTop5List.do',
				type: 'POST',
				data: {
					clusterId: clusterId,
					order: orderKey
				},
				success: function(data) {

					// 가상머신 차트
					var chart = echarts.init($('#vmRank')[0]);
					var option = {
						tooltip: {
							trigger: 'axis',
							backgroundColor: 'transparent',
							formatter: function(params) {
								var html = '';

								html += '<div class="card card-tooltip">';
								html += '<div class="card-header">' + params[0].name + '</div>';
								html += '<div class="card-body">';
								html += '<div>' + params[0].marker + params[0].seriesName + ' : ' + params[0].value + ' %</div>';
								html += '<div>' + params[1].marker + params[1].seriesName + ' : ' + params[1].value + ' %</div>';
								html += '</div>';
								html += '</div>';

								return html;
							}
						},
						// 그리드 설정
						grid: {top: '2', left: '2', right: '2', bottom: '2', containLabel: true},
						// x축 설정 (cpu/memory 값)
						xAxis: {
							type: 'value',
							min: 0,
							max: 100,
							splitNumber: 10,
							axisTick: {show: false},
							axisLine: {lineStyle: {color: '#E0E0E0'}},
							axisLabel: {color: '#212121', align: 'right', fontSize: 10},
							splitLine: {lineStyle: {color: '#E0E0E0'}}
						},
						// y축 설정 (가상머신 이름)
						yAxis: {
							type: 'category',
							axisTick: {show: false},
							axisLine: {lineStyle: {color: '#E0E0E0'}},
							axisLabel: {color: '#212121', fontSize: 10},
							data: []
						},
						// cpu/memory 타입 bar 설정
						series: [
							{type: 'bar', barWidth: '8', data: []},
							{type: 'bar', barWidth: '2', barGap: 0, data: []}
						]
					}

					// 데이터 없을 때
					if (data == null || data == '') {
						$('input[name="vmRankBtn"]').parent().addClass('disabled');
						var vmRankTime = '데이터가 없습니다.';

						option.series[0].data[0] = 0;
						option.series[1].data[0] = 0;

					// 데이터 있을 때
					} else {
						$('input[name="vmRankBtn"]').parent().removeClass('disabled');

						data.reverse();

						for (key in data) {
							option.yAxis.data[key] = data[key].vmName;

							// cpu일 때
							if (orderKey == 'cpu') {
								option.series[0].name = 'CPU';
								option.series[0].color = '#F06A6A';
								option.series[0].data[key] = data[key].cpu;

								option.series[1].name = 'Memory';
								option.series[1].color = '#20CCDE';
								option.series[1].data[key] = data[key].memory;
							}

							// memory일 때
							if (orderKey == 'memory') {
								option.series[0].name = 'Memory';
								option.series[0].color = '#20CCDE';
								option.series[0].data[key] = data[key].memory;

								option.series[1].name = 'CPU';
								option.series[1].color = '#F06A6A';
								option.series[1].data[key] = data[key].cpu;
							}
						}
						var vmRankTime = data[0].dispTimestamp;
					}

					// 다크 모드 차트 컬러 변경
					updateRankChartColor(option);

					$('#colorControl').on('click', function() {
						updateRankChartColor(option);

						chart.setOption(option, true);
					});

					// 차트 옵션 저장
					chart.setOption(option, true);
					chart.resize();

					$('#vmRankTime').html(vmRankTime);

					// 차트 크기 조정
					$(window).resize(function() {
						chart.resize();
					});
				}
			});
		}

		// 호스트 TOP 5
		function getHostRank(clusterId, orderKey) {
			$.ajax({
				url: '/dash/selectHostPerformanceTop5List.do',
				type: 'POST',
				data: {
					clusterId: clusterId,
					order: orderKey
				},
				success: function(data) {

					// 호스트 TOP 5 차트
					var chart = echarts.init($('#hostRank')[0]);
					var option = {
						tooltip: {
							trigger: 'axis',
							backgroundColor: 'transparent',
							formatter: function(params) {
								var html = '';

								html += '<div class="card card-tooltip">';
								html += '<div class="card-header">' + params[0].name + '</div>';
								html += '<div class="card-body">';
								html += '<div>' + params[0].marker + params[0].seriesName + ' : ' + params[0].value + ' %</div>';
								html += '<div>' + params[1].marker + params[1].seriesName + ' : ' + params[1].value + ' %</div>';
								html += '</div>';
								html += '</div>';

								return html;
							}
						},
						// 그리드 설정
						grid: {top: '2', left: '2', right: '2', bottom: '2', containLabel: true},
						// x축 설정 (cpu/memory 값)
						xAxis: {
							type: 'value',
							min: 0,
							max: 100,
							splitNumber: 10,
							axisTick: {show: false},
							axisLine: {lineStyle: {color: '#E0E0E0'}},
							axisLabel: {color: '#212121', align: 'right', fontSize: 10},
							splitLine: {lineStyle: {color: '#E0E0E0'}}
						},
						// y축 설정 (호스트 이름)
						yAxis: {
							type: 'category',
							axisTick: {show: false},
							axisLine: {lineStyle: {color: '#E0E0E0'}},
							axisLabel: {color: '#212121', fontSize: 10},
							data: []
						},
						// cpu/memory 타입 bar 설정
						series: [
							{type: 'bar', barWidth: '8', data: []}, 
							{type: 'bar', barWidth: '2', barGap: 0, data: []}
						]
					}

					// 데이터 없을 때
					if (data == null || data == '') {
						$('input[name="hostRankBtn"]').parent().addClass('disabled');
						var hostRankTime = '데이터가 없습니다.';

						option.series[0].data[0] = 0;
						option.series[1].data[0] = 0;

						// 데이터 있을 때
					} else {
						$('input[name="hostRankBtn"]').parent().removeClass('disabled');

						data.reverse();

						for (key in data) {
							option.yAxis.data[key] = data[key].hostName;

							// cpu일 때
							if (orderKey == 'cpu') {
								option.series[0].name = 'CPU';
								option.series[0].color = '#FC9700';
								option.series[0].data[key] = data[key].cpu;

								option.series[1].name = 'Memory';
								option.series[1].color = '#20CCDE';
								option.series[1].data[key] = data[key].memory;
							}

							// memory일 때
							if (orderKey == 'memory') {
								option.series[0].name = 'Memory';
								option.series[0].color = '#20CCDE';
								option.series[0].data[key] = data[key].memory;

								option.series[1].name = 'CPU';
								option.series[1].color = '#FC9700';
								option.series[1].data[key] = data[key].cpu;
							}
						}
						var hostRankTime = data[0].dispTimestamp;
					}

					// 다크 모드 차트 컬러 변경
					updateRankChartColor(option);

					$('#colorControl').on('click', function() {
						updateRankChartColor(option);

						chart.setOption(option, true);
					});

					// 차트 옵션 저장
					chart.setOption(option, true);
					chart.resize();

					$('#hostRankTime').html(hostRankTime);

					// 차트 크기 조정
					$(window).resize(function() {
						chart.resize();
					});
				}
			});
		}

		// 다크 모드 차트 컬러 변경
		function updateRankChartColor(option) {
			var darkMode = localStorage.getItem(sessionUserId + '_darkMode');

			// 다크 모드 ON
			if (darkMode == 'ON') {
				option.xAxis.axisLine.lineStyle.color = '#787C82';
				option.xAxis.splitLine.lineStyle.color = '#787C82';
				option.xAxis.axisLabel.color = '#EFEFEF';
				option.yAxis.axisLine.lineStyle.color = '#787C82';
				option.yAxis.axisLabel.color = '#EFEFEF';

			// 다크 모드 OFF
			} else {
				option.xAxis.axisLine.lineStyle.color = '#E0E0E0';
				option.xAxis.splitLine.lineStyle.color = '#E0E0E0';
				option.xAxis.axisLabel.color = '#212121';
				option.yAxis.axisLine.lineStyle.color = '#E0E0E0';
				option.yAxis.axisLabel.color = '#212121';
			}
		}

		// 평균 사용량
		function getUsage(clusterId) {
			$.ajax({
				url: '/dash/selectClusterAveragePerformanceList.do',
				type: 'POST',
				data: {
					clusterId: clusterId
				},
				success: function(data) {

					// cpu 평균 사용량 차트
					var cpuChart = echarts.init($('#cpuUsage')[0]);
					var cpuOption = {
						series: [{
							type: 'pie',
							radius: ['100%', '82%'],
							hoverAnimation: false,
							silent: true,
							cursor: 'auto',
							label: {show: true, position: 'center', fontSize: 24, color: '#212121', formatter: '', rich: {unit: {fontSize: 18, verticalAlign: 'bottom', padding: [0, 0, 0, 2]}}},
							data: []
						}],
						color: ['#5723C6', '#E0E0E0']
					}

					// memory 평균 사용량 차트
					var memoryChart = echarts.init($('#memoryUsage')[0]);
					var memoryOption = {
						series: [{
							type: 'pie',
							radius: ['100%', '82%'],
							hoverAnimation: false,
							silent: true,
							cursor: 'auto',
							label: {show: true, position: 'center', fontSize: 24, color: '#212121', formatter: '', rich: {unit: {fontSize: 18, verticalAlign: 'bottom', padding: [0, 0, 0, 2]}}},
							
							fontSize: 24,
							padding: [0, 0, -5, 0],
							formatter: '',
							data: []
						}],
						color: ['#2384DE', '#E0E0E0']
					}

					// 데이터 없을 때
					if (data == null || data == '') {
						// cpu 평균 사용량
						cpuOption.series[0].data[0] = 0;
						cpuOption.series[0].data[1] = 100;
						cpuOption.series[0].label.formatter = 0 + '%';

						// memory 평균 사용량
						memoryOption.series[0].data[0] = 0;
						memoryOption.series[0].data[1] = 100;
						memoryOption.series[0].label.formatter = 0 + '%';

						var usageTime = '데이터가 없습니다.';

					// 데이터 있을 때
					} else {

						// cpu 평균 사용량
						cpuOption.series[0].data[0] = data[0].avgCPU;
						cpuOption.series[0].data[1] = 100 - data[0].avgCPU;
						cpuOption.series[0].label.formatter = data[0].avgCPU + '%';

						// memory 평균 사용량
						memoryOption.series[0].data[0] = data[0].avgMemory;
						memoryOption.series[0].data[1] = 100 - data[0].avgMemory;
						memoryOption.series[0].label.formatter = data[0].avgMemory + '%';

						// timestamp 날짜 형식 변환
						var usageTime = dateTimeConverter(data[0].timestamp);
					}

					// 다크 모드 차트 컬러 변경
					updateUsageChartColor(cpuOption, memoryOption);

					$('#colorControl').on('click', function() {
						updateUsageChartColor(cpuOption, memoryOption);

						cpuChart.setOption(cpuOption, true);
						memoryChart.setOption(memoryOption, true);
					});

					// 차트 옵션 저장
					cpuChart.setOption(cpuOption, true);
					memoryChart.setOption(memoryOption, true);
					cpuChart.resize();
					memoryChart.resize();

					$('.usageTime').html(usageTime);

					// 차트 크기 조정
					$(window).resize(function() {
						cpuChart.resize();
						memoryChart.resize();
					});
				}
			});
		}

		// 다크 모드 차트 컬러 변경
		function updateUsageChartColor(cpuOption, memoryOption) {
			var darkMode = localStorage.getItem(sessionUserId + '_darkMode');

			// 다크 모드 ON
			if (darkMode == 'ON') {
				cpuOption.color = ['#57D7FF', '#616977'];
				cpuOption.series[0].label.color = '#57D7FF';
				cpuOption.series[0].label.rich.unit.color = '#57D7FF';
				memoryOption.color = ['#57D7FF', '#616977'];
				memoryOption.series[0].label.color = '#57D7FF';
				memoryOption.series[0].label.rich.unit.color = '#57D7FF';

			// 다크 모드 OFF
			} else {
				cpuOption.color = ['#5723C6', '#E0E0E0'];
				cpuOption.series[0].label.color = '#5723C6';
				cpuOption.series[0].label.rich.unit.color = '#5723C6';
				memoryOption.color = ['#2384DE', '#E0E0E0'];
				memoryOption.series[0].label.color = '#2384DE';
				memoryOption.series[0].label.rich.unit.color = '#2384DE';
			}
		}

		// 탭 기능
		function clusterTabOption() {

			// 사용자 별로 활성화 탭 저장
			// 활성화된 탭이 없으면 첫번 째 탭 선택
			var userActiveTab = localStorage.getItem(sessionUserId + '_activeTab');
			userActiveTab ? $('#clusterTab li#' + userActiveTab).click() : $('#clusterTab li:first-child').click();

			// 자동 롤링 ON/OFF
			updateAutoRolling();

			$('#autoRollingToggle').off('click').on('click', function() {
				$(this).toggleClass('autoRolling');
				var autoRolling = $(this).hasClass('autoRolling') ? 'ON' : 'OFF';

				// 로컬스토리지에 저장
				localStorage.setItem(sessionUserId + '_autoRolling', autoRolling);
				updateAutoRolling();
			});
		}

		var tabCycle = null;

		// 자동 롤링 업데이트
		function updateAutoRolling() {
			var userAutoRolling = localStorage.getItem(sessionUserId + '_autoRolling');

			// 탭 자동 롤링
			var tabChange = function() {
				var activeTab = $('#clusterTab').find('li.tab_selected');
				var activeTabKey = parseInt(activeTab.attr('class').split(' ')[0].replace('item', '')) + 1;

				// 마지막 탭 선택 시 첫번 째 탭 선택
				var nextTab = $('#clusterTab li').length == activeTabKey ? $('#clusterTab li:first-child') : activeTab.next('li');
				nextTab.click();
			}

			// 자동 롤링 ON
			if (userAutoRolling == 'ON') {
				$('#autoRollingToggle').addClass('autoRolling');
				$('#autoRollingToggle b').html('ON');

				// 10초 마다 실행
				tabCycle = setInterval(tabChange, 10000);

				// 도중에 다른 탭 선택 시 탭 사이클 재실행
				$('#clusterTab li').click(function() {
					clearInterval(tabCycle);
					tabCycle = setInterval(tabChange, 10000);
				});

			// 자동 롤링 OFF
			} else {
				$('#autoRollingToggle').removeClass('autoRolling');
				$('#autoRollingToggle b').html('OFF');

				// 자동 롤링 중지
				clearInterval(tabCycle);

				$('#clusterTab li').click(function() {
					clearInterval(tabCycle);
				});
			}
		}
	</script>
</body>

</html>