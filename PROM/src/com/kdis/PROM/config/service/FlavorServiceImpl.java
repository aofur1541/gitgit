package com.kdis.PROM.config.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdis.PROM.config.dao.FlavorDAO;
import com.kdis.PROM.config.vo.FlavorVO;

/**
 * 가상머신 자원 Service 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class FlavorServiceImpl implements FlavorService {

	/** 가상머신 자원 DAO */
	@Autowired
	FlavorDAO flavorDAO;
	
	/**
	 * 가상머신 자원 목록 조회
	 * 
	 * @param flavorVO
	 * @return
	 */
	@Override
	public List<FlavorVO> selectFlavorList(FlavorVO flavorVO) {
		return flavorDAO.selectFlavorList(flavorVO);
	}
	
	/**
	 * 가상머신 자원 ID로 가상머신 자원 조회
	 * 
	 * @param id
	 * @return
	 */
	@Override
	public FlavorVO selectFlavorById(Integer id) {
		return flavorDAO.selectFlavorById(id);
	}
	
	/**
	 * 가상머신 자원 등록
	 * 
	 * @param flavorVO
	 * @return
	 */
	@Override
	@Transactional
	public int insertFlavor(FlavorVO flavorVO) {
		return flavorDAO.insertFlavor(flavorVO);
	}
	
	/**
	 * 가상머신 자원 수정
	 * 
	 * @param flavorVO
	 * @return
	 */
	@Override
	@Transactional
	public int updateFlavor(FlavorVO flavorVO) {
		return flavorDAO.updateFlavor(flavorVO);
	}
	
	/**
	 * 가상머신 자원 삭제
	 * 
	 * @param id
	 * @return
	 */
	@Override
	@Transactional
	public int deleteFlavor(Integer id) {
		return flavorDAO.deleteFlavor(id);
	}
	
}
