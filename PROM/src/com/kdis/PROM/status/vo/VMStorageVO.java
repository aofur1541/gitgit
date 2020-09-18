package com.kdis.PROM.status.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * VM 스토리지 VO class
 * 
 * @author KimHahn
 *
 */
public class VMStorageVO {

	/** 스토리지 아이디  */
	private String stID;

	/** 스토리지 이름  */
	private String stName;

	/** 스토리지 총용량  */
	private int stAllca;

	/** 스토리지 사용용량  */
	private int stUseca;

	/** 스토리지 남은 용량  */
	private int stSpace;

	/** 업데이트 일시  */
	private String stDatetime;

	/**
	 * @return the stID
	 */
	public String getStID() {
		return stID;
	}

	/**
	 * @param stID the stID to set
	 */
	public void setStID(String stID) {
		this.stID = stID;
	}

	/**
	 * @return the stName
	 */
	public String getStName() {
		return stName;
	}

	/**
	 * @param stName the stName to set
	 */
	public void setStName(String stName) {
		this.stName = stName;
	}

	/**
	 * @return the stAllca
	 */
	public int getStAllca() {
		return stAllca;
	}

	/**
	 * @param stAllca the stAllca to set
	 */
	public void setStAllca(int stAllca) {
		this.stAllca = stAllca;
	}

	/**
	 * @return the stUseca
	 */
	public int getStUseca() {
		return stUseca;
	}

	/**
	 * @param stUseca the stUseca to set
	 */
	public void setStUseca(int stUseca) {
		this.stUseca = stUseca;
	}

	/**
	 * @return the stSpace
	 */
	public int getStSpace() {
		return stSpace;
	}

	/**
	 * @param stSpace the stSpace to set
	 */
	public void setStSpace(int stSpace) {
		this.stSpace = stSpace;
	}

	/**
	 * @return the stDatetime
	 */
	public String getStDatetime() {
		return stDatetime;
	}

	/**
	 * @param stDatetime the stDatetime to set
	 */
	public void setStDatetime(String stDatetime) {
		this.stDatetime = stDatetime;
	}

	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
