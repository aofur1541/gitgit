package com.kdis.PROM.apply.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 가상머신 Disk VO class
 * 
 * @author KimHahn
 *
 */
public class VMNetworkVO {

	/** 가상머신 아이디 */
	private String sVmID;

	/** 가상머신 이름  */
	private String sVmName;

	/** 네트워크 구분번호 */
	private Integer labelNumber;

	/** 네트워크 구분번호 */
	private String macAddress;

	/** 포트 그룹  */
	private String portgroup;

	/** 아이피 주소  */
	private String ipAddress;

	/** 상태  */
	private String status;
	
	/** 포트 그룹 ID */
	private String portgroupId;
	
	/** 서비스 고유번호  */
	private Integer serviceId;
	
	/** 권한  */
	private Integer role;

	/** 사유  */
	private String reasonContext;
	
	/** 모드 : 연결(Connect), 연결 해제(Disconnect), 삭제(Remove)  */
	private String mode;
	
	/**
	 * @return the sVmID
	 */
	public String getsVmID() {
		return sVmID;
	}

	/**
	 * @param sVmID the sVmID to set
	 */
	public void setsVmID(String sVmID) {
		this.sVmID = sVmID;
	}

	/**
	 * @return the sVmName
	 */
	public String getsVmName() {
		return sVmName;
	}

	/**
	 * @param sVmName the sVmName to set
	 */
	public void setsVmName(String sVmName) {
		this.sVmName = sVmName;
	}

	/**
	 * @return the labelNumber
	 */
	public Integer getLabelNumber() {
		return labelNumber;
	}

	/**
	 * @param labelNumber the labelNumber to set
	 */
	public void setLabelNumber(Integer labelNumber) {
		this.labelNumber = labelNumber;
	}

	/**
	 * @return the macAddress
	 */
	public String getMacAddress() {
		return macAddress;
	}

	/**
	 * @param macAddress the macAddress to set
	 */
	public void setMacAddress(String macAddress) {
		this.macAddress = macAddress;
	}

	/**
	 * @return the portgroup
	 */
	public String getPortgroup() {
		return portgroup;
	}

	/**
	 * @param portgroup the portgroup to set
	 */
	public void setPortgroup(String portgroup) {
		this.portgroup = portgroup;
	}

	/**
	 * @return the ipAddress
	 */
	public String getIpAddress() {
		return ipAddress;
	}

	/**
	 * @param ipAddress the ipAddress to set
	 */
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return the portgroupId
	 */
	public String getPortgroupId() {
		return portgroupId;
	}

	/**
	 * @param portgroupId the portgroupId to set
	 */
	public void setPortgroupId(String portgroupId) {
		this.portgroupId = portgroupId;
	}

	/**
	 * @return the serviceId
	 */
	public Integer getServiceId() {
		return serviceId;
	}

	/**
	 * @param serviceId the serviceId to set
	 */
	public void setServiceId(Integer serviceId) {
		this.serviceId = serviceId;
	}

	/**
	 * @return the role
	 */
	public Integer getRole() {
		return role;
	}

	/**
	 * @param role the role to set
	 */
	public void setRole(Integer role) {
		this.role = role;
	}

	/**
	 * @return the reasonContext
	 */
	public String getReasonContext() {
		return reasonContext;
	}

	/**
	 * @param reasonContext the reasonContext to set
	 */
	public void setReasonContext(String reasonContext) {
		this.reasonContext = reasonContext;
	}

	/**
	 * @return the mode
	 */
	public String getMode() {
		return mode;
	}

	/**
	 * @param mode the mode to set
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}

	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
}
