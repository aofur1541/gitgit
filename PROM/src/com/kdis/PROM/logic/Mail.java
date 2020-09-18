package com.kdis.PROM.logic;

public class Mail {
	private int mailHost;
	private String username;
	private String password;
	private String mailFrom;
	private String mailTo;
	private String mailCc;
	private String mailSubject;
	private String mailContent;
	private int mailPort;
	private String contentType;
	
	public int getMailHost() {
		return mailHost;
	}
	public void setMailHost(int mailHost) {
		this.mailHost = mailHost;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMailFrom() {
		return mailFrom;
	}
	public void setMailFrom(String mailFrom) {
		this.mailFrom = mailFrom;
	}
	public String getMailTo() {
		return mailTo;
	}
	public void setMailTo(String mailTo) {
		this.mailTo = mailTo;
	}
	public String getMailCc() {
		return mailCc;
	}
	public void setMailCc(String mailCc) {
		this.mailCc = mailCc;
	}
	public String getMailSubject() {
		return mailSubject;
	}
	public void setMailSubject(String mailSubject) {
		this.mailSubject = mailSubject;
	}
	public String getMailContent() {
		return mailContent;
	}
	public void setMailContent(String mailContent) {
		this.mailContent = mailContent;
	}
	public int getMailPort() {
		return mailPort;
	}
	public void setMailPort(int mailPort) {
		this.mailPort = mailPort;
	}
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	
	@Override
	public String toString() {
		return "Mail [mailHost=" + mailHost + ", username=" + username + ", password=" + password + ", mailFrom="
				+ mailFrom + ", mailTo=" + mailTo + ", mailCc=" + mailCc + ", mailSubject=" + mailSubject
				+ ", mailContent=" + mailContent + ", mailPort=" + mailPort + ", contentType=" + contentType + "]";
	}
	
}
