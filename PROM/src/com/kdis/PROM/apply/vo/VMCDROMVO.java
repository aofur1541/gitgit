package com.kdis.PROM.apply.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 가상머신 CD-ROM VO class
 * 
 * @author KimHahn
 *
 */
public class VMCDROMVO {
	
	/** 가상머신 아이디  */
	private String sVmID;
	
	/** 가상머신 이름 */
	private String sVmName;
	
	/** 가상머신 번호  */
	private Integer nSCSInumber;
	
	/** 데이터스토어 이름 */
	private String dataStoreName;
	
	/** 파일경로  */
	private String filePath;
	
	/** 상태 */
	private String status;
	
	/** 서비스 고유번호  */
	private Integer serviceId;
	
	/** 권한  */
	private Integer role;

	/** 사유  */
	private String reasonContext;

	/** 모드 : MOUNT, UNMOUNT  */
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
	 * @return the filePath
	 */
	public String getFilePath() {
		return filePath;
	}

	/**
	 * @param filePath the filePath to set
	 */
	public void setFilePath(String filePath) {
		this.filePath = filePath;
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
