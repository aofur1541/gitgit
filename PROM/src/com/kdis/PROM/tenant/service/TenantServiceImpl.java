package com.kdis.PROM.tenant.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.tenant.dao.TenantDAO;
import com.kdis.PROM.tenant.vo.ClusterVO;
import com.kdis.PROM.tenant.vo.HostDataStoreVO;
import com.kdis.PROM.tenant.vo.HostNetworkVO;
import com.kdis.PROM.tenant.vo.TenantVO;
import com.kdis.PROM.tenant.vo.VMHostVO;
import com.kdis.PROM.tenant.vo.VMServiceVO;
import com.kdis.PROM.user.service.DepartmentService;
import com.kdis.PROM.user.vo.DepartmentVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 테넌트 Service 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class TenantServiceImpl implements TenantService {

	private static final Log LOG = LogFactory.getLog(TenantServiceImpl.class);
	
	/** 테넌트 DAO */
	@Autowired
	TenantDAO tenantDAO;

	/** 서비스 서비스 */
	@Autowired
	private VMServiceService vmServiceService;
	
	/** 부서 서비스 */
	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 테넌트 목록 조회
	 * 
	 * @param tenantVO 검색 조건
	 * @return
	 */
	@Override
	public List<TenantVO> selectTenantList(TenantVO tenantVO) {
		return tenantDAO.selectTenantList(tenantVO);
	}
	
	/**
	 * 사용자가 속한 테넌트 목록 조회
	 * 
	 * @param userId 사용자 고유번호
	 * @return
	 */
	@Override
	public List<TenantVO> selectTenantListByUserMapping(int userId) {
		return tenantDAO.selectTenantListByUserMapping(userId);
	}
	
	/**
	 * 사용자 테넌트 배치를 위한 테넌트 목록 조회
	 * 
	 * @param userId 사용자 고유번호
	 * @return
	 */
	@Override
	public List<TenantVO> selectTenantArrangeList(int userId) {
		return tenantDAO.selectTenantArrangeList(userId);
	}
	
	/**
	 * 테넌트 조회
	 * 
	 * @param id
	 * @return
	 */
	@Override
	public TenantVO selectTenant(int id) {
		TenantVO tenantVO = new TenantVO();
		tenantVO.setId(id);
		return tenantDAO.selectTenant(tenantVO);
	}
	
	/**
	 * 관리자 고유번호로 테넌트 조회
	 * 복수일 경우 가장 최근에 생성된 테넌트를 조회한다
	 * 
	 * @param adminId
	 * @return
	 */
	@Override
	public TenantVO selectTenantByAdminId(int adminId) {
		return tenantDAO.selectTenantByAdminId(adminId);
	}
	
	/**
	 * 부서 목록으로 테넌트 조회
	 * 복수일 경우 부서 목록에서 순서가 가장 빠른 부서의 테넌트를 조회한다
	 * 
	 * @param companyId
	 * @param deptList
	 * @return
	 */
	@Override
	public TenantVO selectTenantByDeptList(int companyId, List<DepartmentVO> deptList) {
		TenantVO tenantVO = new TenantVO();
		tenantVO.setCompanyId(companyId);
		tenantVO.setParamDeptList(deptList);
		return tenantDAO.selectTenantByDeptList(tenantVO);
	}
	
	/**
	 * 로그인한 사용자의 테넌트ID 얻기 TODO 삭제
	 * 
	 * 사용자의 테넌트를 결정하는 우선 순위
	 * 1. 로그인한 사용자가 관리자로 지정된 테넌트
	 * 2. 로그인한 사용자가 관리자로 지정된 서비스의 테넌트
	 * 3. 로그인한 사용자의 사용자 정보에 설정된 테넌트
	 * 4. 로그인한 사용자의 부서와 그 상위 부서에 속한 테넌트
	 * 
	 * @param session
	 * @return
	 */
	@Override
	public Integer getLoginUserTenantId(HttpSession session) {

		// 사용자의 테넌트가 없는 경우에는 0을 리턴한다.
		Integer tenantId = 0;
		
		// 세션에서 로그인 정보 얻기
		UserVO sessionInfo = LoginSessionUtil.getLoginInfo(session);
		
		// 1. 로그인한 사용자가 관리자로 지정된 테넌트
		// 로그인한 사용자가 관리자로 지정된 테넌트 조회
		TenantVO adminTenant = this.selectTenantByAdminId(sessionInfo.getId());
		if(adminTenant != null && adminTenant.getId() != null) {
			tenantId = adminTenant.getId();
			LOG.debug("Admin Tenant : " + tenantId);
			return tenantId;
		}
		
		// 2. 로그인한 사용자가 관리자로 지정된 서비스의 테넌트
		// 로그인한 사용자가 관리자로 지정된 서비스 조회
		VMServiceVO adminService = vmServiceService.selectVMServiceByVMServiceUserID(sessionInfo.getId());
		if(adminService != null && adminService.getTenantId() != null) {
			tenantId = adminService.getTenantId();
			LOG.debug("Admin Service : " + tenantId);
			return tenantId;
		}

		// 3. 로그인한 사용자의 사용자 정보에 설정된 테넌트
		if(sessionInfo.getnTenantId() != null && sessionInfo.getnTenantId() != 0) {
			tenantId = sessionInfo.getnTenantId();
			LOG.debug("UserInfo Tenant : " + tenantId);
			return tenantId;
		}
		
		// 4. 로그인한 사용자의 부서와 그 상위 부서에 속한 테넌트
		// 로그인한 사용자의 부서를 기준으로 그 부서의 상위 계층 목록 조회
		List<DepartmentVO> deptList = departmentService.selectDeptUpperHierarchyList(
				sessionInfo.getsCompany(), sessionInfo.getsDepartment());
		TenantVO deptTenant = null;
		if(deptList != null && deptList.size() > 0) {
			deptTenant = this.selectTenantByDeptList(sessionInfo.getsCompany(), deptList);
			if(deptTenant != null && deptTenant.getId() > 0) {
				tenantId = deptTenant.getId();
				LOG.debug("Dept Tenant : " + tenantId);
				return tenantId;
			}
		}
		LOG.warn("No Tenant : " + tenantId);
		return tenantId;
	}
	
	/**
	 * 사용자가 관리자로 있는 테넌트 수 조회
	 * 
	 * @param adminId 사용자 고유번호
	 * @return
	 */
	@Override
	public int countTenantByAdminId(int adminId) {
		TenantVO tenantVO = new TenantVO();
		tenantVO.setAdminId(adminId);
		return tenantDAO.countTenantByAdminId(tenantVO);
	}
	
	/**
	 * 해당 부서에 속한 테넌트 수 조회
	 * 
	 * @param companyId
	 * @return
	 */
	public int countTenantsByDeptId(Integer companyId, String deptId) {
		TenantVO tenantVO = new TenantVO();
		tenantVO.setCompanyId(companyId);
		tenantVO.setDeptId(deptId);
		return tenantDAO.countTenantsByDeptId(tenantVO);
	}
	
	/**
	 * 클러스터 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<ClusterVO> selectClusterList() {
		return tenantDAO.selectClusterList();
	}
	
	/**
	 * VM 호스트 목록 조회
	 * 
	 * @param vmHostVO
	 * @return
	 */
	@Override
	public List<VMHostVO> selectVMHostList(VMHostVO vmHostVO) {
		return tenantDAO.selectVMHostList(vmHostVO);
	}
	
	/**
	 * 호스트ID로 호스트 데이터 스토어 목록 조회
	 * 
	 * @param hostID
	 * @return
	 */
	@Override
	public List<HostDataStoreVO> selectHostDataStoreListByHostID(String hostID) {
		HostDataStoreVO hostDataStoreVO = new HostDataStoreVO();
		hostDataStoreVO.setHostID(hostID);
		return tenantDAO.selectHostDataStoreListByHostID(hostDataStoreVO);
	}
	
	/**
	 * 호스트ID로 호스트 네트워크 목록 조회
	 * 
	 * @param hostID
	 * @return
	 */
	@Override
	public List<HostNetworkVO> selectHostNetworkListByHostID(String hostID) {
		HostNetworkVO hostNetworkVO = new HostNetworkVO();
		hostNetworkVO.setHostID(hostID);
		return tenantDAO.selectHostNetworkListByHostID(hostNetworkVO);
	}
	
	/**
	 * 테넌트 등록
	 * 
	 * @param tenantVO
	 * @return
	 */
	@Override
	@Transactional
	public int insertTenant(TenantVO tenantVO) {
		return tenantDAO.insertTenant(tenantVO);
	}
	
	/**
	 * 테넌트 수정
	 * 
	 * @param tenantVO
	 * @return
	 */
	@Override
	@Transactional
	public int updateTenant(TenantVO tenantVO) {
		return tenantDAO.updateTenant(tenantVO);
	}
	
	/**
	 * 테넌트 삭제
	 * 
	 * @param id 테넌트 고유번호
	 * @return
	 */
	@Override
	@Transactional
	public int deleteTenant(int id) {
		return tenantDAO.deleteTenant(id);
	}


}
