package com.kdis.PROM.dash.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.dash.service.DashboardService;
import com.kdis.PROM.dash.vo.DashboardVO;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.performance.service.PerformanceService;
import com.kdis.PROM.performance.vo.PerformanceVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 사용자 대시보드 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class UserDashboardController {
	
	/** 대시보드 서비스 */
	@Autowired
	private DashboardService dashboardService;
	
	/** 성능 서비스 */
	@Autowired
	private PerformanceService performanceService;
	
	/**
	 * 사용자 대시보드 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/dash/userDashboard.prom")
	public String userDashboard() {
		return "dash/userDashboard";
	}
	
	/**
	 * 사사용자가 속한 테넌트의 현황 얻기
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/dash/selectUserTenantStatus.do")
	public DashboardVO selectUserTenantStatus() {
		
		// 세션에서 로그인 정보 얻기
		UserVO sessionInfo = LoginSessionUtil.getLoginInfo();
				
		DashboardVO result = dashboardService.selectUserTenantStatus(sessionInfo.getId());
		return result;
	}
	
	/**
	 * 해당 서비스의 현황 얻기
	 * 
	 * @param serviceId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/dash/selectServiceStatus.do")
	public DashboardVO selectPerformanceRankListByServiceId(Integer serviceId) {

		// 서비스 현황 얻기
		DashboardVO dashboardVO = dashboardService.selectServiceStatus(serviceId);
		
		PerformanceVO performanceVO = new PerformanceVO();
		performanceVO.setServiceId(serviceId);
		
		// CPU TOP 5 얻기
		performanceVO.setOrder("cpu");
		List<PerformanceVO> cpuTop5List = performanceService.selectPerformanceRankListByServiceId(performanceVO);
		dashboardVO.setCpuTop5List(cpuTop5List);
		
		// Memory TOP 5 얻기
		performanceVO.setOrder("memory");
		List<PerformanceVO> memoryTop5List = performanceService.selectPerformanceRankListByServiceId(performanceVO);
		dashboardVO.setMemoryTop5List(memoryTop5List);
		
		// Disk TOP 5 얻기
		performanceVO.setOrder("disk");
		List<PerformanceVO> diskTop5List = performanceService.selectPerformanceRankListByServiceId(performanceVO);
		dashboardVO.setDiskTop5List(diskTop5List);
		
		// Network TOP 5 얻기
		performanceVO.setOrder("network");
		List<PerformanceVO> networkTop5List = performanceService.selectPerformanceRankListByServiceId(performanceVO);
		dashboardVO.setNetworkTop5List(networkTop5List);
		
		return dashboardVO;
	}
}
