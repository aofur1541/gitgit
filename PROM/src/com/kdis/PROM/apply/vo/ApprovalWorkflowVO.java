package com.kdis.PROM.apply.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 승인 Workflow VO class
 * 
 * @author KimHahn
 *
 */
public class ApprovalWorkflowVO {

	/** 승인 Workflow 고유번호 */
	private Integer id;
	
	/** 가상머신 생성 ID */
	private Integer crNum;
	
	/** 단계 */
	private Integer stage;
	
	/** 상태 */
	private Integer status;
	
	/** 사용자ID */
	private String sUserID;
	
	/** 사용자명 */
	private String name;
	
	/** 설명 */
	private String description;
	
	/** 일시 */
	private String timestamp;

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
	 * @return the crNum
	 */
	public Integer getCrNum() {
		return crNum;
	}

	/**
	 * @param crNum the crNum to set
	 */
	public void setCrNum(Integer crNum) {
		this.crNum = crNum;
	}

	/**
	 * @return the stage
	 */
	public Integer getStage() {
		return stage;
	}

	/**
	 * @param stage the stage to set
	 */
	public void setStage(Integer stage) {
		this.stage = stage;
	}

	/**
	 * @return the status
	 */
	public Integer getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}

	/**
	 * @return the sUserID
	 */
	public String getsUserID() {
		return sUserID;
	}

	/**
	 * @param sUserID the sUserID to set
	 */
	public void setsUserID(String sUserID) {
		this.sUserID = sUserID;
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
	 * @return the timestamp
	 */
	public String getTimestamp() {
		return timestamp;
	}

	/**
	 * @param timestamp the timestamp to set
	 */
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	
	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
