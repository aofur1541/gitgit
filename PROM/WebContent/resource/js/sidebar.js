// 현재 URL 체크하기
var nowURL = window.location.pathname;

// 문의/공지 링크 설정
if (nowURL.includes('Notice') == true) {
	var nowURL = '/support/notice.prom'

} else if (nowURL.includes('Question') == true || nowURL.includes('Answer') == true) {
	var nowURL = '/support/question.prom'
} 

// 사이드바 링크 설정
var activeLink = $('a[href="' + nowURL + '"]');
var parent = activeLink.parent('li').parent('ul').parent('li');
var parents = parent.parents('li');

activeLink.addClass('active');

parents.addClass('sidebar-open');
parents.children('a').removeClass('collapsed');
parents.children('ul').removeClass('collapse').addClass('show');

parent.children('a').removeClass('collapsed');
parent.children('ul').removeClass('collapse').addClass('show');

if (parents.length != 1) {
	parent.addClass('sidebar-open');
}

// 사이드 바 클릭 시 효과
$('.sidebar-nav>.sidebar-item-submenu>.sidebar-link').click(function() {
	$('.sidebar-nav>.sidebar-item-submenu').removeClass('sidebar-open');
	$(this).parent().addClass('sidebar-open');
});

// 현재 위치 디렉토리에 표시하기
var title1 = parents.children('a').text();
var title2 = parent.children('a').text();
var title3 = parent.find('a.active').text();

if (title1) {
	$('.page-directory').html('<i class="fas fa-home"></i><i class="fas fa-chevron-right"></i><span>' + title1 + '</span><i class="fas fa-chevron-right"></i><span>' + title2 + '</span><i class="fas fa-chevron-right"></i><span>' + title3 + '</span>');

} else {
	$('.page-directory').html('<i class="fas fa-home"></i><i class="fas fa-chevron-right"></i><span>' + title2 + '</span><i class="fas fa-chevron-right"></i><span>' + title3 + '</span>');
}

// 현재 시간 출력 (1초)
$('#currentTime').html(currentTime());

setInterval(function() {
	$('#currentTime').html(currentTime());
}, 1000);