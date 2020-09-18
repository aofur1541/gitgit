package com.kdis.PROM.user.dao;

import java.util.List;

import com.kdis.PROM.user.vo.UserVO;

/**
 * 사용자 DAO interface
 * 
 * @author KimHahn
 *
 */
public interface UserDAO {

	/**
	 * 사용자 목록 조회
	 * 
	 * @param userVO 검색 조건
	 * @return
	 */
	public List<UserVO> selectUserList(UserVO userVO);
	
	/**
	 * 사용자 정보 조회
	 * 
	 * @param userVO 검색 조건
	 * @return
	 */
	public UserVO selectUser(UserVO userVO);
	
	/**
	 * 사용자가 속한 테넌트에 속한 다른 사용자 목록 조회(본인 제외)
	 * 
	 * @param userVO 검색 조건
	 * @return
	 */
	public List<UserVO> selectUserTenantMembersList(UserVO userVO);
	
	/**
	 * 부서 목록에 속한 사용자 목록 조회 
	 * 
	 * @param userVO 검색 조건
	 * @return
	 */
	public List<UserVO> selectUserListByDepartmentList(UserVO userVO);
	
	/**
	 * 해당 테넌트에 속한 사용자 목록 조회
	 * 
	 * @param userVO 검색 조건
	 * @return
	 */
	public List<UserVO> selectUserTenantMappingList(UserVO userVO);
	
	/**
	 * 아이디로 사용자 수 조회
	 * 
	 * @param sUserID 아이디
	 * @return
	 */
	public int countUserBySUserID(String sUserID);
	
	/**
	 * 테넌트 고유번호로 사용자 수 조회
	 * 
	 * @param nTenantId 테넌트 고유번호
	 * @return
	 */
	public int countUserByNTenantId(Integer nTenantId);
	
	/**
	 * 서비스 고유번호로 사용자 수 조회
	 * 
	 * @param nServiceId 서비스 고유번호
	 * @return
	 */
	public int countUserByNServiceId(Integer nServiceId);
	
	/**
	 * 해당 부서에 속한 사용자 수 조회
	 * 
	 * @param userVO 검색 조건
	 * @return
	 */
	public int countUserByDeptId(UserVO userVO);
	
	/**
	 * 사용자 등록
	 * 
	 * @param userVO 사용자 정보
	 * @return
	 */
	public int insertUser(UserVO userVO);
	
	/**
	 * 사용자 수정
	 * 
	 * @param userVO 사용자 정보
	 * @return
	 */
	public int updateUser(UserVO userVO);
	
	/**
	 * 사용자 비밀번호 변경
	 * 
	 * @param userVO 사용자 정보
	 * @return
	 */
	public int updateUserPassword(UserVO userVO);
	
	/**
	 * 최종 로그인 일시 현재 시간으로 변경
	 * 
	 * @param id 사용자 고유번호
	 * @return
	 */
	public int updateLastLoginDate(int id);
	
	/**
	 * 사용자 테넌트 수정
	 * 
	 * @param userVO 사용자 정보
	 * @return
	 */
	public int updateUserTenant(UserVO userVO);
	
	/**
	 * 사용자 서비스 수정
	 * 
	 * @param userVO 사용자 정보
	 * @return
	 */
	public int updateUserService(UserVO userVO);
	
	/**
	 * 사용자 삭제
	 * 
	 * @param id 사용자 고유번호
	 * @return
	 */
	public int deleteUser(int id);
	
	/**
	 * 사용자 테넌트 매핑 등록
	 * 
	 * @param userVO
	 * @return
	 */
	public int insertUserTenantMapping(UserVO userVO);
	
	/**
	 * 사용자 테넌트 매핑 삭제
	 * 
	 * @param id 사용자 고유번호
	 * @return
	 */
	public int deleteUserTenantMappingByUserId(int id);
	
	/**
	 *  by kkp
	 * @param userVO
	 * @return 현대 OTP ,AD 인증
	 */
	public UserVO selectauthUser(UserVO userVO);
	
}
