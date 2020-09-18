package com.kdis.PROM.dash.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.dash.service.DashboardService;
import com.kdis.PROM.dash.vo.DashboardVO;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.performance.vo.PerformanceVO;
import com.kdis.PROM.status.vo.VMStorageVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 대시보드 Controller
 */
@Controller
public class DashboardController {
	
	private static final Log LOG = LogFactory.getLog( DashboardController.class );
	/** 대시보드 서비스 */
	@Autowired
	private DashboardService dashboardService;
	
	/**
	 * 관리자 대시보드 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/dash/dashboard.prom")
	public String dashBoard() {
		return "dash/dashboard";
	}

	//색깔 별 클러스터,호스트, 가상머신 , 탬플릿, 테넌트, 서비스, 부서 ,사용자 개체수
	@RequestMapping("dash/selectAllCountList.do")
	public @ResponseBody HashMap<String, Object> selectAllCountList(){
		HashMap<String, Object> result = dashboardService.selectAllCountList();
		return result;
	}
	
	/**
	 * 가상머신 할당 현황, 물리 자원 현황
	 * 
	 */
	//	전체 가상머신 할당 현황
	@RequestMapping("dash/selectAllResourceVMs.do")
	public @ResponseBody HashMap<String, Object> selectAllResourceVMs(){
		HashMap<String, Object> result = dashboardService.selectAllResourceVMs();
		return result;
	}
	
	//	전체 물리 자원 현황
	@RequestMapping("dash/selectAllResourcePhysics.do")
	public @ResponseBody HashMap<String, Object> selectAllResourcePhysics(){
		HashMap<String, Object> result = dashboardService.selectAllResourcePhysics();
		return result;
	}
	
	//	클러스터 별 물리 자원 현황
	@RequestMapping("dash/selectClusterResourcePhysics.do")
	public @ResponseBody HashMap<String, Object> selectClusterResourcePhysics(DashboardVO vo){
		HashMap<String, Object> result = dashboardService.selectAllResourcePhysics(vo);
		return result;
	}
	
	//	클러스터 별 가상 머신 현황
	@RequestMapping("dash/selectClusterResourceVMs.do")
	public @ResponseBody HashMap<String, Object> selectClusterResourceVMs(DashboardVO vo){
		HashMap<String, Object> result = dashboardService.selectAllResourceVMs(vo);
		return result;
	}
	
	/**
	 *  어드민 권한일 경우 신청 승인 현황
	 * @ Admin / User
	 */
	@RequestMapping("dash/selectAllApprovalCheckcnt.do")
	public @ResponseBody HashMap<String, Object> selectAllApprovalCheckcnt(){
		HashMap<String, Object> result = dashboardService.selectAllApprovalCheckcnt();
		return result;
	}
	
	/**
	 * @return 원형 그래프 ( 호스트 현황, 가상머신 현황, 데이터 스토어 현황)
	 * 
	 */
	@RequestMapping("dash/selectDataStoreState.do")
	public @ResponseBody List<VMStorageVO> selectDataStoreState(DashboardVO vo){
		List<VMStorageVO> result = dashboardService.selectDataStoreState(vo);
		return result;
	}
	
	//	호스트 현황
	@RequestMapping("dash/selectHostsState.do")
	public @ResponseBody HashMap<String, Object> selectHostsState(DashboardVO vo){
		HashMap<String, Object> result = dashboardService.selectHostsState(vo);
		return result;
	}
	
	//	가상머신 현황
	@RequestMapping("dash/selectVMState.do")
	public @ResponseBody HashMap<String, Object> selectVMState(DashboardVO vo){
		HashMap<String, Object> result = dashboardService.selectVMState(vo);
		return result;
	}
	
	/**
	 * 호스트 성능 Top 5목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/dash/selectHostPerformanceTop5List.do")
	public List<PerformanceVO> selectHostPerformanceTop5List(PerformanceVO performanceVO) {
		// VM과 Host의 가장 최근 성능 로그의 시간 차이 얻기
		int calc = dashboardService.selectTimestampdiffVMAndHost();
		if(calc > 0) {
			performanceVO.setCalc(calc);
		}
		// 호스트 성능 Top 5목록 조회
		List<PerformanceVO> result = dashboardService.selectHostPerformanceTop5List(performanceVO);
		return result;
	}
	
	/**
	 * 가상머신 성능 Top 5목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/dash/selectVMPerformanceTop5List.do")
	public List<PerformanceVO> selectVMPerformanceTop5List(PerformanceVO performanceVO){
		// VM과 Host의 가장 최근 성능 로그의 시간 차이 얻기
		int calc = dashboardService.selectTimestampdiffVMAndHost();
		if(calc > 0) {
			performanceVO.setCalc(calc);
		}
		// 가상머신 성능 Top 5목록 조회
		List<PerformanceVO> result = dashboardService.selectVMPerformanceTop5List(performanceVO);
		return result;
	}
	
	/**
	 * 클러스트 최근 10분 평균 성능 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/dash/selectClusterAveragePerformanceList.do")
	public List<PerformanceVO> selectClusterAveragePerformanceList(PerformanceVO performanceVO){
		List<PerformanceVO> result = dashboardService.selectClusterAveragePerformanceList(performanceVO);
		return result;
	}
	
	
	@PostMapping("/dash/saveWidgetCustomization.do")
	public @ResponseBody void saveWidgetCustomization(@RequestParam(value = "integrateWidgetList[]", required = false) List<String> integrateWidgetList,
			@RequestParam(value = "clusterWidgetListId[]",required = false) List<String> clusterWidgetListId,HttpSession session){
		String integrateWidget = null;
		String clusterWidget= null;
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		try {
			if(integrateWidgetList != null) {
				for(int i=0;i<integrateWidgetList.size();i++) {
					if(i == 0) {
						integrateWidget = "";
						integrateWidget += integrateWidgetList.get(i);
					}else {
						integrateWidget += ","+integrateWidgetList.get(i);
					}
				}
				try {
					dashboardService.updateWidgetCustomization(integrateWidget,loginInfo.getsUserID());
				} catch (Exception e) {
					LOG.warn(e+" saveWidgetCustomization #2 ERROR");
				}
			}else {
				dashboardService.updateWidgetCustomization(integrateWidget,loginInfo.getsUserID());
			}
			if(clusterWidgetListId != null) {
				for(int i=0;i<clusterWidgetListId.size();i++) {
					if(i == 0) {
						clusterWidget = "";
						clusterWidget += clusterWidgetListId.get(i);
					}else {
						clusterWidget += ","+clusterWidgetListId.get(i);
					}
				}
				try {
					dashboardService.updateWidgetIdCustomization(clusterWidget,loginInfo.getsUserID());
				} catch (Exception e) {
					LOG.warn(e+" saveWidgetCustomization #3 ERROR");
				}
				
			}else {
				dashboardService.updateWidgetIdCustomization(clusterWidget,loginInfo.getsUserID());
			}
		}catch (Exception e) {
			LOG.warn(e+" saveWidgetCustomization #1 ERROR");
		}
		
	}
	@RequestMapping("/dash/selectWidgetList.do")
	public @ResponseBody HashMap<String, Object> selectWidgetList(HttpSession session) {
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		List<DashboardVO> result = null;
		try {
			result = dashboardService.selectWidgetList(loginInfo.getsUserID());
			if(result != null) {
				hashmap.put("getIntegrateWidgetList", result.get(0).getIntegrateWidgetList());
				hashmap.put("getClusterWidgetListId", result.get(0).getClusterWidgetListId()); 
			}else {
				hashmap.put("getIntegrateWidgetList", null);
				hashmap.put("getClusterWidgetListId", null); 
			}
			
		} catch (NullPointerException e) {
			// TODO: handle exception
		}catch (Exception e) {
			LOG.warn(e+" saveWidgetCustomization #4 ERROR");
		}
		
		
	    return hashmap; 
	}
	@PostMapping("/dash/saveWidgetOrderCustomization.do")
	public @ResponseBody void saveIntegrateWidgetOrderCustomization(
			@RequestParam(value = "integrateWidgetOrder[]", required = false) List<String> integrateWidgetOrder,
			@RequestParam(value = "clusterWidgetOrder[]", required = false) List<String> clusterWidgetOrder,
			HttpSession session) { 
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		String strIntegrateWidgetOrder = null;
		String strClusterWidgetOrder = null;
		if(integrateWidgetOrder != null) {
			try {
				for(int i=0; i<integrateWidgetOrder.size();i++) {
					if(i == 0) {
						strIntegrateWidgetOrder = "";
						strIntegrateWidgetOrder += integrateWidgetOrder.get(i);
					}else {
						strIntegrateWidgetOrder += ","+integrateWidgetOrder.get(i);
					}
				}
				dashboardService.updateIntegrateWidgetOrderCustomization(strIntegrateWidgetOrder,loginInfo.getsUserID());
			} catch (Exception e) {
				LOG.warn(e+"saveWidgetOrderCustomization #1 ERROR");
			}
		}else {
		}
		if(clusterWidgetOrder != null) {
			try {
				for(int i=0; i<clusterWidgetOrder.size();i++) {
					if(i == 0) {
						strClusterWidgetOrder = "";
						strClusterWidgetOrder += clusterWidgetOrder.get(i);
					}else {
						strClusterWidgetOrder += ","+clusterWidgetOrder.get(i);
					}
				}
				dashboardService.updateClusterWidgetOrderCustomization(strClusterWidgetOrder,loginInfo.getsUserID());
			} catch (Exception e) {
				LOG.warn(e+" saveWidgetOrderCustomization #2 ERROR");
			}
		}else {
		}
	}
	
	@RequestMapping("/dash/selectWidgetOrderList.do")
	public @ResponseBody HashMap<String, Object> selectWidgetOrderList(HttpSession session) {
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		try {
			List<DashboardVO> result = dashboardService.selectWidgetOrderList(loginInfo.getsUserID());
			if(result != null) {
				hashmap.put("getIntegrateWidgetOrder", result.get(0).getIntegrateWidgetOrder()); 
				hashmap.put("getclusterWidgetOrder", result.get(0).getClusterWidgetOrder());
			}else {
				hashmap.put("getIntegrateWidgetOrder", null); 
				hashmap.put("getclusterWidgetOrder", null);
			}
		}catch (NullPointerException e) {
			// TODO: handle exception
		}catch (Exception e) {
			LOG.warn(e+" selectWidgetOrderList #1 ERROR");
		}
	    return hashmap; 
	}
	
	@RequestMapping("/dash/getNSXTClusterList.do")
	public @ResponseBody List<DashboardVO> getNSXTClusterList() {
		List<DashboardVO> result = null;
		try {
			result = dashboardService.getNSXTClusterList();
		} catch (Exception e) {
			LOG.warn(e+" getNSXTClusterList #1 ERROR");
		}
	    return result; 
	}
}
