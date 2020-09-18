package com.kdis.PROM.tenant.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 클러스터 VO class
 * 
 * @author KimHahn
 *
 */
public class ClusterVO {

	/** 클러스터 아이디  */
	private String clusterID;
	
	/** 클러스터명  */
	private String clusterName;
	
	/** 부모 클러스터 아이디 */
	private String clusterParent;
	
	/** DNS  */
	private Integer drsEnabled;
	
	/** 클러스터 코어 */
	private Integer clusterCore;
	
	/** 클러스터 메모리 */
	private Integer clusterMemory;
	
	/** 변경 일시 */
	private String updatedOn;

	/**
	 * @return the clusterID
	 */
	public String getClusterID() {
		return clusterID;
	}

	/**
	 * @param clusterID the clusterID to set
	 */
	public void setClusterID(String clusterID) {
		this.clusterID = clusterID;
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
	 * @return the clusterParent
	 */
	public String getClusterParent() {
		return clusterParent;
	}

	/**
	 * @param clusterParent the clusterParent to set
	 */
	public void setClusterParent(String clusterParent) {
		this.clusterParent = clusterParent;
	}

	/**
	 * @return the drsEnabled
	 */
	public Integer getDrsEnabled() {
		return drsEnabled;
	}

	/**
	 * @param drsEnabled the drsEnabled to set
	 */
	public void setDrsEnabled(Integer drsEnabled) {
		this.drsEnabled = drsEnabled;
	}

	/**
	 * @return the clusterCore
	 */
	public Integer getClusterCore() {
		return clusterCore;
	}

	/**
	 * @param clusterCore the clusterCore to set
	 */
	public void setClusterCore(Integer clusterCore) {
		this.clusterCore = clusterCore;
	}

	/**
	 * @return the clusterMemory
	 */
	public Integer getClusterMemory() {
		return clusterMemory;
	}

	/**
	 * @param clusterMemory the clusterMemory to set
	 */
	public void setClusterMemory(Integer clusterMemory) {
		this.clusterMemory = clusterMemory;
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
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
