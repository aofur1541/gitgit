package com.kdis.PROM.performance.dao;

import java.util.List;

import com.kdis.PROM.performance.vo.AgentVO;
import com.kdis.PROM.performance.vo.PerformanceVO;

/**
 * 성능 DAO interface
 * 
 * @author KimHahn
 *
 */
public interface PerformanceDAO {

	/**
	 * 가상머신 목록의 리소스 통계 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public PerformanceVO selectVMResourceStatistics(PerformanceVO performanceVO);
	
	/**
	 * 해당 서비스에 속한 가상머신의 성능 통계 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public List<PerformanceVO> selectVMPerformanceStatisticsList(PerformanceVO performanceVO);
	
	/**
	 * 가상머신의 성능 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public List<PerformanceVO> selectVMPerformanceList(PerformanceVO performanceVO);
	
	/**
	 * 가상머신 통합 성능 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public List<PerformanceVO> selectVMPerformanceTotalList(PerformanceVO performanceVO);
	
	/**
	 * 해당 클러스터에 속한 호스트의 리소스 통계 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public PerformanceVO selectHostResourceStatistics(PerformanceVO performanceVO);
	
	/**
	 * 해당 클러스터에 속한 호스트의 성능 통계 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public List<PerformanceVO> selectHostPerformanceStatisticsList(PerformanceVO performanceVO);
	
	/**
	 * 호스트 성능 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public List<PerformanceVO> selectHostPerformanceList(PerformanceVO performanceVO);
	
	/**
	 * 호스트 통합 성능 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public List<PerformanceVO> selectHostPerformanceTotalList(PerformanceVO performanceVO);
	
	/**
	 * 자원 기준치를 넘은 가상머신 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public List<PerformanceVO> selectVMOvercpuList(PerformanceVO performanceVO);
	
	/**
	 * 에이전트 OS 목록 조회
	 * 
	 * @return
	 */
	public List<AgentVO> selectAgentOSList();
	
	/**
	 * 에이전트 성능 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public List<PerformanceVO> selectAgentPerformanceList(PerformanceVO performanceVO);
	
	/**
	 * 해당 서비스에 속한 가상머신의 Top5 성능 리소스 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public List<PerformanceVO> selectPerformanceRankListByServiceId(PerformanceVO performanceVO);

	public List<PerformanceVO> selectPNICPerformanceList(PerformanceVO performanceVO);

	public List<PerformanceVO> selectVMOvermemoryList(PerformanceVO performanceVO);
	
}
