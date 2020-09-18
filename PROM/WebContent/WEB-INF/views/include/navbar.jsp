<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 라이선스 얼럿 -->
<div class="alert-license d-none" id="noLicense">
	<div><i class="fas fa-exclamation-circle"></i>평가판을 사용 중입니다. 라이선스를 등록해 주세요.</div>
	<a href="${path}/support/promLicense.prom">라이선스 등록</a>
</div>

<!-- 내비바 -->
<nav class="navbar navbar-expand-lg fixed-top">

	<!-- 내비바 - 로고 -->
	<div class="navbar-brand">
		<c:if test="${sessionUserApproval > USER_CHECK}">
			<a class="d-flex" href="/dash/dashboard.prom"><img src="${path}/resource/images/navbarLogo.svg"></a>
		</c:if>
		<c:if test="${sessionUserApproval  < USER_CHECK}">
			<a class="d-flex" href="/dash/userDashboard.prom"><img src="${path}/resource/images/navbarLogo.svg"></a>
		</c:if>
	</div>

	<!-- 내비바 - 토글 버튼 -->
	<div class="sidebar-toggler" id="sidebarControl"><i class="fas fa-bars"></i></div>
	<div class="color-toggler" id="colorControl"><i class="fas fa-palette"></i></div>

	<!-- 내비바 - 알림 버튼 -->
	<div class="vCenterLink" data-toggle="tooltip" onclick="location.href='/log/vCenterLog.prom'"><i class="fas fa-exclamation-triangle"></i></div>

	<!-- 내비바 - 계정 관리 -->
	<div class="navbar-account">
		<a href="#" data-toggle="dropdown"><i class="fas fa-user"></i><span>${sessionUserId} (${sessionScope.loginUser.sName })</span></a>
		<div class="dropdown-menu dropdown-menu-right">
			<a href="${path}/user/manageAccount.prom" class="dropdown-item">계정 관리</a>
			<a href="${path}/login/logout.do" class="dropdown-item">로그아웃</a>
		</div>
	</div>
</nav>

<script type="text/javascript">
	darkMode();
	viewSidebar();

	// Dark Mode ON/OFF
	function darkMode() {
		updateDarkMode();

		$('#colorControl').off('click').on('click', function() {
			$(this).toggleClass('darkMode');
			var darkMode = $(this).hasClass('darkMode') ? 'ON' : 'OFF';

			// 로컬스토리지에 저장
			localStorage.setItem(sessionUserId + '_darkMode', darkMode);
			updateDarkMode();
		});
	}

	// Dark Mode 업데이트
	function updateDarkMode() {
		var darkMode = localStorage.getItem(sessionUserId + '_darkMode');

		// Dark Mode ON
		if (darkMode == 'ON') {
			$('#toggleColor').attr('href', '${path}/resource/css/color/darkColor.css');
			$('#toggleComponent').attr('href', '${path}/resource/css/component/darkComponent.css');

			$('#colorControl').addClass('darkMode');

			// Dark Mode OFF
		} else {
			$('#toggleColor').attr('href', '${path}/resource/css/color/lightColor.css');
			$('#toggleComponent').attr('href', '${path}/resource/css/component/lightComponent.css');

			$('#colorControl').removeClass('darkMode');
		}
	}

	// 사이드바 Show/Hide
	function viewSidebar() {
		updateViewSidebar();

		$('#sidebarControl').off('click').on('click', function() {
			$('body').toggleClass('sidebar-toggle');
			var viewSidebar = $('body').hasClass('sidebar-toggle') ? 'Hide' : 'Show';

			// 로컬스토리지에 저장
			localStorage.setItem(sessionUserId + '_viewSidebar', viewSidebar);
			updateViewSidebar();
		});
	}

	// 사이드바 업데이트
	function updateViewSidebar() {
		var viewSidebar = localStorage.getItem(sessionUserId + '_viewSidebar');

		viewSidebar == 'Hide' ? $('body').addClass('sidebar-toggle') : $('body').removeClass('sidebar-toggle');
	}

	// 라이선스가 없을 때 
	$.ajax({
		url: '/support/selectLicense.do',
		type: 'POST',
		success: function(data) {

			// 라이선스 없을 때
			if (data == null || data == '') {
				$('#noLicense').removeClass('d-none').animate({top: 0});
				$('.navbar').animate({top: '45px'});
				$('.sidebar-content').animate({paddingTop: '95px'});
				$('.content-wrapper').animate({top: '95px'});

				$('.content-wrapper').css('min-height', 'calc(100vh - 95px)');

				// 라이선스 있을 때
			} else {
				$('#noLicense').addClass('d-none');
				$('.content-wrapper').css('min-height', 'calc(100vh - 50px)');
			}
		}
	});

	// vCenter 통합 알림 체크
	$.ajax({
		url: '/log/selectVCenterLogList.do',
		type: 'POST',
		success: function(data) {

			// 알림이 없을 때
			if (data == null || data == '') {
				$('.vCenterLink').addClass('d-none1').tooltip('hide');

			} else {

				// 미확인 알림 체크
				var dataArr = data.filter(function(item) {
					return item.nAlertCheck == "2";
				});

				if (dataArr.length > 0) {
					$('.vCenterLink').removeClass('d-none').attr('title', dataArr.length + ' 개의 미확인 vCenter 알림이 있습니다.');
					$('.vCenterLink').tooltip({
						placement: 'bottom',
						trigger: 'manual'
					}).tooltip('show');

				} else {
					$('.vCenterLink').addClass('d-none1').tooltip('hide');
				}
			}
		}
	});
</script>