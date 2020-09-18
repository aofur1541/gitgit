package com.kdis.PROM.obj_common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kdis.PROM.logic.HostDataStore;
import com.kdis.PROM.logic.HostNetwork;
import com.kdis.PROM.logic.Vm_data_info;
import com.kdis.PROM.logic.Vm_host_info;
import com.kdis.PROM.obj_common.dao.CommonDAO;

@Service
public class CommonServiceImpl implements CommonService {

	@Autowired
	CommonDAO commonDAO;
	
	@Override
	public List<Vm_host_info> getHostsInCluster(String clusterID) {
		return commonDAO.getHostsInCluster(clusterID);
	}

	@Override
	public List<HostDataStore> getDataStoresInHost(String hostId) {
		return commonDAO.getDataStoresInHost(hostId);
	}
	
	@Override
	public List<HostNetwork> getNetworksInHost(String hostId) {
		return commonDAO.getNetworksInHost(hostId);
	}
	
	@Override
	public List<Vm_data_info> getOneVMInfo(String vm_ID) {
		return commonDAO.getOneVMInfo(vm_ID);
	}
	
	@Override
	public Vm_host_info getHostInfoByName(String hostName) {
		return commonDAO.getHostInfoByName(hostName);
	}

}
