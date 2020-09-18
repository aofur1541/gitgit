package com.kdis.PROM.logic;

public class Ep_service {

	private String nEp_num;
	private String sEp_name;
	private String dEp_datetime;
	private int nEp_subfolder;
	
	public int getnEp_subfolder() {
		return nEp_subfolder;
	}
	public void setnEp_subfolder(int nEp_subfolder) {
		this.nEp_subfolder = nEp_subfolder;
	}
	public String getnEp_num() {
		return nEp_num;
	}
	public void setnEp_num(String nEp_num) {
		this.nEp_num = nEp_num;
	}
	public String getsEp_name() {
		return sEp_name;
	}
	public void setsEp_name(String sEp_name) {
		this.sEp_name = sEp_name;
	}
	public String getdEp_datetime() {
		return dEp_datetime;
	}
	public void setdEp_datetime(String dEp_datetime) {
		this.dEp_datetime = dEp_datetime;
	}
	
	@Override
	public String toString() {
		return "Ep_service [nEp_num=" + nEp_num + ", sEp_name=" + sEp_name + ", dEp_datetime=" + dEp_datetime
				+ ", nEp_subfolder=" + nEp_subfolder + "]";
	}
	
	
	
}
