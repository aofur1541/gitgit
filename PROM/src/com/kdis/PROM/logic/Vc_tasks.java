package com.kdis.PROM.logic;

public class Vc_tasks {

	private String dTask_startTime;
	private String dTask_completeTime;
	private String sTask_entityName;
	private String sTask_descriptionId;
	private String sTask_changeTag;
	
	public String getdTask_startTime() {
		return dTask_startTime;
	}
	public void setdTask_startTime(String dTask_startTime) {
		this.dTask_startTime = dTask_startTime;
	}
	public String getdTask_completeTime() {
		return dTask_completeTime;
	}
	public void setdTask_completeTime(String dTask_completeTime) {
		this.dTask_completeTime = dTask_completeTime;
	}
	public String getsTask_entityName() {
		return sTask_entityName;
	}
	public void setsTask_entityName(String sTask_entityName) {
		this.sTask_entityName = sTask_entityName;
	}
	public String getsTask_descriptionId() {
		return sTask_descriptionId;
	}
	public void setsTask_descriptionId(String sTask_descriptionId) {
		this.sTask_descriptionId = sTask_descriptionId;
	}
	public String getsTask_changeTag() {
		return sTask_changeTag;
	}
	public void setsTask_changeTag(String sTask_changeTag) {
		this.sTask_changeTag = sTask_changeTag;
	}
	
	@Override
	public String toString() {
		return "Vc_tasks [dTask_startTime=" + dTask_startTime + ", dTask_completeTime=" + dTask_completeTime
				+ ", sTask_entityName=" + sTask_entityName + ", sTask_descriptionId=" + sTask_descriptionId
				+ ", sTask_changeTag=" + sTask_changeTag + "]";
	}
}
