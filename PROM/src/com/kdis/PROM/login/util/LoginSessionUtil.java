package com.kdis.PROM.login.util;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.kdis.PROM.user.vo.UserVO;

/**
 * 로그인, 로그인 정보 관련 메소드를 모아둔 Class
 * 
 * @author KimHahn
 *
 */
public class LoginSessionUtil {
	
	// 세션에 로그인 정보를 저장하는데 사용하는 KEY
	private static final String LOGIN_SESSION_INFO = "loginUser";
	
	private static final Log LOG = LogFactory.getLog(LoginSessionUtil.class);
	
	/**
	 * 로그인 정보를 세션에 저장
	 * 
	 * @param user
	 * @param session
	 */
	public static void login(UserVO user, HttpSession session) {
		// 로그인 정보 세션에 저장
		session.setAttribute(LOGIN_SESSION_INFO, user);
	}
	
	/**
	 * 로그아웃
	 * 
	 * @param user
	 * @param session
	 */
	public static void logout(HttpSession session) {
		// 세션 초기화 : 세션에 담긴 로그인 정보를 삭제하는 것보다 세션을 초기화하는 것이 보안상 더 좋다.
		session.invalidate();
	}

	/**
	 * 세션에서 로그인 정보 얻기
	 * 
	 * @param session
	 * @return
	 */
	public static UserVO getLoginInfo(HttpSession session) {
		
		// 세션에서 로그인 정보 얻기
		Object obj = session.getAttribute(LOGIN_SESSION_INFO);
		
		// 로그인 정보가 없는 경우에는 NullPointerException을 방지하기 위해 빈 로그인 정보를 리턴한다.
		if (obj != null && obj instanceof UserVO) {
			return (UserVO) obj;
		} else {
			return new UserVO();
		}
	}

	/**
	 * 세션에서 로그인 정보 얻기
	 * 
	 * @param session
	 * @return
	 */
	public static UserVO getLoginInfo() {
		
		// 세션 얻기
		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
	    HttpSession httpSession = servletRequestAttribute.getRequest().getSession(true);
		
		// 세션에서 로그인 정보 얻기
		Object obj = httpSession.getAttribute(LOGIN_SESSION_INFO);
		
		// 로그인 정보가 없는 경우에는 NullPointerException을 방지하기 위해 빈 로그인 정보를 리턴한다.
		if (obj != null && obj instanceof UserVO) {
			return (UserVO) obj;
		} else {
			return new UserVO();
		}
	}
	
	/**
	 * 로그인한 상태인 확인
	 * 
	 * @param session
	 * @return
	 */
	public static boolean isLogin(HttpSession session) {
		// 세션에서 로그인 정보 얻기
		Object obj = session.getAttribute(LOGIN_SESSION_INFO);
		
		// 세션에 로그인 정보가 있으면 로그인한 상태임
		if (obj != null && obj instanceof UserVO) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 로그인 정보 중에서 String 형식의 각 항목 정보 얻기
	 * 
	 * @param session
	 * @param category 얻고 싶은 항목
	 * @return
	 */
	public static String getStringLoginInfo(HttpSession session, String category) {
		
		// 세션에서 로그인 정보 얻기
		UserVO loginUser = LoginSessionUtil.getLoginInfo(session);
		
		String strResult = null;

		if (category.equals("sUserID")) {
			strResult = loginUser.getsUserID();
		} else if (category.equals("sUserPW")) {
			strResult = loginUser.getsUserPW();
		} else if (category.equals("sName")) {
			strResult = loginUser.getsName();
		} else if (category.equals("sDepartment")) {
			strResult = loginUser.getsDepartment();
		} else if (category.equals("sNameEng")) {
			strResult = loginUser.getsNameEng();
		} else if (category.equals("nNumber")) {
			strResult = loginUser.getnNumber();
		} else if (category.equals("sUserIP")) {
			strResult = loginUser.getsUserIP();
		} else if (category.equals("sEmailAddress")) {
			strResult = loginUser.getsEmailAddress();
		} else if (category.equals("sPhoneNumber")) {
			strResult = loginUser.getsPhoneNumber();
		} else if (category.equals("dBirthday")) {
			strResult = loginUser.getdBirthday();
		} else if (category.equals("dStartday")) {
			strResult = loginUser.getdStartday();
		} else if (category.equals("sJobCode")) {
			strResult = loginUser.getsJobCode();
		} else {
			strResult = "getSessionloginUserInfo() category 매개변수 값을 찾지 못함";
			LOG.debug("getSessionloginUserInfoStr method strResult value is null");
		}
		return strResult;
	}
	
	/**
	 * 로그인 정보 중에서 int 형식의 각 항목 정보 얻기
	 * 
	 * @param session
	 * @param category 얻고 싶은 항목
	 * @return
	 */
	public static int getIntLoginInfo(HttpSession session, String category) {
		
		// 세션에서 로그인 정보 얻기
		UserVO loginUser = LoginSessionUtil.getLoginInfo(session);
		
		int numberResult = 0;

		if (category.equals("id")) {
			numberResult = loginUser.getId();
		} else if (category.equals("nApproval")) {
			numberResult = loginUser.getnApproval();
		} else if (category.equals("sCompany")) {
			numberResult = loginUser.getsCompany();
		} else if (category.equals("sTenureCode")) {
			numberResult = loginUser.getsTenureCode();
		} else if (category.equals("nTenant_id")) {
			numberResult = loginUser.getnTenantId();
		} else if (category.equals("nService_id")) {
			numberResult = loginUser.getnServiceId();
		} else {
			numberResult = 0;
			LOG.debug("getSessionloginUserInfoNum method numberResult value is null");
		}
		return numberResult;
	}
	
	/**
	 * 로그인 정보 중에서 부서 얻기
	 * 
	 * @param session
	 * @return
	 */
	public static String getLoginDepartment(HttpSession session) {
		// 세션에서 로그인 정보 얻기
		UserVO loginUser = LoginSessionUtil.getLoginInfo(session);
		return loginUser.getsDepartment();
	}

	/**
	 * 로그인 정보 중에서 사용자 ID 얻기
	 * 
	 * @param session
	 * @return
	 */
	public static String getLoginUserID(HttpSession session) {
		// 세션에서 로그인 정보 얻기
		UserVO loginUser = LoginSessionUtil.getLoginInfo(session);
		return loginUser.getsUserID();
	}

	/**
	 * 로그인 정보 중에서 사용자명 얻기
	 * 
	 * @param session
	 * @return
	 */
	public static String getLoginUserName(HttpSession session) {
		// 세션에서 로그인 정보 얻기
		UserVO loginUser = LoginSessionUtil.getLoginInfo(session);
		return loginUser.getsName();
	}
}
