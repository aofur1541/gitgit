package com.kdis.PROM.logic;

public class WorkflowStatus {

		private String name;
		private int state;
		private String error;
		private String operatingtime;
		
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int getState() {
			return state;
		}
		public void setState(int state) {
			this.state = state;
		}
		public String getError() {
			return error;
		}
		public void setError(String error) {
			this.error = error;
		}
		public String getOperatingtime() {
			return operatingtime;
		}
		public void setOperatingtime(String operatingtime) {
			this.operatingtime = operatingtime;
		}
		
		@Override
		public String toString() {
			return "WorkflowStatus [name=" + name + ", state=" + state + ", error=" + error + ", operatingtime="
					+ operatingtime + "]";
		}
}
