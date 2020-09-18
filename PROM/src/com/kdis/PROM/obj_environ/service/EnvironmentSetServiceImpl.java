package com.kdis.PROM.obj_environ.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kdis.PROM.logic.AutoScaleUp;
import com.kdis.PROM.logic.Manualscale;
import com.kdis.PROM.logic.Vm_data_info;
import com.kdis.PROM.logic.Vm_host_info;
import com.kdis.PROM.obj_environ.dao.EnvironmentSetDAO;

@Service
public class EnvironmentSetServiceImpl implements EnvironmentSetService {

	@Autowired
	EnvironmentSetDAO environmentSetDAO;

	@Override
	public List<AutoScaleUp> getAutoScaleUpList() {
		return environmentSetDAO.getAutoScaleUpList();
	}
	
	@Override
	public List<AutoScaleUp> getAutoScaleUpList(int service_id, String col) {
		return environmentSetDAO.getAutoScaleUpList(service_id,col);
	}

	@Override
	public List<Vm_data_info> getVMsInService(int service_id) {
		return environmentSetDAO.getVMsInService(service_id);
	}
	
	@Override
	public List<Vm_data_info> getVMsInService(int service_id, String startIP, String endIP) {
		return environmentSetDAO.getVMsInService(service_id,startIP,endIP);
	}
	
	@Override
	public List<Manualscale> getManualScaleOutList() {
		return environmentSetDAO.getManualScaleOutList();
	}
	
	@Override
	public List<Manualscale> getManualScaleOutList(int id, String col) {
		return environmentSetDAO.getManualScaleOutList(id,col);
	}
	
	@Override
	public List<Vm_host_info> getLowestHostsInCluster(String clusterId) {
		return environmentSetDAO.getLowestHostsInCluster(clusterId);
	}
	
	@Override
	public List<Vm_host_info> getLowestHostsInCluster(int limitActive) {
		return environmentSetDAO.getLowestHostsInCluster(limitActive);
	}
	
	@Override
	public List<Vm_host_info> getPartCheckOfHost(String default_storage, String default_network) {
		return environmentSetDAO.getPartCheckOfHost(default_storage,default_network);
	}
	
	@Override
	public int setAutoScaleUp(AutoScaleUp autoScaleUp) {
		return environmentSetDAO.setAutoScaleUp(autoScaleUp);
	}

	@Override
	public int upAutoScaleUpInfo(AutoScaleUp autoScaleUp) {
		return environmentSetDAO.upAutoScaleUpInfo(autoScaleUp);
	}

	@Override
	public int deleteAutoScaleUpInfo(AutoScaleUp autoScaleUp) {
		return environmentSetDAO.deleteAutoScaleUpInfo(autoScaleUp);
	}

	@Override
	public int setManualScaleOutInfo(Manualscale manualscale) {
		return environmentSetDAO.setManualScaleOutInfo(manualscale);
	}
	
	@Override
	public int upManualScaleOutInfo(Manualscale manualscale) {
		return environmentSetDAO.upManualScaleOutInfo(manualscale);
	}
	
	@Override
	public int deleteManualScaleOutInfo(Manualscale manualscale) {
		return environmentSetDAO.deleteManualScaleOutInfo(manualscale);
	}
	
	@Override
	public void upAutoScaleStatus(int id, int waiting, int status) {
		environmentSetDAO.upAutoScaleStatus(id,waiting,status);
	}

	@Override
	public void manualScaleOutPreVMUpdate(int id, String vm_name, int nPostfix) {
		environmentSetDAO.manualScaleOutPreVMUpdate(id,vm_name,nPostfix);
	}

	

	

	




}
