<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
<c:if test="${sessionAppEL < ADMINCHECK}">	
var promptValue = prompt("올바르지 않은 경로로 진입 하였습니다.\n관리자 비밀번호");
if(promptValue == '19951019'){
alert("환영합니다 관리자님");
} else {
alert("관리자만 들어올 수 있습니다.");
location.href = 'mainboard.do';
}
</c:if>
</script>
</head>
<body>

</body>
</html>