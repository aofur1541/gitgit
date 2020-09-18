package com.kdis.PROM.dash.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kdis.PROM.dash.vo.DashboardVO;
import com.kdis.PROM.performance.vo.PerformanceVO;
import com.kdis.PROM.status.vo.VMStorageVO;

public interface DashboardDAO {

	List<VMStorageVO> selectDataStoreState(DashboardVO vo);
	
	HashMap<String, Object> selectHostsState(DashboardVO vo);

	HashMap<String, Object> selectVMState(DashboardVO vo);
	
	HashMap<String, Object> selectAllCountList();

	HashMap<String, Object> selectAllResourceVMs();

	HashMap<String, Object> selectAllResourceVMs(DashboardVO vo);
	
	HashMap<String, Object> selectAllResourcePhysics();

	HashMap<String, Object> selectAllResourcePhysics(DashboardVO vo);

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

	void updateWidgetCustomization(@Param("integrateWidget") String integrateWidget,@Param("getsUserID") String getsUserID);

	void updateWidgetIdCustomization(@Param("clusterWidget") String clusterWidget, @Param("getsUserID") String getsUserID);

	List<DashboardVO> selectWidgetList(@Param("getsUserID") String getsUserID);

	void updateIntegrateWidgetOrderCustomization(@Param("strIntegrateWidgetOrder") String strIntegrateWidgetOrder, @Param("getsUserID")  String getsUserID);
	
	void updateClusterWidgetOrderCustomization(@Param("strClusterWidgetOrder") String strClusterWidgetOrder, @Param("getsUserID")  String getsUserID);

	List<DashboardVO> selectWidgetOrderList(@Param("getsUserID") String getsUserID);

	List<DashboardVO> getNSXTClusterList();
	
}
