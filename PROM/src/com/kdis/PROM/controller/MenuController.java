package com.kdis.PROM.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kdis.PROM.common.CommonAPI;
import com.kdis.PROM.logic.Ep_service;
import com.kdis.PROM.logic.LogConfiguration;
import com.kdis.PROM.logic.Metering;
import com.kdis.PROM.logic.MeteringSum;
import com.kdis.PROM.logic.MeteringVMs;
import com.kdis.PROM.logic.MmonitoringJoin;
import com.kdis.PROM.logic.Vm_create;
import com.kdis.PROM.logic.Vm_data_info;
import com.kdis.PROM.logic.Vm_host_info;
import com.kdis.PROM.logic.Vm_service;
import com.kdis.PROM.logic.Vm_service_graph;
import com.kdis.PROM.logic.Vm_storage;
import com.kdis.PROM.logic.Vm_templet;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.service.MenuService;
import com.kdis.PROM.user.vo.UserVO;

@Controller
@RequestMapping("menu/*")
public class MenuController {

	@Autowired
	private  MenuService menuservice;
	
	@Autowired
	private CommonAPI api; 
	
	@RequestMapping("menu/allRefresh.do")
	public @ResponseBody int allRefresh() throws Exception {
		int result = api.vm_data_infoWorkflow();
		return result;
	}
	
	@RequestMapping("menu/autoAllHostsearch.do")
	public @ResponseBody List<Vm_host_info> autoAllHostsearch(String inputed) {
		List<Vm_host_info> result = menuservice.AllSearchHostlist(inputed);
		return result;
	}
	
	@RequestMapping("menu/getVMoslinuxList.do")
	public @ResponseBody List<Vm_data_info> getVMoslinuxList() {
		List<Vm_data_info> result = menuservice.getVMoslinuxList();
		return result;
	}
	
	@RequestMapping("menu/Mselfservice_OneStoragedetail.do")
	public @ResponseBody Vm_storage oneStoragedetail(String st_ID) {
		Vm_storage vm_storageDetail = menuservice.vm_storageDetail(st_ID);
		return vm_storageDetail;
	}
	
	@RequestMapping("menu/vmapplyList.do")
	public @ResponseBody List<Vm_create> vmapplyList() {
		List<Vm_create> vmapplyList = menuservice.vmapplyList();
		return vmapplyList;
	}
	
	@RequestMapping("menu/EpserviceCount.do")
	public @ResponseBody int EpserviceCount(String nEp_num) {
		int EpserviceCount = menuservice.EpserviceCount(nEp_num);
		return EpserviceCount;
	}
	
	@RequestMapping("menu/EpMeteringDetail.do")
	public @ResponseBody List<MeteringSum> EpMeteringDetail(String sEp_num,String Month,String vm_service_ID) {
		List<MeteringSum> EpMeteringDetail = menuservice.EpMeteringDetail(sEp_num,Month,vm_service_ID);
		return EpMeteringDetail;
	}
	
	@RequestMapping("menu/EpInVM.do")
	public @ResponseBody List<Vm_data_info> EpInVM(String sEp_num) {
		List<Vm_data_info> EpInVM = menuservice.EpInVM(sEp_num);
		return EpInVM;
	}
	
	@RequestMapping("menu/Ep_exitservicelist.do")
	public @ResponseBody List<Vm_service> Ep_exitservicelist() {
		
		List<Vm_service> Ep_exitservicelist = menuservice.Ep_exitservicelist();
		return Ep_exitservicelist;
	}
	
	@RequestMapping("menu/EPinViewList.do")
	public @ResponseBody List<Vm_service> EPinViewList(String nEp_num) {
		List<Vm_service> EPinViewList = menuservice.EPinView(nEp_num);
		return EPinViewList;
	}
	
	@RequestMapping("menu/WeblogConfigCheck.do")
	public @ResponseBody LogConfiguration WeblogConfigCheck(String sUserID) {
		LogConfiguration logConfiguration = menuservice.SelectlogConfig(sUserID);
		return logConfiguration;
	}
	
	@RequestMapping("menu/WeblogConfiginsert.do")
	public @ResponseBody int WeblogConfiginsert(String sUserID,int selectBox,boolean Weblogconfirm,boolean Webloginoutskip) {
		int result = 0;
		int weblogconfirm;
		int webloginoutskip;
		if(Weblogconfirm) { weblogconfirm = 1;} else { weblogconfirm = 0;}
		if(Webloginoutskip) { webloginoutskip = 1;} else { webloginoutskip = 0;}
		
		LogConfiguration logConfiguration = menuservice.SelectlogConfig(sUserID);
		
		if(logConfiguration == null) {
			result = menuservice.WeblogConfiginsert(sUserID,selectBox,weblogconfirm,webloginoutskip);
		} else {
			result = menuservice.WeblogConfigUpdate(sUserID,selectBox,weblogconfirm,webloginoutskip);
		}
		return result;
	}
	
	@RequestMapping("menu/config.do")
	public ModelAndView config(){
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/Host_Status.do")
	public @ResponseBody HashMap<String, Object> Host_Status(){
		HashMap<String, Object> result;
		result = menuservice.Host_Status();
		return result;
	}
	
	/*
	 * @RequestMapping("menu/VMCopy.do") public @ResponseBody int VMCopy() throws
	 * URISyntaxException{ int result; result = vmcreate_Copy(); return result; }
	 */
	
	@RequestMapping("menu/meteringVMsTableData.do")
	public @ResponseBody List<MeteringVMs> meteringVMsTableData(String vm_service_ID,String DateFormat){
		List<MeteringVMs> MeteringVMsTableValue = menuservice.meteringVMsTableData(vm_service_ID,DateFormat);
		return MeteringVMsTableValue;
		
	}
	
	@RequestMapping("menu/Mmonitoring_PageReload.do")
	public @ResponseBody int MPload(String vm_service_ID) throws Exception {
		int result = 0;
		result = api.vm_data_infoWorkflow();
		return result;
	}
	
	//단위 서비스 모니터링 엑셀 레포트 종합
	
	@RequestMapping("menu/Ep_INservice.do")
	public @ResponseBody int nEp_INservice(String nEp_num) {
		int result = 0;
		result = menuservice.Ep_INservice(nEp_num);
		return result;
	}
	
	@RequestMapping("menu/Service_INVM.do")
	public @ResponseBody int SeINVM(String vm_service_ID) {
		int result = 0;
		result = menuservice.ServiceINVM(vm_service_ID);
		return result;
	}
	
	@RequestMapping("menu/createName.do")
	public @ResponseBody Boolean cN(String vm_name){
		Boolean result = false;
		Vm_data_info createNameCheck = menuservice.createNameCheck(vm_name);
		if(createNameCheck != null) {
			result = false;
		} else if(createNameCheck == null) {
			result = true;
		}
		return result;
	}
	
	@RequestMapping("menu/templateUp.do")
	public @ResponseBody int tempUp(Vm_templet vm_templet) {
		int result = 0;
		result = menuservice.templateUpdate(vm_templet);
		return result;
	}
	
	@RequestMapping("menu/MeteringValue.do")
	public @ResponseBody Metering MVL(int vm_service_ID) {
	 Metering meteringvalue = menuservice.meteringValue(vm_service_ID);
		return meteringvalue;
	}
	
	@RequestMapping("menu/MeteringMonthValue.do")
	public @ResponseBody MeteringSum MeteringMonthValue(int vm_service_ID) {
	 MeteringSum meteringMonthvalue = menuservice.meteringMonthValue(vm_service_ID);
		return meteringMonthvalue;
	}
	
	@RequestMapping("menu/MeteringYearMonths.do")
	public @ResponseBody MeteringSum MeteringYearMonths(String vm_service_ID,String DateSelectBox) {
	 MeteringSum MeteringYearMonthsValue = menuservice.MeteringYearMonths(vm_service_ID,DateSelectBox);
		return MeteringYearMonthsValue;
	}
	
	@RequestMapping("menu/Mtemplate_Onedetail.do")
	public @ResponseBody Vm_templet MOn(String vm_templet_name){
		
		Vm_templet Onedetail = menuservice.Onedetail(vm_templet_name);
		
		return Onedetail;
	}
	
	@RequestMapping("menu/Mtemplate_list.do")
	public @ResponseBody List<Vm_data_info> MID(){
		
		List<Vm_data_info> templateList = menuservice.templateList();
		
		return templateList;
	}

	// mainboard page 서비스 신청 5개 출력
	@RequestMapping("menu/NotApplyList.do")
	public @ResponseBody List<Vm_create> NAL() {
		List<Vm_create> NotApplyVMCR = menuservice.notapprovalVMCR_list();
		return NotApplyVMCR;
	}

	@RequestMapping("menu/DashServiceGraph.do")
	public @ResponseBody List<Vm_service_graph> DSG() {
		List<Vm_service_graph> DashServiceList = menuservice.DashServiceGraph();
		return DashServiceList;
	}

	@RequestMapping("menu/Mvm_Status.do")
	public @ResponseBody HashMap<String, Object> vm_st() {
		HashMap<String, Object> result = menuservice.vmStatus();
		return result;
	}

	

	// vm_data_info workflow 실행 메소드
	@RequestMapping("menu/vmdatainfo_workflow.do")
	public @ResponseBody int vmdatainfo_workflow() throws Exception {
		return api.vm_data_infoWorkflow();
	}

	// applyVMlist.do page
	@RequestMapping("menu/notapplyVMdetail.do")
	public @ResponseBody Vm_create npVd(Vm_create vm_create) {
		Vm_create npVd = menuservice.notapplyVMdetail(vm_create.getCr_num());
		return npVd;
	}

	// Mmonitoring.do page 그룹별 모니터링에 이름을 클릭 했을 시 상세 보기의 그룹 이름 뽑기
	@RequestMapping("menu/Mmonitoring_service_detail_sename.do")
	public @ResponseBody Vm_service MSD_sename(Vm_service vm_service) {
		Vm_service service_detail_sename = menuservice.service_detail_sename(vm_service.getVm_service_ID());
		return service_detail_sename;
	}

	// Mmonitoring.do page 시스템 정보
	@RequestMapping("menu/Mmonitoring_service_detailInfo.do")
	public @ResponseBody List<MmonitoringJoin> MSDInfo(String vm_service_ID){
		List<MmonitoringJoin> service_detail = menuservice.service_detailInfo(vm_service_ID);
		return service_detail;
	}

	// usergroupmapping.do page Jquery를 이용한 서비스 검색 기능
	@RequestMapping("menu/Mservice_ApplyautoServicesearch.do")
	public @ResponseBody List<Vm_service> ApplyautoServicesearch(String inputed) {
		List<Vm_service> SearchServicelist = menuservice.ApplySearchServicelist(inputed);
		return SearchServicelist;

	}

	// Epgroupmapping.do page Jquery를 이용한 service 검색 기능
	@RequestMapping("menu/Ep_autoServicesearch.do")
	public @ResponseBody List<Vm_service> Ep_autoServicesearch(String inputed) {
		List<Vm_service> SearchServicelist = menuservice.SearchServicelist(inputed);
		return SearchServicelist;
		
	}
	
	// vmgroupmapping.do page Jquery를 이용한 VM 검색 기능
	@RequestMapping("menu/Mservice_autoVMsearch.do")
	public @ResponseBody List<Vm_data_info> autoVMsearch(String inputed) {
		List<Vm_data_info> SearchVMlist = menuservice.SearchVMlist(inputed);
		return SearchVMlist;
		
	}
	
	@RequestMapping("menu/autoAllVMsearch.do")
	public @ResponseBody List<Vm_data_info> autoAllVMsearch(String inputed) {
		List<Vm_data_info> SearchVMlist = menuservice.AllSearchVMlist(inputed);
		return SearchVMlist;
	}

	// EPgroupmapping.do page 기업에 담겨져있는 서비스 내보내기
	@RequestMapping("menu/Ep_deportService.do")
	public @ResponseBody int Ep_deportService(String[] INServicelist) {
		for (int i = 0; i < INServicelist.length; i++) {
			menuservice.EpDelete(INServicelist[i]);
		}
		return 0;
	}
	
	// vmgroupmapping.do page 서비스 VM 매핑 서비스 클릭시 그 안에 VM들 정보 출력 함수
	@RequestMapping("menu/Mservice_INVMlist.do")
	public @ResponseBody List<Vm_data_info> service_INVMlist(Vm_service vm_service) {
		List<Vm_data_info> vm_data_infos = menuservice.service_INVMlist(vm_service.getVm_service_ID());
		return vm_data_infos;
	}

	@RequestMapping("menu/Mservice_inVMdetail.do")
	public @ResponseBody Vm_data_info service_inVMdetail(Vm_data_info vm_data_info) {
		Vm_data_info vm_data_info_select = menuservice.service_inVMdetail(vm_data_info.getVm_ID());
		return vm_data_info_select;
	}

	// vmgroupmapping.do page 미적용 VM 선택된 서비스로 전송하기
	@RequestMapping("menu/Mgroup_seSubmit.do")
	public @ResponseBody List<Object> seSubmit(String[] Sechecklist) {
		List<Object> ls = new ArrayList<Object>();
		for (int i = 0; i < Sechecklist.length; i++) {
			Vm_service vm_service = menuservice.service_detail_sename(Integer.parseInt(Sechecklist[i]));
			ls.add(vm_service);
		}
		return ls;
	}

	// vmgroupmapping.do page 미적용 VM 선택된 서비스로 전송하기
	@RequestMapping("menu/Ep_Servicesubmit.do")
	public @ResponseBody int Ep_Servicesubmit(String[] Epchecklist, String nEp_num) {
		
		for (int i = 0; i < Epchecklist.length; i++) {
			menuservice.Ep_serviceupdate(Epchecklist[i], nEp_num);
		}
		
		return 0;
		
	}

	@RequestMapping("menu/Mallvm_list.do")
	public @ResponseBody List<Vm_data_info> Mallvm_list() {
		List<Vm_data_info> vm_infolist = menuservice.VMAllinfolist();

		return vm_infolist;
	}

	@RequestMapping("menu/Mallhost_list.do")
	public @ResponseBody List<Vm_host_info> Mallhost_list() {
		List<Vm_host_info> vm_hostinfolist = menuservice.host_info_list();

		return vm_hostinfolist;
	}

	@RequestMapping(value = "menu/Mselfservice.do", method = RequestMethod.GET)
	public ModelAndView selfservice() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	// Mmonitoring.do page USER 권한별 서비스 List 출력
	@RequestMapping("menu/Mselfservice_listAuthority.do")
	public @ResponseBody List<Vm_service> Mselfservice_listAuthority(HttpSession session) {
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		List<Vm_service> vm_servicelist = menuservice.Authorityservice_list(loginInfo.getsUserID(),loginInfo.getsEpNum());
		return vm_servicelist;
	}

	// Mmonitoring.do page 서비스 List 출력
	@RequestMapping("menu/Mselfservice_list.do") 
	public @ResponseBody List<Vm_service> Mselfservice_list(Vm_service vm_serivce,HttpSession session) { 
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		List<Vm_service> vm_servicelist;
		if(loginInfo.getnApproval() == 2) { 
			vm_servicelist = menuservice.VMservice_list(loginInfo.getsEpNum());
		} else { 
			vm_servicelist = menuservice.VMservice_list(); 
		} 
		return vm_servicelist; 
	}
	 

	@RequestMapping("menu/Mselfservice_detail.do")
	public @ResponseBody Vm_service service_select(Vm_service vm_serivce) {
		vm_serivce = menuservice.VMservice_select(vm_serivce.getVm_service_name());
		return vm_serivce;
	}
	
	@RequestMapping("menu/Ep_checkname.do")
	public @ResponseBody int Ep_checkname(Ep_service ep_service) {
		int result = 0;
		ep_service = menuservice.EpNamecheck(ep_service.getsEp_name());
		if (ep_service != null)
			result = 1;
		return result;
	}

	@RequestMapping("menu/Mselfservice_Onevmdetail_vm.do")
	public @ResponseBody Vm_data_info Onevmdetail(Vm_data_info vm_data_info) {
		vm_data_info = menuservice.VM_Onevm_info(vm_data_info.getVm_ID());
		return vm_data_info;
	}

	@RequestMapping("menu/Mselfservice_Onehostdetail_host.do")
	public @ResponseBody Vm_host_info Onehostdetail(Vm_host_info vm_host_info) {
		vm_host_info = menuservice.VM_Onehost_info(vm_host_info.getVm_HID());
		return vm_host_info;
	}

	@RequestMapping("menu/host_info_list.do")
	public @ResponseBody List<Vm_host_info> host_info_list() {
		List<Vm_host_info> vm_host_info_list = menuservice.host_info_list();
		return vm_host_info_list;

	}

	@RequestMapping("menu/vm_templetList.do")
	public @ResponseBody List<Vm_templet> templet(Vm_templet vm_templet) {
		List<Vm_templet> vm_templetlist = menuservice.vm_templetlist();
		return vm_templetlist;
	}

	@RequestMapping("menu/vmcreatewait_list")
	public @ResponseBody List<Vm_create> vmcreatewaitlist(Vm_create vm_create) {

		List<Vm_create> vm_createwaitlist = menuservice.VM_createwaitlist();
		return vm_createwaitlist;

	}
	
		
	
	@RequestMapping("menu/loding.do")
	public ModelAndView loding(HttpServletRequest request) {
		String NewVMname = request.getParameter("vm_service_vm_name");
		String NewVMnServiceID = request.getParameter("vm_service_ID");
		ModelAndView mav = new ModelAndView();
		mav.addObject("NewVMname", NewVMname);
		mav.addObject("NewVMnServiceID", NewVMnServiceID);
		return mav;

	}

	@RequestMapping("menu/servicecrup.do")
	public ModelAndView servicecrup() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	@RequestMapping("menu/Chargebacks.do")
	public ModelAndView Chargebacks() {
		ModelAndView mav = new ModelAndView();
		int nYear;
		Calendar calendar = new GregorianCalendar(Locale.KOREA);
		nYear = calendar.get(Calendar.YEAR);
		
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMM");
		
		Date time = new Date();
		String FormatTime = format1.format(time);
		
		mav.addObject("nYear",nYear);
		mav.addObject("nMonth", FormatTime);
		return mav;
	}

	@RequestMapping("menu/temp.do")
	public ModelAndView temp() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	@RequestMapping("menu/Mmonitoring.do")
	public ModelAndView jquery() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	@RequestMapping("menu/hostViewChoice.do")
	public ModelAndView hostViewChoice() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/temp119.do")
	public ModelAndView temp119() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/company.do")
	public ModelAndView company() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/tenantManage.do")
	public ModelAndView tenantManage() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/serviceManage.do")
	public ModelAndView serviceManage() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/serviceMapping.do")
	public ModelAndView serviceMaeping() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	
	@RequestMapping("menu/templateSetting.do")
	public ModelAndView templateSetting() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/flavorSetting.do")
	public ModelAndView flavorSetting() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/approvalManage.do")
	public ModelAndView approvalManage() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/workflowConfig.do")
	public ModelAndView workflowConfig() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/statisticsManagement.do")
	public ModelAndView statisticsManagement(String ca,String pa,String ch,String vn,Integer ts,String dt) {
		ModelAndView mav = new ModelAndView();

		if (ca != null) {
			mav.addObject("ca", ca);
		}
		if (pa != null) {
			mav.addObject("pa", pa);
		}
		if (ch != null) {
			mav.addObject("ch", ch);
		}
		if (vn != null) {
			mav.addObject("vn", vn);
		}
		if (ts != null) {
			mav.addObject("ts", ts);
		}
		if (dt != null) {
			mav.addObject("dt", dt);
		}
		
				return mav;
	}
	
	@RequestMapping("menu/userDashboard.do")
	public ModelAndView userMainboard() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/report.do")
	public ModelAndView report() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/monitoring.do")
	public ModelAndView monitoring(String cn,String hn, String vn,String ten,String se) {
		
		ModelAndView mav = new ModelAndView();
		
		if (cn != null) {
			mav.addObject("cn", cn);
		}
		if (hn != null) {
			mav.addObject("hn", hn);
		}
		if (vn != null) {
			mav.addObject("vn", vn);
		}
		if(ten != null) {
			mav.addObject("ten", ten);
		}
		if(se != null) {
			mav.addObject("se", se);
		}
		
		
		return mav;
		
	}
	
	@RequestMapping("menu/dashboard.do")
	public ModelAndView dashboard() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/autoScaleSetting.do")
	public ModelAndView autoScaleSetting() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/vmManagement.do")
	public ModelAndView vmManagement() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("menu/inventoryStatus.do")
	public ModelAndView inventoryStatus(String ten,String se) {
		ModelAndView mav = new ModelAndView();
		
		if(ten != null) {
			mav.addObject("ten",ten);	
		}
		if(se != null) {
			mav.addObject("se",se);	
		}
		
		return mav;
	}
	
}
