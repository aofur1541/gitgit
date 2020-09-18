package com.kdis.PROM.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdis.PROM.user.dao.UserDAO;
import com.kdis.PROM.user.vo.DepartmentVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 회사 Service 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class UserServiceImpl implements UserService {

	/** 사용자 DAO */
	@Autowired
	UserDAO userDAO;
	
	/**
	 * 사용자 목록 조회
	 * 
	 * @param userVO 검색 조건
	 * @return
	 */
	@Override
	public List<UserVO> selectUserList(UserVO userVO) {
		return userDAO.selectUserList(userVO);
	}
	
	/**
	 * 사용자 정보 조회
	 * 
	 * @param userVO 검색 조건
	 * @return
	 */
	@Override
	public UserVO selectUser(UserVO userVO) {
		return userDAO.selectUser(userVO);
	}
	
	/**
	 * 사용자 고유번호로 사용자 정보 조회
	 * 
	 * @param id 사용자 고유번호
	 * @return
	 */
	@Override
	public UserVO selectUserById(int id) {
		UserVO userVO = new UserVO();
		userVO.setId(id);
		return userDAO.selectUser(userVO);
	}
	
	/**
	 * 사용자 아이디로 사용자 정보 조회
	 * 
	 * @param sUserId 사용자 아이디
	 * @return
	 */
	@Override
	public UserVO selectUserBySUserID(String sUserID) {
		UserVO userVO = new UserVO();
		userVO.setsUserID(sUserID);
		return userDAO.selectUser(userVO);
	}
	
	/**
	 * 사용자가 속한 테넌트에 속한 다른 사용자 목록 조회(본인 제외)
	 * 
	 * @param id 사용자 고유번호
	 * @return
	 */
	public List<UserVO> selectUserTenantMembersList(int id) {
		UserVO userVO = new UserVO();
		userVO.setId(id);
		return userDAO.selectUserTenantMembersList(userVO);
	}
	
	/**
	 * 부서 목록에 속한 사용자 목록 조회 
	 * 
	 * @param companyId 회사 고유번호
	 * @param deptList 부서 목록
	 * @param notApproval 목록에서 제외할 승인(권한)
	 * @return
	 */
	public List<UserVO> selectUserListByDepartmentList(int companyId, List<DepartmentVO> deptList, int notApproval) {
		UserVO userVO = new UserVO();
		userVO.setsCompany(companyId);
		userVO.setParamDeptList(deptList);
		userVO.setParamNotApproval(notApproval);
		return userDAO.selectUserListByDepartmentList(userVO);
	}
	
	/**
	 * 해당 테넌트에 속한 사용자 목록 조회
	 * 
	 * @param nTenantId 테넌트 고유번호
	 * @return
	 */
	public List<UserVO> selectUserTenantMappingList(Integer nTenantId) {
		UserVO userVO = new UserVO();
		userVO.setnTenantId(nTenantId);
		return userDAO.selectUserTenantMappingList(userVO);
	}
	
	/**
	 * 아이디로 사용자 수 조회
	 * 
	 * @param sUserId 아이디
	 * @return
	 */
	@Override
	public int countUserBySUserID(String sUserID) {
		return userDAO.countUserBySUserID(sUserID);
	}
	
	/**
	 * 테넌트 고유번호로 사용자 수 조회
	 * 
	 * @param nTenantId 테넌트 고유번호
	 * @return
	 */
	@Override
	public int countUserByNTenantId(Integer nTenantId) {
		return userDAO.countUserByNTenantId(nTenantId);
		
	}
	
	/**
	 * 서비스 고유번호로 사용자 수 조회
	 * 
	 * @param nServiceId 서비스 고유번호
	 * @return
	 */
	public int countUserByNServiceId(Integer nServiceId) {
		return userDAO.countUserByNServiceId(nServiceId);
	}
	
	/**
	 * 해당 부서에 속한 사용자 수 조회
	 * 
	 * @param sCompany
	 * @param sDepartment
	 * @return
	 */
	public int countUserByDeptId(Integer sCompany, String sDepartment) {
		UserVO userVO = new UserVO();
		userVO.setsCompany(sCompany);
		userVO.setsDepartment(sDepartment);
		return userDAO.countUserByDeptId(userVO);
	}
	
	/**
	 * 사용자 등록
	 * 
	 * @param userVO 사용자 정보
	 * @return
	 */
	@Override
	@Transactional
	public int insertUser(UserVO userVO) {
		return userDAO.insertUser(userVO);
	}
	
	/**
	 * 사용자 수정
	 * 
	 * @param userVO 사용자 정보
	 * @return
	 */
	@Override
	@Transactional
	public int updateUser(UserVO userVO) {
		return userDAO.updateUser(userVO);
	}
	
	/**
	 * 사용자 비밀번호 변경
	 * 
	 * @param userVO 사용자 정보
	 * @return
	 */
	@Override
	@Transactional
	public int updateUserPassword(UserVO userVO) {
		return userDAO.updateUserPassword(userVO);
	}
	
	/**
	 * 최종 로그인 일시 현재 시간으로 변경
	 * 
	 * @param id 사용자 고유번호
	 * @return
	 */
	@Override
	@Transactional
	public int updateLastLoginDate(int id) {
		return userDAO.updateLastLoginDate(id);
	}
	
	/**
	 * 사용자 테넌트 수정
	 * 
	 * @param id 사용자 고유번호
	 * @param nTenantId 테넌트 고유번호
	 * @return
	 */
	public int updateUserTenant(int id, Integer nTenantId) {
		UserVO userVO = new UserVO();
		userVO.setId(id);
		userVO.setnTenantId(nTenantId);
		return userDAO.updateUserTenant(userVO);
	}
	
	/**
	 * 사용자 서비스 수정
	 * 
	 * @param id 사용자 고유번호
	 * @param nTenantId 테넌트 고유번호
	 * @param nServiceId 서비스 고유번호
	 * @return
	 */
	public int updateUserService(int id, Integer nTenantId, Integer nServiceId) {
		UserVO userVO = new UserVO();
		userVO.setId(id);
		userVO.setnTenantId(nTenantId);
		userVO.setnServiceId(nServiceId);
		return userDAO.updateUserService(userVO);
	}
	
	/**
	 * 사용자 삭제
	 * 
	 * @param id 사용자 고유번호
	 * @return
	 */
	@Override
	@Transactional
	public int deleteUser(int id) {
		return userDAO.deleteUser(id);
	}
	
	/**
	 * 사용자 테넌트 매핑 등록(delete & insert)
	 * 기존에 등록된 테넌트는 다 지우고 nTenantIds 를 다 추가함
	 * 
	 * @param id 사용자 고유번호
	 * @param nTenantId 배치된 테넌트 목록
	 * @return
	 */
	@Override
	@Transactional
	public void insertUserTenantMapping(int id, Integer[] nTenantIds) {
		
		// 우선 기존에 등록된 테넌트를 지운다
		userDAO.deleteUserTenantMappingByUserId(id);
		
		// 이번에 배치된 테넌트를 전부 등록한다.
		if(nTenantIds != null && nTenantIds.length > 0) {
			UserVO userVO = new UserVO();
			userVO.setId(id);
			for(Integer tenantId : nTenantIds) {
				userVO.setnTenantId(tenantId);
				
				userDAO.insertUserTenantMapping(userVO);
			}
		}
	}

	@Override
	public UserVO selectUserByADid(String adID) {
		UserVO userVO = new UserVO();
		userVO.setsEmailAddress(adID);
		System.out.println(userVO.getsEmailAddress());
		return userDAO.selectauthUser(userVO);
	}
	
}
