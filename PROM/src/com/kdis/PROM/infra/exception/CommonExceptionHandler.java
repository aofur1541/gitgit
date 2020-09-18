package com.kdis.PROM.infra.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 예외 Handler
 */
@ControllerAdvice
@SuppressWarnings("serial")
public class CommonExceptionHandler extends RuntimeException {

	private static final Log LOG = LogFactory.getLog(Exception.class);
	
	/** 이력 서비스 */
	@Autowired
	private LogService logService;

	// 모든 예외 처리
	@ExceptionHandler(Exception.class)
	public void handlerException(HttpServletRequest request, HttpServletResponse response, Exception e)
			throws Exception {
		e.printStackTrace();
		LOG.warn(e);
		LOG.warn(e.getCause());
		LOG.warn(e.getMessage());
		
		// 에러 내용을 이력에 실패로 기록한다.
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(request.getSession());

		// 이력 기록
		String context = "Path : " + request.getServletPath() + ", Message : " + e.getMessage() + ", Cause : " + e.getCause();
		String target = "";
		String keyword = "";
		
		// url로 이력의 대상, 작업구분을 유추해낸다.
		LOG.warn("Path : " + request.getServletPath());
		String path = "";
		if(request.getServletPath() != null) {
			path = request.getServletPath().toLowerCase();
		}
		// 대상 
		if(path.indexOf("/login/") > -1) {
			// 로그인
			target = "Login";
		} else if(path.indexOf("/dash/") > -1) {
			// 대시보드
			target = "대시보드";
		} else if(path.indexOf("/status/") > -1) {
			// 현황
			if(path.indexOf("vmstatus") > -1) {
				target = "가상머신 현황";
			} else if(path.indexOf("hoststatus") > -1) {
				target = "호스트 현황";
			} else if(path.indexOf("datastorestatus") > -1) {
				target = "데이터스토어 현황";
			} else {
				target = "현황";
			}
		} else if(path.indexOf("/apply/") > -1) {
			// 신청
			target = "신청";
		} else if(path.indexOf("/approval/") > -1) {
			// 승인
			target = "승인";
		} else if(path.indexOf("/performance/") > -1) {
			// 성능
			target = "성능";
		} else if(path.indexOf("/report/") > -1) {
			// 보고서
			target = "보고서";
		} else if(path.indexOf("/log/") > -1) {
			// 감사 이력
			target = "감사 이력";
		} else if(path.indexOf("/vm/") > -1) {
			// 가상머신 인프라 관리
			target = "가상머신 인프라 관리";
		} else if(path.indexOf("/scale/") > -1) {
			// Scale 인프라 관리
			target = "Scale 인프라 관리";
		} else if(path.indexOf("/config/") > -1) {
			// 인프라 관리
			target = "인프라 관리";
		} else if(path.indexOf("/tenant/") > -1) {
			// 그룹 관리
			if(path.indexOf("tenant") > -1) {
				target = "테넌트";
			} else if(path.indexOf("vmservice") > -1) {
				target = "서비스";
			} else if(path.indexOf("arrangevm") > 1) {
				target = "가상머신 배치";
			} else {
				target = "그룹 관리";
			}
		} else if(path.indexOf("/user/") > -1) {
			// 기초 데이터
			if(path.indexOf("company") > -1) {
				target = "회사";
			} else if(path.indexOf("department") > -1 || path.indexOf("dept") > -1) {
				target = "부서";
			} else if(path.indexOf("user") > 1) {
				target = "사용자";
			} else {
				target = "기초 데이터";
			}
		} else if(path.indexOf("/support/") > -1) {
			// 고객 지원
			if(path.indexOf("notice") > -1) {
				target = "공지사항";
			} else if(path.indexOf("question") > -1) {
				target = "문의사항";
			} else {
				target = "고객 지원";
			}
		}
		
		// 작업 구분
		if(path.indexOf("select") > -1 || path.indexOf("get") > -1) {
			// 조회
			keyword = "Select";
		} else if(path.indexOf("insert") > -1 || path.indexOf("create") > -1 || path.indexOf("regist") > -1) {
			// 생성
			keyword = "Create";
		} else if(path.indexOf("update") > -1 || path.indexOf("modify") > -1) {
			// 수정
			keyword = "Update";
		} else if(path.indexOf("delete") > -1 || path.indexOf("remove") > -1) {
			// 삭제
			keyword = "Delete";
		}  else if(path.indexOf("arrange") > -1) {
			// 매핑
			keyword = "Mapping";
		} 
		
		LOG.debug("context : " + context);
		LOG.debug("target : " + target);
		LOG.debug("keyword : " + keyword);

		logService.insertLog(loginInfo.getsUserID(), 1, context, target, keyword);
		
	}

}
