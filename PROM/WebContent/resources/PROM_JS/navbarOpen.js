$(document).ready(function() {
	var nowURL = window.location.pathname;

	//세부 메뉴
	var report = "/menu/report.do";
	var statisticsManagement = "/menu/statisticsManagement.do";
	var chargebacks = "/menu/Chargebacks.do";

	var connectHistory = "/menu/connectHistory.do";
	var workHistory = "/menu/workHistory.do";
	var vmHistory = "/menu/vmHistory.do";

	//단일 메뉴
	var mainboard = "/menu/mainboard.do";
	var dashboard = "/menu/dashboard.do";
	var userDashboard = "/menu/userDashboard.do";
	
	var inventoryManage = "/menu/vmManagement.do";
	var inventoryStatus = "/menu/inventoryStatus.do";
	var approvalManage = "/menu/approvalManage.do";
	var monitoring = "/menu/monitoring.do";
	
	var userHistory = "/user/userHistory.do";
	
	var preferences = "/menu/Preferences.do";
	var autoScaleSetting = "/menu/autoScaleSetting.do";
	var userSetting = "/menu/userSetting.do";
	var tenantSetting = "/menu/tenantSetting.do";
	var totalconfiguration = "/menu/totalconfiguration.do";

	//세부 메뉴
	if (nowURL == report) {
		$("#statisticalReports").addClass("nav-item-expanded nav-item-open");
		$("#statisticalReports ul li:nth-child(1) a").addClass("active");
	} else if (nowURL == statisticsManagement) {
		$("#statisticalReports").addClass("nav-item-expanded nav-item-open");
		$("#statisticalReports ul li:nth-child(2) a").addClass("active");
	} else if (nowURL == chargebacks) {
		$("#statisticalReports").addClass("nav-item-expanded nav-item-open");
		$("#statisticalReports ul li:nth-child(3) a").addClass("active");

	} else if (nowURL == connectHistory) {
		$("#auditHistory").addClass("nav-item-expanded nav-item-open");
		$("#auditHistory ul li:nth-child(1) a").addClass("active");
	} else if (nowURL == workHistory) {
		$("#auditHistory").addClass("nav-item-expanded nav-item-open");
		$("#auditHistory ul li:nth-child(2) a").addClass("active");
	} else if (nowURL == vmHistory) {
		$("#auditHistory").addClass("nav-item-expanded nav-item-open");
		$("#auditHistory ul li:nth-child(3) a").addClass("active");

	//단일 메뉴
	} else if (nowURL == mainboard) {
		$("#dashboard a").addClass("active");
	} else if (nowURL == dashboard) {
		$("#dashboard a").addClass("active");
	} else if (nowURL == userDashboard) {
		$("#dashboard a ").addClass("active");

	} else if (nowURL == inventoryManage) {
		$("#inventoryManage a").addClass("active");
	} else if (nowURL == inventoryStatus) {
		$("#inventoryStatus a").addClass("active");
	} else if (nowURL == approvalManage) {
		$("#approvalManage a").addClass("active");
	} else if (nowURL == monitoring) {
		$("#monitoring a").addClass("active");

	} else if (nowURL == userHistory) {
		$("#userAuditHistory a").addClass("active");

	} else if (nowURL == preferences) {
		$("#preferences a").addClass("active");
	} else if (nowURL == autoScaleSetting) {
		$("#autoScaleSetting a").addClass("active");
	} else if (nowURL == userSetting) {
		$("#userSetting a").addClass("active");
	} else if (nowURL == tenantSetting) {
		$("#tenantSetting a").addClass("active");
	} else if (nowURL == totalconfiguration) {
		$("#helpDesk a").addClass("active");
	}
});