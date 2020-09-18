$(document).ready(function(){
		var link = document.location.href;
		var tab = link.split('#').pop();
		$('#tab'+tab).trigger("click");	
		
	})
	
	function getContentTab(index,url){
	var targetDiv = "#content" + index; 
	location.href = "#"+index;
	} 

	