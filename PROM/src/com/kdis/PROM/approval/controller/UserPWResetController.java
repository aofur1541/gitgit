package com.kdis.PROM.approval.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.approval.service.UserPWResetService;
import com.kdis.PROM.approval.vo.UserPWResetVO;
import com.kdis.PROM.common.CommonUtil;
import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.log.vo.LogVO;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.user.service.UserService;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 비밀번호 초기화 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class UserPWResetController {
	
	private static final Log LOG = LogFactory.getLog( UserPWResetController.class );

	/** 비밀번호 초기화 서비스 */
	@Autowired
	UserPWResetService userPWResetService;
	
	/** 사용자 service */
	@Autowired
    private UserService userService; 
	
	/** 이력 service */
	@Autowired
	private LogService logService;
	
	/**
	 * 승인 > 비밀번호 초기화 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/approval/approvalResetPassword.prom")
	public String approvalResetPassword() {
		return "approval/approvalResetPassword";
	}
	
	/**
	 * 비밀번호 초기화 요청 목록 조회
	 * 
	 * @return
	 */
	@RequestMapping("/approval/selectUserPWResetList.do")
	public @ResponseBody List<UserPWResetVO> selectUserPWResetList() {
		List<UserPWResetVO> result = userPWResetService.selectUserPWResetList();
		return result;
	}
	
	/**
	 * 비밀번호 초기화 승인
	 * 
	 * @param userPWResetVO
	 * @param session
	 * @return
	 */
	@RequestMapping("/approval/approveUserPWReset.do")
	public @ResponseBody int approveUserPWReset(UserPWResetVO userPWResetVO, HttpSession session) {
		
		int resetNum = userPWResetVO.getResetNum();
		int id = userPWResetVO.getId();
		String sUserID = userPWResetVO.getsUserID();
		
		// 비밀번호 초기화 승인
		int result = userPWResetService.approveUserPWReset(resetNum, id, sUserID);
		
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);

		// 로그 기록
		String sContext = "[" + sUserID + "] 초기화 승인";
		logService.insertLog(loginInfo.getsUserID(), 2, sContext, "비밀번호", "Approval");

		return result;
	}
	
	/**
	 * 비밀번호 초기화 반려
	 * 
	 * @param userPWResetVO
	 * @param session
	 * @return
	 */
	@RequestMapping("/approval/rejectUserPWReset.do")
	public @ResponseBody int rejectUserPWReset(UserPWResetVO userPWResetVO, HttpSession session) {
		
		int resetNum = userPWResetVO.getResetNum();
		String sUserID = userPWResetVO.getsUserID();
		String pwResetComment = userPWResetVO.getPwResetComment();
		
		int result = userPWResetService.rejectUserPWReset(resetNum, pwResetComment);
		
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);

		// 로그 기록
		String sContext = "[" + sUserID + "] 초기화 반려";
		logService.insertLog(loginInfo.getsUserID(), 2, sContext, "비밀번호", "Return");
		
		return result;
	}

	/**
	 * 비밀번호 초기화 신청
	 * 
	 * - 0 : 사용자ID, 사원코드 불일치
	 * - 1 : 성공
	 * - 5 : 예외 발생
	 * 
	 * @param sUserID 사용자 ID
	 * @param nNumber 사원코드
	 * @return
	 */
	@RequestMapping(value="/approval/applyPasswordReset.do", method=RequestMethod.POST)
	public @ResponseBody int applyPasswordReset(String sUserID, String nNumber) {
		
		// 결과 코드
		int result = 0;
		
		try {
			// 사용자 정보 얻기
			UserVO dbUser = userService.selectUserBySUserID(sUserID);
			
			// 사원코드 확인
			if (CommonUtil.isEmpty(nNumber) || !nNumber.equals(dbUser.getnNumber())) {
				// 사원코드 불일치
				result = 0;
				return result;
			}
			
			// 비밀번호 초기화 신청 등록
			userPWResetService.insertUserPWReset(sUserID, nNumber);
			
			// 비밀번호 초기화 로그 기록
			LogVO notification = new LogVO();
			String sContext = "[" + sUserID + "]" + " 초기화 신청";
			notification.setsContext(sContext);
			notification.setsReceive(sUserID);
			notification.setnCategory(2);
			notification.setsKeyword("Request");
			notification.setsTarget("비밀번호");
			logService.insertLog(notification);
			
			// 비밀번호 초기화 신청 성공
			result = 1;
			
		} catch (Exception e) {
			// 예외 발생
			LOG.error(e);
			result = 5;
		}
		return result;
	}
	
}
