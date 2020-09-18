<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${path}/resources/PROM_CSS/vmUsageStatistics.css"
	rel="stylesheet" type="text/css">
<script src="${path}/resources/external_JS/Chart.bundle.min.js"></script>
<%-- <script src="${path}/resources/PROM_JS/refreshGetParaDelete.js"></script> --%>
<script type="text/javascript">
var d = 0;

//test 


function setStart(index){
var test = '';
test = setTimeout(function(){
	d++;
	console.log(test);
	$("#countNumber").empty();
	$("#countNumber").append(d);
	if(index == 0){
	setStart(0);
	} else {
		clearTimeout(test);
	}
},2000)

}

function setStop(){
	
	
	
}

</script>
</head>
 <body>
 <h1 class="text-white" id="countNumber"></h1>
<button type="button" onclick="setStart(0)">set시작</button>
<button type="button" onclick="setStart(1)">set중지</button>
</body>
</html>