package com.kdis.PROM.tenant.vo;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.kdis.PROM.user.vo.DepartmentVO;

/**
 * 테넌트 VO class
 * 
 * @author KimHahn
 *
 */
public class TenantVO {

	/** 테넌트 고유번호  */
	private Integer id;
	
	/** 테넌트 이름  */
	private String name;
	
	/** 테넌트 관리자 고유번호  */
	private Integer adminId;
	
	/** 테넌트 관리자명 */
	private String adminName = "";
	
	/** 회사 고유번호  */
	private Integer companyId;
	
	/** 회사명 */
	private String companyName = "";
	
	/** 부서 코드 */
	private String deptId;
	
	/** 부서명 */
	private String deptName = "";
	
	/** 테넌트 설명  */
	private String description;
	
	/** 클러스터 기본값  */
	private String defaultCluster;
	
	/** 호스트 기본값  */
	private String defaultHost;
	
	/** 데이터스토어 기본값  */
	private String defaultStorage;
	
	/** 데이터스토어명 기본값 */
	private String defaultStorageName = "";
	
	/** 네트워크 기본값  */
	private String defaultNetwork;
	
	/** 네트워크명 기본값 */
	private String defaultNetworkName = "";
	
	/** 아이피 기본값 */
	private String defaultNetmask;
	
	/** 게이트웨이 기본값 */
	private String defaultGateway;
	
	/** DHCP 여부(1:ON, 2:OFF)  */
	private Integer dhcpOnoff;
	
	/** 생성 일시  */
	private String createdOn;
	
	/** 변경 일시  */
	private String updatedOn;
	
	/** 해당 테넌트 배치 여부  */
	private String isInclude;
	
	/** 사용자가 해당 테넌트 관리자 여부 */
	private String isTenantAdmin;
	
	/** 사용자가 해당 테넌트의 속한 서비스 관리자 여부  */
	private String isServiceAdmin;
	
	/** 검색 조건 : 부서 목록  */
	private List<DepartmentVO> paramDeptList;

	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the adminId
	 */
	public Integer getAdminId() {
		return adminId;
	}

	/**
	 * @param adminId the adminId to set
	 */
	public void setAdminId(Integer adminId) {
		this.adminId = adminId;
	}

	/**
	 * @return the adminName
	 */
	public String getAdminName() {
		return adminName;
	}

	/**
	 * @param adminName the adminName to set
	 */
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	/**
	 * @return the companyId
	 */
	public Integer getCompanyId() {
		return companyId;
	}

	/**
	 * @param companyId the companyId to set
	 */
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	/**
	 * @return the companyName
	 */
	public String getCompanyName() {
		return companyName;
	}

	/**
	 * @param companyName the companyName to set
	 */
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	/**
	 * @return the deptId
	 */
	public String getDeptId() {
		return deptId;
	}

	/**
	 * @param deptId the deptId to set
	 */
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	/**
	 * @return the deptName
	 */
	public String getDeptName() {
		return deptName;
	}

	/**
	 * @param deptName the deptName to set
	 */
	public void setDeptName(String deptName) {
		this.deptName = deptName;
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
	 * @return the isInclude
	 */
	public String getIsInclude() {
		return isInclude;
	}

	/**
	 * @param isInclude the isInclude to set
	 */
	public void setIsInclude(String isInclude) {
		this.isInclude = isInclude;
	}

	/**
	 * @return the isTenantAdmin
	 */
	public String getIsTenantAdmin() {
		return isTenantAdmin;
	}

	/**
	 * @param isTenantAdmin the isTenantAdmin to set
	 */
	public void setIsTenantAdmin(String isTenantAdmin) {
		this.isTenantAdmin = isTenantAdmin;
	}

	/**
	 * @return the isServiceAdmin
	 */
	public String getIsServiceAdmin() {
		return isServiceAdmin;
	}

	/**
	 * @param isServiceAdmin the isServiceAdmin to set
	 */
	public void setIsServiceAdmin(String isServiceAdmin) {
		this.isServiceAdmin = isServiceAdmin;
	}

	/**
	 * @return the paramDeptList
	 */
	public List<DepartmentVO> getParamDeptList() {
		return paramDeptList;
	}

	/**
	 * @param paramDeptList the paramDeptList to set
	 */
	public void setParamDeptList(List<DepartmentVO> paramDeptList) {
		this.paramDeptList = paramDeptList;
	}

	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
