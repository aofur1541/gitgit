package com.kdis.PROM.tenant.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * VM 호스트 VO class
 * 
 * @author KimHahn
 *
 */
public class VMHostVO {

	/** 호스트 ID */
	private String vmHID;
	
	/** 호스트 이름 */
	private String vmHhostname;
	
	/** 호스트 CPU */
	private int vmHcpu;
	
	/** 호스트 메모리  */
	private int vmHmemory;
	
	/** 호스트 버전  */
	private String vmHverBu;
	
	/** 가상머신 벤더사  */
	private String vmHvendor;
	
	/** 호스트 모델  */
	private String hostModel;
	
	/** 가상머신 아이피  */
	private String vmHIP;
	
	/** 가상머신 개수  */
	private int vmHvmCount;
	
	/** 서버연결 여부  */
	private String vmHpower;
	
	/** 호스트 가동일  */
	private int vmHuptime;
	
	/** 부모 호스트ID  */
	private String hostParent;
	
	/** 호스트 CPU 모델  */
	private String hostCpuModel;
	
	/** 호스트 스레드 수 */
	private int hostThread;
	
	/** 호스트 CPU 합계 */
	private int sumCPU;
	
	/** 호스트 메모리 합계 */
	private int sumMemory;
	
	/** 클러스터 아이디 */
	private String clusterId;

	/**
	 * @return the vmHID
	 */
	public String getVmHID() {
		return vmHID;
	}

	/**
	 * @param vmHID the vmHID to set
	 */
	public void setVmHID(String vmHID) {
		this.vmHID = vmHID;
	}

	/**
	 * @return the vmHhostname
	 */
	public String getVmHhostname() {
		return vmHhostname;
	}

	/**
	 * @param vmHhostname the vmHhostname to set
	 */
	public void setVmHhostname(String vmHhostname) {
		this.vmHhostname = vmHhostname;
	}

	/**
	 * @return the vmHcpu
	 */
	public int getVmHcpu() {
		return vmHcpu;
	}

	/**
	 * @param vmHcpu the vmHcpu to set
	 */
	public void setVmHcpu(int vmHcpu) {
		this.vmHcpu = vmHcpu;
	}

	/**
	 * @return the vmHmemory
	 */
	public int getVmHmemory() {
		return vmHmemory;
	}

	/**
	 * @param vmHmemory the vmHmemory to set
	 */
	public void setVmHmemory(int vmHmemory) {
		this.vmHmemory = vmHmemory;
	}

	/**
	 * @return the vmHverBu
	 */
	public String getVmHverBu() {
		return vmHverBu;
	}

	/**
	 * @param vmHverBu the vmHverBu to set
	 */
	public void setVmHverBu(String vmHverBu) {
		this.vmHverBu = vmHverBu;
	}

	/**
	 * @return the vmHvendor
	 */
	public String getVmHvendor() {
		return vmHvendor;
	}

	/**
	 * @param vmHvendor the vmHvendor to set
	 */
	public void setVmHvendor(String vmHvendor) {
		this.vmHvendor = vmHvendor;
	}

	/**
	 * @return the hostModel
	 */
	public String getHostModel() {
		return hostModel;
	}

	/**
	 * @param hostModel the hostModel to set
	 */
	public void setHostModel(String hostModel) {
		this.hostModel = hostModel;
	}

	/**
	 * @return the vmHIP
	 */
	public String getVmHIP() {
		return vmHIP;
	}

	/**
	 * @param vmHIP the vmHIP to set
	 */
	public void setVmHIP(String vmHIP) {
		this.vmHIP = vmHIP;
	}

	/**
	 * @return the vmHvmCount
	 */
	public int getVmHvmCount() {
		return vmHvmCount;
	}

	/**
	 * @param vmHvmCount the vmHvmCount to set
	 */
	public void setVmHvmCount(int vmHvmCount) {
		this.vmHvmCount = vmHvmCount;
	}

	/**
	 * @return the vmHpower
	 */
	public String getVmHpower() {
		return vmHpower;
	}

	/**
	 * @param vmHpower the vmHpower to set
	 */
	public void setVmHpower(String vmHpower) {
		this.vmHpower = vmHpower;
	}

	/**
	 * @return the vmHuptime
	 */
	public int getVmHuptime() {
		return vmHuptime;
	}

	/**
	 * @param vmHuptime the vmHuptime to set
	 */
	public void setVmHuptime(int vmHuptime) {
		this.vmHuptime = vmHuptime;
	}

	/**
	 * @return the hostParent
	 */
	public String getHostParent() {
		return hostParent;
	}

	/**
	 * @param hostParent the hostParent to set
	 */
	public void setHostParent(String hostParent) {
		this.hostParent = hostParent;
	}

	/**
	 * @return the hostCpuModel
	 */
	public String getHostCpuModel() {
		return hostCpuModel;
	}

	/**
	 * @param hostCpuModel the hostCpuModel to set
	 */
	public void setHostCpuModel(String hostCpuModel) {
		this.hostCpuModel = hostCpuModel;
	}

	/**
	 * @return the hostThread
	 */
	public int getHostThread() {
		return hostThread;
	}

	/**
	 * @param hostThread the hostThread to set
	 */
	public void setHostThread(int hostThread) {
		this.hostThread = hostThread;
	}

	/**
	 * @return the sumCPU
	 */
	public int getSumCPU() {
		return sumCPU;
	}

	/**
	 * @param sumCPU the sumCPU to set
	 */
	public void setSumCPU(int sumCPU) {
		this.sumCPU = sumCPU;
	}

	/**
	 * @return the sumMemory
	 */
	public int getSumMemory() {
		return sumMemory;
	}

	/**
	 * @param sumMemory the sumMemory to set
	 */
	public void setSumMemory(int sumMemory) {
		this.sumMemory = sumMemory;
	}

	/**
	 * @return the clusterId
	 */
	public String getClusterId() {
		return clusterId;
	}

	/**
	 * @param clusterId the clusterId to set
	 */
	public void setClusterId(String clusterId) {
		this.clusterId = clusterId;
	}

	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
