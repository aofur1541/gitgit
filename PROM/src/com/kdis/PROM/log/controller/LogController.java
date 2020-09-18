package com.kdis.PROM.log.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.log.vo.LogVO;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 감사 이력 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class LogController {

	/**
	 * 이력 서비스
	 */
	@Autowired
	private LogService logService;
	
	/**
	 * 감사 이력 > 관리자 > 접속 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/log/adminLoginLog.prom")
	public String adminLoginLog() {
		return "log/adminLoginLog";
	}
		
	/**
	 * 감사 이력 > 사용자 > 접속 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/log/userLoginLog.prom")
	public String userLoginLog() {
		return "log/userLoginLog";
	}
	
	/**
	 * 감사 이력 > 관리자 > 작업 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/log/adminLog.prom")
	public String adminLog() {
		return "log/adminLog";
	}
			
	/**
	 * 감사 이력 > 사용자 > 작업 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/log/userLog.prom")
	public String userLog() {
		return "log/userLog";
	}
	
	/**
	 * 감사 이력 > 신청 승인 이력 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/log/applyApprovalLog.prom")
	public String applyApprovalLog() {
		return "log/applyApprovalLog";
	}
	
	/**
	 * 관리자(슈퍼 관리자, 인프라 관리자, 테넌트 관리자, 관제 OP) 접속 이력 목록 조회
	 * 
	 * @return
	 */
	@RequestMapping("/log/selectAdminConnectLogList.do")
	public @ResponseBody List<LogVO> selectAdminConnectLogList() {
		// 관리자의 로그인, 로그아웃 이력 목록 조회
		List<LogVO> result = logService.selectAdminConnectLogList();
		return result;
	}
	
	/**
	 * 사용자 접속 이력 목록 조회
	 * 
	 * @return
	 */
	@RequestMapping("/log/selectUserConnectLogList.do")
	public @ResponseBody List<LogVO> selectUserConnectLogList() {
		// 사용자의 로그인, 로그아웃 이력 목록 조회
		List<LogVO> result = logService.selectUserConnectLogList();
		return result;
	}
	
	/**
	 * 관리자 작업 이력 목록 조회
	 * 
	 * @return
	 */
	@RequestMapping("/log/selectAdminWorkLogList.do")
	public @ResponseBody List<LogVO> selectAdminWorkLogList() {
		// 관리자의 작업(접속, 승인 관련 제외) 이력 목록 조회
		List<LogVO> result = logService.selectAdminWorkLogList();
		return result;
	}
	
	/**
	 * 사용자 작업 이력 목록 조회
	 * 
	 * @return
	 */
	@RequestMapping("/log/selectUserWorkLogList.do")
	public @ResponseBody List<LogVO> selectUserWorkLogList() {
		// 사용자의 작업(접속, 승인 관련 제외) 이력 목록 조회
		List<LogVO> result = logService.selectUserWorkLogList();
		return result;
	}
	
	/**
	 * 신청 승인 이력 목록 조회
	 * 
	 * @return
	 */
	@RequestMapping("/log/selectApproveLogList.do")
	public @ResponseBody List<LogVO> selectApproveLogList() {
		// 모든 사용자 의 승인 이력 목록 조회
		List<LogVO> result = logService.selectApproveLogList();
		return result;
	}
	
	/**
	 * 사용자 신청 승인 이력 목록 조회
	 * 
	 * @return
	 */
	@RequestMapping("/log/selectUserApplyLogList.do")
	public @ResponseBody List<LogVO> selectUserApplyLogList(HttpSession session) {
		// 세션에서 로그인 정보 얻기
		UserVO sessionInfo = LoginSessionUtil.getLoginInfo(session);
		
		// 해당 사용자가 속한 테넌트의 사용자들의 승인 이력 목록 조회
		List<LogVO> result = logService.selectApproveLogListByUserId(sessionInfo.getId());
		return result;
	}
	
}
