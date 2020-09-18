package com.kdis.PROM.config.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdis.PROM.common.AESUtil;
import com.kdis.PROM.config.dao.ExternalServerDAO;
import com.kdis.PROM.config.vo.ExternalServerTypeEnum;
import com.kdis.PROM.config.vo.ExternalServerVO;

/**
 * 외부 서버 Service 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class ExternalServerServiceImpl implements ExternalServerService {

	/** 외부 서버 DAO */
	@Autowired
	ExternalServerDAO externalServerDAO;
	
	/**
	 * 외부 서버 목록 조회
	 * 
	 * @param externalServerVO 검색 조건
	 * @return
	 */
	@Override
	public List<ExternalServerVO> selectExternalServerList(ExternalServerVO externalServerVO) {
		return externalServerDAO.selectExternalServerList(externalServerVO);
	}
	
	/**
	 * 외부 서버  조회
	 * 
	 * @param id 외부 서버 고유 번호
	 * @return
	 */
	@Override
	public ExternalServerVO selectExternalServer(Integer id) {
		return externalServerDAO.selectExternalServer(id);
	}
	
	/**
	 * 서버 종류로 외부 서버  조회
	 * 
	 * @param serverType 서버 종류
	 * @return
	 * @throws Exception 
	 */
	@Override
	public ExternalServerVO selectExternalServerByServerType(ExternalServerTypeEnum serverType) throws Exception {
		ExternalServerVO result = externalServerDAO.selectExternalServerByServerType(serverType.getServerType());
		
		// 비밀번호 복호화
		AESUtil aesUtil = new AESUtil();
		if(result != null && result.getPassword() != null && !"".contentEquals(result.getPassword())) {
			String decString = aesUtil.decrypt(result.getPassword());
			result.setPassword(decString);
		}
		return result;
	}
	
	/**
	 * 외부 서버 등록
	 * 
	 * @param externalServerVO
	 * @return
	 */
	@Override
	@Transactional
	public int insertExternalServer(ExternalServerVO externalServerVO) {
		return externalServerDAO.insertExternalServer(externalServerVO);
	}
	
	/**
	 * 외부 서버 수정
	 * 
	 * @param externalServerVO
	 * @return
	 */
	@Override
	@Transactional
	public int updateExternalServer(ExternalServerVO externalServerVO) {
		return externalServerDAO.updateExternalServer(externalServerVO);
	}
	
	/**
	 * 외부 서버 삭제
	 * 
	 * @param id 외부 서버 고유 번호
	 * @return
	 */
	@Override
	@Transactional
	public int deleteExternalServer(Integer id) {
		return externalServerDAO.deleteExternalServer(id);
	}
	
}
