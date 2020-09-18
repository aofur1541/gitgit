package com.kdis.PROM.status.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.status.service.StatusService;
import com.kdis.PROM.status.vo.VMStorageVO;
import com.kdis.PROM.tenant.vo.VMHostVO;

/**
 * 현황 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class StatusController {

	/** 현황 서비스 */
	@Autowired
	private StatusService statusService;
	
	/**
	 * 현황 > 가상머신 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/status/vmStatus.prom")
	public String vmStatus() {
		return "status/vmStatus";
	}
	
	/**
	 * 현황 > 데이터스토어 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/status/datastoreStatus.prom")
	public String datastoreStatus() {
		return "status/datastoreStatus";
	}

	/**
	 * 현황 > 호스트 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/status/hostStatus.prom")
	public String hostStatus() {
		return "status/hostStatus";
	}
	
	/**
	 * 호스트 정보 목록 조회
	 * 
	 * @param vmHID
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/status/selectVMHostList.do")
	public List<VMHostVO> selectVMHostList(VMHostVO vmHostVO) {
		List<VMHostVO> result = statusService.selectVMHostList(vmHostVO);
		return result;
	}
	
	/**
	 * 호스트 정보 조회
	 * 
	 * @param vmHID
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/status/selectVMHost.do")
	public VMHostVO selectVMHost(String vmHID) {
		VMHostVO result = statusService.selectVMHost(vmHID);
		return result;
	}
	
	/**
	 * 공용 데이터스토어 목록 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/status/selectPublicDatastoreList.do")
	public List<VMStorageVO> selectPublicDatastoreList() {
		List<VMStorageVO> datastoreList = statusService.selectPublicDatastoreList();
		return datastoreList;
	}

	/**
	 * 로컬 데이터스토어 목록 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/status/selectLocalDatastoreList.do")
	public List<VMStorageVO> selectLocalDatastoreList() {
		List<VMStorageVO> datastoreList = statusService.selectLocalDatastoreList();
		return datastoreList;
	}

}