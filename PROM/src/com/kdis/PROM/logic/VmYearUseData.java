package com.kdis.PROM.logic;

public class VmYearUseData {

	private String vmID;
	private String vmName;
	private String cpuUse;
	private String memoryUse;
	private int dateCategory;
	private String dataUseTime;
	
	public int getDateCategory() {
		return dateCategory;
	}
	public void setDateCategory(int dateCategory) {
		this.dateCategory = dateCategory;
	}
	public String getVmID() {
		return vmID;
	}
	public void setVmID(String vmID) {
		this.vmID = vmID;
	}
	public String getVmName() {
		return vmName;
	}
	public void setVmName(String vmName) {
		this.vmName = vmName;
	}
	public String getCpuUse() {
		return cpuUse;
	}
	public void setCpuUse(String cpuUse) {
		this.cpuUse = cpuUse;
	}
	public String getMemoryUse() {
		return memoryUse;
	}
	public void setMemoryUse(String memoryUse) {
		this.memoryUse = memoryUse;
	}
	public String getDataUseTime() {
		return dataUseTime;
	}
	public void setDataUseTime(String dataUseTime) {
		this.dataUseTime = dataUseTime;
	}
	
	@Override
	public String toString() {
		return "VmYearUseData [vmID=" + vmID + ", vmName=" + vmName + ", cpuUse=" + cpuUse + ", memoryUse=" + memoryUse
				+ ", dateCategory=" + dateCategory + ", dataUseTime=" + dataUseTime + "]";
	}
	
	
	
}
