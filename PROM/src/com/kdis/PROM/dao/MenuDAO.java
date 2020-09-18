package com.kdis.PROM.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kdis.PROM.logic.AutoScale;
import com.kdis.PROM.logic.Ep_service;
import com.kdis.PROM.logic.LogConfiguration;
import com.kdis.PROM.logic.Metering;
import com.kdis.PROM.logic.MeteringSum;
import com.kdis.PROM.logic.MeteringVMs;
import com.kdis.PROM.logic.MmonitoringJoin;
import com.kdis.PROM.logic.PowerOffCheck;
import com.kdis.PROM.logic.VROConfig;
import com.kdis.PROM.logic.VmOneDetail;
import com.kdis.PROM.logic.VmYearUseData;
import com.kdis.PROM.logic.Vm_create;
import com.kdis.PROM.logic.Vm_data_info;
import com.kdis.PROM.logic.Vm_host_info;
import com.kdis.PROM.logic.Vm_service;
import com.kdis.PROM.logic.Vm_service_graph;
import com.kdis.PROM.logic.Vm_storage;
import com.kdis.PROM.logic.Vm_templet;
import com.kdis.PROM.logic.WorkflowStatus;

@Repository
public class MenuDAO {

	@Autowired
	private SqlSession sqlSession;
	private final String NS = "com.kdis.PROM.mapper.menuMapper.";

	public int maxservicenum() {
		return sqlSession.selectOne(NS+"maxnum");
	}

	public List<Vm_service> servicelist() {
		return sqlSession.selectList(NS+"servicelist");
	}

	public Vm_service getserviceSelect(String servicename) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("vm_service_name", servicename);
		return sqlSession.selectOne(NS+"getserviceOne",map);
	}

	public int host_count(int vm_service_ID) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("vm_service_ID", vm_service_ID);
		return sqlSession.selectOne(NS+"servicehostcount",map);
	}

	public int vm_count(int vm_service_ID) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("vm_service_ID", vm_service_ID);
		return sqlSession.selectOne(NS+"servicevmcount",map);
	}

	public Vm_data_info VM_Onevm_info(String vm_ID) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("vm_ID", vm_ID);
		return sqlSession.selectOne(NS+"VMOneinfo", map);
	}

	public Vm_host_info VM_Onehost_info(String vm_HID) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("vm_HID", vm_HID);
		return sqlSession.selectOne(NS+"VMHostinfo",map);
	}

	public List<Vm_host_info> host_info() {
		return sqlSession.selectList(NS+"VMHostinfo");
	}

	public List<Vm_templet> vm_templet() {
		return sqlSession.selectList(NS+"templateList");
	}

	public int vm_create(Vm_create vm_create) {
		return sqlSession.insert("VMcreate", vm_create);
	}
	
	public List<Vm_create> vm_createwaitlist() {
		return sqlSession.selectList(NS+"vmcreatewaitlist");
	}

	public List<Vm_create> notapprovalVMCR_list() {
		return sqlSession.selectList(NS+"notapprovalVMCR_list");
	}

	public List<Vm_data_info> VMAllinfolist() {
		return sqlSession.selectList(NS+"VMAllinfolist");
	}

	public Vm_data_info service_inVMdetail(String vm_ID) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("vm_ID", vm_ID);
		return sqlSession.selectOne(NS+"service_inVMdetail",map);
	}

	public void VM_service_VMcount(String vm_service_ID) {
		sqlSession.update(NS+"VMserviceVMcount", vm_service_ID);
	}

	public void VM_deportdelete(String vm_service_vm_ID) {
		sqlSession.delete(NS+"VM_deportdelete",vm_service_vm_ID);
	}

	public List<Vm_data_info> SearchVMlist(String inputed) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("inputed", inputed);
		return sqlSession.selectList(NS+"SearchVMlist", map);
	}

	public Vm_service service_detail_sename(Integer vm_service_ID) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("vm_service_ID", vm_service_ID);
		return sqlSession.selectOne(NS+"Mservice_detail_sename", map);
	}

	public int applyserviceDetail(Integer vm_service_ID) {
		return sqlSession.update(NS+"applyserviceDetail", vm_service_ID);
	}

	public Vm_create notapplyVMdetail(int cr_num) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("cr_num", cr_num);
		return sqlSession.selectOne(NS+"notapplyVMdetail", map);
	}

	public int VM_delete(int cr_num) {
		return sqlSession.delete(NS+"VMDelete", cr_num);
	}

	public List<MmonitoringJoin> service_detailInfo(String vm_service_ID) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("vm_service_ID", vm_service_ID);
		return sqlSession.selectList(NS+"service_detailInfo", map);
	}

	public List<Vm_service_graph> DashServiceGraph() {
		return sqlSession.selectList(NS+"DashServiceGraph");
	}

	public HashMap<String, Object> serviceCount() {
		return sqlSession.selectOne(NS+"serviceCount");
	}

	public int maxGraphnum() {
		return sqlSession.selectOne(NS+"maxGraphnum");
	}

	public void service_graphInsert(Vm_service_graph vm_service_graph) {
		sqlSession.insert(NS+"service_graphInsert", vm_service_graph);
	}

	public List<Vm_service> SearchServiceNotApply(String inputed) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("inputed", inputed);
		return sqlSession.selectList(NS+"SearchServiceNotApply", map);
	}

	public List<Vm_service> SearchServiceApply(String inputed) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("inputed", inputed);
		return sqlSession.selectList(NS+"SearchServiceApply", map);
		
	}

	public List<Vm_service> Authorityservice_list(String sUserID, String sEp_num) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("sUserID", sUserID);
		map.put("sEp_num", sEp_num);
		return sqlSession.selectList(NS+"Authorityservice_list",map);
	}

	public Vm_data_info NewVM_Select(String vm_service_vm_name) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("vm_service_vm_name", vm_service_vm_name);
		return sqlSession.selectOne(NS+"NewVM_Select", map);
	}

	public int ServiceINVM(String service_radio) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("vm_service_ID", service_radio);
		return sqlSession.selectOne(NS+"ServiceINVM", map);
	}

	public List<Vm_data_info> service_INVMlist(Integer vm_service_ID) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("vm_service_ID", vm_service_ID);
		return sqlSession.selectList(NS+"service_INVMlist",map);
	}

	public List<Vm_data_info> templateList() {
		return sqlSession.selectList(NS+"templateList");
	}

	public Vm_templet tempOnedetail(String vm_templet_name) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("vm_templet_name", vm_templet_name);
		return sqlSession.selectOne(NS+"templateList", map);
	}

	public Metering meteringValue(int vm_service_ID) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("vm_service_ID", vm_service_ID);
		return sqlSession.selectOne(NS+"meteringValue", map);
	}

	public int templateUpdate(Vm_templet vm_templet) {
		return sqlSession.update(NS+"templateUpdate",vm_templet);
	}

	public List<Vm_data_info> hostInVM(String hname) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("vm_host", hname);
		return sqlSession.selectList(NS+"hostInVM", map);
	}

	public List<PowerOffCheck> PowerCheckList() {
		return sqlSession.selectList(NS+"PowerOffCheck");
	}

	public Vm_data_info createNameCheck(String vm_name) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("vm_name",  vm_name);
		return sqlSession.selectOne(NS+"createNameCheck",map);
	}

	public void MeteringSum(MeteringSum meteringSum) {
		sqlSession.insert(NS+"MeteringSum", meteringSum);
	}

	public MeteringSum meteringMonthValue(int vm_service_ID) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("vm_service_ID",  vm_service_ID);
		return sqlSession.selectOne(NS+"MeteringMonthValue",map);
	}

	public MeteringSum MeteringYearMonths(String vm_service_ID, String dateSelectBox) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("nVm_service_ID",  vm_service_ID);
		map.put("Month",  dateSelectBox);
		return sqlSession.selectOne(NS+"MeteringYearMonths",map);
	}

	public List<MeteringVMs> meteringVMsSelect(String vm_service_ID, String format) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("nVm_service_ID",  vm_service_ID);
		map.put("format",  format);
		return sqlSession.selectList(NS+"meteringVMsSelect", map);
	}

	public void meteringVMsInsert(MeteringVMs meteringVMsInsertObject) {
		sqlSession.insert("meteringVMsInsert", meteringVMsInsertObject);
	}

	public void meteringVMsUpdate(MeteringVMs meteringVMsInsertObject) {
		sqlSession.update("meteringVMsUpdate", meteringVMsInsertObject);
	}

	public Vm_storage vm_storageDetail(String st_ID) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("st_ID",  st_ID);
		return sqlSession.selectOne(NS+"vm_storageDetail",map);
	}

	public List<MeteringVMs> meteringVMsTableData(String vm_service_ID, String dateFormat) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("nVm_service_ID",  vm_service_ID);
		map.put("format",  dateFormat);
		return sqlSession.selectList(NS+"meteringVMsTableData", map);
	}

	public HashMap<String, Object> Host_Status() {
		return sqlSession.selectOne(NS+"Host_Status");
	}

	public CharSequence countAlert(String payload) {
		return sqlSession.selectOne(NS+"countAlert");
	}

	public int vROinsert(VROConfig vROconfig) {
		return sqlSession.insert("vROinsert",vROconfig);
	}

	public int vROupdate(VROConfig vROconfig) {
		return sqlSession.update("vROupdate", vROconfig);
	}

	public int WeblogConfiginsert(String sUserID, int selectBox, int weblogconfirm, int webloginoutskip) {
		Map<Object, Object> map = new HashMap<>();
		map.put("sUserID", sUserID);
		map.put("nWebloglimit", selectBox);
		map.put("nConfirm", weblogconfirm);
		map.put("nLoginoutskip", webloginoutskip);
		return sqlSession.insert("WeblogConfiginsert", map);
	}

	public LogConfiguration SelectlogConfig(String sUserID) {
		Map<String, String> map = new HashMap<String,String>();
		map.put("sUserID", sUserID);
		return sqlSession.selectOne(NS+"SelectlogConfig", map);
	}

	public int WeblogConfigUpdate(String sUserID, int selectBox, int weblogconfirm, int webloginoutskip) {
		Map<Object, Object> map = new HashMap<>();
		map.put("sUserID", sUserID);
		map.put("nWebloglimit", selectBox);
		map.put("nConfirm", weblogconfirm);
		map.put("nLoginoutskip", webloginoutskip);
		return sqlSession.update("WeblogConfigUpdate", map);
	}

	public List<Ep_service> EPserviceList() {
		return sqlSession.selectList(NS+"EPserviceList");
	}

	public List<Vm_service> EPinView(String nEp_num) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("nEp_num", nEp_num);
		return sqlSession.selectList(NS+"EPinView", map);
	}

	public int EpINservicecheck(int nEp_num) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("nEp_num", nEp_num);
		return sqlSession.selectOne(NS+"EpINservicecheck", map);
	}

	public Ep_service EpNamecheck(String getsEp_name) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("inputed", getsEp_name);
		return sqlSession.selectOne(NS+"EpNamecheck", map);
	}

	public List<Vm_service> Ep_exitservicelist() {
		return sqlSession.selectList(NS+"Ep_exitservicelist");
	}

	public void Ep_serviceupdate(String vm_service_ID, String nEp_num) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("vm_service_ID", vm_service_ID);
		map.put("nEp_num", nEp_num);
		sqlSession.update("Ep_serviceupdate", map);
	}

	public int Ep_INservice(String nEp_num) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("nEp_num", nEp_num);
		return sqlSession.selectOne(NS+"Ep_INservice", map);
	}

	public void EpDelete(String iNServicelist) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("vm_service_ID", iNServicelist);
		sqlSession.update("EpDelete", map);
	}

	public List<Vm_service> SearchServicelist(String inputed) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("inputed", inputed);
		return sqlSession.selectList(NS+"SearchServicelist", map);
	}

	public List<Vm_data_info> EpInVM(String sEp_num) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("sEp_num", sEp_num);
		return sqlSession.selectList(NS+"EpInVM", map);
	}

	public List<MeteringSum> EpMeteringDetail(String sEp_num, String month, String vm_service_ID) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("sEp_num", sEp_num);
		map.put("Month",month);
		map.put("vm_service_ID",vm_service_ID);
		return sqlSession.selectList(NS+"EpMeteringDetail", map);
	}

	public int EpserviceCount(String nEp_num) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("nEp_num", nEp_num);
		return sqlSession.selectOne(NS+"EpserviceCount", map);
	}

	public List<Vm_data_info> VMAllinfolist(String getsEp_num) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("sEp_num", getsEp_num);
		return sqlSession.selectList(NS+"VMAllinfolist",map);
	}

	public List<Vm_service> servicelist(String order) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("order", order);
		return sqlSession.selectList(NS+"servicelist", map);
	}

	public List<Ep_service> EPserviceList(String getsEp_num) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("nEp_num", getsEp_num);
		return sqlSession.selectList(NS+"EPserviceList", map);
	}

	public List<PowerOffCheck> PowerCheckList(String getsEp_num) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("nEp_num", getsEp_num);
		return sqlSession.selectList(NS+"PowerOffCheck", map);
	}

	public List<Vm_host_info> gethostInVMvalue(String hostID) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("hostID", hostID);
		return sqlSession.selectList(NS+"gethostInVMvalue", map);
	}

	public List<Vm_create> vmapplyList() {
		return sqlSession.selectList(NS+"vmapplyList");
	}

	public HashMap<String, Object> vmStatus() {
		return sqlSession.selectOne(NS+"vmStatus");
	}

	public List<PowerOffCheck> monitoringSearch(String inputed) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("inputed", inputed);
		return sqlSession.selectList(NS+"monitoringSearch",map);
	}

	public List<Vm_storage> storageUseList() {
		return sqlSession.selectList(NS+"storageUseList");
	}

	public List<VmOneDetail> vmDetailService(int vm_service_ID) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("vm_service_ID", vm_service_ID);
		return sqlSession.selectList(NS+"vmDetailService",map);
	}

	public List<Vm_data_info> vmDetailNotService() {
		return sqlSession.selectList(NS+"vmDetailNotService");
	}

	public LogConfiguration skipcheck(String sUserID) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("sUserID", sUserID);
		return sqlSession.selectOne(NS+"skipcheck",map);
	}

	public List<Vm_data_info> AllSearchVMlist(String inputed) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("inputed", inputed);
		return sqlSession.selectList(NS+"AllSearchVMlist",map);
	}

	public List<MmonitoringJoin> vmUseAutoScaleCheck() {
		return sqlSession.selectList(NS+"vmUseAutoScaleCheck");
	}

	public int vmthresHoldInsert(AutoScale vm_autoScale) {
		return sqlSession.insert("vmthresHoldInsert",vm_autoScale);
	}

	public List<Vm_data_info> getVMoslinuxList() {
		return sqlSession.selectList(NS+"getVMoslinuxList");
	}

	public List<Vm_host_info> AllSearchHostlist(String inputed) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("inputed", inputed);
		return sqlSession.selectList(NS+"AllSearchHostlist",map);
	}


	public List<Vm_data_info> getVMoslinuxListSearch(String inputed) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("inputed", inputed);
		return sqlSession.selectList(NS+"getVMoslinuxListSearch",map);
	}

	public List<Vm_data_info> getVMID(String vm_name) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("vm_name", vm_name);
		return sqlSession.selectList(NS+"getVMID",map);
	}

	public List<Vm_data_info> getSearchServiceInVM(String inputed, int choiceServiceID){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("inputed", inputed);
		map.put("choiceServiceID", choiceServiceID);
		return sqlSession.selectList(NS+"getSearchServiceInVM",map);
	}
	
	public List<VmYearUseData> vmUseWeekGraph(String vm_ID) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("vm_ID", vm_ID);
		return sqlSession.selectList(NS+"vmUseWeekGraph",map);
	}

	public List<VmYearUseData> vmUseDayGraph() {
		return sqlSession.selectList(NS+"vmUseDayGraph");
	}

	public List<Vm_data_info> getAllvmInfo() {
		return sqlSession.selectList(NS+"VMAllinfolist");
	}

	public List<VmYearUseData> getvmYearData() {
		return sqlSession.selectList(NS+"getvmYearData");
	}

	public List<Vm_data_info> getClusterinHostInfoinVM(String hostName) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("hostName", hostName);
		return sqlSession.selectList(NS+"getClusterinHostInfoinVM",map);
	}

	public Integer tempCount() {
		return sqlSession.selectOne(NS+"tempCount");
	}

	public int serviceUpdate(Vm_service vm_service) {
		//이걸 왜 int로 해놓지???
		
		return sqlSession.update("serviceUpdate",vm_service);
	}

	public List<MmonitoringJoin> autoFilter(String inputed) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("inputed", inputed);
		return sqlSession.selectList(NS+"autoFilter",map);
	}

	public List<Vm_data_info> undeployedautoFilter(String inputed, String order, String orderSwitch) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("inputed", inputed);
		map.put("order", order);
		map.put("orderSwitch", orderSwitch);
		return sqlSession.selectList(NS+"undeployedautoFilter", map);
	}

	public List<Vm_data_info> tenantsInServiceVMs(int serviceID, int tenantsID) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("serviceID", serviceID);
		map.put("tenantsID", tenantsID);
		return sqlSession.selectList(NS+"tenantsInServiceVMs",map);
	}

	public List<Vm_data_info> autoSearchTenantsInServiceVMs(int serviceID, int tenantsID, String inputed) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("tenantsID", tenantsID);
		map.put("serviceID", serviceID);
		map.put("inputed", inputed);
		return sqlSession.selectList(NS+"autoSearchTenantsInServiceVMs",map);
	}

	public Vm_data_info getVMoneinfoName(String cr_vm_name) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("name", cr_vm_name);
		return sqlSession.selectOne(NS+"getVMoneinfoName", map);
	}

	public int companyRelationTenants(int id) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		return sqlSession.selectOne(NS+"companyRelationTenants",map);
	}

	public List<WorkflowStatus> getWorkflowStateList() {
		return sqlSession.selectList(NS+"getWorkflowStateList");
	}

	public HashMap<String, Object> getApprovalCheckcnt(int stage) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("stage", stage);
		return sqlSession.selectOne(NS+"getApprovalCheckcnt",map);
	}

	public int applyVMDetailReturn(String cr_vm_name) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("vmName", cr_vm_name);
		return sqlSession.update(NS+"applyVMDetailReturn",map);
	}

	public List<Vm_service> getTenantlowerRank(int id) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		return sqlSession.selectList(NS+"getTenantlowerRank",map);
	}

	public HashMap<String, Object> getTenantVM(int id) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		return sqlSession.selectOne(NS+"getTenantVM",map);
	}

	public List<MmonitoringJoin> getUserMeteringService(int id) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		return sqlSession.selectList(NS+"getUserMeteringService",id);
	}

	public List<Vm_data_info> getTenantsInServiceOfVMs(Integer serviceID, Integer tenantsID) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("serviceID", serviceID);
		map.put("tenantsID", tenantsID);
		return sqlSession.selectList(NS+"getTenantsInServiceOfVMs",map);
	}

	public int autoScaleInsert(AutoScale autoScale) {
		return sqlSession.insert("autoScaleInsert", autoScale);
	}

	public List<AutoScale> getAutoScaleList() {
		return sqlSession.selectList(NS+"getAutoScaleList");
	}

	public int autoScaleDelete(AutoScale autoScale) {
		return sqlSession.delete("autoScaleDelete",autoScale);
	}

	public List<AutoScale> getAutoScaleList(int id, String col) {
		Map<String,Object> map = new HashMap<String,Object>();
		if(col.equals("id")) {
			map.put("id", id);
		}else if(col.equals("service_id")) {
			map.put("service_id", id);
		}else if(col.equals("isUse")) {
			map.put("isUse", id);
		}
		return sqlSession.selectList(NS+"getAutoScaleList",map);
	}

	public int autoScaleUpdate(AutoScale autoScale) {
		return sqlSession.update("autoScaleUpdate",autoScale);
	}

	public HashMap<String, Object> getServiceInVMvalChk(int service_id) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("service_id", service_id);
		return sqlSession.selectOne(NS+"getServiceInVMvalChk",map);
	}

	public void autoScaleStatusUpdate(int id, int val) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("val", val);
		map.put("id", id);
		sqlSession.update("autoScaleStatusUpdate",map);
	}

	public List<Vm_data_info> getTenantsInServiceOfVMs(int service_id, String col) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("serviceID", service_id);
		map.put("limitChk", col);
		return sqlSession.selectList(NS+"getTenantsInServiceOfVMs",map);
	}

	public List<Vm_data_info> service_INVMlist(int service_id, String col) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("vm_service_ID", service_id);
		map.put("status", col);
		return sqlSession.selectList(NS+"service_INVMlist",map);
	}

	public void autoScalePreVMUpdate(int id, String vm_name, int nPostfix) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("nPostfix", nPostfix);
		map.put("vm_name", vm_name);
		sqlSession.update("autoScalePreVMUpdate",map);
	}

	public void autoScaleStatusUpdate(int id, int val, String col) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("col", col);
		map.put("val", val);
		map.put("id", id);
		sqlSession.update("autoScaleStatusUpdate",map);
	}

	public HashMap<String, Object> getApprovalCheckcnt(int stageDown, String department) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("stage", stageDown);
		map.put("deptId", department);
		return sqlSession.selectOne(NS+"getApprovalCheckcnt",map);
	}

}
