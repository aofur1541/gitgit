package com.kdis.PROM.logic;

public class SearchFilter {
	
	private String vmUsageStartDatetime;
	private String vmUsageEndDatetime;
	private String startTimeCustom;
	private String endTimeCustom;
	
	public String getVmUsageStartDatetime() {
		return vmUsageStartDatetime;
	}
	public void setVmUsageStartDatetime(String vmUsageStartDatetime) {
		this.vmUsageStartDatetime = vmUsageStartDatetime;
	}
	public String getVmUsageEndDatetime() {
		return vmUsageEndDatetime;
	}
	public void setVmUsageEndDatetime(String vmUsageEndDatetime) {
		this.vmUsageEndDatetime = vmUsageEndDatetime;
	}
	public String getStartTimeCustom() {
		return startTimeCustom;
	}
	public void setStartTimeCustom(String startTimeCustom) {
		this.startTimeCustom = startTimeCustom;
	}
	public String getEndTimeCustom() {
		return endTimeCustom;
	}
	public void setEndTimeCustom(String endTimeCustom) {
		this.endTimeCustom = endTimeCustom;
	}
	
	@Override
	public String toString() {
		return "SearchFilter [vmUsageStartDatetime=" + vmUsageStartDatetime + ", vmUsageEndDatetime="
				+ vmUsageEndDatetime + ", startTimeCustom=" + startTimeCustom + ", endTimeCustom=" + endTimeCustom
				+ "]";
	}
}
