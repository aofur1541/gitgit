package com.kdis.PROM.config.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 외부 서버 연동 VO class
 * 
 * @author KimHahn
 *
 */
public class ExternalServerVO {

	/** 서버 고유번호 */
	private Integer id;

	/** 서버 이름  */
	private String name;

	/** 
	 * 서버 구분자
	 * 1 : vCenter
	 * 2 : vRealize Orchestrator
	 * 3 : vRealize Operations
	 * 4 : vRealize Automation
	 * 5 : Email
	 * 6 : OTP Server
	 */
	private Integer serverType;

	/** 연결 URL  */
	private String connectString;

	/** 연결 아이디  */
	private String account;

	/** 연결 패스워드  */
	private String password;

	/** 연결 포트  */
	private Integer port;

	/** SSL 여부  */
	private Integer ssl;

	/** 사용 여부  */
	private Integer isUse;

	/** 상태  */
	private Integer status;

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
	 * @return the serverType
	 */
	public Integer getServerType() {
		return serverType;
	}

	/**
	 * @param serverType the serverType to set
	 */
	public void setServerType(Integer serverType) {
		this.serverType = serverType;
	}

	/**
	 * @return the connectString
	 */
	public String getConnectString() {
		return connectString;
	}

	/**
	 * @param connectString the connectString to set
	 */
	public void setConnectString(String connectString) {
		this.connectString = connectString;
	}

	/**
	 * @return the account
	 */
	public String getAccount() {
		return account;
	}

	/**
	 * @param account the account to set
	 */
	public void setAccount(String account) {
		this.account = account;
	}

	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @return the port
	 */
	public Integer getPort() {
		return port;
	}

	/**
	 * @param port the port to set
	 */
	public void setPort(Integer port) {
		this.port = port;
	}

	/**
	 * @return the ssl
	 */
	public Integer getSsl() {
		return ssl;
	}

	/**
	 * @param ssl the ssl to set
	 */
	public void setSsl(Integer ssl) {
		this.ssl = ssl;
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
