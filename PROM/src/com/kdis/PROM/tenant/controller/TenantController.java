package com.kdis.PROM.tenant.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.tenant.service.TenantService;
import com.kdis.PROM.tenant.service.VMServiceService;
import com.kdis.PROM.tenant.vo.ClusterVO;
import com.kdis.PROM.tenant.vo.HostDataStoreVO;
import com.kdis.PROM.tenant.vo.HostNetworkVO;
import com.kdis.PROM.tenant.vo.TenantVO;
import com.kdis.PROM.tenant.vo.VMHostVO;
import com.kdis.PROM.user.service.UserService;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 인프라 관리 > 그룹 관리 > 서비스 그룹 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class TenantController {
	
	private static final Log LOG = LogFactory.getLog(TenantController.class);
	
	/** 테넌트 서비스 */
	@Autowired
	private TenantService tenantService;
	
	/** 서비스 서비스 */
	@Autowired
	private VMServiceService vmServiceService;
	
	/** 사용자 서비스 */
	@Autowired
	private UserService userService;
	
	/** 이력 서비스 */
	@Autowired
	private LogService logService;
	
	/**
	 * 인프라 관리 > 그룹 관리 > 서비스 그룹 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/serviceGroup/manageServiceGroup.prom")
	public String manageServiceGroup() {
		return "serviceGroup/manageServiceGroup";
	}
	
	/**
	 * 테넌트 목록 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectTenantList.do")
	public List<TenantVO> selectTenantList() {
		List<TenantVO> result = null;
		result = tenantService.selectTenantList(new TenantVO());
		return result;
	}
	
	/**
	 * 해당 회사의 테넌트 목록 조회 
	 * 
	 * @param companyId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectTenantListByCompanyId.do")
	public List<TenantVO> selectTenantListByCompanyId(Integer companyId) {
		List<TenantVO> result = null;
		TenantVO tenantVO = new TenantVO();
		tenantVO.setCompanyId(companyId);
		result = tenantService.selectTenantList(tenantVO);
		return result;
	}
	
	/**
	 * 사용자 테넌트 배치를 위한 테넌트 목록 조회
	 * 
	 * @param userId 사용자 고유번호
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectTenantArrangeList.do")
	public List<TenantVO> selectTenantArrangeList(Integer userId) {
		List<TenantVO> result = tenantService.selectTenantArrangeList(userId);
		return result;
	}
	
	/**
	 * 테넌트  조회
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectTenant.do")
	public TenantVO selectTenant(Integer id) {
		TenantVO result = tenantService.selectTenant(id);
		return result;
	}
	
	/**
	 * 로그인 사용자의 테넌트 정보 조회 TODO 삭제
	 * 
	 * @param id
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectTenantByLoginUserTenantId.do")
	public TenantVO selectTenantByLoginUserTenantId(HttpSession session) {
		//로그인 사용자의 테넌트 정보를 조회한다 
		Integer id = tenantService.getLoginUserTenantId(session);
		if(id != null && id != 0) {
			TenantVO result = tenantService.selectTenant(id);
			return result;
		} else {
			return new TenantVO();
		}
	}
	
	/**
	 * 로그인한 사용자가 속한 테넌트 목록 조회
	 * 
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectLoginUserTenantList.do")
	public List<TenantVO> selectLoginUserTenantList(HttpSession session) {
		List<TenantVO> result = null;
		
		// 세션에서 로그인 정보 얻기
		UserVO sessionInfo = LoginSessionUtil.getLoginInfo(session);
		
		// 로그인한 사용자가 속한 테넌트 목록 조회
		result = tenantService.selectTenantListByUserMapping(sessionInfo.getId());
		return result;
	}
	
	/**
	 * 클러스터 목록 조회
	 * TODO 리팩토링 완료 이후에 해당 메소드 패키지 위치 고민해 보기
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectClusterList.do")
	public List<ClusterVO> selectClusterList() {
		List<ClusterVO> result = tenantService.selectClusterList();
		return result;
	}
	
	/**
	 * VM 호스트 목록 조회
	 * TODO 리팩토링 완료 이후에 해당 메소드 패키지 위치 고민해 보기
	 * 
	 * @param hostParent
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectVMHostList.do")
	public List<VMHostVO> selectVMHostList(VMHostVO vmHostVO) {
		List<VMHostVO> result = tenantService.selectVMHostList(vmHostVO);
		return result;
	}
	
	/**
	 * 호스트 데이터 스토어 목록 조회
	 * TODO 리팩토링 완료 이후에 해당 메소드 패키지 위치 고민해 보기
	 * 
	 * @param hostID
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectHostDataStoreListByHostID.do")
	public List<HostDataStoreVO> selectHostDataStoreListByHostID(String hostID) {
		List<HostDataStoreVO> result = tenantService.selectHostDataStoreListByHostID(hostID);
		return result;
	}
	
	/**
	 * 호스트 네트워크 목록 조회
	 * TODO 리팩토링 완료 이후에 해당 메소드 패키지 위치 고민해 보기
	 * 
	 * @param hostID
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/tenant/selectHostNetworkListByHostID.do")
	public List<HostNetworkVO> selectHostNetworkListByHostID(String hostID) {
		List<HostNetworkVO> result = tenantService.selectHostNetworkListByHostID(hostID);
		return result;
	}
	
	/**
	 * 테넌트 등록
	 * 
	 * 결과
	 * 0 : 실패
	 * 1 : 성공
	 * 2 : 테넌트명 중복
	 * 3 : 테넌트 관리자 중복
	 * 
	 * @param tenantVO
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/tenant/insertTenant.do", method=RequestMethod.POST)
	public int insertTenant(TenantVO tenantVO, HttpSession session) {
		
		// 결과
		int result = 0;
		
		// 테넌트명 중복 체크
		// 사용자가 입력한 테넌트명으로 테넌트 목록을 조회한다.
		TenantVO nameVO = new TenantVO();
		nameVO.setName(tenantVO.getName());
		List<TenantVO> tenantListByName = tenantService.selectTenantList(nameVO);
		
		if(tenantListByName != null && tenantListByName.size() > 0) {
			// 테넌트명 중복
			result = 2;
			return result;
		}
		
		// 지정한 테넌트 관리자가 이미 다른 테넌트 관리지인지 확인
		if(tenantVO.getAdminId() != null && tenantVO.getAdminId() != 0) {
			// 사용자가 관리자로 있는 테넌트 수 조회
			int tenantCount = tenantService.countTenantByAdminId(tenantVO.getAdminId());
			if(tenantCount > 0) {
				// 테넌트 관리자 중복
				result = 3;
				return result;
			}
		}
		
		// 테넌트 등록
		result = tenantService.insertTenant(tenantVO);

		LOG.debug("Tenant ID : " + tenantVO.getId());
		
		// 테넌트 관리자를 설정한 경우에는 관리자의 테넌트 정보를 이 테넌트로 설정한다.
		if (tenantVO.getAdminId() != null && tenantVO.getAdminId() != 0) {
			userService.updateUserTenant(tenantVO.getAdminId(), tenantVO.getId());
		}
		
		// 이력 기록
		String dhcpReplace = "";
		if (tenantVO.getDhcpOnoff() == 1) {
			dhcpReplace = "ON";
		} else if (tenantVO.getDhcpOnoff() == 2) {
			dhcpReplace = "OFF";
		}

		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "[" + tenantVO.getName() + "] ";
		if (tenantVO.getAdminId() != null && tenantVO.getAdminId() != 0) {
			sContext += "테넌트 관리자 : , ";
		} else {
			sContext += "테넌트 관리자 : " + tenantVO.getAdminName() + ", ";
		}
		sContext += "클러스터 : " + tenantVO.getDefaultCluster() + ", ";
		sContext += "호스트 : " + tenantVO.getDefaultHost() + ", ";
		sContext += "데이터스토어 : " + tenantVO.getDefaultStorageName() + ", ";
		sContext += "네트워크 : " + tenantVO.getDefaultNetworkName() + ", ";
		sContext += "DHCP : " + dhcpReplace + ", ";
		sContext += "게이트웨이 : " + tenantVO.getDefaultGateway() + ", ";
		sContext += "서브넷마스크 : " + tenantVO.getDefaultNetmask() + ", ";
		sContext += "설명 : " + tenantVO.getDescription();
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "테넌트", "Create");
		
		return result;
	}
	
	/**
	 * 테넌트 수정
	 * 
	 * 결과
	 * 0 : 실패
	 * 1 : 성공
	 * 2 : 테넌트명 중복
	 * 3 : 테넌트 관리자 중복
	 * 
	 * @param tenantVO
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/tenant/updateTenant.do", method=RequestMethod.POST)
	public int updateTenant(TenantVO tenantVO, HttpSession session) {
		
		// 결과
		int result = 0;
		
		// DB에 저장된 테넌트 정보 조회
		TenantVO dbTenant = tenantService.selectTenant(tenantVO.getId());
		
		// 테넌트명 중복 체크
		// 테넌트명이 변경한 경우 사용자가 입력한 테넌트명으로 테넌트 목록을 조회한다.
		if(!dbTenant.getName().equals(tenantVO.getName())) {
			TenantVO nameVO = new TenantVO();
			nameVO.setName(tenantVO.getName());
			List<TenantVO> tenantListByName = tenantService.selectTenantList(nameVO);
			
			if(tenantListByName != null && tenantListByName.size() > 0) {
				// 테넌트명 중복
				result = 2;
				return result;
			}
		}
		
		// 관리자 중복 체크
		if(tenantVO.getAdminId() != null && !tenantVO.getAdminId().equals(dbTenant.getAdminId())) {
			// 관리자를 변경한 경우 
			if(tenantVO.getAdminId() != null && tenantVO.getAdminId() != 0) {
				// 관리자를 미지정이 아닌 사용자로 지정한 경우
				// 테넌트 관리자가 이미 다른 테넌트 관리지인지 확인
				
				// 사용자가 관리자로 있는 테넌트 수 조회
				int tenantCount = tenantService.countTenantByAdminId(tenantVO.getAdminId());
				if(tenantCount > 0) {
					// 테넌트 관리자 중복
					result = 3;
					return result;
				}
				
			}
		}
		
		// 이력 내용
		String context = this.getUpdateLogContext(tenantVO, dbTenant);
		
		// 변경된 것이 있는 경우
		if(context.length() > 0) {	
			// 테넌트 수정
			result = tenantService.updateTenant(tenantVO);
			
			// 관리자가 변경된 경우 사용자 정보에 테넌트를 변경한다.
			if(tenantVO.getAdminId() != null && !tenantVO.getAdminId().equals(dbTenant.getAdminId())) {
				
				if(tenantVO.getAdminId() != null && tenantVO.getAdminId() != 0) {
					// 관리자를 미지정이 아닌 사용자로 지정한 경우
					userService.updateUserTenant(tenantVO.getAdminId(), tenantVO.getId());
				} else {
					// 미지정으로 변경한 경우
					// 관리자가 된 사용자의 테넌트 정보를 변경한다.
					userService.updateUserTenant(tenantVO.getAdminId(), null);
				}
				
				// 해당 테넌트의 예전 관리자였던 사용자의 테넌트 정보도 변경해 준다.
				if(dbTenant.getAdminId() != null && dbTenant.getAdminId() != 0) {
					// 예젼 관리자가 미지정이 아니였던 경우
					// 미지정으로 변경한다.
					userService.updateUserTenant(dbTenant.getAdminId(), null);
				}
				
			}
			
			// 로그인 정보 얻기
			UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);

			// 이력 기록
			String sContext = "[" + dbTenant.getName() + "]" + context;
			logService.insertLog(loginInfo.getsUserID(), 0, sContext, "테넌트", "Update");
			
		} else {
			// 변경된 것이 없어도 변경 성공으로 한다.
			result = 1;
		}

		return result;
	}
	
	/**
	 * 테넌트 삭제
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 서비스 있음
	 * 3 : 사용자 있음
	 * 
	 * @param tenantVO
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/tenant/deleteTenant.do", method=RequestMethod.POST)
	public int deleteTenant(Integer id, HttpSession session) {
		
		// 결과
		int result = 0;
		
		// 해당 테넌트에 속한 서비스가 있는지 확인
		// 해당 테넌트에 속한 서비스 수 조회
		int serviceCount = vmServiceService.countServiceByTenantId(id);
		if(serviceCount > 0) {
			// 테넌트에 서비스가 있는 경우
			result = 2;
			return result;
		}
		
		// 해당 테넌트에 속한 사용자가 있는지 확인
		int userCount = userService.countUserByNTenantId(id);
		if(userCount > 0) {
			// 해당 테넌트에 속한 사용자 있는 경우
			result = 3;
			return result;
		}
		
		// DB에 저장된 테넌트 정보 조회
		TenantVO dbTenant = tenantService.selectTenant(id);
		
		// 테넌트 삭제
		result = tenantService.deleteTenant(id);
		
		// 지정된 관리자가 있는 경우에는 관리자의 사용자 정보의 테넌트를 삭제한다
		if(dbTenant.getAdminId() != null && dbTenant.getAdminId() != 0) {
			// 미지정으로 변경한다.
			userService.updateUserTenant(dbTenant.getAdminId(), null);
		}
		
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);

		// 이력 기록
		String sContext = "[" + dbTenant.getName() + "]";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "테넌트", "Delete");
		
		return result;
	}
	
	/**
	 * 테넌트 수정 상세 이력 얻기
	 * 
	 * @param inputVO 입력한 테넌트 정보
	 * @param dbVO DB에 저장된 테넌트 정보
	 * @return
	 */
	private String getUpdateLogContext(TenantVO inputVO, TenantVO dbVO) {
		
		// 이력 내용
		StringBuffer contextBuffer = new StringBuffer();
		
		// 이름이 변경된 경우
		if (!inputVO.getName().equals(dbVO.getName())) {
			contextBuffer.append(", 이름 : ").append(dbVO.getName() + " -> " + inputVO.getName());
		}

		// 테넌트 관리자가 변경된 경우
		if((inputVO.getAdminId() == null && dbVO.getAdminId() != null) ||
				(inputVO.getAdminId() != null && !inputVO.getAdminId().equals(dbVO.getAdminId()))) {
			if(inputVO.getAdminId() == null || inputVO.getAdminId() == 0) {
				contextBuffer.append(", 테넌트 관리자 : ").append(dbVO.getAdminName() + " -> ");
			} else {
				contextBuffer.append(", 테넌트 관리자 : ").append(dbVO.getAdminName() + " -> " + inputVO.getAdminName());
			}
		}

		// 클러스터가 변경된 경우
		if (!inputVO.getDefaultCluster().equals(dbVO.getDefaultCluster())) {
			contextBuffer.append(", 클러스터 : ").append(dbVO.getDefaultCluster() + " -> " + inputVO.getDefaultCluster());
		}

		// 호스트가 변경된 경우
		if (!inputVO.getDefaultHost().equals(dbVO.getDefaultHost())) {
			contextBuffer.append(", 호스트 : ").append(dbVO.getDefaultHost() + " -> " + inputVO.getDefaultHost());
		}

		// 데이터스토어가 변경된 경우
		if (!inputVO.getDefaultStorageName().equals(dbVO.getDefaultStorageName())) {
			contextBuffer.append(", 데이터스토어 : ").append(dbVO.getDefaultStorageName() + " -> " + inputVO.getDefaultStorageName());
		}

		// 네트워크가 변경된 경우
		if (!inputVO.getDefaultNetwork().equals(dbVO.getDefaultNetwork())) {
			contextBuffer.append(", 네트워크 : ").append(dbVO.getDefaultNetworkName() + " -> " + inputVO.getDefaultNetworkName());
		}

		// 게이트웨이가 변경된 경우
		if (!inputVO.getDefaultGateway().equals(dbVO.getDefaultGateway())) {
			contextBuffer.append(", 게이트웨이 : ").append(dbVO.getDefaultGateway() + " -> " + inputVO.getDefaultGateway());
		}

		// 서브넷 마스크가 변경된 경우
		if (!inputVO.getDefaultNetmask().equals(dbVO.getDefaultNetmask())) {
			contextBuffer.append(", 서브넷 마스크 : ").append(dbVO.getDefaultNetmask() + " -> " + inputVO.getDefaultNetmask());
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
			contextBuffer.append(", 설명 : ").append(dbVO.getDescription() + " -> " + inputVO.getDescription());
		}
		
		// , 을 삭제하고 리턴한다
		if(contextBuffer.length() > 0) {
			return contextBuffer.toString().substring(1);
		} else {
			return "";
		}
	}

}
