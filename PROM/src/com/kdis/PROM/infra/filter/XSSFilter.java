package com.kdis.PROM.infra.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * XSS Filter
 * 
 * 크로스 사이트 스크립트(Cross-site Scripting) 공격으로 보호하는 Filter
 * 	단 form data만 보고하고 json data는 보고하지 못한다. 
 * 	json data는 HtmlEscapingObjectMapperFactory 통해서 보호한다.
 * 
 * @author KimHahn
 *
 */
public class XSSFilter implements Filter {

	public FilterConfig filterConfig;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		chain.doFilter(new RequestWrapper((HttpServletRequest) request), response);
	}

	@Override
	public void destroy() {
		this.filterConfig = null;
	}

}
