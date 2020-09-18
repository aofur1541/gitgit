package com.kdis.PROM.tenant.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.kdis.PROM.tenant.vo.ClusterVO;
import com.kdis.PROM.tenant.vo.HostDataStoreVO;
import com.kdis.PROM.tenant.vo.HostNetworkVO;
import com.kdis.PROM.tenant.vo.TenantVO;
import com.kdis.PROM.tenant.vo.VMHostVO;
import com.kdis.PROM.user.vo.DepartmentVO;

/**
 * 테넌트 Service interface
 * 
 * @author KimHahn
 *
 */
public interface TenantService {

	/**
	 * 테넌트 목록 조회
	 * 
	 * @param tenantVO 검색 조건
	 * @return
	 */
	public List<TenantVO> selectTenantList(TenantVO tenantVO);
	
	/**
	 * 사용자가 속한 테넌트 목록 조회
	 * 
	 * @param userId 사용자 고유번호
	 * @return
	 */
	public List<TenantVO> selectTenantListByUserMapping(int userId);
	
	/**
	 * 사용자 테넌트 배치를 위한 테넌트 목록 조회
	 * 
	 * @param userId 사용자 고유번호
	 * @return
	 */
	public List<TenantVO> selectTenantArrangeList(int userId);
	
	/**
	 * 테넌트 조회
	 * 
	 * @param id
	 * @return
	 */
	public TenantVO selectTenant(int id);
	
	/**
	 * 관리자 고유번호로 테넌트 조회
	 * 복수일 경우 가장 최근에 생성된 테넌트를 조회한다
	 * 
	 * @param adminId
	 * @return
	 */
	public TenantVO selectTenantByAdminId(int adminId);
	
	/**
	 * 부서 목록으로 테넌트 조회
	 * 복수일 경우 부서 목록에서 순서가 가장 빠른 부서의 테넌트를 조회한다
	 * 
	 * @param companyId
	 * @param deptList
	 * @return
	 */
	public TenantVO selectTenantByDeptList(int companyId, List<DepartmentVO> deptList);
	
	/**
	 * 로그인한 사용자의 테넌트ID 얻기
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
	public Integer getLoginUserTenantId(HttpSession session);
	
	/**
	 * 사용자가 관리자로 있는 테넌트 수 조회
	 * 
	 * @param adminId 사용자 고유번호
	 * @return
	 */
	public int countTenantByAdminId(int adminId);
	
	/**
	 * 해당 부서에 속한 테넌트 수 조회
	 * 
	 * @param companyId
	 * @return
	 */
	public int countTenantsByDeptId(Integer companyId, String deptId);
	
	/**
	 * 클러스터 목록 조회
	 * 
	 * @return
	 */
	public List<ClusterVO> selectClusterList();

	/**
	 * VM 호스트 목록 조회
	 * 
	 * @param vmHostVO
	 * @return
	 */
	public List<VMHostVO> selectVMHostList(VMHostVO vmHostVO);
	
	/**
	 * 호스트ID로 호스트 데이터 스토어 목록 조회
	 * 
	 * @param hostID
	 * @return
	 */
	public List<HostDataStoreVO> selectHostDataStoreListByHostID(String hostID);
	
	/**
	 * 호스트ID로 호스트 네트워크 목록 조회
	 * 
	 * @param hostID
	 * @return
	 */
	public List<HostNetworkVO> selectHostNetworkListByHostID(String hostID);
	
	/**
	 * 테넌트 등록
	 * 
	 * @param tenantVO
	 * @return
	 */
	public int insertTenant(TenantVO tenantVO);
	
	/**
	 * 테넌트 수정
	 * 
	 * @param tenantVO
	 * @return
	 */
	public int updateTenant(TenantVO tenantVO);
	
	/**
	 * 테넌트 삭제
	 * 
	 * @param id 테넌트 고유번호
	 * @return
	 */
	public int deleteTenant(int id);
	
}
