package com.kdis.PROM.tenant.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.common.CommonUtil;
import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.tenant.service.TenantService;
import com.kdis.PROM.tenant.service.VMServiceService;
import com.kdis.PROM.tenant.vo.TenantVO;
import com.kdis.PROM.tenant.vo.VMServiceVO;
import com.kdis.PROM.user.service.UserService;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 인프라 관리 > 그룹 관리 > 서비스 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class VMServiceController {
	
	private static final Log LOG = LogFactory.getLog(VMServiceController.class);

	/** 서비스 서비스 */
	@Autowired
	private VMServiceService vmServiceService;
	
	/** 테넌트 서비스 */
	@Autowired
	private TenantService tenantService;
	
	/** 사용자 서비스 */
	@Autowired
	private UserService userService;
	
	/** 이력 서비스 */
	@Autowired
	private LogService logService;
	
	// TODO 새로운 서비스 관리 화면이 적용된 이후에는 삭제해야 함
	@RequestMapping("/data/serviceManage.do")
	public String serviceManage() {
		return "/data/serviceManage";
	}
	
	/**
	 * 인프라 관리 > 그룹 관리 > 서비스 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/serviceGroup/manageService.prom")
	public String manageService() {
		return "serviceGroup/manageService";
	}
	
	/**
	 * 서비스 목록 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectVMServiceList.do")
	public List<VMServiceVO> selectVMServiceList() {
		List<VMServiceVO> result = vmServiceService.selectVMServiceList(new VMServiceVO());
		return result;
	}
	
	/**
	 * 테넌트 고유번호로 서비스 목록 조회
	 * 
	 * @param tenantId
	 * @param isUserTenantMapping 사용자에 매핑된 테넌트만을 대상으로 할지 여부
	 * @return
	 */
	@RequestMapping("/tenant/selectVMServiceListByTenantId.do")
	public @ResponseBody List<VMServiceVO> selectVMServiceListByTenantId(Integer tenantId, String isUserTenantMapping) {
		List<VMServiceVO> result = null;
		
		if("true".equals(isUserTenantMapping)) {
			// 로그인한 사용자에게 매핑된 테넌트만을 대상으로 한다.
			
			// 세션에서 로그인 정보 얻기
			UserVO sessionInfo = LoginSessionUtil.getLoginInfo();
			VMServiceVO vmServiceVO = new VMServiceVO();
			vmServiceVO.setUserId(sessionInfo.getId());
			vmServiceVO.setTenantId(tenantId);
			
			// 로그인한 사용자가 속한 서비스 목록 조회
			result = vmServiceService.selectVMServiceListByUserMapping(vmServiceVO);
			
		} else {
			// 전체 테넌트 대상
			result = vmServiceService.selectVMServiceListByTenantId(tenantId);
		}
		return result;
	}

	/**
	 * 서비스  조회
	 * 
	 * @param vmServiceID 서비스ID
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectVMService.do")
	public VMServiceVO selectVMService(int vmServiceID) {
		VMServiceVO result = vmServiceService.selectVMService(vmServiceID);
		return result;
	}
	
	/**
	 * DHCP State 조회
	 * 해당 서비스의 클러스터, 호스트, 데이터스토어, 네트워크 기본값을 조회한다.
	 * 이 값들 중에 호스트 값이 없는 경우는 해당 서비스의 테넌트의 정보를 조회한다.
	 * 왜 4개의 값중에  호스트 값만 확인해서 테넌트 정보를 사용할지 말지 정하는지 모르겠다.
	 * 
	 * @param serviceId
	 * @return
	 */
	@RequestMapping("/tenant/selectDHCPState.do")
	public @ResponseBody Map<String,Object> getOneService(Integer serviceId) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		// 서버스 고유번호가 없는 경우는 빈값을 리턴한다.
		if(serviceId == null) {
			return map;
		}
		
		TenantVO tenantVO = new TenantVO();
		
		// 서비스 정보 조회
		VMServiceVO serviceVO = vmServiceService.selectVMService(serviceId);
		
		
		if (!CommonUtil.isEmpty(serviceVO)) {
			// 서비스 정보가 있는 경우
			
			if (serviceVO.getDefaultHost() == null || serviceVO.getDefaultHost().equals("0")) {
				// 서비스의 기본 HOST 값이 없는 경우  해당 서비스의 테넌트 정보를 조회해 return 한다
				// 화면에서 사용하는 클러스터, 호스트, 데이터스토어, 네트워크 기본값 중에  호스트 값만 확인해서 테넌트 정보를 사용할지 말지 정하는지 몰라 예전 로직을 그래도 유지했음.
				tenantVO = tenantService.selectTenant(serviceVO.getTenantId());
				
				map.put("getOneInfo", tenantVO);
				map.put("resultNum", 1);
				return map;
			}
		} else {
			// 서비스 정보가 없는 경우
			LOG.warn("getOneService serviceInformation is null");
		}
		
		map.put("getOneInfo", serviceVO);
		map.put("resultNum", 2);
		return map;
	}
	
	/**
	 * 서비스 등록
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 서비스명 중복
	 * 
	 * @param serviceVO
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/tenant/insertVMService.do", method=RequestMethod.POST)
	public int insertVMService(VMServiceVO serviceVO, HttpSession session) {
		
		// 결과
		int result = 0;

		// 서비스명 중복 체크
		// 사용자가 입력한 서비스명으로 서비스 목록을 조회한다.
		VMServiceVO searchVO = new VMServiceVO();
		searchVO.setVmServiceName(serviceVO.getVmServiceName());
		List<VMServiceVO> serviceList = vmServiceService.selectVMServiceList(searchVO);
		
		if(serviceList != null && serviceList.size() > 0) {
			// 서비스명 중복
			result = 2;
			return result;
		}
		
		// 서비스 관리자 중복 체크는 하지 않는다.
		// 한 사용자가 복수의 서비스의 관리자가 될 수 있다.
		
		// 서비스 등록
		result = vmServiceService.insertVMService(serviceVO);
		
		LOG.debug("VmServiceID : " + serviceVO.getVmServiceID());
		
		// 서비스 관리자를 설정한 경우에는 관리자의 테넌트, 서비스 정보를 이 테넌트, 서비스로 설정한다.
		if (serviceVO.getVmServiceUserID() != null && serviceVO.getVmServiceUserID() != 0) {
			// 한 사용자가 복수의 서비스의 관리자가 될 수 있기 때문에
			// 사용자 정보의 테넌트, 서비스 정보는 마지막에 관리자로 지정된 테넌트 혹은 서비스의 값이 저장된다.
			userService.updateUserService(serviceVO.getVmServiceUserID(), serviceVO.getTenantId(), serviceVO.getVmServiceID());
		}
		
		// 이력 기록

		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String dhcpReplace = "";
		if (serviceVO.getDhcpOnoff() == 1) {
			dhcpReplace = "ON";
		} else if (serviceVO.getDhcpOnoff() == 2) {
			dhcpReplace = "OFF";
		}
		
		String sContext = "";
		sContext = "[" + serviceVO.getVmServiceName() + "] ";
		sContext += "테넌트 이름 : " + serviceVO.getTenantName();
		sContext += ", 서비스 이름 : " + serviceVO.getVmServiceName();
		sContext += ", 서비스 관리자 : " + CommonUtil.nullToBlank(serviceVO.getVmServiceUserName());
		sContext += ", 클러스터 : " + CommonUtil.nullToBlank(serviceVO.getDefaultCluster());
		sContext += ", 호스트 : " + CommonUtil.nullToBlank(serviceVO.getDefaultHost());
		sContext += ", 데이터스토어 : " + CommonUtil.nullToBlank(serviceVO.getDefaultStorageName());
		sContext += ", 네트워크 : " + CommonUtil.nullToBlank(serviceVO.getDefaultNetworkName());
		sContext += ", DHCP : " + dhcpReplace;
		sContext += ", 게이트웨이 : " + CommonUtil.nullToBlank(serviceVO.getDefaultGateway());
		sContext += ", 서브넷 마스크 : " + CommonUtil.nullToBlank(serviceVO.getDefaultNetmask());
		sContext += ", 설명 : " + serviceVO.getDescription();
		
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "서비스", "Create");

		return result;
	}
	
	/**
	 * 서비스 수정
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 서비스명 중복
	 * 
	 * @param serviceVO
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/tenant/updateVMService.do", method=RequestMethod.POST)
	public int updateVMService(VMServiceVO serviceVO, HttpSession session) {
		
		// 결과
		int result = 0;
		
		// DB에 저장된 서비스 정보 조회
		VMServiceVO dbService = vmServiceService.selectVMService(serviceVO.getVmServiceID());
		
		// 서비스명이 변경된 경우 서비스명 중복 체크
		if(!dbService.getVmServiceName().equals(serviceVO.getVmServiceName())) {
			// 사용자가 입력한 서비스명으로 서비스 목록을 조회한다.
			VMServiceVO searchVO = new VMServiceVO();
			searchVO.setVmServiceName(serviceVO.getVmServiceName());
			List<VMServiceVO> serviceList = vmServiceService.selectVMServiceList(searchVO);
			
			if(serviceList != null && serviceList.size() > 0) {
				// 서비스명 중복
				result = 2;
				return result;
			}
		}	
		
		// 이력 내용
		String context = this.getUpdateLogContext(serviceVO, dbService);
			
		// 변경된 것이 있는 경우
		if(context.length() > 0) {	
			// 서비스 수정
			result = vmServiceService.updateVMService(serviceVO);
			
			// 서비스 관리자가 변경된 경우에는 관리자의 테넌트, 서비스 정보를 이 테넌트, 서비스로 설정한다.
			if (serviceVO.getVmServiceUserID() != null && serviceVO.getVmServiceUserID() != 0 &&
					!serviceVO.getVmServiceUserID().equals(dbService.getVmServiceUserID())) {
				// 한 사용자가 복수의 서비스의 관리자가 될 수 있기 때문에
				// 사용자 정보의 테넌트, 서비스 정보는 마지막에 관리자로 지정된 테넌트 혹은 서비스의 값이 저장된다.
				userService.updateUserService(serviceVO.getVmServiceUserID(), serviceVO.getTenantId(), serviceVO.getVmServiceID());
			}
	
			// 로그인 정보 얻기
			UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
	
			// 이력 기록
			String sContext = "[" + dbService.getVmServiceName() + "]" + context;
			logService.insertLog(loginInfo.getsUserID(), 0, sContext, "서비스", "Update");
			
		} else {
			// 변경된 것이 없어도 변경 성공으로 한다.
			result = 1;
		}
		return result;
	}
	
	/**
	 * 서비스 삭제
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 가상머신 있음
	 * 3 : 사용자 있음
	 * 
	 * @param serviceVO
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/deleteVMService.do")
	public int deleteVMService(VMServiceVO serviceVO, HttpSession session) {
		
		// 결과
		int result = 0;
		
		// 해당 서비스에 속한 가상머신 수 확인
		int vmCount = vmServiceService.countVMByVMServiceID(serviceVO.getVmServiceID());
		if(vmCount > 0) {
			// 가상머신 있음
			result = 2;
			return result;
		}
		
		result = vmServiceService.deleteVMService(serviceVO.getVmServiceID());
		
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);

		// 이력 기록
		String sContext = "[" + serviceVO.getVmServiceName() + "]";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "서비스", "Delete");
		
		return result;
	}
	
	/**
	 * 서비스 수정 상세 이력 얻기
	 * 
	 * @param inputVO 입력한 서비스 정보
	 * @param dbVO DB에 저장된 서비스 정보
	 * @return
	 */
	private String getUpdateLogContext(VMServiceVO inputVO, VMServiceVO dbVO) {
		
		// 이력 내용
		StringBuffer contextBuffer = new StringBuffer();
		
		// 테넌트가 변경된 경우
		if (!inputVO.getTenantId().equals(dbVO.getTenantId())) {
			contextBuffer.append(", 테넌트 : ");
			contextBuffer.append(CommonUtil.nullToBlank(dbVO.getTenantName()));
			contextBuffer.append(" -> ");
			contextBuffer.append(CommonUtil.nullToBlank(inputVO.getTenantName()));
		}

		// 서비스 이름이 변경된 경우
		if (!inputVO.getVmServiceName().equals(dbVO.getVmServiceName())) {
			contextBuffer.append(", 서비스 이름  : ");
			contextBuffer.append(CommonUtil.nullToBlank(dbVO.getVmServiceName()));
			contextBuffer.append(" -> ");
			contextBuffer.append(CommonUtil.nullToBlank(inputVO.getVmServiceName()));
		}

		// 서비스 관리자가 변경된 경우
		if (!inputVO.getVmServiceUserName().equals(dbVO.getServiceUserName())) {
			contextBuffer.append(", 서비스 관리자  : ");
			contextBuffer.append(CommonUtil.nullToBlank(dbVO.getVmServiceUserName()));
			contextBuffer.append(" -> ");
			contextBuffer.append(CommonUtil.nullToBlank(inputVO.getVmServiceUserName()));
		}

		// 클러스터가 변경된 경우
		if (!inputVO.getDefaultCluster().equals(dbVO.getDefaultCluster())) {
			contextBuffer.append(", 클러스터  : ");
			contextBuffer.append(CommonUtil.nullToBlank(dbVO.getDefaultCluster()));
			contextBuffer.append(" -> ");
			contextBuffer.append(CommonUtil.nullToBlank(inputVO.getDefaultCluster()));
		}

		// 호스트가 변경된 경우
		if (!inputVO.getDefaultHost().equals(dbVO.getDefaultHost())) {
			contextBuffer.append(", 호스트  : ");
			contextBuffer.append(CommonUtil.nullToBlank(dbVO.getDefaultHost()));
			contextBuffer.append(" -> ");
			contextBuffer.append(CommonUtil.nullToBlank(inputVO.getDefaultHost()));
		}

		// 데이터스토어가 변경된 경우
		if (!inputVO.getDefaultStorage().equals(dbVO.getDefaultStorage())) {
			contextBuffer.append(", 호스트  : ");
			contextBuffer.append(CommonUtil.nullToBlank(dbVO.getDefaultStorage()));
			contextBuffer.append(" -> ");
			contextBuffer.append(CommonUtil.nullToBlank(inputVO.getDefaultStorage()));
		}

		// 네트워크가 변경된 경우
		if (!inputVO.getDefaultNetwork().equals(dbVO.getDefaultNetwork())) {
			contextBuffer.append(", 네트워크 : ");
			contextBuffer.append(CommonUtil.nullToBlank(dbVO.getDefaultNetwork()));
			contextBuffer.append(" -> ");
			contextBuffer.append(CommonUtil.nullToBlank(inputVO.getDefaultNetwork()));
		}

		// 게이트웨이가 변경된 경우
		if (!inputVO.getDefaultGateway().equals(dbVO.getDefaultGateway())) {
			contextBuffer.append(", 게이트웨이 : ");
			contextBuffer.append(CommonUtil.nullToBlank(dbVO.getDefaultGateway()));
			contextBuffer.append(" -> ");
			contextBuffer.append(CommonUtil.nullToBlank(inputVO.getDefaultGateway()));
		}

		// 서브넷 마스크가 변경된 경우
		if (!inputVO.getDefaultNetmask().equals(dbVO.getDefaultNetmask())) {
			contextBuffer.append(", 서브넷 마스크 : ");
			contextBuffer.append(CommonUtil.nullToBlank(dbVO.getDefaultNetmask()));
			contextBuffer.append(" -> ");
			contextBuffer.append(CommonUtil.nullToBlank(inputVO.getDefaultNetmask()));
		}

		// DHCP가 변경된 경우
		if (inputVO.getDhcpOnoff() != dbVO.getDhcpOnoff()) {
			if (dbVO.getDhcpOnoff() == 1) {
				contextBuffer.append(", DHCP: ON -> OFF");
			} else {
				contextBuffer.append(", DHCP: OFF -> ON");
			}
		}

		// 설명이 변경된 경우
		if (!inputVO.getDescription().equals(dbVO.getDescription())) {
			contextBuffer.append(", 설명 : ");
			contextBuffer.append(CommonUtil.nullToBlank(dbVO.getDescription()));
			contextBuffer.append(" -> ");
			contextBuffer.append(CommonUtil.nullToBlank(inputVO.getDescription()));
		}
		
		// , 을 삭제하고 리턴한다
		if(contextBuffer.length() > 0) {
			return contextBuffer.toString().substring(1);
		} else {
			return "";
		}
	}
}
