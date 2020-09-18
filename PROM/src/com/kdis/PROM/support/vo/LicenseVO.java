package com.kdis.PROM.support.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 라이선스 VO
 * 
 * @author KimHahn
 *
 */
public class LicenseVO {

	/** 라이선스 고유번호  */
	private Integer nSerialNum;

	/** 라이선스 키 */
	private String sSerialKey;

	/** 라이선스 구분자(Month, Year) */
	private String sSerialCategory;

	/** 라이선스 사용 여부 */
	private String sSerialuseCheck;

	/** 라이선스 시작일 */
	private String dSerialStartTime;

	/** 라이선스 만료일 */
	private String dSerialStopTime;

	/**
	 * @return the nSerialNum
	 */
	public Integer getnSerialNum() {
		return nSerialNum;
	}

	/**
	 * @param nSerialNum the nSerialNum to set
	 */
	public void setnSerialNum(Integer nSerialNum) {
		this.nSerialNum = nSerialNum;
	}

	/**
	 * @return the sSerialKey
	 */
	public String getsSerialKey() {
		return sSerialKey;
	}

	/**
	 * @param sSerialKey the sSerialKey to set
	 */
	public void setsSerialKey(String sSerialKey) {
		this.sSerialKey = sSerialKey;
	}

	/**
	 * @return the sSerialCategory
	 */
	public String getsSerialCategory() {
		return sSerialCategory;
	}

	/**
	 * @param sSerialCategory the sSerialCategory to set
	 */
	public void setsSerialCategory(String sSerialCategory) {
		this.sSerialCategory = sSerialCategory;
	}

	/**
	 * @return the sSerialuseCheck
	 */
	public String getsSerialuseCheck() {
		return sSerialuseCheck;
	}

	/**
	 * @param sSerialuseCheck the sSerialuseCheck to set
	 */
	public void setsSerialuseCheck(String sSerialuseCheck) {
		this.sSerialuseCheck = sSerialuseCheck;
	}

	/**
	 * @return the dSerialStartTime
	 */
	public String getdSerialStartTime() {
		return dSerialStartTime;
	}

	/**
	 * @param dSerialStartTime the dSerialStartTime to set
	 */
	public void setdSerialStartTime(String dSerialStartTime) {
		this.dSerialStartTime = dSerialStartTime;
	}

	/**
	 * @return the dSerialStopTime
	 */
	public String getdSerialStopTime() {
		return dSerialStopTime;
	}

	/**
	 * @param dSerialStopTime the dSerialStopTime to set
	 */
	public void setdSerialStopTime(String dSerialStopTime) {
		this.dSerialStopTime = dSerialStopTime;
	}

	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
