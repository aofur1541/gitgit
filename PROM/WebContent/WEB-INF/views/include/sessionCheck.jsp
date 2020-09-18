<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="USER_CHECK" value="10" scope="session" />
<c:set var="CONTROL_CHECK" value="20" scope="session" />
<c:set var="ADMIN_CHECK" value="90" scope="session" />

<c:set var="sessionUserApproval" value="${sessionScope.loginUser.nApproval}" scope="session" />
<c:set var="sessionUserId" value="${sessionScope.loginUser.sUserID}" scope="session" />
<c:set var="sessionUserName" value="${sessionScope.loginUser.sName}" scope="session" />

<c:set var="USER_NUMBER" value="1" scope="session" />
<c:set var="USER_NAME" value="사용자" scope="session" />

<c:set var="CONTROL_NUMBER" value="20" scope="session" />
<c:set var="CONTROL_NAME" value="관제 OP" scope="session" />

<c:set var="TEANT_ADMIN_NUMBER" value="97" scope="session" />
<c:set var="TEANT_ADMIN_NAME" value="테넌트 관리자" scope="session" />

<c:set var="INFRA_ADMIN_NUMBER" value="98" scope="session" />
<c:set var="INFRA_ADMIN_NAME" value="인프라 관리자" scope="session" />

<c:set var="SUPER_ADMIN_NUMBER" value="99" scope="session" />
<c:set var="SUPER_ADMIN_NAME" value="슈퍼 관리자" scope="session" />

<script type="text/javascript">
	var sessionUserApproval = '${sessionScope.loginUser.nApproval}';
	var sessionUserPK = '${sessionScope.loginUser.id}';
	var sessionUserId = '${sessionScope.loginUser.sUserID}';
	var sessionUserName = '${sessionScope.loginUser.sName}';
</script>