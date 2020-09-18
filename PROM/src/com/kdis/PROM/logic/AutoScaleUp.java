package com.kdis.PROM.logic;

import java.util.Date;

public class AutoScaleUp {

	private int id;
	private int tenants_id;
	private int service_id;
	private int cpuUp;
	private int memoryUp;
	private int cpuAdd;
	private int memoryAdd;
	private int isUse;
	private int status;
	private int waiting;
	private Date updated_on;
	
	private String service_ids;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getTenants_id() {
		return tenants_id;
	}

	public void setTenants_id(int tenants_id) {
		this.tenants_id = tenants_id;
	}

	public int getService_id() {
		return service_id;
	}

	public void setService_id(int service_id) {
		this.service_id = service_id;
	}

	public int getCpuUp() {
		return cpuUp;
	}

	public void setCpuUp(int cpuUp) {
		this.cpuUp = cpuUp;
	}

	public int getMemoryUp() {
		return memoryUp;
	}

	public void setMemoryUp(int memoryUp) {
		this.memoryUp = memoryUp;
	}

	public int getCpuAdd() {
		return cpuAdd;
	}

	public void setCpuAdd(int cpuAdd) {
		this.cpuAdd = cpuAdd;
	}

	public int getMemoryAdd() {
		return memoryAdd;
	}

	public void setMemoryAdd(int memoryAdd) {
		this.memoryAdd = memoryAdd;
	}

	public int getIsUse() {
		return isUse;
	}

	public void setIsUse(int isUse) {
		this.isUse = isUse;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getWaiting() {
		return waiting;
	}

	public void setWaiting(int waiting) {
		this.waiting = waiting;
	}

	public Date getUpdated_on() {
		return updated_on;
	}

	public void setUpdated_on(Date updated_on) {
		this.updated_on = updated_on;
	}

	public String getService_ids() {
		return service_ids;
	}

	public void setService_ids(String service_ids) {
		this.service_ids = service_ids;
	}

	@Override
	public String toString() {
		return "AutoScaleUp [id=" + id + ", tenants_id=" + tenants_id + ", service_id=" + service_id + ", cpuUp=" + cpuUp + ", memoryUp=" + memoryUp + ", cpuAdd=" + cpuAdd + ", memoryAdd=" + memoryAdd + ", isUse=" + isUse + ", status="
				+ status + ", waiting=" + waiting + ", updated_on=" + updated_on + ", service_ids=" + service_ids + "]";
	}
	
	
	
}
