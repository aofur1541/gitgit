package com.kdis.PROM.logic;

public class Manualscale {

	private int id;
	private int tenants_id;
	private int service_id;
	private String service_ids;
	private String naming;
	private String postfix;
	private String startIP;
	private String endIP;
	private String template_id;
	private String template_ids;
	private int status;
	private String next_vm;
	
	private String clusterID;
	private String default_storage;
	private String default_network;
	private String default_netmask;
	private String default_gateway;
	
	private String manualVMName;
	private String manualIP;
	private String manualHost;
	private String manualStorage;
	private String manualNetwork;
	
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
	public String getManualStorage() {
		return manualStorage;
	}
	public void setManualStorage(String manualStorage) {
		this.manualStorage = manualStorage;
	}
	public String getManualNetwork() {
		return manualNetwork;
	}
	public void setManualNetwork(String manualNetwork) {
		this.manualNetwork = manualNetwork;
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
	public String getManualVMName() {
		return manualVMName;
	}
	public void setManualVMName(String manualVMName) {
		this.manualVMName = manualVMName;
	}
	public String getManualHost() {
		return manualHost;
	}
	public void setManualHost(String manualHost) {
		this.manualHost = manualHost;
	}
	public String getManualIP() {
		return manualIP;
	}
	public void setManualIP(String manualIP) {
		this.manualIP = manualIP;
	}
	public String getClusterID() {
		return clusterID;
	}
	public void setClusterID(String clusterID) {
		this.clusterID = clusterID;
	}
	public int getTenants_id() {
		return tenants_id;
	}
	public void setTenants_id(int tenants_id) {
		this.tenants_id = tenants_id;
	}
	public String getTemplate_ids() {
		return template_ids;
	}
	public void setTemplate_ids(String template_ids) {
		this.template_ids = template_ids;
	}
	public String getService_ids() {
		return service_ids;
	}
	public void setService_ids(String service_ids) {
		this.service_ids = service_ids;
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
	public String getNext_vm() {
		return next_vm;
	}
	public void setNext_vm(String next_vm) {
		this.next_vm = next_vm;
	}
	
	@Override
	public String toString() {
		return "Manualscale [id=" + id + ", tenants_id=" + tenants_id + ", service_id=" + service_id + ", service_ids=" + service_ids + ", naming=" + naming + ", postfix=" + postfix + ", startIP=" + startIP + ", endIP=" + endIP
				+ ", template_id=" + template_id + ", template_ids=" + template_ids + ", status=" + status + ", next_vm=" + next_vm + ", clusterID=" + clusterID + ", default_storage=" + default_storage + ", default_network="
				+ default_network + ", default_netmask=" + default_netmask + ", default_gateway=" + default_gateway + ", manualVMName=" + manualVMName + ", manualIP=" + manualIP + ", manualHost=" + manualHost + ", manualStorage="
				+ manualStorage + ", manualNetwork=" + manualNetwork + "]";
	}

	
	
}
