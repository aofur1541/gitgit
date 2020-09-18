package com.kdis.PROM.approval.service;

import java.util.List;

import com.kdis.PROM.approval.vo.UserPWResetVO;

/**
 * 비밀번호 초기화 서비스 interface
 * 
 * @author KimHahn
 *
 */
public interface UserPWResetService {

	/**
	 * 비밀번호 초기화 요청 목록 조회
	 * 
	 * @return
	 */
	public List<UserPWResetVO> selectUserPWResetList();
	
	/**
	 * 비밀번호 초기화 신청 등록
	 * 
	 * @param sUserID 사용자 아이디
	 * @param nNumber 사번
	 * @return
	 */
	public int insertUserPWReset(String sUserID, String nNumber);
	
	/**
	 * 비밀번호 초기화 승인
	 * 
	 * @param resetNum 비밀번호 초기화  고유번호
	 * @param id 사용자 고유번호
	 * @param sUserID 사용자 아이디
	 * @return
	 */
	public int approveUserPWReset(int resetNum, int id, String sUserID);
	
	/**
	 * 비밀번호 초기화 반려
	 * 
	 * @param resetNum 비밀번호 초기화  고유번호
	 * @param pwResetComment 코멘트
	 * @return
	 */
	public int rejectUserPWReset(int resetNum, String pwResetComment);
	
}
