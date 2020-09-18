package com.kdis.PROM.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 공통 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class CommonController {

	/**
	 * 경고(에러) 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/common/alert.do")
	public String alert() {
		return "/common/alert";
	}
	
}
