package com.kdis.PROM.config.dao;

import java.util.List;

import com.kdis.PROM.config.vo.BasicVO;

/**
 * 기본 기능 DAO
 * 
 * @author KimHahn
 *
 */
public interface BasicDAO {

	/**
	 * 기본 기능 목록 조회
	 * 
	 * @return
	 */
	public List<BasicVO> selectBasicList();
	
	/**
	 * 이름으로 기본 기능 조회
	 * 
	 * @return
	 */
	public BasicVO selectBasicByName(String name);
	
	/**
	 * 기본 기능 수정
	 * 
	 * @param basicVO
	 * @return
	 */
	public int updateBasic(BasicVO basicVO);
	
} 
