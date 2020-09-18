package com.kdis.PROM.logic;

public class ServiceMonitoring {

	private int vm_service_ID;
	private String vm_service_name;
	private String vm_ID;
	private String vm_name;
	private String cpuUse;
	private String memoryUse;
	private String dataUseTime;
	private String vm_ipaddr1;
	private String vm_ipaddr2;
	private String vm_ipaddr3;
	private String vm_status;
	
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
	public String getCpuUse() {
		return cpuUse;
	}
	public void setCpuUse(String cpuUse) {
		this.cpuUse = cpuUse;
	}
	public String getMemoryUse() {
		return memoryUse;
	}
	public void setMemoryUse(String memoryUse) {
		this.memoryUse = memoryUse;
	}
	public String getDataUseTime() {
		return dataUseTime;
	}
	public void setDataUseTime(String dataUseTime) {
		this.dataUseTime = dataUseTime;
	}
	public String getVm_ipaddr1() {
		return vm_ipaddr1;
	}
	public void setVm_ipaddr1(String vm_ipaddr1) {
		this.vm_ipaddr1 = vm_ipaddr1;
	}
	public String getVm_ipaddr2() {
		return vm_ipaddr2;
	}
	public void setVm_ipaddr2(String vm_ipaddr2) {
		this.vm_ipaddr2 = vm_ipaddr2;
	}
	public String getVm_ipaddr3() {
		return vm_ipaddr3;
	}
	public void setVm_ipaddr3(String vm_ipaddr3) {
		this.vm_ipaddr3 = vm_ipaddr3;
	}
	public String getVm_status() {
		return vm_status;
	}
	public void setVm_status(String vm_status) {
		this.vm_status = vm_status;
	}
	
	@Override
	public String toString() {
		return "ServiceMonitoring [vm_service_ID=" + vm_service_ID + ", vm_service_name=" + vm_service_name + ", vm_ID="
				+ vm_ID + ", vm_name=" + vm_name + ", cpuUse=" + cpuUse + ", memoryUse=" + memoryUse + ", dataUseTime="
				+ dataUseTime + ", vm_ipaddr1=" + vm_ipaddr1 + ", vm_ipaddr2=" + vm_ipaddr2 + ", vm_ipaddr3="
				+ vm_ipaddr3 + ", vm_status=" + vm_status + "]";
	}

}
