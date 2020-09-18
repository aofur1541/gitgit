package com.kdis.PROM.tenant.service;

import java.util.List;

import com.kdis.PROM.tenant.vo.VMServiceVO;

/**
 * 서비스 Service interface
 * 
 * @author KimHahn
 *
 */
public interface VMServiceService {

	/**
	 * 서비스 목록 조회
	 * 
	 * @param serviceVO
	 * @return
	 */
	public List<VMServiceVO> selectVMServiceList(VMServiceVO serviceVO);
	
	/**
	 * 테넌트 고유번호로 서비스 목록 조회
	 * 
	 * @param tenantId
	 * @return
	 */
	public List<VMServiceVO> selectVMServiceListByTenantId(Integer tenantId);
	
	/**
	 * 사용자가 속한 서비스 목록 조회
	 * 
	 * @param serviceVO
	 * @return
	 */
	public List<VMServiceVO> selectVMServiceListByUserMapping(VMServiceVO serviceVO);
	
	/**
	 * 서비스 조회
	 * 
	 * @param vmServiceID 서비스ID
	 * @return
	 */
	public VMServiceVO selectVMService(Integer vmServiceID);
	
	/**
	 * 관리자 ID로 서비스 조회
	 * 복수일 경우 가장 최근에 생성된서비스를 조회한다
	 * 
	 * @param vmServiceUserID 서비스 관리자 ID
	 * @return
	 */
	public VMServiceVO selectVMServiceByVMServiceUserID(Integer vmServiceUserID);
	
	/**
	 * 해당 서비스에 속한 가상머신 수
	 * 
	 * @param vmServiceID 서비스ID
	 * @return
	 */
	public int countVMByVMServiceID(Integer vmServiceID);
	
	/**
	 * 해당 테넌트에 속한 서비스 수 조회
	 * 
	 * @param tenantId 테넌트 ID
	 * @return
	 */
	public int countServiceByTenantId(int tenantId);
	
	/**
	 * 사용자가 관리자로 있는 서비스 수 조회
	 * 
	 * @param vmServiceUserID 사용자 고유번호
	 * @return
	 */
	public int countServiceAdmin(Integer vmServiceUserID);
	
	/**
	 * 서비스 등록
	 * 
	 * @param serviceVO
	 * @return
	 */
	public int insertVMService(VMServiceVO serviceVO);

	/**
	 * 서비스 수정
	 * 
	 * @param serviceVO
	 * @return
	 */
	public int updateVMService(VMServiceVO serviceVO);

	/**
	 * 서비스 삭제
	 * 
	 * @param vmServiceID 서비스ID
	 * @return
	 */
	public int deleteVMService(Integer vmServiceID);
	
}
