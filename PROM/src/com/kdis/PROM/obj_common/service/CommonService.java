package com.kdis.PROM.obj_common.service;

import java.util.List;

import com.kdis.PROM.logic.HostDataStore;
import com.kdis.PROM.logic.HostNetwork;
import com.kdis.PROM.logic.Vm_data_info;
import com.kdis.PROM.logic.Vm_host_info;

public interface CommonService {

	List<Vm_host_info> getHostsInCluster(String clusterID);

	List<HostDataStore> getDataStoresInHost(String hostId);
	
	List<HostNetwork> getNetworksInHost(String hostId);
	
	List<Vm_data_info> getOneVMInfo(String vm_ID);
	
	Vm_host_info getHostInfoByName(String hostName);




}
