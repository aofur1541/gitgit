package com.kdis.PROM.service;

import java.util.HashMap;
import java.util.List;

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


public interface MenuService {

	List<Vm_service> VMservice_list();

	Vm_service VMservice_select(String servicename);
	
	Vm_data_info VM_Onevm_info(String vm_ID);

	Vm_host_info VM_Onehost_info(String vm_HID);

	List<Vm_host_info> host_info_list();

	List<Vm_templet> vm_templetlist();

	List<Vm_create> VM_createwaitlist();

	List<Vm_create> notapprovalVMCR_list();

	List<Vm_data_info> VMAllinfolist();

	Vm_data_info service_inVMdetail(String vm_ID);

	List<Vm_data_info> SearchVMlist(String inputed);

	Vm_service service_detail_sename(Integer vm_service);

	Vm_create notapplyVMdetail(int cr_num);
	
	List<MmonitoringJoin> service_detailInfo(String vm_service_ID);

	List<Vm_service_graph> DashServiceGraph();

	HashMap<String, Object> serviceCount();
	
	List<Vm_service> SearchServiceNotApply(String inputed);

	List<Vm_service> ApplySearchServicelist(String inputed);

	List<Vm_service> Authorityservice_list(String sUserID, String sEp_num);

	Vm_data_info NewVM_Select(String vm_service_vm_name);

	List<Vm_data_info> service_INVMlist(Integer vm_service_ID);

	List<Vm_data_info> templateList();

	Vm_templet Onedetail(String vm_templet_name);

	Metering meteringValue(int vm_service_ID);

	List<Vm_data_info> hostInVM(String hname);

	List<PowerOffCheck> PowerCheckList();

	Vm_data_info createNameCheck(String vm_name);

	MeteringSum meteringMonthValue(int vm_service_ID);

	MeteringSum MeteringYearMonths(String vm_service_ID, String dateSelectBox);

	List<MeteringVMs> meteringVMsSelect(String vm_service_ID, String formatTime);

	Vm_storage vm_storageDetail(String st_ID);

	List<MeteringVMs> meteringVMsTableData(String vm_service_ID, String dateFormat);

	HashMap<String, Object> Host_Status();

	LogConfiguration SelectlogConfig(String sUserID);

	List<Ep_service> EPserviceList();

	List<Vm_service> EPinView(String nEp_num);

	Ep_service EpNamecheck(String getsEp_name);

	List<Vm_service> Ep_exitservicelist();
	
	List<Vm_service> SearchServicelist(String inputed);

	List<Vm_data_info> EpInVM(String sEp_num);

	List<MeteringSum> EpMeteringDetail(String sEp_num, String month, String vm_service_ID);

	List<Vm_data_info> VMAllinfolist(String getsEp_num);

	List<Vm_service> VMservice_list(String order);

	List<Ep_service> EPserviceList(String getsEp_num);

	List<PowerOffCheck> PowerCheckList(String getsEp_num);

	List<Vm_host_info> gethostInVMvalue(String hostID);

	List<Vm_create> vmapplyList();

	HashMap<String, Object> vmStatus();

	List<PowerOffCheck> monitoringSearch(String inputed);

	List<Vm_storage> storageUseList();

	List<VmOneDetail> vmDetailService(int vm_service_ID);

	List<Vm_data_info> vmDetailNotService();

	LogConfiguration skipcheck(String sUserID);

	List<Vm_data_info> AllSearchVMlist(String inputed);

	List<MmonitoringJoin> vmUseAutoScaleCheck();

	List<Vm_data_info> getVMoslinuxList();

	List<Vm_host_info> AllSearchHostlist(String inputed);

	List<Vm_data_info> getVMoslinuxListSearch(String inputed);

	List<Vm_data_info> getVMID(String vm_name);

	List<Vm_data_info> getSearchServiceInVM(String inputed, int choiceServiceID);

	List<Vm_data_info> getAllvmInfo();

	List<Vm_data_info> getClusterinHostInfoinVM(String hostName);

	Integer tempCount();

	List<MmonitoringJoin> autoFilter(String inputed);

	List<Vm_data_info> undeployedautoFilter(String inputed, String order, String orderSwitch);

	List<Vm_data_info> autoSearchTenantsInServiceVMs(int serviceID, int tenantsID, String inputed);
	
	Vm_data_info getVMoneinfoName(String cr_vm_name);

	List<WorkflowStatus> getWorkflowStateList();

	HashMap<String, Object> getApprovalCheckcnt(int stage);

	List<Vm_service> getTenantlowerRank(int id);

	HashMap<String, Object> getTenantVM(int id);

	List<MmonitoringJoin> getUserMeteringService(int id);

	List<Vm_data_info> getTenantsInServiceOfVMs(Integer serviceID, Integer tenantsID);

	List<AutoScale> getAutoScaleList();
	
	List<AutoScale> getAutoScaleList(int id,String col);

	List<Vm_data_info> getTenantsInServiceOfVMs(int service_id, String col);

	List<Vm_data_info> service_INVMlist(int service_id, String col);
	
	HashMap<String, Object> getServiceInVMvalChk(int service_id);
	
	HashMap<String, Object> getApprovalCheckcnt(int stageDown, String department);
	
	int ServiceINVM(String service_radio);

	int templateUpdate(Vm_templet vm_templet);

	int vROinsert(VROConfig vROconfig);
	
	int vROupdate(VROConfig vROconfig);
	
	int WeblogConfiginsert(String sUserID, int selectBox, int weblogconfirm, int webloginoutskip);
	
	int WeblogConfigUpdate(String sUserID, int selectBox, int weblogconfirm, int webloginoutskip);
	
	int EpINservicecheck(int nEp_num);
	
	int Ep_INservice(String nEp_num);
	
	int EpserviceCount(String sEp_num);

	int VMservice_hostcount(int vm_service_ID);

	int VMservice_vmcount(int vm_service_ID);

	int VM_create(Vm_create vm_create);
	
	int applyserviceDetail(Integer vm_service_ID);

	int VM_delete(int cr_num);

	int applyVMDetailReturn(String cr_vm_name);
	
	int autoScaleInsert(AutoScale vm_autoScale);
	
	int autoScaleDelete(AutoScale autoScale);
	
	int autoScaleUpdate(AutoScale autoScale);
	
	int companyRelationTenants(int id);
	
	void Ep_serviceupdate(String string, String nEp_num);

	void EpDelete(String INServicelist);
	
	void autoScaleStatusUpdate(int id, int val);

	void autoScalePreVMUpdate(int id, String vm_name, int nPostfix);
	
	void autoScaleReset(int id);
	
	void autoScaleStatusUpdate(int id, int i, String col);
	
	void VM_service_VMcount(String service_radio);
	
	void VM_deportdelete(String INVMlist);

	void service_graph(Vm_service_graph vm_service_graph);

	void MeteringSum(MeteringSum meteringSum);
	
	void meteringVMsInsert(MeteringVMs meteringVMsInsertObject);

	void meteringVMsUpdate(MeteringVMs meteringVMsInsertObject);

}
