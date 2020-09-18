package com.kdis.PROM.tenant.dao;

import java.util.List;

import com.kdis.PROM.tenant.vo.ClusterVO;
import com.kdis.PROM.tenant.vo.HostDataStoreVO;
import com.kdis.PROM.tenant.vo.HostNetworkVO;
import com.kdis.PROM.tenant.vo.TenantVO;
import com.kdis.PROM.tenant.vo.VMHostVO;

/**
 * 테넌트 DAO interface
 * 
 * @author KimHahn
 *
 */
public interface TenantDAO {

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
	 * @param tenantVO 검색 조건
	 * @return
	 */
	public TenantVO selectTenant(TenantVO tenantVO);

	/**
	 * 관리자 고유번호로 테넌트 조회
	 * 복수일 경우 가장 최근에 생성된 테넌트를 조회한다
	 * 
	 * @param adminId
	 * @return
	 */
	public TenantVO selectTenantByAdminId(Integer adminId);
	
	/**
	 * 부서 목록으로 테넌트 조회
	 * 복수일 경우 부서 목록에서 순서가 가장 빠른 부서의 테넌트를 조회한다
	 * 
	 * @param tenantVO
	 * @return
	 */
	public TenantVO selectTenantByDeptList(TenantVO tenantVO);
	
	/**
	 * 사용자가 관리자로 있는 테넌트 수 조회
	 * 
	 * @param tenantVO 검색 조건
	 * @return
	 */
	public int countTenantByAdminId(TenantVO tenantVO);
	
	/**
	 * 해당 부서에 속한 테넌트 수 조회
	 * 
	 * @param tenantVO 검색 조건
	 * @return
	 */
	public int countTenantsByDeptId(TenantVO tenantVO);
	
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
	 * 호스트 데이터 스토어 목록 조회
	 * 
	 * @param hostDataStoreVO
	 * @return
	 */
	public List<HostDataStoreVO> selectHostDataStoreListByHostID(HostDataStoreVO hostDataStoreVO);
	

	/**
	 * 호스트 네트워크 목록 조회
	 * 
	 * @param hostNetworkVO
	 * @return
	 */
	public List<HostNetworkVO> selectHostNetworkListByHostID(HostNetworkVO hostNetworkVO);
	
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
