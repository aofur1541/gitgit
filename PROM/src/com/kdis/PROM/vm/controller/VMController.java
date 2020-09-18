package com.kdis.PROM.vm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 인프라 > 가상머신  Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class VMController {

	/**
	 * 인프라 > 가상머신 > 가상머신 생성 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/vm/createVM.prom")
	public String createVM() {
		return "vm/createVM";
	}
	
	/**
	 * 인프라 > 가상머신 > 가상머신 설정 편집 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/vm/changeVM.prom")
	public String changeVM() {
		return "vm/changeVM";
	}
	
}
