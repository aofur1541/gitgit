package com.kdis.PROM.approval.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.apply.service.VMService;
import com.kdis.PROM.apply.vo.ApprovalWorkflowVO;
import com.kdis.PROM.apply.vo.VMCDROMVO;
import com.kdis.PROM.apply.vo.VMCreateVO;
import com.kdis.PROM.apply.vo.VMDataVO;
import com.kdis.PROM.apply.vo.VMDiskVO;
import com.kdis.PROM.apply.vo.VMNetworkVO;
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
 * 가상머신 승인 관련  Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class VMApprovalController {

	/** 가상머신 서비스 */
	@Autowired
	private VMService vmService;
	
	/** 테넌트 서비스 */
	@Autowired
	private TenantService tenantService;
	
	/** 서비스 서비스 */
	@Autowired
	private VMServiceService vmServiceService;	
	
	/** 이력 service */
	@Autowired
	private LogService logService;
	
	/** API 서비스 */
	@Autowired
	private CommonAPI api;
	
	/**
	 * 승인 > 가상머신 생성 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/approval/approvalCreateVM.prom")
	public String approvalCreateVM() {
		return "approval/approvalCreateVM";
	}
	
	/**
	 * 승인 > 가상머신 자원 변경 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/approval/approvalChangeVM.prom")
	public String approvalChangeVM() {
		return "approval/approvalChangeVM";
	}

	/**
	 * 가상머신 생성/변경 신청 목록 조회
	 * 
	 * @param applyLevel 신청 구분
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/approval/selectApplyVMList.do")
	public List<VMCreateVO> selectApplyVMList(Integer applyLevel) {
		
		// 로그인 사용자 승인(권한)에 따른 승인 단계 얻기
		int stage = vmService.getStage();
		
		// 전단계
		int stageDown = stage - 1;
		
		// 사용자 로그인 정보 얻기
		UserVO sessionInfo = LoginSessionUtil.getLoginInfo();
		
		VMCreateVO searchVO = new VMCreateVO();
		searchVO.setCrSorting(applyLevel);
		searchVO.setStage(stage);
		searchVO.setStageDown(stageDown);
		searchVO.setnApproval(sessionInfo.getnApproval());
		
		// 가상머신 생성 신청 목록 조회
		List<VMCreateVO> ApplyVMList = vmService.selectApplyVMList(searchVO);

		return ApplyVMList;
	}
	
	/**
	 * 로그인한 사용자와 매핑된 서비스 그룹의 가상머신 생성/변경 신청 목록 조회
	 * 
	 * @param applyLevel
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/approval/selectApplyVMListByUserMapping.do")
	public List<VMCreateVO> selectApplyVMListByUserMapping(int applyLevel) {
		
		// 로그인 사용자 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		
		VMCreateVO searchVO = new VMCreateVO();
		searchVO.setCrSorting(applyLevel);
		searchVO.setUserId(loginInfo.getId());
		searchVO.setnApproval(Constants.SUPER_ADMIN_NUMBER);
		
		List<VMCreateVO> result = vmService.selectApplyVMListByUserMapping(searchVO);
		return result;
	}
	
	/**
	 * 가상머신 승인 Workflow 목록 조회
	 * 
	 * @param crNum 가상머신 생성 아이디
	 * @param stage 단계
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/approval/selectApprovalWorkflowList.do")
	public List<ApprovalWorkflowVO> selectApprovalWorkflowList(Integer crNum, Integer stage) {
		List<ApprovalWorkflowVO> result = vmService.selectApprovalWorkflowList(crNum, stage);
		return result;
	}
	
	/**
	 * 가상머신 생성 정보 조회
	 * 
	 * @param vmCreateVO 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/approval/selectVMCreate.do")
	public VMCreateVO selectVMCreate(VMCreateVO vmCreateVO) {
		VMCreateVO result = vmService.selectVMCreate(vmCreateVO);
		return result;
	}
	
	/**
	 * 승인 상태 수정
	 * 
	 * @param crNum 가상머신 생성 아이디
	 * @param description 사유
	 * @param index 승인 단계
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/approval/updateVMCreateApproval.do")
	public int updateVMCreateApproval(Integer crNum, String description, int index) {
		
		// 로그인 사용자 승인(권한)에 따른 승인 단계 얻기
		int stage = vmService.getStage();
		
		// 로그인 사용자 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		
		// 상태 설정
		int status = 0;
		if (index == 1) {
			status = 3;
		} else if (index == 2) {
			status = 5;
		} else if (index == 3) {
			status = 6;
		}

		ApprovalWorkflowVO approvalWorkflowVO = new ApprovalWorkflowVO();
		approvalWorkflowVO.setStage(stage);
		approvalWorkflowVO.setStatus(status);
		approvalWorkflowVO.setsUserID(loginInfo.getsUserID());
		approvalWorkflowVO.setDescription(description);
		approvalWorkflowVO.setCrNum(crNum);

		//  가상머신 승인 Workflow에 승인 등록
		int result = vmService.insertApprovalWorkflow(approvalWorkflowVO);

		// 가상머신 생성 정보에 승인 상태 수정
		vmService.updateVMCreateApproval(crNum, stage);
		
		// 가상머신 생성 신청 정보 조회
		VMCreateVO searchVO = new VMCreateVO();
		searchVO.setCrNum(crNum);
		VMCreateVO vmCreateVO = vmService.selectVMCreate(searchVO);
		
		// 승인 로그 기록
		String context = "";
		if (stage == 2) {
			context = "결재";
		} else if (stage == 3) {
			context = "검토";
		} else if (stage == 4) {
			context = "검토승인";
		}
		context = "[" + vmCreateVO.getCrVMName() + "] " + context;
		logService.insertLog(loginInfo.getsUserID(), 2, context, "가상머신", "Approval");

		return result;
	}
	
	/**
	 * 가상머신 생성/변경 최종 승인
	 * 
	 * @param vmCreateVO
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/approval/approvalVMCreate.do")
	public int approvalVMCreate(VMCreateVO vmCreateVO) throws Exception {
		
		// 결과
		int result = 0;
		// 로그상세
		String context = "";
		// 단계
		int stage = vmService.getStage();
		
		// 가상머신 생성 신청 정보 조회
		VMCreateVO searchVO = new VMCreateVO();
		searchVO.setCrNum(vmCreateVO.getCrNum());
		VMCreateVO dbVMCreate = vmService.selectVMCreate(searchVO);
		
		if(vmCreateVO.getCrSorting() == 1) {
			// 가상머신 생성 최종 승인
			
			// 서비스 정보 얻기
			VMServiceVO serviceVO = vmServiceService.selectVMService(dbVMCreate.getVmServiceID());
			// 테넌트 정보 얻기
			TenantVO tenantVO = tenantService.selectTenant(serviceVO.getTenantId());
			
			// DHCP 값에 따른 가상머신 게이트웨이, 아이피 설정
			vmCreateVO = vmService.setGatewayAndNetmaskByDHCP(tenantVO, serviceVO, vmCreateVO);
			
			// 운영자가 수정한 값 설정
			dbVMCreate.setCrHost(vmCreateVO.getCrHost());
			dbVMCreate.setCrStorage(vmCreateVO.getCrStorage());
			dbVMCreate.setCrNetWork(vmCreateVO.getCrNetWork());
			dbVMCreate.setCrIPAddress(vmCreateVO.getCrIPAddress());
			dbVMCreate.setCrNetmask(vmCreateVO.getCrNetmask());
			dbVMCreate.setCrGateway(vmCreateVO.getCrGateway());
			dbVMCreate.setCrDhcp(vmCreateVO.getCrDhcp());
			
			// 가상머신 생성 정보에 승인 상태 수정
			if(dbVMCreate.getCrDhcp() == 2 && 
					vmCreateVO.getCrIPAddress() != null && !"".equals(vmCreateVO.getCrIPAddress())) {
				vmService.updateVMCreateApproval(dbVMCreate.getCrNum(), 8, vmCreateVO.getCrIPAddress());
			} else {
				vmService.updateVMCreateApproval(dbVMCreate.getCrNum(), 8);
			}
			
			// vRO(vRealize Orchestrator) 서버의 VM 생성 API 실행
			result = api.createVM(dbVMCreate);
			
			// 로그 상세
			context = "["+dbVMCreate.getCrVMName()+"] ";
			
			context += "템플릿 : " + dbVMCreate.getCrTemplet() + ", ";
			context += "vCPU : " + dbVMCreate.getCrCPU() + ", ";
			context += "Memory : " + dbVMCreate.getCrMemory() + "GB, ";
			context +=	"Disk : " + dbVMCreate.getCrDisk() + "GB, ";
			context += "IP : " + dbVMCreate.getCrIPAddress() + ", ";
			context += "테넌트 : " + dbVMCreate.getTenantName() + ", ";
			context += "서비스 : " + dbVMCreate.getServiceName() + ", ";
			context += "게이트웨이 : " + dbVMCreate.getCrGateway() + ", ";
			context += "서브넷마스크 : " + dbVMCreate.getCrNetmask() + ", ";
			if (dbVMCreate.getCrDhcp() == 1) {
				context += "DHCP : ON";
			} else if (dbVMCreate.getCrDhcp() == 2) {
				context += "DHCP : OFF";
			}
		} else if(vmCreateVO.getCrSorting() == 2) {
			// 가상머신 변경 최종 승인
			
			// 가상머신명으로 가상머신 정보 조회
			VMDataVO dbVMData = vmService.selectVMDataByVMName(dbVMCreate.getCrVMName());
			
			if(dbVMData == null) {
				// 자원 변경하려는 가상머신 없음
				result = 2;
				return result;
			}
			
			if("addDisk".equals(vmCreateVO.getCategory())) {
				// Disk 추가
				VMDiskVO searchVMDiskVO = new VMDiskVO();
				searchVMDiskVO.setsVmID(vmCreateVO.getVmID());
				List<VMDiskVO> vmDiskList = vmService.selectVMDiskList(searchVMDiskVO);
				
				VMDiskVO vmDiskVO = new VMDiskVO();
				vmDiskVO.setsVmName(vmCreateVO.getCrVMName());
				vmDiskVO.setnDiskCapacity(vmCreateVO.getCrDisk());
				vmDiskVO.setsDiskId(vmCreateVO.getSelectedValue());
				vmDiskVO.setsDiskLocation(vmCreateVO.getSelectedText());
				vmDiskVO.setnSCSInumber((vmDiskList.size()+1));
				
				//vRO 서버 API를 통해 disk 추가
				result = api.addVMDisk(vmDiskVO);
				
				context = "["+vmDiskVO.getsVmName()+"] 디스크 추가 승인 " + vmDiskVO.getnDiskCapacity() + "GB " + vmDiskVO.getsDiskLocation() + " 데이터스토어";
			
			} else if("addCDROM".equals(vmCreateVO.getCategory())) {
				// CD-ROM 추가
				
				VMCDROMVO vmCDROMVO = new VMCDROMVO();
				vmCDROMVO.setsVmID(vmCreateVO.getVmID());
				vmCDROMVO.setsVmName(vmCreateVO.getCrVMName());
				vmCDROMVO.setDataStoreName(vmCreateVO.getSelectedText());
				vmCDROMVO.setFilePath(vmCreateVO.getCrTemplet());
				
				// 가상머신 CD-ROM 제어(MOUNT) API
				vmCDROMVO.setMode("MOUNT");
				api.controlVMCDROM(vmCDROMVO);
				
				// 가상머신 CD-ROM 등록
				result = vmService.insertVMCDROM(vmCDROMVO);
				
				context = "["+vmCDROMVO.getsVmName()+"] ["+vmCDROMVO.getDataStoreName()+"] " + vmCDROMVO.getFilePath() + " CD-ROM 연결 승인";

			} else if("addvNic".equals(vmCreateVO.getCategory())) {
				// vNIC 추가
				
				VMNetworkVO vmNetworkVO = new VMNetworkVO();
				vmNetworkVO.setsVmName(vmCreateVO.getCrVMName());
				vmNetworkVO.setPortgroup(vmCreateVO.getSelectedText());
				vmNetworkVO.setPortgroupId(vmCreateVO.getSelectedValue());
				
				//vRO 서버 API를 가상머신 네트워크 추가 
				result = api.addVMNetwork(vmNetworkVO);
				
				context = "["+vmNetworkVO.getsVmName()+"] 네트워크 어댑터 추가 " + vmNetworkVO.getPortgroup()+" 승인";
				
			} else {
				// CPU, 메모리 변경
				
				String switchMsg = "";
				if("true".equals(dbVMData.getCpuHotAdd()) && "true".equals(dbVMData.getMemoryHotAdd())) {
					switchMsg = "ON";
					// vRO(vRealize Orchestrator) 서버의 VM 변경 API 실행
					api.changeVMHotAddON(dbVMCreate);
				}else {
					switchMsg = "OFF";
					// vRO(vRealize Orchestrator) 서버의 VM 변경(핫플러그 ON) API 실행
					api.changeVM(dbVMCreate);
				}
				
				context = "["+dbVMCreate.getCrVMName()+"] ";
				context += "CPU : " + dbVMData.getVmCPU() + " -> " + dbVMCreate.getCrCPU() + ", ";
				context += "Memory : " + dbVMData.getVmMemory() + "GB -> " + dbVMCreate.getCrMemory() + "GB 변경 승인 완료(Hot 플러그 "+switchMsg+")";
			
			}
			
			// 승인 상태 완료로 수정
			vmService.updateVMCreateApproval(dbVMCreate.getCrNum(), 8);
		} else if(vmCreateVO.getCrSorting() == 3) {
			// 가상머신 반환
			
			// 가상머신명으로 가상머신 정보 조회
			VMDataVO dbVMData = vmService.selectVMDataByVMName(dbVMCreate.getCrVMName());
			
			// 서비스에 매핑된 것을 해제한다.
			vmService.updateVmDataServiceId(dbVMData.getVmID(), null);
			
			// 승인 상태 완료로 수정
			vmService.updateVMCreateApproval(dbVMCreate.getCrNum(), 8);
			
			context = "[" + dbVMCreate.getCrVMName() + "] "+"반환 승인 완료";
		}
		
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		
		// 가상머신 생성 승인 Workflow 등록
		ApprovalWorkflowVO approvalWorkflowVO = new ApprovalWorkflowVO();
		
		approvalWorkflowVO.setsUserID(loginInfo.getsUserID());
		approvalWorkflowVO.setCrNum(dbVMCreate.getCrNum());
		approvalWorkflowVO.setDescription(vmCreateVO.getDescription());
		approvalWorkflowVO.setStage(stage);
		approvalWorkflowVO.setStatus(7);
		
		// 가상머신 승인 Workflow 목록 조회
		List<ApprovalWorkflowVO> approvalWorkflowList = vmService.selectApprovalWorkflowList(vmCreateVO.getCrNum(), 5);
		
		if(approvalWorkflowList == null || approvalWorkflowList.size() == 0) {
			// 5단계까지 진행되지 않은 경우
			vmService.insertApprovalWorkflow(approvalWorkflowVO);
		} else {
			// 5단계까지 진행된 경우
			vmService.updateApprovalWorkflow(approvalWorkflowVO);
		}
		
		// 로그 기록
		logService.insertLog(2, context, "가상머신", "Approval");
		
		return result;
	}
	
	/**
	 * 가상머신 생성/변경 보류
	 * 
	 * @param vmCreateVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/approval/holdVMCreate.do")
	public int holdVMCreate(VMCreateVO vmCreateVO) {
		
		// 결과
		int result = 0;
		
		if(vmCreateVO.getDescription() == null || "".equals(vmCreateVO.getDescription())) {
			vmCreateVO.setDescription("보류사유 없음");
		}
		
		// 가상머신 생성 신청 정보 조회
		VMCreateVO searchVO = new VMCreateVO();
		searchVO.setCrNum(vmCreateVO.getCrNum());
		VMCreateVO dbCreate = vmService.selectVMCreate(searchVO);
		
		// 가상머신 생성/변경 보류
		result = vmService.holdVMCreate(vmCreateVO.getCrNum(), vmCreateVO.getDescription());
		
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
				
		// 가상머신 생성 승인 Workflow 등록
		ApprovalWorkflowVO approvalWorkflowVO = new ApprovalWorkflowVO();
		
		approvalWorkflowVO.setsUserID(loginInfo.getsUserID());
		approvalWorkflowVO.setCrNum(vmCreateVO.getCrNum());
		approvalWorkflowVO.setDescription(vmCreateVO.getDescription());
		approvalWorkflowVO.setStage(vmService.getStage());
		approvalWorkflowVO.setStatus(6);
		
		vmService.insertApprovalWorkflow(approvalWorkflowVO);
		
		// 로그 기록
		String context = "";
		if(dbCreate.getCrSorting() == 1) {
			context = "["+dbCreate.getCrVMName()+"]"+" 생성 보류, 사유 : " + vmCreateVO.getDescription();
		} else {
			context = "["+dbCreate.getCrVMName()+"]"+" 변경 보류, 사유 : " + vmCreateVO.getDescription();
		}
		
		logService.insertLog(2, context, "가상머신", "Hold");
		
		return result;
	}
	
	/**
	 * 가상머신 생성/변경/반환 반려
	 * 
	 * @param vmCreateVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/approval/rejectVMCreate.do")
	public int rejectVMCreate(VMCreateVO vmCreateVO) {
		
		// 결과
		int result = 0;
		
		if(vmCreateVO.getDescription() == null || "".equals(vmCreateVO.getDescription())) {
			vmCreateVO.setDescription("반려사유 없음");
		}
		
		// 가상머신 생성 신청 정보 조회
		VMCreateVO searchVO = new VMCreateVO();
		searchVO.setCrNum(vmCreateVO.getCrNum());
		VMCreateVO dbCreate = vmService.selectVMCreate(searchVO);
		
		// 가상머신 생성/변경/반환 반려
		result = vmService.rejectVMCreate(vmCreateVO.getCrNum(), vmCreateVO.getDescription());
			
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
						
		// 가상머신 생성 승인 Workflow 등록
		ApprovalWorkflowVO approvalWorkflowVO = new ApprovalWorkflowVO();
		
		approvalWorkflowVO.setsUserID(loginInfo.getsUserID());
		approvalWorkflowVO.setCrNum(vmCreateVO.getCrNum());
		approvalWorkflowVO.setDescription(vmCreateVO.getDescription());
		approvalWorkflowVO.setStage(vmService.getStage());
		approvalWorkflowVO.setStatus(5);
		
		// 가상머신 승인 Workflow 목록 조회
		List<ApprovalWorkflowVO> approvalWorkflowList = vmService.selectApprovalWorkflowList(vmCreateVO.getCrNum(), 5);
		
		if(approvalWorkflowList == null || approvalWorkflowList.size() == 0) {
			// 5단계까지 진행되지 않은 경우
			vmService.insertApprovalWorkflow(approvalWorkflowVO);
		} else {
			// 5단계까지 진행된 경우
			vmService.updateApprovalWorkflow(approvalWorkflowVO);
		}
		
		// 로그 기록
		String context = "";
		if(dbCreate.getCrSorting() == 1) {
			context = "["+dbCreate.getCrVMName()+"]"+" 생성 반려, 사유 : " + vmCreateVO.getDescription();
		} else if(dbCreate.getCrSorting() == 2) {
			context = "["+dbCreate.getCrVMName()+"]"+" 변경 반려, 사유 : " + vmCreateVO.getDescription();
		} else {
			context = "["+dbCreate.getCrVMName()+"]"+" 반환 반려, 사유 : " + vmCreateVO.getDescription();
		}
		
		logService.insertLog(2, context, "가상머신", "Return");
		
		return result;
	}
	
	/**
	 * 가상머신 생성/변경/반환 신청 취소
	 * 
	 * @param crNum
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/approval/cancelVMCreate.do")
	public int cancelVMCreate(Integer crNum) {
		
		// 결과
		int result = 0;

		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		
		// 가상머신 생성 승인 Workflow 등록
		ApprovalWorkflowVO approvalWorkflowVO = new ApprovalWorkflowVO();
		
		approvalWorkflowVO.setsUserID(loginInfo.getsUserID());
		approvalWorkflowVO.setCrNum(crNum);
		approvalWorkflowVO.setDescription("");
		approvalWorkflowVO.setStage(vmService.getStage());
		approvalWorkflowVO.setStatus(2);
		
		// 가상머신 승인 Workflow 목록 조회
		List<ApprovalWorkflowVO> approvalWorkflowList = vmService.selectApprovalWorkflowList(crNum, vmService.getStage());
		
		if(approvalWorkflowList == null || approvalWorkflowList.size() == 0) {
			// 단계까지 진행되지 않은 경우
			vmService.insertApprovalWorkflow(approvalWorkflowVO);
		} else {
			// 단계까지 진행된 경우
			vmService.updateApprovalWorkflow(approvalWorkflowVO);
		}
				
		// 가상머신 생성/변경/반환 신청 취소
		result = vmService.updateVMCreateApproval(crNum, 10);

		return result;
	}
}
