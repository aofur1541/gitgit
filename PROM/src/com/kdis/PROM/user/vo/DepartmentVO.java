package com.kdis.PROM.user.vo;

import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 부서 VO
 * 
 * @author KimHahn
 *
 */
public class DepartmentVO {

	/** 부서 고유번호  */
	private Integer id;

	/** 회사 아이디 */
	private Integer companyId;

	/** 회사 이름 */
	private String companyName;

	/** 부서 아이디(코드)  */
	private String deptId;

	/** 부서 이름  */
	private String name;

	/** 상위 부서 아이디  */
	private String upperdeptId;

	/** 상위 부서 이름  */
	private String upperdeptName;

	/** 사용여부 (사용중=1) */
	private Integer isUse; 

	/** 설명  */
	private String description;

	/** 생성 일시 */
	private Date createdOn;

	/** 변경 일시 */
	private Date updatedOn;

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
	 * @return the upperdeptId
	 */
	public String getUpperdeptId() {
		return upperdeptId;
	}

	/**
	 * @param upperdeptId the upperdeptId to set
	 */
	public void setUpperdeptId(String upperdeptId) {
		this.upperdeptId = upperdeptId;
	}

	/**
	 * @return the upperdeptName
	 */
	public String getUpperdeptName() {
		return upperdeptName;
	}

	/**
	 * @param upperdeptName the upperdeptName to set
	 */
	public void setUpperdeptName(String upperdeptName) {
		this.upperdeptName = upperdeptName;
	}

	/**
	 * @return the isUse
	 */
	public Integer getIsUse() {
		return isUse;
	}

	/**
	 * @param isUse the isUse to set
	 */
	public void setIsUse(Integer isUse) {
		this.isUse = isUse;
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
	public Date getCreatedOn() {
		return createdOn;
	}

	/**
	 * @param createdOn the createdOn to set
	 */
	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	/**
	 * @return the updatedOn
	 */
	public Date getUpdatedOn() {
		return updatedOn;
	}

	/**
	 * @param updatedOn the updatedOn to set
	 */
	public void setUpdatedOn(Date updatedOn) {
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
