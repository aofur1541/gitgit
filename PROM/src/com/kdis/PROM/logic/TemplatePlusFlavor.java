package com.kdis.PROM.logic;

public class TemplatePlusFlavor {

	private String templateID;
	private String templateName;
	private String templateDescription;
	private String flavorID;
	private String flavorName;
	private int flavorvCPU;
	private int flavorMemory;
	private int flavorDisk;
	
	public String getTemplateID() {
		return templateID;
	}
	public void setTemplateID(String templateID) {
		this.templateID = templateID;
	}
	public String getTemplateName() {
		return templateName;
	}
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	public String getTemplateDescription() {
		return templateDescription;
	}
	public void setTemplateDescription(String templateDescription) {
		this.templateDescription = templateDescription;
	}
	public String getFlavorID() {
		return flavorID;
	}
	public void setFlavorID(String flavorID) {
		this.flavorID = flavorID;
	}
	public String getFlavorName() {
		return flavorName;
	}
	public void setFlavorName(String flavorName) {
		this.flavorName = flavorName;
	}
	public int getFlavorvCPU() {
		return flavorvCPU;
	}
	public void setFlavorvCPU(int flavorvCPU) {
		this.flavorvCPU = flavorvCPU;
	}
	public int getFlavorMemory() {
		return flavorMemory;
	}
	public void setFlavorMemory(int flavorMemory) {
		this.flavorMemory = flavorMemory;
	}
	public int getFlavorDisk() {
		return flavorDisk;
	}
	public void setFlavorDisk(int flavorDisk) {
		this.flavorDisk = flavorDisk;
	}
	
	@Override
	public String toString() {
		return "TemplatePlusFlavor [templateID=" + templateID + ", templateName=" + templateName
				+ ", templateDescription=" + templateDescription + ", flavorID=" + flavorID + ", flavorName="
				+ flavorName + ", flavorvCPU=" + flavorvCPU + ", flavorMemory=" + flavorMemory + ", flavorDisk="
				+ flavorDisk + "]";
	}
	
	
	
	
	
}
