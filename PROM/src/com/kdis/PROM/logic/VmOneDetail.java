package com.kdis.PROM.logic;

public class VmOneDetail {

	private int vm_service_ID;
	private String vm_service_name;
	private String vm_ID;
	private String vm_name;
	private String vm_devices;
	private String vm_status;
	private String cpuHotAdd;
	private String memoryHotAdd;
	private String vm_OS;
	
	public String getVm_OS() {
		return vm_OS;
	}
	public void setVm_OS(String vm_OS) {
		this.vm_OS = vm_OS;
	}
	public String getVm_status() {
		return vm_status;
	}
	public void setVm_status(String vm_status) {
		this.vm_status = vm_status;
	}
	public String getCpuHotAdd() {
		return cpuHotAdd;
	}
	public void setCpuHotAdd(String cpuHotAdd) {
		this.cpuHotAdd = cpuHotAdd;
	}
	public String getMemoryHotAdd() {
		return memoryHotAdd;
	}
	public void setMemoryHotAdd(String memoryHotAdd) {
		this.memoryHotAdd = memoryHotAdd;
	}
	public String getVm_devices() {
		return vm_devices;
	}
	public void setVm_devices(String vm_devices) {
		this.vm_devices = vm_devices;
	}
	public int getVm_service_ID() {
		return vm_service_ID;
	}
	public void setVm_service_ID(int vm_service_ID) {
		this.vm_service_ID = vm_service_ID;
	}
	public String getVm_service_name() {
		return vm_service_name;
	}
	public void setVm_service_name(String vm_service_name) {
		this.vm_service_name = vm_service_name;
	}
	public String getVm_ID() {
		return vm_ID;
	}
	public void setVm_ID(String vm_ID) {
		this.vm_ID = vm_ID;
	}
	public String getVm_name() {
		return vm_name;
	}
	public void setVm_name(String vm_name) {
		this.vm_name = vm_name;
	}
	
	@Override
	public String toString() {
		return "VmOneDetail [vm_service_ID=" + vm_service_ID + ", vm_service_name=" + vm_service_name + ", vm_ID="
				+ vm_ID + ", vm_name=" + vm_name + ", vm_devices=" + vm_devices + ", vm_status=" + vm_status
				+ ", cpuHotAdd=" + cpuHotAdd + ", memoryHotAdd=" + memoryHotAdd + ", vm_OS=" + vm_OS + "]";
	}
	
	
	
	
	
	
}
