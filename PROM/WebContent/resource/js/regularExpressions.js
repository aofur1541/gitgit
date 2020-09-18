// 숫자
var pattern_num = /[0-9]/;

// 한글
var pattern_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;

// 특수문자
var pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/;

// 공백
var pattern_blank = /[\s]/g;

// 전화번호
var pattern_phoneNum = /^\d{2,3}-\d{3,4}-\d{4}$/;


// IP 주소
var pattern_ipAddress = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/;