package com.kdis.PROM.user.service;

import java.util.List;

import com.kdis.PROM.user.vo.DepartmentVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 회사 Service interface
 * 
 * @author KimHahn
 *
 */
public interface UserService {

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
	 * 사용자 고유번호로 사용자 정보 조회
	 * 
	 * @param id 사용자 고유번호
	 * @return
	 */
	public UserVO selectUserById(int id);
	
	/**
	 * 사용자 아이디로 사용자 정보 조회
	 * 
	 * @param sUserID 사용자 아이디
	 * @return
	 */
	public UserVO selectUserBySUserID(String sUserID);
	
	/**
	 * 사용자가 속한 테넌트에 속한 다른 사용자 목록 조회(본인 제외)
	 * 
	 * @param id 사용자 고유번호
	 * @return
	 */
	public List<UserVO> selectUserTenantMembersList(int id);
	
	/**
	 * 부서 목록에 속한 사용자 목록 조회 
	 * 
	 * @param companyId 회사 고유번호
	 * @param deptList 부서 목록
	 * @param notApproval 목록에서 제외할 승인(권한)
	 * @return
	 */
	public List<UserVO> selectUserListByDepartmentList(int companyId, List<DepartmentVO> deptList, int notApproval);
	
	/**
	 * 해당 테넌트에 속한 사용자 목록 조회
	 * 
	 * @param nTenantId 테넌트 고유번호
	 * @return
	 */
	public List<UserVO> selectUserTenantMappingList(Integer nTenantId);
	
	/**
	 * 아이디로 사용자 수 조회
	 * 
	 * @param sUserId 아이디
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
	 * @param sCompany
	 * @param sDepartment
	 * @return
	 */
	public int countUserByDeptId(Integer sCompany, String sDepartment);
	
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
	 * @param id 사용자 고유번호
	 * @param nTenantId 테넌트 고유번호
	 * @return
	 */
	public int updateUserTenant(int id, Integer nTenantId);
	
	/**
	 * 사용자 서비스 수정
	 * 
	 * @param id 사용자 고유번호
	 * @param nTenantId 테넌트 고유번호
	 * @param nServiceId 서비스 고유번호
	 * @return
	 */
	public int updateUserService(int id, Integer nTenantId, Integer nServiceId);
	
	/**
	 * 사용자 삭제
	 * 
	 * @param id 사용자 고유번호
	 * @return
	 */
	public int deleteUser(int id);
	
	/**
	 * 사용자 테넌트 매핑 등록(delete & insert)
	 * 기존에 등록된 테넌트는 다 지우고 nTenantIds 를 다 추가함
	 * 
	 * @param id 사용자 고유번호
	 * @param nTenantId 배치된 테넌트 목록
	 * @return
	 */
	public void insertUserTenantMapping(int id, Integer[] nTenantIds);
	
	
	
	public UserVO selectUserByADid(String adID);
	
	
	
}
