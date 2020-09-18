package com.kdis.PROM.dash.service;

import java.util.HashMap;
import java.util.List;

import com.kdis.PROM.dash.vo.DashboardVO;
import com.kdis.PROM.performance.vo.PerformanceVO;
import com.kdis.PROM.status.vo.VMStorageVO;


public interface DashboardService {
	
	
	//전체 개체수 
	HashMap<String, Object> selectAllCountList();
	//물리, 가상 자원 (전체)
	HashMap<String, Object> selectAllResourceVMs();
	//물리, 가상 자원 (클러스터별)
	HashMap<String, Object> selectAllResourceVMs(DashboardVO vo);
	//물리, 가상 자원 (전체)
	HashMap<String, Object> selectAllResourcePhysics();
	//물리, 가상 자원 (클러스터별)
	HashMap<String, Object> selectAllResourcePhysics(DashboardVO vo);

	/**
	 * 
	 * 원형 데이터 (호스트현황, 가상머신 현황, 데이터스토어 현황)
	 *  
	 **/
	
	//호스트
	HashMap<String, Object> selectHostsState(DashboardVO vo);
	//vm
	HashMap<String, Object> selectVMState(DashboardVO vo);
	//데이터스토어
	List<VMStorageVO> selectDataStoreState(DashboardVO vo);
	
	/**
	 * 
	 * 승인 현황
	 */
	
	HashMap<String, Object> selectAllApprovalCheckcnt();
	
	/**
	 * VM과 Host의 가장 최근 성능 로그의 시간 차이 얻기
	 * 
	 * @return
	 */
	public int selectTimestampdiffVMAndHost();
	
	/**
	 * 호스트 성능 Top 5 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public List<PerformanceVO> selectHostPerformanceTop5List(PerformanceVO performanceVO);
	
	/**
	 * 가상머신 성능 Top 5 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public List<PerformanceVO> selectVMPerformanceTop5List(PerformanceVO performanceVO);

	/**
	 * 클러스트 최근 10분 평균 성능 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	public List<PerformanceVO> selectClusterAveragePerformanceList(PerformanceVO performanceVO);
	
	/**
	 * 사용자가 속한 테넌트의 현황 얻기
	 * 
	 * @param userId 사용자 고유번호
	 * @return
	 */
	public DashboardVO selectUserTenantStatus(Integer userId);
	
	/**
	 * 서비스의 현황 얻기
	 * 
	 * @param serviceId 서비스 고유번호
	 * @return
	 */
	public DashboardVO selectServiceStatus(Integer serviceId);
	void updateWidgetCustomization(String integrateWidget, String getsUserID);
	void updateWidgetIdCustomization(String clusterWidget, String getsUserID);
	List<DashboardVO> selectWidgetList(String getsUserID);
	void updateIntegrateWidgetOrderCustomization(String strIntegrateWidgetOrder, String getsUserID);
	void updateClusterWidgetOrderCustomization(String strClusterWidgetOrder, String getsUserID);
	List<DashboardVO> selectWidgetOrderList(String getsUserID);
	List<DashboardVO> getNSXTClusterList();
	

}
