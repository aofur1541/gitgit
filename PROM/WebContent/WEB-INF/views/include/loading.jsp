<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="loading-background" id="page_loading"><div class="spinner-border" role="status"></div></div>

<script type="text/javascript">

	//모든 ajax 요청이 완료될 때
	$(document).ajaxStop(function() {
		$('#page_loading').addClass('d-none');
	});
</script>