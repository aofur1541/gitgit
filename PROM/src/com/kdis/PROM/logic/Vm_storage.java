package com.kdis.PROM.logic;


public class Vm_storage {

	private String clusterId;
	
	public String getClusterId() {
		return clusterId;
	}
	public void setClusterId(String clusterId) {
		this.clusterId = clusterId;
	}
	private String st_ID;
	private String st_name;
	private int st_Allca;
	private int st_Useca;
	private int st_space;
	private String st_datetime;
	
	public String getSt_ID() {
		return st_ID;
	}
	public void setSt_ID(String st_ID) {
		this.st_ID = st_ID;
	}
	public String getSt_name() {
		return st_name;
	}
	public void setSt_name(String st_name) {
		this.st_name = st_name;
	}
	public int getSt_Allca() {
		return st_Allca;
	}
	public void setSt_Allca(int st_Allca) {
		this.st_Allca = st_Allca;
	}
	public int getSt_Useca() {
		return st_Useca;
	}
	public void setSt_Useca(int st_Useca) {
		this.st_Useca = st_Useca;
	}
	public int getSt_space() {
		return st_space;
	}
	public void setSt_space(int st_space) {
		this.st_space = st_space;
	}
	public String getSt_datetime() {
		return st_datetime;
	}
	public void setSt_datetime(String st_datetime) {
		this.st_datetime = st_datetime;
	}
	@Override
	public String toString() {
		return "Vm_storage [clusterId=" + clusterId + ", st_ID=" + st_ID + ", st_name=" + st_name + ", st_Allca="
				+ st_Allca + ", st_Useca=" + st_Useca + ", st_space=" + st_space + ", st_datetime=" + st_datetime + "]";
	}
	
	
	
	
}
