package com.kdis.PROM.config.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 기본 기능 VO class
 * 
 * @author KimHahn
 *
 */
public class BasicVO {

	/** 고유번호 */
	private Integer id;

	/** 이름 */
	private String name;

	/** 뷰에 보여지는 이름  */
	private String displayName;

	/** 설정값(숫자) */
	private Integer value;

	/** 설정값(문자열)  */
	private String valueStr;

	/** 설명  */
	private String description;

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
	 * @return the displayName
	 */
	public String getDisplayName() {
		return displayName;
	}

	/**
	 * @param displayName the displayName to set
	 */
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	/**
	 * @return the value
	 */
	public Integer getValue() {
		return value;
	}

	/**
	 * @param value the value to set
	 */
	public void setValue(Integer value) {
		this.value = value;
	}

	/**
	 * @return the valueStr
	 */
	public String getValueStr() {
		return valueStr;
	}

	/**
	 * @param valueStr the valueStr to set
	 */
	public void setValueStr(String valueStr) {
		this.valueStr = valueStr;
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
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
