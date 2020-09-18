package com.kdis.PROM.performance.vo;

import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 성능 VO class
 * 
 * @author KimHahn
 *
 */
public class PerformanceVO {

	/** 가상머신 아이디 */
	private String vmID;
	
	/** 가상머신명 */
	private String vmName;
	
	/** 가상머신 CPU 합계 */
	private double sumCPU;

	/** 가상머신 메모리 합계 */
	private double sumMemory;

	/** 가상머신 디스크 합계 */
	private double sumDisk;

	/** 호스트 스레드 합계 */
	private double sumThread;

	/** 가상머신 개수 */
	private double countVM;

	/** 호스트 개수 */
	private double countHost;

	/** 가상머신 cpu */
	private double cpu;

	/** 가상머신 메모리 (GB) */
	private double memory;

	/** 가상머신 하드디스크 (GB)  */
	private double disk;

	/** 가상머신 네트워크 */
	private double network;
	
	/** 가상머신 cpu 평균값 */
	private double avgCPU;

	/** 가상머신 메모리 평균값(GB) */
	private double avgMemory;

	/** 가상머신 하드디스크 평균값(GB)  */
	private double avgDisk;

	/** 가상머신 네트워크 평균값 */
	private double avgNetwork;

	/** 일시 */
	private Date timestamp; 

	/** 표시용 일시 */
	private String dispTimestamp;
	
	/** 테넌트 ID */
	private Integer tenantId;
	
	/** 테넌트명 */
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
	
	/** 보기 단위(0:20초, 1:5분, 2:30분, 3:2시간, 4:24시간) */
	private Integer period;

	/** 대상 테이블 */
	private String targetTable;
	
	/** 클러스터별 or 서비스그룹별 */
	private String category;
	
	/** 사용자가 매핑된 테넌트 사용 여부  */
	private String isUserTenantMapping;
	
	/** 사용자 고유번호 */
	private Integer userId;
	
	/** 에이전트 UUID */
	private String resourceId;
	
	/** 검색조건 : 시작일 */
	private String startDate;

	/** 검색조건 : 종료일 */
	private String endDate;
	
	/** 검색조건 : 시작 시간 */
	private String startTime;

	/** 검색조건 : 종료 시간 */
	private String endTime;

	/** 검색조건 : 정렬 */
	private String order;

	private int cnt;
	
	private int co; 
	
	public int getCo() {
		return co;
	}

	public void setCo(int co) {
		this.co = co;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	
	
	
	
	
	
	
	/** 검색조건 : 정렬 */
	private Integer calc;
	
	private Integer pnicKBytesRx;
	
	private Integer pnicKBytesTx;
	
	private Integer speedMB;
	
	private String adaptersName;
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
	 * @return the sumCPU
	 */
	public double getSumCPU() {
		return sumCPU;
	}

	/**
	 * @param sumCPU the sumCPU to set
	 */
	public void setSumCPU(double sumCPU) {
		this.sumCPU = sumCPU;
	}

	/**
	 * @return the sumMemory
	 */
	public double getSumMemory() {
		return sumMemory;
	}

	/**
	 * @param sumMemory the sumMemory to set
	 */
	public void setSumMemory(double sumMemory) {
		this.sumMemory = sumMemory;
	}

	/**
	 * @return the sumDisk
	 */
	public double getSumDisk() {
		return sumDisk;
	}

	/**
	 * @param sumDisk the sumDisk to set
	 */
	public void setSumDisk(double sumDisk) {
		this.sumDisk = sumDisk;
	}

	/**
	 * @return the sumThread
	 */
	public double getSumThread() {
		return sumThread;
	}

	/**
	 * @param sumThread the sumThread to set
	 */
	public void setSumThread(double sumThread) {
		this.sumThread = sumThread;
	}

	/**
	 * @return the countVM
	 */
	public double getCountVM() {
		return countVM;
	}

	/**
	 * @param countVM the countVM to set
	 */
	public void setCountVM(double countVM) {
		this.countVM = countVM;
	}

	/**
	 * @return the countHost
	 */
	public double getCountHost() {
		return countHost;
	}

	/**
	 * @param countHost the countHost to set
	 */
	public void setCountHost(double countHost) {
		this.countHost = countHost;
	}

	/**
	 * @return the cpu
	 */
	public double getCpu() {
		return cpu;
	}

	/**
	 * @param cpu the cpu to set
	 */
	public void setCpu(double cpu) {
		this.cpu = cpu;
	}

	/**
	 * @return the memory
	 */
	public double getMemory() {
		return memory;
	}

	/**
	 * @param memory the memory to set
	 */
	public void setMemory(double memory) {
		this.memory = memory;
	}

	/**
	 * @return the disk
	 */
	public double getDisk() {
		return disk;
	}

	/**
	 * @param disk the disk to set
	 */
	public void setDisk(double disk) {
		this.disk = disk;
	}

	/**
	 * @return the network
	 */
	public double getNetwork() {
		return network;
	}

	/**
	 * @param network the network to set
	 */
	public void setNetwork(double network) {
		this.network = network;
	}

	/**
	 * @return the avgCPU
	 */
	public double getAvgCPU() {
		return avgCPU;
	}

	/**
	 * @param avgCPU the avgCPU to set
	 */
	public void setAvgCPU(double avgCPU) {
		this.avgCPU = avgCPU;
	}

	/**
	 * @return the avgMemory
	 */
	public double getAvgMemory() {
		return avgMemory;
	}

	/**
	 * @param avgMemory the avgMemory to set
	 */
	public void setAvgMemory(double avgMemory) {
		this.avgMemory = avgMemory;
	}

	/**
	 * @return the avgDisk
	 */
	public double getAvgDisk() {
		return avgDisk;
	}

	/**
	 * @param avgDisk the avgDisk to set
	 */
	public void setAvgDisk(double avgDisk) {
		this.avgDisk = avgDisk;
	}

	/**
	 * @return the avgNetwork
	 */
	public double getAvgNetwork() {
		return avgNetwork;
	}

	/**
	 * @param avgNetwork the avgNetwork to set
	 */
	public void setAvgNetwork(double avgNetwork) {
		this.avgNetwork = avgNetwork;
	}

	/**
	 * @return the timestamp
	 */
	public Date getTimestamp() {
		return timestamp;
	}

	/**
	 * @param timestamp the timestamp to set
	 */
	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}

	/**
	 * @return the dispTimestamp
	 */
	public String getDispTimestamp() {
		return dispTimestamp;
	}

	/**
	 * @param dispTimestamp the dispTimestamp to set
	 */
	public void setDispTimestamp(String dispTimestamp) {
		this.dispTimestamp = dispTimestamp;
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
	 * @return the period
	 */
	public Integer getPeriod() {
		return period;
	}

	/**
	 * @param period the period to set
	 */
	public void setPeriod(Integer period) {
		this.period = period;
	}

	/**
	 * @return the targetTable
	 */
	public String getTargetTable() {
		return targetTable;
	}

	/**
	 * @param targetTable the targetTable to set
	 */
	public void setTargetTable(String targetTable) {
		this.targetTable = targetTable;
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
	 * @return the resourceId
	 */
	public String getResourceId() {
		return resourceId;
	}

	/**
	 * @param resourceId the resourceId to set
	 */
	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
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
	 * @return the startTime
	 */
	public String getStartTime() {
		return startTime;
	}

	/**
	 * @param startTime the startTime to set
	 */
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	/**
	 * @return the order
	 */
	public String getOrder() {
		return order;
	}

	/**
	 * @param order the order to set
	 */
	public void setOrder(String order) {
		this.order = order;
	}

	/**
	 * @return the calc
	 */
	public Integer getCalc() {
		return calc;
	}

	/**
	 * @param calc the calc to set
	 */
	public void setCalc(Integer calc) {
		this.calc = calc;
	}

	@Override
	public String toString() {
		return "PerformanceVO [vmID=" + vmID + ", vmName=" + vmName + ", sumCPU=" + sumCPU + ", sumMemory=" + sumMemory
				+ ",\r sumDisk=" + sumDisk + ", sumThread=" + sumThread + ", countVM=" + countVM + ", countHost="
				+ countHost + ", cpu=" + cpu + ", memory=" + memory + ", disk=" + disk + ", network=" + network
				+ ", avgCPU=" + avgCPU + ", avgMemory=" + avgMemory + ", avgDisk=" + avgDisk + ", avgNetwork="
				+ avgNetwork + ", timestamp=" + timestamp + ",\r dispTimestamp=" + dispTimestamp + ", tenantId="
				+ tenantId + ", tenantName=" + tenantName + ", serviceId=" + serviceId + ", serviceName=" + serviceName
				+ ", clusterId=" + clusterId + ", clusterName=" + clusterName + ", hostId=" + hostId + ", hostName="
				+ hostName + ", period=" + period + ", targetTable=" + targetTable + ",\r category=" + category
				+ ", isUserTenantMapping=" + isUserTenantMapping + ", userId=" + userId + ", resourceId=" + resourceId
				+ ",\r startDate=" + startDate + ", endDate=" + endDate + ", startTime=" + startTime + ", endTime="
				+ endTime + ", order=" + order + ", cnt=" + cnt + ", co=" + co + ", calc=" + calc + ", pnicKBytesRx="
				+ pnicKBytesRx + ",\r pnicKBytesTx=" + pnicKBytesTx + ", speedMB=" + speedMB + ", adaptersName="
				+ adaptersName + "]";
	}

	public Integer getPnicKBytesRx() {
		return pnicKBytesRx;
	}

	public void setPnicKBytesRx(Integer pnicKBytesRx) {
		this.pnicKBytesRx = pnicKBytesRx;
	}

	public Integer getPnicKBytesTx() {
		return pnicKBytesTx;
	}

	public void setPnicKBytesTx(Integer pnicKBytesTx) {
		this.pnicKBytesTx = pnicKBytesTx;
	}

	public Integer getSpeedMB() {
		return speedMB;
	}

	public void setSpeedMB(Integer speedMB) {
		this.speedMB = speedMB;
	}

	public String getAdaptersName() {
		return adaptersName;
	}

	public void setAdaptersName(String adaptersName) {
		this.adaptersName = adaptersName;
	}
	
}
