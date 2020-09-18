<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="sidebar">
	<nav class="sidebar-content" id="sidebar-accordion">

		<!-- 사이드바 - 헤더 -->
		<div class="sidebar-header">MENU</div>

		<!-- 사이드바 - 바디 -->
		<div class="sidebar-body">
			<ul class="sidebar-nav">
				<c:if test="${sessionUserApproval > USER_CHECK}">
					<li><a class="sidebar-link" href="/dash/dashboard.prom"><i class="fas fa-th-large"></i>대시보드</a></li>
				</c:if>
				<c:if test="${sessionUserApproval  < USER_CHECK}">
					<li><a class="sidebar-link" href="/dash/userDashboard.prom"><i class="fas fa-th-large"></i>대시보드</a></li>
				</c:if>

				<c:if test="${sessionUserApproval != CONTROL_CHECK}">
					<li class="sidebar-item-submenu">
						<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarStatus"><i class="fas fa-desktop"></i>현황</a>
						<ul class="sidebar-item-group collapse" data-parent="#sidebar-accordion" id="sidebarStatus">
							<li><a class="sidebar-link" href="/status/vmStatus.prom">가상머신</a></li>

							<c:if test="${sessionUserApproval > USER_CHECK}">
								<li><a class="sidebar-link" href="/status/hostStatus.prom">호스트</a></li>
								<li><a class="sidebar-link" href="/status/datastoreStatus.prom">데이터스토어</a></li>
							</c:if>
						</ul>
					</li>
				</c:if>

				<li class="sidebar-item-submenu">
					<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarPerformance"><i class="fas fa-chart-line"></i>성능</a>
					<ul class="sidebar-item-group collapse" data-parent="#sidebar-accordion" id="sidebarPerformance">
						<li class="sidebar-item-submenu">
							<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarBasicPerformance">일반<i class="fas fa-angle-up"></i></a>
							<ul class="sidebar-item-group collapse" data-parent="#sidebarPerformance" id="sidebarBasicPerformance">
								<li><a class="sidebar-link" href="/performance/vmPerformance.prom">가상머신</a></li>
								<c:if test="${sessionUserApproval > USER_CHECK}">
									<li><a class="sidebar-link" href="/performance/hostPerformance.prom">호스트</a></li>
									<li><a class="sidebar-link" href="/performance/networkPerformance.prom">네트워크</a></li>
								</c:if>
							</ul>
						</li>
						<li class="sidebar-item-submenu">
							<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarCustomPerformance">고급<i class="fas fa-angle-up"></i></a>
							<ul class="sidebar-item-group collapse" data-parent="#sidebarPerformance" id="sidebarCustomPerformance">
								<li><a class="sidebar-link" href="/performance/vmCustomPerformance.prom">가상머신</a></li>
								<c:if test="${sessionUserApproval > USER_CHECK}">
									<li><a class="sidebar-link" href="/performance/hostCustomPerformance.prom">호스트</a></li>
								</c:if>
								<li><a class="sidebar-link" href="/performance/cpuCustomPerformance.prom">CPU 기준</a></li>
								<li><a class="sidebar-link" href="/performance/memoryCustomPerformance.prom">Memory 기준</a></li>
								
								
							</ul>
						</li>
					</ul>
				</li>

				<c:if test="${sessionUserApproval != CONTROL_CHECK}">
					<li class="sidebar-item-submenu">
						<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarReport"><i class="far fa-file-alt"></i>보고서</a>
						<ul class="sidebar-item-group collapse" data-parent="#sidebar-accordion" id="sidebarReport">
							<li class="sidebar-item-submenu">
								<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarBasicReport">일반 성능<i class="fas fa-angle-up"></i></a>
								<ul class="sidebar-item-group collapse" data-parent="#sidebarReport" id="sidebarBasicReport">
									<li><a class="sidebar-link" href="/report/vmReport.prom">가상머신</a></li>
									<c:if test="${sessionUserApproval > USER_CHECK}">
										<li><a class="sidebar-link" href="/report/hostReport.prom">호스트</a></li>
									</c:if>
								</ul>
							</li>
							<li class="sidebar-item-submenu">
								<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarDayNightReport">주야간 성능<i class="fas fa-angle-up"></i></a>
								<ul class="sidebar-item-group collapse" data-parent="#sidebarReport" id="sidebarDayNightReport">
									<li><a class="sidebar-link" href="/report/vmDayNightReport.prom">가상머신</a></li>
									<c:if test="${sessionUserApproval > USER_CHECK}">
										<li><a class="sidebar-link" href="/report/hostDayNightReport.prom">호스트</a></li>
									</c:if>
								</ul>
							</li>
						</ul>
					</li>
				</c:if>

				<li class="sidebar-item-submenu">
					<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarLog"><i class="fas fa-history"></i>감사 이력</a>
					<ul class="sidebar-item-group collapse" data-parent="#sidebar-accordion" id="sidebarLog">
						<c:if test="${sessionUserApproval > USER_CHECK && sessionUserApproval != CONTROL_CHECK}">
							<li class="sidebar-item-submenu">
								<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarAdminLog">관리자<i class="fas fa-angle-up"></i></a>
								<ul class="sidebar-item-group collapse" data-parent="#sidebarLog" id="sidebarAdminLog">
									<li><a class="sidebar-link" href="/log/adminLoginLog.prom">접속</a></li>
									<li><a class="sidebar-link" href="/log/adminLog.prom">작업</a></li>
								</ul>
							</li>
							<li class="sidebar-item-submenu">
								<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarUserLog">사용자<i class="fas fa-angle-up"></i></a>
								<ul class="sidebar-item-group collapse" data-parent="#sidebarLog" id="sidebarUserLog">
									<li><a class="sidebar-link" href="/log/userLoginLog.prom">접속</a></li>
									<li><a class="sidebar-link" href="/log/userLog.prom">작업</a></li>
								</ul>
							</li>
						</c:if>
						<c:if test="${sessionUserApproval != CONTROL_CHECK}">
							<li><a class="sidebar-link" href="/log/vmLog.prom">가상머신 이력</a></li>
						</c:if>
						<c:if test="${sessionUserApproval > USER_CHECK}">
							<li><a class="sidebar-link" href="/log/vCenterLog.prom">vCenter 통합 알림</a></li>
						</c:if>
					</ul>
				</li>

				<c:if test="${sessionUserApproval > USER_CHECK && sessionUserApproval != CONTROL_CHECK}">
					<li class="sidebar-item-submenu">
						<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarInfraConfig"><i class="fas fa-wrench"></i>인프라 관리</a>
						<ul class="sidebar-item-group collapse" data-parent="#sidebar-accordion" id="sidebarInfraConfig">
							<li class="sidebar-item-submenu">
								<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarVMConfig">가상머신<i class="fas fa-angle-up"></i></a>
								<ul class="sidebar-item-group collapse" data-parent="#sidebarInfraConfig" id="sidebarVMConfig">
									<li><a class="sidebar-link" href="/vm/createVM.prom">생성</a></li>
									<li><a class="sidebar-link" href="/vm/changeVM.prom">설정 편집</a></li>
								</ul>
							</li>
							<li class="sidebar-item-submenu">
								<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarImageConfig">골든 이미지<i class="fas fa-angle-up"></i></a>
								<ul class="sidebar-item-group collapse" data-parent="#sidebarInfraConfig" id="sidebarImageConfig">
									<li><a class="sidebar-link" href="/config/templateConfig.prom">템플릿 선택</a></li>
									<li><a class="sidebar-link" href="/config/catalogConfig.prom">카탈로그</a></li>
								</ul>
							</li>
							<li class="sidebar-item-submenu">
								<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarGroupConfig">그룹 관리<i class="fas fa-angle-up"></i></a>
								<ul class="sidebar-item-group collapse" data-parent="#sidebarInfraConfig" id="sidebarGroupConfig">
									<li><a class="sidebar-link" href="/serviceGroup/manageServiceGroup.prom">서비스 그룹</a></li>
									<li><a class="sidebar-link" href="/serviceGroup/manageService.prom">서비스</a></li>
									<li><a class="sidebar-link" href="/serviceGroup/arrangeVM.prom">가상머신 배치</a></li>
								</ul>
							</li>
							<li><a class="sidebar-link" href="/config/basicConfig.prom">기본 기능</a></li>
							<li><a class="sidebar-link" href="/config/externalServerConfig.prom">외부 서버 연동 현황</a></li>
						</ul>
					</li>
				</c:if>

				<c:if test="${sessionUserApproval != CONTROL_CHECK}">
					<li class="sidebar-item-submenu">
						<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarInformation"><i class="fas fa-user-circle"></i>기초 데이터</a>
						<ul class="sidebar-item-group collapse" data-parent="#sidebar-accordion" id="sidebarInformation">
							<c:if test="${sessionUserApproval > USER_CHECK}">
								<li><a class="sidebar-link" href="/user/manageCompany.prom">회사</a></li>
								<li><a class="sidebar-link" href="/user/manageDepartment.prom">부서</a></li>
							</c:if>
							<li><a class="sidebar-link" href="/user/manageUser.prom">사용자</a></li>
							<c:if test="${sessionUserApproval > USER_CHECK}">
								<li><a class="sidebar-link" href="/support/promLicense.prom">라이선스</a></li>
							</c:if>
						</ul>
					</li>
				</c:if>

				<c:if test="${sessionUserApproval != CONTROL_CHECK}">
					<li class="sidebar-item-submenu">
						<a class="sidebar-link collapsed" href="#" data-toggle="collapse" data-target="#sidebarSupport"><i class="fas fa-question-circle"></i>고객 지원</a>
						<ul class="sidebar-item-group collapse" data-parent="#sidebar-accordion" id="sidebarSupport">
							<li><a class="sidebar-link" href="/support/notice.prom">공지사항</a></li>
							<li><a class="sidebar-link" href="/support/question.prom">문의사항</a></li>
						</ul>
					</li>
				</c:if>
			</ul>
		</div>

		<!-- 사이드바 - 푸터 -->
		<div class="sidebar-footer"><i class="far fa-clock"></i><span id="currentTime">오전 00:00:00</span></div>
	</nav>
</div>