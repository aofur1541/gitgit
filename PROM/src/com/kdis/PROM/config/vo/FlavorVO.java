package com.kdis.PROM.config.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 가상머신 자원 VO class
 * 
 * @author KimHahn
 *
 */
public class FlavorVO {

	/** 가상머신 자원 고유번호  */
	private Integer id;

	/** 가상머신 자원 이름  */
	private String name;

	/** 가상머신 자원 CPU 용량  */
	private Integer vCPU;

	/** 가상머신 자원 메모리 용량  */
	private Integer memory;

	/** 가상머신 자원 디스크 용량  */
	private Integer disk;

	/** 설명  */
	private String description; 

	/** 생성일시  */
	private String createdOn;

	/** 변경일시  */
	private String updatedOn;

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
	 * @return the vCPU
	 */
	public Integer getvCPU() {
		return vCPU;
	}

	/**
	 * @param vCPU the vCPU to set
	 */
	public void setvCPU(Integer vCPU) {
		this.vCPU = vCPU;
	}

	/**
	 * @return the memory
	 */
	public Integer getMemory() {
		return memory;
	}

	/**
	 * @param memory the memory to set
	 */
	public void setMemory(Integer memory) {
		this.memory = memory;
	}

	/**
	 * @return the disk
	 */
	public Integer getDisk() {
		return disk;
	}

	/**
	 * @param disk the disk to set
	 */
	public void setDisk(Integer disk) {
		this.disk = disk;
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
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
