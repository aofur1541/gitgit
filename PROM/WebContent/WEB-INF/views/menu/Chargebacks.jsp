<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>	
	<head>
		<link href="${path}/resources/PROM_CSS/Chargebacks.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<ul class="chartup nav mb-2">
			<li class="active"><button onclick="location.href='Chargebacks.do'" type="button" class="btn btn-link">그래프 보기</button>
			<li><button onclick="OnlyEpView()" type="button" class="btn btn-link" >계열사별 보기 (관리자용)</button>
			<!-- <li><button type="button"  class="btn btn-link">계열사별 금액</button></li>
			<li><button type="button"  class="btn btn-link">설정</button></li> -->
		</ul>
		<div class="row">
			<!-- Basic bars -->
			<div class="col-xl-7">
				<div class="card bg-dark meteringchart">
					<div class="card-header header-elements-inline" id="Meteringheader">
						<h5 class="card-title" id="MeteringTitle"><i class="icon-meter2"></i>단위 서비스별 미터링(일) </h5>
						<div id="DateDataSelectOutDIV">
							<select class="form-control select-fixed-single select2-hidden-accessible" data-fouc="" tabindex="-1" aria-hidden="true" id="DateDataSelect">
								<!-- <option disabled="disabled" selected>날짜 선택</option> -->
							</select>
						</div>
						<div id="EpDateDataSelectOutDIV">
							<select class="form-control select-fixed-single select2-hidden-accessible" data-fouc="" tabindex="-1" aria-hidden="true" id="EpDateDataSelect"></select>
						</div>
					</div>
					<div class="card-body">
					<div id="Meteringbody">
						<h6 id="DataemptyMessage" style = "display:none;">이 달에 누적된 데이터가 없습니다.</h6>
						<div class=" d-flex justify-content-center align-items-center">
							 <div class="chart-container mt-2" style="position: relative; height:65vh; width:45vw">
								<canvas id="meteringChart"></canvas>
								</div>
							</div>
                        </div>
					</div>
				</div>
			</div>
			<div class="col-xl-5" id="MeteringsideCardAll">
				<div class="card bg-dark meteringday" id="MeteringintegrationCardAll">
					<div class="card-header header-elements-inline">
						<h5 class="card-title" id="Meteringintegration"><i class="icon-meter-fast"></i>미터링 요약 정보(일)</h5>
					</div>
					<div class="card-body" id="MeteringintegrationCardBody">
						<select class="form-control select-search select2-hidden-accessible col-md-6 mb-0" data-fouc="" tabindex="-1" aria-hidden="true" id="meteringinfo"></select>
							<!-- <div class="form-group pt-2">
									<label class="d-block font-weight-semibold">Left stacked radios</label>
									<div class="custom-control custom-radio">
										<input type="radio" class="custom-control-input" name="custom-stacked-radio" id="custom_radio_stacked_unchecked" checked="">
										<label class="custom-control-label" for="custom_radio_stacked_unchecked">Custom selected</label>
									</div>

									<div class="custom-control custom-radio">
										<input type="radio" class="custom-control-input" name="custom-stacked-radio" id="custom_radio_stacked_checked">
										<label class="custom-control-label" for="custom_radio_stacked_checked">Custom unselected</label>
									</div>

									<div class="custom-control custom-radio">
										<input type="radio" class="custom-control-input" id="custom_radio_stacked_checked_disabled" checked="" disabled="">
										<label class="custom-control-label" for="custom_radio_stacked_checked_disabled">Custom selected disabled</label>
									</div>
								</div> -->
						<div id="meterCPUMEMORY" class="mb-4 mt-4"></div>
						<div class="servicesVMlsit">
							<div id="ServiceInVMs" ></div>
						</div>	
					</div>
				</div>
			</div>
		</div>
<script type="text/javascript">

$(function(){
	  var sBtn = $(".chartup > li"); 
	  sBtn.find("button").click(function(){  
	   sBtn.removeClass("active"); 
	   $(this).parent().addClass("active"); 
	  })
	 })

var global_html = '';
var global_nEp_num = '';
var global_sEp_name = '';
var global_EpServiceCount = 0;
var DayCheckValue = 0;
var count = 0;

var ctx = document.getElementById("meteringChart").getContext("2d");

var myChart = new Chart(ctx, {
	  type: 'horizontalBar',
	  data: {
	    labels: [],
	    datasets: [{
	      label: 'Cpu (Core)',
	      data: [],
	      backgroundColor: "#E91E63", // bar color
	    }, {
	      label: 'Memory (GB)',
	      data: [],
	    backgroundColor: "#4FC3F7"
	    }]
	  },
options: { 
	 scaleFontColor: 'red',
responsive: true,
maintainAspectRatio: false,
    legend: { 
     labels: { 
      fontColor: "white", 
      fontSize: 14 
     } 	
    },
     scales:{
    	   yAxes: [{
    	         ticks: { 
    	        	 fontColor: 'white',
    	             fontSize: 12, 
    	             beginAtZero: true 
    	            } 
    	       }],

    	   xAxes: [{
    		   //stacked: true, 데이터 합치기
    	         ticks: { 
    	             fontColor: 'white', 
    	             fontSize: 12, 
    	             beginAtZero: true 
    	            } 
    	       }]
    	   },
    	   
 tooltips: {
   backgroundColor: '#fff',
   titleFontColor: '#333',
   bodyFontColor: '#666',
   bodySpacing: 4,
   xPadding: 12,
   mode: "nearest",
   intersect: 0,
   position: "nearest"
 },
 
}, // options finish
	  
});	//Chart finish	

function getUserMeteringService(){
	
	$.ajax({
		
		url : "/jquery/getUserMeteringService.do",
		success:function(service){
			for(key in service){
						$("#meteringChart").show();
						$("#DataemptyMessage").hide();
					 		myChart.data.labels[key] = service[key].vm_service_name;
							myChart.data.datasets[0].data[key] = service[key].vm_cpu;
							myChart.data.datasets[1].data[key] = service[key].vm_memory;
					myChart.update();
						}
					}
					
				})
			}

// Days Graph
function MeteringServiceGraph(){

$.ajax({
	url : "Mselfservice_list.do",
	success : function(Service){
		var count = 0;
	for(key in Service){
		$.ajax({
			
			url : "MeteringValue.do",
			data : { vm_service_ID : Service[key].vm_service_ID },
			 async: false,
			success : function(Metering){
				$("#meteringChart").show();
				$("#DataemptyMessage").hide();
			 		myChart.data.labels[count] = Metering.vm_service_name;
					myChart.data.datasets[0].data[count] = Metering.total_cpu;
					myChart.data.datasets[1].data[count] = Metering.total_memory;
					count++; 		
			myChart.update();
				}
			
		})
		 
	}
	
	}
})

}

//finish
// Days intergration view
function MeteringintegrationDay(vm_service_ID){
		
	$.ajax({
			
			url : "MeteringValue.do",
			data : { vm_service_ID : vm_service_ID  },
			
			success : function(data) {
			  var html = '';
			  var total = data.total_memory+data.total_cpu;
			  var result = 100*total;
			  
 			  if(data.total_cpu == 0 || data.total_memory == 0){
				  
			  html += '<h6 class="font-weight-semibold mb-0 text-center">가상머신이 존재하지 않습니다.</h6>';
				  $("#ServiceInVMs").empty();
				  $("#meterCPUMEMORY").empty();
				  $("#meterCPUMEMORY").append(html);
					 
		 	  } else {
		 	 	
			  html += '<div class="row text-center">';
			  
			  
			  html += '<div class="col-4">';
			  html += '<div class="d-flex align-items-center justify-content-center mb-2"><div class="metericon bg-blue"><i class="icon-chip icon-2x mr-0"></i></div></div>';
			  html += '<h5 class="font-weight-semibold mb-0">'+data.total_cpu+' Core</h5>';
			  html += '<span class="text-muted font-size-sm">CPU</span>';
			  html += '</div>';
			  
			  
			  html += '<div class="col-4">';
			  html += '<div class="d-flex align-items-center justify-content-center mb-2"><div class="metericon bg-blue"><i class="icon-barcode2 icon-2x mr-0"></i></div></div>';
			  html += '<h5 class="font-weight-semibold mb-0">'+data.total_memory+' GB</h5>';
			  html += '<span class="text-muted font-size-sm">Memory</span>';
			  html += '</div>';
			  
			  
			  html += '<div class="col-4">';
			  html += '<div class="d-flex align-items-center justify-content-center mb-2"><div class="metericon bg-blue"><i class="icon-cash3 icon-2x mr-0"></i></div></div>';
			  html += '<h5 class="font-weight-semibold mb-0">$ '+result.toLocaleString()+'</h5>';
			  html += '<span class="text-muted font-size-sm">result</span>';
			  html += '</div></div>';
			  
		 	 }				 
			  $("#meterCPUMEMORY").empty();
			  $("#meterCPUMEMORY").append(html);
			}
	})
	
	
	
	$.ajax({
		
		url : "Mmonitoring_service_detailInfo.do",
		data : { vm_service_ID : vm_service_ID },
		
		success : function(data){
			var html = '';
			html += '<section>';
			html += '<div class=servicesVM-header>';
			html += '<table class="servicesVM-table">';
			html += '<thead>';
			html += '<tr><th width="40%" class="text-left">가상머신 이름</th>';
			html += '<th width="25%">vCPU</th>';
			html += '<th width="35%">Memory</th></tr>';
			html += '</thead>';
			html += '</table>';
			html += '</div>';
			html += '<div class=servicesVM-content>';
			html += '<table class="servicesVM-table">';
			html += '<tbody>';
			for(key in data){
			html += '<tr>';
			html += '<td width="40%">';
			
			html += '<div class="text-left">';
			html += '<div class="row">';
			
			html += '<div class="col-md-2 d-flex align-items-center">';
			html += '<i class="icon-screen3"></i></div>';
			
			html += '<div class="col-md-10">';
			html += '<div class="row">';
			
			html += '<div class="col-md-12">';
			html += data[key].vm_name+'</div>';
			
			html += '<div class="col-md-12">';
			if(data[key].vm_status == 'poweredOff'){
			html += '<div class="text-muted font-size-sm">전원 : <i class="icon-switch text-warning font-size-sm"></i></div>';
				} else {
			html += '<div class="text-muted font-size-sm">전원 : <i class="icon-switch text-green font-size-sm"></i></div>';
				}
			html += '</div></div></div></div>';
			
			html += '</td>';
			html += '<td width="30%">';
			html += data[key].vm_cpu;
			html += '</td>';
			html += '<td width="30%">';
			html += data[key].vm_memory+' GB';
			html += '</td>';
			html += '</tr>';
			}
			html += '</tbody></table></div></section>';
			
			  if(data == 0 || data == ''){
			  $("#ServiceInVMs").empty();
			  } else {
			  $("#ServiceInVMs").empty();
			  $("#ServiceInVMs").append(html);
			  }
		}	
	})
	}
	
//월별 통계
function MeteringYearMonths(vm_service_ID,DateSelectBox){
	var selectBoxValue = $("#DateDataSelect option:selected").val();
	var replaceResult = selectBoxValue.replace("-","");	
	var DayCount = 0;
	
	$.ajax({
		
		url : "MeteringYearMonths.do",
		data : { vm_service_ID : vm_service_ID ,
				 DateSelectBox : DateSelectBox
			},
		
		success : function(data) {
			DayCount = data.nCountDay;
		  var html = '';
		  var total = data.nTotal_memory+data.nTotal_cpu;
		  var result = 100*total;
		  
			  if(data.nTotal_memory == 0 || data.nTotal_cpu == 0){
		  html += '<h6 class="font-weight-semibold mb-0 text-center">해당 월은 가상머신이 존재하지 않습니다.</h6>';
		  $("#ServiceInVMs").empty();
		  $("#meterCPUMEMORY").empty();
		  $("#meterCPUMEMORY").append(html);
				 
	 	  } else {
	 	 	
	 		 html += '<div class="row text-center">';
			  html += '<div class="col-4">';
			  html += '<div class="d-flex align-items-center justify-content-center mb-2"><div class="metericon bg-blue"><i class="icon-chip icon-2x mr-0"></i></div></div>';
			  html += '<h5 class="font-weight-semibold mb-0">'+data.nTotal_cpu+' Core</h5>';
			  html += '<span class="text-muted font-size-sm">CPU</span>';
			  html += '</div>';
			  html += '<div class="col-4">';
			  html += '<div class="d-flex align-items-center justify-content-center mb-2"><div class="metericon bg-blue"><i class="icon-barcode2 icon-2x mr-0"></i></div></div>';
			  html += '<h5 class="font-weight-semibold mb-0">'+data.nTotal_memory+' GB</h5>';
			  html += '<span class="text-muted font-size-sm">MEMORY</span>';
			  html += '</div>';
			  html += '<div class="col-4">';
			  html += '<div class="d-flex align-items-center justify-content-center mb-2"><div class="metericon bg-blue"><i class="icon-cash3 icon-2x mr-0"></i></div></div>';
			  html += '<h5 class="font-weight-semibold mb-0">$ '+result.toLocaleString()+'</h5>';
			  html += '<span class="text-muted font-size-sm">result</span>';
			  html += '</div></div>';
		  
	 	 }				 
		  
		  $("#meterCPUMEMORY").empty();
		  $("#meterCPUMEMORY").append(html);
		}
})
	
//누적 가상머신 테이블
$.ajax({
	
	url : "meteringVMsTableData.do",
	data : { vm_service_ID : vm_service_ID, 
			 DateFormat : replaceResult
	},
	
	success : function(data){
		var html = '';
		html += '<section>';
		html += '<div class=servicesVM-header>';
		html += '<table class="servicesVM-table">';
		html += '<thead>';
		html += '<tr><th width="40%" class="text-left">가상머신 이름</th>';
		html += '<th width="30%">누적 vCPU</th>';
		html += '<th width="30%">누적 Memory</th></tr>';
		html += '</thead>';
		html += '</table>';
		html += '</div>';
		html += '<div class=servicesVM-content>';
		html += '<table class="servicesVM-table">';
		html += '<tbody>';
		for(key in data){
		html += '<tr>';
		html += '<td width="40%">';
		html += '<div class="d-flex align-items-center">';
		html += '<div class="mr-3">';
		html += '<i class="icon-screen3"></i>';
		html += '</div>';
		html += '<div>';
		html += data[key].sVm_name
		html += '</div>';
		html += '</div>';
		html += '</td>';
		html += '<td width="30%">';
		html += '<span>'+data[key].nVm_cpu+'</span>';
		html += '</td>';
		html += '<td width="30%">';
		html += '<span>'+data[key].nVm_memory+' GB</span>';
		html += '</td></tr>';
		}
		html += '</tbody></table></div></section>';
		
		 if(data == 0 || data == ''){
			  $("#ServiceInVMs").empty();
			  } else {
			  $("#ServiceInVMs").empty();
			  $("#ServiceInVMs").append(html);
			  }
		
	}	
	})
	}

//Month Graph view
function MeteringYearMonthsGraphValue(selectBoxValue){
	var selectBoxValue = $("#DateDataSelect option:selected").val();
$.ajax({
	url : "Mselfservice_list.do",
	success : function(Service){
		var MonthGraphCheck = 0;
		var count = 0;
		var CardTitle = '';
		var CardIntegration = '';
		 
		 CardTitle += '<i class="icon-meter2"></i>단위 서비스별 미터링( '+selectBoxValue.substring(5,7)+'월) </h5>'; 
		 CardIntegration += '<i class="icon-meter-fast"></i>미터링 요약 정보( '+selectBoxValue.substring(5,7)+'월)</h5>'; 
		 
		$('#MeteringTitle').empty();
		$('#MeteringTitle').append(CardTitle);
		
		$('#Meteringintegration').empty();
		$('#Meteringintegration').append(CardIntegration);
		
	for(key in Service){
		$.ajax({
			
			url : "MeteringYearMonths.do",
			data : { vm_service_ID : Service[key].vm_service_ID,
						DateSelectBox : selectBoxValue	
			},
			 async: false,
			success : function(Metering){
				MonthGraphCheck += Metering.nVm_service_ID
				if(MonthGraphCheck == 0){
				$("#meteringChart").hide();
				$("#DataemptyMessage").show();
					} else {
				$("#meteringChart").show();
				$("#DataemptyMessage").hide();
					}
				
					if(Metering.nVm_service_ID > 0){
			 		myChart.data.labels[count] = Metering.sVm_service_name;
			 		if(Metering.nTotal_cpu > 0){
					myChart.data.datasets[0].data[count] = Metering.nTotal_cpu;
					myChart.data.datasets[1].data[count] = Metering.nTotal_memory;
			 		} if(Metering.nTotal_cpu == 0 || Metering.sVm_service_name == null){
					myChart.data.datasets[0].data[count] = 0;
					myChart.data.datasets[1].data[count] = 0;
			 		}
					count++; 		
			myChart.update();
					
			}
			}
			
		})
		 
	}
	
	}
})

}

function OnlyEpViewInServiceCount(nEp_num){
	
	$.ajax({
		
		url : "EpserviceCount.do",
		data : { nEp_num : nEp_num },
		async : false,
		success:function(data){
		global_EpServiceCount = data;	
		}
		
	})
	
}

//2019-04-24
function OnlyEpView(){
	
	alert("Coming soon!");
	
}

//2019-04-24
function EpMeteringDetail(nEp_num,sEp_name){
	$("#EpDateDataSelectOutDIV").show();
	global_nEp_num = nEp_num;
	global_sEp_name = sEp_name;
	var selectBoxValue = $("#EpDateDataSelect option:selected").val();
	var sidecardvalue = '';
	var cardheader = '';
	var html = '';
	var vm_service_ID;
	cardheader += '<div class="d-flex align-items-center"><h5 class="mb-0"><i class="icon-city"></i>'+sEp_name+'</h5><h6 class="ml-3 mb-0"><button class="btn btn-outline bg-blue text-blue btn-icon ml-2" onclick="OnlyEpView()"><i class="icon-reply"></i>목록 보기</button></h6></div>';
	$("#MeteringTitle").empty();
	$("#MeteringTitle").append(cardheader);
	$.ajax({
	
	url : "EPinViewList.do",
	data : { nEp_num : nEp_num },
	success : function(data){
	if(data == null || data == ''){
		html = '<h6>데이터가 없습니다.</h6>';	
	$("#Meteringbody").empty();
	$("#Meteringbody").append(html);
	} else{
	$("#Meteringbody").empty();
	
	html +='<div class="detailCardinfor">';
	html += '<div class="card-group-control card-group-control-right"  id="MeteringIndata"></div>';
	html +='</div>';	
	$("#Meteringbody").append(html);
	
	for(key in data){
	vm_service_ID = data[key].vm_service_ID;	
	EpinVM(nEp_num,sEp_name,vm_service_ID);	
	}
	}	} })
}

//2019-04-24
function EpinVM(nEp_num,sEp_name,vm_service_ID){
	var selectBoxValue = $("#EpDateDataSelect option:selected").val();
	$.ajax({
		
		url : "EpMeteringDetail.do",
		data : { sEp_num : nEp_num,
			Month : selectBoxValue,
			vm_service_ID : vm_service_ID,
			   },
		async : false,
		success:function(data){
			var html = '';
			var totalcpu =0 ;
			var totalmemory =0;
			if(data == null || data == ''){
				$("#Meteringbody").empty();
				html = '<h6>데이터가 없습니다.</h6>';
			} else {
				
				
				html += '<div class="card bg-dark servicesdetail">';
				html += '<a data-toggle="collapse" class="text-white collapsed mt-0" href="#collapsible-control-right-group'+count+'" aria-expanded="false">';
				html += '<div class="card-header header-elements-inline">';
				html += '<h6 class="card-title"><i class="icon-folder2"></i>'+data[0].sVm_service_name+'</h6>';
				html += '<div class="header-elements"><div class="list-icons"><i class="icon-plus3"></i></div></div></div></a>';
				html += '<div id="collapsible-control-right-group'+count+'" class="collapse">';
				html += '<div class="card-body" style="padding:0; margin-top:-20px;">';
				html += '<section>';
				html += '<div class=servicesdetail-header>';
				html += '<table class="servicesdetail-table">';
				html += '<thead>';
				html += '<tr><th width="40%">날짜</th>';
				html += '<th width="30%">CPU</th>';
				html += '<th width="30%">Memory</th></tr>';
				html += '</thead>';
				html += '</table>';
				html += '</div>';
				html += '<div class=servicesdetail-content>';
				html += '<table class="servicesdetail-table">';
				html += '<tbody>';
			
			for(key in data){
			html += '<tr><td width="40%">'+data[key].dMeteringDate+"</td>";
			html += '<td width="30%">'+data[key].nTotal_cpu+" Core</td>";
			html += '<td width="30%">'+data[key].nTotal_memory+" GB</td></tr>";
			
			totalcpu += parseInt(data[key].nTotal_cpu);
			totalmemory += parseInt(data[key].nTotal_memory);
			}
			html += '</tbody></table></div></section></div></div>';
			html += '<div class="card-footer text-muted"><i class="icon-chip"></i><span class="mr-3">통합 CPU : <b>'+totalcpu+'</b> Core</span>/<span class="ml-3"><i class="icon-floppy-disk"></i>통합 Memory : <b>'+totalmemory+'</b> GB</span></div>';
			html += '</div>';
			count++;
			}
		$("#MeteringIndata").append(html);
		
		}
		})
		}


function getUserMeteringinfo(){

		$.ajax({
			
			url : "/jquery/getTenantlowerRank.do",
			
			success : function(service) {
	
	var html = '';
	html += '<option value=0 disabled="disabled" selected>단위 서비스 선택</option>';
	for(key in service){
	html += '<option value='+service[key].vm_service_ID+'>'+service[key].vm_service_name+'</option>';
	}
	
	$("#meteringinfo").empty();
	$("#meteringinfo").append(html);
	
			}
		})
}

function meteringinfo(){

		$.ajax({
			
			url : "Mselfservice_list.do",
			
			success : function(service) {
	
	var html = '';
	html += '<option value=0 disabled="disabled" selected>단위 서비스 선택</option>';
	for(key in service){
	html += '<option value='+service[key].vm_service_ID+'>'+service[key].vm_service_name+'</option>';
	}
	
	$("#meteringinfo").empty();
	$("#meteringinfo").append(html);
	
			}
		})
}

function DayCheck(){

	var date = new Date(); 
	var year = date.getFullYear(); 
	var month = new String(date.getMonth()+1); 
	var day = new String(date.getDate()); 
	var MonthCheck = '.select-fixed-single';
	if(month == 1){
		$(MonthCheck).empty();
		$(MonthCheck).append("<option value='Day'>일"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-01'>1월"+"</option>");
	}else if(month == 2){
		$(MonthCheck).empty();
		$(MonthCheck).append("<option value='Day'>일"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-01'>1월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-02'>2월"+"</option>");
	}else if(month == 3){
		$(MonthCheck).empty();
		$(MonthCheck).append("<option value='Day'>일"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-01'>1월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-02'>2월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-03'>3월"+"</option>");
	}else if(month == 4 ){
		$(MonthCheck).empty();
		$(MonthCheck).append("<option value='Day'>일"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-01'>1월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-02'>2월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-03'>3월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-04'>4월"+"</option>");
	}else if(month == 5){
		$(MonthCheck).empty();
		$(MonthCheck).append("<option value='Day'>일"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-01'>1월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-02'>2월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-03'>3월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-04'>4월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-05'>5월"+"</option>");
	}else if(month == 6){
		$(MonthCheck).empty();
		$(MonthCheck).append("<option value='Day'>일"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-01'>1월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-02'>2월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-03'>3월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-04'>4월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-05'>5월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-06'>6월"+"</option>");
	}else if(month == 7){
		$(MonthCheck).empty();
		$(MonthCheck).append("<option value='Day'>일"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-01'>1월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-02'>2월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-03'>3월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-04'>4월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-05'>5월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-06'>6월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-07'>7월"+"</option>");
	}else if(month == 8){
		$(MonthCheck).empty();
		$(MonthCheck).append("<option value='Day'>일"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-01'>1월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-02'>2월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-03'>3월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-04'>4월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-05'>5월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-06'>6월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-07'>7월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-08'>8월"+"</option>");
	}else if(month == 9){
		$(MonthCheck).empty();
		$(MonthCheck).append("<option value='Day'>일"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-01'>1월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-02'>2월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-03'>3월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-04'>4월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-05'>5월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-06'>6월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-07'>7월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-08'>8월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-09'>9월"+"</option>");
	}else if(month == 10){
		$(MonthCheck).empty();
		$(MonthCheck).append("<option value='Day'>일"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-01'>1월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-02'>2월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-03'>3월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-04'>4월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-05'>5월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-06'>6월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-07'>7월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-08'>8월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-09'>9월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-10'>10월"+"</option>");
	}else if(month == 11){
		$(MonthCheck).empty();
		$(MonthCheck).append("<option value='Day'>일"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-01'>1월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-02'>2월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-03'>3월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-04'>4월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-05'>5월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-06'>6월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-07'>7월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-08'>8월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-09'>9월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-10'>10월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-11'>11월"+"</option>");
	}else if(month == 12){
		$(MonthCheck).empty();
		$(MonthCheck).append("<option value='Day'>일"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-01'>1월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-02'>2월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-03'>3월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-04'>4월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-05'>5월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-06'>6월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-07'>7월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-08'>8월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-09'>9월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-10'>10월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-11'>11월"+"</option>");
		$(MonthCheck).append("<option value='${nYear}-12'>12월"+"</option>");
	}
	
	
}



$( document ).ready(function() {
	
	DayCheck();
	$('#EpDateDataSelect').change(function(){EpMeteringDetail(global_nEp_num,global_sEp_name); })
	$("#EpDateDataSelectOutDIV").hide();
	$('#DateDataSelect').change(function(){
		var selectBoxValue = $("#DateDataSelect option:selected").val();
		var vm_service_ID = $("#meteringinfo option:selected").val();
		
		if(selectBoxValue == 'Day'){
		
			MeteringServiceGraph();
			
			 var CardTitle = '';
			 var CardIntegration = '';
			 
			 CardTitle += '<i class="icon-meter2"></i>단위 서비스별 미터링(일) </h5>'; 
			 CardIntegration += '<i class="icon-meter-fast"></i>미터링 요약 정보(일)</h5>'; 
			 
			$('#MeteringTitle').empty();
			$('#MeteringTitle').append(CardTitle);
			
			$('#Meteringintegration').empty();
			$('#Meteringintegration').append(CardIntegration);
			if($("#meteringinfo option:selected").val() > 0){
				MeteringintegrationDay(vm_service_ID); 
				}
			
		}  else {
			
		if( $("#meteringinfo option:selected").val() > 0) { MeteringYearMonths(vm_service_ID,selectBoxValue);}	
		if(selectBoxValue == "${nYear}-01") { MeteringYearMonthsGraphValue(selectBoxValue)}	
		if(selectBoxValue == "${nYear}-02") { MeteringYearMonthsGraphValue(selectBoxValue)}	
		if(selectBoxValue == "${nYear}-03") { MeteringYearMonthsGraphValue(selectBoxValue)}	
		if(selectBoxValue == "${nYear}-04") { MeteringYearMonthsGraphValue(selectBoxValue)}	
		if(selectBoxValue == "${nYear}-05") { MeteringYearMonthsGraphValue(selectBoxValue)}	
		if(selectBoxValue == "${nYear}-06") { MeteringYearMonthsGraphValue(selectBoxValue)}	
		if(selectBoxValue == "${nYear}-07") { MeteringYearMonthsGraphValue(selectBoxValue)}	
		if(selectBoxValue == "${nYear}-08") { MeteringYearMonthsGraphValue(selectBoxValue)}	
		if(selectBoxValue == "${nYear}-09") { MeteringYearMonthsGraphValue(selectBoxValue)}	
		if(selectBoxValue == "${nYear}-10") { MeteringYearMonthsGraphValue(selectBoxValue)}	
		if(selectBoxValue == "${nYear}-11") { MeteringYearMonthsGraphValue(selectBoxValue)}	
		if(selectBoxValue == "${nYear}-12") { MeteringYearMonthsGraphValue(selectBoxValue)}	
			
		} // else  
		
	})
	

	
	$('#meteringinfo').change(function(){
	var vm_service_ID = $("#meteringinfo option:selected").val();
	var selectBoxValue = $("#DateDataSelect option:selected").val();	
	
	if(selectBoxValue == 'Day') {
	
		MeteringintegrationDay(vm_service_ID);
	
	} else {
		if( $("#meteringinfo option:selected").val() > 0) { MeteringYearMonths(vm_service_ID,selectBoxValue);}	
		if(selectBoxValue == "${nYear}-01") { MeteringYearMonths(vm_service_ID,selectBoxValue);}	
		
	}
	
	})
	
	if(sessionApproval > ADMINCHECK){
		MeteringServiceGraph();
		meteringinfo();
	}else if(sessionApproval < ADMINCHECK){
		getUserMeteringService();
		getUserMeteringinfo();
	}
	
});
</script>
</body>
</html>