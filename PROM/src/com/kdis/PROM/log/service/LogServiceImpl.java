package com.kdis.PROM.log.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.kdis.PROM.log.dao.LogDAO;
import com.kdis.PROM.log.vo.LogVO;
import com.kdis.PROM.log.vo.VCenterAlertVO;
import com.kdis.PROM.log.vo.VMGeneratingVO;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 이력 Service 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class LogServiceImpl implements LogService {

	/** 이력 DAO */
	@Autowired
	LogDAO logDAO;
	
	/**
	 * 사용자 로그인, 로그아웃 이력 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<LogVO> selectUserConnectLogList() {
		return logDAO.selectUserConnectLogList();
	}
	
	/**
	 * 관리자 로그인, 로그아웃 이력 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<LogVO> selectAdminConnectLogList() {
		return logDAO.selectAdminConnectLogList();
	}
	
	/**
	 * 사용자  작업 (로그인, 로그아웃, 승인 관련 제외) 이력 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<LogVO> selectUserWorkLogList() {
		return logDAO.selectUserWorkLogList();
	}
	
	/**
	 * 관리자 작업(로그인, 로그아웃, 승인 관련 제외) 이력 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<LogVO> selectAdminWorkLogList() {
		return logDAO.selectAdminWorkLogList();
	}
	
	/**
	 * 승인 이력 목록 조회
	 * 
	 * @param approval
	 * @return
	 */
	@Override
	public List<LogVO> selectApproveLogList() {
		return logDAO.selectApproveLogList();
	}
	
	/**
	 * 해당 사용자가 속한 테넌트의 사용자들의 승인 이력 목록 조회
	 * 
	 * @param userId
	 * @return
	 */
	@Override
	public List<LogVO> selectApproveLogListByUserId(int userId) {
		return logDAO.selectApproveLogListByUserId(userId);
	}
	
	/**
	 * 이력 등록
	 * 
	 * @param logVO 이력 정보
	 * @return
	 */
	@Override
	@Transactional
	public int insertLog(LogVO logVO) {
		return logDAO.insertLog(logVO);
	}
	
	/**
	 * 이력 등록(이력 받는사람은 로그인 아이디로 자동 설정)
	 *  
	 * @param nCategory 이력 구분자 
	 * @param sContext 이력 내용 
	 * @param sTarget 이력 상세 구분자 
	 * @param sKeyword 이력 구분자(문자열) 
	 */
	@Override
	public void insertLog(String sReceive, int nCategory, String sContext, String sTarget, String sKeyword) {

		// 이력 내용은 512자까지만 입력 가능하다.
		// 512자 이상인 경우는 512자까지만 입력한다.
		if(sContext != null && sContext.length() > 512) {
			sContext = sContext.substring(0, 512);
		}
		
		LogVO logVO = new LogVO();

		logVO.setsReceive(sReceive);
		logVO.setnCategory(nCategory);
		logVO.setsContext(sContext);
		logVO.setsTarget(sTarget);
		logVO.setsKeyword(sKeyword);

		this.insertLog(logVO);
	}
	
	/**
	 * 이력 등록
	 * 
	 * @param nCategory 이력 구분자 
	 * @param sContext 이력 내용 
	 * @param sTarget 이력 상세 구분자 
	 * @param sKeyword 이력 구분자(문자열) 
	 */
	@Override
	public void insertLog(int nCategory, String sContext, String sTarget, String sKeyword) {
		
		// 세션 얻기
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
	    HttpSession httpSession = servletRequestAttribute.getRequest().getSession(true);
		
	    // 로그인 정보 얻기
	 	UserVO loginInfo = LoginSessionUtil.getLoginInfo(httpSession);
	    
		this.insertLog(loginInfo.getsUserID(), nCategory, sContext, sTarget, sKeyword);
	}
	
	/**
	 * 가상 머신 이력 조회
	 * 
	 * @param vmGeneratingVO
	 * @return
	 */
	@Override
	public List<VMGeneratingVO> selectVMLogList(VMGeneratingVO vmGeneratingVO) {
		
		// 세션에서 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		vmGeneratingVO.setUserId(loginInfo.getId());
		
		return logDAO.selectVMLogList(vmGeneratingVO);
	}
	
	/**
	 * 가상 머신 이력 중에 생성, 변경 진행중인 로그 개수 조회
	 * 
	 * @return
	 */
	@Override
	public VMGeneratingVO countProgressVMLog() {
		return logDAO.countProgressVMLog();
	}
	
	/**
	 * 미확인 가상 머신 에러 이력 개수 조회
	 * 
	 * @return
	 */
	@Override
	public int countErrorVMLog() {
		return logDAO.countErrorVMLog();
	}
	
	/**
	 * 가상 머신 이력 에러체크 확인으로 수정
	 * 완료 상태가 2(실패?), 3(비정상종료)인 로그의 에러 구분자(errorCheck)를 1로 수정 
	 */
	@Override
	@Transactional
	public void updateVMLogErrorCheckConfirm() {
		logDAO.updateVMLogErrorCheckConfirm();
	}
	
	/**
	 * 시작된지 15분 동안 상태가 아직 '진행중'인 이력을 '비정상 종료'로 수정
	 */
	@Override
	@Transactional
	public void updateVMLogNoProgress() {
		logDAO.updateVMLogNoProgress();
	}
	
	/**
	 * vCenter 이력 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<VCenterAlertVO> selectVCenterLogList() {
		return logDAO.selectVCenterLogList();
	}
	
	/**
	 * 오늘 발생한 미확인 vCenter 이력 개수 조회
	 * 
	 * @return
	 */
	@Override
	public int countTodayVCenterLog() {
		return logDAO.countTodayVCenterLog();
	}
	
	/**
	 * vCenter 이력의 경고 확인 여부를 확인(1)으로 변경
	 * 
	 * @param vcAlertPK
	 * @return
	 */
	@Override
	@Transactional
	public int updateVCenterAlertConfirm(String vcAlertPK) {
		return logDAO.updateVCenterAlertConfirm(vcAlertPK);
	}
	
	/**
	 * vCenter 모든 이력의 경고 확인 여부를 미확인(0)으로 변경
	 * 
	 * @param vcAlertPK
	 * @return
	 */
	@Override
	@Transactional
	public void updateVCenterAlertAllReset() {
		logDAO.updateVCenterAlertAllReset();
	}
	
}
