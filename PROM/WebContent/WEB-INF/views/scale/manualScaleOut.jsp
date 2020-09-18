<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/include/include.jsp"%>
	<%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
	<%@ include file="/WEB-INF/views/include/sessionCheck.jsp"%>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/loading.jsp"%>
	<%@ include file="/WEB-INF/views/include/navbar.jsp"%>
	<%@ include file="/WEB-INF/views/include/sidebar.jsp"%>

	<div class="content-wrapper">
		<%@ include file="/WEB-INF/views/include/directory.jsp"%>
		
		<!-- 본문 시작 -->
		<div class="content">
		
			<!-- 수동 scale out 모달 -->
			<div id="addManualScaleOut" class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header bg-prom">
							<h5 class="modal-title">수동 Scale Out 등록</h5>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body bg-light modal-type-4">
							<div class="card mb-0">
								<div class="card-header bg-white">
									<a href="#required-input" data-toggle="collapse">
										<span class="h6 card-title"><i class="icon-checkbox-checked2 text-prom mr-2"></i>필수 입력 정보</span>
										<i class="icon-arrow-down12 text-prom"></i>
									</a>
								</div>
								<div id="required-input" class="collapse show">
									<div class="card-body bg-light">
										<div class="row">
											<div class="col-sm-6 col-xl-6">
												<div class="form-group">
													<label>서비스 그룹:<span class="text-prom ml-2">(필수)</span></label>
													<select class="form-control select-search" id="tenantSB" data-fouc>
														<option value="" selected disabled>:: 서비스 그룹를 선택하십시오. ::</option>
													</select>
												</div>
											</div>
											<div class="col-sm-6 col-xl-6">
												<div class="form-group">
													<label>서비스:<span class="text-prom ml-2">(필수)</span></label>
													<select class="form-control select-search" id="tenantInServiceSB" data-fouc>
														<option value="" selected disabled>:: 서비스 그룹 선택후 선택할 수 있습니다. ::</option>
													</select>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-12 col-xl-12">
												<div class="form-group">
													<label>소스 가상머신:<span class="text-prom ml-2">(필수)</span></label>
													<select class="form-control select-search" id="serviceInVMSB" data-fouc>
														<option value="" selected disabled>:: 서비스 선택후 선택할 수 있습니다. ::</option>
													</select>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-6 col-xl-6">
												<div class="form-group">
													<label>네이밍:<span class="text-prom ml-2">(필수)</span></label>
													<input type="text" class="form-control form-control-modal" placeholder="naming" autocomplete="off" maxlength="50" onkeyup="manualScaleRegisterEnterkey()" id="naming">
												</div>
											</div>
											<div class="col-sm-6 col-xl-6">
												<div class="form-group">
													<label>Postfix:<span class="text-prom ml-2">(필수)</span></label>
													<input type="text" class="form-control form-control-modal" placeholder="postfix" autocomplete="off" maxlength="50" onkeyup="manualScaleRegisterEnterkey()" id="postfix">
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-6 col-xl-6">
												<div class="form-group">
													<label>시작 IP 주소:<span class="text-prom ml-2">(필수)</span></label>
													<input type="text" class="form-control form-control-modal" placeholder="start IP address" autocomplete="off" onkeyup="manualScaleRegisterEnterkey()" id="startIPAddr">
												</div>
											</div>
											<div class="col-sm-6 col-xl-6">
												<div class="form-group">
													<label>끝 IP 주소:<span class="text-prom ml-2">(필수)</span></label>
													<input type="text" class="form-control form-control-modal" placeholder="end IP address" autocomplete="off" onkeyup="manualScaleRegisterEnterkey()" id="endIPAddr">
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer bg-white">
							<button type="button" class="btn bg-prom rounded-round" onclick="synthesisInputValidation('',0)">등록<i class="icon-checkmark2 ml-2"></i></button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 수동 scale out 테이블 -->
			<table id="tableManualScaleOut" class="cell-border hover" style="width: 100%">
				<thead>
					<tr>
						<th rowspan="2">서비스</th>
						<th rowspan="2">네이밍 룰</th>
						<th colspan="2" class="text-center">IP 주소</th>
						<th rowspan="2">소스 가상머신</th>
					</tr>
					<tr>
						<th>시작</th>
						<th style="border-right: 1px solid #E0E0E0;">끝</th>
					</tr>
				</thead>
			</table>
		</div>
		<!-- 본문 끝 -->
	</div>

	<script src="${path}/resource/js/sidebar.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			getManualScaleOutList();
			getTenantList();

			$(document).on('change', '#tenantSB', function() {
				serviceInTenant();
			})

			$(document).on('change', '#tenantInServiceSB', function() {
				getVMsInService();
			})

			$(document).on('change', '#defaultHostSB', function() {
				hostinDataStoreList();
				hostinNetworkList();
			})

		})
		
		function getManualScaleOutList() {
			var tableManualScaleOut = $('#tableManualScaleOut').addClass('nowrap').DataTable({
				dom: "<'datatables-header'<'createB'><'manageB'>B>" + "<'datatables-body'rt>" + "<'datatables-footer'ifp>",
				ajax: {
					url: "/environ/getManualScaleOutList.do",
					type: "POST",
					dataSrc: ""
				},
				columns: [
					{data: "service_ids"},
					{data: "naming", render: function(data, type, row) {
						data = data + '<span class="text-point">' + row.postfix + '</span>';
						
						return data;
					}},
					{data: "startIP"},
					{data: "endIP"},
					{data: "template_ids"}
				],
				language: datatables_lang,
				colReorder: true,
				stateSave: true,
				lengthMenu: [[10, 25, 50, -1], ['10', '25', '50', '전체']],
				buttons: [{
					extend: "collection",
					text: "<i class='fas fa-download'></i><span>내보내기</span>",
					className: "btn exportBtn",
					buttons: [{
							extend: "csvHtml5",
							charset: "UTF-8",
							bom: true,
							text: "CSV",
							title: "수동 Scale Out 정보"
						},
						{
							extend: "excelHtml5",
							text: "Excel",
							title: "수동 Scale Out 정보"
						}
					]
				}, {
					extend: "pageLength",
					className: "btn pageLengthBtn",
				}, {
					extend: 'colvis',
					text: '테이블 편집',
					className: 'btn colvisBtn'
				}]
			});
			
			tableManualScaleOutButton(tableManualScaleOut);
		}
		
		// 관리 버튼 설정
		function tableManualScaleOutButton(tableManualScaleOut){
			$('.createB').html('<button type="button" class="btn createBtn" data-toggle="modal" data-target="#addManualScaleOut"><i class="fas fa-plus"></i><span>등록</span></button>');
			$('.manageB').html('<button type="button" class="btn manageBtn"><i class="fas fa-ellipsis-h"></i><span>관리</span></button>');
			
			$('.manageBtn').click(function() {
				alert('행을 선택해 주세요.');
			});
			
			// 행 선택 시
			$('#tableManualScaleOut').on('click', 'tr', function() {
				var data = tableManualScaleOut.row(this).data();
				
				if (data != undefined){
					$(this).addClass('selected');
					$('#tableManualScaleOut tr').not(this).removeClass('selected');
					
					// 관리 버튼 활성화
					var html = '';
					
					html += '<button type="button" class="btn manageBtn" data-toggle="dropdown"><i class="fas fa-ellipsis-h"></i><span>관리</span></button>';
					html += '<div class="dropdown-menu">';
					html += '<a href="#" class="dropdown-item" onclick="manualScaleUpdateCheck('+data.id+','+ 3 + ')">수동 Scale Out 실행</a>';
					html += '<div class="dropdown-divider"></div>';
					html += '<a href="#" class="dropdown-item" onclick="manualScaleUpdateCheck('+data.id+','+ 2 + ')">수동 Scale Out 정보 변경</a>';
					html += '<a href="#" class="dropdown-item" onclick="manualScaleDelete('+data.id+', "'+ data.service_ids + '")">수동 Scale Out 삭제</a>';
					html += '</div>';
					
					$('.manageB').empty().append(html);
				}
			});
		}
		
		
		
		
		
		
		
		
		
		
		
		
		

		function manualScaleRegisterEnterkey() {
			if (window.event.keyCode == 13) {
				synthesisInputValidation('', 0);
			}
		}

		function synthesisInputValidation(category, id) {
			var add = '';
			var msg = '';
			var url = '';

			if (category == 'up') {
				add = 'up';
				msg = '수정'
				url = '/environ/upManualScaleOutInfo.do';
			} else if (category == '') {
				add = '';
				msg = '등록'
				url = '/environ/setManualScaleOutInfo.do';
			}

			var tenantSBval = $("#tenantSB" + add + " option:selected").val();
			var serviceSBval = $("#tenantInServiceSB" + add + " option:selected").val();
			var serviceSBtext = $("#tenantInServiceSB" + add + " option:selected").text();

			var serviceInVMSB = $("#serviceInVMSB" + add + " option:selected").val();

			var naming = $("#naming" + add).val();
			var postfix = $("#postfix" + add).val();
			var startIPAddr = $("#startIPAddr" + add).val();
			var endIPAddr = $("#endIPAddr" + add).val();

			if (!tenantSBval) {
				alert("서비스 그룹를 선택하십시오.");
				$("#tenantSB" + add).focus();
				return false;
			} else if (!serviceSBval) {
				alert("서비스를 선택하십시오");
				$("#tenantInServiceSB" + add).focus();
				return false;
			} else if (!serviceInVMSB) {
				alert("소스 가상머신을 선택하십시오");
				$("#serviceInVMSB" + add).focus();
				return false;
			} else if (!naming) {
				alert("네이밍은 필수 기입 항목입니다.");
				$("#naming" + add).focus();
				return false;
			} else if (hangulchk.test(naming)) {
				$("#naming" + add).focus();
				alert("네이밍 룰에 한글을 넣을 수 없습니다.");
				return false;
			} else if (blank_pattern.test(naming)) {
				$("#naming" + add).focus();
				alert("네이밍 룰에 공백(띄어쓰기)을 넣을 수 없습니다.");
				return false;
			} else if (!postfix) {
				alert("Postfix는 필수 기입 항목입니다.");
				$("#postfix" + add).focus();
				return false;
			} else if (numberRegexchk.test(postfix)) {
				alert("Postfix의 값은 숫자로만 넣어야 합니다.");
				$("#postfix" + add).focus();
				return false;
			} else if (!startIPAddr) {
				alert("시작 IP 주소는 필수 기입 항목입니다.");
				$("#startIPAddr" + add).focus();
				return false;
			} else if (!filter.test(startIPAddr)) {
				$("#startIPAddr" + add).focus();
				alert("시작IP의 IP4 형식이 올바르지 않습니다.");
				return false;
			} else if (!filter.test(endIPAddr)) {
				$("#endIPAddr" + add).focus();
				alert("끝IP의 IP4 형식이 올바르지 않습니다.");
				return false;
			} else if (!endIPAddr) {
				alert("끝 IP 주소는 필수 기입 항목입니다.");
				$("#endIPAddr" + add).focus();
				return false;
			} else {

				if (confirm("수동 Scale Out " + msg + "을 하시겠습니까?") == true) {

					$.ajax({

						url: url,
						type: "POST",
						dataType: "json",
						contentType: "application/json;charset=UTF-8",
						data: JSON.stringify({
							id: id,
							service_id: serviceSBval,
							service_ids: serviceSBtext,
							template_id: serviceInVMSB,
							naming: naming,
							postfix: postfix,
							startIP: startIPAddr,
							endIP: endIPAddr
						}),
						success: function(data) {
							if (data == 1) {
								alert("수동 Scale Out " + msg + "이 완료되었습니다.");
								window.parent.location.reload();
							} else if (data == 2) {
								alert("해당 서비스는 이미 수동 Scale Out이 등록되어 있습니다.");
							}
						},
						error: function() {
							console.log("통신 에러 ");
						}
					})

				} else {
					return false;
				}
			}
		}

		function runInputValidation(id) {

			var manualVMName = $("#vmName").val();
			var manualIP = $("#ipAddr").val();
			var manualHost = $("#defaultHostSB").val();
			var manualStorage = $("#defaultStorageSB").val();
			var manualNetwork = $("#defaultNetworkSB").val();

			var url = '';
			var html = '';

			url = '/rest/runManualScaleOut.do';

			$.ajax({

				url: url,
				type: "POST",
				dataType: "json",
				contentType: "application/json;charset=UTF-8",
				data: JSON.stringify({
					id: id,
					manualVMName: manualVMName,
					manualHost: manualHost,
					manualStorage: manualStorage,
					manualNetwork: manualNetwork,
					manualIP: manualIP,
				}),
				beforeSend: function() {
					html += '<i class="icon-spinner2 spinner mr-4"></i>Creating...';
					$("#modal-footer").empty();
					$("#modal-footer").append(html);
				},
				success: function(data) {
					if (data == 2) {
						window.parent.location.reload();
					}
				},
				error: function() {
					console.log("통신 에러 ");
				}
			})

		}

		function getTenantList() {

			$.ajax({
				url: "/tenant/selectTenantList.do",
				success: function(data) {
					var html = '';
					html += '<option value="" selected disabled>:: 서비스 그룹를 선택하십시오. ::</option>';

					for (key in data) {
						html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
					}

					$("#tenantSB").empty();
					$("#tenantSB").append(html);
				}
			})
		}

		function serviceInTenant() {
			var tenantsID = $("#tenantSB option:selected").val();

			$.ajax({
				data: {
					tenantId: tenantsID
				},
				url: "/tenant/selectVMServiceListByTenantId.do",
				success: function(data) {
					var html = '';
					if (data == null || data == '') {
						html = '<option value="" selected disabled>:: 서비스 그룹에 포함된 서비스가 없습니다. ::</option>';
					} else {
						for (key in data) {
							html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].dhcpOnoff + '>' + data[key].vmServiceName + '</option>';
						}
					}
					$("#tenantInServiceSB").empty();
					$("#tenantInServiceSB").append(html);
					getVMsInService();
				}
			})
		}

		function getVMsInService() {

			var service_id = $("#tenantInServiceSB option:selected").val();
			if (typeof service_id === 'undefined' || service_id == '') {
				console.log(service_id);
				service_id = 0;
			}

			$.ajax({

				url: '/environ/getVMsInService.do',
				data: {
					service_id: service_id
				},
				success: function(data) {
					var html = '';
					if (data == null || data == '') {
						html = '<option value="" selected disabled>:: 서비스 그룹에 포함된 서비스가 없습니다. ::</option>';
					} else {
						for (key in data) {
							html += '<option value=' + data[key].vm_ID + '>' + data[key].vm_name + '</option>';
						}
					}
					$("#serviceInVMSB").empty();
					$("#serviceInVMSB").append(html);
				}
			})
		}

		function getTenantListUp(tenants_id, service_id, template_id, template_ids) {
			$.ajax({
				url: "/tenant/selectTenantList.do",
				success: function(data) {
					var html = '';
					for (key in data) {
						if (tenants_id != data[key].id) {
							html += '<option value=' + data[key].id + ' value2=' + data[key].name + '>' + data[key].name + '</option>';
						} else {
							html += '<option value=' + data[key].id + ' value2=' + data[key].name + ' selected>' + data[key].name + '</option>';
						}
					}
					$("#tenantSBup").empty();
					$("#tenantSBup").append(html);
					serviceInTenantUp(service_id, template_id, template_ids);
				}
			})
		}

		function serviceInTenantUp(service_id, template_id, template_ids) {
			var tenantsID = $("#tenantSBup option:selected").val();
			$.ajax({
				data: {
					tenantId: tenantsID
				},
				url: "/tenant/selectVMServiceListByTenantId.do",
				success: function(data) {
					var html = '';
					if (data == null || data == '') {
						html = '<option value="" selected disabled>:: 서비스 그룹에 포함된 서비스가 없습니다. ::</option>';
					} else {
						for (key in data) {
							if (service_id != data[key].vmServiceID) {
								html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].dhcpOnoff + '>' + data[key].vmServiceName + '</option>';
							} else {
								html += '<option value=' + data[key].vmServiceID + ' value2=' + data[key].dhcpOnoff + ' selected>' + data[key].vmServiceName + '</option>';
							}
						}
					}
					$("#tenantInServiceSBup").empty();
					$("#tenantInServiceSBup").append(html);
					getVMsInServiceUp(service_id, template_id, template_ids);
				}
			})
		}

		function getVMsInServiceUp(service_id, template_id, template_ids) {

			if (typeof service_id === 'undefined' || service_id == '') {
				console.log(service_id);
				service_id = 0;
			}

			$.ajax({

				url: '/environ/getVMsInService.do',
				data: {
					service_id: service_id
				},
				success: function(data) {
					var html = '';
					if (data == null || data == '') {
						html = '<option value="" selected disabled>:: 서비스에 포함된 가상머신이 없습니다. ::</option>';
					} else {
						if (template_ids == '없음') {
							html += '<option value="" selected>없음</option>';
						}
						for (key in data) {

							if (template_id != data[key].vm_ID) {
								html += '<option value=' + data[key].vm_ID + '>' + data[key].vm_name + '</option>';
							} else {
								html += '<option value=' + data[key].vm_ID + ' selected>' + data[key].vm_name + '</option>';
							}
						}
					}
					$("#serviceInVMSBup").empty();
					$("#serviceInVMSBup").append(html);
				}
			})
		}

		function manualScaleUpdateCheck(id, index) {

			$.ajax({
				url: "/environ/getOneManualScaleOut.do",
				data: {
					id: id
				},
				success: function(data) {
					btnStatusChk(id, index);
					for (key in data) {
						getTenantListUp(data[key].tenants_id, data[key].service_id, data[key].template_id, data[key].template_ids);
						$("#namingup").val(data[key].naming);
						$("#postfixup").val(data[key].postfix);
						$("#startIPAddrup").val(data[key].startIP);
						$("#endIPAddrup").val(data[key].endIP);

						if (index == 3) {
							getLowestHostsInCluster(data[key].clusterID, data[key].default_storage, data[key].default_network);
							getMaximumIP(data[key].service_id, data[key].startIP, data[key].endIP);
							$("#runDiv").show();
							$("#changeDiv").hide();
							$("#vmName").val(data[key].naming + data[key].postfix);
						} else {
							$("#runDiv").hide();
							$("#changeDiv").show();
						}
					}
					$("#changeManualScaleOut").modal("show");
				}
			})
		}

		function getMaximumIP(serviceId, startIP, endIP) {
			$.ajax({
				url: "/environ/getMaximumIPInService.do",
				data: {
					service_id: serviceId,
					startIP: startIP,
					endIP: endIP
				},
				success: function(data) {
					if (data == null || data == '') {
						$("#ipAddr").val(0);
					} else {
						$("#ipAddr").val(data[0].vm_ipaddr1);
					}
				}
			})

		}

		function overIPChk() {

			var startIP = $("#startIPAddrup").val();
			var endIP = $("#endIPAddrup").val();

			var nowIP = $("#ipAddr").val();

			var startSplit = startIP.split('.');
			var endSplit = endIP.split('.');

			var startResult = startSplit[startSplit.length - 1];
			var endResult = endSplit[endSplit.length - 1];

			if (nowIP.length > 8) {

				var nowSplit = nowIP.split('.');
				var nowResult = nowSplit[nowSplit.length - 1];

				if (nowResult != '' && (nowResult < startResult || nowResult > endResult)) {
					$("#ipAddr").css("background-color", "orange");
				} else {
					$("#ipAddr").css("background-color", "white");
				}

			}

		}

		function getLowestHostsInCluster(clusterId, storageId, networkId) {

			$.ajax({

				url: '/environ/getLowestHostsInCluster.do',
				data: {
					clusterId: clusterId
				},
				success: function(data) {
					var html = '';
					if (data == null || data == '') {
						html = '<option value="" selected disabled>:: 클러스터에 포함된 호스트가 없습니다. ::</option>';
					} else {
						for (key in data) {
							html += '<option value=' + data[key].vm_Hhostname + '>' + data[key].vm_Hhostname + '</option>';
						}
					}
					$("#defaultHostSB").empty();
					$("#defaultHostSB").append(html);
					hostinDataStoreList(storageId);
					hostinNetworkList(networkId);
				}
			})
		}

		function btnStatusChk(id, index) {
			var header = '';
			var footer = '';
			var category = "\'" + 'up' + "\'";

			if (index == 1) {
				header += '<h5 class="modal-title mb-0">수동 Scale Out 상세 보기</h5>';
				$("#modal-footer").hide();

			} else if (index == 2) {
				header += '<h5 class="modal-title mb-0">수동 Scale Out 정보 변경</h5>';
				footer += '<button type="button" class="btn bg-prom rounded-round" onclick="synthesisInputValidation(' + category + ',' + id + ')">변경사항 저장<i class="icon-checkmark2 ml-2"></i></button>';
				$("#modal-footer").show();

			} else if (index == 3) {
				header += '<h5 class="modal-title mb-0">수동 Scale Out 실행</h5>';
				footer += '<button type="button" class="btn bg-prom rounded-round" onclick="runInputValidation(' + id + ')">실행<i class="icon-checkmark2 ml-2"></i></button>';
				$("#modal-footer").show();
			}

			header += '<button type="button" class="close" data-dismiss="modal">&times;</button>';

			$("#modal-header").empty();
			$("#modal-header").append(header);

			$("#modal-footer").empty();
			$("#modal-footer").append(footer);

			$("#required-inputup").addClass("show");

			if (index == 1) {
				$("#tenantSBup").attr("disabled", true);
				$("#tenantInServiceSBup").attr("disabled", true);
				$("#serviceInVMSBup").attr("disabled", true);
				$("#namingup").attr("disabled", true);
				$("#postfixup").attr("disabled", true);
				$("#startIPAddrup").attr("disabled", true);
				$("#endIPAddrup").attr("disabled", true);

			} else if (index == 2) {
				$("#tenantSBup").attr("disabled", true);
				$("#tenantInServiceSBup").attr("disabled", true);
				$("#serviceInVMSBup").attr("disabled", false);
				$("#namingup").attr("disabled", false);
				$("#postfixup").attr("disabled", false);
				$("#startIPAddrup").attr("disabled", false);
				$("#endIPAddrup").attr("disabled", false);

			} else if (index == 3) {
				$("#tenantSBup").attr("disabled", true);
				$("#tenantInServiceSBup").attr("disabled", true);
				$("#serviceInVMSBup").attr("disabled", true);
			}
		}

		//삭제
		function manualScaleDelete(id, serviceName) {

			var msg = '삭제';
			var url = '/environ/deleteManualScaleOutInfo.do';

			if (confirm("수동 Scale Out " + msg + "을 하시겠습니까?") == true) {

				$.ajax({

					url: url,
					type: "POST",
					dataType: "json",
					contentType: "application/json;charset=UTF-8",
					data: JSON.stringify({
						id: id,
						service_ids: serviceName
					}),
					success: function(data) {
						if (data == 1) {
							alert("수동 Scale Out " + msg + "가 완료되었습니다.");
							window.parent.location.reload();
						}
					},
					error: function() {
						console.log("통신 에러 ");
					}
				})

			} else {
				return false;
			}
		}
	</script>
</body>

</html>