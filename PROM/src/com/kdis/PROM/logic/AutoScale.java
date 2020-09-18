package com.kdis.PROM.logic;

public class AutoScale {

	private int id;
	private int service_id;
	private int tenants_id;
	private int cpuUp;
	private int memoryUp;
	private int cpuDown;
	private int memoryDown;
	private int minVM;
	private int maxVM;
	private String naming;
	private String postfix;
	private String startIP;
	private String endIP;
	private int isUse;
	private String template_id;
	private int status;
	private String next_vm;
	
	private String serviceName;
	private String vmName;
	
	private String service_ids;
	private String template_ids;
	
	public String getNext_vm() {
		return next_vm;
	}
	public void setNext_vm(String next_vm) {
		this.next_vm = next_vm;
	}
	public String getService_ids() {
		return service_ids;
	}
	public void setService_ids(String service_ids) {
		this.service_ids = service_ids;
	}
	public String getTemplate_ids() {
		return template_ids;
	}
	public void setTemplate_ids(String template_ids) {
		this.template_ids = template_ids;
	}
	public int getTenants_id() {
		return tenants_id;
	}
	public void setTenants_id(int tenants_id) {
		this.tenants_id = tenants_id;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public String getVmName() {
		return vmName;
	}
	public void setVmName(String vmName) {
		this.vmName = vmName;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getService_id() {
		return service_id;
	}
	public void setService_id(int service_id) {
		this.service_id = service_id;
	}
	public int getCpuUp() {
		return cpuUp;
	}
	public void setCpuUp(int cpuUp) {
		this.cpuUp = cpuUp;
	}
	public int getMemoryUp() {
		return memoryUp;
	}
	public void setMemoryUp(int memoryUp) {
		this.memoryUp = memoryUp;
	}
	public int getCpuDown() {
		return cpuDown;
	}
	public void setCpuDown(int cpuDown) {
		this.cpuDown = cpuDown;
	}
	public int getMemoryDown() {
		return memoryDown;
	}
	public void setMemoryDown(int memoryDown) {
		this.memoryDown = memoryDown;
	}
	public int getMinVM() {
		return minVM;
	}
	public void setMinVM(int minVM) {
		this.minVM = minVM;
	}
	public int getMaxVM() {
		return maxVM;
	}
	public void setMaxVM(int maxVM) {
		this.maxVM = maxVM;
	}
	public String getNaming() {
		return naming;
	}
	public void setNaming(String naming) {
		this.naming = naming;
	}
	public String getPostfix() {
		return postfix;
	}
	public void setPostfix(String postfix) {
		this.postfix = postfix;
	}
	public String getStartIP() {
		return startIP;
	}
	public void setStartIP(String startIP) {
		this.startIP = startIP;
	}
	public String getEndIP() {
		return endIP;
	}
	public void setEndIP(String endIP) {
		this.endIP = endIP;
	}
	public int getIsUse() {
		return isUse;
	}
	public void setIsUse(int isUse) {
		this.isUse = isUse;
	}
	public String getTemplate_id() {
		return template_id;
	}
	public void setTemplate_id(String template_id) {
		this.template_id = template_id;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "AutoScale [id=" + id + ", service_id=" + service_id + ", tenants_id=" + tenants_id + ", cpuUp=" + cpuUp
				+ ", memoryUp=" + memoryUp + ", cpuDown=" + cpuDown + ", memoryDown=" + memoryDown + ", minVM=" + minVM
				+ ", maxVM=" + maxVM + ", naming=" + naming + ", postfix=" + postfix + ", startIP=" + startIP
				+ ", endIP=" + endIP + ", isUse=" + isUse + ", template_id=" + template_id + ", status=" + status
				+ ", next_vm=" + next_vm + ", serviceName=" + serviceName + ", vmName=" + vmName + ", service_ids="
				+ service_ids + ", template_ids=" + template_ids + "]";
	}
	
	
	
}
