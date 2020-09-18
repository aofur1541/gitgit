package com.kdis.PROM.report.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 가상머신 보고서 VO class
 * 
 * @author KimHahn
 *
 */
public class VMReportVO {

	/** 가상머신 아이디  */
	private String vmID;

	/** 가상머신 이름  */
	private String vmName;

	/** 가상머신 cpu 용량  */
	private String vmCPU;

	/** 가상머신 메모리(GB)  */
	private String vmMemory;

	/** 가상머신 하드디스크(GB)  */
	private String vmDisk;

	/** 가상머신 운영체제  */
	private String vmOS;

	/** 가상머신 클러스터명  */
	private String clusterName;

	/** 가상머신 호스트명  */
	private String hostName;
	
	/** 가상머신 cpu 최대값 */
	private String maxCPU = "";
	
	/** 가상머신 메모리 최대값(GB) */
	private String maxMemory = "";
	
	/** 가상머신 cpu 평균값 */
	private String avgCPU = "";

	/** 가상머신 메모리 평균값(GB) */
	private String avgMemory = "";
	
	/** 가상머신 야간(20시~08시) cpu 최대값 */
	private String nightMaxCPU = "";
	
	/** 가상머신 야간(20시~08시) 메모리 최대값(GB) */
	private String nightMaxMemory = "";
	
	/** 가상머신 야간(20시~08시) cpu 평균값 */
	private String nightAvgCPU = "";

	/** 가상머신 야간(20시~08시) 메모리 평균값(GB) */
	private String nightAvgMemory = "";

	/** 가상머신 하드디스크 평균값(GB)  */
	private String avgDisk = "";

	/** 가상머신 네트워크 평균값 */
	private String avgNetwork = "";

	/** 테넌트명 */
	private String tenantName;

	/** 서비스명 */
	private String serviceName;
	
	/** 검색조건 : 시작일 */
	private String startDate;

	/** 검색조건 : 종료일 */
	private String endDate;

	/** 검색조건 : 테넌트 고유번호 */
	private Integer tenantId;

	/** 검색조건 : 서비스 고유번호 */
	private Integer serviceId;
	
	/** 검색조건 : 검색 기간 단위(1:일, 2:주, 3:월) */
	private Integer timeset;

	/** 검색조건 : 사용자 고유번호 */
	private Integer userId;
	
	/** 검색조건 : 사용자가 매핑된 테넌트 사용 여부  */
	private String isUserTenantMapping;
	
	/** 클러스터별 or 서비스그룹별 */
	private String category;
	
	/**
	 * @return the vmID
	 */
	public String getVmID() {
		return vmID;
	}

	/**
	 * @param vmID the vmID to set
	 */
	public void setVmID(String vmID) {
		this.vmID = vmID;
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
	 * @return the vmCPU
	 */
	public String getVmCPU() {
		return vmCPU;
	}

	/**
	 * @param vmCPU the vmCPU to set
	 */
	public void setVmCPU(String vmCPU) {
		this.vmCPU = vmCPU;
	}

	/**
	 * @return the vmMemory
	 */
	public String getVmMemory() {
		return vmMemory;
	}

	/**
	 * @param vmMemory the vmMemory to set
	 */
	public void setVmMemory(String vmMemory) {
		this.vmMemory = vmMemory;
	}

	/**
	 * @return the vmDisk
	 */
	public String getVmDisk() {
		return vmDisk;
	}

	/**
	 * @param vmDisk the vmDisk to set
	 */
	public void setVmDisk(String vmDisk) {
		this.vmDisk = vmDisk;
	}

	/**
	 * @return the vmOS
	 */
	public String getVmOS() {
		return vmOS;
	}

	/**
	 * @param vmOS the vmOS to set
	 */
	public void setVmOS(String vmOS) {
		this.vmOS = vmOS;
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
	 * @return the maxCPU
	 */
	public String getMaxCPU() {
		return maxCPU;
	}

	/**
	 * @param maxCPU the maxCPU to set
	 */
	public void setMaxCPU(String maxCPU) {
		this.maxCPU = maxCPU;
	}

	/**
	 * @return the maxMemory
	 */
	public String getMaxMemory() {
		return maxMemory;
	}

	/**
	 * @param maxMemory the maxMemory to set
	 */
	public void setMaxMemory(String maxMemory) {
		this.maxMemory = maxMemory;
	}

	/**
	 * @return the avgCPU
	 */
	public String getAvgCPU() {
		return avgCPU;
	}

	/**
	 * @param avgCPU the avgCPU to set
	 */
	public void setAvgCPU(String avgCPU) {
		this.avgCPU = avgCPU;
	}

	/**
	 * @return the avgMemory
	 */
	public String getAvgMemory() {
		return avgMemory;
	}

	/**
	 * @param avgMemory the avgMemory to set
	 */
	public void setAvgMemory(String avgMemory) {
		this.avgMemory = avgMemory;
	}

	/**
	 * @return the nightMaxCPU
	 */
	public String getNightMaxCPU() {
		return nightMaxCPU;
	}

	/**
	 * @param nightMaxCPU the nightMaxCPU to set
	 */
	public void setNightMaxCPU(String nightMaxCPU) {
		this.nightMaxCPU = nightMaxCPU;
	}

	/**
	 * @return the nightMaxMemory
	 */
	public String getNightMaxMemory() {
		return nightMaxMemory;
	}

	/**
	 * @param nightMaxMemory the nightMaxMemory to set
	 */
	public void setNightMaxMemory(String nightMaxMemory) {
		this.nightMaxMemory = nightMaxMemory;
	}

	/**
	 * @return the nightAvgCPU
	 */
	public String getNightAvgCPU() {
		return nightAvgCPU;
	}

	/**
	 * @param nightAvgCPU the nightAvgCPU to set
	 */
	public void setNightAvgCPU(String nightAvgCPU) {
		this.nightAvgCPU = nightAvgCPU;
	}

	/**
	 * @return the nightAvgMemory
	 */
	public String getNightAvgMemory() {
		return nightAvgMemory;
	}

	/**
	 * @param nightAvgMemory the nightAvgMemory to set
	 */
	public void setNightAvgMemory(String nightAvgMemory) {
		this.nightAvgMemory = nightAvgMemory;
	}

	/**
	 * @return the avgDisk
	 */
	public String getAvgDisk() {
		return avgDisk;
	}

	/**
	 * @param avgDisk the avgDisk to set
	 */
	public void setAvgDisk(String avgDisk) {
		this.avgDisk = avgDisk;
	}

	/**
	 * @return the avgNetwork
	 */
	public String getAvgNetwork() {
		return avgNetwork;
	}

	/**
	 * @param avgNetwork the avgNetwork to set
	 */
	public void setAvgNetwork(String avgNetwork) {
		this.avgNetwork = avgNetwork;
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
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}

	/**
	 * @param startDate the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
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
	 * @return the timeset
	 */
	public Integer getTimeset() {
		return timeset;
	}

	/**
	 * @param timeset the timeset to set
	 */
	public void setTimeset(Integer timeset) {
		this.timeset = timeset;
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
	 * @return the category
	 */
	public String getCategory() {
		return category;
	}

	/**
	 * @param category the category to set
	 */
	public void setCategory(String category) {
		this.category = category;
	}

	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
