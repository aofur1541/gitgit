package com.kdis.PROM.tenant.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 호스트 네드워크 VO class
 * 
 * @author KimHahn
 *
 */
public class HostNetworkVO {

	/** 호스트 아이디 */
	private String hostID;

	/** 네트워크 아이디 */
	private String netWorkID;

	/** 네트워크 이름  */
	private String netWorkName;

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
	 * @return the netWorkID
	 */
	public String getNetWorkID() {
		return netWorkID;
	}

	/**
	 * @param netWorkID the netWorkID to set
	 */
	public void setNetWorkID(String netWorkID) {
		this.netWorkID = netWorkID;
	}

	/**
	 * @return the netWorkName
	 */
	public String getNetWorkName() {
		return netWorkName;
	}

	/**
	 * @param netWorkName the netWorkName to set
	 */
	public void setNetWorkName(String netWorkName) {
		this.netWorkName = netWorkName;
	}

	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
