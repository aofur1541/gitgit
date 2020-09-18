package com.kdis.PROM.log.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.log.vo.VCenterAlertVO;

/**
 * 감사 이력 > vCenter 통합 로그 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class VCenterLogController {

	/**
	 * 이력 서비스
	 */
	@Autowired
	private LogService logService;
	
	/**
	 * 감사 이력 > vCenter 통합 로그 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/log/vCenterLog.prom")
	public String vCenterLog() {
		return "log/vCenterLog";
	}
	
	/**
	 * vCenter 통합 로그 목록 조회
	 * 
	 * @return
	 */
	@RequestMapping("/log/selectVCenterLogList.do")
	public @ResponseBody List<VCenterAlertVO> selectVCenterLogList(){
		
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
		Date currentTime = new Date();
		String mTime = mSimpleDateFormat.format (currentTime);
		
		List<VCenterAlertVO> vCenterLogList = logService.selectVCenterLogList();
		
		// 오늘 발생한 미확인은  화면에 강조해서 표시하도록 한다.
		for(VCenterAlertVO logVO : vCenterLogList) {
			// vCenter 이력의 일시(yyyy-MM-dd) 얻기
			String alertDate = "";
			if(logVO.getdAlertTime() != null && logVO.getdAlertTime().length() >= 10) {
				alertDate = logVO.getdAlertTime().substring(0,10);
			}
			
			if(mTime.equals(alertDate) && logVO.getnAlertCheck() == 0) {
				logVO.setnAlertCheck(2);
			}
		}
		return vCenterLogList;
	}
	
	/**
	 * 오늘 발생한 미확인 vCenter 이력 개수 조회
	 * 
	 * @return
	 */
	@RequestMapping("/log/countTodayVCenterLog.do")
	public @ResponseBody int countTodayVCenterLog() {
		int todayVCenterLogCount = logService.countTodayVCenterLog();
		return todayVCenterLogCount;
	}

	/**
	 * vCenter 이력의 경고 확인 여부를 확인(1)으로 변경
	 * 
	 * @param vcAlertPK
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/log/updateVCenterAlertConfirm.do")
	public int updateVCenterAlertConfirm(String vcAlertPK) {
		int result = 0;
		result = logService.updateVCenterAlertConfirm(vcAlertPK);
		return result;
	}
	
}
