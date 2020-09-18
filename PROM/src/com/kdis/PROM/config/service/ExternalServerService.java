package com.kdis.PROM.config.service;

import java.util.List;

import com.kdis.PROM.config.vo.ExternalServerTypeEnum;
import com.kdis.PROM.config.vo.ExternalServerVO;

/**
 * 외부 서버 Service interface
 * 
 * @author KimHahn
 *
 */
public interface ExternalServerService {

	/**
	 * 외부 서버 목록 조회
	 * 
	 * @param externalServerVO 검색 조건
	 * @return
	 */
	public List<ExternalServerVO> selectExternalServerList(ExternalServerVO externalServerVO);
	
	/**
	 * 외부 서버  조회
	 * 
	 * @param id 외부 서버 고유 번호
	 * @return
	 */
	public ExternalServerVO selectExternalServer(Integer id);
	
	/**
	 * 서버 종류로 외부 서버  조회
	 * 
	 * @param serverType 서버 종류
	 * @return
	 * @throws Exception 
	 */
	public ExternalServerVO selectExternalServerByServerType(ExternalServerTypeEnum serverType) throws Exception;
	
	/**
	 * 외부 서버 등록
	 * 
	 * @param externalServerVO
	 * @return
	 */
	public int insertExternalServer(ExternalServerVO externalServerVO);
	
	/**
	 * 외부 서버 수정
	 * 
	 * @param externalServerVO
	 * @return
	 */
	public int updateExternalServer(ExternalServerVO externalServerVO);
	
	/**
	 * 외부 서버 삭제
	 * 
	 * @param id 외부 서버 고유 번호
	 * @return
	 */
	public int deleteExternalServer(Integer id);
	
}
