package com.kdis.PROM.logic;

public class Vm_service_graph {

	private int nGraphNumber;
	private int nServiceCount;
	private int nVMCount;
	private int nFreeVMCount;
	private String dServiceDatetime;
	
	public int getnVMCount() {
		return nVMCount;
	}
	public void setnVMCount(int nVMCount) {
		this.nVMCount = nVMCount;
	}
	public int getnFreeVMCount() {
		return nFreeVMCount;
	}
	public void setnFreeVMCount(int nFreeVMCount) {
		this.nFreeVMCount = nFreeVMCount;
	}
	public int getnGraphNumber() {
		return nGraphNumber;
	}
	public void setnGraphNumber(int nGraphNumber) {
		this.nGraphNumber = nGraphNumber;
	}
	public int getnServiceCount() {
		return nServiceCount;
	}
	public void setnServiceCount(int nServiceCount) {
		this.nServiceCount = nServiceCount;
	}
	public String getdServiceDatetime() {
		return dServiceDatetime;
	}
	public void setdServiceDatetime(String dServiceDatetime) {
		this.dServiceDatetime = dServiceDatetime;
	}
	
	@Override
	public String toString() {
		return "Vm_service_graph [nGraphNumber=" + nGraphNumber + ", nServiceCount=" + nServiceCount + ", nVMCount="
				+ nVMCount + ", nFreeVMCount=" + nFreeVMCount + ", dServiceDatetime=" + dServiceDatetime + "]";
	}
	
	
	
}
