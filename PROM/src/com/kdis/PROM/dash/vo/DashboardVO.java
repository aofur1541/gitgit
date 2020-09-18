package com.kdis.PROM.dash.vo;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.kdis.PROM.performance.vo.PerformanceVO;

/**
 * 대시보드 VO class
 * 
 * @author KimHahn
 *
 */
public class DashboardVO {

	/** 테넌트 수 */
	private String tenantCount;

	/** 서비스 수 */
	private String serviceCount;

	/** 가상머신 수 */
	private String vmCount;

	/** 전원 ON 가상머신 수 */
	private String vmOnCount;

	/** 전원 OFF 가상머신 수 */
	private String vmOffCount;

	/** CPU 합계 */
	private String cpuTotal;

	/** 메모리 합계 */
	private String memoryTotal;
	
	/** CPU TOP 5 목록 */
	private List<PerformanceVO> cpuTop5List;

	/** memory TOP 5 목록 */
	private List<PerformanceVO> memoryTop5List;

	/** disk TOP 5 목록 */
	private List<PerformanceVO> diskTop5List;

	/** networ TOP 5 목록 */
	private List<PerformanceVO> networkTop5List;

	/** 클러스터 ID */
	private String clusterId;
	
	/** 검색조건 : integrateWidgetList  */
	private String integrateWidgetList;
	
	/** 검색조건 : clusterWidgetListId   */
	private String clusterWidgetListId ;

	/** 검색조건 : _integrateWidgetOrder   */
	private String integrateWidgetOrder;
	
	/** 검색조건 : _clusterWidgetOrder   */
	private String clusterWidgetOrder;

	private String cluster_id;
	
	private String controlClusterStatus;
	
	private String mgmtClusterStatusStaus;
	
	private String uuid;
	
	private String mgmtClusterListenIpAddress;
	
	private int status;
	
	
	public String getIntegrateWidgetList() {
		return integrateWidgetList;
	}

	public void setIntegrateWidgetList(String integrateWidgetList) {
		this.integrateWidgetList = integrateWidgetList;
	}

	public String getClusterWidgetListId() {
		return clusterWidgetListId;
	}

	public void setClusterWidgetListId(String clusterWidgetListId) {
		this.clusterWidgetListId = clusterWidgetListId;
	}

	

	/**
	 * @return the tenantCount
	 */
	public String getTenantCount() {
		return tenantCount;
	}

	/**
	 * @param tenantCount the tenantCount to set
	 */
	public void setTenantCount(String tenantCount) {
		this.tenantCount = tenantCount;
	}

	/**
	 * @return the serviceCount
	 */
	public String getServiceCount() {
		return serviceCount;
	}

	/**
	 * @param serviceCount the serviceCount to set
	 */
	public void setServiceCount(String serviceCount) {
		this.serviceCount = serviceCount;
	}

	/**
	 * @return the vmCount
	 */
	public String getVmCount() {
		return vmCount;
	}

	/**
	 * @param vmCount the vmCount to set
	 */
	public void setVmCount(String vmCount) {
		this.vmCount = vmCount;
	}

	/**
	 * @return the vmOnCount
	 */
	public String getVmOnCount() {
		return vmOnCount;
	}

	/**
	 * @param vmOnCount the vmOnCount to set
	 */
	public void setVmOnCount(String vmOnCount) {
		this.vmOnCount = vmOnCount;
	}

	/**
	 * @return the vmOffCount
	 */
	public String getVmOffCount() {
		return vmOffCount;
	}

	/**
	 * @param vmOffCount the vmOffCount to set
	 */
	public void setVmOffCount(String vmOffCount) {
		this.vmOffCount = vmOffCount;
	}

	/**
	 * @return the cpuTotal
	 */
	public String getCpuTotal() {
		return cpuTotal;
	}

	/**
	 * @param cpuTotal the cpuTotal to set
	 */
	public void setCpuTotal(String cpuTotal) {
		this.cpuTotal = cpuTotal;
	}

	/**
	 * @return the memoryTotal
	 */
	public String getMemoryTotal() {
		return memoryTotal;
	}

	/**
	 * @param memoryTotal the memoryTotal to set
	 */
	public void setMemoryTotal(String memoryTotal) {
		this.memoryTotal = memoryTotal;
	}
	
	/**
	 * @return the cpuTop5List
	 */
	public List<PerformanceVO> getCpuTop5List() {
		return cpuTop5List;
	}

	/**
	 * @param cpuTop5List the cpuTop5List to set
	 */
	public void setCpuTop5List(List<PerformanceVO> cpuTop5List) {
		this.cpuTop5List = cpuTop5List;
	}

	/**
	 * @return the memoryTop5List
	 */
	public List<PerformanceVO> getMemoryTop5List() {
		return memoryTop5List;
	}

	/**
	 * @param memoryTop5List the memoryTop5List to set
	 */
	public void setMemoryTop5List(List<PerformanceVO> memoryTop5List) {
		this.memoryTop5List = memoryTop5List;
	}

	/**
	 * @return the diskTop5List
	 */
	public List<PerformanceVO> getDiskTop5List() {
		return diskTop5List;
	}

	/**
	 * @param diskTop5List the diskTop5List to set
	 */
	public void setDiskTop5List(List<PerformanceVO> diskTop5List) {
		this.diskTop5List = diskTop5List;
	}

	/**
	 * @return the networkTop5List
	 */
	public List<PerformanceVO> getNetworkTop5List() {
		return networkTop5List;
	}

	/**
	 * @param networkTop5List the networkTop5List to set
	 */
	public void setNetworkTop5List(List<PerformanceVO> networkTop5List) {
		this.networkTop5List = networkTop5List;
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
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }

	public String getIntegrateWidgetOrder() {
		return integrateWidgetOrder;
	}

	public void setIntegrateWidgetOrder(String integrateWidgetOrder) {
		this.integrateWidgetOrder = integrateWidgetOrder;
	}

	public String getClusterWidgetOrder() {
		return clusterWidgetOrder;
	}

	public void setClusterWidgetOrder(String clusterWidgetOrder) {
		this.clusterWidgetOrder = clusterWidgetOrder;
	}

	public String getCluster_id() {
		return cluster_id;
	}

	public void setCluster_id(String cluster_id) {
		this.cluster_id = cluster_id;
	}

	public String getControlClusterStatus() {
		return controlClusterStatus;
	}

	public void setControlClusterStatus(String controlClusterStatus) {
		this.controlClusterStatus = controlClusterStatus;
	}

	public String getMgmtClusterStatusStaus() {
		return mgmtClusterStatusStaus;
	}

	public void setMgmtClusterStatusStaus(String mgmtClusterStatusStaus) {
		this.mgmtClusterStatusStaus = mgmtClusterStatusStaus;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getMgmtClusterListenIpAddress() {
		return mgmtClusterListenIpAddress;
	}

	public void setMgmtClusterListenIpAddress(String mgmtClusterListenIpAddress) {
		this.mgmtClusterListenIpAddress = mgmtClusterListenIpAddress;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
}
