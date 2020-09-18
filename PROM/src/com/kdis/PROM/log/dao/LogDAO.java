package com.kdis.PROM.log.dao;

import java.util.List;

import com.kdis.PROM.log.vo.LogVO;
import com.kdis.PROM.log.vo.VCenterAlertVO;
import com.kdis.PROM.log.vo.VMGeneratingVO;

/**
 * 이력 DAO interface
 * 
 * @author KimHahn
 *
 */
public interface LogDAO {

	/**
	 * 사용자 로그인, 로그아웃 이력 목록 조회
	 * 
	 * @return
	 */
	public List<LogVO> selectUserConnectLogList();
	
	/**
	 * 관리자 로그인, 로그아웃 이력 목록 조회
	 * 
	 * @return
	 */
	public List<LogVO> selectAdminConnectLogList();
	
	/**
	 * 사용자  작업 (로그인, 로그아웃, 승인 관련 제외) 이력 목록 조회
	 * 
	 * @return
	 */
	public List<LogVO> selectUserWorkLogList();
	
	/**
	 * 관리자 작업(로그인, 로그아웃, 승인 관련 제외) 이력 목록 조회
	 * 
	 * @return
	 */
	public List<LogVO> selectAdminWorkLogList();
	
	/**
	 * 승인 이력 목록 조회
	 * 
	 * @param approval
	 * @return
	 */
	public List<LogVO> selectApproveLogList();
	
	/**
	 * 해당 사용자가 속한 테넌트의 사용자들의 승인 이력 목록 조회
	 * 
	 * @param userId
	 * @return
	 */
	public List<LogVO> selectApproveLogListByUserId(int userId);
	
	/**
	 * 이력 등록
	 * 
	 * @param logVO 이력 정보
	 * @return
	 */
	public int insertLog(LogVO logVO);
	
	/**
	 * 가상 머신 이력 조회
	 * 
	 * @param vmGeneratingVO
	 * @return
	 */
	public List<VMGeneratingVO> selectVMLogList(VMGeneratingVO vmGeneratingVO);
	
	/**
	 * 가상 머신 이력 중에 생성, 변경 진행중인 로그 개수 조회
	 * 
	 * @return
	 */
	public VMGeneratingVO countProgressVMLog();
	
	/**
	 * 미확인 가상 머신 에러 이력 개수 조회
	 * 
	 * @return
	 */
	public int countErrorVMLog();
	
	/**
	 * 가상 머신 이력 에러체크 확인으로 수정
	 * 완료 상태가 2(실패?), 3(비정상종료)인 로그의 에러 구분자(errorCheck)를 1로 수정 
	 */
	public void updateVMLogErrorCheckConfirm();
	
	/**
	 * 시작된지 15분 동안 상태가 아직 '진행중'인 이력을 '비정상 종료'로 수정
	 */
	public void updateVMLogNoProgress();
	
	/**
	 * vCenter 이력 목록 조회
	 * 
	 * @return
	 */
	public List<VCenterAlertVO> selectVCenterLogList();
	
	/**
	 * 오늘 발생한 미확인 vCenter 이력 개수 조회
	 * 
	 * @return
	 */
	public int countTodayVCenterLog();
	
	/**
	 * vCenter 이력의 경고 확인 여부를 확인(1)으로 변경
	 * 
	 * @param vcAlertPK
	 * @return
	 */
	public int updateVCenterAlertConfirm(String vcAlertPK);
	
	/**
	 * vCenter 모든 이력의 경고 확인 여부를 미확인(0)으로 변경
	 * 
	 * @param vcAlertPK
	 * @return
	 */
	public void updateVCenterAlertAllReset();
	
}
