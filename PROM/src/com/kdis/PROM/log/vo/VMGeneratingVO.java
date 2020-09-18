package com.kdis.PROM.log.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 가상머신 이력 VO
 * 
 * @author KimHahn
 *
 */
public class VMGeneratingVO {

	/** 고유 번호  */
	private Integer nNumber;

	/** 가상머신 이름  */
	private String vmName;

	/** 구분자(1:생성, 2:변경, 3:삭제)  */
	private Integer distinction;

	/** 생성상태  */
	private String createStatus;

	/** 완료상태(0:진행중, 1:성공, 3:비정상 종료) */
	private Integer finishStatus;

	/** 생성일시  */
	private String dStartTime;

	/** 종료 일시  */
	private String dEndTime;

	/** 에러 코드  */
	private String sErrorCode;

	/** 에러 구분자(0:에러 미확인, 1:에러 확인)  */
	private Integer errorCheck;

	/** 생성 진행중 개수  */
	private Integer creatingCnt;
	
	/** 변경 진행중 개수  */
	private Integer updatingCnt;
	
	/** 테넌트 고유번호  */
	private Integer tenantId;
	
	/** 테넌트명  */
	private String tenantName;
	
	/** 서비스 ID */
	private Integer serviceId;
	
	/** 서비스명 */
	private String serviceName;
	
	/** 클러스터 ID */
	private String clusterId;
	
	/** 클러스터명 */
	private String clusterName;
	
	/** 호스트 ID */
	private String hostId;
	
	/** 호스트명 */
	private String hostName;
	
	/** 사용자 고유번호 */
	private Integer userId;
	
	/** 사용자가 매핑된 테넌트 사용 여부  */
	private String isUserTenantMapping;

	/**
	 * @return the nNumber
	 */
	public Integer getnNumber() {
		return nNumber;
	}

	/**
	 * @param nNumber the nNumber to set
	 */
	public void setnNumber(Integer nNumber) {
		this.nNumber = nNumber;
	}

	/**
	 * @return the vmName
	 */
	public String getVmName() {
		return vmName;
	}

	/**
	 * @param vmName the vmName to set
	 */
	public void setVmName(String vmName) {
		this.vmName = vmName;
	}

	/**
	 * @return the distinction
	 */
	public Integer getDistinction() {
		return distinction;
	}

	/**
	 * @param distinction the distinction to set
	 */
	public void setDistinction(Integer distinction) {
		this.distinction = distinction;
	}

	/**
	 * @return the createStatus
	 */
	public String getCreateStatus() {
		return createStatus;
	}

	/**
	 * @param createStatus the createStatus to set
	 */
	public void setCreateStatus(String createStatus) {
		this.createStatus = createStatus;
	}

	/**
	 * @return the finishStatus
	 */
	public Integer getFinishStatus() {
		return finishStatus;
	}

	/**
	 * @param finishStatus the finishStatus to set
	 */
	public void setFinishStatus(Integer finishStatus) {
		this.finishStatus = finishStatus;
	}

	/**
	 * @return the dStartTime
	 */
	public String getdStartTime() {
		return dStartTime;
	}

	/**
	 * @param dStartTime the dStartTime to set
	 */
	public void setdStartTime(String dStartTime) {
		this.dStartTime = dStartTime;
	}

	/**
	 * @return the dEndTime
	 */
	public String getdEndTime() {
		return dEndTime;
	}

	/**
	 * @param dEndTime the dEndTime to set
	 */
	public void setdEndTime(String dEndTime) {
		this.dEndTime = dEndTime;
	}

	/**
	 * @return the sErrorCode
	 */
	public String getsErrorCode() {
		return sErrorCode;
	}

	/**
	 * @param sErrorCode the sErrorCode to set
	 */
	public void setsErrorCode(String sErrorCode) {
		this.sErrorCode = sErrorCode;
	}

	/**
	 * @return the errorCheck
	 */
	public Integer getErrorCheck() {
		return errorCheck;
	}

	/**
	 * @param errorCheck the errorCheck to set
	 */
	public void setErrorCheck(Integer errorCheck) {
		this.errorCheck = errorCheck;
	}

	/**
	 * @return the creatingCnt
	 */
	public Integer getCreatingCnt() {
		return creatingCnt;
	}

	/**
	 * @param creatingCnt the creatingCnt to set
	 */
	public void setCreatingCnt(Integer creatingCnt) {
		this.creatingCnt = creatingCnt;
	}

	/**
	 * @return the updatingCnt
	 */
	public Integer getUpdatingCnt() {
		return updatingCnt;
	}

	/**
	 * @param updatingCnt the updatingCnt to set
	 */
	public void setUpdatingCnt(Integer updatingCnt) {
		this.updatingCnt = updatingCnt;
	}
	
	/**
	 * @return the tenantId
	 */
	public Integer getTenantId() {
		return tenantId;
	}

	/**
	 * @param tenantId the tenantId to set
	 */
	public void setTenantId(Integer tenantId) {
		this.tenantId = tenantId;
	}

	/**
	 * @return the tenantName
	 */
	public String getTenantName() {
		return tenantName;
	}

	/**
	 * @param tenantName the tenantName to set
	 */
	public void setTenantName(String tenantName) {
		this.tenantName = tenantName;
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
	 * @return the serviceName
	 */
	public String getServiceName() {
		return serviceName;
	}

	/**
	 * @param serviceName the serviceName to set
	 */
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	/**
	 * @return the clusterId
	 */
	public String getClusterId() {
		return clusterId;
	}

	/**
	 * @param clusterId the clusterId to set
	 */
	public void setClusterId(String clusterId) {
		this.clusterId = clusterId;
	}

	/**
	 * @return the clusterName
	 */
	public String getClusterName() {
		return clusterName;
	}

	/**
	 * @param clusterName the clusterName to set
	 */
	public void setClusterName(String clusterName) {
		this.clusterName = clusterName;
	}

	/**
	 * @return the hostId
	 */
	public String getHostId() {
		return hostId;
	}

	/**
	 * @param hostId the hostId to set
	 */
	public void setHostId(String hostId) {
		this.hostId = hostId;
	}

	/**
	 * @return the hostName
	 */
	public String getHostName() {
		return hostName;
	}

	/**
	 * @param hostName the hostName to set
	 */
	public void setHostName(String hostName) {
		this.hostName = hostName;
	}

	/**
	 * @return the userId
	 */
	public Integer getUserId() {
		return userId;
	}

	/**
	 * @param userId the userId to set
	 */
	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	/**
	 * @return the isUserTenantMapping
	 */
	public String getIsUserTenantMapping() {
		return isUserTenantMapping;
	}

	/**
	 * @param isUserTenantMapping the isUserTenantMapping to set
	 */
	public void setIsUserTenantMapping(String isUserTenantMapping) {
		this.isUserTenantMapping = isUserTenantMapping;
	}

	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
