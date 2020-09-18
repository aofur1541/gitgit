
var hangulchk = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
var regchk = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/; //비밀번호 8자 이상 숫자/대소문자/특수문자 포함
var numberRegexchk= /[^0-9]/g // 숫자만

var hangulRegexchk = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g; //한글만
var phone_numRegexchk =  /^\d{2,3}-\d{3,4}-\d{4}$/; //phone_number 
var ipRegexchk = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/;
var filter = /^([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\.([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])){3}$/;
var blank_pattern = /[\s]/g;

var USER_NAPP = 1;
var USER_NAME = '사용자';

var USER_HEAD_NAPP = 2;
var USER_HEAD_NAME = '부서장';

var MANAGER_NAPP = 11;
var MANAGER_NAME = '담당자';

var MANAGER_HEAD_NAPP = 12;
var MANAGER_HEAD_NAME = '검토 승인자';

var OPERATOR_NAPP = 21;
var OPERATOR_NAME = '운영자';

var CONTROL_OPERATOR_NAPP = 20;
var CONTROL_OPERATOR_NAME = '관제 OP';

var ADMIN_NAPP = 99;
var ADMIN_NAME = '관리자';

var ADMINCHECK = 10;
var CONTROLCHECK = 20;

var BanNumber = 20;
var BanNumber2 = 21;
var BanNumber3 = 2;