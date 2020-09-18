package com.kdis.PROM.logic;

public class HostDataStore {

	private String hostID;
	private String dataStoreID;
	private String dataStoreName;
	private int st_Allca;
	private int st_Useca;
	private int st_space;
	
	public int getSt_Allca() {
		return st_Allca;
	}
	public void setSt_Allca(int st_Allca) {
		this.st_Allca = st_Allca;
	}
	public int getSt_Useca() {
		return st_Useca;
	}
	public void setSt_Useca(int st_Useca) {
		this.st_Useca = st_Useca;
	}
	public int getSt_space() {
		return st_space;
	}
	public void setSt_space(int st_space) {
		this.st_space = st_space;
	}
	public String getHostID() {
		return hostID;
	}
	public void setHostID(String hostID) {
		this.hostID = hostID;
	}
	public String getDataStoreID() {
		return dataStoreID;
	}
	public void setDataStoreID(String dataStoreID) {
		this.dataStoreID = dataStoreID;
	}
	public String getDataStoreName() {
		return dataStoreName;
	}
	public void setDataStoreName(String dataStoreName) {
		this.dataStoreName = dataStoreName;
	}
	
	@Override
	public String toString() {
		return "HostDataStore [hostID=" + hostID + ", dataStoreID=" + dataStoreID + ", dataStoreName=" + dataStoreName
				+ ", st_Allca=" + st_Allca + ", st_Useca=" + st_Useca + ", st_space=" + st_space + "]";
	}
	
	
}
