package com.kdis.PROM.report.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 호스트 보고서 VO class
 * 
 * @author KimHahn
 *
 */
public class HostReportVO {

	/** 호스트 아이디  */
	private String vmHID;

	/** 호스트명  */
	private String hostName;

	/** 호스트 cpu 용량  */
	private String hostCPU;

	/** 호스트 메모리(GB)  */
	private String hostMemory;

	/** 호스트 CPU 모델  */
	private String cpuModel;

	/** 가상머신 개수  */
	private Integer vmCount;
	
	/** 가상머신 CPU 합계  */
	private String sumCPU;

	/** 가상머신 메모리 합계  */
	private String sumMemory;

	/** 클러스터명  */
	private String clusterName;
	
	/** 호스트 cpu 최대값 */
	private String maxCPU = "";
	
	/** 호스트 메모리 최대값(GB) */
	private String maxMemory = "";
	
	/** 호스트 cpu 평균값 */
	private String avgCPU = "";

	/** 호스트 메모리 평균값(GB) */
	private String avgMemory = "";
	
	/** 호스트 야간(20시~08시) cpu 최대값 */
	private String nightMaxCPU = "";
	
	/** 호스트 야간(20시~08시) 메모리 최대값(GB) */
	private String nightMaxMemory = "";
	
	/** 호스트 야간(20시~08시) cpu 평균값 */
	private String nightAvgCPU = "";

	/** 호스트 야간(20시~08시) 메모리 평균값(GB) */
	private String nightAvgMemory = "";

	/** 호스트 하드디스크 평균값(GB)  */
	private String avgDisk = "";

	/** 호스트 네트워크 평균값 */
	private String avgNetwork = "";
	
	/** 검색조건 : 시작일 */
	private String startDate;

	/** 검색조건 : 종료일 */
	private String endDate;
	
	/** 검색조건 : 구분 */
	private String category;
	
	/** 검색조건 : 검색 기간 단위(1:일, 2:주, 3:월) */
	private Integer timeset;

	/**
	 * @return the vmHID
	 */
	public String getVmHID() {
		return vmHID;
	}

	/**
	 * @param vmHID the vmHID to set
	 */
	public void setVmHID(String vmHID) {
		this.vmHID = vmHID;
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
	 * @return the hostCPU
	 */
	public String getHostCPU() {
		return hostCPU;
	}

	/**
	 * @param hostCPU the hostCPU to set
	 */
	public void setHostCPU(String hostCPU) {
		this.hostCPU = hostCPU;
	}

	/**
	 * @return the hostMemory
	 */
	public String getHostMemory() {
		return hostMemory;
	}

	/**
	 * @param hostMemory the hostMemory to set
	 */
	public void setHostMemory(String hostMemory) {
		this.hostMemory = hostMemory;
	}

	/**
	 * @return the cpuModel
	 */
	public String getCpuModel() {
		return cpuModel;
	}

	/**
	 * @param cpuModel the cpuModel to set
	 */
	public void setCpuModel(String cpuModel) {
		this.cpuModel = cpuModel;
	}

	/**
	 * @return the vmCount
	 */
	public Integer getVmCount() {
		return vmCount;
	}

	/**
	 * @param vmCount the vmCount to set
	 */
	public void setVmCount(Integer vmCount) {
		this.vmCount = vmCount;
	}

	/**
	 * @return the sumCPU
	 */
	public String getSumCPU() {
		return sumCPU;
	}

	/**
	 * @param sumCPU the sumCPU to set
	 */
	public void setSumCPU(String sumCPU) {
		this.sumCPU = sumCPU;
	}

	/**
	 * @return the sumMemory
	 */
	public String getSumMemory() {
		return sumMemory;
	}

	/**
	 * @param sumMemory the sumMemory to set
	 */
	public void setSumMemory(String sumMemory) {
		this.sumMemory = sumMemory;
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
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
