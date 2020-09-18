package com.kdis.PROM.common;

import java.net.URI;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.kdis.PROM.apply.vo.VMCDROMVO;
import com.kdis.PROM.apply.vo.VMCreateVO;
import com.kdis.PROM.apply.vo.VMDataVO;
import com.kdis.PROM.apply.vo.VMDiskVO;
import com.kdis.PROM.apply.vo.VMNetworkVO;
import com.kdis.PROM.config.service.ExternalServerService;
import com.kdis.PROM.config.vo.ExternalServerTypeEnum;
import com.kdis.PROM.config.vo.ExternalServerVO;
import com.kdis.PROM.logic.Vm_create;
import com.kdis.PROM.logic.Vm_host_info;
import com.kdis.PROM.obj_environ.service.EnvironmentSetService;
import com.kdis.PROM.tenant.vo.VMServiceVO;
import com.vmware.o11n.sdk.rest.client.DefaultVcoSessionFactory;
import com.vmware.o11n.sdk.rest.client.VcoSession;
import com.vmware.o11n.sdk.rest.client.services.ExecutionContextBuilder;
import com.vmware.o11n.sdk.rest.client.services.ExecutionService;
import com.vmware.o11n.sdk.rest.client.services.WorkflowService;
import com.vmware.o11n.sdk.rest.client.stubs.ExecutionContext;
import com.vmware.o11n.sdk.rest.client.stubs.Workflow;
import com.vmware.o11n.sdk.rest.client.stubs.WorkflowExecution;
import com.vmware.o11n.sdk.rest.client.stubs.WorkflowExecutionState;

@Component
public class CommonAPI {

	public final String AUTODOWN_VM_CREATE = "af5c1e79-2ac3-4ad2-aabf-ed8923d9c3dc";
	public final String AUTODOWN_VM_STATE = "fed3fcee-a5c4-4f8d-a839-1765f9b33f86";
	public final String CHANGE_VM_STATE = "d6936674-3dc0-4771-af61-1be53eabb418";
	public final String VM_CREATE = "055abafa-8447-4ccb-a370-b269ab3c4385";
	public final String VM_CHANGE = "a049f799-e177-4fd1-be34-5d8493f80f84";
	public final String VM_CHANGE_HOTADDON = "17fa2eab-ce33-43de-88c8-7d85539382ea";
	public final String VM_DATA_INFO = "58606177-90c4-4be9-82a8-b22047369f20";
	public final String VCENTER_ALERT = "61e89a86-3be2-4057-951d-f13c0a57c57c";
	public final String AUTOVM_RESOURCE_CHANGE = "658c5614-a667-47f2-8fbc-1a5ee284190c";
	public final String MANUAL_SCLAEOUT = "4ae61742-fa70-4c5d-b42c-af1a731ee5d2";
	public final String ADD_VDISK = "a2914e51-5fc1-452f-adcd-3240ed4afa31";
	public final String ADD_VNIC = "cfdfb91e-fdc4-4a8f-a653-d6fd1735d8cf";
	public final String VNIC_CONTROL = "7e916443-bb50-4174-86bd-b1e14cf60043";
	public final String CD_ROM_MOUNT = "88d78c3c-5c6e-4a4a-a995-23659c21fc36";
	public final String CD_ROM_UNMOUNT = "f89a0495-81b6-46cb-92fc-c3659bb0df3a";
	
	public String vRoUrl = "";
	public String vRoSSoID = "";
	public String vRoSSoPW = "";
	
	@Autowired
	private static final Log LOG = LogFactory.getLog( CommonAPI.class );
	
	@Autowired
	private  EnvironmentSetService environmentSetService;
	
	/** 외부 서버 서비스 */
	@Autowired
	private ExternalServerService serverService;
	
	public void vROconfigModule() throws Exception {
		
		// vRealize Orchestrator 서버 정보 얻기
		ExternalServerVO vRealizeOrchestrator = 
				serverService.selectExternalServerByServerType(ExternalServerTypeEnum.vRealizeOrchestrator);
		
		if (vRealizeOrchestrator != null) {
			vRoUrl = vRealizeOrchestrator.getConnectString();
			vRoSSoID = vRealizeOrchestrator.getAccount();
			vRoSSoPW = vRealizeOrchestrator.getPassword();
		}
	}
	
	/**
	 * vRO(vRealize Orchestrator) 서버의 VM 생성 API 실행
	 * 
	 * @param vmCreateVO
	 * @return
	 * @throws Exception
	 */
	public int createVM(VMCreateVO vmCreateVO) throws Exception {
		VcoSession session;
		vROconfigModule();

		Boolean dhcpOnOff = true;
		
		if(vmCreateVO.getCrDhcp() == 1) {
			dhcpOnOff = true;
		}else if(vmCreateVO.getCrDhcp() == 2) {
			dhcpOnOff = false;
		}
		
		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl), vRoSSoID, vRoSSoPW);

		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);

		Workflow workflow = workflowService.getWorkflow(VM_CREATE);
		ExecutionContext context = new ExecutionContextBuilder().addParam("ipAddress", vmCreateVO.getCrIPAddress())
				.addParam("vmname", vmCreateVO.getCrVMName())
				.addParam("vmtemplate", vmCreateVO.getCrTemplet())
				.addParam("vCpu", vmCreateVO.getCrCPU())
				.addParam("vMem", vmCreateVO.getCrMemory())
				.addParam("vHost", vmCreateVO.getCrHost())
				.addParam("vDatastore", vmCreateVO.getCrStorage())
				.addParam("vNetwork", vmCreateVO.getCrNetWork())
				.addParam("service_id", vmCreateVO.getVmServiceID())
				.addParam("dhcp", dhcpOnOff)
				.addParam("netmask", vmCreateVO.getCrNetmask())
				.addParam("gatewayIn", vmCreateVO.getCrGateway()).build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED, WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
		return 2;
	}
	
	/**
	 * vRO(vRealize Orchestrator) 서버의 VM 변경 API 실행
	 * 
	 * @param vmCreateVO
	 * @throws Exception
	 */
	public void changeVM(VMCreateVO vmCreateVO) throws Exception {
		VcoSession session;
		vROconfigModule();
		
		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl),
				vRoSSoID, vRoSSoPW);
		
		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);

		Workflow workflow = workflowService.getWorkflow(VM_CHANGE);
		ExecutionContext context = new ExecutionContextBuilder()
				.addParam("vmname", vmCreateVO.getCrVMName())
				.addParam("vcpu",vmCreateVO.getCrCPU())
				.addParam("vmemory", vmCreateVO.getCrMemory()).build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED,
					WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * vRO(vRealize Orchestrator) 서버의 VM 변경(핫플러그 ON) API 실행
	 * 
	 * @param vmCreateVO
	 * @throws Exception
	 */
	public void changeVMHotAddON(VMCreateVO vmCreateVO) throws Exception {
		VcoSession session;
		vROconfigModule();
		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl),
				vRoSSoID,vRoSSoPW);
		
		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);
		
		Workflow workflow = workflowService.getWorkflow(VM_CHANGE_HOTADDON);
		ExecutionContext context = new ExecutionContextBuilder()
				.addParam("vmname", vmCreateVO.getCrVMName())
				.addParam("vcpu",vmCreateVO.getCrCPU())
				.addParam("vmemory", vmCreateVO.getCrMemory()).build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED,
					WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * vRO(vRealize Orchestrator) 서버의 가상머신 Disk 추가  API 실행 
	 * 
	 * @param vmDiskVO
	 * @return
	 * @throws Exception
	 */
	public int addVMDisk(VMDiskVO vmDiskVO) throws Exception {
		
		VcoSession session;
		vROconfigModule();

		Boolean useThin = false;
		
		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl), vRoSSoID, vRoSSoPW);

		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);

		Workflow workflow = workflowService.getWorkflow(ADD_VDISK);
		ExecutionContext context = new ExecutionContextBuilder()
				.addParam("diskIndex", vmDiskVO.getnSCSInumber())
				.addParam("diskSize", vmDiskVO.getnDiskCapacity())
				.addParam("vmname", vmDiskVO.getsVmName())
				.addParam("thinProvisioned", useThin)
				.addParam("datastoreID", vmDiskVO.getsDiskId())
				.build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED, WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
		
		return 1;
	}
	
	/**
	 * vRO(vRealize Orchestrator) 서버의 가상머신 네트워크 추가  API 실행 
	 * 
	 * @param vmNetworkVO
	 * @return
	 * @throws Exception
	 */
	public int addVMNetwork(VMNetworkVO vmNetworkVO) throws Exception {
		
		VcoSession session;
		vROconfigModule();

		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl), vRoSSoID, vRoSSoPW);

		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);

		Workflow workflow = workflowService.getWorkflow(ADD_VNIC);
		ExecutionContext context = new ExecutionContextBuilder()
				.addParam("vmName", vmNetworkVO.getsVmName())
				.addParam("networkId", vmNetworkVO.getPortgroupId()).build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED, WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
		
		return 1;
		
	}
	
	/**
	 * vRO(vRealize Orchestrator) 서버의 가상머신 네트워크 제어(연결/연결해제/삭제) API 실행 
	 * 
	 * @param vmNetworkVO
	 * @return
	 * @throws Exception
	 */
	public int controlVMNetwork(VMNetworkVO vmNetworkVO) throws Exception {
		
		VcoSession session;
		vROconfigModule();

		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl), vRoSSoID, vRoSSoPW);

		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);

		Workflow workflow = workflowService.getWorkflow(VNIC_CONTROL);
		ExecutionContext context = new ExecutionContextBuilder()
				.addParam("conn", vmNetworkVO.getMode())
				.addParam("vmname", vmNetworkVO.getsVmName())
				.addParam("nwLable", vmNetworkVO.getLabelNumber()).build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED, WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
		return 1;
	}
	
	/**
	 * vRO(vRealize Orchestrator) 서버의 가상머신 CD-ROM 제어(MOUNT/UNMOUNT) API 실행 
	 * 
	 * @param vmCDROMVO
	 * @throws Exception
	 */
	public void controlVMCDROM(VMCDROMVO vmCDROMVO) throws Exception {
		String target = "";
		String filepath = "";
		
		if("MOUNT".equals(vmCDROMVO.getMode())) {
			target = CD_ROM_MOUNT;
			filepath = "["+vmCDROMVO.getDataStoreName()+"] "+vmCDROMVO.getFilePath();
		} else {
			target = CD_ROM_UNMOUNT;
		}
		ExecutionContext context = null;
		VcoSession session;
		vROconfigModule();

		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl), vRoSSoID, vRoSSoPW);

		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);

		Workflow workflow = workflowService.getWorkflow(target);
		if("MOUNT".equals(vmCDROMVO.getMode())) {
			context = new ExecutionContextBuilder()
					.addParam("filePath", filepath)
					.addParam("vmname", vmCDROMVO.getsVmName()).build();
		} else {
			context = new ExecutionContextBuilder()
					.addParam("vmname", vmCDROMVO.getsVmName()).build();
		}
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED, WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
		
	}
	
	/**
	 * vRO(vRealize Orchestrator) 서버의 가상 머신 상태(전원 켜기/전원 끄기/리부팅/삭제) 변경 API 실행 
	 * 
	 * 
	 * @param vmName
	 * @param stateIndex 1:전원 켜기, 2:전원 끄기, 3:전원 리부팅, 4:삭제
	 * @throws Exception
	 */
	public void changeVMState(String vmName, int stateIndex) throws Exception {
		VcoSession session;
		vROconfigModule();
		
		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl),
				vRoSSoID, vRoSSoPW);
		
		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);

		Workflow workflow = workflowService.getWorkflow(CHANGE_VM_STATE);
		ExecutionContext context = new ExecutionContextBuilder()
				.addParam("vmname", vmName)
				.addParam("select",stateIndex).build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED,
					WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
		
	}
		
	public int vm_data_infoWorkflow() throws Exception {
		VcoSession session;
		
		vROconfigModule();
		
		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl),
				vRoSSoID, vRoSSoPW);

		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);

		Workflow workflow = workflowService.getWorkflow(VM_DATA_INFO);
		ExecutionContext context = new ExecutionContextBuilder().build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED,
					WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
			
			
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
		return 2;
	}
		
	public void Vc_alert() throws Exception {
		VcoSession session;
		
		vROconfigModule();
		
		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl),
				vRoSSoID, vRoSSoPW);

		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);
		
		Workflow workflow = workflowService.getWorkflow(VCENTER_ALERT);
		ExecutionContext context = new ExecutionContextBuilder().build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED,
					WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
	}
		
	public void autoScaleworkflow(VMDataVO vmOneInfo, VMServiceVO serviceVO,String avIP,String vmName) throws Exception {
		
		int limitActive = 1;
		String hostName = "";
		
		VcoSession session;
		vROconfigModule();
		
		
		List<Vm_host_info> partCheck = environmentSetService.getPartCheckOfHost(serviceVO.getDefaultStorage(),serviceVO.getDefaultNetwork());
		
		if(partCheck.isEmpty()) {
			LOG.warn("autoScaleworkflow Method Scale Out/In ERROR : 1.The host datastore or network settings are not correct.");
		} else {
		
		List<Vm_host_info> result = environmentSetService.getLowestHostsInCluster(limitActive);
		
		if(result.isEmpty()) {
			LOG.warn("autoScaleworkflow Method Scale Out/In ERROR : 2.Host does not exist.");
			LOG.warn("Active : 1-1.That's why it runs on the host data in the service.");
			hostName = serviceVO.getDefaultHost();
		} else {
			LOG.warn("Active : 1-2.CPU acts as the lowest host");
			hostName = result.get(0).getVm_Hhostname();
		}
		
		
		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl),
				vRoSSoID, vRoSSoPW);
		
		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);

		Workflow workflow = workflowService.getWorkflow(AUTODOWN_VM_CREATE);
		ExecutionContext context = new ExecutionContextBuilder()
				.addParam("ipAddress", avIP)
				.addParam("vmname", vmOneInfo.getVmName())
				.addParam("vmtemplate", vmName)
				.addParam("vCpu",vmOneInfo.getVmCPU())
				.addParam("vMem", vmOneInfo.getVmMemory())
				.addParam("vHost", hostName)
				.addParam("vDatastore", serviceVO.getDefaultStorage())
				.addParam("vNetwork", serviceVO.getDefaultNetwork())
				.addParam("service_id",serviceVO.getVmServiceID())
				.addParam("dhcp",serviceVO.getDhcpOnoff())
				.addParam("netmask",serviceVO.getDefaultNetmask())
				.addParam("gatewayIn",serviceVO.getDefaultGateway()).build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED,
					WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn("autoScaleworkflow Method Scale Out/In ERROR : "+e.getMessage());
			e.printStackTrace();
		}
		
		}
		
	}
		
	public void autoExecuteVMStateChange(String vmName,int stateindex) throws Exception {
		VcoSession session;
		vROconfigModule();
		
		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl),
				vRoSSoID, vRoSSoPW);
		
		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);

		Workflow workflow = workflowService.getWorkflow(AUTODOWN_VM_STATE);
		ExecutionContext context = new ExecutionContextBuilder()
				.addParam("vmname", vmName)
				.addParam("select",stateindex).build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED,
					WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
		
	} 
		
	public void autoVMResourceChange(Vm_create vm_create) throws Exception {
		VcoSession session;
		vROconfigModule();
		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl),
				vRoSSoID,vRoSSoPW);
		
		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);
		
		Workflow workflow = workflowService.getWorkflow(AUTOVM_RESOURCE_CHANGE);
		ExecutionContext context = new ExecutionContextBuilder()
				.addParam("vmname", vm_create.getCr_vm_name())
				.addParam("vcpu",vm_create.getCr_cpu())
				.addParam("vmemory", vm_create.getCr_memory()).build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED,
					WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}
		
	}
		
	public int manualScaleVMCreate(Vm_create vm_create) throws Exception {
		//60.ManualScaleVMCreate
		VcoSession session;
		vROconfigModule();

		Boolean dhcpOnOff = true;
		
		if(vm_create.getCr_dhcp() == 1) {
			dhcpOnOff = true;
		}else if(vm_create.getCr_dhcp() == 2) {
			dhcpOnOff = false;
		}
		
		session = DefaultVcoSessionFactory.newLdapSession(new URI(vRoUrl), vRoSSoID, vRoSSoPW);

		WorkflowService workflowService = new WorkflowService(session);
		ExecutionService executionService = new ExecutionService(session);

		Workflow workflow = workflowService.getWorkflow(MANUAL_SCLAEOUT);
		ExecutionContext context = new ExecutionContextBuilder().addParam("ipAddress", vm_create.getCr_ipaddress())
				.addParam("vmname", vm_create.getCr_vm_name())
				.addParam("vmtemplate", vm_create.getCr_templet())
				.addParam("vCpu", vm_create.getCr_cpu())
				.addParam("vMem", vm_create.getCr_memory())
				.addParam("vHost", vm_create.getCr_host())
				.addParam("vDatastore", vm_create.getCr_storage())
				.addParam("vNetwork", vm_create.getCr_netWork()).addParam("service_id", vm_create.getVm_service_ID()).addParam("dhcp", dhcpOnOff).addParam("netmask", vm_create.getCr_netmask())
				.addParam("gatewayIn", vm_create.getCr_gateway()).build();
		WorkflowExecution execution = executionService.execute(workflow, context);
		try {
			execution = executionService.awaitState(execution, 500, 10, WorkflowExecutionState.CANCELED, WorkflowExecutionState.FAILED, WorkflowExecutionState.COMPLETED);
		} catch (InterruptedException e) {
			LOG.warn(e.getMessage());
			e.printStackTrace();
		}

		return 2;
	}
		
}
