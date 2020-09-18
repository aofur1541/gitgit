package com.kdis.PROM.obj_environ.service;

import java.util.List;

import com.kdis.PROM.logic.AutoScaleUp;
import com.kdis.PROM.logic.Manualscale;
import com.kdis.PROM.logic.Vm_data_info;
import com.kdis.PROM.logic.Vm_host_info;

public interface EnvironmentSetService {

	List<AutoScaleUp> getAutoScaleUpList();
	
	List<AutoScaleUp> getAutoScaleUpList(int service_id, String col);

	List<Vm_data_info> getVMsInService(int service_id);
	
	List<Vm_data_info> getVMsInService(int service_id, String startIP, String endIP);
	
	List<Manualscale> getManualScaleOutList();
	
	List<Manualscale> getManualScaleOutList(int id, String col);
	
	List<Vm_host_info> getLowestHostsInCluster(String clusterId);
	
	List<Vm_host_info> getLowestHostsInCluster(int limitActive);
	
	List<Vm_host_info> getPartCheckOfHost(String default_storage, String default_network);
	
	int setAutoScaleUp(AutoScaleUp autoScaleUp);

	int upAutoScaleUpInfo(AutoScaleUp autoScaleUp);

	int deleteAutoScaleUpInfo(AutoScaleUp autoScaleUp);

	int setManualScaleOutInfo(Manualscale manualscale);
	
	int upManualScaleOutInfo(Manualscale manualscale);
	
	int deleteManualScaleOutInfo(Manualscale manualscale);
	
	void upAutoScaleStatus(int id, int waiting, int status);

	void manualScaleOutPreVMUpdate(int id, String vm_name, int nPostfix);


	

	

	




	




}
