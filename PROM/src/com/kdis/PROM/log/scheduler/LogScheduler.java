package com.kdis.PROM.log.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kdis.PROM.log.service.LogService;

/**
 * 이력 스케쥴러
 * 
 * @author KimHahn
 *
 */
@Service
public class LogScheduler {

	/**
	 * 이력 서비스
	 */
	@Autowired
	private LogService logService;
	
	/**
	 * 매일 23시 59분에 vCenter 모든 이력의 경고 확인 여부를 미확인(0)으로 변경
	 */
	//@Scheduled(fixedDelay = 60000)//테스트용(1분마다 실행) 
	@Scheduled(cron = "0 59 23 * * ?")//23시 59분에 실행
	public void updateVCenterAlertAllReset() {
		logService.updateVCenterAlertAllReset();
	}
}
