package com.kdis.PROM.user.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.common.CommonUtil;
import com.kdis.PROM.common.Constants;
import com.kdis.PROM.common.SHA256Util;
import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.tenant.service.TenantService;
import com.kdis.PROM.tenant.service.VMServiceService;
import com.kdis.PROM.tenant.vo.TenantVO;
import com.kdis.PROM.user.service.DepartmentService;
import com.kdis.PROM.user.service.UserService;
import com.kdis.PROM.user.vo.DepartmentVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 기초 데이터 > 사용자 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class UserController {

	/** 사용자 service */
	@Autowired
    private UserService userService; 

	/** 부서 service */
	@Autowired
	private DepartmentService departmentService;

	/** 테넌트 service */
	@Autowired
    private TenantService tenantService; 
	
	/** 서비스 서비스 */
	@Autowired
	private VMServiceService vmServiceService;
	
	/** 이력 service */
	@Autowired
	private LogService logService;
	
	/**
	 * 기초 데이터 > 사용자 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/user/manageUser.prom")
	public String manageUser() {
		return "/user/manageUser";
	}
	
	/**
	 * 계정 관리 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/user/manageAccount.prom")
	public String manageAccount() {
		return "/user/manageAccount";
	}
	
	/**
	 * 사용자 목록 조회(로그인한 사용자와 슈퍼관리자 제외)
	 * 
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/user/selectUserList.do")
	public List<UserVO> selectUserList(HttpSession session) {

		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		// 로그인한 사용자와 슈퍼관리자를 제외한 사용자 목록을 조회한다.
		UserVO userVO = new UserVO();
		userVO.setParamNotApproval(Constants.SUPER_ADMIN_NUMBER);
		userVO.setParamNotId(loginInfo.getId());
		List<UserVO> result = userService.selectUserList(userVO);
		return result;
	}
	
	/**
	 * 사용자 정보 조회
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/user/selectUser.do")
	public UserVO selectUser(int id) {
		UserVO result = userService.selectUserById(id);
		return result;
	}
	
	/**
	 * 사용자 정보 얻기
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/user/selectUserBySUserID.do")
	public UserVO selectUserBySUserID(String sUserID){
		UserVO result = userService.selectUserBySUserID(sUserID);
		return result;
	}
	
	/**
	 * 로그인 사용자가 속한 테넌트에 속한 다른 사용자 목록 조회(로그인한 사용자 제외)
	 * 
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/user/selectUserTenantMembersList.do")
	public List<UserVO> selectUserTenantMembersList(HttpSession session) {
		
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		// 로그인 사용자가 속한 테넌트에 속한 다른 사용자 목록 조회(로그인한 사용자 제외)
		List<UserVO> result = userService.selectUserTenantMembersList(loginInfo.getId());
		return result;
	}
	
	/**
	 * 지정한 부서와 그 하위 부서에 소속된 사용자 목록 얻기
	 * 
	 * @param companyId
	 * @param deptId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/user/selectUserByDeptHierarchy.do")
	public List<UserVO> selectUserByDeptHierarchy(int companyId, String deptId){
		List<UserVO> result = new ArrayList<UserVO>();
		
		// 지정한 부서와 그 하위 부서 목록 얻기
		List<DepartmentVO> deptHierarchyList = departmentService.selectDeptHierarchyList(companyId, deptId);
		
		if(!deptHierarchyList.isEmpty()) {
			// 부서 목록에 속한 사용자 목록 조회 
			result = userService.selectUserListByDepartmentList(companyId, deptHierarchyList, Constants.SUPER_ADMIN_NUMBER);
		}
		return result;
	}
	
	/**
	 * 해당 테넌트에 속한 사용자 목록 조회
	 * 
	 * @param tenantId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/user/selectUserTenantMappingList.do")
	public List<UserVO> selectUserTenantMappingList(Integer tenantId){
		List<UserVO> result = userService.selectUserTenantMappingList(tenantId);
		return result;
	}
	
	/**
	 * 사용자 등록
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 중복 아이디
	 * 
	 * @param userVO
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user/insertUser.do", method=RequestMethod.POST)
	public int insertUser(UserVO userVO, HttpSession session) {
		
		// 결과
		int result = 0;

		// 아이디 중복 체크
		// 사용자가 입력한 아이디로 사용자 수 조회
		int userCountBysUserId = userService.countUserBySUserID(userVO.getsUserID());
		if(userCountBysUserId > 0) {
			// 사용자가 입력한 아이디가 이미 사용중인 경우
			result = 2;
			return result;
		}
		
		// 초기회된(임시) 비밀번호 설정 : 아이디 + "2020!@";
		String tempPassword = userVO.getsUserID()+"2020!@";
		
		// 비밀번호 해시
		String hashedPassword = SHA256Util.hash(tempPassword);
		userVO.setsUserPW(hashedPassword);
		
		// 사용자 등록
		result = userService.insertUser(userVO);
		
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		// 이력 내용
		String sContext = "["+userVO.getsUserID()+"]";
		sContext += " 이름 : "+userVO.getsName()+",";
		sContext += " 회사 : "+userVO.getCompanyName()+",";
		sContext += " 부서 : "+userVO.getsDepartmentName()+",";
		sContext +=	" 권한 : "+userVO.getApprovalName()+",";
		sContext += " 재직 여부 : "+userVO.getTenureName()+",";
		sContext += " 영문 이름 : "+userVO.getsNameEng()+",";
		sContext += " 직급 : "+userVO.getsJobCode()+",";
		sContext += " 이메일 : "+userVO.getsEmailAddress()+",";
		sContext += " 전화번호 : "+userVO.getsPhoneNumber()+",";
		sContext += " 입사일 : "+userVO.getdStartday()+",";
		sContext += " 사번 : "+userVO.getnNumber()+",";
		sContext += " IP : "+userVO.getsUserIP();
		
		// 로그 기록
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "사용자", "Create");
		
		return result;
	}
	
	/**
	 * 사용자 정보 수정
	 * 
	 * 결과
	 * 1 : 성공
	 * 
	 * @param userVO
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user/updateUser.do", method=RequestMethod.POST)
	public int updateUser(UserVO userVO, HttpSession session) {
		int result = 0;
		
		// 사용자 정보 조회
		UserVO dbUserVO = userService.selectUserById(userVO.getId());
		
		// 이력 내용
		StringBuffer contextBuffer = new StringBuffer();

		// 이름이 변경된 경우
		if(!userVO.getsName().equals(dbUserVO.getsName())) {
			contextBuffer.append(", 이름 : ").append(dbUserVO.getsName() + " -> " + userVO.getsName());
		}
		// 회사가 변경된 경우
		if(!userVO.getCompanyName().equals(dbUserVO.getCompanyName())) {
			contextBuffer.append(", 회사 : ").append(dbUserVO.getCompanyName() + " -> " + userVO.getCompanyName());
		}
		// 부서가 변경된 경우
		if(!userVO.getsDepartment().equals(dbUserVO.getsDepartment())) {
			contextBuffer.append(", 부서 : ").append(dbUserVO.getsDepartmentName() + " -> " + userVO.getsDepartmentName());
		}
		// 승인(권한)이 변경된 경우
		if(userVO.getnApproval() != dbUserVO.getnApproval()) {
			String preApprovalName = "";
			if(dbUserVO.getnApproval() == 1) {
				preApprovalName = "사용자";
			} else if(dbUserVO.getnApproval() == 2) {
				preApprovalName = "부서장";
			} else if(dbUserVO.getnApproval() == 11) {
				preApprovalName = "담당자";
			} else if(dbUserVO.getnApproval() == 12) {
				preApprovalName = "검토 승인자";
			} else if(dbUserVO.getnApproval() == 21) {
				preApprovalName = "운영자";
			}
			contextBuffer.append(", 권한 : ").append(preApprovalName + " -> " +  userVO.getApprovalName());
		}
		// 재직 여부가 변경된 경우
		if(userVO.getsTenureCode() != dbUserVO.getsTenureCode()) {
			String preTenureName = "";
			if(dbUserVO.getsTenureCode() == 11) {
				preTenureName = "재직";
			} else if(dbUserVO.getsTenureCode() == 55) {
				preTenureName = "휴직";
			} else if(dbUserVO.getsTenureCode() == 99) {
				preTenureName = "퇴사";
			}
			contextBuffer.append(", 재직 여부 : ").append(preTenureName + " -> " +  userVO.getTenureName());
		}
		// 영문 이름이 변경된 경우
		if(!userVO.getsNameEng().equals(dbUserVO.getsNameEng())) {
			contextBuffer.append(", 영문 이름 : ").append(dbUserVO.getsNameEng() + " -> " +  userVO.getsNameEng());
		}
		// 직급이 변경된 경우
		if(!userVO.getsJobCode().equals(dbUserVO.getsJobCode())) {
			contextBuffer.append(", 직급 : ").append(dbUserVO.getsJobCode() + " -> " +  userVO.getsJobCode());
		}
		// 이메일이 변경된 경우
		if(!userVO.getsEmailAddress().equals(dbUserVO.getsEmailAddress())) {
			contextBuffer.append(", 이메일 : ").append(dbUserVO.getsEmailAddress() + " -> " + userVO.getsEmailAddress());
		}
		// 전화번호가 변경된 경우
		if(!userVO.getsPhoneNumber().equals(dbUserVO.getsPhoneNumber())) {
			contextBuffer.append(", 전화번호 : ").append(dbUserVO.getsPhoneNumber() + " -> " + userVO.getsPhoneNumber());
		}
		// 입사일이 변경된 경우
		if(userVO.getdStartday() != null &&
				!userVO.getdStartday().equals(dbUserVO.getdStartday())) {
			contextBuffer.append(", 입사일 : ").append(dbUserVO.getdStartday() + " -> " + userVO.getdStartday());
		}
		// 사번이 변경된 경우
		if(!userVO.getnNumber().equals(dbUserVO.getnNumber())) {
			contextBuffer.append(", 사번 : ").append(dbUserVO.getnNumber() + " -> " + userVO.getnNumber());
		}
		// IP 주소가 변경된 경우
		if(!userVO.getsUserIP().equals(dbUserVO.getsUserIP())) {
			contextBuffer.append(", IP 주소 : ").append(dbUserVO.getsUserIP() + " -> " + userVO.getsUserIP());
		}
		
		// 변경된 것이 있는 경우
		if(contextBuffer.length() > 0) {
			
			// 부서 정보 수정
			result = userService.updateUser(userVO);

			// 로그인 정보 얻기
			UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
			
			// 로그 기록
			String sContext = "[" + dbUserVO.getsUserID() + "] " + contextBuffer.toString().substring(1);
			logService.insertLog(loginInfo.getsUserID(), 0, sContext, "사용자", "Update");
		} else {
			// 변경된 것이 없어도 변경 성공으로 한다.
			result = 1;
		}
		return result;
	}
	
	/**
	 * 사용자 정보 삭제
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 테넌트 관리자인 경우
	 * 3 : 서비스 관리자인 경우
	 * 
	 * @param userVO
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user/deleteUser.do", method=RequestMethod.POST)
	public int deleteUser(UserVO userVO, HttpSession session) {
		
		// 결과
		int result = 0;
		
		// 사용자가 관리자로 있는 테넌트 수 조회
		int tenantsCount = tenantService.countTenantByAdminId(userVO.getId());
		
		// 테넌트 관리자인 경우
		if(tenantsCount > 0) {
			result = 2;
			return result;
		}
		
		// 사용자가 관리자가 있는 서비스 수 조회
		int serviceCount = vmServiceService.countServiceAdmin(userVO.getId());
		
		// 서비스 관리자인 경우
		if(serviceCount > 0) {
			result = 3;
			return result;
		}
		
		// 사용자 삭제
		result = userService.deleteUser(userVO.getId());
		
		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "[" + userVO.getsUserID() + "]";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "사용자", "Update");
		
		return result;
	}
	
    /**
     * 비밀번호 초기화
     * 
     * @param id
     * @param sUserID
     * @return
     */
	@ResponseBody
	@RequestMapping(value="/user/resetPassword.do", method=RequestMethod.POST)
	public int resetPassword(int id, String sUserID, HttpSession session) {
		
		// 결과
		int result = 0;
		
		// 초기화 비밀번호 : 사용자 아이디 + "2020!@"
		String resetPassword = sUserID+"2020!@";
		// 비밀번호 해시
		String hashedResetPassword = SHA256Util.hash(resetPassword);
		
		// 초기화 비밀번호로 비밀번호 변경
		UserVO userVO = new UserVO();
		userVO.setId(id);
		userVO.setsUserPW(hashedResetPassword);
		result = userService.updateUserPassword(userVO);
		
		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		// 로그 기록
		String sContext = "[" + sUserID + "] 비밀번호 초기화";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "사용자", "Update");
		
		return result;
	}

	/**
	 * 현재 비밀번호 검증
	 * 
	 * 결과 코드 
	 * 0 : 실패
	 * 1 : 성공
	 * 
	 * @param sUserPW
	 * @param sUserID
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user/verifyPassword.do", method=RequestMethod.POST)
	public int verifyPassword(String sUserID, String sUserPW) {

		// 결과(0:실패, 1:성공)
		int result = 0;
		// 사용자 입력한 비밀번호를 SHA256 알고리즘으로 해시
		String hashedPassword = SHA256Util.hash(sUserPW);

		// 사용자 정보 얻기
		UserVO dbUser = userService.selectUserBySUserID(sUserID);

		// 비밀번호 일치 확인
		if (dbUser.getsUserPW().equals(hashedPassword)) {
			// 성공
			result = 1;
		}

		return result;
	}
	
	/**
	 * 비밀번호 변경
	 * 
	 * 결과 코드 
	 * 0 : 사용자가 입력한 비밀번호 2개가 불일치 
	 * 1 : 비밀번호 변경 성공 
	 * 2 : 특수문자, 숫자, 영문대소문자 미포함
	 * 3 : 기존 비밀번호와 동일
	 * 4 : 현재 비밀번호 틀림
	 * 
	 * @param id
	 * @param sUserID
	 * @param newPW
	 * @param newPWconfirm
	 * @param currentPW
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user/upateNewPassword.do", method=RequestMethod.POST)
	public int upateNewPassword(int id, String sUserID, String newPW, 
			String newPWconfirm, String currentPW, HttpSession session) {

		// 결과
		int result = 1;

		// 사용자가 입력한 비밀번호 2개가 일치하지 않는 경우
		if (CommonUtil.isEmpty(newPW) || !newPW.equals(newPWconfirm)) {
			result = 0;
			return result;
		}

		// 비밀번호 숫자, 특수문자, 영문자 대소문자 포함 여부 확인

		// 비밀번호 유효성 검사식1 : 숫자, 특수문자가 포함되어야 한다.
		String regExpSymbol = "([0-9].*[!,@,#,^,&,*,(,)])|([!,@,#,^,&,*,(,)].*[0-9])";
		// 비밀번호 유효성 검사식2 : 영문자 대소문자가 적어도 하나씩은 포함되어야 한다.
		String regExpAlpha = "([a-z].*[A-Z])|([A-Z].*[a-z])";

		Pattern patternSymbol = Pattern.compile(regExpSymbol);
		Pattern patternAlpha = Pattern.compile(regExpAlpha);

		Matcher matcherSymbol = patternSymbol.matcher(newPW);
		Matcher matcherAlpha = patternAlpha.matcher(newPW);

		boolean symbol = matcherSymbol.find();
		boolean alpha = matcherAlpha.find();

		// 비밀번호에 특수문자, 숫자, 영문대소문자가 포함되지 않은 경우
		if (!(symbol && alpha)) {
			result = 2;
			return result;
		}

		// 현재 비밀번호 검증
		// 현재 비밀번호를 SHA256 알고리즘으로 해시
		String hashedCurrentPassword = SHA256Util.hash(currentPW);

		// 사용자 정보 얻기
		UserVO dbUser = userService.selectUserBySUserID(sUserID);

		// 사용자가 입력한 현재 비밀번호와 DB에 있는현재 비밀번호 일치 확인
		if (!dbUser.getsUserPW().equals(hashedCurrentPassword)) {
			result = 4;
			return result;
		}
		
		// 새 비밀번호와 기존 비밀번호와 동일한지 확인
		// 사용자 입력한 비밀번호를 SHA256 알고리즘으로 해시
		String hashedNewPassword = SHA256Util.hash(newPW);

		// 기존 비밀번호와 동일한 경우
		if (dbUser.getsUserPW().equals(hashedNewPassword)) {
			result = 3;
			return result;
		}

		// 비밀번호 변경
		UserVO userVO = new UserVO();
		userVO.setId(id);
		userVO.setsUserPW(hashedNewPassword);
		result = userService.updateUserPassword(userVO);

		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		// 로그 기록
		String sContext = "[" + sUserID + "] 비밀번호 변경";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "비밀번호", "Update");

		return result;
	}

	/**
	 * 사용자 테넌트 배치
	 * 
	 * @param id 사용자 고유번호
	 * @param sUserID 사용자 아이디
	 * @param tenantIds 배치 대상 테넌트 ID 목록
	 * @param tenantNames 배치 대상 테넌트명 목록
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user/arrangeTenant.do", method=RequestMethod.POST)
	public int arrangeTenant(Integer id, String sUserID, Integer[] tenantIds, String[] tenantNames) {
		
		// 결과
		int result = 0;
		
		// 새로 추가된 테넌트 이름(로그 기록용)
		String addTenantName = "";
		// 삭제된 테넌트 이름(로그 기록용)
		String deleteTenantName = "";
		
		// 사용자에 매핑된 테넌트 목록 얻기
		List<TenantVO> tenantList = tenantService.selectTenantListByUserMapping(id);
		
		// 새로 추가된 테넌트 이름 얻기
		if(tenantIds != null && tenantIds.length > 0) {
			for(int i = 0; i < tenantIds.length; i++) {
				boolean isAdd = true;
				for(TenantVO tenantVO : tenantList) {
					// 이미 등록된 테넌트인 경우
					if(tenantVO.getId().equals(tenantIds[i])) {
						isAdd = false;
						continue;
					}
				}
				if(isAdd) {
					addTenantName += ", " + tenantNames[i];
				}
			}
		}
		
		// 삭제된 테넌트 이름 얻기
		for(TenantVO tenantVO : tenantList) {
			boolean isDelete = true;
			if(tenantIds != null && tenantIds.length > 0) {
				for(Integer tenantId : tenantIds) {
					// 이번에도 포함된 테넌트인 경우
					if(tenantVO.getId().equals(tenantId)) {
						isDelete = false;
						continue;
					}
				}
			}
			if(isDelete) {
				deleteTenantName += ", " + tenantVO.getName();
			}
		}
		
		if(addTenantName.length() > 0 || deleteTenantName.length() > 0) {
			// 변경된 것이 있는 경우
			
			// 사용자 테넌트 매핑 등록(delete & insert)
			userService.insertUserTenantMapping(id, tenantIds);
			
			result = 1;
			
			// 로그 기록
			String sContext = "[" + sUserID + "] ";
			if(addTenantName.length() > 2) {
				sContext += "추가 : " + addTenantName.substring(2);
			}
			if(deleteTenantName.length() > 2) {
				if(addTenantName.length() > 2) {
					sContext += ", ";
				}
				sContext += "삭제 : " + deleteTenantName.substring(2);
			}
			logService.insertLog(0, sContext, "서비스 그룹 배치", "Update");
			
		} else {
			// 변경된 것이 없는 경우
			
			// 변경된 것이 없어도 변경 성공으로 한다.
			result = 1;
		}
		
		return result;
	}
}
