package com.kdis.PROM.config.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kdis.PROM.config.dao.BasicDAO;
import com.kdis.PROM.config.vo.BasicVO;

/**
 * 기본 기능 Service 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class BasicServiceImpl implements BasicService {

	/** 기본 기능 DAO */
	@Autowired
	BasicDAO basicDAO;
	
	/**
	 * 기본 기능 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<BasicVO> selectBasicList() {
		return basicDAO.selectBasicList();
	}
	
	/**
	 * 이름으로 기본 기능 조회
	 * 
	 * @return
	 */
	@Override
	public BasicVO selectBasicByName(String name) {
		return basicDAO.selectBasicByName(name);
	}
	
	/**
	 * 기본 기능 수정
	 * 
	 * @param basicVO
	 * @return
	 */
	@Override
	public int updateBasic(BasicVO basicVO) {
		return basicDAO.updateBasic(basicVO);
	}
	
}
