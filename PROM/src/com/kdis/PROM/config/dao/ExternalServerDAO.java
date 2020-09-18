package com.kdis.PROM.config.dao;

import java.util.List;

import com.kdis.PROM.config.vo.ExternalServerVO;

/**
 * 외부 서버 DAO interface
 * 
 * @author KimHahn
 *
 */
public interface ExternalServerDAO {

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
	 */
	public ExternalServerVO selectExternalServerByServerType(Integer serverType);
	
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
