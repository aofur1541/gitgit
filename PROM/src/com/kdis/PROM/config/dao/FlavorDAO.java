package com.kdis.PROM.config.dao;

import java.util.List;

import com.kdis.PROM.config.vo.FlavorVO;

/**
 * 가상머신 자원 DAO interface
 * 
 * @author KimHahn
 *
 */
public interface FlavorDAO {

	/**
	 * 가상머신 자원 목록 조회
	 * 
	 * @param flavorVO
	 * @return
	 */
	public List<FlavorVO> selectFlavorList(FlavorVO flavorVO);
	
	/**
	 * 가상머신 자원 ID로 가상머신 자원 조회
	 * 
	 * @param id
	 * @return
	 */
	public FlavorVO selectFlavorById(Integer id);
	
	/**
	 * 가상머신 자원 등록
	 * 
	 * @param flavorVO
	 * @return
	 */
	public int insertFlavor(FlavorVO flavorVO);
	
	/**
	 * 가상머신 자원 수정
	 * 
	 * @param flavorVO
	 * @return
	 */
	public int updateFlavor(FlavorVO flavorVO);
	
	/**
	 * 가상머신 자원 삭제
	 * 
	 * @param id
	 * @return
	 */
	public int deleteFlavor(Integer id);
}
