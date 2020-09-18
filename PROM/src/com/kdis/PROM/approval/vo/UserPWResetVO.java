package com.kdis.PROM.approval.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 비밀번호 초기화 VO
 * 
 * @author KimHahn
 *
 */
public class UserPWResetVO {

	/** 사용자 고유번호 */
	private int id;
	
	/** 비밀번호 초기화  고유번호 */
	private int resetNum;
	
	/** 사용자 아이디 */
	private String sUserID;
	
	/** 사용자 이름 */
	private String sName;
	
	/** 사용자 사번 */
	private String nNumber;
	
	/** 초기화 요청 일시 */
	private String dRdatetime;
	
	/** 승인 일시 */
	private String dApplytime;
	
	/** 승인 상태  (0:신청, 1:승인, 2:반려) */
	private int nApproval;
	
	/** 코멘트 */
	private String pwResetComment = "";

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * @return the resetNum
	 */
	public int getResetNum() {
		return resetNum;
	}

	/**
	 * @param resetNum the resetNum to set
	 */
	public void setResetNum(int resetNum) {
		this.resetNum = resetNum;
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
	 * @return the sName
	 */
	public String getsName() {
		return sName;
	}

	/**
	 * @param sName the sName to set
	 */
	public void setsName(String sName) {
		this.sName = sName;
	}

	/**
	 * @return the nNumber
	 */
	public String getnNumber() {
		return nNumber;
	}

	/**
	 * @param nNumber the nNumber to set
	 */
	public void setnNumber(String nNumber) {
		this.nNumber = nNumber;
	}

	/**
	 * @return the dRdatetime
	 */
	public String getdRdatetime() {
		return dRdatetime;
	}

	/**
	 * @param dRdatetime the dRdatetime to set
	 */
	public void setdRdatetime(String dRdatetime) {
		this.dRdatetime = dRdatetime;
	}

	/**
	 * @return the dApplytime
	 */
	public String getdApplytime() {
		return dApplytime;
	}

	/**
	 * @param dApplytime the dApplytime to set
	 */
	public void setdApplytime(String dApplytime) {
		this.dApplytime = dApplytime;
	}

	/**
	 * @return the nApproval
	 */
	public int getnApproval() {
		return nApproval;
	}

	/**
	 * @param nApproval the nApproval to set
	 */
	public void setnApproval(int nApproval) {
		this.nApproval = nApproval;
	}

	/**
	 * @return the pwResetComment
	 */
	public String getPwResetComment() {
		return pwResetComment;
	}

	/**
	 * @param pwResetComment the pwResetComment to set
	 */
	public void setPwResetComment(String pwResetComment) {
		this.pwResetComment = pwResetComment;
	}

	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }

}
