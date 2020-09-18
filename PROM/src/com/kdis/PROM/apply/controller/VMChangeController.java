package com.kdis.PROM.apply.controller;

import java.net.URISyntaxException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.apply.service.VMService;
import com.kdis.PROM.apply.vo.ApprovalWorkflowVO;
import com.kdis.PROM.apply.vo.VMCDROMVO;
import com.kdis.PROM.apply.vo.VMCreateVO;
import com.kdis.PROM.apply.vo.VMDataVO;
import com.kdis.PROM.apply.vo.VMDiskVO;
import com.kdis.PROM.apply.vo.VMNetworkVO;
import com.kdis.PROM.common.CommonAPI;
import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 신청 > 가상머신 설정 변경 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class VMChangeController {
	
	private static final Log LOG = LogFactory.getLog( VMChangeController.class );

	/** 가상머신 서비스 */
	@Autowired
	private VMService vmService;
	
	/** API 서비스 */
	@Autowired
	private CommonAPI api;
	
	/** 이력 서비스 */
	@Autowired
	private LogService logService;
	
	
	
	
	@ResponseBody
	@RequestMapping(value="/apply/changedescription.do",method=RequestMethod.POST)
	public void changedescription(String vmName,String description) throws Exception {
		
		
	
		
		// 가상머신 정보 조회
		VMDataVO dbVMData = vmService.selectVMDataByVMName(vmName);
		dbVMData.setDescription(description);
		
		vmService.updateVmDataComment(dbVMData);
		//로그 찍어줘
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 신청 > 가상머신 설정 변경 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/apply/applyChangeVM.prom")
	public String applyChangeVM() {
		return "apply/applyChangeVM";
	}
	
	/**
	 * 가상머신 조회
	 * 
	 * @param vmId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/apply/selectVMData.do")
	public VMDataVO selectVMData(String vmId) {
		VMDataVO result = vmService.selectVMData(vmId);
		return result;
	}
	
	/**
	 * 가상머신 목록 조회
	 * 
	 * @param vmDataVO
	 * @param isUserTenantMapping 사용자에 매핑된 테넌트만을 대상으로 할지 여부
	 * @return
	 */
	@RequestMapping("/apply/selectVMDataList.do")
	public @ResponseBody List<VMDataVO> selectVMDataList(VMDataVO vmDataVO, String isUserTenantMapping) {
		List<VMDataVO> result = null;
		
		if("true".equals(isUserTenantMapping)) {
			// 로그인한 사용자에게 매핑된 테넌트만을 대상으로 한다.
			
			// 세션에서 로그인 정보 얻기
			UserVO sessionInfo = LoginSessionUtil.getLoginInfo();
			
			// 로그인한  사용자가 속한 서비스 목록 조회
			vmDataVO.setUserId(sessionInfo.getId());
			result = vmService.selectVMDataListByUserMapping(vmDataVO);
		} else {
			// 전체 테넌트 대상
			result = vmService.selectVMDataList(vmDataVO);
		}
		return result;
	}
	
	/**
	 * 가상머신 Disk 목록 조회
	 * 
	 * @param vmID 가상머신 ID
	 * @return
	 */
	@RequestMapping("/apply/selectVMDiskList.do")
	public @ResponseBody List<VMDiskVO> selectVMDiskList(String vmID) {
		VMDiskVO vmDiskVO = new VMDiskVO();
		vmDiskVO.setsVmID(vmID);
		List<VMDiskVO> result = vmService.selectVMDiskList(vmDiskVO);
		return result;
	}
	
	/**
	 * 가상머신 네트워크 인터페이스 목록 조회
	 * 
	 * @param vmID 가상머신 ID
	 * @return
	 */
	@RequestMapping("/apply/selectVMNetworkList.do")
	public @ResponseBody List<VMNetworkVO> selectVMNetworkList(String vmID) {
		VMNetworkVO vmNetworkVO = new VMNetworkVO();
		vmNetworkVO.setsVmID(vmID);
		List<VMNetworkVO> result = vmService.selectVMNetworkList(vmNetworkVO);
		return result;
	}
	
	/**
	 * 가상머신 CD-ROM 목록 조회
	 * 
	 * @param vmID 가상머신 ID
	 * @return
	 */
	@RequestMapping("/apply/selectVMCDROMList.do")
	public @ResponseBody List<VMCDROMVO> selectVMCDROMList(String vmID) {
		VMCDROMVO vmCDROMVO = new VMCDROMVO();
		vmCDROMVO.setsVmID(vmID);
		List<VMCDROMVO> result = vmService.selectVMCDROMList(vmCDROMVO);
		return result;
	}
	
	/**
	 * 가상머신 자원 변경 신청 등록
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 변경 사항 없음
	 * 
	 * @param vmCreateVO
	 * @param vmID
	 * @param session
	 * @return
	 * @throws URISyntaxException
	 */
	@ResponseBody
	@RequestMapping(value="/apply/insertVMChange.do", method=RequestMethod.POST)
	public int insertVMChange(VMCreateVO vmCreateVO, String vmID, HttpSession session) throws URISyntaxException {
		
		// 결과
		int result = 0;
		
		// DB에 저장된 가상머신 정보를 조회한다.
		VMDataVO dbVMData = vmService.selectVMData(vmID);
		
		int cpu = 0;
		int memory = 0;
		try {
			cpu = Integer.parseInt(vmCreateVO.getCrCPU());
		} catch(NumberFormatException e) {
			LOG.warn("CrCPU NumberFormatException : " + vmCreateVO.getCrCPU());
		}
		try {
			memory = Integer.parseInt(vmCreateVO.getCrMemory());
		} catch(NumberFormatException e) {
			LOG.warn("CrMemory NumberFormatException : " + vmCreateVO.getCrMemory());
		}

		// 이력 내용
		String context = "";
		if(cpu != 0 && dbVMData.getVmCPU() != cpu) {
			context += " CPU : " + dbVMData.getVmCPU() + " -> " + vmCreateVO.getCrCPU();
		}
		if(memory != 0 && dbVMData.getVmMemory() != memory) {
			if(context.length() > 0)  context += ",";
			context += " Memory : " + dbVMData.getVmMemory() + "GB -> " + vmCreateVO.getCrMemory() + "GB";
		}
		
		if(context.length() > 0) {
			// 변경된 것이 있는 경우
			UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
			int stage = vmService.getStage(loginInfo.getnApproval());
			
			vmCreateVO.setCrSorting(2);
			vmCreateVO.setCrUserID(loginInfo.getsUserID());
			vmCreateVO.setCrApproval(stage);
			
			// 가상머신 변경 신청 등록
			result = vmService.insertVMCreate(vmCreateVO);
			
			// 가상머신 승인 Workflow 등록
			ApprovalWorkflowVO approvalWorkflowVO = new ApprovalWorkflowVO();
			
			approvalWorkflowVO.setsUserID(vmCreateVO.getCrUserID());
			approvalWorkflowVO.setCrNum(vmCreateVO.getCrNum());
			approvalWorkflowVO.setDescription(vmCreateVO.getCrVMContext());
			approvalWorkflowVO.setStage(stage);
			approvalWorkflowVO.setStatus(3);
			
			vmService.insertApprovalWorkflow(approvalWorkflowVO);
			
			// 이력 기록
			context = "[" + vmCreateVO.getCrVMName() + "]" + context + " 변경 신청";
			logService.insertLog(2, context, "가상머신", "Request");
			
		} else {
			// 변경된 것이 없는 경우
			result = 2;
		}
		return result;
	}
	
	/**
	 * 가상머신 자원 변경
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 변경 사항 없음
	 * 
	 * @param vmCreateVO
	 * @param vmID
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/apply/changeVMResource.do", method=RequestMethod.POST)
	public int changeVMResource(VMCreateVO vmCreateVO, String vmID, HttpSession session) throws Exception {
		
		// 결과
		int result = 0;
				
		// DB에 저장된 가상머신 정보를 조회한다.
		VMDataVO dbVMData = vmService.selectVMData(vmID);
				
		int cpu = 0;
		int memory = 0;
		try {
			cpu = Integer.parseInt(vmCreateVO.getCrCPU());
		} catch(NumberFormatException e) {
			LOG.warn("CrCPU NumberFormatException : " + vmCreateVO.getCrCPU());
		}
		try {
			memory = Integer.parseInt(vmCreateVO.getCrMemory());
		} catch(NumberFormatException e) {
			LOG.warn("CrMemory NumberFormatException : " + vmCreateVO.getCrMemory());
		}
		
		String context = "";
		if(cpu != 0 && dbVMData.getVmCPU() != cpu) {
			context += " CPU : " + dbVMData.getVmCPU() + " -> " + vmCreateVO.getCrCPU();
		}
		if(memory != 0 && dbVMData.getVmMemory() != memory) {
			if(context.length() > 0)  context += ",";
			context += " Memory : " + dbVMData.getVmMemory() + "GB -> " + vmCreateVO.getCrMemory() + "GB";
		}
		
		if(context.length() > 0) {
			// 변경된 것이 있는 경우
			
			// 핫 플러그가 ON/OFF에 따라 실행하는 API가 다르다.
			if("ON".equals(vmCreateVO.getHotPlugOnOff())) {
				api.changeVMHotAddON(vmCreateVO);
			} else {
				api.changeVM(vmCreateVO);
			}
			
			UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
			
			vmCreateVO.setCrApproval(1);
			vmCreateVO.setCrSorting(2);
			vmCreateVO.setCrUserID(loginInfo.getsUserID());
			
			// 가상머신 변경 신청 등록
			result = vmService.insertVMCreate(vmCreateVO);
			
			// 이력 기록
			context = "[" + vmCreateVO.getCrVMName() + "]" + context + " 변경(Hot 플러그 " + vmCreateVO.getHotPlugOnOff() + ")";
			logService.insertLog(2, context, "가상머신", "Request");
			
		} else {
			// 변경된 것이 없는 경우
			result = 2;
		}
		return result;
	}

	/**
	 * 가상머신 Disk 추가 신청 등록
	 * 
	 * @param vmDiskVO
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/apply/addVMDisk.do",method=RequestMethod.POST)
	public int addVMDisk(VMDiskVO vmDiskVO, HttpSession session) {
		
		// 결과
		int result = 0;
		
		try {
			String context = "";
			String keyword = "";
			int category = 0;
			
			// 권한 - 0: 신청, 1: 관리자
			if(vmDiskVO.getRole() == 1) {
				// 관라자
				// 관리자는 바로 vRO 서버 API를 통해 disk 추가
				result = api.addVMDisk(vmDiskVO);
				
				keyword = "Update";
				category = 0;
				context = "["+vmDiskVO.getsVmName()+"] 디스크 추가 "+vmDiskVO.getnDiskCapacity()+"GB "+vmDiskVO.getsDiskLocation()+" 데이터스토어 저장";
				
			} else {
				// 신청
				
				// 가상머신 변경 신청 등록
				VMCreateVO vmCreateVO = new VMCreateVO();
				vmCreateVO.setCrUserID(LoginSessionUtil.getStringLoginInfo(session, "sUserID"));
				vmCreateVO.setCrSorting(2);
				vmCreateVO.setCrApproval(1);
				vmCreateVO.setCrVMName(vmDiskVO.getsVmName());
				vmCreateVO.setCrDisk(vmDiskVO.getnDiskCapacity());
				vmCreateVO.setVmServiceID(vmDiskVO.getServiceId());
				vmCreateVO.setCrVMContext(vmDiskVO.getReasonContext());
				
				result = vmService.insertVMCreate(vmCreateVO);
				
				// 가상머신 승인 Workflow 등록
				vmService.insertApprovalWorkflow(vmCreateVO);
				
				keyword = "Request";
				category = 2;
				context = "["+vmDiskVO.getsVmName()+"] 디스크 추가 신청 : "+vmDiskVO.getnDiskCapacity()+"GB ";
			}

			// 이력 기록
			logService.insertLog(category, context, "가상머신", keyword);
			
			result = 1;
			
		} catch (Exception e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 가상머신 네트워크 추가 신청
	 * 
	 * @param vmNetworkVO
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/apply/addVMNetwork.do",method=RequestMethod.POST)
	public int addVMNetwork(VMNetworkVO vmNetworkVO, HttpSession session) {
		
		// 결과
		int result = 0;
		
		try {
			String context = "";
			String keyword = "";
			int category = 0;
			
			// 권한 - 0: 신청, 1: 관리자
			if(vmNetworkVO.getRole() == 1) {
				// 관라자
				
				// 관리자는 바로 vRO 서버 API를 가상머신 네트워크 추가 
				result = api.addVMNetwork(vmNetworkVO);
				
				keyword = "Update";
				category = 0;
				context = "["+vmNetworkVO.getsVmName()+"] 네트워크 어댑터 추가 : "+vmNetworkVO.getPortgroup();

			} else {
				// 신청
				
				// 가상머신 변경 신청 등록
				VMCreateVO vmCreateVO = new VMCreateVO();
				vmCreateVO.setCrUserID(LoginSessionUtil.getStringLoginInfo(session, "sUserID"));
				vmCreateVO.setCrSorting(2);
				vmCreateVO.setCrApproval(1);
				vmCreateVO.setCrVMName(vmNetworkVO.getsVmName());
				vmCreateVO.setVmServiceID(vmNetworkVO.getServiceId());
				vmCreateVO.setCrVMContext(vmNetworkVO.getReasonContext());
				
				result = vmService.insertVMCreate(vmCreateVO);
				
				// 가상머신 승인 Workflow 등록
				vmService.insertApprovalWorkflow(vmCreateVO);
				
				keyword = "Request";
				category = 2;
				context = "["+vmNetworkVO.getsVmName()+"] 네트워크 어댑터 추가 신청 ";
			}
			
			// 이력 기록
			logService.insertLog(category, context, "가상머신", keyword);
			
			result = 1;
			
		} catch (Exception e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 *  가상머신 네트워크 제어(연결/연결해제/삭제)
	 * 
	 * @param vmNetworkVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/apply/controlVMNetwork.do",method=RequestMethod.POST)
	public int controlVMNetwork(VMNetworkVO vmNetworkVO) {
		
		int result = 0;
		String mode = "";
		String context = "";
		try {
			
			if("Connect".equals(vmNetworkVO.getMode())) {
				mode = "연결";
			} else if("Disconnect".equals(vmNetworkVO.getMode())) {
				mode = "연결 해제";
			} else if("Remove".equals(vmNetworkVO.getMode())) {
				mode = "삭제";
			}
			
			context = "["+vmNetworkVO.getsVmName()+"] " + vmNetworkVO.getPortgroup() + " 네트워크 " + mode;
			
			// 가상머신 네트워크 제어(연결/연결해제/삭제) API 실행
			result = api.controlVMNetwork(vmNetworkVO);
			
			logService.insertLog(0, context, "가상머신", "Update"); 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 가상머신 CD-ROM 연결 신청
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : CD-ROM 있음
	 * 
	 * @param vmCDROMVO
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/apply/mountVMCDROM.do",method=RequestMethod.POST)
	public int mountVMCDROM(VMCDROMVO vmCDROMVO, HttpSession session) throws Exception {
		
		// 결과
		int result = 0;
		
		try {
			// 해당 가상머신에 CD-ROM이 있는지 조회한다
			VMCDROMVO searchVO = new VMCDROMVO();
			searchVO.setsVmID(vmCDROMVO.getsVmID());
			List<VMCDROMVO> vmCDROMList = vmService.selectVMCDROMList(searchVO);
			
			if(vmCDROMList.isEmpty()) {
				// 해당 가상머신에 CD-ROM이 없는 경우
				
				String context = "";
				String keyword = "";
				int category = 0;
				
				// 권한 - 0: 신청, 1: 관리자
				if(vmCDROMVO.getRole() == 1) {
					// 관라자
					// 관리자는 바로 vRO 서버 API를 통해 CD-ROM 추가
					
					// 가상머신 CD-ROM 제어(MOUNT) API
					vmCDROMVO.setMode("MOUNT");
					api.controlVMCDROM(vmCDROMVO);
					
					// 가상머신 CD-ROM 등록
					result = vmService.insertVMCDROM(vmCDROMVO);
					
					keyword = "Update";
					category = 0;
					context = "["+vmCDROMVO.getsVmName()+"] ["+vmCDROMVO.getDataStoreName()+"] "+vmCDROMVO.getFilePath()+" CD-ROM 연결";
					
				} else {
					// 신청
					
					// 가상머신 변경 신청 등록
					VMCreateVO vmCreateVO = new VMCreateVO();
					vmCreateVO.setCrUserID(LoginSessionUtil.getStringLoginInfo(session, "sUserID"));
					vmCreateVO.setCrSorting(2);
					vmCreateVO.setCrApproval(1);
					vmCreateVO.setCrVMName(vmCDROMVO.getsVmName());
					vmCreateVO.setVmServiceID(vmCDROMVO.getServiceId());
					vmCreateVO.setCrVMContext(vmCDROMVO.getReasonContext());
					vmCreateVO.setCrTemplet(vmCDROMVO.getReasonContext());
					
					result = vmService.insertVMCreate(vmCreateVO);
					
					// 가상머신 승인 Workflow 등록
					vmService.insertApprovalWorkflow(vmCreateVO);
					
					keyword = "Request";
					category = 2;
					context = "["+vmCDROMVO.getsVmName()+"] CD-ROM 연결 신청";
				} 
				
				// 이력 기록
				logService.insertLog(category, context, "가상머신", keyword);
				
			} else {
				// 해당 가상머신에 CD-ROM이 없는 경우
				result = 2;
			}
		} catch (Exception e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}	
		return result;
	}
	
	/**
	 * 가상머신 CD-ROM 제어(MOUNT/UNMOUND)
	 * 
	 * @param vmCDROMVO
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/apply/controlVMCDROM.do",method=RequestMethod.POST)
	public int controlVMCDROM(VMCDROMVO vmCDROMVO, HttpSession session) throws Exception {
		// 결과
		int result = 0;
				
		try {
			String msg = "";
			String context = "";
			
			// 가상머신 CD-ROM 제어(MOUNT/UNMOUND) API
			api.controlVMCDROM(vmCDROMVO);
			
			if("MOUNT".equals(vmCDROMVO.getMode())) { 
				msg = " CD-ROM 연결"; 
			} else { 
				msg = " CD-ROM 연결 해제"; 
				
				// 가상머신 CD-ROM 삭제
				vmService.deleteVMCDROM(vmCDROMVO.getsVmID());
			}
			
			context = "["+vmCDROMVO.getsVmName()+"] ["+vmCDROMVO.getDataStoreName()+"] "+vmCDROMVO.getFilePath() + msg;
			logService.insertLog(0, context, "가상머신", "Update");
		
		} catch (Exception e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}	
		return result;
	}
	
	/**
	 * 가상 머신 상태(전원 켜기/전원 끄기/리부팅) 변경
	 * 
	 * @param vmName
	 * @param stateIndex
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/apply/controlVMState.do",method=RequestMethod.POST)
	public void controlVMState(String vmName, int stateIndex) throws Exception {
				
		String context = "";
		if(stateIndex == 1) { 
			context = "["+vmName+"]"+" 전원 켜기";	
		} else if(stateIndex == 2) { 
			context = "["+vmName+"]"+" 전원 끄기";	
		} else if(stateIndex == 3) { 
			context = "["+vmName+"]"+" 전원 리부팅"; 
		}	 
		
		api.changeVMState(vmName, stateIndex);
		logService.insertLog(0, context, "가상머신", "Update");
	}
	
	/**
	 * 가상머신 반환 신청
	 * 결과
	 * 1 : 성공
	 * 2 : 이미 신청함 
	 * 
	 * @param vmCreateVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/apply/insertVMReturn.do",method=RequestMethod.POST)
	public int insertVMReturn(VMCreateVO vmCreateVO) {
		
		// 결과
		int result = 0;
		
		// 해당 가상머신이 이미 반환 신청되었는지 확인
		int returnCount = vmService.countVMReturn(vmCreateVO.getCrVMName());
		if(returnCount > 0) {
			// 이미 반환 신청된 경우
			result = 2;
			return result;
		}
		
		// 세션에서 로그인 정보 얻기
		UserVO sessionInfo = LoginSessionUtil.getLoginInfo();
		
		// 반환 신청 등록
		vmCreateVO.setCrApproval(vmService.getStage());
		vmCreateVO.setCrSorting(3);
		vmCreateVO.setCrUserID(sessionInfo.getsUserID());
		result = vmService.insertVMCreate(vmCreateVO);

		// 가상머신 승인 Workflow 등록
		ApprovalWorkflowVO approvalWorkflowVO = new ApprovalWorkflowVO();
		
		approvalWorkflowVO.setsUserID(vmCreateVO.getCrUserID());
		approvalWorkflowVO.setCrNum(vmCreateVO.getCrNum());
		approvalWorkflowVO.setDescription(vmCreateVO.getCrVMContext());
		approvalWorkflowVO.setStage(vmService.getStage());
		approvalWorkflowVO.setStatus(3);
		
		vmService.insertApprovalWorkflow(approvalWorkflowVO);

		// 로그 기록
		String context = "[" + vmCreateVO.getCrVMName() + "] " + "반환 신청";
		logService.insertLog(2, context, "가상머신", "Request");
		
		return result;
	}
	
	/**
	 * 가상머신 삭제
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 전원 켜짐
	 * 3 : 서비스 매핑
	 * 
	 * @param vmName
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/apply/deleteVM.do",method=RequestMethod.POST)
	public int destoryVM(String vmName) throws Exception {
		
		// 결과
		int result = 1;
		
		// 가상머신 정보 조회
		VMDataVO dbVMData = vmService.selectVMDataByVMName(vmName);
		
		// 가상머신 전원 확인
		if(!"poweredOff".equals(dbVMData.getVmStatus())) {
			// 전원이 꺼진 가상마신만 삭제할 수 있음
			result = 2;
			return result;
		}
		
		// 서비스 확인
		if(dbVMData.getVmServiceID() != null && dbVMData.getVmServiceID() != 0) {
			// 서비스에 매핑된 가상머신은 삭제할 수 없음
			result = 3;
			return result;
		}

		// vRO(vRealize Orchestrator) 서버의 가상 머신 삭제 변경 API 실행 
		api.changeVMState(vmName, 4);
		
		String context = "[" + vmName + "]" + " 삭제";
		logService.insertLog(0, context, "가상머신", "Delete");
			
		return result;
	}
	@RequestMapping("/apply/selectPNIC.do")
	public @ResponseBody List<VMDataVO> selectPNIC(VMDataVO vmDataVO) {
		List<VMDataVO> result = null;
		String cluster = null;
		String host = null;
		if(vmDataVO.getClusterId() != null && vmDataVO.getHostId() != null) {
			cluster = vmDataVO.getClusterId();
			host = vmDataVO.getHostId();
			result = vmService.selectPNIC(cluster,host);
		}
		return result;
	}
}
