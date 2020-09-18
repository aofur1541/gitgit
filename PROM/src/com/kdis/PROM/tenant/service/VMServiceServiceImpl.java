package com.kdis.PROM.tenant.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdis.PROM.tenant.dao.VMServiceDAO;
import com.kdis.PROM.tenant.vo.VMServiceVO;

/**
 * 서비스 Service 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class VMServiceServiceImpl implements VMServiceService {

	/** 서비스 DAO */
	@Autowired
	VMServiceDAO serviceDAO;
	
	/**
	 * 서비스 목록 조회
	 * 
	 * @param serviceVO
	 * @return
	 */
	@Override
	public List<VMServiceVO> selectVMServiceList(VMServiceVO serviceVO) {
		return serviceDAO.selectVMServiceList(serviceVO);
	}
	
	/**
	 * 사용자가 속한 서비스 목록 조회
	 * 
	 * @param serviceVO
	 * @return
	 */
	@Override
	public List<VMServiceVO> selectVMServiceListByUserMapping(VMServiceVO serviceVO) {
		return serviceDAO.selectVMServiceListByUserMapping(serviceVO);
	}
	
	/**
	 * 테넌트 고유번호로 서비스 목록 조회
	 * 
	 * @param tenantId
	 * @return
	 */
	@Override
	public List<VMServiceVO> selectVMServiceListByTenantId(Integer tenantId) {
		VMServiceVO serviceVO = new VMServiceVO();
		serviceVO.setTenantId(tenantId);
		return serviceDAO.selectVMServiceList(serviceVO);
	}
	
	/**
	 * 서비스 조회
	 * 
	 * @param vmServiceID 서비스ID
	 * @return
	 */
	@Override
	public VMServiceVO selectVMService(Integer vmServiceID) {
		return serviceDAO.selectVMService(vmServiceID);
	}
	
	/**
	 * 해당 서비스에 속한 가상머신 수
	 * 
	 * @param vmServiceID 서비스ID
	 * @return
	 */
	@Override
	public int countVMByVMServiceID(Integer vmServiceID) {
		return serviceDAO.countVMByVMServiceID(vmServiceID);
	}
	
	/**
	 * 관리자 ID로 서비스 조회
	 * 복수일 경우 가장 최근에 생성된서비스를 조회한다
	 * 
	 * @param vmServiceUserID 서비스 관리자 ID
	 * @return
	 */
	@Override
	public VMServiceVO selectVMServiceByVMServiceUserID(Integer vmServiceUserID) {
		return serviceDAO.selectVMServiceByVMServiceUserID(vmServiceUserID);
		
	}
	
	/**
	 * 해당 테넌트에 속한 서비스 수 조회
	 * 
	 * @param tenantId 테넌트 ID
	 * @return
	 */
	@Override
	public int countServiceByTenantId(int tenantId) {
		return serviceDAO.countServiceByTenantId(tenantId);
	}
	
	/**
	 * 사용자가 관리자로 있는 서비스 수 조회
	 * 
	 * @param vmServiceUserID 사용자 고유번호
	 * @return
	 */
	public int countServiceAdmin(Integer vmServiceUserID) {
		VMServiceVO serviceVO = new VMServiceVO();
		serviceVO.setVmServiceUserID(vmServiceUserID);
		return serviceDAO.countServiceAdmin(serviceVO);
	}
	
	/**
	 * 서비스 등록
	 * 
	 * @param serviceVO
	 * @return
	 */
	@Override
	@Transactional
	public int insertVMService(VMServiceVO serviceVO) {
		return serviceDAO.insertVMService(serviceVO);
	}

	/**
	 * 서비스 수정
	 * 
	 * @param serviceVO
	 * @return
	 */
	@Override
	@Transactional
	public int updateVMService(VMServiceVO serviceVO) {
		return serviceDAO.updateVMService(serviceVO);
	}

	/**
	 * 서비스 삭제
	 * 
	 * @param vmServiceID 서비스ID
	 * @return
	 */
	@Override
	@Transactional
	public int deleteVMService(Integer vmServiceID) {
		return serviceDAO.deleteVMService(vmServiceID);
	}
	
}
