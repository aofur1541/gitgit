package com.kdis.PROM.logic;

import java.util.Date;

public class MeteringSum {

	private int nVm_service_ID;
	private String sVm_service_name;
	private int nTotal_cpu;
	private int nTotal_memory;
	private String dMeteringDate;
	private String dMinDate;
	private String dMaxDate;
	private int nCountDay;
	
	
	public String getdMinDate() {
		return dMinDate;
	}
	public void setdMinDate(String dMinDate) {
		this.dMinDate = dMinDate;
	}
	public String getdMaxDate() {
		return dMaxDate;
	}
	public void setdMaxDate(String dMaxDate) {
		this.dMaxDate = dMaxDate;
	}
	public int getnCountDay() {
		return nCountDay;
	}
	public void setnCountDay(int nCountDay) {
		this.nCountDay = nCountDay;
	}
	public String getsVm_service_name() {
		return sVm_service_name;
	}
	public void setsVm_service_name(String sVm_service_name) {
		this.sVm_service_name = sVm_service_name;
	}
	public int getnVm_service_ID() {
		return nVm_service_ID;
	}
	public void setnVm_service_ID(int nVm_service_ID) {
		this.nVm_service_ID = nVm_service_ID;
	}
	public int getnTotal_cpu() {
		return nTotal_cpu;
	}
	public void setnTotal_cpu(int nTotal_cpu) {
		this.nTotal_cpu = nTotal_cpu;
	}
	public int getnTotal_memory() {
		return nTotal_memory;
	}
	public void setnTotal_memory(int nTotal_memory) {
		this.nTotal_memory = nTotal_memory;
	}
	public String getdMeteringDate() {
		return dMeteringDate;
	}
	public void setdMeteringDate(String dMeteringDate) {
		this.dMeteringDate = dMeteringDate;
	}
	@Override
	public String toString() {
		return "MeteringSum [nVm_service_ID=" + nVm_service_ID + ", sVm_service_name=" + sVm_service_name
				+ ", nTotal_cpu=" + nTotal_cpu + ", nTotal_memory=" + nTotal_memory + ", dMeteringDate=" + dMeteringDate
				+ ", nCountDay=" + nCountDay + "]";
	}
	
	
	
	
	
	
	
}
