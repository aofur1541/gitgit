package com.kdis.PROM.tenant.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 호스트 데이터 스토어 VO class
 * 
 * @author KimHahn
 *
 */
public class HostDataStoreVO {

	/** 호스트 아이디  */
	private String hostID;
	
	/** 데이터 스토어 아이디  */
	private String dataStoreID;
	
	/** 데이터 스토어 이름  */
	private String dataStoreName;
	
	/** 스토리지 총용량 */
	private int stAllca;
	
	/** 스토리 사용용량 */
	private int stUseca;
	
	/** 스토리지 남은 용량  */
	private int stSpace;

	/**
	 * @return the hostID
	 */
	public String getHostID() {
		return hostID;
	}

	/**
	 * @param hostID the hostID to set
	 */
	public void setHostID(String hostID) {
		this.hostID = hostID;
	}

	/**
	 * @return the dataStoreID
	 */
	public String getDataStoreID() {
		return dataStoreID;
	}

	/**
	 * @param dataStoreID the dataStoreID to set
	 */
	public void setDataStoreID(String dataStoreID) {
		this.dataStoreID = dataStoreID;
	}

	/**
	 * @return the dataStoreName
	 */
	public String getDataStoreName() {
		return dataStoreName;
	}

	/**
	 * @param dataStoreName the dataStoreName to set
	 */
	public void setDataStoreName(String dataStoreName) {
		this.dataStoreName = dataStoreName;
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
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
