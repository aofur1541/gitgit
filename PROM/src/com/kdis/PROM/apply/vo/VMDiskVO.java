package com.kdis.PROM.apply.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 가상머신 Disk VO class
 * 
 * @author KimHahn
 *
 */
public class VMDiskVO {

	/** 가상머신 아이디 */
	private String sVmID;

	/** 가상머신 이름  */
	private String sVmName;

	/** 가상머신 번호  */
	private Integer nSCSInumber;

	/** 가상머신 디스크   */
	private String sDiskLocation;

	/** 서비스 디스크 용량  */
	private Integer nDiskCapacity;
	
	/** 서비스 고유번호  */
	private Integer serviceId;
	
	/** 서비스 디스크 고유번호  */
	private String sDiskId;
	
	/** 권한  */
	private Integer role;

	/** 사유  */
	private String reasonContext;

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
	 * @return the nSCSInumber
	 */
	public Integer getnSCSInumber() {
		return nSCSInumber;
	}

	/**
	 * @param nSCSInumber the nSCSInumber to set
	 */
	public void setnSCSInumber(Integer nSCSInumber) {
		this.nSCSInumber = nSCSInumber;
	}

	/**
	 * @return the sDiskLocation
	 */
	public String getsDiskLocation() {
		return sDiskLocation;
	}

	/**
	 * @param sDiskLocation the sDiskLocation to set
	 */
	public void setsDiskLocation(String sDiskLocation) {
		this.sDiskLocation = sDiskLocation;
	}

	/**
	 * @return the nDiskCapacity
	 */
	public Integer getnDiskCapacity() {
		return nDiskCapacity;
	}

	/**
	 * @param nDiskCapacity the nDiskCapacity to set
	 */
	public void setnDiskCapacity(Integer nDiskCapacity) {
		this.nDiskCapacity = nDiskCapacity;
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
	 * @return the sDiskId
	 */
	public String getsDiskId() {
		return sDiskId;
	}

	/**
	 * @param sDiskId the sDiskId to set
	 */
	public void setsDiskId(String sDiskId) {
		this.sDiskId = sDiskId;
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
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
		
}
