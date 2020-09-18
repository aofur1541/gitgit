package com.kdis.PROM.login.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 로그인 VO
 * 
 * @author KimHahn
 *
 */
public class LoginVO {

	// 사용자 ID
	private String sUserID = "";
	
	// 비밀번호
	private String sUserPW = "";
	
	// OTP 번호
	private String otpNumber = "";

	/**
	 * @return the sUserID
	 */
	public String getsUserID() {
		return sUserID;
	}

	/**
	 * @param sUserID the sUserID to set
	 */
	public void setsUserID(String sUserID) {
		this.sUserID = sUserID;
	}

	/**
	 * @return the sUserPW
	 */
	public String getsUserPW() {
		return sUserPW;
	}

	/**
	 * @param sUserPW the sUserPW to set
	 */
	public void setsUserPW(String sUserPW) {
		this.sUserPW = sUserPW;
	}

	/**
	 * @return the otpNumber
	 */
	public String getOtpNumber() {
		return otpNumber;
	}

	/**
	 * @param otpNumber the otpNumber to set
	 */
	public void setOtpNumber(String otpNumber) {
		this.otpNumber = otpNumber;
	}

	@Override
	public String toString() {
		return "LoginVO [sUserID=" + sUserID + ", sUserPW=" + sUserPW + ", otpNumber=" + otpNumber + "]";
	}
	
}
