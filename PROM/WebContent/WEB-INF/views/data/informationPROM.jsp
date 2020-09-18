<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/include/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript">
			
			$(function(){
				$("#vCenterSidebar").hide();
				var sBtn = $(".chartup > li");
				sBtn.find("button").click(function(){
				sBtn.removeClass("active");
				$(this).parent().addClass("active");
				})
			$(".license").keyup(function(e) { 
				if (!(e.keyCode >=37 && e.keyCode<=40)) {
					var v = $(this).val();
					$(this).val(v.replace(/[^a-z0-9]/gi,''));
				}
			})
			LicenseCheck();	
			})
			
			function LicenseCheck(){
				
				$.ajax({
			    	
					  url:"/jquery/LicenseCheck.do",
					  success : function(data){
							var html = '';
							var title = '';
							var info = '';
							var licenseInput = '';
							var licenseOKBtnCall = '';
							if(!data || data == null || data == ''){
							//html += '<div class="alert bg-teal text-white alert-styled-left alert-dismissible">';
							//html += '<span class="font-weight-semibold">라이선스가 만료됐거나 없습니다 라이선스가 없을 경우 동작이 제대로 되지 않을 수 있습니다.</span>';
							//html += '<button class="btn bg-blue" data-toggle="modal" data-target="#modal_form_horizontal" style="margin-left: 120px; id="modalBtn2"><i class="icon-key"></i>License 등록하기</button>';
							//html += '</div>';	
							licenseInput += '<div class="row">';
							licenseInput += '<div class="col-md-2">';
							licenseInput += '<input type="text" placeholder="License" tabindex="1" onKeyUp="autoTab(this, this.value)" id="licenseInput1" class="form-control license" maxlength="8" autofocus="autofocus">';
							licenseInput += '</div>';
							licenseInput += '<div class="col-md-2">';
							licenseInput += '<input type="text" placeholder="License" tabindex="2" onKeyUp="autoTab(this, this.value)" id="licenseInput2" class="form-control license" maxlength="4">';
							licenseInput += '</div>';
							licenseInput += '<div class="col-md-2">';
							licenseInput += '<input type="text" placeholder="License" tabindex="3" onKeyUp="autoTab(this, this.value)" id="licenseInput3" class="form-control license" maxlength="4">';
							licenseInput += '</div>';
							licenseInput += '<div class="col-md-2">';
							licenseInput += '<input type="text" placeholder="License" tabindex="4" onKeyUp="autoTab(this, this.value)" id="licenseInput4" class="form-control license" maxlength="4">';
							licenseInput += '</div>';
							licenseInput += '<div class="col-md-3">';
							licenseInput += '<input type="text" placeholder="License" tabindex="5" id="licenseInput5" class="form-control license" maxlength="12">';
							licenseInput += '</div>';
							licenseInput += '</div>';
							licenseOKBtnCall += '<button type="button" onclick="LicenseConfirm()" class="btn btn-primary col-lg-12 " id="licenseOKBtn">등록</button>';
							info += '<p>라이선스 미등록 상태</p>';
							$("#noLicense").empty();
							$("#noLicense").append(html);
							$("#licenseInput").empty();
							$("#licenseInput").append(licenseInput);
							$("#licenseOKBtnCall").empty();
							$("#licenseOKBtnCall").append(licenseOKBtnCall);
							$("#licenseinfo").empty();
	  					 	$("#licenseinfo").append(info);
							
							//noLicenseRestrictions();	
							} else {
							title += '<i class="icon-puzzle3"></i>등록된 라이선스';
							html += '<div class="modal-body">';
	  					    html += '<p>라이선스 키 : '+data.sSerialKey.substring(0,8)+"-"+data.sSerialKey.substring(8,12)+"-"+data.sSerialKey.substring(12,16)+"-"+data.sSerialKey.substring(16,20)+"-"+data.sSerialKey.substring(20,32)+'</p>';
	  					    html += '</div>';
	  					    info += '<div class="list-feed-item border-blue" >';
							info += '<span>제품 : PROM Cloud v.1.5.0 </span>';
							info += '<span> </span>';
							info += '</div>';
							info += '<div class="list-feed-item border-blue" >';
							info += '<span>라이선스 유형 : 일반 </span>';
							info += '<span> </span>';
							info += '</div>';
							info += '<div class="list-feed-item border-blue" >';
							info += '<span> 연동 : vCenter </span>';
							info += '<span> </span>';
							info += '</div>';
							info += '<div class="list-feed-item border-blue" >';
							info += '<span>만료 날짜 : '+data.dSerialStopTime+'</span>';
							info += '<span> </span>';
							info += '</div>';
							info += '<div class="list-feed-item border-blue" >';
							info += '<span> 제작 : KDIS </span>';
							info += '</div>';
	  					    //html += '<button type="button" class="btn bg-primary">라이선스 연장</button>';
	  					    $("#licenseTitle").empty();
	  					    $("#licenseTitle").append(title);
	  					    $("#licenseBody").empty(); 
	  					    $("#licenseBody").append(html); 
	  					 	$("#licenseinfo").empty();
	  					 	$("#licenseinfo").append(info);
							}					
					  }
				})	
			}
			
			function autoTab(tabno, invalue) {
					  if(invalue.length == tabno.maxLength) {
					  var nextin = tabno.tabIndex;
					  	if(nextin < document.forms[0].elements.length)
							document.forms[0].elements[nextin].focus();
					  }
					}  
			
			function vCenterView(){
				alert("공사중...");
				return false;
				$("#vCenterSidebar").show();
				$.ajax({

				success:function(data){
					var cardheader = '';
					var html = '';
					cardheader += '<h5 class="card-title"><i class="icon-make-group"></i>vCenter Specification</h5>';
					
					html +='<div class="vCenterspec">';
					html +='<ul class="nav nav-tabs nav-tabs-highlight nav-justified">';
					html +='<li class="nav-item"><a href="#highlighted-justified-tab1" class="nav-link active show" data-toggle="tab"><b><i class="icon-windows2"></i>vCenter 요약 정보</b></a></li>';
					html +='<li class="nav-item"><a href="#highlighted-justified-tab2" class="nav-link" data-toggle="tab"><b><i class=""></i>내용1</b></a></li>';
					html +='<li class="nav-item"><a href="#highlighted-justified-tab3" class="nav-link" data-toggle="tab"><b><i class=""></i>내용2</b></a></li>';
					html +='<li class="nav-item"><a href="#highlighted-justified-tab4" class="nav-link" data-toggle="tab"><b><i class=""></i>내용3</b></a></li>';
					html +='</ul>';
					
					html +='<div class="tab-content">';
					html +='<div class="tab-pane fade active show" id="highlighted-justified-tab1">';
					html +='<div class="d-flex justify-content-center align-items-center">';
					html +='요약정보';
					html +='</div></div>';
					/* html +='<div class="tab-pane fade" id="highlighted-justified-tab2">';
					html +='<div class="d-flex justify-content-center align-items-center">';
					html +='내용1';
					html +='</div></div>';
					
					html +='<div class="tab-pane fade" id="highlighted-justified-tab3">';
					html +='<div class="d-flex justify-content-center align-items-center">';
					html +='내용2';
					html +='</div></div>';
					html +='<div class="tab-pane fade" id="highlighted-justified-tab4">';
					html +='<div class="d-flex justify-content-center align-items-center">';
					html +='내용3';
					html +='</div></div> */
					html += '</div>';

					$("#licensestitle").empty();
					$("#licensestitle").append(cardheader);
					$("#licenseinfor").empty();
					$("#licenseinfor").append(html);
				
				}
				})
			}
			
			function LicenseConfirm(){
			    var licenseInput1 = $("#licenseInput1").val();
			    var licenseInput2 = $("#licenseInput2").val();
			    var licenseInput3 = $("#licenseInput3").val();
			    var licenseInput4 = $("#licenseInput4").val();
			    var licenseInput5 = $("#licenseInput5").val();
			    var StringSum = '';
			    if(!licenseInput1 || licenseInput1.length < 8){
			    	alert("첫번째 라이선스 키를 입력 해주세요");
			    	$("#licenseInput1").focus();
			    	return false;
			    } else if(!licenseInput2 || licenseInput2.length < 4){
			    	alert("두번째 라이선스 키를 입력 해주세요");
			    	$("#licenseInput2").focus();
			    	return false;
			    } else if(!licenseInput3 || licenseInput3.length < 4){
			    	alert("세번째 라이선스 키를 입력 해주세요");
			    	$("#licenseInput3").focus();
			    	return false;
			    } else if(!licenseInput4 || licenseInput4.length < 4){
			    	alert("네번째 라이선스 키를 입력 해주세요");
			    	$("#licenseInput4").focus();
			    	return false;
			    } else if(!licenseInput5 || licenseInput5.length < 12){
			    	alert("다섯번째 라이선스 키를 입력 해주세요");
			    	$("#licenseInput5").focus();
			    	return false;
			    } else {
			    StringSum = licenseInput1+licenseInput2+licenseInput3+licenseInput4+licenseInput5;
			    if(StringSum.length < 32){ alert("라이선스 키의 자릿수가 맞지 않습니다."); return false }
			    else {  
			
			    	$.ajax({
			    	
					  url:"/jquery/LicenseInsert.do",
					  data : { StringSum : StringSum },
					  success : function(data){
						  var replace;
				          var sum;
			    		  var date = new Date();
						  if(data == null || data == ''){
							  alert("등록되지 않은 라이선스 키입니다.");
						  } else {
						if(data.sSerialCategory == "Month"){replace = '30일'; sum = 30} 
						else if(data.sSerialCategory == "Year"){replace = '1년'; sum =365}
			    	    date.setDate(date.getDate()+sum);
				         var year = date.getFullYear();
			    	     var month = date.getMonth() + 1;
			    	     var day = date.getDate();
			    		if(confirm("이 라이선스 키를 등록하시겠습니까?\n유효기간:"+replace+"\n"+year+"-"+month+"-"+day+"까지") == true){
			    			$.ajax({
			    		    	
			    				  url:"/jquery/LicenseUpdate.do",
			    				  data : { sSerialCategory : data.sSerialCategory,
			    						   nSerialNum : data.nSerialNum, 	  
			    				  		 },
			    				  success : function(Integer){
			    					  var html = '';
			    					  html += '<div class="modal-body">';
			    					  html += '<p>라이선스 등록 완료</p>';
			    					  html += '<p>'+data.sSerialKey.substring(0,8)+"-"+data.sSerialKey.substring(8,12)+"-"+data.sSerialKey.substring(12,16)+"-"+data.sSerialKey.substring(16,20)+"-"+data.sSerialKey.substring(20,32)+'</p>';
			    					  html += '</div>';
			    					  html += '<div class="modal-footer">';
			    					  html += '<button type="button" class="btn btn-link" data-dismiss="modal">Close</button>';
			    					  html += '</div>';
			    					  setTimeout(function(){
			    						  location.reload();
			    					  },2000)
			    					  $("#licenseform").empty(); 
			    					  $("#licenseform").append(html); 
			    					  
			    				  }
			    			})
				    		}
						  }
				     	 }
			    	})
			    } // else
			    }
			    }
			
			  function noLicenseRestrictions(){
			    	$('button').attr('disabled', true);
			    	$('#modalBtn').attr('disabled', false);
			    	$('#modalBtn2').attr('disabled', false);
			    	$('#licenseOKBtn').attr('disabled', false);
			    	$('#RetainlicenseBtn').attr('disabled', false);
			    	$('#CreateLicenseBtn').attr('disabled', false);
			    	$('a').click(function(event){
			    		event.preventDefault();
			    	})
			    }
			  
		</script>
		
		

	</head>
	<body >							
		<div class="card bg-dark">
			<div class="card-header">
					<h5 class="card-title" id="licensestitle">
						<i class="icon-hammer-wrench"></i>라이선스
					</h5>
				</div>
				<div class="card-body" id="licenseinfor">
					<div class="card bg-dark">
						<div class="card-header">
							<h6 class="card-title" id="licenseTitle">
								<i class="icon-puzzle3"></i>라이선스 등록
							</h6>
						</div>
						<div class="card-body" id="licenseBody">
							<div class="row">
								<div class="col-lg-10 col-sm-10">
									<form id="licenseInput"></form>
								</div>
								<div class="col-lg-2 col-sm-2" id="licenseOKBtnCall"></div>
							</div>
						</div>
					</div>
					<div class="card bg-dark mb-0">
						<div class="card-header">
							<h6 class="card-title">
								<i class="icon-clipboard3"></i>라이선스 정보
							</h6>
						</div>
						<div class=" card-body">
							<div class="list-feed" id="licenseinfo"></div>
						</div>
					</div>
				</div>
			</div>
	</body>
</html>