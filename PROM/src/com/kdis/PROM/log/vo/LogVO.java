package com.kdis.PROM.log.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 이력 VO
 * 
 * @author KimHahn
 *
 */
public class LogVO {

	/** 이력 고유번호 */
	private int nAlertNum;
	
	/** 이력 받는 사람 */
	private String sReceive;
	
	/** 이력 구분자 */
	private int nCategory;
	
	/** 이력 구분자(문자열) */
	private String sKeyword;
	
	/** 이력 내용 */
	private String sContext;
	
	/** 이력 날짜 */
	private String sSendDay;
	
	/** 이력 상세 구분자 */
	private String sTarget;
	
	/** ??? */
	private String cateReplace;
	
	/** 이름 */
	private String name;

	/**
	 * @return the nAlertNum
	 */
	public int getnAlertNum() {
		return nAlertNum;
	}

	/**
	 * @param nAlertNum the nAlertNum to set
	 */
	public void setnAlertNum(int nAlertNum) {
		this.nAlertNum = nAlertNum;
	}

	/**
	 * @return the sReceive
	 */
	public String getsReceive() {
		return sReceive;
	}

	/**
	 * @param sReceive the sReceive to set
	 */
	public void setsReceive(String sReceive) {
		this.sReceive = sReceive;
	}

	/**
	 * @return the nCategory
	 */
	public int getnCategory() {
		return nCategory;
	}

	/**
	 * @param nCategory the nCategory to set
	 */
	public void setnCategory(int nCategory) {
		this.nCategory = nCategory;
	}

	/**
	 * @return the sKeyword
	 */
	public String getsKeyword() {
		return sKeyword;
	}

	/**
	 * @param sKeyword the sKeyword to set
	 */
	public void setsKeyword(String sKeyword) {
		this.sKeyword = sKeyword;
	}

	/**
	 * @return the sContext
	 */
	public String getsContext() {
		return sContext;
	}

	/**
	 * @param sContext the sContext to set
	 */
	public void setsContext(String sContext) {
		this.sContext = sContext;
	}

	/**
	 * @return the sSendDay
	 */
	public String getsSendDay() {
		return sSendDay;
	}

	/**
	 * @param sSendDay the sSendDay to set
	 */
	public void setsSendDay(String sSendDay) {
		this.sSendDay = sSendDay;
	}

	/**
	 * @return the sTarget
	 */
	public String getsTarget() {
		return sTarget;
	}

	/**
	 * @param sTarget the sTarget to set
	 */
	public void setsTarget(String sTarget) {
		this.sTarget = sTarget;
	}

	/**
	 * @return the cateReplace
	 */
	public String getCateReplace() {
		return cateReplace;
	}

	/**
	 * @param cateReplace the cateReplace to set
	 */
	public void setCateReplace(String cateReplace) {
		this.cateReplace = cateReplace;
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
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
