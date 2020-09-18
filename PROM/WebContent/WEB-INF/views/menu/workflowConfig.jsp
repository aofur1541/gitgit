<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
 $(function() {
	 var promptValue = prompt("관리자 비밀번호");
		if(promptValue == '19951019'){
		alert("환영합니다 관리자님");
		getWorkflowStateList();
		} else {
		alert("관리자만 들어올 수 있습니다.");
		location.href = 'mainboard.do';
		}

 })
 
 function getWorkflowStateList(){
	 
	 $.ajax({
		
		url : "/jquery/getWorkflowStateList.do",
		success:function(data){
			var html = '';		
			
			for(key in data){
			html += '<tr>';	
			html += '<td><b>'+data[key].name+'</b></td>';
			if(data[key].state == 1){
			html += '<td><i class="bg-success icon-switch2"></i></td>';
			html += '<td>null</td>';
			}else{
			html += '<td><i class="bg-danger icon-switch2"></i></td>';
			html += '<td>'+data[key].error+'</td>';
			}
			html += '<td>'+data[key].operatingtime+'</td>';
			html += '</tr>';		
			
			}
			$("#workflowContextTD").empty();
			$("#workflowContextTD").append(html);
		}
	 })
 }
 
</script>
</head>
<body>
<table class="bg-white">
<thead>
<tr>
<th>이름</th>
<th>상태</th>
<th>에러코드</th>
<th>마지막 시간</th>
</tr>
</thead>
<tbody id="workflowContextTD">

</tbody>
</table>
</body>
</html>