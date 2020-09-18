package com.kdis.PROM.logic;

public class VROConfig {

	private String vROURL;
	private String vROSSOID;
	private String vROSSOPW;
	private String vCURL;
	
	public String getvCURL() {
		return vCURL;
	}
	public void setvCURL(String vCURL) {
		this.vCURL = vCURL;
	}
	public String getvROURL() {
		return vROURL;
	}
	public void setvROURL(String vROURL) {
		this.vROURL = vROURL;
	}
	public String getvROSSOID() {
		return vROSSOID;
	}
	public void setvROSSOID(String vROSSOID) {
		this.vROSSOID = vROSSOID;
	}
	public String getvROSSOPW() {
		return vROSSOPW;
	}
	public void setvROSSOPW(String vROSSOPW) {
		this.vROSSOPW = vROSSOPW;
	}
	@Override
	public String toString() {
		return "VROConfig [vROURL=" + vROURL + ", vROSSOID=" + vROSSOID + ", vROSSOPW=" + vROSSOPW + ", vCURL=" + vCURL
				+ "]";
	}
	
}
