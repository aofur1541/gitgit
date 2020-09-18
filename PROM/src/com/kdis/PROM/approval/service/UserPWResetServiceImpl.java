package com.kdis.PROM.approval.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdis.PROM.approval.dao.UserPWResetDAO;
import com.kdis.PROM.approval.vo.UserPWResetVO;
import com.kdis.PROM.common.SHA256Util;
import com.kdis.PROM.user.service.UserService;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 비밀번호 초기화 서비스 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class UserPWResetServiceImpl implements UserPWResetService {

	/** 비밀번호 초기화 DAO */
	@Autowired
	UserPWResetDAO userPWResetDAO;
	
	/** 사용자 서비스 */
	@Autowired
	UserService userService;
	
	/**
	 * 비밀번호 초기화 요청 목록 조회
	 * 
	 * @return
	 */
	public List<UserPWResetVO> selectUserPWResetList() {
		return userPWResetDAO.selectUserPWResetList();
	}
	
	/**
	 * 비밀번호 초기화 신청 등록
	 * 
	 * @param sUserID 사용자 아이디
	 * @param nNumber 사번
	 * @return
	 */
	@Override
	@Transactional
	public int insertUserPWReset(String sUserID, String nNumber) {
		UserPWResetVO userPWResetVO = new UserPWResetVO();
		userPWResetVO.setsUserID(sUserID);
		userPWResetVO.setnNumber(nNumber);
		return userPWResetDAO.insertUserPWReset(userPWResetVO);
	}
	
	/**
	 * 비밀번호 초기화 승인
	 * 
	 * @param resetNum 비밀번호 초기화  고유번호
	 * @return
	 */
	@Override
	@Transactional
	public int approveUserPWReset(int resetNum, int id, String sUserID) {
		
		// 비밀번호 초기화 신청의 상태를 승인으로 변경
		UserPWResetVO userPWResetVO = new UserPWResetVO();
		userPWResetVO.setResetNum(resetNum);
		userPWResetVO.setnApproval(1);//0:신청, 1:승인, 2:반려
		userPWResetDAO.updateUserPWResetApproval(userPWResetVO);
		
		// 사용자 비밀번호를 초기값)으로 변경
		// 초기화 비밀번호 : 사용자 아이디 + "2020!@"
		String resetPassword = sUserID+"2020!@";
		// 비밀번호 해시
		String hashedResetPassword = SHA256Util.hash(resetPassword);
		
		// 초기화 비밀번호로 비밀번호 변경
		UserVO userVO = new UserVO();
		userVO.setId(id);
		userVO.setsUserPW(hashedResetPassword);
		return userService.updateUserPassword(userVO);
	}
	
	/**
	 * 비밀번호 초기화 반려
	 * 
	 * @param resetNum 비밀번호 초기화  고유번호
	 * @param pwResetComment 코멘트
	 * @return
	 */
	@Override
	@Transactional
	public int rejectUserPWReset(int resetNum, String pwResetComment) {
		// 비밀번호 초기화 신청의 상태를 반려로 변경
		UserPWResetVO userPWResetVO = new UserPWResetVO();
		userPWResetVO.setResetNum(resetNum);
		userPWResetVO.setnApproval(2);//0:신청, 1:승인, 2:반려
		userPWResetVO.setPwResetComment(pwResetComment);
		return userPWResetDAO.updateUserPWResetApproval(userPWResetVO);
	}
	
}
