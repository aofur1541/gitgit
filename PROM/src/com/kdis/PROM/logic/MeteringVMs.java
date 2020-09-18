package com.kdis.PROM.logic;

public class MeteringVMs {

	private int nVm_service_ID;
	private String sVm_ID;
	private String sVm_name;
	private int nVm_cpu;
	private int nVm_memory;
	private String sVm_host;
	private String dMeteringDate;
	
	
	public String getdMeteringDate() {
		return dMeteringDate;
	}
	public void setdMeteringDate(String dMeteringDate) {
		this.dMeteringDate = dMeteringDate;
	}
	public String getsVm_ID() {
		return sVm_ID;
	}
	public void setsVm_ID(String sVm_ID) {
		this.sVm_ID = sVm_ID;
	}
	public int getnVm_service_ID() {
		return nVm_service_ID;
	}
	public void setnVm_service_ID(int nVm_service_ID) {
		this.nVm_service_ID = nVm_service_ID;
	}
	public String getsVm_name() {
		return sVm_name;
	}
	public void setsVm_name(String sVm_name) {
		this.sVm_name = sVm_name;
	}
	public int getnVm_cpu() {
		return nVm_cpu;
	}
	public void setnVm_cpu(int nVm_cpu) {
		this.nVm_cpu = nVm_cpu;
	}
	public int getnVm_memory() {
		return nVm_memory;
	}
	public void setnVm_memory(int nVm_memory) {
		this.nVm_memory = nVm_memory;
	}
	public String getsVm_host() {
		return sVm_host;
	}
	public void setsVm_host(String sVm_host) {
		this.sVm_host = sVm_host;
	}
	
	@Override
	public String toString() {
		return "MeteringVMs [nVm_service_ID=" + nVm_service_ID + ", sVm_ID=" + sVm_ID + ", sVm_name=" + sVm_name
				+ ", nVm_cpu=" + nVm_cpu + ", nVm_memory=" + nVm_memory + ", sVm_host=" + sVm_host + ", dMeteringDate="
				+ dMeteringDate + "]";
	}
	
	
	
	
	
	
	
}
