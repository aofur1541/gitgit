package com.kdis.PROM.apply.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 가상머신 생성 VO class
 * 
 * @author KimHahn
 *
 */
public class VMCreateVO {

	/** 가상머신 생성 아이디 */
	private Integer crNum;

	/** 신청 구분(1:가상머신 생성, 2:가상머신 변경, 3:가상머신 반환) */
	private Integer crSorting;

	/** 가상머신 신청 사용자ID */
	private String crUserID;

	/** 가상머신 이름 */
	private String crVMName;

	/** 가상머신 cpu 용량 */
	private String crCPU;

	/** 가상머신 메모리(GB) */
	private String crMemory;

	/** 가상머신 하드디스크(GB) */
	private Integer crDisk;

	/** 사유 */
	private String crVMContext;

	/** 가상머신 아이피 주소 */
	private String crIPAddress;

	/** 가상머신 템플릿명 */
	private String crTemplet;

	/** 가상머신 호스트 */
	private String crHost;

	/** 가상머신 데이터스토어 */
	private String crStorage;

	/** 
	 * 가상머신 생성 승인 상태
	 * 1 : 신청
	 * 2 : 결재 완료
	 * 3 : 검토 완료
	 * 4 : 승인 완료
	 * 5 : 작업 완료
	 * 6 : 보류
	 * 7 : 반려
	 * 8 : 완료
	 * 10 : 신청 취소
	 */
	private Integer crApproval;

	/** 일시 */
	private String crDatetime;

	/** 가상머신 생성 신청 일시 */
	private String crApplytime;

	/** 가상머신 네트워크 */
	private String crNetWork;

	/** 가상머신 서비스ID */
	private Integer vmServiceID;

	/** 가상머신 생성 코멘트 */
	private String crComment;

	/** 가상머신 게이트웨이 */
	private String crGateway;

	/** 가상머신 아이피 */
	private String crNetmask;

	/** DHCP 여부(1:ON, 2:OFF) */
	private Integer crDhcp;

	/** DHCP 카테고리(1:테넌트, 2:서비스) */
	private Integer dhcpCategory;
	
	/** 테넌트 고유번호 */
	private Integer tenantId;
	
	/** 테넌트명 */
	private String tenantName;
	
	/** 서비스명 */
	private String serviceName;
	
	/** 핫 플러그 ON OFF */
	private String hotPlugOnOff;

	/** 가상머신 신청 사용자명 */
	private String userName;
	
	/** 단계 */
	private Integer stage;
	
	/** 전단계 */
	private Integer stageDown;
	
	/** 상태 */
	private Integer status;
	
	/** 부서 코드 */
	private String sDepartment;
	
	/** 사용자 승인(권한) */
	private int nApproval;
	
	/** 가상머신 cpu 용량  */
	private Integer vmCPU;

	/** 가상머신 메모리(GB)  */
	private Integer vmMemory;

	/** 가상머신 하드디스크(GB)  */
	private Integer vmDisk;
	
	/** 가상머신 운영체제  */
	private String vmOS;

	/** 설명  */
	private String description = "";

	/** 가상머신 cpu추가  */
	private String cpuHotAdd;

	/** 가상머신 메모리추가  */
	private String memoryHotAdd;

	/** 사용자 고유번호  */
	private Integer userId;
	
	/** 가상머신 ID  */
	private String vmID;
	
	/** 가상머신 Host  */
	private String vmHost;
	
	/** 변경 신청 카테고리  */
	private String category;
	
	/** 선택한 것의 값 */
	private String selectedValue;
	
	/** 선택한 것의 이름  */
	private String selectedText;
	
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
	 * @return the crSorting
	 */
	public Integer getCrSorting() {
		return crSorting;
	}

	/**
	 * @param crSorting the crSorting to set
	 */
	public void setCrSorting(Integer crSorting) {
		this.crSorting = crSorting;
	}

	/**
	 * @return the crUserID
	 */
	public String getCrUserID() {
		return crUserID;
	}

	/**
	 * @param crUserID the crUserID to set
	 */
	public void setCrUserID(String crUserID) {
		this.crUserID = crUserID;
	}

	/**
	 * @return the crVMName
	 */
	public String getCrVMName() {
		return crVMName;
	}

	/**
	 * @param crVMName the crVMName to set
	 */
	public void setCrVMName(String crVMName) {
		this.crVMName = crVMName;
	}

	/**
	 * @return the crCPU
	 */
	public String getCrCPU() {
		return crCPU;
	}

	/**
	 * @param crCPU the crCPU to set
	 */
	public void setCrCPU(String crCPU) {
		this.crCPU = crCPU;
	}

	/**
	 * @return the crMemory
	 */
	public String getCrMemory() {
		return crMemory;
	}

	/**
	 * @param crMemory the crMemory to set
	 */
	public void setCrMemory(String crMemory) {
		this.crMemory = crMemory;
	}

	/**
	 * @return the crDisk
	 */
	public Integer getCrDisk() {
		return crDisk;
	}

	/**
	 * @param crDisk the crDisk to set
	 */
	public void setCrDisk(Integer crDisk) {
		this.crDisk = crDisk;
	}

	/**
	 * @return the crVMContext
	 */
	public String getCrVMContext() {
		return crVMContext;
	}

	/**
	 * @param crVMContext the crVMContext to set
	 */
	public void setCrVMContext(String crVMContext) {
		this.crVMContext = crVMContext;
	}

	/**
	 * @return the crIPAddress
	 */
	public String getCrIPAddress() {
		return crIPAddress;
	}

	/**
	 * @param crIPAddress the crIPAddress to set
	 */
	public void setCrIPAddress(String crIPAddress) {
		this.crIPAddress = crIPAddress;
	}

	/**
	 * @return the crTemplet
	 */
	public String getCrTemplet() {
		return crTemplet;
	}

	/**
	 * @param crTemplet the crTemplet to set
	 */
	public void setCrTemplet(String crTemplet) {
		this.crTemplet = crTemplet;
	}

	/**
	 * @return the crHost
	 */
	public String getCrHost() {
		return crHost;
	}

	/**
	 * @param crHost the crHost to set
	 */
	public void setCrHost(String crHost) {
		this.crHost = crHost;
	}

	/**
	 * @return the crStorage
	 */
	public String getCrStorage() {
		return crStorage;
	}

	/**
	 * @param crStorage the crStorage to set
	 */
	public void setCrStorage(String crStorage) {
		this.crStorage = crStorage;
	}

	/**
	 * @return the crApproval
	 */
	public Integer getCrApproval() {
		return crApproval;
	}

	/**
	 * @param crApproval the crApproval to set
	 */
	public void setCrApproval(Integer crApproval) {
		this.crApproval = crApproval;
	}

	/**
	 * @return the crDatetime
	 */
	public String getCrDatetime() {
		return crDatetime;
	}

	/**
	 * @param crDatetime the crDatetime to set
	 */
	public void setCrDatetime(String crDatetime) {
		this.crDatetime = crDatetime;
	}

	/**
	 * @return the crApplytime
	 */
	public String getCrApplytime() {
		return crApplytime;
	}

	/**
	 * @param crApplytime the crApplytime to set
	 */
	public void setCrApplytime(String crApplytime) {
		this.crApplytime = crApplytime;
	}

	/**
	 * @return the crNetWork
	 */
	public String getCrNetWork() {
		return crNetWork;
	}

	/**
	 * @param crNetWork the crNetWork to set
	 */
	public void setCrNetWork(String crNetWork) {
		this.crNetWork = crNetWork;
	}

	/**
	 * @return the vmServiceID
	 */
	public Integer getVmServiceID() {
		return vmServiceID;
	}

	/**
	 * @param vmServiceID the vmServiceID to set
	 */
	public void setVmServiceID(Integer vmServiceID) {
		this.vmServiceID = vmServiceID;
	}

	/**
	 * @return the crComment
	 */
	public String getCrComment() {
		return crComment;
	}

	/**
	 * @param crComment the crComment to set
	 */
	public void setCrComment(String crComment) {
		this.crComment = crComment;
	}

	/**
	 * @return the crGateway
	 */
	public String getCrGateway() {
		return crGateway;
	}

	/**
	 * @param crGateway the crGateway to set
	 */
	public void setCrGateway(String crGateway) {
		this.crGateway = crGateway;
	}

	/**
	 * @return the crNetmask
	 */
	public String getCrNetmask() {
		return crNetmask;
	}

	/**
	 * @param crNetmask the crNetmask to set
	 */
	public void setCrNetmask(String crNetmask) {
		this.crNetmask = crNetmask;
	}

	/**
	 * @return the crDhcp
	 */
	public Integer getCrDhcp() {
		return crDhcp;
	}

	/**
	 * @param crDhcp the crDhcp to set
	 */
	public void setCrDhcp(Integer crDhcp) {
		this.crDhcp = crDhcp;
	}

	/**
	 * @return the dhcpCategory
	 */
	public Integer getDhcpCategory() {
		return dhcpCategory;
	}

	/**
	 * @param dhcpCategory the dhcpCategory to set
	 */
	public void setDhcpCategory(Integer dhcpCategory) {
		this.dhcpCategory = dhcpCategory;
	}

	/**
	 * @return the tenantId
	 */
	public Integer getTenantId() {
		return tenantId;
	}

	/**
	 * @param tenantId the tenantId to set
	 */
	public void setTenantId(Integer tenantId) {
		this.tenantId = tenantId;
	}

	/**
	 * @return the tenantName
	 */
	public String getTenantName() {
		return tenantName;
	}

	/**
	 * @param tenantName the tenantName to set
	 */
	public void setTenantName(String tenantName) {
		this.tenantName = tenantName;
	}

	/**
	 * @return the serviceName
	 */
	public String getServiceName() {
		return serviceName;
	}

	/**
	 * @param serviceName the serviceName to set
	 */
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	/**
	 * @return the hotPlugOnOff
	 */
	public String getHotPlugOnOff() {
		return hotPlugOnOff;
	}

	/**
	 * @param hotPlugOnOff the hotPlugOnOff to set
	 */
	public void setHotPlugOnOff(String hotPlugOnOff) {
		this.hotPlugOnOff = hotPlugOnOff;
	}

	/**
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}

	/**
	 * @param userName the userName to set
	 */
	public void setUserName(String userName) {
		this.userName = userName;
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
	 * @return the stageDown
	 */
	public Integer getStageDown() {
		return stageDown;
	}

	/**
	 * @param stageDown the stageDown to set
	 */
	public void setStageDown(Integer stageDown) {
		this.stageDown = stageDown;
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
	 * @return the vmCPU
	 */
	public Integer getVmCPU() {
		return vmCPU;
	}

	/**
	 * @param vmCPU the vmCPU to set
	 */
	public void setVmCPU(Integer vmCPU) {
		this.vmCPU = vmCPU;
	}

	/**
	 * @return the vmMemory
	 */
	public Integer getVmMemory() {
		return vmMemory;
	}

	/**
	 * @param vmMemory the vmMemory to set
	 */
	public void setVmMemory(Integer vmMemory) {
		this.vmMemory = vmMemory;
	}

	/**
	 * @return the vmDisk
	 */
	public Integer getVmDisk() {
		return vmDisk;
	}

	/**
	 * @param vmDisk the vmDisk to set
	 */
	public void setVmDisk(Integer vmDisk) {
		this.vmDisk = vmDisk;
	}

	/**
	 * @return the vmOS
	 */
	public String getVmOS() {
		return vmOS;
	}

	/**
	 * @param vmOS the vmOS to set
	 */
	public void setVmOS(String vmOS) {
		this.vmOS = vmOS;
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
	 * @return the cpuHotAdd
	 */
	public String getCpuHotAdd() {
		return cpuHotAdd;
	}

	/**
	 * @param cpuHotAdd the cpuHotAdd to set
	 */
	public void setCpuHotAdd(String cpuHotAdd) {
		this.cpuHotAdd = cpuHotAdd;
	}

	/**
	 * @return the memoryHotAdd
	 */
	public String getMemoryHotAdd() {
		return memoryHotAdd;
	}

	/**
	 * @param memoryHotAdd the memoryHotAdd to set
	 */
	public void setMemoryHotAdd(String memoryHotAdd) {
		this.memoryHotAdd = memoryHotAdd;
	}

	/**
	 * @return the userId
	 */
	public Integer getUserId() {
		return userId;
	}

	/**
	 * @param userId the userId to set
	 */
	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	/**
	 * @return the vmID
	 */
	public String getVmID() {
		return vmID;
	}

	/**
	 * @param vmID the vmID to set
	 */
	public void setVmID(String vmID) {
		this.vmID = vmID;
	}

	/**
	 * @return the vmHost
	 */
	public String getVmHost() {
		return vmHost;
	}

	/**
	 * @param vmHost the vmHost to set
	 */
	public void setVmHost(String vmHost) {
		this.vmHost = vmHost;
	}

	/**
	 * @return the category
	 */
	public String getCategory() {
		return category;
	}

	/**
	 * @param category the category to set
	 */
	public void setCategory(String category) {
		this.category = category;
	}

	/**
	 * @return the selectedValue
	 */
	public String getSelectedValue() {
		return selectedValue;
	}

	/**
	 * @param selectedValue the selectedValue to set
	 */
	public void setSelectedValue(String selectedValue) {
		this.selectedValue = selectedValue;
	}

	/**
	 * @return the selectedText
	 */
	public String getSelectedText() {
		return selectedText;
	}

	/**
	 * @param selectedText the selectedText to set
	 */
	public void setSelectedText(String selectedText) {
		this.selectedText = selectedText;
	}

	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
