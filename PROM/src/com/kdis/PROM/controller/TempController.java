package com.kdis.PROM.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TempController {
	
	// 인프라 관리 - scale
	@RequestMapping("scale/autoScaleUp.prom")
	public String autoScaleUp() {
		return "scale/autoScaleUp";
	}
	
	@RequestMapping("scale/manualScaleOut.prom")
	public String manualScaleOut() {
		return "scale/manualScaleOut";
	}
	
	@RequestMapping("scale/autoScaleOut.prom")
	public String autoScaleOut() {
		return "scale/autoScaleOut";
	}
	
	// 샘플 이미지 사용, 미팅 후 삭제
	@RequestMapping("dash/rackDashboard.prom") 
	public String rackDashboard() { 
		return "dash/rackDashboard"; 
	}
	
	// 성능 - 일반 - 네트워크
	@RequestMapping("performance/networkPerformance.prom")
	public String networkPerformance() {
		return "performance/networkPerformance";
	}
	
}
