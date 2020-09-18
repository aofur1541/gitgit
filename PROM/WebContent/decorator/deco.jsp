<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/favicon.jsp" %>
<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>

<!DOCTYPE html>
<html>
   <head>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <%@ include file="/WEB-INF/views/commonFiles.jsp"%>
      <%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
      
      <script>
      	 function getUnAnsweredCount(){
      	   $.ajax({
               url: "/support/countUnansweredQuestion.do",
               success: function(data) {
            	   var count = data;
            	   if(count >= 1){
            		   $('#getUnAnsweredCount').append(count);
            	   }
               }
      	   })
      	 }
         function allLicenseCheck() {
            $.ajax({
               url: "/support/selectLicense.do",
               success: function(data) {
                  var html = '';
                  var location = "location.href=\'/menu/totalconfiguration.do#1\'";
                  if (!data || data == null || data == '') {
                     html += '<div class="alert bg-warning  text-white alert-styled-left alert-dismissible allalert mb-0" style="padding:2px">';
                     html += '<span class="font-weight-semibold">라이선스가 만료됐거나 없습니다 라이선스가 없을 경우 일부 기능이 제한됩니다.</span>';
                     html += '<button type="button" class="btn btn-light ml-4" onclick=' + location + '><i class="icon-key"></i> 라이선스 등록</button></div>';
                     /* $("#meteringDisabled").bind('click',false);
                     $("#totalvmViewDisabled").bind("click",false);
                     $("#monitorDisabled").bind("click",false); */
                  }
                  $("#dangerAlert").empty();
                  $("#dangerAlert").append(html);
               }
            })
         }
   
         function dayVcenterAlertCheck() {
            $.ajax({
               url: "/log/countTodayVCenterLog.do",
               success: function(data) {
                  if (data > 0) {
                      $('#vCenterAlert').append(data);
                  } 
               }
            })
         }
   
         function vCenterBtn() {
            $.ajax({
               data: { serverType: 1 },
               url: "/config/selectExternalServerByServerType.do",
               success: function(data) {
                  var html = '';
                  html += '<a  href=' + data.connectString + ' target="_blank" class="navbar-nav-link">';
                  html += '<i class="icon-make-group" title="vCenter 바로가기"></i>';
                  html += '<span class="d-md-none ml-2">vCenter 바로가기</span>';
                  html += '</a>';
                  
                  $("#vCenterBtn").empty();
                  $("#vCenterBtn").append(html);
               }
            })
         }
   
         function printClock() {
   
            var clock = document.getElementById("clock"); // 출력할 장소 선택
            var currentDate = new Date(); // 현재시간
            var calendar = currentDate.getFullYear() + "-" + (currentDate.getMonth() + 1) + "-" + currentDate.getDate() // 현재 날짜
            var amPm = 'AM'; // 초기값 AM
            var currentHours = addZeros(currentDate.getHours(), 2);
            var currentMinute = addZeros(currentDate.getMinutes(), 2);
            var currentSeconds = addZeros(currentDate.getSeconds(), 2);
   
            if (currentHours >= 12) { // 시간이 12보다 클 때 PM으로 세팅, 12를 빼줌
               amPm = 'PM';
               currentHours = addZeros(currentHours - 12, 2);
            }
            clock.innerHTML = currentHours + ":" + currentMinute + ":" + currentSeconds + " " + amPm; //날짜를 출력해 줌
            setTimeout("printClock()", 1000); // 1초마다 printClock() 함수 호출
         }
   
         function addZeros(num, digit) { // 자릿수 맞춰주기
            var zero = '';
            num = num.toString();
            if (num.length < digit) {
               for (i = 0; i < digit - num.length; i++) {
                  zero += '0';
               }
            }
            return zero + num;
         }
   
         function TV() {
   
            var nowURL = window.location.pathname;
   
            var URL = "/menu/mainboard.do";
            var subURL = "/menu/Mmonitoring.do";
   
            if (nowURL == URL || nowURL == subURL) {
               var html = '';
               html = '<a href="#" class="navbar-nav-link" >';
               html += '<i class="icon-tv" title="전체화면 보기"></i>';
               html += '<span class="d-md-none ml-2">전체 화면 보기</span></a>';
               
               $("#toggle_fullscreen").empty();
               $("#toggle_fullscreen").append(html);
            }
         }
   
         function vmCreateActionCheck() {
            $.ajax({
               url: "/log/countProgressVMLog.do",
               success: function(data) {
                  var totalCnt = data.creatingCnt + data.updatingCnt;
                  creatingCnt = data.creatingCnt;
                  updatingCnt = data.updatingCnt;
                  if (totalCnt >= 1) {
                     $("#vmActionCheckView").empty();
                     $("#vmActionCheckView").append(totalCnt);
                  }
               }
            })
         }
   
         function vmCreateActionErrorCheck() {
            $.ajax({
               url: "/log/countErrorVMLog.do",
               success: function(data) {
                  if (data >= 1) {
                     $("#vmActionCheckView").empty();
                     $("#vmActionCheckView").append(data + " ERROR");
                  }
               }
            })
         }
   
         function getApprovalCheckcnt() {
            $.ajax({
               url: "/jquery/getApprovalCheckcnt.do",
               data: {
                  sUserID: '${sessionScope.loginUser.sUserID}',
                  nApproval: '${sessionScope.loginUser.nApproval}'
               },
               success: function(data) {
                  if (typeof data["userPWCnt"] == "undefined" || sessionApproval == BanNumber2) {
                     var totalCnt = data["createCnt"] + data["updateCnt"] + data["returnCnt"];
                     userPWCnt = 0;
                  } else {
                     var totalCnt = data["createCnt"] + data["updateCnt"] + data["returnCnt"] + data["userPWCnt"];
                     userPWCnt = data["userPWCnt"];
                  }
                  createCnt = data["createCnt"];
                  updateCnt = data["updateCnt"];
                  returnCnt = data["returnCnt"];
                  $('#approvalCnt').empty();
                  if (totalCnt >= 1) {
                     $('#approvalCnt').append(totalCnt);
                  }
               }
            })
         }
   
         function notAuthorityCheck() {
            if (sessionApproval < ADMINCHECK) {
               $.ajax({
                  url: "/jquery/notAuthorityCheck.do",
                  success: function(data) {
                     if (data == 1) {
                        alert("테넌트/서비스에 소속되어있지 않습니다.\n소속이 없을 경우 제대로 동작하지 않으니 관리자에게 문의해 주십시오.");
                     }
                  }
               })
            }
         }
   
   
         function allRefresh() {
            $("#allRefreshBtn").attr('class', 'icon-spinner2 spinner');
            $.ajax({
               url: "/menu/allRefresh.do",
               success: function(data) {
                  window.location.reload();
               },
               error: function() {
                  alert("시스템 오류 : 잠시 후 다시 시도해 주십시오.");
               }
            })
         }
   
         function userPWupdate() {
            userProDetail('${sessionScope.loginUser.sUserID}');
            $("#passwordChange").modal("show");
         }
   
         var creatingCnt = 0;
         var updatingCnt = 0;
         var createCnt = 0;
         var updateCnt = 0;
         var returnCnt = 0;
         var userPWCnt = 0;
         var maxCnt = new Array();
         var maxVMCnt = 0;
         var maxNum = 0;
         var urlCheck = window.location.href;
   
         $(document).ready(function() {
            notAuthorityCheck();
            getApprovalCheckcnt();
            vmCreateActionCheck();
            vmCreateActionErrorCheck();
            allLicenseCheck();
            dayVcenterAlertCheck();
            vCenterBtn();
            TV();
            getUnAnsweredCount();
 
            $("#vmActionCheckLink").click(function() {
               var indexCnt = 0;
               if (creatingCnt > maxVMCnt) {
                  indexCnt = 1;
               }
               if (updatingCnt > creatingCnt) {
                  indexCnt = 2;
               }
               location.href = '/menu/vmHistory.do#' + indexCnt
            })
   
   
            $("#approvalLink").click(function() {
               var indexCnt = 0;
               maxCnt.push(createCnt);
               maxCnt.push(updateCnt);
               maxCnt.push(returnCnt);
               maxCnt.push(userPWCnt);
               for (var i = 0; i < maxCnt.length; i++) {
                  if (maxNum < maxCnt[i]) {
                     maxNum = maxCnt[i];
                     indexCnt = i;
                  }
               }
               location.href = '/menu/approvalManage.do#' + (indexCnt + 1)
               maxCnt = [];
            })
           $("#getUnAnswerLink").click(function() {
        	   location.href = '/menu/totalconfiguration.do#2';
           	})
             
            $("#hostDetaillistSearch").hide();
            $("#vmDetaillistSearch").hide();
            $("#loading").hide();
         })
      </script>
   
      <style type="text/css">
         @font-face {
            font-family: 'SpoqaHanSans';
            font-style: normal;
            font-weight: 400;
            src: local('SpoqaHanSansLight'),
            url('${path}/resources/fonts/SpoqaHanSansLight.woff2') format('woff2'),
            url('${path}/resources/fonts/SpoqaHanSansLight.woff') format('woff'),
            url('${path}/resources/fonts/SpoqaHanSansLight.ttf') format('truetype');
         }
   
         @font-face {
            font-family: 'SpoqaHanSans';
            font-style: normal;
            font-weight: 700;
            src: local('Spoqa Han Sans Regular'),
            url('${path}/resources/fonts/SpoqaHanSansRegular.woff2') format('woff2'),
            url('${path}/resources/fonts/SpoqaHanSansRegular.woff') format('woff'),
            url('${path}/resources/fonts/SpoqaHanSansRegular.ttf') format('truetype');
         }
   
         @font-face {
            font-family: 'SpoqaHanSans';
            font-style: normal;
            font-weight: 900;
            src: local('Spoqa Han Sans Bold'),
            url('${path}/resources/fonts/SpoqaHanSansBold.woff2') format('woff2'),
            url('${path}/resources/fonts/SpoqaHanSansBold.woff') format('woff'),
            url('${path}/resources/fonts/SpoqaHanSansBold.ttf') format('truetype');
         }
      </style>
   
      <decorator:head />
      <script src="${path}/resources/PROM_JS/commonValidation.js"></script>
   
   </head>
   <decorator:title />
   
   <title>PROM</title>
   
   <body class="navbar-top" onload="printClock()">
      <button type="button" style="display: none;" id="limitedBtn"></button>
      <div class="navbar navbar-expand-md navbar-dark fixed-top">
         <div class="navbar-brand">
            <c:if test="${sessionAppEL > ADMINCHECK}">
               <a href="${path}/menu/dashboard.do" class="d-inline-block">
                  <img src="${path}/resources/global_assets/images/PROMPortal_logo_md.png">
               </a>
            </c:if>
            <c:if test="${sessionAppEL < ADMINCHECK}">
               <a href="${path}/menu/userDashboard.do" class="d-inline-block">
                  <img src="${path}/resources/global_assets/images/PROMPortal_logo_md.png">
               </a>
            </c:if>
         </div>
   
         <div class="d-md-none">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-mobile">
               <i class="icon-tree5"></i>
            </button>
            <button class="navbar-toggler sidebar-mobile-main-toggle" type="button">
               <i class="icon-paragraph-justify3"></i>
            </button>
         </div>
   
         <div class="collapse navbar-collapse" id="navbar-mobile">
            <ul class="navbar-nav">
               <li class="nav-item">
                  <a href="#" class="navbar-nav-link sidebar-control sidebar-main-toggle d-none d-md-block"><i class="icon-paragraph-justify3"></i></a>
               </li>
               <li class="nav-item" id="transmissionbtn" style="display: none;">
                  <a href="#" class="navbar-nav-link sidebar-control sidebar-secondary-toggle d-none d-md-block"><i class="icon-transmission mt-1"></i></a>
               </li>
               <li class="nav-item">
                  <a href="#" class="navbar-nav-link d-flex align-items-center" style="cursor: default"><i class="icon-alarm mr-2"></i>
                     <span class="d-md-none mr-2">현재 시각</span><span id="clock"></span>
                  </a>
               </li>
            </ul>
            <ul class="navbar-nav ml-auto">
   			<c:if test="${sessionAppEL != BANNUMBER}">
               <c:if test="${sessionAppEL > ADMINCHECK or sessionAppEL == BANNUMBER3}">
                  <li class="nav-item">
                     <a href="#" id="approvalLink" class="navbar-nav-link">
                        <i class="icon-bell2" title="신청 승인 관리"></i>
                        <span class="d-md-none ml-2">신청 승인 관리</span>
                        <span class="badge badge-pill bg-warning-400 ml-auto ml-md-0" id="approvalCnt"></span>
                     </a>
                  </li>
               </c:if>
   
               <c:if test="${sessionAppEL > ADMINCHECK}">
                  <li class="nav-item">
                     <a href="#" onclick="location.href='/menu/monitoring.do#3'" class="navbar-nav-link">
                        <i class="icon-warning22" title="vCenter 로그"></i>
                        <span class="d-md-none ml-2">vCenter 로그</span>
                        <span class="badge badge-pill bg-warning-400 ml-auto ml-md-0" id="vCenterAlert"></span>
                     </a>
                  </li>
                  <c:if test="${sessionAppEL > ADMINCHECK}">
                  <li class="nav-item">
                     <a href="#" id="getUnAnswerLink" onclick="location.href='/menu/totalconfiguration.do#2'" class="navbar-nav-link">
                        <i class="icon-help" title="문의사항"></i>
                        <span class="d-md-none ml-2">문의사항</span>
                        <span class="badge badge-pill bg-warning-400 ml-auto ml-md-0" id="getUnAnsweredCount"></span>
                     </a>
                  </li>
                  </c:if>
                  <li class="nav-item">
                     <a href="#" id="vmActionCheckLink" class="navbar-nav-link">
                        <i class="icon-cube4" title="가상머신 생성/변경 진행사항"></i>
                        <i style="margin-left:-10px; margin-top:5px; border-radius:0.5em; padding:2px 1px 1px 1px; background-color:#242a37;" class="icon-hammer-wrench font-size-sm" title="가상머신 생성/변경 진행사항"></i>
                        <span class="d-md-none ml-2">진행중인 가상머신 생성/변경</span>
                        <span class="badge badge-pill bg-warning-400 ml-auto ml-md-0" id="vmActionCheckView"></span>
                     </a>
                  </li>
                  
                  <li class="nav-item" id="vCenterBtn"></li>
                  
               </c:if>
   
               <li class="nav-item" id="toggle_fullscreen"></li>
   
               <li class="nav-item">
                  <a href="#" class="navbar-nav-link" onclick="allRefresh()">
                     <i class="icon-reload-alt" id="allRefreshBtn" title="데이터 새로고침"></i>
                     <span class="d-md-none ml-2">데이터 새로고침</span>
                  </a>
               </li>
   				</c:if>
               <li class="nav-item dropdown">
                  <a href="#" class="navbar-nav-link dropdown-toggle" data-toggle="dropdown">
                     <c:if test="${sessionAppEL > ADMINCHECK}">
                        <i class="icon-user-tie mr-2"></i>
                     </c:if>
                     <c:if test="${sessionAppEL < ADMINCHECK}">
                        <i class="icon-user mr-2"></i>
                     </c:if>
                     <span>${sessionUserIDEL}</span>
                     <span>(${sessionScope.loginUser.sName })</span>
                     <c:if test="${empty sessionUserIDEL}">
                        <i class="icon-user-block"></i>
                     </c:if>
                  </a>
                  <div class="dropdown-menu dropdown-menu-right">
                  <c:if test="${sessionAppEL != BANNUMBER}">
                     <c:if test="${sessionAppEL > ADMINCHECK}">
                        <a class="dropdown-item" href="${path }/menu/userSetting.do#3">
                           <i class="icon-user-plus"></i> 계정 관리
                        </a>
                     </c:if>
   				 </c:if>
   
                     <c:if test="${empty sessionUserIDEL }">
                        <a href="${path }/index.jsp" class="dropdown-item">
                           <i class="icon-switch2"></i> Login
                        </a>
                     </c:if>
                     <c:if test="${!empty sessionUserIDEL }">
                        <a href="${path }/login/logout.do" class="dropdown-item">
                           <i class="icon-exit"></i> 로그아웃
                        </a>
                     </c:if>
                  </div>
               </li>
            </ul>
            
         </div>
      </div>
      
      <div class="page-content">
         <div class="sidebar sidebar-dark sidebar-main sidebar-fixed sidebar-expand-md">
            <div class="sidebar-mobile-toggler text-center">
               <a href="#" class="sidebar-mobile-main-toggle"><i class="icon-arrow-left8"></i>
               </a> PROM <a href="#" class="sidebar-mobile-expand"><i class="icon-screen-full"></i><i class="icon-screen-normal"></i>
               </a>
            </div>
            <div class="sidebar-content" style="overflow: auto;">
               <div class="card card-sidebar-mobile">
                  <ul class="nav nav-sidebar" data-nav-type="accordion">
                     <li class="nav-item-header">
                        <div class="text-uppercase font-size-xs line-height-xs">MAIN MENU</div> <i class="icon-menu" title="Main Menu"></i>
                     </li>
   
                     <li class="nav-item" id="dashboard">
                        <c:if test="${sessionAppEL > ADMINCHECK}">
                           <a href="${path }/menu/dashboard.do" class="nav-link"> <i class="icon-meter-fast"></i><span>대시보드</span></a>
                        </c:if>
                        <c:if test="${sessionAppEL < ADMINCHECK}">
                           <a href="${path }/menu/userDashboard.do" class="nav-link"> <i class="icon-meter-fast"></i><span>대시보드</span></a>
                        </c:if>
                     </li>
   
   					<c:if test="${sessionAppEL != BANNUMBER}">
                     <li class="nav-item" id="inventoryManage">
                        <a href="${path }/menu/vmManagement.do#1" class="nav-link" title="인벤토리 관리">
                           <i class="icon-box"></i><span>인벤토리 관리</span>
                        </a>
                     </li>
   
                     <li class="nav-item" id="inventoryStatus">
                        <a href="${path }/menu/inventoryStatus.do#1" class="nav-link" title="인벤토리 현황">
                           <i class="icon-inbox"></i><span>인벤토리 현황</span>
                        </a>
                     </li>
   
                     <li class="nav-item" id="approvalManage">
                        <c:if test="${sessionAppEL > ADMINCHECK}">
                           <a href="${path }/menu/approvalManage.do#1" class="nav-link" title="신청 승인 관리">
                              <i class="icon-bell2"></i><span>신청 승인 관리</span>
                           </a>
                        </c:if>
                        <c:if test="${sessionAppEL < ADMINCHECK}">
                           <a href="${path }/menu/approvalManage.do#1" class="nav-link" title="신청 승인 현황">
                              <i class="icon-bell2"></i><span>신청 승인 현황</span>
                           </a>
                        </c:if>
                     </li>
                     </c:if>
                     <li class="nav-item" id="monitoring">
                        <a href="${path }/menu/monitoring.do#1" class="nav-link" title="모니터링">
                           <i class="icon-screen3"></i><span>모니터링</span>
                        </a>
                     </li>
   
   					<c:if test="${sessionAppEL != BANNUMBER}">
                     <li class="nav-item nav-item-submenu" id="statisticalReports"><a href="#" class="nav-link "> <i class="icon-file-stats2"></i><span>통계 보고서</span></a>
                        <ul class="nav nav-group-sub" data-submenu-title="통계 보고서">
                           <li class="nav-item"><a href="${path }/menu/report.do#1" class="nav-link">보고서</a></li>
                           <li class="nav-item"><a href="${path }/menu/statisticsManagement.do#1" class="nav-link ">성능 통계</a></li>
                           <li class="nav-item"><a href="${path }/menu/Chargebacks.do" class="nav-link ">과금 통계</a></li>
                        </ul>
                     </li>
   
                     <li class="nav-item nav-item-submenu" id="auditHistory">
                        <c:if test="${sessionAppEL > ADMINCHECK}">
                           <a href="#" class="nav-link "> <i class="icon-file-text3"></i><span>감사 이력</span></a>
                           <ul class="nav nav-group-sub" data-submenu-title="감사 이력">
                              <li class="nav-item"><a href="${path }/menu/connectHistory.do#1" class="nav-link">접속 이력</a></li>
                              <li class="nav-item"><a href="${path }/menu/workHistory.do#1" class="nav-link ">작업 이력</a></li>
                              <li class="nav-item"><a href="${path }/menu/vmHistory.do#1" class="nav-link ">가상머신 이력</a></li>
                           </ul>
                        </c:if>
                     </li>
                     </c:if>
                     
                     <c:if test="${sessionAppEL < ADMINCHECK}">
                        <li class="nav-item" id="userAuditHistory">
                           <a href="${path }/user/userHistory.do#1" class="nav-link" title="감사 이력">
                              <i class="icon-file-text3"></i><span>감사 이력</span>
                           </a>
                        </li>
                     </c:if>
   
   					<c:if test="${sessionAppEL != BANNUMBER}">
                     <li class="nav-item-header">
                        <div class="text-uppercase font-size-xs line-height-xs">CONFIGURATION</div>
                        <i class="icon-menu" title="Configuration"></i>
                     </li>
   
                     <c:if test="${sessionAppEL gt ADMINCHECK}">
                        <li class="nav-item" id="preferences">
                           <a href="${path}/menu/Preferences.do#1" class="nav-link" title="환경 설정">
                              <i class="icon-cog"></i><span>환경 설정</span>
                           </a>
                        </li>
                     </c:if>
   
                     <c:if test="${sessionAppEL gt ADMINCHECK}">
                        <li class="nav-item" id="autoScaleSetting">
                           <a href="${path}/menu/autoScaleSetting.do#1" class="nav-link" title="Auto Scale 설정">
                              <i class="icon-cog3"></i><span>오토 스케일 설정</span>
                           </a>
                        </li>
                     </c:if>
   
                     <li class="nav-item" id="userSetting">
                        <c:if test="${sessionAppEL gt ADMINCHECK}">
                           <a href="${path}/menu/userSetting.do#1" class="nav-link" title="사용자 설정">
                              <i class="icon-user"></i><span>사용자 설정</span>
                           </a>
                        </c:if>
                        <c:if test="${sessionAppEL lt ADMINCHECK}">
                           <a href="${path}/menu/userSetting.do#3" class="nav-link" title="사용자 정보">
                              <i class="icon-user"></i><span>사용자 정보</span>
                           </a>
                        </c:if>
                     </li>
   
                     <c:if test="${sessionAppEL gt ADMINCHECK}">
                        <li class="nav-item" id="tenantSetting">
                           <a href="${path}/menu/tenantSetting.do#1" class="nav-link" title="테넌트 설정">
                              <i class="icon-home2"></i><span>테넌트 설정</span>
                           </a>
                        </li>
                     </c:if>
   
                     <li class="nav-item" id="helpDesk">
                        <a href="${path}/menu/totalconfiguration.do#1" class="nav-link " title="헬프 데스크">
                           <i class="icon-question7"></i><span>헬프 데스크</span>
                        </a>
                     </li>
                     </c:if>
                  </ul>
               </div>
            </div>
         </div>
         <div class="content-wrapper">
            <div id="dangerAlert"></div>
            
            <!-- 
            <div class="alert bg-primary text-white alert-styled-left alert-dismissible allalert mb-0">
               <span>제한된 상태에서 볼 수 있습니다.</span> 
               <button type="button" class="btn btn-light ml-4"><i class="icon-reading"></i> 읽기 전용</button>
            </div>
             -->
   
            <div id="loading">
               <div class="pace-demo">
                  <div class="theme_tail theme_tail_circle theme_tail_with_text">
                     <div class="pace_progress" data-progress-text="60%" data-progress="60"></div>
                     <div class="pace_activity"></div>
                     <span class="text-center">로딩중...</span>
                  </div>
               </div>
               <div class="pace-back"></div>
            </div>
            <div class="content">
               <div id="noLicense"></div>
               <decorator:body />
            </div>
         </div>
      </div>
   </body>
   <script type="text/javascript">
      var serviceINvmCount = 0;
      
      $('#toggle_fullscreen').on('click', function() {
            // if already full screen; exit
            // else go fullscreen
            function requestFullScreen() {
   
               var el = document.body;
   
               // Supports most browsers and their versions.
               var requestMethod = el.requestFullScreen ||
                  el.webkitRequestFullScreen ||
                  el.mozRequestFullScreen ||
                  el.msRequestFullScreen;
   
               if (requestMethod) {
                  // Native full screen.
                  requestMethod.call(el);
   
               } else if (typeof window.ActiveXObject !== "undefined") {
                  // Older IE.
                  var wscript = new ActiveXObject("WScript.Shell");
                  if (wscript !== null) {
                     wscript.SendKeys("{F11}");
                  }
               }
            }
            requestFullScreen();
         });
   </script>
</html>