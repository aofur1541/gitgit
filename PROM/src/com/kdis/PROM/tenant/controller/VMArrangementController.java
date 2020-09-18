package com.kdis.PROM.tenant.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.apply.service.VMService;
import com.kdis.PROM.apply.vo.VMDataVO;
import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 인프라 관리 > 그룹 관리 > 가상머신 배치 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class VMArrangementController {

	/** 가상머신 서비스 */
	@Autowired
	private VMService vmDataService;
	
	/** 이력 서비스 */
	@Autowired
	private LogService logService;
	
	// TODO 새로운 가상머신 배치 화면이 적용된 이후에는 삭제해야 함
	@RequestMapping("/data/serviceMapping.do")
	public String serviceMapping() {
		return "/data/serviceMapping";
	}
	
	/**
	 * 인프라 관리 > 그룹 관리 > 서비스 매핑 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/serviceGroup/arrangeVM.prom")
	public String arrangeVM() {
		return "serviceGroup/arrangeVM";
	}
	
	/**
	 * 서비스에 배치된 가상머신 목록 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectArrangedVMList.do")
	public List<VMDataVO> selectArrangedVMList() {
		List<VMDataVO> result = vmDataService.selectArrangedVMList();
		return result;
	}
	
	/**
	 * 서비스에 미배치된 가상머신 목록 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectUnarrangedVMList.do")
	public List<VMDataVO> selectUnarrangedVMList() {
		List<VMDataVO> result = vmDataService.selectUnarrangedVMList();
		return result;
	}
	
	/**
	 * 가상머신 목록을 서비스에 배치
	 * 
	 * @param vmIDList
	 * @param vmNameList
	 * @param vmServiceID
	 * @param tenantName
	 * @param vmServiceName
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/tenant/arrangeVM.do", method=RequestMethod.POST)
	public int arrangeVM(String[] vmIDList, String[] vmNameList, Integer vmServiceID, String tenantName, String vmServiceName, HttpSession session) {
		
		// 결과
		int result = 0;
		
		if(vmIDList != null && vmIDList.length > 0 && vmServiceID != null && vmServiceID != 0) {
			// 가상머신 목록의 서비스ID 수정
			vmDataService.updateVmDataServiceId(vmIDList, vmServiceID);
			result = 1;
		}
		
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);

		// 이력 기록
		String context = "";
		for(String vmName : vmNameList) {
			context += ", " + vmName;
		}
		if(context.length() > 0) context = context.substring(1);
		context = "테넌트 : " + tenantName + ", 서비스 : " + vmServiceName + ", 배치 가상머신 : " + context;
		
		logService.insertLog(loginInfo.getsUserID(), 0, context, "서비스", "Mapping");
		
		return result;
	}
	
	/**
	 * 가상머신 목록을 서비스 미배치로 수정
	 * 
	 * @param vmIDList
	 * @param vmNameList
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/tenant/unarrangeVM.do", method=RequestMethod.POST)
	public int unarrangeVM(String[] vmIDList, String vmNameList[], HttpSession session) {
		
		// 결과
		int result = 0;
		
		if(vmIDList != null && vmIDList.length > 0 ) {
			// 가상머신 목록의 서비스ID 수정
			vmDataService.updateVmDataServiceId(vmIDList, null);
			result = 1;
		}

		// 이력 기록
		String context = "";
		for(String vmName : vmNameList) {
			context += ", " + vmName;
		}
		if(context.length() > 0) context = context.substring(1);
		context += " 서비스 배치 -> 미배치 이동";
		
		logService.insertLog(0, context, "서비스", "Mapping");
		
		return result;
	}
	
}
