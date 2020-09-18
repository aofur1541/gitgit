package com.kdis.PROM.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kdis.PROM.dao.MenuDAO;
import com.kdis.PROM.logic.Ep_service;
import com.kdis.PROM.logic.LogConfiguration;
import com.kdis.PROM.logic.Metering;
import com.kdis.PROM.logic.MeteringSum;
import com.kdis.PROM.logic.MeteringVMs;
import com.kdis.PROM.logic.MmonitoringJoin;

import com.kdis.PROM.logic.PowerOffCheck;
import com.kdis.PROM.logic.VROConfig;
import com.kdis.PROM.logic.VmOneDetail;
import com.kdis.PROM.logic.AutoScale;
import com.kdis.PROM.logic.Vm_create;
import com.kdis.PROM.logic.Vm_data_info;
import com.kdis.PROM.logic.Vm_host_info;
import com.kdis.PROM.logic.Vm_service;
import com.kdis.PROM.logic.Vm_service_graph;
import com.kdis.PROM.logic.Vm_storage;
import com.kdis.PROM.logic.Vm_templet;
import com.kdis.PROM.logic.WorkflowStatus;

@Service
public class MenuServiceImpl implements MenuService {

	@Autowired
	MenuDAO menuDAO;

	@Override
	public List<Vm_service> VMservice_list() {
		return menuDAO.servicelist();
	}


	@Override
	public Vm_service VMservice_select(String servicename) {
		return menuDAO.getserviceSelect(servicename);
	}

	@Override
	public int VMservice_hostcount(int vm_service_ID) {
		return menuDAO.host_count(vm_service_ID);
	}


	@Override
	public int VMservice_vmcount(int vm_service_ID) {
		return menuDAO.vm_count(vm_service_ID);
	}

	@Override
	public Vm_data_info VM_Onevm_info(String vm_ID) {
		return menuDAO.VM_Onevm_info(vm_ID);
	}


	@Override
	public Vm_host_info VM_Onehost_info(String vm_HID) {
		return menuDAO.VM_Onehost_info(vm_HID);
	}


	@Override
	public List<Vm_host_info> host_info_list() {
		return menuDAO.host_info();
	}


	@Override
	public List<Vm_templet> vm_templetlist() {
		return menuDAO.vm_templet();
	}

	@Override
	public int VM_create(Vm_create vm_create) {
		return menuDAO.vm_create(vm_create);
	}

	@Override
	public List<Vm_create> VM_createwaitlist() {
		return menuDAO.vm_createwaitlist();
	}

	@Override
	public List<Vm_create> notapprovalVMCR_list() {
		return menuDAO.notapprovalVMCR_list();
	}


	@Override
	public List<Vm_data_info> VMAllinfolist() {
		return menuDAO.VMAllinfolist();
	}

	@Override
	public Vm_data_info service_inVMdetail(String vm_ID) {
		return menuDAO.service_inVMdetail(vm_ID);
	}

	@Override
	public void VM_service_VMcount(String service_radio) {
		menuDAO.VM_service_VMcount(service_radio);
	}


	@Override
	public void VM_deportdelete(String INVMlist) {
		menuDAO.VM_deportdelete(INVMlist);
	}


	@Override
	public List<Vm_data_info> SearchVMlist(String inputed) {
		return menuDAO.SearchVMlist(inputed);
	}

	@Override
	public Vm_service service_detail_sename(Integer vm_service) {
		return menuDAO.service_detail_sename(vm_service);
	}


	@Override
	public int applyserviceDetail(Integer vm_service_ID) {
		return menuDAO.applyserviceDetail(vm_service_ID);
	}

	@Override
	public Vm_create notapplyVMdetail(int cr_num) {
		return menuDAO.notapplyVMdetail(cr_num);
	}


	@Override
	public int VM_delete(int cr_num) {
		return menuDAO.VM_delete(cr_num);
	}

	@Override
	public List<MmonitoringJoin> service_detailInfo(String vm_service_ID) {
		return menuDAO.service_detailInfo(vm_service_ID);
	}


	@Override
	public List<Vm_service_graph> DashServiceGraph() {
		return menuDAO.DashServiceGraph();
	}


	@Override
	public HashMap<String, Object> serviceCount() {
		return menuDAO.serviceCount();
	}
	
	@Override
	public void service_graph(Vm_service_graph vm_service_graph) {
		menuDAO.service_graphInsert(vm_service_graph);
	}


	@Override
	public List<Vm_service> SearchServiceNotApply(String inputed) {
		return menuDAO.SearchServiceNotApply(inputed);
	}

	@Override
	public List<Vm_service> ApplySearchServicelist(String inputed) {
		return menuDAO.SearchServiceApply(inputed);
	}


	@Override
	public List<Vm_service> Authorityservice_list(String sUserID,String sEp_num) {
		return menuDAO.Authorityservice_list(sUserID,sEp_num);
	}


	@Override
	public Vm_data_info NewVM_Select(String vm_service_vm_name) {
		return menuDAO.NewVM_Select(vm_service_vm_name);
	}

	@Override
	public int ServiceINVM(String service_radio) {
		return menuDAO.ServiceINVM(service_radio);
	}


	@Override
	public List<Vm_data_info> service_INVMlist(Integer vm_service_ID) {
		return menuDAO.service_INVMlist(vm_service_ID);
	}


	@Override
	public List<Vm_data_info> templateList() {
		return menuDAO.templateList();
	}


	@Override
	public Vm_templet Onedetail(String vm_templet_name) {
		return menuDAO.tempOnedetail(vm_templet_name);
	}


	@Override
	public Metering meteringValue(int vm_service_ID) {
		return menuDAO.meteringValue(vm_service_ID);
	}


	@Override
	public int templateUpdate(Vm_templet vm_templet) {
		return menuDAO.templateUpdate(vm_templet);
	}

	@Override
	public List<Vm_data_info> hostInVM(String hname) {
		return menuDAO.hostInVM(hname);
	}


	@Override
	public List<PowerOffCheck> PowerCheckList() {
		return menuDAO.PowerCheckList();
	}


	@Override
	public Vm_data_info createNameCheck(String vm_name) {
		return menuDAO.createNameCheck(vm_name);
	}


	@Override
	public void MeteringSum(MeteringSum meteringSum) {
		menuDAO.MeteringSum(meteringSum);
	}


	@Override
	public MeteringSum meteringMonthValue(int vm_service_ID) {
		return menuDAO.meteringMonthValue(vm_service_ID);
	}


	@Override
	public MeteringSum MeteringYearMonths(String vm_service_ID, String dateSelectBox) {
		
		return menuDAO.MeteringYearMonths(vm_service_ID,dateSelectBox);
	}


	@Override
	public List<MeteringVMs> meteringVMsSelect(String vm_service_ID,String Format) {
		return menuDAO.meteringVMsSelect(vm_service_ID,Format);
	}


	@Override
	public void meteringVMsInsert(MeteringVMs meteringVMsInsertObject) {
		menuDAO.meteringVMsInsert(meteringVMsInsertObject);
		
	}


	@Override
	public void meteringVMsUpdate(MeteringVMs meteringVMsInsertObject) {
		menuDAO.meteringVMsUpdate(meteringVMsInsertObject);
	}


	@Override
	public Vm_storage vm_storageDetail(String st_ID) {
		return menuDAO.vm_storageDetail(st_ID);
	}


	@Override
	public List<MeteringVMs> meteringVMsTableData(String vm_service_ID, String dateFormat) {
		return menuDAO.meteringVMsTableData(vm_service_ID,dateFormat);
	}


	@Override
	public HashMap<String, Object> Host_Status() {
		return menuDAO.Host_Status();
	}


	@Override
	public int vROinsert(VROConfig vROconfig) {
		return menuDAO.vROinsert(vROconfig);
	}


	@Override
	public int vROupdate(VROConfig vROconfig) {
		return menuDAO.vROupdate(vROconfig);
	}


	@Override
	public int WeblogConfiginsert(String sUserID,int selectBox, int weblogconfirm, int webloginoutskip) {
		return menuDAO.WeblogConfiginsert(sUserID,selectBox,weblogconfirm,webloginoutskip);
	}


	@Override
	public LogConfiguration SelectlogConfig(String sUserID) {
		return menuDAO.SelectlogConfig(sUserID);
	}


	@Override
	public int WeblogConfigUpdate(String sUserID, int selectBox, int weblogconfirm, int webloginoutskip) {
		return menuDAO.WeblogConfigUpdate(sUserID,selectBox,weblogconfirm,webloginoutskip);
	}


	@Override
	public List<Ep_service> EPserviceList() {
		return menuDAO.EPserviceList();
	}


	@Override
	public List<Vm_service> EPinView(String nEp_num) {
		return menuDAO.EPinView(nEp_num);
	}


	@Override
	public int EpINservicecheck(int nEp_num) {
		return menuDAO.EpINservicecheck(nEp_num);
	}

	@Override
	public Ep_service EpNamecheck(String getsEp_name) {
		return menuDAO.EpNamecheck(getsEp_name);
	}


	@Override
	public List<Vm_service> Ep_exitservicelist() {
		return menuDAO.Ep_exitservicelist();
	}


	@Override
	public void Ep_serviceupdate(String string, String nEp_num) {
		menuDAO.Ep_serviceupdate(string,nEp_num);
	}


	@Override
	public int Ep_INservice(String nEp_num) {
		return menuDAO.Ep_INservice(nEp_num);
	}


	@Override
	public void EpDelete(String INServicelist) {
		menuDAO.EpDelete(INServicelist);
	}


	@Override
	public List<Vm_service> SearchServicelist(String inputed) {
		return menuDAO.SearchServicelist(inputed);
	}

	@Override
	public List<Vm_data_info> EpInVM(String sEp_num) {
		return menuDAO.EpInVM(sEp_num);
	}


	@Override
	public List<MeteringSum> EpMeteringDetail(String sEp_num,String Month,String vm_service_ID) {
		return menuDAO.EpMeteringDetail(sEp_num,Month,vm_service_ID);
	}


	@Override
	public int EpserviceCount(String sEp_num) {
		return menuDAO.EpserviceCount(sEp_num);
	}

	@Override
	public List<Vm_data_info> VMAllinfolist(String getsEp_num) {
		return menuDAO.VMAllinfolist(getsEp_num);
	}


	@Override
	public List<Vm_service> VMservice_list(String order) {
		return menuDAO.servicelist(order);
	}


	@Override
	public List<Ep_service> EPserviceList(String getsEp_num) {
		return menuDAO.EPserviceList(getsEp_num);
	}


	@Override
	public List<PowerOffCheck> PowerCheckList(String getsEp_num) {
		return menuDAO.PowerCheckList(getsEp_num);
	}


	@Override
	public List<Vm_host_info> gethostInVMvalue(String hostID) {
		return menuDAO.gethostInVMvalue(hostID);
	}


	@Override
	public List<Vm_create> vmapplyList() {
		return menuDAO.vmapplyList();
	}


	@Override
	public HashMap<String, Object> vmStatus() {
		return menuDAO.vmStatus();
	}

	@Override
	public List<PowerOffCheck> monitoringSearch(String inputed) {
		return menuDAO.monitoringSearch(inputed);
	}

	@Override
	public List<Vm_storage> storageUseList() {
		return menuDAO.storageUseList();
	}


	@Override
	public List<VmOneDetail> vmDetailService(int vm_service_ID) {
		return menuDAO.vmDetailService(vm_service_ID);
	}


	@Override
	public List<Vm_data_info> vmDetailNotService() {
		return menuDAO.vmDetailNotService();
	}


	@Override
	public LogConfiguration skipcheck(String sUserID) {
		return menuDAO.skipcheck(sUserID);
	}

	@Override
	public List<Vm_data_info> AllSearchVMlist(String inputed) {
		return menuDAO.AllSearchVMlist(inputed);
	}

	@Override
	public List<MmonitoringJoin> vmUseAutoScaleCheck() {
		return menuDAO.vmUseAutoScaleCheck();
	}


	@Override
	public List<Vm_data_info> getVMoslinuxList() {
		return menuDAO.getVMoslinuxList();
	}

	@Override
	public List<Vm_host_info> AllSearchHostlist(String inputed) {
		return menuDAO.AllSearchHostlist(inputed);
	}

	@Override
	public List<Vm_data_info> getVMoslinuxListSearch(String inputed) {
		return menuDAO.getVMoslinuxListSearch(inputed);
	}


	@Override
	public List<Vm_data_info> getVMID(String vm_name) {
		return menuDAO.getVMID(vm_name);
	}


	@Override
	public List<Vm_data_info> getSearchServiceInVM(String inputed,int choiceServiceID) {
		return menuDAO.getSearchServiceInVM(inputed,choiceServiceID);
	}


	@Override
	public List<Vm_data_info> getAllvmInfo() {
		return menuDAO.getAllvmInfo();
	}


	@Override
	public List<Vm_data_info> getClusterinHostInfoinVM(String hostName) {
		return menuDAO.getClusterinHostInfoinVM(hostName);
	}


	@Override
	public Integer tempCount() {
		return menuDAO.tempCount();
	}


	@Override
	public List<MmonitoringJoin> autoFilter(String inputed) {
		return menuDAO.autoFilter(inputed);
	}


	@Override
	public List<Vm_data_info> undeployedautoFilter(String inputed, String order, String orderSwitch) {
		return menuDAO.undeployedautoFilter(inputed,order,orderSwitch);
	}


	@Override
	public List<Vm_data_info> autoSearchTenantsInServiceVMs(int serviceID,int tenantsID, String inputed) {
		return menuDAO.autoSearchTenantsInServiceVMs(serviceID,tenantsID,inputed);
	}

	@Override
	public Vm_data_info getVMoneinfoName(String cr_vm_name) {
		return menuDAO.getVMoneinfoName(cr_vm_name);
	}


	@Override
	public int companyRelationTenants(int id) {
		return menuDAO.companyRelationTenants(id);
	}


	@Override
	public List<WorkflowStatus> getWorkflowStateList() {
		return menuDAO.getWorkflowStateList();
	}

	@Override
	public HashMap<String, Object> getApprovalCheckcnt(int stage) {
		return menuDAO.getApprovalCheckcnt(stage);
	}

	@Override
	public int applyVMDetailReturn(String cr_vm_name) {
		return menuDAO.applyVMDetailReturn(cr_vm_name);
	}


	@Override
	public List<Vm_service> getTenantlowerRank(int id) {
		return menuDAO.getTenantlowerRank(id);
	}


	@Override
	public HashMap<String, Object> getTenantVM(int id) {
		return menuDAO.getTenantVM(id);
	}

	@Override
	public List<MmonitoringJoin> getUserMeteringService(int id) {
		return menuDAO.getUserMeteringService(id);
	}


	@Override
	public List<Vm_data_info> getTenantsInServiceOfVMs(Integer serviceID,Integer tenantsID) {
		return menuDAO.getTenantsInServiceOfVMs(serviceID,tenantsID);
	}


	@Override
	public int autoScaleInsert(AutoScale autoScale) {
		return menuDAO.autoScaleInsert(autoScale);
	}


	@Override
	public List<AutoScale> getAutoScaleList() {
		return menuDAO.getAutoScaleList();
	}

	@Override
	public int autoScaleDelete(AutoScale autoScale) {
		return menuDAO.autoScaleDelete(autoScale);
	}


	@Override
	public List<AutoScale> getAutoScaleList(int id,String col) {
		return menuDAO.getAutoScaleList(id,col);
	}


	@Override
	public int autoScaleUpdate(AutoScale autoScale) {
		return menuDAO.autoScaleUpdate(autoScale);
	}


	@Override
	public HashMap<String, Object> getServiceInVMvalChk(int service_id) {
		return menuDAO.getServiceInVMvalChk(service_id);
	}

	@Override
	public void autoScaleStatusUpdate(int id,int val) {
		menuDAO.autoScaleStatusUpdate(id,val);
	}


	@Override
	public List<Vm_data_info> getTenantsInServiceOfVMs(int service_id, String col) {
		return menuDAO.getTenantsInServiceOfVMs(service_id,col);
	}


	@Override
	public List<Vm_data_info> service_INVMlist(int service_id, String col) {
		return menuDAO.service_INVMlist(service_id,col);
	}


	@Override
	public void autoScalePreVMUpdate(int id, String vm_name,int nPostfix) {
		menuDAO.autoScalePreVMUpdate(id,vm_name,nPostfix);
	}


	@Override
	public void autoScaleReset(int id) {
	}


	@Override
	public void autoScaleStatusUpdate(int id, int val, String col) {
		menuDAO.autoScaleStatusUpdate(id,val,col);
	}

	@Override
	public HashMap<String, Object> getApprovalCheckcnt(int stageDown, String department) {
		return menuDAO.getApprovalCheckcnt(stageDown,department);
	}

}
