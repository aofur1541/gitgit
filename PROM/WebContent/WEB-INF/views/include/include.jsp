<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 페이지 기본 설정 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>PROM</title>

<!-- 파비콘 (웹 브라우저 아이콘) -->
<link href="${path}/resource/images/favicon.ico" rel="icon" type="image/x-icon">
<link href="${path}/resource/images/favicon.ico" rel="shortcut icon" type="image/x-icon">

<!-- 플러그인 - 제이쿼리 -->
<script src="${path}/resource/plugin/jquery-3.5.1/jquery.js"></script>

<!-- 플러그인 - 제이쿼리 UI -->
<!-- 부트스트랩과 충돌나기 때문에 제이쿼리와 제이쿼리 UI를 먼저 import 후에 부트스트랩을 import 시켜야 함 -->
<script type="text/javascript" src="${path}/resource/plugin/jquery-ui-1.12.1/jquery-ui.js"></script>
<link href="${path}/resource/plugin/jquery-ui-1.12.1/jquery-ui.css" rel="stylesheet" type="text/css">

<!-- 플러그인 - 부트스트랩 -->
<script src="${path}/resource/plugin/bootstrap-4.5.0/bootstrap.bundle.js"></script>
<link href="${path}/resource/plugin/bootstrap-4.5.0/bootstrap.css" rel="stylesheet" type="text/css">

<!-- 플러그인 - 폰트어썸 -->
<link href="${path}/resource/plugin/fontawesome-5/css/all.css" rel="stylesheet">

<!-- 플러그인 - 데이터테이블즈 -->
<link href="${path}/resource/plugin/dataTables-1.10.21/datatables.css" rel="stylesheet">
<script src="${path}/resource/plugin/dataTables-1.10.21/datatables.js"></script>

<!-- 플러그인 - 이차트 -->
<script type="text/javascript" src="${path}/resource/plugin/echarts-4.8.0/echarts.js"></script>

<!-- 플러그인 - 써머노트 -->
<link href="${path}/resource/plugin/summernote-0.8.18/summernote-lite.css" rel="stylesheet" type="text/css">
<script src="${path}/resource/plugin/summernote-0.8.18/summernote-lite.js"></script>
<script src="${path}/resource/plugin/summernote-0.8.18/lang/summernote-ko-KR.js"></script>

<!-- 플러그인 - 셀렉트2 -->
<link href="${path}/resource/plugin/select2/select2.css" rel="stylesheet" type="text/css">
<script src="${path}/resource/plugin/select2/select2.js"></script>

<!-- Global CSS -->
<link href="${path}/resource/css/main/layout.css" rel="stylesheet" type="text/css">
<link href="${path}/resource/css/main/style.css" rel="stylesheet" type="text/css">

<!-- Global CSS - Dark Mode  -->
<link href="${path}/resource/css/color/lightColor.css" rel="stylesheet" type="text/css" id="toggleColor">

<link href="${path}/resource/css/component/component.css" rel="stylesheet" type="text/css">
<link href="${path}/resource/css/component/lightComponent.css" rel="stylesheet" type="text/css" id="toggleComponent">

<!-- Global JS -->
<script src="${path}/resource/js/authority.js"></script>
<script src="${path}/resource/js/common.js"></script>
<script src="${path}/resource/js/regularExpressions.js"></script>
<script src="${path}/resource/js/date.js"></script>