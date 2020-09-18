package com.kdis.PROM.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kdis.PROM.logic.Vm_data_info;
import com.kdis.PROM.service.MenuService;

@Controller
@RequestMapping("data/*")
public class DataController {
	
	@Autowired
	private  MenuService menuservice;
	
	@RequestMapping("data/applyResourceChange.do")
	public ModelAndView applyResourceChange() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/applyReturnVM.do")
	public ModelAndView applyReturnVM() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	@RequestMapping("data/Mallvmlist.do")
	public ModelAndView Mallvmlist(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		List<Vm_data_info> vm_infolist = null;
		vm_infolist = menuservice.VMAllinfolist();
		
		for(int i=0; i<vm_infolist.size(); i++) {
			if(vm_infolist.get(i).getVm_ipaddr1() != null) {
				if(vm_infolist.get(i).getVm_ipaddr1().substring(0,3).equals("org")) {
					vm_infolist.get(i).setVm_ipaddr1(vm_infolist.get(i).getVm_ipaddr1().replace(vm_infolist.get(i).getVm_ipaddr1(), "ip empty"));
				}
			}
			 if(vm_infolist.get(i).getVm_ipaddr2() != null) {
				if(vm_infolist.get(i).getVm_ipaddr2().substring(0,3).equals("org")) {
					vm_infolist.get(i).setVm_ipaddr2(vm_infolist.get(i).getVm_ipaddr2().replace(vm_infolist.get(i).getVm_ipaddr2(), "ip empty"));
				}
			 }
			  if(vm_infolist.get(i).getVm_ipaddr3() != null) {
				if(vm_infolist.get(i).getVm_ipaddr3().substring(0,3).equals("org")) {
					vm_infolist.get(i).setVm_ipaddr3(vm_infolist.get(i).getVm_ipaddr3().replace(vm_infolist.get(i).getVm_ipaddr3(), "ip empty"));
				}
			  }
		}
		
		mav.addObject("vm_infolist", vm_infolist);
		return mav;
	}
	
	@RequestMapping("data/serviceList.do")
	public ModelAndView serviceList(String ten,String se) {
		ModelAndView mav = new ModelAndView();
		
		if(ten != null) {
			mav.addObject("ten",ten);	
		}
		if(se != null) {
			mav.addObject("se",se);	
		}
		
		return mav;
	}
	
	@RequestMapping("data/vmUsageStatistics.do")
	public ModelAndView vmUsageStatistics(String ca,String pa,String ch,String vn,Integer ts,String dt) {
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
	
	@RequestMapping("data/hostUsageStatistics.do")
	public ModelAndView hostUsageStatistics() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	/*@RequestMapping("data/serverSetting.do")
	public ModelAndView serverSetting() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}*/
	
	@RequestMapping("data/autoScaleOut.do")
	public ModelAndView autoScaleOut() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	/*@RequestMapping("data/otherSetting.do")
	public ModelAndView otherSetting() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}*/
	
	@RequestMapping("data/agentStatistics.do")
	public ModelAndView agentStatistics() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	/*@RequestMapping("data/userReqResHistory.do")
	public ModelAndView userReqResHistory() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}*/
	
	@RequestMapping("data/department.do")
	public ModelAndView department() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/vmReport.do")
	public ModelAndView vmReport() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/vmReportOriginal.do")
	public ModelAndView vmReportOriginal() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/hostReport.do")
	public ModelAndView hostReport() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/hostReportOriginal.do")
	public ModelAndView hostReportOriginal() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/vmMonitoring.do")
	public ModelAndView vmMonitoring(String vn,String ten,String se) {
		ModelAndView mav = new ModelAndView();
		
		if(vn != null) { mav.addObject("vmActiveName",vn);}
		
		if(ten != null) { mav.addObject("ten",ten);}
		
		if(se != null) { mav.addObject("se",se);}
		
		return mav;
	}
	
	@RequestMapping("data/hostMonitoring.do")
	public ModelAndView hostMonitoring(String cn,String hn) {
		ModelAndView mav = new ModelAndView();
		
		if(cn != null) {
			mav.addObject("clusterActiveName",cn);
		}
		if(hn != null) {
			mav.addObject("hostActiveName",hn);
		}
		
		return mav;
	}
	
	@RequestMapping("data/lateVMResource.do")
	public ModelAndView lateVMResource() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/informationPROM.do")
	public ModelAndView informationPROM() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/dashClusterWidget.do")
	public ModelAndView dashClusterWidget() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/Mallhostlist.do")
	public ModelAndView Mallhostlist() {
		ModelAndView mav = new ModelAndView();
		
		//mav.addObject("vm_hostinfolist", vm_hostinfolist);
		return mav;
	}

	@RequestMapping("data/Mallstoragelist.do")
	public ModelAndView Mallstoragelist() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/autoScaleUP.do")
	public ModelAndView autoScaleUP() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/manualScaleOut.do")
	public ModelAndView manualScaleOut() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/vmDetailList.do")
	public ModelAndView vmDetailList() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("data/applyVMCreate.do")
	public ModelAndView applyVMCreate() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

	/**
	 * 승인 > 가상머신 생성 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("data/applyVMlist.do")
	//@RequestMapping("/approval/approvalCreateVM.prom")
	public String createVM() {
		//return "approval/approvalCreateVM";
		return "data/applyVMlist";
	}
	
}


