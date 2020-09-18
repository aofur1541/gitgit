package com.kdis.PROM.logic;

public class LogConfiguration {

	private String sUserID;
	private int nCategory;
	private int nWebloglimit;
	private int nConfirm;
	private int nLoginoutskip;
	
	public String getsUserID() {
		return sUserID;
	}
	public void setsUserID(String sUserID) {
		this.sUserID = sUserID;
	}
	public int getnCategory() {
		return nCategory;
	}
	public void setnCategory(int nCategory) {
		this.nCategory = nCategory;
	}
	public int getnWebloglimit() {
		return nWebloglimit;
	}
	public void setnWebloglimit(int nWebloglimit) {
		this.nWebloglimit = nWebloglimit;
	}
	public int getnConfirm() {
		return nConfirm;
	}
	public void setnConfirm(int nConfirm) {
		this.nConfirm = nConfirm;
	}
	public int getnLoginoutskip() {
		return nLoginoutskip;
	}
	public void setnLoginoutskip(int nLoginoutskip) {
		this.nLoginoutskip = nLoginoutskip;
	}
	
	@Override
	public String toString() {
		return "LogConfiguration [sUserID=" + sUserID + ", nCategory=" + nCategory + ", nWebloglimit=" + nWebloglimit
				+ ", nConfirm=" + nConfirm + ", nLoginoutskip=" + nLoginoutskip + "]";
	}
	
}
