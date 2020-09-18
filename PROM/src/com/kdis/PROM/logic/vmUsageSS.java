package com.kdis.PROM.logic;

public class vmUsageSS {
	
	private String parentTitle;
	private String childeTitle;
	
	private String category;
	private String clusterName;
	private String hostName;
	private String vmName;
	private Double cpu;
	private Double memory;
	private Double network;
	private Double disk;
	private String date;
	
	
	public String getParentTitle() {
		return parentTitle;
	}
	public void setParentTitle(String parentTitle) {
		this.parentTitle = parentTitle;
	}
	public String getChildeTitle() {
		return childeTitle;
	}
	public void setChildeTitle(String childeTitle) {
		this.childeTitle = childeTitle;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getClusterName() {
		return clusterName;
	}
	public void setClusterName(String clusterName) {
		this.clusterName = clusterName;
	}
	public String getHostName() {
		return hostName;
	}
	public void setHostName(String hostName) {
		this.hostName = hostName;
	}
	public String getVmName() {
		return vmName;
	}
	public void setVmName(String vmName) {
		this.vmName = vmName;
	}
	public Double getCpu() {
		return cpu;
	}
	public void setCpu(Double cpu) {
		this.cpu = cpu;
	}
	public Double getMemory() {
		return memory;
	}
	public void setMemory(Double memory) {
		this.memory = memory;
	}
	public Double getNetwork() {
		return network;
	}
	public void setNetwork(Double network) {
		this.network = network;
	}
	public Double getDisk() {
		return disk;
	}
	public void setDisk(Double disk) {
		this.disk = disk;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	@Override
	public String toString() {
		return "vmUsageSS [parentTitle=" + parentTitle + ", childeTitle=" + childeTitle + ", category=" + category
				+ ", clusterName=" + clusterName + ", hostName=" + hostName + ", vmName=" + vmName + ", cpu=" + cpu
				+ ", memory=" + memory + ", network=" + network + ", disk=" + disk + ", date=" + date + "]";
	}
	
}
