package com.kdis.PROM.log.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.log.vo.VMGeneratingVO;

/**
 * 가상머신 이력 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class VMLogController {

	/**
	 * 이력 서비스
	 */
	@Autowired
	private LogService logService;
	
	/**
	 * 감사 이력 > 가상머신 이력 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/log/vmLog.prom")
	public String vmLog() {
		return "log/vmLog";
	}
	
	/**
	 * 가상머신 이력 목록 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/log/selectVMLogList.do")
	public List<VMGeneratingVO> selectVMLogList(VMGeneratingVO vmGeneratingVO) {
		List<VMGeneratingVO> result = logService.selectVMLogList(vmGeneratingVO);
		return result;
	}
	
	/**
	 * 시작된지 15분 동안 상태가 아직 '진행중'인 이력을 '비정상 종료'로 수정
	 */
	@ResponseBody
	@RequestMapping("/log/updateVMLogNoProgress.do")
	public void updateVMLogNoProgress() {
		logService.updateVMLogNoProgress();
	}	
			
	/**
	 * 가상 머신 이력 에러체크 확인으로 수정
	 */
	@ResponseBody
	@RequestMapping("/log/updateVMLogErrorCheckConfirm.do")
	public void updateVMLogErrorCheckConfirm() {
		// 완료 상태가 2(실패?), 3(비정상종료)인 로그의 에러 구분자(errorCheck)를 1로 수정  
		logService.updateVMLogErrorCheckConfirm();
	}
	
	/**
	 * 가상 머신 이력 중에 생성, 변경 진행중인 로그 개수 조회
	 * 
	 * @return
	 */
	@RequestMapping("/log/countProgressVMLog.do")
	public @ResponseBody VMGeneratingVO countProgressVMLog() {
		VMGeneratingVO result = logService.countProgressVMLog();
		return result;
	}
	
	/**
	 * 미확인 가상 머신 에러 이력 개수 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/log/countErrorVMLog.do")
	public int countErrorVMLog() {
		int result = logService.countErrorVMLog();
		return result;
	}
}
