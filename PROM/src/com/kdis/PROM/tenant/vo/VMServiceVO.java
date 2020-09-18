package com.kdis.PROM.tenant.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * Service VO class
 * 
 * @author KimHahn
 *
 */
public class VMServiceVO {

	/** 서비스 아이디 */
	private Integer vmServiceID;

	/** 서비스 이름 */
	private String vmServiceName;

	/** 서비스 관리자 고유번호 */
	private Integer vmServiceUserID;

	/** 서비스 관리자명 (값을 없을 경우는 '관리자 미지정') */
	private String vmServiceUserName = "";
	
	/** 서비스 관리자명(값을 없을 경우는 '')  */
	private String serviceUserName = "";

	/** 서비스 시간 */
	private String vmServiceDatetime;

	/** 서비스 안의 가상머신 */
	private Integer vmServiceINVM;

	/** ??? */
	private String nEpNum;

	/** 테넌트 아이디(고유번호) */
	private Integer tenantId;

	/** 테넌트명 */
	private String tenantName;

	/** 클러스터 기본값 */
	private String defaultCluster;

	/** 호스트 기본값 */
	private String defaultHost;

	/** 스토리지 기본값 */
	private String defaultStorage;

	/** 스토리지명 기본값 */
	private String defaultStorageName;

	/** 네트워크 기본값  */
	private String defaultNetwork;

	/** 네트워크명 기본값  */
	private String defaultNetworkName;
	
	/** 아이피 기본값  */
	private String defaultNetmask;

	/** 게이트웨이 기본값 */
	private String defaultGateway;

	/** DHCP 여부 */
	private Integer dhcpOnoff;

	/** 생성 일시 */
	private String createdOn;

	/** 수정 일시 */
	private String updatedOn;

	/** 설명 */
	private String description;

	/** VM 수 */
	private int countVM;
	
	/** 사용자 고유번호 */
	private Integer userId;

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
	 * @return the vmServiceUserID
	 */
	public Integer getVmServiceUserID() {
		return vmServiceUserID;
	}

	/**
	 * @param vmServiceUserID the vmServiceUserID to set
	 */
	public void setVmServiceUserID(Integer vmServiceUserID) {
		this.vmServiceUserID = vmServiceUserID;
	}

	/**
	 * @return the vmServiceUserName
	 */
	public String getVmServiceUserName() {
		return vmServiceUserName;
	}

	/**
	 * @param vmServiceUserName the vmServiceUserName to set
	 */
	public void setVmServiceUserName(String vmServiceUserName) {
		this.vmServiceUserName = vmServiceUserName;
	}

	/**
	 * @return the serviceUserName
	 */
	public String getServiceUserName() {
		return serviceUserName;
	}

	/**
	 * @param serviceUserName the serviceUserName to set
	 */
	public void setServiceUserName(String serviceUserName) {
		this.serviceUserName = serviceUserName;
	}

	/**
	 * @return the vmServiceDatetime
	 */
	public String getVmServiceDatetime() {
		return vmServiceDatetime;
	}

	/**
	 * @param vmServiceDatetime the vmServiceDatetime to set
	 */
	public void setVmServiceDatetime(String vmServiceDatetime) {
		this.vmServiceDatetime = vmServiceDatetime;
	}

	/**
	 * @return the vmServiceINVM
	 */
	public Integer getVmServiceINVM() {
		return vmServiceINVM;
	}

	/**
	 * @param vmServiceINVM the vmServiceINVM to set
	 */
	public void setVmServiceINVM(Integer vmServiceINVM) {
		this.vmServiceINVM = vmServiceINVM;
	}

	/**
	 * @return the nEpNum
	 */
	public String getnEpNum() {
		return nEpNum;
	}

	/**
	 * @param nEpNum the nEpNum to set
	 */
	public void setnEpNum(String nEpNum) {
		this.nEpNum = nEpNum;
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
	 * @return the defaultCluster
	 */
	public String getDefaultCluster() {
		return defaultCluster;
	}

	/**
	 * @param defaultCluster the defaultCluster to set
	 */
	public void setDefaultCluster(String defaultCluster) {
		this.defaultCluster = defaultCluster;
	}

	/**
	 * @return the defaultHost
	 */
	public String getDefaultHost() {
		return defaultHost;
	}

	/**
	 * @param defaultHost the defaultHost to set
	 */
	public void setDefaultHost(String defaultHost) {
		this.defaultHost = defaultHost;
	}

	/**
	 * @return the defaultStorage
	 */
	public String getDefaultStorage() {
		return defaultStorage;
	}

	/**
	 * @param defaultStorage the defaultStorage to set
	 */
	public void setDefaultStorage(String defaultStorage) {
		this.defaultStorage = defaultStorage;
	}

	/**
	 * @return the defaultStorageName
	 */
	public String getDefaultStorageName() {
		return defaultStorageName;
	}

	/**
	 * @param defaultStorageName the defaultStorageName to set
	 */
	public void setDefaultStorageName(String defaultStorageName) {
		this.defaultStorageName = defaultStorageName;
	}

	/**
	 * @return the defaultNetwork
	 */
	public String getDefaultNetwork() {
		return defaultNetwork;
	}

	/**
	 * @param defaultNetwork the defaultNetwork to set
	 */
	public void setDefaultNetwork(String defaultNetwork) {
		this.defaultNetwork = defaultNetwork;
	}

	/**
	 * @return the defaultNetworkName
	 */
	public String getDefaultNetworkName() {
		return defaultNetworkName;
	}

	/**
	 * @param defaultNetworkName the defaultNetworkName to set
	 */
	public void setDefaultNetworkName(String defaultNetworkName) {
		this.defaultNetworkName = defaultNetworkName;
	}

	/**
	 * @return the defaultNetmask
	 */
	public String getDefaultNetmask() {
		return defaultNetmask;
	}

	/**
	 * @param defaultNetmask the defaultNetmask to set
	 */
	public void setDefaultNetmask(String defaultNetmask) {
		this.defaultNetmask = defaultNetmask;
	}

	/**
	 * @return the defaultGateway
	 */
	public String getDefaultGateway() {
		return defaultGateway;
	}

	/**
	 * @param defaultGateway the defaultGateway to set
	 */
	public void setDefaultGateway(String defaultGateway) {
		this.defaultGateway = defaultGateway;
	}

	/**
	 * @return the dhcpOnoff
	 */
	public Integer getDhcpOnoff() {
		return dhcpOnoff;
	}

	/**
	 * @param dhcpOnoff the dhcpOnoff to set
	 */
	public void setDhcpOnoff(Integer dhcpOnoff) {
		this.dhcpOnoff = dhcpOnoff;
	}

	/**
	 * @return the createdOn
	 */
	public String getCreatedOn() {
		return createdOn;
	}

	/**
	 * @param createdOn the createdOn to set
	 */
	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}

	/**
	 * @return the updatedOn
	 */
	public String getUpdatedOn() {
		return updatedOn;
	}

	/**
	 * @param updatedOn the updatedOn to set
	 */
	public void setUpdatedOn(String updatedOn) {
		this.updatedOn = updatedOn;
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
	 * @return the countVM
	 */
	public int getCountVM() {
		return countVM;
	}

	/**
	 * @param countVM the countVM to set
	 */
	public void setCountVM(int countVM) {
		this.countVM = countVM;
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
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
