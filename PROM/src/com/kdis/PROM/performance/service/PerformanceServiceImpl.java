package com.kdis.PROM.performance.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.performance.dao.PerformanceDAO;
import com.kdis.PROM.performance.vo.AgentVO;
import com.kdis.PROM.performance.vo.PerformanceVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 성능 Service 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class PerformanceServiceImpl implements PerformanceService {

	/** 성능 DAO */
	@Autowired
	PerformanceDAO performanceDAO;
	
	/**
	 * 가상머신 목록의 리소스 통계 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@Override
	public PerformanceVO selectVMResourceStatistics(PerformanceVO performanceVO) {
		// 세션에서 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		performanceVO.setUserId(loginInfo.getId());
		
		return performanceDAO.selectVMResourceStatistics(performanceVO);
	}
	
	/**
	 * 가상머신의 성능 통계 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@Override
	public List<PerformanceVO> selectVMPerformanceStatisticsList(PerformanceVO performanceVO) {
		
		// 세션에서 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		performanceVO.setUserId(loginInfo.getId());
		
		// 대상 테이블명 얻기
		String targetTable = this.getPerformanceTable("VM", performanceVO.getPeriod());
		performanceVO.setTargetTable(targetTable);
		
		return performanceDAO.selectVMPerformanceStatisticsList(performanceVO);
	}
	
	/**
	 * 가상머신의 성능 목록 조회
	 * 
	 * @param vmID
	 * @param period 주기
	 * @return
	 */
	@Override
	public List<PerformanceVO> selectVMPerformanceList(String vmID, int period) {

		// 대상 테이블명 얻기
		String targetTable = this.getPerformanceTable("VM", period);
		
		PerformanceVO performanceVO = new PerformanceVO();
		performanceVO.setVmID(vmID);
		performanceVO.setPeriod(period);
		performanceVO.setTargetTable(targetTable);
		
		return performanceDAO.selectVMPerformanceList(performanceVO);
	}
	
	/**
	 * 해당 클러스터에 속한 호스트의 리소스 통계 조회
	 * 
	 * @param clusterId
	 * @return
	 */
	@Override
	public PerformanceVO selectHostResourceStatistics(String clusterId) {
		PerformanceVO performanceVO = new PerformanceVO();
		performanceVO.setClusterId(clusterId);
		return performanceDAO.selectHostResourceStatistics(performanceVO);
	}
	
	/**
	 * 가상머신의 통합 성능 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@Override
	public List<PerformanceVO> selectVMPerformanceTotalList(PerformanceVO performanceVO) {
		
		// 세션에서 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		performanceVO.setUserId(loginInfo.getId());
		
		// 대상 테이블명 얻기
		String targetTable = this.getPerformanceTable("VM", performanceVO.getPeriod());
		performanceVO.setTargetTable(targetTable);
				
		return performanceDAO.selectVMPerformanceTotalList(performanceVO);
	}
	
	/**
	 * 해당 클러스터에 속한 호스트의 성능 통계 목록 조회
	 * 
	 * @param clusterId
	 * @param period 주기
	 * @return
	 */
	@Override
	public List<PerformanceVO> selectHostPerformanceStatisticsList(String clusterId, int period) {
		
		// 대상 테이블명 얻기
		String targetTable = this.getPerformanceTable("Host", period);
		
		PerformanceVO performanceVO = new PerformanceVO();
		performanceVO.setClusterId(clusterId);
		performanceVO.setPeriod(period);
		performanceVO.setTargetTable(targetTable);
		
		return performanceDAO.selectHostPerformanceStatisticsList(performanceVO);
	}
	
	/**
	 * 호스트 성능 목록 조회
	 * 
	 * @param hostId
	 * @param period 주기
	 * @return
	 */
	@Override
	public List<PerformanceVO> selectHostPerformanceList(String hostId, int period) {
		
		// 대상 테이블명 얻기
		String targetTable = this.getPerformanceTable("Host", period);
		
		PerformanceVO performanceVO = new PerformanceVO();
		performanceVO.setHostId(hostId);
		performanceVO.setPeriod(period);
		performanceVO.setTargetTable(targetTable);
		
		return performanceDAO.selectHostPerformanceList(performanceVO);
	}
	
	/**
	 * 호스트 통합 성능 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@Override
	public List<PerformanceVO> selectHostPerformanceTotalList(PerformanceVO performanceVO) {
		// 대상 테이블명 얻기
		String targetTable = this.getPerformanceTable("Host", performanceVO.getPeriod());
		performanceVO.setTargetTable(targetTable);
				
		return performanceDAO.selectHostPerformanceTotalList(performanceVO);
	}
	
	/**
	 * 자원 기준치를 넘은 가상머신 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@Override
	public List<PerformanceVO> selectVMOvercpuList(PerformanceVO performanceVO) {

		// 세션에서 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		performanceVO.setUserId(loginInfo.getId());
		
		return performanceDAO.selectVMOvercpuList(performanceVO);
	}
	
	/**
	 * 에이전트 OS 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<AgentVO> selectAgentOSList() {
		return performanceDAO.selectAgentOSList();
	}
	
	/**
	 * 에이전트 성능 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@Override
	public List<PerformanceVO> selectAgentPerformanceList(PerformanceVO performanceVO) {
		return performanceDAO.selectAgentPerformanceList(performanceVO);
	}
	
	/**
	 * 해당 서비스에 속한 가상머신의 Top5 성능 리소스 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@Override
	public List<PerformanceVO> selectPerformanceRankListByServiceId(PerformanceVO performanceVO) {
		return performanceDAO.selectPerformanceRankListByServiceId(performanceVO);
	}
	
	/**
	 * 카테고리(가상머신 or 호스트), 주기별 성능 대상 테이블명 얻기
	 * 
	 * @param category
	 * @param period
	 * @return
	 */
	private String getPerformanceTable(String category, int period) {

		String targetTable = "";

		if (category.equals("VM")) {
			targetTable = "VM";
		} else {
			targetTable = "Host";
		}

		switch (period) {
			case 0:
				targetTable = "`perf" + targetTable + "Realtime`";
				break;
			case 1:
				targetTable = "`perf" + targetTable + "Day`";
				break;
			case 2:
				targetTable = "`perf" + targetTable + "Week`";
				break;
			case 3:
				targetTable = "`perf" + targetTable + "Month`";
				break;
			case 4:
				targetTable = "`perf" + targetTable + "Year`";
				break;
		}
		return targetTable;
	}

	@Override
	public List<PerformanceVO> selectPNICPerformanceList(PerformanceVO performanceVO) {
		return performanceDAO.selectPNICPerformanceList(performanceVO);
	}

	@Override
	public List<PerformanceVO> selectVMOvermemoryList(PerformanceVO performanceVO) {
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		performanceVO.setUserId(loginInfo.getId());
		
		return performanceDAO.selectVMOvermemoryList(performanceVO);
	}
}
