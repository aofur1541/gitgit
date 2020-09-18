package com.kdis.PROM.obj_common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kdis.PROM.logic.HostDataStore;
import com.kdis.PROM.logic.HostNetwork;
import com.kdis.PROM.logic.Vm_data_info;
import com.kdis.PROM.logic.Vm_host_info;

@Repository
public class CommonDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public List<Vm_host_info> getHostsInCluster(String clusterID) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("clusterID", clusterID);
		return sqlSession.selectList("getHostsInCluster", map);
	}

	public List<HostDataStore> getDataStoresInHost(String hostId) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("hostId", hostId);
		return sqlSession.selectList("getDataStoresInHost", map);
	}
	
	public List<HostNetwork> getNetworksInHost(String hostId) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("hostId", hostId);
		return sqlSession.selectList("getNetworksInHost", map);
	}
	
	public List<Vm_data_info> getOneVMInfo(String vm_ID) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("vm_ID", vm_ID);
		return sqlSession.selectList("getOneVMInfo", map);
	}
	
	public Vm_host_info getHostInfoByName(String hostName) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("hostName", hostName);
		return sqlSession.selectOne("getHostInfo", map);
	}




}
