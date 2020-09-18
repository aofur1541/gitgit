<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<script type="text/javascript">
		$(document).ready(function() {
			var promptValue = prompt("관리자 비밀번호");
			if (promptValue == 'VMware1!') {
				alert("환영합니다 관리자님");
				vROconfigSelect();
				administratorCheck();
			} else {
				alert("관리자만 들어올 수 있습니다.");
				location.href = 'mainboard.do';
			}

		});

		function LicenseSelect() {
			$.ajax({

				url: "/jquery/LicenseKeySelect.do",
				asnyc: false,
				success: function(data) {
					var html = '';
					html += '<h4><b>라이센스 목록</b></h4>';
					for (key in data) {
						if (data[key].sSerialuseCheck == 0) {
							html += '<h5>' + data[key].sSerialKey.substring(0, 8) + "-" + data[key].sSerialKey.substring(8, 12) + "-" + data[key].sSerialKey.substring(12, 16) + "-" + data[key].sSerialKey.substring(16, 20) + "-" + data[key].sSerialKey.substring(20, 32) + ' 유효기간 :<span class="text-warning">  ' + data[key].sSerialCategory + '</span></h5>';
						} else if (data[key].sSerialuseCheck == 1) {
							html += '<h5 class="text-slate">사용된 라이선스 ' + data[key].sSerialKey.substring(0, 8) + "-" + data[key].sSerialKey.substring(8, 12) + "-" + data[key].sSerialKey.substring(12, 16) + "-" + data[key].sSerialKey.substring(16, 20) + "-" + data[key].sSerialKey.substring(20, 32) + ' 유효기간 : ' + data[key].sSerialCategory + '</h5>';
						}
					}
					$("#LicenseView").empty();
					$("#LicenseView").append(html);
				}
			})
		}

		function administratorCheck() {
			<
			c: if test = "${sessionAppEL < ADMINCHECK}" >
				$("#configForm").hide();
			alert("관리자만 들어올 수 있습니다.");
			location.href = 'mainboard.do'; <
			/c:if>
		}

		function vROconfig() {

			var vROURL = $("#vRoUrl").val();
			var vROSSOID = $("#vRoSSoID").val();
			var vROSSOPW = $("#vRoSSoPW").val();
			var vCURL = $("#vCURL").val();

			$.ajax({
				url: "vROconfig.do",
				data: {
					vROURL: vROURL,
					vROSSOID: vROSSOID,
					vROSSOPW: vROSSOPW,
					vCURL: vCURL
				},
				success: function(data) {
					var html = '';
					html += 'vROUrl : <input type="text" class="col-md-12" name="vRoUrl" id="vRoUrl" value=' + data.vROURL + '><br>';
					html += 'vROID : <input type="text"  class="col-md-12" name="vRoSSoID" id="vRoSSoID" value=' + data.vROSSOID + '><br>';
					html += 'vROPW : <input type="text"  class="col-md-12" name="vRoSSoPW" id="vRoSSoPW" value=' + data.vROSSOPW + '><br>';
					html += 'vCURL : <input type="text"  class="col-md-12" name="vCURL" id="vCURL" value=' + data.vCURL + '><br>';
					html += '<br><br>';
					html += '<button type="button" onclick="vROconfig()">적용</button>';
					$("#configForm").empty();
					$("#configForm").append(html);
					vROconfigSelect();
				}

			})
		}

		function vROconfigSelect() {
			$.ajax({

				url: "vROconfigSelect.do",
				success: function(data) {
					var html = '';
					if (data == null || data == '') {
						html += '먼저 vRo 설정이 되어있지 않습니다.  vRo의 설정을 해주세요.';
						html += 'vROUrl : <input type="text" class="col-md-12" name="vRoUrl" id="vRoUrl">https://DNS||IP:8281/vco/api/<br>';
						html += 'vROID : <input type="text"  class="col-md-12" name="vRoSSoID" id="vRoSSoID">administrator@vsphere.local<br>';
						html += 'vROPW : <input type="text"  class="col-md-12" name="vRoSSoPW" id="vRoSSoPW"><br>'
						html += 'vCURL : <input type="text"  class="col-md-12" name="vCURL" id="vCURL">https://vcenterip<br>';
						html += '<br><br>';
						html += '<button type="button" onclick="vROconfig()">적용</button>';
					} else {
						html += 'vROUrl : <input type="text" class="col-md-12" name="vRoUrl" id="vRoUrl" value=' + data.vROURL + '>https://value:8281/vco/api/<br>';
						html += 'vROID : <input type="text"  class="col-md-12" name="vRoSSoID" id="vRoSSoID" value=' + data.vROSSOID + '>administrator@vSphere.local<br>';
						html += 'vROPW : <input type="text"  class="col-md-12" name="vRoSSoPW" id="vRoSSoPW" value=' + data.vROSSOPW + '><br>'
						html += 'vCURL : <input type="text"  class="col-md-12" name="vCURL" id="vCURL" value=' + data.vCURL + '>https://vcenterip<br>';
						html += '<br><br>';
						html += '<button type="button" onclick="vROconfig()">적용</button>';
					}
					$("#configForm").empty();
					$("#configForm").append(html);
				}
			})
		}

		function CreateLicenseKey() {
			var licenseSelect = $("#licenseSelect option:selected").val();
			$.ajax({

				url: "/jquery/CreateLicenseKey.do",
				data: {
					licenseSelect: licenseSelect
				},
				success: function(data) {
					if (data == 1) {
						alert("라이센스 생성 완료");
						LicenseSelect();
					}
				}
			})
		}
	</script>

</head>

<body>

	<form id="configForm">
		<%-- vCenter : <input type="text" name="vCenter" id="vCenter" value="${vCenter }"><br> --%>
		Loading...
	</form>
	<hr><br><br>
	<div>
		<button type="button" onclick="LicenseSelect()" id="RetainlicenseBtn">보유 라이센스 키 보기</button>
		<select id="licenseSelect">
			<optgroup label="라이선스 유효기간">
				<option value="Month">30일</option>
				<option value="Year">1년</option>
			</optgroup>
		</select>
		<button type="button" onclick="CreateLicenseKey()" id="CreateLicenseBtn">라이센스 생성하기</button>
		<div id="LicenseView"></div>
	</div>
</body>

</html>