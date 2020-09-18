package com.kdis.PROM.apply.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 가상머신 VO class
 * 
 * @author KimHahn
 *
 */
public class VMDataVO {

	/** 가상머신 아이디  */
	private String vmID;

	/** 가상머신 이름  */
	private String vmName;

	/** 가상머신 cpu 용량  */
	private Integer vmCPU;

	/** 가상머신 메모리(GB)  */
	private Integer vmMemory;

	/** 가상머신 하드디스크(GB)  */
	private Integer vmDisk;

	/** 가상머신 호스트  */
	private String vmHost;

	/** 가상머신 데이터스토어  */
	private String vmDataStore;

	/** 가상머신 툴 사용상태  */
	private String vmtoolsStatus;

	/** 가상머신 아이피 주소  */
	private String vmIpaddr1;

	/** 예비 아이피 주소  */
	private String vmIpaddr2;

	/** 예비2 아이피 주소  */
	private String vmIpaddr3;

	/** 가상머신 전원 상태  */
	private String vmStatus;

	/** 템플릿 사용 (true:VM 템플릿 , false:실제 VM)  */
	private String vmTemplet;

	/** 가상머신 운영체제  */
	private String vmOS;

	/** 가상머신 서비스 아이디  */
	private Integer vmServiceID;
	
	/** 가상머신 생성일자  */
	private String vmCreatetime;

	/** 가상머신 연결상태  */
	private String vmDevices;

	/** (미사용)  */
	private String sEpNum;

	/** 가상머신 cpu추가  */
	private String cpuHotAdd;

	/** 가상머신 메모리추가  */
	private String memoryHotAdd;

	/** 템플릿 상태 (1:ON, 0:OFF)  */
	private Integer templateOnoff;

	/** 설명  */
	private String description = "";
	
	/** 가상머신 서비스명  */
	private String vmServiceName;
	
	/** 테넌트 아이디  */
	private Integer tenantId;
	
	/** 테넌트명  */
	private String tenantName;
	
	/** 호스트 ID  */
	private String hostId;
	
	/** 클러스터 ID  */
	private String clusterId;
	
	/** 클러스터명 */
	private String clusterName;
	
	/** 사용자 고유번호 */
	private Integer userId;
	
	/** 검색어  */
	private String searchParam;
	
	/** 정렬:AES, DESC  */
	private String sort;
	
	private String hostName;
	
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
	 * @return the vmCPU
	 */
	public Integer getVmCPU() {
		return vmCPU;
	}

	/**
	 * @param vmCPU the vmCPU to set
	 */
	public void setVmCPU(Integer vmCPU) {
		this.vmCPU = vmCPU;
	}

	/**
	 * @return the vmMemory
	 */
	public Integer getVmMemory() {
		return vmMemory;
	}

	/**
	 * @param vmMemory the vmMemory to set
	 */
	public void setVmMemory(Integer vmMemory) {
		this.vmMemory = vmMemory;
	}

	/**
	 * @return the vmDisk
	 */
	public Integer getVmDisk() {
		return vmDisk;
	}

	/**
	 * @param vmDisk the vmDisk to set
	 */
	public void setVmDisk(Integer vmDisk) {
		this.vmDisk = vmDisk;
	}

	/**
	 * @return the vmHost
	 */
	public String getVmHost() {
		return vmHost;
	}

	/**
	 * @param vmHost the vmHost to set
	 */
	public void setVmHost(String vmHost) {
		this.vmHost = vmHost;
	}

	/**
	 * @return the vmDataStore
	 */
	public String getVmDataStore() {
		return vmDataStore;
	}

	/**
	 * @param vmDataStore the vmDataStore to set
	 */
	public void setVmDataStore(String vmDataStore) {
		this.vmDataStore = vmDataStore;
	}

	/**
	 * @return the vmtoolsStatus
	 */
	public String getVmtoolsStatus() {
		return vmtoolsStatus;
	}

	/**
	 * @param vmtoolsStatus the vmtoolsStatus to set
	 */
	public void setVmtoolsStatus(String vmtoolsStatus) {
		this.vmtoolsStatus = vmtoolsStatus;
	}

	/**
	 * @return the vmIpaddr1
	 */
	public String getVmIpaddr1() {
		return vmIpaddr1;
	}

	/**
	 * @param vmIpaddr1 the vmIpaddr1 to set
	 */
	public void setVmIpaddr1(String vmIpaddr1) {
		this.vmIpaddr1 = vmIpaddr1;
	}

	/**
	 * @return the vmIpaddr2
	 */
	public String getVmIpaddr2() {
		return vmIpaddr2;
	}

	/**
	 * @param vmIpaddr2 the vmIpaddr2 to set
	 */
	public void setVmIpaddr2(String vmIpaddr2) {
		this.vmIpaddr2 = vmIpaddr2;
	}

	/**
	 * @return the vmIpaddr3
	 */
	public String getVmIpaddr3() {
		return vmIpaddr3;
	}

	/**
	 * @param vmIpaddr3 the vmIpaddr3 to set
	 */
	public void setVmIpaddr3(String vmIpaddr3) {
		this.vmIpaddr3 = vmIpaddr3;
	}

	/**
	 * @return the vmStatus
	 */
	public String getVmStatus() {
		return vmStatus;
	}

	/**
	 * @param vmStatus the vmStatus to set
	 */
	public void setVmStatus(String vmStatus) {
		this.vmStatus = vmStatus;
	}

	/**
	 * @return the vmTemplet
	 */
	public String getVmTemplet() {
		return vmTemplet;
	}

	/**
	 * @param vmTemplet the vmTemplet to set
	 */
	public void setVmTemplet(String vmTemplet) {
		this.vmTemplet = vmTemplet;
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
	 * @return the vmServiceID
	 */
	public Integer getVmServiceID() {
		return vmServiceID;
	}

	/**
	 * @param vmServiceID the vmServiceID to set
	 */
	public void setVmServiceID(Integer vmServiceID) {
		this.vmServiceID = vmServiceID;
	}
	
	/**
	 * @return the vmCreatetime
	 */
	public String getVmCreatetime() {
		return vmCreatetime;
	}

	/**
	 * @param vmCreatetime the vmCreatetime to set
	 */
	public void setVmCreatetime(String vmCreatetime) {
		this.vmCreatetime = vmCreatetime;
	}

	/**
	 * @return the vmDevices
	 */
	public String getVmDevices() {
		return vmDevices;
	}

	/**
	 * @param vmDevices the vmDevices to set
	 */
	public void setVmDevices(String vmDevices) {
		this.vmDevices = vmDevices;
	}

	/**
	 * @return the sEpNum
	 */
	public String getsEpNum() {
		return sEpNum;
	}

	/**
	 * @param sEpNum the sEpNum to set
	 */
	public void setsEpNum(String sEpNum) {
		this.sEpNum = sEpNum;
	}

	/**
	 * @return the cpuHotAdd
	 */
	public String getCpuHotAdd() {
		return cpuHotAdd;
	}

	/**
	 * @param cpuHotAdd the cpuHotAdd to set
	 */
	public void setCpuHotAdd(String cpuHotAdd) {
		this.cpuHotAdd = cpuHotAdd;
	}

	/**
	 * @return the memoryHotAdd
	 */
	public String getMemoryHotAdd() {
		return memoryHotAdd;
	}

	/**
	 * @param memoryHotAdd the memoryHotAdd to set
	 */
	public void setMemoryHotAdd(String memoryHotAdd) {
		this.memoryHotAdd = memoryHotAdd;
	}

	/**
	 * @return the templateOnoff
	 */
	public Integer getTemplateOnoff() {
		return templateOnoff;
	}

	/**
	 * @param templateOnoff the templateOnoff to set
	 */
	public void setTemplateOnoff(Integer templateOnoff) {
		this.templateOnoff = templateOnoff;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @return the vmServiceName
	 */
	public String getVmServiceName() {
		return vmServiceName;
	}

	/**
	 * @param vmServiceName the vmServiceName to set
	 */
	public void setVmServiceName(String vmServiceName) {
		this.vmServiceName = vmServiceName;
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
	 * @return the searchParam
	 */
	public String getSearchParam() {
		return searchParam;
	}

	/**
	 * @param searchParam the searchParam to set
	 */
	public void setSearchParam(String searchParam) {
		this.searchParam = searchParam;
	}

	/**
	 * @return the sort
	 */
	public String getSort() {
		return sort;
	}

	/**
	 * @param sort the sort to set
	 */
	public void setSort(String sort) {
		this.sort = sort;
	}
	
	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }

	public String getHostName() {
		return hostName;
	}

	public void setHostName(String hostName) {
		this.hostName = hostName;
	}

	public String getAdaptersName() {
		return adaptersName;
	}

	public void setAdaptersName(String adaptersName) {
		this.adaptersName = adaptersName;
	}

	
	
}
