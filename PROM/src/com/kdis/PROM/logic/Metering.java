package com.kdis.PROM.logic;

public class Metering {

	private int vm_service_ID;
	private String vm_service_name;
	private int total_cpu;
	private int total_memory;
	
	
	
	public String getVm_service_name() {
		return vm_service_name;
	}
	public void setVm_service_name(String vm_service_name) {
		this.vm_service_name = vm_service_name;
	}
	public int getVm_service_ID() {
		return vm_service_ID;
	}
	public void setVm_service_ID(int vm_service_ID) {
		this.vm_service_ID = vm_service_ID;
	}
	public int getTotal_cpu() {
		return total_cpu;
	}
	public void setTotal_cpu(int total_cpu) {
		this.total_cpu = total_cpu;
	}
	public int getTotal_memory() {
		return total_memory;
	}
	public void setTotal_memory(int total_memory) {
		this.total_memory = total_memory;
	}
	
	@Override
	public String toString() {
		return "Metering [vm_service_ID=" + vm_service_ID + ", vm_service_name=" + vm_service_name + ", total_cpu="
				+ total_cpu + ", total_memory=" + total_memory + "]";
	}
	
	
	
	
	
	
	
	
}
