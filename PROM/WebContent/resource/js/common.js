// 데이터테이블즈 언어 설정
var datatables_lang = {
	"decimal": "",
	"emptyTable": "데이터가 없습니다.",
	"info": "_START_ - _END_ (총 _TOTAL_ 건)",
	"infoEmpty": "0 건",
	"infoFiltered": "(전체 _MAX_ 건 중 검색결과)",
	"infoPostFix": "",
	"thousands": ",",
	"lengthMenu": "_MENU_",
	"loadingRecords": "로딩중...",
	"processing": "처리중...",
	"search": "",
	"zeroRecords": "검색된 데이터가 없습니다.",
	"paginate": {
		"first": "",
		"last": "",
		"next": "<i class='fas fa-chevron-right'></i>",
		"previous": "<i class='fas fa-chevron-left'></i>"
	},
	"aria": {
		"sortAscending": " :  오름차순 정렬",
		"sortDescending": " :  내림차순 정렬"
	}
};

$(document).ready(function() {
	$('select.form-control').select2();
	$('select.form-control.no-search').select2({
		minimumResultsForSearch: Infinity
	});
});
