package com.kdis.PROM.logic;

public class ExternalServer {

	private int id;
	private String name;
	private int serverType;
	private String connectString;
	private String account;
	private String password;
	private int port;
	private int sSL;
	private int isUse;
	private int status;
	private String description;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getServerType() {
		return serverType;  
	}
	public void setServerType(int serverType) {
		this.serverType = serverType;
	}
	public String getConnectString() {
		return connectString;
	}
	public void setConnectString(String connectString) {
		this.connectString = connectString;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getPort() {
		return port;
	}
	public void setPort(int port) {
		this.port = port;
	}
	
	public int getsSL() {
		return sSL;
	}
	public void setsSL(int sSL) {
		this.sSL = sSL;
	}
	public int getIsUse() {
		return isUse;
	}
	public void setIsUse(int isUse) {
		this.isUse = isUse;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	@Override
	public String toString() {
		return "ExternalServer [id=" + id + ", name=" + name + ", serverType=" + serverType + ", connectString="
				+ connectString + ", account=" + account + ", password=" + password + ", port=" + port + ", sSL=" + sSL
				+ ", isUse=" + isUse + ", status=" + status + ", description=" + description + "]";
	}
	
	
	
	
	
	
	
}
