package com.kdis.PROM.logic;

public class VmRealTimeUseData {
	
	private String vmID;
	private String vmName;
	private String cpuUseRT;
	private String memoryUseRT;
	private String dataUseTime;
	
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
	public String getCpuUseRT() {
		return cpuUseRT;
	}
	public void setCpuUseRT(String cpuUseRT) {
		this.cpuUseRT = cpuUseRT;
	}
	public String getMemoryUseRT() {
		return memoryUseRT;
	}
	public void setMemoryUseRT(String memoryUseRT) {
		this.memoryUseRT = memoryUseRT;
	}
	public String getDataUseTime() {
		return dataUseTime;
	}
	public void setDataUseTime(String dataUseTime) {
		this.dataUseTime = dataUseTime;
	}
	
	@Override
	public String toString() {
		return "VmRealTimeUseData [vmID=" + vmID + ", vmName=" + vmName + ", cpuUseRT=" + cpuUseRT + ", memoryUseRT="
				+ memoryUseRT + ", dataUseTime=" + dataUseTime + "]";
	} 

}
