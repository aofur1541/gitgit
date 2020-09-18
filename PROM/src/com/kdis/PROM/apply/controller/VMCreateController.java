package com.kdis.PROM.apply.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.apply.service.VMService;
import com.kdis.PROM.apply.vo.ApprovalWorkflowVO;
import com.kdis.PROM.apply.vo.VMCreateVO;
import com.kdis.PROM.apply.vo.VMDataVO;
import com.kdis.PROM.common.CommonAPI;
import com.kdis.PROM.common.Constants;
import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.tenant.service.TenantService;
import com.kdis.PROM.tenant.service.VMServiceService;
import com.kdis.PROM.tenant.vo.TenantVO;
import com.kdis.PROM.tenant.vo.VMServiceVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 신청 > 가상머신 생성 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class VMCreateController {

	/** 가상머신 서비스 */
	@Autowired
	private VMService vmService;
	
	/** 테넌트 서비스 */
	@Autowired
	private TenantService tenantService;
	
	/** 서비스 서비스 */
	@Autowired
	private VMServiceService vmServiceService;
	
	/** API 서비스 */
	@Autowired
	private CommonAPI api;
	
	/** 이력 서비스 */
	@Autowired
	private LogService logService;
	
	/**
	 * 신청 > 가상머신 생성 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/apply/applyCreateVM.prom")
	public String applyCreateVM() {
		return "apply/applyCreateVM";
	}
	
	/**
	 * ON인 가상머신 템플릿 목록 조회
	 * 
	 * @param searchParam 검색어
	 * @param sort 정렬:AES, DESC
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/apply/selectVMTemplateOnList.do")
	public List<VMDataVO> selectVMTemplateOnList(String searchParam, String sort) {
		List<VMDataVO> result = vmService.selectVMTemplateOnList(searchParam, sort);
		return result;
	}
	
	/**
	 * 가상머신 생성 등록
	 * 
	 * @param vmCreateVO
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/apply/insertVMCreate.do")
	public @ResponseBody int insertVMCreate(VMCreateVO vmCreateVO, HttpSession session) throws Exception {
		
		// 결과
		int result = 0;
		int category = 0;
		String keyword = "";

		// 서비스 정보 조회
		VMServiceVO serviceVO = vmServiceService.selectVMService(vmCreateVO.getVmServiceID());
		// 테넌트 정보 조회
		TenantVO tenantVO = new TenantVO();
		if(serviceVO != null) {
			tenantVO = tenantService.selectTenant(serviceVO.getTenantId());
		}
		
		// 승인 권한 유무
		boolean isControlcheck = false;
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		if (loginInfo.getnApproval() == Constants.SUPER_ADMIN_NUMBER 
				|| loginInfo.getnApproval() == Constants.TENANT_ADMIN_NUMBER) {
			// 테넌트 관리자, 슈퍼관리자인 경우
			isControlcheck = true;
			
			// DHCP 값에 따른 가상머신 게이트웨이, 아이피 설정
			vmCreateVO = vmService.setGatewayAndNetmaskByDHCP(tenantVO, serviceVO, vmCreateVO);
		}

		if (isControlcheck) {
			// 테넌트 관리자, 슈퍼관리자인 경우에는 승인 상태로 바로 완료로 한다.
			vmCreateVO.setCrApproval(vmService.getStage(loginInfo.getnApproval()));
			keyword = "Create";
			category = 0;
		} else {
			// 그외는 승인 상태를 신청으로 한다.
			vmCreateVO.setCrApproval(vmService.getStage(loginInfo.getnApproval()));
			keyword = "Request";
			category = 2;
		}

		vmCreateVO.setCrSorting(1);
		vmCreateVO.setCrUserID(LoginSessionUtil.getStringLoginInfo(session, "sUserID"));
		
		// 가상머신 생성 등록
		result = vmService.insertVMCreate(vmCreateVO);

		// 신청자가 승인 권한을 가지고 있는 경우에는 API를 이용해 바로 가상머신을 생성한다.
		if (isControlcheck) {
			// vRO(vRealize Orchestrator) 서버의 VM 생성 API 실행
			result = api.createVM(vmCreateVO);
		}

		// 가상머신 생성 승인 Workflow 등록
		ApprovalWorkflowVO approvalWorkflowVO = new ApprovalWorkflowVO();

		approvalWorkflowVO.setsUserID(vmCreateVO.getCrUserID());
		approvalWorkflowVO.setCrNum(vmCreateVO.getCrNum());
		approvalWorkflowVO.setDescription(vmCreateVO.getCrVMContext());
		approvalWorkflowVO.setStage(vmService.getStage(loginInfo.getnApproval()));
		approvalWorkflowVO.setStatus(3);

		vmService.insertApprovalWorkflow(approvalWorkflowVO);
		
		// 로그 기록
		String context = "[" + vmCreateVO.getCrVMName() + "]";
		context += " 템플릿 : " + vmCreateVO.getCrTemplet() + ",";
		context += " vCPU : " + vmCreateVO.getCrCPU() + ",";
		context += " Memory : " + vmCreateVO.getCrMemory() + "GB,";
		context += " Disk : " + vmCreateVO.getCrDisk() + "GB,";
		
		if (isControlcheck) { 
			context += " IP : " + vmCreateVO.getCrIPAddress() + ","; 
		}
		
		context += " 테넌트 : " + vmCreateVO.getTenantName() + ",";
		if (isControlcheck) {
			context += " 서비스 : " + vmCreateVO.getServiceName() + ",";
			context += " 게이트웨이 : " + vmCreateVO.getCrGateway() + ",";
			context += " 서브넷마스크 : " + vmCreateVO.getCrNetmask() + ",";
			if (vmCreateVO.getCrDhcp() == 1) { 
				context += " DHCP : ON";
			} else { 
				context += " DHCP : OFF"; 
			}
		} else {
			context += " 서비스 : " + vmCreateVO.getServiceName();
		}

		logService.insertLog(category, context, "가상머신", keyword);

		return result;
	}
}
