package com.kdis.PROM.status.service;

import java.util.List;

import com.kdis.PROM.status.vo.VMStorageVO;
import com.kdis.PROM.tenant.vo.VMHostVO;

public interface StatusService {
	
	/**
	 * 동작 중인(최근 60초 기준) 호스트 목록 조회
	 * 
	 * @param vmHostVO 검색 조건
	 * @return
	 */
	public List<VMHostVO> selectVMHostList(VMHostVO vmHostVO);

	/**
	 * 호스트 정보 조회
	 * 
	 * @param vmHID
	 * @return
	 */
	public VMHostVO selectVMHost(String vmHID);

	/**
	 * 공용 데이터스토어 목록 조회
	 * 
	 * @return
	 */
	public List<VMStorageVO> selectPublicDatastoreList();
	
	/**
	 * 로컬 데이터스토어 목록 조회
	 * 
	 * @return
	 */
	public List<VMStorageVO> selectLocalDatastoreList();
}
