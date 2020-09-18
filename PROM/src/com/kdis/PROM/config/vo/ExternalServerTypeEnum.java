package com.kdis.PROM.config.vo;

public enum ExternalServerTypeEnum {

	vCenter(1), vRealizeOrchestrator(2), vRealizeOperations(3), vRealizeAutomation(4), email(5), otpServer(6);

	private int serverType;

	ExternalServerTypeEnum(int serverType) {
		this.serverType = serverType;
	}

	public int getServerType() {
		return this.serverType;
	}

	public  static ExternalServerTypeEnum valueOfServerType(int serverType) {
	    for (ExternalServerTypeEnum e : values()) {
	        if (e.getServerType() == serverType) {
	            return e;
	        }
	    }
	    return null;
	}

}
