package com.kdis.PROM.infra.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kdis.PROM.login.util.LoginSessionUtil;

/**
 * 로그인 인증 interceptor
 */
public class AuthenticationInterceptor extends HandlerInterceptorAdapter {
	
	private static final Log LOG = LogFactory.getLog( AuthenticationInterceptor.class );

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		try {
			// 로그인 안한 경우는 경고 화면으로 이동
			if (!LoginSessionUtil.isLogin(request.getSession())) {
				LOG.info("Interceptor error : " + request.getRequestURI());
				response.sendRedirect("/common/alert.do");
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}
}
