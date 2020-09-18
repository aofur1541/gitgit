package com.kdis.PROM.logic;

public class Vm_service {

	private Integer vm_service_ID;
	private String vm_service_name;
	private Integer vm_service_sUserID;
	private String vm_service_sUserName;
	private String vm_service_datetime;
	private Integer vm_service_INVM;
	private String nEp_num;
	private String description;
	private Integer tenants_id;
	private String tenants_ids;
	private String default_cluster;
	private String default_host;
	private String default_storage;
	private String default_storageName;
	private String default_network;
	private String default_networkName;
	private Integer dhcp_onoff;
	private String created_on;
	private String updated_on;
	
	private String default_netmask;
	private String default_gateway;
	private int countVM;
	
	
	public int getCountVM() {
		return countVM;
	}
	public void setCountVM(int countVM) {
		this.countVM = countVM;
	}
	public String getDefault_netmask() {
		return default_netmask;
	}
	public void setDefault_netmask(String default_netmask) {
		this.default_netmask = default_netmask;
	}
	public String getDefault_gateway() {
		return default_gateway;
	}
	public void setDefault_gateway(String default_gateway) {
		this.default_gateway = default_gateway;
	}
	public String getDefault_storageName() {
		return default_storageName;
	}
	public void setDefault_storageName(String default_storageName) {
		this.default_storageName = default_storageName;
	}
	public String getDefault_networkName() {
		return default_networkName;
	}
	public void setDefault_networkName(String default_networkName) {
		this.default_networkName = default_networkName;
	}
	public String getVm_service_sUserName() {
		return vm_service_sUserName;
	}
	public void setVm_service_sUserName(String vm_service_sUserName) {
		this.vm_service_sUserName = vm_service_sUserName;
	}
	public String getTenants_ids() {
		return tenants_ids;
	}
	public void setTenants_ids(String tenants_ids) {
		this.tenants_ids = tenants_ids;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getTenants_id() {
		return tenants_id;
	}
	public void setTenants_id(Integer tenants_id) {
		this.tenants_id = tenants_id;
	}
	public String getDefault_cluster() {
		return default_cluster;
	}
	public void setDefault_cluster(String default_cluster) {
		this.default_cluster = default_cluster;
	}
	public String getDefault_host() {
		return default_host;
	}
	public void setDefault_host(String default_host) {
		this.default_host = default_host;
	}
	public String getDefault_storage() {
		return default_storage;
	}
	public void setDefault_storage(String default_storage) {
		this.default_storage = default_storage;
	}
	public String getDefault_network() {
		return default_network;
	}
	public void setDefault_network(String default_network) {
		this.default_network = default_network;
	}
	public Integer getDhcp_onoff() {
		return dhcp_onoff;
	}
	public void setDhcp_onoff(Integer dhcp_onoff) {
		this.dhcp_onoff = dhcp_onoff;
	}
	public String getCreated_on() {
		return created_on;
	}
	public void setCreated_on(String created_on) {
		this.created_on = created_on;
	}
	public String getUpdated_on() {
		return updated_on;
	}
	public void setUpdated_on(String updated_on) {
		this.updated_on = updated_on;
	}
	public String getnEp_num() {
		return nEp_num;
	}
	public void setnEp_num(String nEp_num) {
		this.nEp_num = nEp_num;
	}
	public Integer getVm_service_INVM() {
		return vm_service_INVM;
	}
	public void setVm_service_INVM(Integer vm_service_INVM) {
		this.vm_service_INVM = vm_service_INVM;
	}
	public Integer getVm_service_sUserID() {
		return vm_service_sUserID;
	}
	public void setVm_service_sUserID(Integer vm_service_sUserID) {
		this.vm_service_sUserID = vm_service_sUserID;
	}
	public String getVm_service_datetime() {
		return vm_service_datetime;
	}
	public void setVm_service_datetime(String vm_service_datetime) {
		this.vm_service_datetime = vm_service_datetime;
	}
	public Integer getVm_service_ID() {
		return vm_service_ID;
	}
	public void setVm_service_ID(Integer vm_service_ID) {
		this.vm_service_ID = vm_service_ID;
	}
	public String getVm_service_name() {
		return vm_service_name;
	}
	public void setVm_service_name(String vm_service_name) {
		this.vm_service_name = vm_service_name;
	}
	@Override
	public String toString() {
		return "Vm_service [vm_service_ID=" + vm_service_ID + ", vm_service_name=" + vm_service_name
				+ ", vm_service_sUserID=" + vm_service_sUserID + ", vm_service_sUserName=" + vm_service_sUserName
				+ ", vm_service_datetime=" + vm_service_datetime + ", vm_service_INVM=" + vm_service_INVM + ", nEp_num="
				+ nEp_num + ", description=" + description + ", tenants_id=" + tenants_id + ", tenants_ids="
				+ tenants_ids + ", default_cluster=" + default_cluster + ", default_host=" + default_host
				+ ", default_storage=" + default_storage + ", default_storageName=" + default_storageName
				+ ", default_network=" + default_network + ", default_networkName=" + default_networkName
				+ ", dhcp_onoff=" + dhcp_onoff + ", created_on=" + created_on + ", updated_on=" + updated_on
				+ ", default_netmask=" + default_netmask + ", default_gateway=" + default_gateway + ", countVM="
				+ countVM + "]";
	}
	
	
}
