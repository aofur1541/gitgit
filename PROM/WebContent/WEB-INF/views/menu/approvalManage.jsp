<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="${path}/resources/PROM_JS/refreshMaintain.js"></script>
		<script type="text/javascript">
			
			getApprovalCheckcnt();
			$(function() {
				if (createCnt > 0) {
					$("#createLabel").append(createCnt);
				}
				if (updateCnt > 0) {
					$("#updateLabel").append(updateCnt);
				}
				if (returnCnt > 0) {
					$("#returnVMLabel").append(returnCnt);
				}
				if (sessionApproval != BanNumber2) {

					if (userPWCnt > 0) {
						$("#userPWLabel").append(userPWCnt);
					}
				}

			});
		</script>
	</head>
	<body>
		<input id="radio1" type="radio" name="css-tabs" checked>
		<input id="radio2" type="radio" name="css-tabs">
		<input id="radio3" type="radio" name="css-tabs">
		<c:if test="${sessionAppEL > ADMINCHECK}">
			<input id="radio4" type="radio" name="css-tabs">
		</c:if>
		
		<div id="tabs">
			<label id="tab1" for="radio1" onclick="getContentTab(1)">
				<i class="icon-cube4"></i><span class="tabs-title">가상머신 생성</span>
				<span class="badge bg-warning badge-pill ml-1" id="createLabel"></span>
			</label>
			<label id="tab2" for="radio2" onclick="getContentTab(2)">
				<i class="icon-clipboard3"></i><span class="tabs-title">가상머신 자원 변경</span>
				<span class="badge bg-warning badge-pill ml-1" id="updateLabel"></span>
			</label>
			<label id="tab3" for="radio3" onclick="getContentTab(3)">
				<i class="icon-reply"></i><span class="tabs-title">가상머신 반환</span>
				<span class="badge bg-warning badge-pill ml-1" id="returnVMLabel"></span>
			</label>
			<c:if test="${sessionAppEL > ADMINCHECK}">
				<label id="tab4" for="radio4" onclick="getContentTab(4)">
					<i class="icon-lock2"></i><span class="tabs-title">비밀번호 초기화</span>
					<span class="badge bg-warning badge-pill ml-1" id="userPWLabel"></span>
				</label>
			</c:if>
		</div>
		
		<div id="content">
			<section id="content1">
				<iframe src="/data/applyVMlist.do"  width="100%" height="700" seamless></iframe>
			</section>
			<section id="content2">
				<iframe src="/data/applyResourceChange.do" width="100%" height="700" seamless></iframe>
			</section>
			<section id="content3">
				<iframe src="/data/applyReturnVM.do" width="100%" height="700" seamless></iframe>
			</section>
			<c:if test="${sessionAppEL > ADMINCHECK}">
				<section id="content4">
					<iframe src="/data/userPW.do" width="100%" height="700" seamless></iframe>
				</section>
			</c:if>
		</div>
	</body>
</html>