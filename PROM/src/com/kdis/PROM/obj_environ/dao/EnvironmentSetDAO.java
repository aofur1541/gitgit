package com.kdis.PROM.obj_environ.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kdis.PROM.logic.AutoScale;
import com.kdis.PROM.logic.AutoScaleUp;
import com.kdis.PROM.logic.Manualscale;
import com.kdis.PROM.logic.Vm_data_info;
import com.kdis.PROM.logic.Vm_host_info;

@Repository
public class EnvironmentSetDAO {

	@Autowired
	private SqlSession sqlSession;

	public List<AutoScaleUp> getAutoScaleUpList() {
		return sqlSession.selectList("getAutoScaleUpList");
	}
	
	public List<AutoScaleUp> getAutoScaleUpList(int numParameter, String col) {
		Map<String,Object> map = new HashMap<String,Object>();
		if(col.equals("service_id")) { map.put("service_id", numParameter); }
		if(col.equals("id")) { map.put("id", numParameter); }
		if(col.equals("isUse")) { map.put("isUse", numParameter); }
		
		return sqlSession.selectList("getAutoScaleUpList", map);
	}
	
	public List<Vm_data_info> getVMsInService(int service_id) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("service_id", service_id);
		return sqlSession.selectList("getVMsInService",map);
	}
	
	public List<Vm_data_info> getVMsInService(int service_id, String startIP, String endIP) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("service_id", service_id);
		map.put("startIP", startIP);
		map.put("endIP", endIP);
		return sqlSession.selectList("getVMsInService",map);
	}
	
	public List<Manualscale> getManualScaleOutList() {
		return sqlSession.selectList("getManualScaleOutList");
	}
	
	public List<Manualscale> getManualScaleOutList(int numParameter, String col) {
		Map<String,Object> map = new HashMap<String,Object>();
		if(col.equals("id")) { map.put("id", numParameter); }
		return sqlSession.selectList("getManualScaleOutList",map);
	}
	
	public List<Vm_host_info> getLowestHostsInCluster(String clusterId) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("clusterId", clusterId);
		return sqlSession.selectList("getLowestHostsInCluster", map);
	}
	
	public List<Vm_host_info> getLowestHostsInCluster(int limitActive) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("limitActive", limitActive);
		return sqlSession.selectList("getLowestHostsInCluster", map);
	}
	
	public List<Vm_host_info> getPartCheckOfHost(String default_storage, String default_network) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("default_storage", default_storage);
		map.put("default_network", default_network);
		return sqlSession.selectList("getPartCheckOfHost",map);
	}

	public int setAutoScaleUp(AutoScaleUp autoScaleUp) {
		return sqlSession.insert("setAutoScaleUp",autoScaleUp);
	}

	public int upAutoScaleUpInfo(AutoScaleUp autoScaleUp) {
		return sqlSession.update("upAutoScaleUpInfo",autoScaleUp);
	}

	public int deleteAutoScaleUpInfo(AutoScaleUp autoScaleUp) {
		return sqlSession.delete("deleteAutoScaleUpInfo",autoScaleUp);
	}

	public int setManualScaleOutInfo(Manualscale manualscale) {
		return sqlSession.insert("setManualScaleOutInfo",manualscale);
	}
	
	public int upManualScaleOutInfo(Manualscale manualscale) {
		return sqlSession.update("upManualScaleOutInfo",manualscale);
	}
	
	public int deleteManualScaleOutInfo(Manualscale manualscale) {
		return sqlSession.delete("deleteManualScaleOutInfo",manualscale);
	}
	
	public void upAutoScaleStatus(int id, int waiting, int status) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("waiting", waiting);
		map.put("status", status);
		sqlSession.update("upAutoScaleStatus",map);
	}

	public void manualScaleOutPreVMUpdate(int id, String vm_name, int nPostfix) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("vm_name", vm_name);
		map.put("nPostfix", nPostfix);
		sqlSession.update("manualScaleOutPreVMUpdate",map);
		
	}

	

	



	


}
