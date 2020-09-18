package com.kdis.PROM.logic;

public class PowerOffCheck {

	private String vm_name;
	private String vm_service_name;
	private String sEp_name;
	
	public String getsEp_name() {
		return sEp_name;
	}
	public void setsEp_name(String sEp_name) {
		this.sEp_name = sEp_name;
	}
	public String getVm_name() {
		return vm_name;
	}
	public void setVm_name(String vm_name) {
		this.vm_name = vm_name;
	}
	public String getVm_service_name() {
		return vm_service_name;
	}
	public void setVm_service_name(String vm_service_name) {
		this.vm_service_name = vm_service_name;
	}
	
	@Override
	public String toString() {
		return "PowerOffCheck [vm_name=" + vm_name + ", vm_service_name=" + vm_service_name + ", sEp_name=" + sEp_name
				+ "]";
	}
	
	
	
	
	
	
}
