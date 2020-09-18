package com.kdis.PROM.logic;

public class Vm_data_info {
	
	private String name;
	private String servicename;
	private String vm_ID;
	private String vm_name;
	private int vm_cpu;
	private int vm_memory;
	private String vm_host;
	private String vm_DataStore;
	private int vm_disk;
	private String vm_vmtools_status;
	private String vm_ipaddr1;
	private String vm_ipaddr2;
	private String vm_ipaddr3;
	private String vm_status;
	private String vm_templet;
	private String vm_OS;
	private String vm_service_ID;
	private String vm_createtime;
	private String vm_devices;
	private String sEp_num;
	private String cpuHotAdd;
	private String memoryHotAdd;
	private int template_onoff;
	private String description;
	
	private int hostCPU;
	private int hostMemory;
	private String hostId;
	
	//tenants
	private int tenants_id;
	
	//service 
	private int service_id;
	
	
	public String getHostId() {
		return hostId;
	}
	public void setHostId(String hostId) {
		this.hostId = hostId;
	}
	public int getService_id() {
		return service_id;
	}
	public void setService_id(int service_id) {
		this.service_id = service_id;
	}
	public int getTenants_id() {
		return tenants_id;
	}
	public void setTenants_id(int tenants_id) {
		this.tenants_id = tenants_id;
	}
	public int getHostCPU() {
		return hostCPU;
	}
	public void setHostCPU(int hostCPU) {
		this.hostCPU = hostCPU;
	}
	public int getHostMemory() {
		return hostMemory;
	}
	public void setHostMemory(int hostMemory) {
		this.hostMemory = hostMemory;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getServicename() {
		return servicename;
	}
	public void setServicename(String servicename) {
		this.servicename = servicename;
	}
	public int getTemplate_onoff() {
		return template_onoff;
	}
	public void setTemplate_onoff(int template_onoff) {
		this.template_onoff = template_onoff;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public String getVm_DataStore() {
		return vm_DataStore;
	}
	public void setVm_DataStore(String vm_DataStore) {
		this.vm_DataStore = vm_DataStore;
	}
	public String getsEp_num() {
		return sEp_num;
	}
	public void setsEp_num(String sEp_num) {
		this.sEp_num = sEp_num;
	}
	public String getVm_createtime() {
		return vm_createtime;
	}
	public void setVm_createtime(String vm_createtime) {
		this.vm_createtime = vm_createtime;
	}
	public String getVm_service_ID() {
		return vm_service_ID;
	}
	public void setVm_service_ID(String vm_service_ID) {
		this.vm_service_ID = vm_service_ID;
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
	
	public int getVm_cpu() {
		return vm_cpu;
	}
	public void setVm_cpu(int vm_cpu) {
		this.vm_cpu = vm_cpu;
	}
	public int getVm_memory() {
		return vm_memory;
	}
	public void setVm_memory(int vm_memory) {
		this.vm_memory = vm_memory;
	}
	public String getVm_host() {
		return vm_host;
	}
	public void setVm_host(String vm_host) {
		this.vm_host = vm_host;
	}
	public int getVm_disk() {
		return vm_disk;
	}
	public void setVm_disk(int vm_disk) {
		this.vm_disk = vm_disk;
	}
	public String getVm_vmtools_status() {
		return vm_vmtools_status;
	}
	public void setVm_vmtools_status(String vm_vmtools_status) {
		this.vm_vmtools_status = vm_vmtools_status;
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
	public String getVm_templet() {
		return vm_templet;
	}
	public void setVm_templet(String vm_templet) {
		this.vm_templet = vm_templet;
	}
	public String getVm_OS() {
		return vm_OS;
	}
	public void setVm_OS(String vm_OS) {
		this.vm_OS = vm_OS;
	}
	
	@Override
	public String toString() {
		return "Vm_data_info [name=" + name + ", servicename=" + servicename + ", vm_ID=" + vm_ID + ", vm_name=" + vm_name + ", vm_cpu=" + vm_cpu + ", vm_memory=" + vm_memory + ", vm_host=" + vm_host + ", vm_DataStore=" + vm_DataStore
				+ ", vm_disk=" + vm_disk + ", vm_vmtools_status=" + vm_vmtools_status + ", vm_ipaddr1=" + vm_ipaddr1 + ", vm_ipaddr2=" + vm_ipaddr2 + ", vm_ipaddr3=" + vm_ipaddr3 + ", vm_status=" + vm_status + ", vm_templet=" + vm_templet
				+ ", vm_OS=" + vm_OS + ", vm_service_ID=" + vm_service_ID + ", vm_createtime=" + vm_createtime + ", vm_devices=" + vm_devices + ", sEp_num=" + sEp_num + ", cpuHotAdd=" + cpuHotAdd + ", memoryHotAdd=" + memoryHotAdd
				+ ", template_onoff=" + template_onoff + ", description=" + description + ", hostCPU=" + hostCPU + ", hostMemory=" + hostMemory + ", hostId=" + hostId + ", tenants_id=" + tenants_id + ", service_id=" + service_id + "]";
	}
	
}
