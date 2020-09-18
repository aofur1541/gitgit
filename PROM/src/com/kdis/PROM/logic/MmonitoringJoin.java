package com.kdis.PROM.logic;

public class MmonitoringJoin {

	private int vm_service_ID;
	private String vm_service_name;
	private String vm_name;
	private String vm_status;
	private String vm_ID;
	private int vm_cpu;
	private int vm_memory;
	private int vm_disk;
	private String vm_host;
	private String vm_DataStore;
	private String vm_vmtools_status;
	private String vm_ipaddr1;
	private String vm_ipaddr2;
	private String vm_ipaddr3;
	private String vm_templet;
	private String vm_OS;
	private String vm_datetime;
	private String name;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getVm_DataStore() {
		return vm_DataStore;
	}
	public void setVm_DataStore(String vm_DataStore) {
		this.vm_DataStore = vm_DataStore;
	}
	public int getVm_disk() {
		return vm_disk;
	}
	public void setVm_disk(int vm_disk) {
		this.vm_disk = vm_disk;
	}
	public String getVm_datetime() {
		return vm_datetime;
	}
	public void setVm_datetime(String vm_datetime) {
		this.vm_datetime = vm_datetime;
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
	public int getVm_service_ID() {
		return vm_service_ID;
	}
	public void setVm_service_ID(int vm_service_ID) {
		this.vm_service_ID = vm_service_ID;
	}
	public String getVm_name() {
		return vm_name;
	}
	public void setVm_name(String vm_name) {
		this.vm_name = vm_name;
	}
	public String getVm_status() {
		return vm_status;
	}
	public void setVm_status(String vm_status) {
		this.vm_status = vm_status;
	}
	
	@Override
	public String toString() {
		return "MmonitoringJoin [vm_service_ID=" + vm_service_ID + ", vm_service_name=" + vm_service_name + ", vm_name="
				+ vm_name + ", vm_status=" + vm_status + ", vm_ID=" + vm_ID + ", vm_cpu=" + vm_cpu + ", vm_memory="
				+ vm_memory + ", vm_host=" + vm_host + ", vm_vmtools_status=" + vm_vmtools_status + ", vm_ipaddr1="
				+ vm_ipaddr1 + ", vm_ipaddr2=" + vm_ipaddr2 + ", vm_ipaddr3=" + vm_ipaddr3 + ", vm_templet="
				+ vm_templet + ", vm_OS=" + vm_OS + ", vm_datetime=" + vm_datetime + "]";
	}
	
	
	
	
	
}
