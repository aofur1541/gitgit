package com.kdis.PROM.status.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kdis.PROM.status.dao.StatusDAO;
import com.kdis.PROM.status.vo.VMStorageVO;
import com.kdis.PROM.tenant.vo.VMHostVO;


@Service
public class StatusServiceImpl implements StatusService {

	/** 현황 DAO */
	@Autowired
	StatusDAO statusDAO;
	
	/**
	 * 동작 중인(최근 60초 기준) 호스트 목록 조회
	 * 
	 * @param vmHostVO 검색 조건
	 * @return
	 */
	@Override
	public List<VMHostVO> selectVMHostList(VMHostVO vmHostVO) {
		return statusDAO.selectVMHostList(vmHostVO);
	}

	/**
	 * 호스트 정보 조회
	 * 
	 * @param vmHID
	 * @return
	 */
	@Override
	public VMHostVO selectVMHost(String vmHID) {
		return statusDAO.selectVMHost(vmHID);
	}
	
	/**
	 * 공용 데이터스토어 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<VMStorageVO> selectPublicDatastoreList() {
		return statusDAO.selectPublicDatastoreList();
	}
	
	/**
	 * 로컬 데이터스토어 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<VMStorageVO> selectLocalDatastoreList() {
		return statusDAO.selectLocalDatastoreList();
	}
}
