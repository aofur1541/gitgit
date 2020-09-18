package com.kdis.PROM.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.apply.service.VMService;
import com.kdis.PROM.apply.vo.VMDataVO;
import com.kdis.PROM.common.CommonAPI;
import com.kdis.PROM.logic.Manualscale;
import com.kdis.PROM.logic.Vm_create;
import com.kdis.PROM.obj_environ.service.EnvironmentSetService;

@Controller
@RequestMapping("rest/*")
public class APIController {
	
	@Autowired
	private EnvironmentSetService environmentSetService;
	
	@Autowired
	private CommonAPI api; 

	/** 가상머신 서비스 */
	@Autowired
	private VMService vmService;
	
	private static final Log LOG = LogFactory.getLog( APIController.class );
	
	@RequestMapping(value = "rest/runManualScaleOut.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody int runManualScaleOut(@RequestBody Manualscale manualscale, HttpSession session) throws Exception {
		int result = 0;
		int nPostfix = 0;
		String col = "id";
		
		List<Manualscale> manualscaleDBInfo = environmentSetService.getManualScaleOutList(manualscale.getId(), col);

		col = "orderIP";
		
		LOG.warn("Manual Scale Out Action");

		VMDataVO templateOneInfo = vmService.selectVMData(manualscaleDBInfo.get(0).getTemplate_id());
		
		nPostfix = Integer.parseInt(manualscaleDBInfo.get(0).getPostfix()) + 1;
		
		Vm_create create = new Vm_create();
		
		create.setCr_vm_name(manualscale.getManualVMName());
		create.setCr_ipaddress(manualscale.getManualIP());
		create.setCr_templet(manualscaleDBInfo.get(0).getTemplate_ids());
		create.setCr_host(manualscale.getManualHost());
		create.setCr_storage(manualscale.getManualStorage());
		create.setCr_netWork(manualscale.getManualNetwork());
		create.setCr_cpu(Integer.toString(templateOneInfo.getVmCPU()));
		create.setCr_memory(Integer.toString(templateOneInfo.getVmMemory()));
		create.setCr_netmask(manualscaleDBInfo.get(0).getDefault_netmask());
		create.setCr_gateway(manualscaleDBInfo.get(0).getDefault_gateway());
		create.setVm_service_ID(Integer.toString(manualscaleDBInfo.get(0).getService_id()));
		create.setCr_dhcp(2);
		
		result = api.manualScaleVMCreate(create);
		templateOneInfo.setVmName(manualscaleDBInfo.get(0).getNaming()+nPostfix);
		environmentSetService.manualScaleOutPreVMUpdate(manualscaleDBInfo.get(0).getId(), templateOneInfo.getVmName(), nPostfix);

		return result;
	}
	
}
