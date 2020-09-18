package com.kdis.PROM.logic;

public class Vm_service_userlist {

	private String vm_sUserID;
	private int vm_service_ID;
	private String vm_service_Name;
	
	
	public int getVm_service_ID() {
		return vm_service_ID;
	}
	public void setVm_service_ID(int vm_service_ID) {
		this.vm_service_ID = vm_service_ID;
	}
	public String getVm_sUserID() {
		return vm_sUserID;
	}
	public void setVm_sUserID(String vm_sUserID) {
		this.vm_sUserID = vm_sUserID;
	}
	
	public String getVm_service_Name() {
		return vm_service_Name;
	}
	public void setVm_service_Name(String vm_service_Name) {
		this.vm_service_Name = vm_service_Name;
	}
	
	@Override
	public String toString() {
		return "Vm_service_userlist [vm_sUserID=" + vm_sUserID + ", vm_service_ID=" + vm_service_ID
				+ ", vm_service_Name=" + vm_service_Name + "]";
	}
	
	
	
}
