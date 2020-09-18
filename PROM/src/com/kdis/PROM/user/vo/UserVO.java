package com.kdis.PROM.user.vo;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 사용자 VO
 * 
 * @author KimHahn
 *
 */
public class UserVO {

	/** 사용자 고유번호 */
	private Integer id;

	/** 아이디 */
	private String sUserID;

	/** 비밀번호 */
	private String sUserPW;

	/** 이름  */
	private String sName;

	/** 영문 이름 */
	private String sNameEng;

	/** 회사 고유번호 */
	private Integer sCompany;
	
	/** 회사명  */
	private String companyName;

	/** 부서 코드 */
	private String sDepartment;

	/** 부서명 */
	private String sDepartmentName;

	/** 승인 */
	private int nApproval;
	
	/** 승인명 */
	private String approvalName;

	/** 사번 */
	private String nNumber;

	/** 아이피 */
	private String sUserIP;

	/** ??? */
	private String sEpNum;
	
	/** 이메일 */
	private String sEmailAddress;

	/** 전화번호 */
	private String sPhoneNumber;

	/** 최종 로그인 일시 */
	private String lastLoginOn;

	/** 비밀번호 변경 일시 */
	private Date passwdChangedOn;

	/** 생성 일시 */
	private String createdOn;

	/** 최종 변경 일시 */
	private String updatedOn;

	/** 생년월일 */
	private String dBirthday;

	/** 입사일 */
	private String dStartday;

	/** 직위 코드 */
	private String sJobCode;

	/** 재직 코드 */
	private int sTenureCode;
	
	/** 재직명 */
	private String tenureName;

	/** 테넌트 아이디 */
	private Integer nTenantId;

	/** 테넌트명 */
	private String sTenantName = "";

	/** 서비스 아이디 */
	private Integer nServiceId;

	/** 서비스명 */
	private String sServiceName = "";

	/** 부서 사용 여부(0:사용안함, 1:사용함) */
	private int isUse;
	
	/** 검색 조건 : 해당 사용자 고유 번호 제외 */
	private Integer paramNotId;
	
	/** 검색 조건 : 해당 승인(권한) 제외 */
	private Integer paramNotApproval;
	
	/** 검색 조건 : 부서 목록 */
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
	 * @return the sUserPW
	 */
	public String getsUserPW() {
		return sUserPW;
	}

	/**
	 * @param sUserPW the sUserPW to set
	 */
	public void setsUserPW(String sUserPW) {
		this.sUserPW = sUserPW;
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
	 * @return the sNameEng
	 */
	public String getsNameEng() {
		return sNameEng;
	}

	/**
	 * @param sNameEng the sNameEng to set
	 */
	public void setsNameEng(String sNameEng) {
		this.sNameEng = sNameEng;
	}

	/**
	 * @return the sCompany
	 */
	public Integer getsCompany() {
		return sCompany;
	}

	/**
	 * @param sCompany the sCompany to set
	 */
	public void setsCompany(Integer sCompany) {
		this.sCompany = sCompany;
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
	 * @return the sDepartment
	 */
	public String getsDepartment() {
		return sDepartment;
	}

	/**
	 * @param sDepartment the sDepartment to set
	 */
	public void setsDepartment(String sDepartment) {
		this.sDepartment = sDepartment;
	}

	/**
	 * @return the sDepartmentName
	 */
	public String getsDepartmentName() {
		return sDepartmentName;
	}

	/**
	 * @param sDepartmentName the sDepartmentName to set
	 */
	public void setsDepartmentName(String sDepartmentName) {
		this.sDepartmentName = sDepartmentName;
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
	 * @return the approvalName
	 */
	public String getApprovalName() {
		return approvalName;
	}

	/**
	 * @param approvalName the approvalName to set
	 */
	public void setApprovalName(String approvalName) {
		this.approvalName = approvalName;
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
	 * @return the sUserIP
	 */
	public String getsUserIP() {
		return sUserIP;
	}

	/**
	 * @param sUserIP the sUserIP to set
	 */
	public void setsUserIP(String sUserIP) {
		this.sUserIP = sUserIP;
	}

	/**
	 * @return the sEpNum
	 */
	public String getsEpNum() {
		return sEpNum;
	}

	/**
	 * @param sEpNum the sEpNum to set
	 */
	public void setsEpNum(String sEpNum) {
		this.sEpNum = sEpNum;
	}

	/**
	 * @return the sEmailAddress
	 */
	public String getsEmailAddress() {
		return sEmailAddress;
	}

	/**
	 * @param sEmailAddress the sEmailAddress to set
	 */
	public void setsEmailAddress(String sEmailAddress) {
		this.sEmailAddress = sEmailAddress;
	}

	/**
	 * @return the sPhoneNumber
	 */
	public String getsPhoneNumber() {
		return sPhoneNumber;
	}

	/**
	 * @param sPhoneNumber the sPhoneNumber to set
	 */
	public void setsPhoneNumber(String sPhoneNumber) {
		this.sPhoneNumber = sPhoneNumber;
	}

	/**
	 * @return the lastLoginOn
	 */
	public String getLastLoginOn() {
		return lastLoginOn;
	}

	/**
	 * @param lastLoginOn the lastLoginOn to set
	 */
	public void setLastLoginOn(String lastLoginOn) {
		this.lastLoginOn = lastLoginOn;
	}

	/**
	 * @return the passwdChangedOn
	 */
	public Date getPasswdChangedOn() {
		return passwdChangedOn;
	}

	/**
	 * @param passwdChangedOn the passwdChangedOn to set
	 */
	public void setPasswdChangedOn(Date passwdChangedOn) {
		this.passwdChangedOn = passwdChangedOn;
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
	 * @return the dBirthday
	 */
	public String getdBirthday() {
		return dBirthday;
	}

	/**
	 * @param dBirthday the dBirthday to set
	 */
	public void setdBirthday(String dBirthday) {
		this.dBirthday = dBirthday;
	}

	/**
	 * @return the dStartday
	 */
	public String getdStartday() {
		return dStartday;
	}

	/**
	 * @param dStartday the dStartday to set
	 */
	public void setdStartday(String dStartday) {
		this.dStartday = dStartday;
	}

	/**
	 * @return the sJobCode
	 */
	public String getsJobCode() {
		return sJobCode;
	}

	/**
	 * @param sJobCode the sJobCode to set
	 */
	public void setsJobCode(String sJobCode) {
		this.sJobCode = sJobCode;
	}

	/**
	 * @return the sTenureCode
	 */
	public int getsTenureCode() {
		return sTenureCode;
	}

	/**
	 * @param sTenureCode the sTenureCode to set
	 */
	public void setsTenureCode(int sTenureCode) {
		this.sTenureCode = sTenureCode;
	}

	/**
	 * @return the tenureName
	 */
	public String getTenureName() {
		return tenureName;
	}

	/**
	 * @param tenureName the tenureName to set
	 */
	public void setTenureName(String tenureName) {
		this.tenureName = tenureName;
	}

	/**
	 * @return the nTenantId
	 */
	public Integer getnTenantId() {
		return nTenantId;
	}

	/**
	 * @param nTenantId the nTenantId to set
	 */
	public void setnTenantId(Integer nTenantId) {
		this.nTenantId = nTenantId;
	}

	/**
	 * @return the sTenantName
	 */
	public String getsTenantName() {
		return sTenantName;
	}

	/**
	 * @param sTenantName the sTenantName to set
	 */
	public void setsTenantName(String sTenantName) {
		this.sTenantName = sTenantName;
	}

	/**
	 * @return the nServiceId
	 */
	public Integer getnServiceId() {
		return nServiceId;
	}

	/**
	 * @param nServiceId the nServiceId to set
	 */
	public void setnServiceId(Integer nServiceId) {
		this.nServiceId = nServiceId;
	}

	/**
	 * @return the sServiceName
	 */
	public String getsServiceName() {
		return sServiceName;
	}

	/**
	 * @param sServiceName the sServiceName to set
	 */
	public void setsServiceName(String sServiceName) {
		this.sServiceName = sServiceName;
	}

	/**
	 * @return the isUse
	 */
	public int getIsUse() {
		return isUse;
	}

	/**
	 * @param isUse the isUse to set
	 */
	public void setIsUse(int isUse) {
		this.isUse = isUse;
	}

	/**
	 * @return the paramNotId
	 */
	public Integer getParamNotId() {
		return paramNotId;
	}

	/**
	 * @param paramNotId the paramNotId to set
	 */
	public void setParamNotId(Integer paramNotId) {
		this.paramNotId = paramNotId;
	}

	/**
	 * @return the paramNotApproval
	 */
	public Integer getParamNotApproval() {
		return paramNotApproval;
	}

	/**
	 * @param paramNotApproval the paramNotApproval to set
	 */
	public void setParamNotApproval(Integer paramNotApproval) {
		this.paramNotApproval = paramNotApproval;
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
