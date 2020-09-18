package com.kdis.PROM.logic;

public class Vm_create {
	
	private String tenantsName;
	private String serviceName;
	private String userName;
	
	private int cr_num;
	private int cr_sorting;
	private String cr_sUserID;
	private String cr_vm_name;
	private String cr_cpu;
	private String cr_memory;
	private int cr_disk;
	private String cr_vmcontext;
	private String cr_ipaddress;
	private String cr_templet;
	private String cr_host;
	private String cr_storage;
	private int cr_approval;
	private String cr_datetime;
	private String cr_applytime;
	private String cr_netWork;
	private String vm_service_ID;
	private String cr_comment;
	
	private String cr_gateway;
	private String cr_netmask;
	private int cr_dhcp;
	
	private String vmOS;
	private String disk;
	private String description;
	private String tenant_str;
	private String service_str;
	private int maxStage;
	
	private int cpu;
	private int memory;
	private String cpuHotAdd;
	private String memoryHotAdd;
	
	//vm_data_info
	private String originallyHost;
	private String vm_ID;
	
	private int dhcpCategory;
	
	
	public String getVm_ID() {
		return vm_ID;
	}
	public void setVm_ID(String vm_ID) {
		this.vm_ID = vm_ID;
	}
	public String getOriginallyHost() {
		return originallyHost;
	}
	public void setOriginallyHost(String originallyHost) {
		this.originallyHost = originallyHost;
	}
	public int getCr_disk() {
		return cr_disk;
	}
	public void setCr_disk(int cr_disk) {
		this.cr_disk = cr_disk;
	}
	public int getDhcpCategory() {
		return dhcpCategory;
	}
	public void setDhcpCategory(int dhcpCategory) {
		this.dhcpCategory = dhcpCategory;
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
	public int getCpu() {
		return cpu;
	}
	public void setCpu(int cpu) {
		this.cpu = cpu;
	}
	public int getMemory() {
		return memory;
	}
	public void setMemory(int memory) {
		this.memory = memory;
	}
	public int getMaxStage() {
		return maxStage;
	}
	public void setMaxStage(int maxStage) {
		this.maxStage = maxStage;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getVmOS() {
		return vmOS;
	}
	public void setVmOS(String vmOS) {
		this.vmOS = vmOS;
	}
	public String getCr_gateway() {
		return cr_gateway;
	}
	public void setCr_gateway(String cr_gateway) {
		this.cr_gateway = cr_gateway;
	}
	public String getCr_netmask() {
		return cr_netmask;
	}
	public void setCr_netmask(String cr_netmask) {
		this.cr_netmask = cr_netmask;
	}
	public int getCr_dhcp() {
		return cr_dhcp;
	}
	public void setCr_dhcp(int cr_dhcp) {
		this.cr_dhcp = cr_dhcp;
	}
	public String getDisk() {
		return disk;
	}
	public void setDisk(String disk) {
		this.disk = disk;
	}
	public String getTenant_str() {
		return tenant_str;
	}
	public void setTenant_str(String tenant_str) {
		this.tenant_str = tenant_str;
	}
	public String getService_str() {
		return service_str;
	}
	public void setService_str(String service_str) {
		this.service_str = service_str;
	}
	public String getCr_comment() {
		return cr_comment;
	}
	public void setCr_comment(String cr_comment) {
		this.cr_comment = cr_comment;
	}
	public String getTenantsName() {
		return tenantsName;
	}
	public void setTenantsName(String tenantsName) {
		this.tenantsName = tenantsName;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCr_netWork() {
		return cr_netWork;
	}
	public void setCr_netWork(String cr_netWork) {
		this.cr_netWork = cr_netWork;
	}
	public int getCr_sorting() {
		return cr_sorting;
	}
	public void setCr_sorting(int cr_sorting) {
		this.cr_sorting = cr_sorting;
	}
	public String getVm_service_ID() {
		return vm_service_ID;
	}
	public void setVm_service_ID(String vm_service_ID) {
		this.vm_service_ID = vm_service_ID;
	}
	public String getCr_datetime() {
		return cr_datetime;
	}
	public void setCr_datetime(String cr_datetime) {
		this.cr_datetime = cr_datetime;
	}
	public int getCr_num() {
		return cr_num;
	}
	public void setCr_num(int cr_num) {
		this.cr_num = cr_num;
	}
	public String getCr_sUserID() {
		return cr_sUserID;
	}
	public void setCr_sUserID(String cr_sUserID) {
		this.cr_sUserID = cr_sUserID;
	}
	public String getCr_host() {
		return cr_host;
	}
	public void setCr_host(String cr_host) {
		this.cr_host = cr_host;
	}
	public String getCr_storage() {
		return cr_storage;
	}
	public void setCr_storage(String cr_storage) {
		this.cr_storage = cr_storage;
	}
	public String getCr_vm_name() {
		return cr_vm_name;
	}
	public void setCr_vm_name(String cr_vm_name) {
		this.cr_vm_name = cr_vm_name;
	}
	public String getCr_cpu() {
		return cr_cpu;
	}
	public void setCr_cpu(String cr_cpu) {
		this.cr_cpu = cr_cpu;
	}
	public String getCr_memory() {
		return cr_memory;
	}
	public void setCr_memory(String cr_memory) {
		this.cr_memory = cr_memory;
	}
	public String getCr_vmcontext() {
		return cr_vmcontext;
	}
	public void setCr_vmcontext(String cr_vmcontext) {
		this.cr_vmcontext = cr_vmcontext;
	}
	public String getCr_ipaddress() {
		return cr_ipaddress;
	}
	public void setCr_ipaddress(String cr_ipaddress) {
		this.cr_ipaddress = cr_ipaddress;
	}
	public String getCr_templet() {
		return cr_templet;
	}
	public void setCr_templet(String cr_templet) {
		this.cr_templet = cr_templet;
	}
	public int getCr_approval() {
		return cr_approval;
	}
	public void setCr_approval(int cr_approval) {
		this.cr_approval = cr_approval;
	}
	
	public String getCr_applytime() {
		return cr_applytime;
	}
	public void setCr_applytime(String cr_applytime) {
		this.cr_applytime = cr_applytime;
	}
	
	@Override
	public String toString() {
		return "Vm_create [tenantsName=" + tenantsName + ", serviceName=" + serviceName + ", userName=" + userName + ", cr_num=" + cr_num + ", cr_sorting=" + cr_sorting + ", cr_sUserID=" + cr_sUserID + ", cr_vm_name=" + cr_vm_name
				+ ", cr_cpu=" + cr_cpu + ", cr_memory=" + cr_memory + ", cr_disk=" + cr_disk + ", cr_vmcontext=" + cr_vmcontext + ", cr_ipaddress=" + cr_ipaddress + ", cr_templet=" + cr_templet + ", cr_host=" + cr_host + ", cr_storage="
				+ cr_storage + ", cr_approval=" + cr_approval + ", cr_datetime=" + cr_datetime + ", cr_applytime=" + cr_applytime + ", cr_netWork=" + cr_netWork + ", vm_service_ID=" + vm_service_ID + ", cr_comment=" + cr_comment
				+ ", cr_gateway=" + cr_gateway + ", cr_netmask=" + cr_netmask + ", cr_dhcp=" + cr_dhcp + ", vmOS=" + vmOS + ", disk=" + disk + ", description=" + description + ", tenant_str=" + tenant_str + ", service_str=" + service_str
				+ ", maxStage=" + maxStage + ", cpu=" + cpu + ", memory=" + memory + ", cpuHotAdd=" + cpuHotAdd + ", memoryHotAdd=" + memoryHotAdd + ", originallyHost=" + originallyHost + ", vm_ID=" + vm_ID + ", dhcpCategory="
				+ dhcpCategory + "]";
	}
	
	

}
