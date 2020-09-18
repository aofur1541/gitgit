package com.kdis.PROM.common;

import java.util.List;
import java.util.Map;

/**
 * 공통 Utility Class
 */
public class CommonUtil {
	
	/**
	 * 해당 Object가 비어있는(null 포함) 확인
	 * true : 비어있는 경우
	 * false : 담겨 있음 
	 * @param obj
	 * @return
	 */
	public static boolean isEmpty(Object obj) {
		if (obj == null) {
			return true;
		}
		if ((obj instanceof String) && (((String) obj).trim().length() == 0)) {
			return true;
		}
		if (obj instanceof Map) {
			return ((Map<?, ?>) obj).isEmpty();
		}
		if (obj instanceof List) {
			return ((List<?>) obj).isEmpty();
		}
		if (obj instanceof Object[]) {
			return (((Object[]) obj).length == 0);
		}
		return false;
	}
	
	/**
	 * 문자열이 null이면 공백을 리턴
	 * 
	 * @param str
	 * @return
	 */
	public static String nullToBlank(String str) {
		if(str == null) {
			return "";
		} else {
			return str;
		}
	}
	
	public static String replaceLast(String string, String toReplace, String replacement) {
		int pos = string.lastIndexOf(toReplace);
		if (pos > -1) {
			return string.substring(0, pos) + replacement + string.substring(pos + toReplace.length(), string.length());
		} else {
			return string;
		}
	}
}
