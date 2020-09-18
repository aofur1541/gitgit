package com.kdis.PROM.logic;

public class HostNetwork {

	private String hostID;
	private String netWorkID;
	private String netWorkName;
	
	public String getHostID() {
		return hostID;
	}
	public void setHostID(String hostID) {
		this.hostID = hostID;
	}
	public String getNetWorkID() {
		return netWorkID;
	}
	public void setNetWorkID(String netWorkID) {
		this.netWorkID = netWorkID;
	}
	public String getNetWorkName() {
		return netWorkName;
	}
	public void setNetWorkName(String netWorkName) {
		this.netWorkName = netWorkName;
	}
	
	@Override
	public String toString() {
		return "HostNetwork [hostID=" + hostID + ", netWorkID=" + netWorkID + ", netWorkName=" + netWorkName + "]";
	}

	
	
}
