package com.kdis.PROM.login.controller;

import java.net.UnknownHostException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kdis.PROM.common.CommonUtil;

import com.kdis.PROM.common.Constants;
import com.kdis.PROM.common.SHA256Util;
import com.kdis.PROM.config.service.BasicService;
import com.kdis.PROM.config.vo.BasicVO;
import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.log.vo.LogVO;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.login.vo.LoginVO;
import com.kdis.PROM.user.service.UserService;
import com.kdis.PROM.user.vo.UserVO;
//import com.hyundai.OTP.server;




/**
 * 로그인 Controller
 * 	로그인/로그아웃에 대한 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class LoginController {
	
	private static final Log LOG = LogFactory.getLog( LoginController.class );

	/** 사용자 서비스 */
	@Autowired
    private UserService userService;
	
	/** 기본 기능 서비스 */
	@Autowired
	private BasicService basicService;
	
	/** 이력 서비스 */
	@Autowired
	private LogService logService;
	
	
	
	/**
	 * 로그인
	 * ID/비밀번호, OTP 인증을 실시하고 그 결과 코드를 리턴한다.
	 * 
	 * 결과 코드  
	 * 0 : ID 없음
	 * 2 : 비밀번호 틀림
	 * 3 : 로그인 성공
	 * 5 : 시스템 에러
	 * 6 : 허용된 IP 아님
	 * 7 : 사용자 네트워크 대역대 설정값이 올바르지 않음
	 * 9 : 초기 비밀번호
	 * 10 : 비밀번호 만료
	 * 11 : OTP 인증 필요
	 * 13 : 사용하지 않는 부서 소속
	 * 
	 * @param login
	 * @param session
	 * @param request
	 * @return
	 */
	
	/*
	 * @RequestMapping(value="/login/admincheck.do") public @ResponseBody int
	 * admincheck(LoginVO login, HttpSession session) { int result = 0; try { UserVO
	 * dbUser = userService.selectUserBySUserID(login.getsUserID());
	 * 
	 * if(dbUser.getnApproval() != 99) { result = -1; }else { result = 1; } }
	 * catch(Exception e){ e.printStackTrace(); } return result; }
	 */
	
	@RequestMapping(value="/login/login.do")
	public @ResponseBody int login(LoginVO login, HttpSession session, HttpServletRequest request) {
		
		// 로그인 결과
		int result = 0;
		
		try {
			
			// 사용자 정보 얻기
			UserVO dbUser = userService.selectUserBySUserID(login.getsUserID());
			
			
				
				
				
			
			// 사용자 입력한 비밀번호를 SHA256 알고리즘으로 해시
			String hashedPassword = SHA256Util.hash(login.getsUserPW());

			// 사용자가 입력한 ID의 사용자 정보가 없는 경우
			if (dbUser == null) {
				LOG.info("login failure(no user) userID : " + login.getsUserID());
				result = 0;
				return result;
			}
			
			// 비밀번호가 틀린 경우
			
			  if (!hashedPassword.equals(dbUser.getsUserPW())) {
				  LOG.info("login failure(wrong password) userID : " + login.getsUserID());
				  
				  // 로그 기록 
				  String sContext = "접속 실패 : 비밀번호가 올바르지 않습니다.";
				  logService.insertLog(dbUser.getsUserID(), 1, sContext, dbUser.getsName(),
				  "Login");
				  
				  result = 2; 
				  return result; 
			  }
			 

				
			// OTP 사용 여부 얻기
			BasicVO useOTPchk = basicService.selectBasicByName("useOTP");
			// 비밀번호 만료기간 얻기
			BasicVO etcChk = basicService.selectBasicByName("pwExpiration");
			
			// 사용자들의 네트워크 대역대 허용할 리스트 얻기
			BasicVO etcNetworkChk = basicService.selectBasicByName("userAccessNetwork");
			
			// 사용자 공인 및 프록시 가져오기 IP
			String ip = this.getClientIP(request);

			// 접속 허용 사용자 IP 리스트
			String[] userIPs = null;
			// 네트워크 대역대 허용 리스트
			String[] userAccessNetworks = null;
			String[] clientIP = ip.split("\\.");
			// IP 체크 결과
			boolean isPassIPChk = false;
			
			if(dbUser.getnApproval() != 1)
			
			// IP 체크
			if ((dbUser.getsUserIP() == null || dbUser.getsUserIP().equals(""))
					&& dbUser.getnApproval() != Constants.SUPER_ADMIN_NUMBER) {
				// 슈퍼관리자가 아닌데 등록된 사용자 IP가 없는 경우 
				LOG.info("2.sUserIP is null and not administrator");
				
				// 대역대 검사
				if (etcNetworkChk.getValueStr() == null || etcNetworkChk.getValueStr().equals("")) {
					// 대역대 설정 값이 없는 경우
					LOG.info("3.etcParameter userAccessNetwork none Setting");
					isPassIPChk = true;
				} else {
					// 대역대 설정 값이 있는 경우
					userAccessNetworks = etcNetworkChk.getValueStr().split(",");
					
					for (int i = 0; i < userAccessNetworks.length; i++) {
						String[] accessNetwork = userAccessNetworks[i].split("\\.");
						
						if (accessNetwork.length != 4) {
							// 대역대 설정 값이 이상한 경우
							LOG.info("5.etcParameter userAccessNetwork Setting value Error, Check the value again");
							LOG.info("Wrong value : " + etcNetworkChk.getValueStr());
							result = 7;
							return result;
						}

						// 설정된 IP와 사용자 IP에서 1,2,3번째 숫자가 일치하는지 확인
						if (accessNetwork[0].equals(clientIP[0]) 
								&& accessNetwork[1].equals(clientIP[1])
								&& accessNetwork[2].equals(clientIP[2])) {
							isPassIPChk = true;
							continue;
						}
					}
					LOG.info("4.etcParameter userAccessNetwork Setting Pass" + ", Pass value : " 
							+ etcNetworkChk.getValueStr());
				}

			} else if (dbUser.getsUserIP() != null
					&& !dbUser.getsUserIP().equals("")) {
				// 등록된 사용자 IP가 있는 경우
				
				userIPs = dbUser.getsUserIP().split(",");
				
				for (String key : userIPs) {
					// IP 검사
					if (ip.equals(key)) {
						LOG.info("1.IP Pass" + ", Pass value " + key);
						isPassIPChk = true;
						continue;
					}

				}
				LOG.info("DB sUserIP " + dbUser.getsUserIP());
			}
			
			// 허용되지 않은 IP에서 로그인한 경우
			if(isPassIPChk == false) {
				LOG.info("login failure userID : " + login.getsUserID() + ", login failure IP : " + ip);
				
				// 로그 기록
				String sContext = "접속 실패 : 허용되지 않은 IP : " + ip;
				logService.insertLog(dbUser.getsUserID(), 1, sContext, dbUser.getsName(), "Login");
				result = 6;
				return result;
			}
			
			// 사용자 client 브라우저
			String browser = this.getBrowser(request);

			// 초기 비밀번호 여부 확인
			// 초기 비밀번호 : 사용자 ID + '2020!@'
			String hashedDefaultPassword = SHA256Util.hash(dbUser.getsUserID() + "2020!@");
			if (dbUser.getsUserPW().equals(hashedDefaultPassword)) {
				LOG.info("Default Password userID : " + login.getsUserID());
				result = 9;
				return result;
			}
			
			// 비밀번호 변경 주기 체크
			// 현재 일시
			LocalDateTime nowTime = LocalDateTime.now();
			// 사용자가 마지막으로 비밀번호를 변경한 일시
			LocalDateTime userPassCh = LocalDateTime.ofInstant(
					dbUser.getPasswdChangedOn().toInstant(),
					ZoneId.systemDefault());
			long dateResult = ChronoUnit.DAYS.between(userPassCh, nowTime);

			if (dateResult >= etcChk.getValue()) {
				// 비밀번호 변경 주기가 지난 경우
				LOG.info("Password expiration userID : " + login.getsUserID());
				result = 10;
				return result;
			}
			
			// 슈퍼관리자, 관제OP가 아닌 경우에는 OTP 사용 여부에 따라 OTP 인증을 할 필요가 있다 
			/*
			 * if (useOTPchk != null && useOTPchk.getValue() == 0) { LOG.debug("USE OTP");
			 * 
			 * // 비밀번호 인증 통화했다는 것을 세션에 표시한다. // 이것은 OTP 인증에서 해당 세션이 비밀번호 인증을 통과했는지 확인하는데
			 * 사용한다. session.setAttribute("passwordLogin", login.getsUserID());
			 * 
			 * // OTP 인증이 필요한 경우 result = 11; return result; }
			 */

			// 로그인 성공
			// 사용자 정보 세션에 저장
			
			LoginSessionUtil.login(dbUser, session);
			
			// 로그 기록
			String sContext = ip + " " + browser;
			LogVO notification = new LogVO();
			notification.setsReceive(login.getsUserID());
			notification.setsTarget(dbUser.getsName());
			notification.setsContext(sContext);
			notification.setnCategory(0);
			notification.setsKeyword("Login");
			logService.insertLog(notification);
			
			// 사용자 마지막 로그인 일시 갱신
			userService.updateLastLoginDate(dbUser.getId());
			
			result = 3;
			
		} catch (Exception e) {
			ModelAndView mav = new ModelAndView("/index.jsp");
			e.printStackTrace();
			LOG.error("login error : " + e);
			mav.addObject("errorMeg", e);
			result = 5;
		}
		
		
		return result;
	}
	
	/**
	 * OTP 인증
	 * TODO 고객별로 고객에서 사용하는 OTP 서버와 연동하도록 구현해야 한다. 
	 * 
	 * @param login
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/login/otpLogin.do", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> otpLogin(LoginVO login, HttpSession session,
			HttpServletRequest request) {
		
		//TODO "수정 필요"
		String result="";
		
		String sUserID = login.getsUserID();
		String otpNumber = login.getOtpNumber();
		
		
		//OTP 서비스 없어서 임의의 6자리 들어오면 패스
		if(otpNumber.length() == 6 ) {
			result = "0";
		}
		
		//admin 전용 통로
		if(sUserID.equals("admin@prom")) {
		 
			// 사용자 정보 얻기
			UserVO dbUser = userService.selectUserByADid(login.getsUserID());
			// 로그인 성공
			// 사용자 정보 세션에 저장
			LoginSessionUtil.login(dbUser, session);
			
			HashMap<String,Object> resultMap = new HashMap<String,Object>();
			resultMap.put("rCode", "0");
			resultMap.put("authFailCnt", "0");
			resultMap.put("rMsg", "success");
			result="0";
			
			return resultMap;  
		}
		
		else {
		//TODO vcloud.local => hd.com
		String ADid = login.getsUserID()+"@vcloud.local";
		
	
		
	
		
		
		// 인증 결과
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		//Client client=new Client();
		
		String Companycode="pcard";
		//TODO vcloud.local => hd.com
		String ID=login.getsUserID()+"@vcloud.local";
		String OTP=login.getOtpNumber();
		String asset="22104";
		String userIP="10.211.103.41";
	
		//String result= Client.certifyOTP();
		
	
		
		// TODO 고객별로 고객에서 사용하는 OTP 서버와 연동하도록 구현해야 한다. 
		// 테스트를 위해서 임의로 OTP 결과 값을 리턴하도록 함
		if(result.equals("0")) {
			// OTP 인증 성공
			// 고객별로 고객에서 사용하는 OTP 서버에게 인증 성공을 확인하면  사용자 정보를 세션에 저장하고 로그를 기록하는 등 일련의 작업이 필요하다.
		
		
			// >>>>>>>>>>>>>>>>>> OTP 인증 성공 이후에 로그인 작업 Start
			
			System.out.println(ADid);
			// 사용자 정보 얻기
			UserVO dbUser = userService.selectUserByADid(ADid);
			
			// 로그인 성공
			// 사용자 정보 세션에 저장
			LoginSessionUtil.login(dbUser, session);
			
			// 사용자 공인 및 프록시 가져오기 IP
			String ip = this.getClientIP(request);
			
			// 사용자 client 브라우저
			String browser = this.getBrowser(request);
			
			// 로그 기록
			String sContext = ip + " " + browser;
			LogVO notification = new LogVO();
			notification.setsReceive(ADid);
			notification.setsTarget(dbUser.getsName());
			notification.setsContext(sContext);
			notification.setnCategory(0);
			notification.setsKeyword("Login");
			logService.insertLog(notification);
		
			// 사용자 마지막 로그인 일시 갱신
			userService.updateLastLoginDate(dbUser.getId());
			// >>>>>>>>>>>>>>>>>>  OTP 인증 성공 이후에 로그인 작업 End
			
			// 인증 결과
			resultMap.put("rCode", "0");
			resultMap.put("authFailCnt", "0");
			resultMap.put("rMsg", "success");
			
		} else {
			// 인증 실패
			// 인증 결과
			resultMap.put("rCode", "-1");
			resultMap.put("authFailCnt", "1");
			resultMap.put("rMsg", "Fail");
	
			
		}
		
		
		
		return resultMap;
		}
	}
	
	@RequestMapping(value="/login/adLogin.do", method=RequestMethod.POST)
	@ResponseBody
	
	public HashMap<String,Object> adLogin(LoginVO login, HttpSession session,
		HttpServletRequest request) { 
	


	
	
		String result="";
		String userID = login.getsUserID();
		String userPW = login.getsUserPW();
		String hashPW = SHA256Util.hash(userPW);
		System.out.println(userID + " , " + userPW);
		//입력 pw와 비교하기위해 사용자 정보 불러오기
		UserVO user = userService.selectUserBySUserID(userID);
		
		// admin@prom 으로 로그인 시도하고 정보가 맞을때
		if (userID.equals("admin@prom") && user.getsUserPW().equals(hashPW) ) {
			
				//ad 연동
				UserVO dbUser = userService.selectUserByADid(login.getsUserID());
				System.out.println(dbUser);
				
				
				// 로그인 성공
				// 사용자 정보 세션에 저장
				LoginSessionUtil.login(dbUser, session);
				
				
				HashMap<String,Object> resultMap = new HashMap<String,Object>();
				resultMap.put("aCode", "0");
				resultMap.put("authFailCnt", "0");
				resultMap.put("rMsg", "success");
				
				result="0";
				return resultMap;
		}
		
		
		
		
		
		
		else {
		
		
		
		
		//TODO vcloud.local => hd.com
		String sUserID = login.getsUserID()+"@vcloud.local";
		String otpNumber = login.getOtpNumber();
	
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();

		//TODO "수정 필요"
		//TODO vcloud.local => hd.com
		//TODO LDAP 주소 변경
		String ntUserId =  login.getsUserID()+"@vcloud.local";
		String ntPasswd= login.getsUserPW();
		String url="LDAP://test-vrops.sddc.kdis.local";
		
		try {
			
			//TODO vcloud.local => hd.com
			String usrId   =  login.getsUserID()+"@vcloud.local";//------------------------------------(예: test001)
			String usrPw   = ntPasswd;//----------------------(예: test001!)
			String baseRdn = "ou=kpkim,ou=users,dc=vcloud,dc=local";//----------------예시입니다.

			Hashtable<String, String> env = new Hashtable<String, String>();

			
			env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
			env.put(Context.PROVIDER_URL, url);
			env.put(Context.SECURITY_AUTHENTICATION, "simple");
			env.put(Context.SECURITY_PRINCIPAL, usrId);
			env.put(Context.SECURITY_CREDENTIALS, usrPw);
			System.out.println("LDAP호출 성공");
			
			LdapContext ctx = new InitialLdapContext(env, null);
			result="0";
			System.out.println("현재까지 에러가 없음");




			
		}catch(Exception e) {
			
			String msg = e.getMessage();
			System.out.println("두두등장"+msg);
			
			  if (msg.indexOf("data 525") > 0) {             

					System.out.println("사용자를 찾을 수 없음.");

				} else if (msg.indexOf("data 773") > 0) { 

					System.out.println("사용자는 암호를 재설정해야합니다.");

				} else if (msg.indexOf("data 52e") > 0) {

					System.out.println("ID와 비밀번호가 일치하지 않습니다.확인 후 다시 시도해 주십시오.");

				} else if (msg.indexOf("data 533") > 0) {

					System.out.println("입력한 ID는 비활성화 상태 입니다.");

				} else if(msg.indexOf("data 532") > 0){

					System.out.println("암호가 만료되었습니다.");

				} else if(msg.indexOf("data 701") > 0){

					System.out.println("AD에서 계정이 만료됨");

				} else {

					System.out.println("알수없는 에러");

				}
			  
		
			  
		}
		
		
	
		
		
		if(result.equals("0")) {
			
			// AD인증 성공
			// 고객별로 고객에서 사용하는 AD 서버 에게 인증 성공을 확인하면  사용자 정보를 세션에 저장하고 로그를 기록하는 등 일련의 작업이 필요하다.
			
			UserVO dbUser = userService.selectUserByADid(sUserID);
			System.out.println("dbUser : "+dbUser);
			LoginSessionUtil.login(dbUser, session);
			String ip = this.getClientIP(request);
			String browser = this.getBrowser(request);
			
			// 로그 기록
			String sContext = ip + " " + browser;
			LogVO notification = new LogVO();
			notification.setsReceive(sUserID);
			notification.setsTarget(dbUser.getsName());
			notification.setsContext(sContext);
			notification.setnCategory(0);
			notification.setsKeyword("Login");
			logService.insertLog(notification);
		
			// 사용자 마지막 로그인 일시 갱신
			userService.updateLastLoginDate(dbUser.getId());
			// >>>>>>>>>>>>>>>>>>  OTP 인증 성공 이후에 로그인 작업 End
			
			// 인증 결과
			resultMap.put("aCode", "0");
			resultMap.put("authFailCnt", "0");
			resultMap.put("rMsg", "success");
		}
		
		
		
		
		
		else {
			// 인증 실패
			// 인증 결과
			resultMap.put("aCode", "-1");
			resultMap.put("authFailCnt", "1");
			resultMap.put("rMsg", "Fail");
		}
		
		return resultMap;
	}
	
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 로그인 성공 이후 사용자 승인 번호에 따라 관리자 혹은 사용자 대시 보드로 이동한다.
	 * 
	 * @param session
	 * @return
	 */
 	@RequestMapping(value="/login/loginSuccess.do" ,method=RequestMethod.POST)
	public String loginSuccess(HttpSession session) {
 		
 		// 세션에서 로그인 정보 얻기
 		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
 		
 		// 사용자 승인 번호(권한 같은 것)
 		int userApproval = loginInfo.getnApproval();
 		if(userApproval == Constants.SUPER_ADMIN_NUMBER ) {
 			
 			System.out.println("admin 계정이기때문에 dash/dashboard.prom으로 갑니다.");
 			// 관리자(슈퍼관리자, 관제OP, 운영자, 검토 승인자, 담당자)인 경우 관리자  대시보드로 이동한다.
 			return "redirect:/dash/dashboard.prom";
 		} else {
 			// 사용자인 경우 사용자 대시보드로 이동한다.
 			return "redirect:/dash/userDashboard.prom";
 		}
	}
    
 	/**
 	 * 로그아웃
 	 * 
 	 * @param session
 	 * @param notification
 	 * @param request
 	 * @return
 	 * @throws UnknownHostException
 	 */
	@RequestMapping("/login/logout.do")
	public String logout(HttpSession session, HttpServletRequest request) throws UnknownHostException {
		
		// 로그아웃 로그를 기록한다.
		LogVO notification = new LogVO();
		notification.setsReceive(LoginSessionUtil.getStringLoginInfo(session, "sUserID"));
		String sContext = this.getClientIP(request);
		notification.setsContext(sContext);
		notification.setsTarget(LoginSessionUtil.getStringLoginInfo(session, "sName"));
		notification.setnCategory(0);
		notification.setsKeyword("Logout");
		logService.insertLog(notification);
		
		// 로그아웃
		LoginSessionUtil.logout(session);
		
		return "redirect:/index.jsp";
	}

	/**
	 * 사용자 Client IP 주소 얻기
	 * @param request
	 * @return
	 */
	private String getClientIP(HttpServletRequest request) {
		String ip = "";
		ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() ==  0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("Proxy-Client-IP"); 
		} 
		if (ip == null || ip.length() ==  0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("WL-Proxy-Client-IP"); 
		} 
		if (ip ==  null || ip.length() ==  0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("HTTP_CLIENT_IP"); 
		} 
		if (ip ==  null || ip.length() ==  0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("X-Real-IP"); 
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("X-RealIP"); 
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getHeader("REMOTE_ADDR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
			ip = request.getRemoteAddr(); 
		}
		
		return ip;
	}
	
	/**
	 * 사용자 Client 브라우저 얻기
	 * @param request
	 * @return
	 */
	private String getBrowser(HttpServletRequest request) {
		String browser = "";
		// 사용자 Agent : 사용자의 client(운영체제와 브라우저 같은 것) 정보 
		String agent = request.getHeader("User-Agent");
		if (agent != null) {
			if (browser.indexOf("Trident") > -1) {
				browser = "MSIE";
			} else if (agent.indexOf("Chrome") > -1) {
				browser = "Chrome";
			} else if (agent.indexOf("Opera") > -1) {
				browser = "Opera";
			} else if (agent.indexOf("iPhone") > -1 && agent.indexOf("Mobile") > -1) {
				browser = "iPhone";
			} else if (agent.indexOf("Android") > -1 && agent.indexOf("Mobile") > -1) {
				browser = "Android";
			}
		}
		return browser;
	}
}
