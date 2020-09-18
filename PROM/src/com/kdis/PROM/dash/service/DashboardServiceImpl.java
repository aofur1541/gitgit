package com.kdis.PROM.dash.service;

import java.util.HashMap;
import java.util.List;
import com.kdis.PROM.status.vo.VMStorageVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.kdis.PROM.dash.dao.DashboardDAO;
import com.kdis.PROM.dash.vo.DashboardVO;
import com.kdis.PROM.performance.vo.PerformanceVO;

@Service
public class DashboardServiceImpl implements DashboardService {

	@Autowired
	DashboardDAO dashboardDAO;

	@Override
	public List<VMStorageVO> selectDataStoreState(DashboardVO vo) {
		return dashboardDAO.selectDataStoreState(vo);
	}
	@Override
	public HashMap<String, Object> selectHostsState(DashboardVO vo) {
		return dashboardDAO.selectHostsState(vo);
	}

	@Override
	public HashMap<String, Object> selectVMState(DashboardVO vo) {
		return dashboardDAO.selectVMState(vo);
	}
	
	@Override
	public HashMap<String, Object> selectAllCountList() {
		return dashboardDAO.selectAllCountList();
	}

	@Override
	public HashMap<String, Object> selectAllResourceVMs() {
		return dashboardDAO.selectAllResourceVMs();
	}

	@Override
	public HashMap<String, Object> selectAllResourcePhysics() {
		return dashboardDAO.selectAllResourcePhysics();
	}
	
	@Override
	public HashMap<String, Object> selectAllResourceVMs(DashboardVO vo) {
		return dashboardDAO.selectAllResourceVMs(vo);
	}
	
	@Override
	public HashMap<String, Object> selectAllResourcePhysics(DashboardVO vo) {
		return dashboardDAO.selectAllResourcePhysics(vo);
	}
	
	@Override
	public HashMap<String, Object> selectAllApprovalCheckcnt() {
		return dashboardDAO.selectAllApprovalCheckcnt();
	}

	/**
	 * VM과 Host의 가장 최근 성능 로그의 시간 차이 얻기
	 * 
	 * @return
	 */
	@Override
	public int selectTimestampdiffVMAndHost() {
		return dashboardDAO.selectTimestampdiffVMAndHost();
	}
	
	/**
	 * 호스트 성능 Top 5 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@Override
	public List<PerformanceVO> selectHostPerformanceTop5List(PerformanceVO performanceVO) {
		return dashboardDAO.selectHostPerformanceTop5List(performanceVO);
	}
	
	/**
	 * 가상머신 성능 Top 5 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@Override
	public List<PerformanceVO> selectVMPerformanceTop5List(PerformanceVO performanceVO) {
		return dashboardDAO.selectVMPerformanceTop5List(performanceVO);
	}
	
	/**
	 * 클러스트 최근 10분 평균 성능 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@Override
	public List<PerformanceVO> selectClusterAveragePerformanceList(PerformanceVO performanceVO) {
		return dashboardDAO.selectClusterAveragePerformanceList(performanceVO);
	}
	
	/**
	 * 사용자가 속한 테넌트의 현황 얻기
	 * 
	 * @param userId 사용자 고유번호
	 * @return
	 */
	@Override
	public DashboardVO selectUserTenantStatus(Integer userId) {
		return dashboardDAO.selectUserTenantStatus(userId);
	}
	
	/**
	 * 서비스의 현황 얻기
	 * 
	 * @param serviceId 서비스 고유번호
	 * @return
	 */
	@Override
	public DashboardVO selectServiceStatus(Integer serviceId) {
		return dashboardDAO.selectServiceStatus(serviceId);
	}
	@Override
	public void updateWidgetCustomization(String integrateWidget, String getsUserID) {
		dashboardDAO.updateWidgetCustomization(integrateWidget,getsUserID);
		
	}
	@Override
	public void updateWidgetIdCustomization(String clusterWidget, String getsUserID) {
		dashboardDAO.updateWidgetIdCustomization(clusterWidget,getsUserID);
	}
	@Override
	public List<DashboardVO> selectWidgetList(String getsUserID) {
		return dashboardDAO.selectWidgetList(getsUserID);
	}
	@Override
	public void updateIntegrateWidgetOrderCustomization(String strIntegrateWidgetOrder, String getsUserID) {
		dashboardDAO.updateIntegrateWidgetOrderCustomization(strIntegrateWidgetOrder,getsUserID);
	}
	@Override
	public void updateClusterWidgetOrderCustomization(String strClusterWidgetOrder, String getsUserID) {
		dashboardDAO.updateClusterWidgetOrderCustomization(strClusterWidgetOrder,getsUserID);
	}
	@Override
	public List<DashboardVO> selectWidgetOrderList(String getsUserID) {
		return dashboardDAO.selectWidgetOrderList(getsUserID);
	}
	@Override
	public List<DashboardVO> getNSXTClusterList() {
		return dashboardDAO.getNSXTClusterList();
	}
}
