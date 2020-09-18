package com.kdis.PROM.log.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * vCenter 이력 VO
 * 
 * @author KimHahn
 *
 */
public class VCenterAlertVO {

	/** 고유번호  */
	private String vcAlertPK;

	/** 경고 대상  */
	private String sTarget;

	/** 경고 메시지  */
	private String sVcMessage;

	/** 경고 시간  */
	private String dAlertTime;

	/** 경고 확인 여부(0: 미확인, 1:확인, 2:미확인 강조)  */
	private Integer nAlertCheck;

	/** 경고 종류  */
	private String sAlertColor;

	/**
	 * @return the vcAlertPK
	 */
	public String getVcAlertPK() {
		return vcAlertPK;
	}

	/**
	 * @param vcAlertPK the vcAlertPK to set
	 */
	public void setVcAlertPK(String vcAlertPK) {
		this.vcAlertPK = vcAlertPK;
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
	 * @return the sVcMessage
	 */
	public String getsVcMessage() {
		return sVcMessage;
	}

	/**
	 * @param sVcMessage the sVcMessage to set
	 */
	public void setsVcMessage(String sVcMessage) {
		this.sVcMessage = sVcMessage;
	}

	/**
	 * @return the dAlertTime
	 */
	public String getdAlertTime() {
		return dAlertTime;
	}

	/**
	 * @param dAlertTime the dAlertTime to set
	 */
	public void setdAlertTime(String dAlertTime) {
		this.dAlertTime = dAlertTime;
	}

	/**
	 * @return the nAlertCheck
	 */
	public Integer getnAlertCheck() {
		return nAlertCheck;
	}

	/**
	 * @param nAlertCheck the nAlertCheck to set
	 */
	public void setnAlertCheck(Integer nAlertCheck) {
		this.nAlertCheck = nAlertCheck;
	}

	/**
	 * @return the sAlertColor
	 */
	public String getsAlertColor() {
		return sAlertColor;
	}

	/**
	 * @param sAlertColor the sAlertColor to set
	 */
	public void setsAlertColor(String sAlertColor) {
		this.sAlertColor = sAlertColor;
	}

	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
