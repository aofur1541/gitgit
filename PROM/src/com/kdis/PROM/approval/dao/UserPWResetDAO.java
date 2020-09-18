package com.kdis.PROM.approval.dao;

import java.util.List;

import com.kdis.PROM.approval.vo.UserPWResetVO;

/**
 * 비밀번호 초기화 DAO interface
 * 
 * @author KimHahn
 *
 */
public interface UserPWResetDAO {

	/**
	 * 비밀번호 초기화 요청 목록 조회
	 * 
	 * @return
	 */
	public List<UserPWResetVO> selectUserPWResetList();

	/**
	 * 비밀번호 초기화 신청 등록
	 * 
	 * @param userPWResetVO
	 * @return
	 */
	public int insertUserPWReset(UserPWResetVO userPWResetVO);

	/**
	 * 비밀번호 승인 상태 수정
	 * 
	 * @param userPWResetVO
	 * @return
	 */
	public int updateUserPWResetApproval(UserPWResetVO userPWResetVO);
	
}
