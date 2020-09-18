package com.kdis.PROM.logic;

public class Vm_host_info {
	
	private int sumCPU;
	private int sumMemory;
	private String vm_HID;
	private String vm_Hhostname;
	private int vm_Hcpu;
	private int vm_Hmemory;
	private String vm_Hver_bu;
	private String vm_Hvendor;
	private String vm_HIP;
	private int vm_HvmCount;
	private String vm_Hpower;
	private int vm_Huptime;
	private String hostParent;
	private String host_model;
	private String host_cpu_model;
	private int host_thread;
	
	//clusterInfo
	private String clusterId;
	
	
	public String getClusterId() {
		return clusterId;
	}
	public void setClusterId(String clusterId) {
		this.clusterId = clusterId;
	}
	public int getHost_thread() {
		return host_thread;
	}
	public void setHost_thread(int host_thread) {
		this.host_thread = host_thread;
	}
	public int getSumCPU() {
		return sumCPU;
	}
	public void setSumCPU(int sumCPU) {
		this.sumCPU = sumCPU;
	}
	public int getSumMemory() {
		return sumMemory;
	}
	public void setSumMemory(int sumMemory) {
		this.sumMemory = sumMemory;
	}
	public String getHost_model() {
		return host_model;
	}
	public void setHost_model(String host_model) {
		this.host_model = host_model;
	}
	public String getHost_cpu_model() {
		return host_cpu_model;
	}
	public void setHost_cpu_model(String host_cpu_model) {
		this.host_cpu_model = host_cpu_model;
	}
	public String getHostParent() {
		return hostParent;
	}
	public void setHostParent(String hostParent) {
		this.hostParent = hostParent;
	}
	public int getVm_Huptime() {
		return vm_Huptime;
	}
	public void setVm_Huptime(int vm_Huptime) {
		this.vm_Huptime = vm_Huptime;
	}
	public String getVm_Hpower() {
		return vm_Hpower;
	}
	public void setVm_Hpower(String vm_Hpower) {
		this.vm_Hpower = vm_Hpower;
	}
	public String getVm_HID() {
		return vm_HID;
	}
	public void setVm_HID(String vm_HID) {
		this.vm_HID = vm_HID;
	}
	public String getVm_Hhostname() {
		return vm_Hhostname;
	}
	public void setVm_Hhostname(String vm_Hhostname) {
		this.vm_Hhostname = vm_Hhostname;
	}
	
	public int getVm_Hcpu() {
		return vm_Hcpu;
	}
	public void setVm_Hcpu(int vm_Hcpu) {
		this.vm_Hcpu = vm_Hcpu;
	}
	public int getVm_Hmemory() {
		return vm_Hmemory;
	}
	public void setVm_Hmemory(int vm_Hmemory) {
		this.vm_Hmemory = vm_Hmemory;
	}
	public String getVm_Hver_bu() {
		return vm_Hver_bu;
	}
	public void setVm_Hver_bu(String vm_Hver_bu) {
		this.vm_Hver_bu = vm_Hver_bu;
	}
	public String getVm_Hvendor() {
		return vm_Hvendor;
	}
	public void setVm_Hvendor(String vm_Hvendor) {
		this.vm_Hvendor = vm_Hvendor;
	}
	public String getVm_HIP() {
		return vm_HIP;
	}
	public void setVm_HIP(String vm_HIP) {
		this.vm_HIP = vm_HIP;
	}
	public int getVm_HvmCount() {
		return vm_HvmCount;
	}
	public void setVm_HvmCount(int vm_HvmCount) {
		this.vm_HvmCount = vm_HvmCount;
	}
	@Override
	public String toString() {
		return "Vm_host_info [sumCPU=" + sumCPU + ", sumMemory=" + sumMemory + ", vm_HID=" + vm_HID + ", vm_Hhostname=" + vm_Hhostname + ", vm_Hcpu=" + vm_Hcpu + ", vm_Hmemory=" + vm_Hmemory + ", vm_Hver_bu=" + vm_Hver_bu + ", vm_Hvendor="
				+ vm_Hvendor + ", vm_HIP=" + vm_HIP + ", vm_HvmCount=" + vm_HvmCount + ", vm_Hpower=" + vm_Hpower + ", vm_Huptime=" + vm_Huptime + ", hostParent=" + hostParent + ", host_model=" + host_model + ", host_cpu_model="
				+ host_cpu_model + ", host_thread=" + host_thread + ", clusterId=" + clusterId + "]";
	}
	
	
	
	
	

}
