package com.kdis.PROM.obj_environ.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.common.CommonUtil;
import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.logic.AutoScaleUp;
import com.kdis.PROM.logic.Manualscale;
import com.kdis.PROM.logic.Vm_data_info;
import com.kdis.PROM.logic.Vm_host_info;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.obj_environ.service.EnvironmentSetService;

@Controller
@RequestMapping("environ/*")
public class EnvironmentSetController {

	@Autowired
	private EnvironmentSetService environmentSetService;

	/** 이력 service */
	@Autowired
	private LogService logService;

	@RequestMapping("environ/getAutoScaleUpList.do")
	public @ResponseBody List<AutoScaleUp> getAutoScaleUpList() {

		List<AutoScaleUp> result = environmentSetService.getAutoScaleUpList();

		return result;
	}

	@RequestMapping("environ/getOneAutoScaleUp.do")
	public @ResponseBody List<AutoScaleUp> getOneAutoScaleUp(int id) {
		String col = "id";
		List<AutoScaleUp> result = environmentSetService.getAutoScaleUpList(id, col);
		return result;
	}

	@RequestMapping("environ/getVMsInService.do")
	public @ResponseBody List<Vm_data_info> getVMsInService(AutoScaleUp autoScaleUp) {

		List<Vm_data_info> result = environmentSetService.getVMsInService(autoScaleUp.getService_id());

		return result;
	}

	@RequestMapping("environ/getMaximumIPInService.do")
	public @ResponseBody List<Vm_data_info> getMaximumIPInService(Manualscale manualscale) {
		int lastIndex = 0;
		List<Vm_data_info> result = environmentSetService.getVMsInService(manualscale.getService_id(), manualscale.getStartIP(), manualscale.getEndIP());

		if (result.isEmpty()) {
			return null;
		} else {
			lastIndex = Integer.parseInt(result.get(0).getVm_ipaddr1().substring(result.get(0).getVm_ipaddr1().lastIndexOf('.') + 1)) + 1;
			result.get(0).setVm_ipaddr1(CommonUtil.replaceLast(result.get(0).getVm_ipaddr1(), result.get(0).getVm_ipaddr1().substring(result.get(0).getVm_ipaddr1().lastIndexOf('.') + 1), lastIndex + ""));
		}

		return result;
	}

	@RequestMapping("environ/getManualScaleOutList.do")
	public @ResponseBody List<Manualscale> getManualScaleOutList() {

		List<Manualscale> result = environmentSetService.getManualScaleOutList();

		return result;
	}

	@RequestMapping("environ/getOneManualScaleOut.do")
	public @ResponseBody List<Manualscale> getOneManualScaleOut(int id) {
		String col = "id";
		List<Manualscale> result = environmentSetService.getManualScaleOutList(id, col);

		return result;
	}

	@RequestMapping("environ/getLowestHostsInCluster.do")
	public @ResponseBody List<Vm_host_info> getLowestHostsInCluster(String clusterId) {
		List<Vm_host_info> result = environmentSetService.getLowestHostsInCluster(clusterId);
		return result;
	}

	@RequestMapping(value = "environ/upManualScaleOutInfo.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody int upManualScaleOutInfo(@RequestBody Manualscale manualscale, HttpSession session) {
		int result = 0;
		String col = "id";
		List<Manualscale> manualscaleDBInfo = environmentSetService.getManualScaleOutList(manualscale.getId(), col);

		String updatedBeforeLog = "";
		String updatedAfterLog = "";

		if (manualscale.getTemplate_id().equals(manualscaleDBInfo.get(0).getTemplate_id())) {
			updatedBeforeLog += ",소스 가상머신 : " + manualscaleDBInfo.get(0).getTemplate_ids();
			updatedAfterLog += ",소스 가상머신 : " + manualscale.getTemplate_ids();
		}

		if (manualscale.getNaming().equals(manualscaleDBInfo.get(0).getNaming())) {
			updatedBeforeLog += ",네이밍 : " + manualscaleDBInfo.get(0).getNaming();
			updatedAfterLog += ",네이밍 : " + manualscale.getNaming();
		}

		if (manualscale.getPostfix().equals(manualscaleDBInfo.get(0).getPostfix())) {
			updatedBeforeLog += ",포스트픽스 : " + manualscaleDBInfo.get(0).getPostfix();
			updatedAfterLog += ",포스트픽스 : " + manualscale.getPostfix();
		}

		if (manualscale.getStartIP().equals(manualscaleDBInfo.get(0).getStartIP())) {
			updatedBeforeLog += ",시작 IP : " + manualscaleDBInfo.get(0).getStartIP();
			updatedAfterLog += ",시작 IP : " + manualscale.getStartIP();
		}

		if (manualscale.getEndIP().equals(manualscaleDBInfo.get(0).getEndIP())) {
			updatedBeforeLog += ",끝 IP : " + manualscaleDBInfo.get(0).getEndIP();
			updatedAfterLog += ",끝 IP : " + manualscale.getEndIP();
		}

		if (updatedBeforeLog.startsWith(",")) {
			updatedBeforeLog = updatedBeforeLog.substring(1);
		}
		if (updatedAfterLog.startsWith(",")) {
			updatedAfterLog = updatedAfterLog.substring(1);
		}

		result = environmentSetService.upManualScaleOutInfo(manualscale);
		String sContext = "[수동스케일 아웃 수정 : " + manualscale.getService_ids() + "] " + updatedBeforeLog + " -> " + updatedAfterLog;
		if (updatedBeforeLog != "" && updatedAfterLog != "") {
			logService.insertLog(LoginSessionUtil.getStringLoginInfo(session, "sUserID"), 0, sContext, "수동스케일", "Update");
		}
		return result;
	}

	@RequestMapping(value = "environ/deleteManualScaleOutInfo.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody int deleteManualScaleOutInfo(@RequestBody Manualscale manualscale, HttpSession session) {
		int result = 0;
		String sContext = "[수동스케일 아웃 삭제 : " + manualscale.getService_ids() + "]";

		logService.insertLog(LoginSessionUtil.getStringLoginInfo(session, "sUserID"), 0, sContext, "수동스케일", "Delete");

		result = environmentSetService.deleteManualScaleOutInfo(manualscale);
		return result;
	}

	@RequestMapping(value = "environ/deleteAutoScaleUpInfo.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody int deleteAutoScaleUpInfo(@RequestBody AutoScaleUp autoScaleUp, HttpSession session) {
		int result = 0;
		String sContext = "[오토스케일 업 삭제 : " + autoScaleUp.getService_ids() + "]";

		logService.insertLog(LoginSessionUtil.getStringLoginInfo(session, "sUserID"), 0, sContext, "오토스케일", "Delete");

		result = environmentSetService.deleteAutoScaleUpInfo(autoScaleUp);
		return result;
	}

	@RequestMapping(value = "environ/upAutoScaleUpInfo.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody int upAutoScaleUpInfo(@RequestBody AutoScaleUp autoScaleUp, HttpSession session) {
		int result = 0;
		String col = "id";
		List<AutoScaleUp> autoScaleUpDBInfo = environmentSetService.getAutoScaleUpList(autoScaleUp.getId(), col);
		col = "service_id";
		List<AutoScaleUp> overlapChkAutoScale = environmentSetService.getAutoScaleUpList(autoScaleUp.getService_id(), col);

		if (!overlapChkAutoScale.isEmpty() && autoScaleUp.getService_id() != overlapChkAutoScale.get(0).getService_id()) {
			result = 2;
		} else {

			String updatedBeforeLog = "";
			String updatedAfterLog = "";

			if (autoScaleUp.getService_id() != autoScaleUpDBInfo.get(0).getService_id()) {
				updatedBeforeLog += ",서비스 : " + autoScaleUpDBInfo.get(0).getService_ids();
				updatedAfterLog += ",서비스 : " + autoScaleUp.getService_ids();
			}

			if (autoScaleUp.getCpuUp() != autoScaleUpDBInfo.get(0).getCpuUp()) {
				updatedBeforeLog += ",CPU Up : " + autoScaleUpDBInfo.get(0).getCpuUp();
				updatedAfterLog += ",CPU Up : " + autoScaleUp.getCpuUp();
			}

			if (autoScaleUp.getMemoryUp() != autoScaleUpDBInfo.get(0).getMemoryUp()) {
				updatedBeforeLog += ",Memory Up : " + autoScaleUpDBInfo.get(0).getMemoryUp();
				updatedAfterLog += ",Memory Up : " + autoScaleUp.getMemoryUp();
			}

			if (autoScaleUp.getCpuAdd() != autoScaleUpDBInfo.get(0).getCpuAdd()) {
				updatedBeforeLog += ",CPU 추가 개수 : " + autoScaleUpDBInfo.get(0).getCpuAdd();
				updatedAfterLog += ",CPU 추가 개수 : " + autoScaleUp.getCpuAdd();
			}

			if (autoScaleUp.getMemoryAdd() != autoScaleUpDBInfo.get(0).getMemoryAdd()) {
				updatedBeforeLog += ",Memory 추가 개수 : " + autoScaleUpDBInfo.get(0).getMemoryAdd();
				updatedAfterLog += ",Memory 추가 개수 : " + autoScaleUp.getMemoryAdd();
			}

			if (autoScaleUp.getIsUse() != autoScaleUpDBInfo.get(0).getIsUse()) {

				/*
				 * if(overlapChkAutoScale.get(0).getIsUse() == 0 && autoScaleUp.getIsUse() == 1)
				 * { autoScaleUp.autoScaleStatusUpdate(autoScaleUp.getId(),0,col); }
				 */

				if (autoScaleUpDBInfo.get(0).getIsUse() == 1) {
					updatedBeforeLog += ",사용 여부 : 사용";
				} else if (autoScaleUpDBInfo.get(0).getIsUse() == 0) {
					updatedBeforeLog += ",사용 여부 : 미사용";
				}

				if (autoScaleUp.getIsUse() == 1) {
					updatedAfterLog += ",사용 여부 : 사용";
				} else if (autoScaleUp.getIsUse() == 0) {
					updatedAfterLog += ",사용 여부 : 미사용";
				}
			}

			if (updatedBeforeLog.startsWith(",")) {
				updatedBeforeLog = updatedBeforeLog.substring(1);
			}
			if (updatedAfterLog.startsWith(",")) {
				updatedAfterLog = updatedAfterLog.substring(1);
			}

			result = environmentSetService.upAutoScaleUpInfo(autoScaleUp);
			String sContext = "[오토스케일 업 수정 : " + autoScaleUp.getService_ids() + "] " + updatedBeforeLog + " -> " + updatedAfterLog;
			if (updatedBeforeLog != "" && updatedAfterLog != "") {
				logService.insertLog(LoginSessionUtil.getStringLoginInfo(session, "sUserID"), 0, sContext, "오토스케일", "Update");
			}
		}
		return result;
	}

	@RequestMapping(value = "environ/setAutoScaleUpInfo.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody int setAutoScaleUpInfo(@RequestBody AutoScaleUp autoScaleUp, HttpSession session) {
		int result = 0;
		String col = "service_id";
		List<AutoScaleUp> overlapChkAutoScale = environmentSetService.getAutoScaleUpList(autoScaleUp.getService_id(), col);
		if (!overlapChkAutoScale.isEmpty()) {
			result = 2;
		} else {
			result = environmentSetService.setAutoScaleUp(autoScaleUp);
			String sContext = "[오토스케일 업 적용 : " + autoScaleUp.getService_ids() + "] ";
			sContext += " 서비스 : " + autoScaleUp.getService_ids() + ",";
			sContext += " CPU Up : " + autoScaleUp.getCpuUp() + "%,";
			sContext += " Memory Up : " + autoScaleUp.getMemoryUp() + "%,";
			sContext += " CPU Add : " + autoScaleUp.getCpuAdd() + "%,";
			sContext += " Memory Add : " + autoScaleUp.getMemoryAdd() + "%,";
			sContext += " 대기 시간 : " + autoScaleUp.getWaiting() + ",";
			if (autoScaleUp.getIsUse() == 0) {
				sContext += " 사용여부 : 미사용";
			} else if (autoScaleUp.getIsUse() == 1) {
				sContext += " 사용여부 : 사용";
			}

			logService.insertLog(LoginSessionUtil.getStringLoginInfo(session, "sUserID"), 0, sContext, "오토스케일", "Create");

		}

		return result;
	}

	@RequestMapping(value = "environ/setManualScaleOutInfo.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody int setManualScaleOutInfo(@RequestBody Manualscale manualscale, HttpSession session) {
		int result = 0;

		result = environmentSetService.setManualScaleOutInfo(manualscale);
		String sContext = "[수동스케일 아웃 적용 : " + manualscale.getService_ids() + "] ";
		sContext += " 서비스 : " + manualscale.getService_ids() + ",";
		sContext += " 네이밍 : " + manualscale.getNaming() + "%,";
		sContext += " 포스트픽스 : " + manualscale.getPostfix() + "%,";
		sContext += " 시작 IP : " + manualscale.getStartIP() + "%,";
		sContext += " 끝 IP : " + manualscale.getEndIP() + "%,";

		logService.insertLog(LoginSessionUtil.getStringLoginInfo(session, "sUserID"), 0, sContext, "수동스케일", "Create");

		return result;
	}

	//@Scheduled Zone
	
	//AutoScale Up
	/*@Scheduled(fixedDelay = 30 * 1000)
	public void autoScaleUpUseChk() throws Exception {
		String col = "isUse";
		int cpuAvg = 0;
		int memAvg = 0;
		Boolean action = false;
		List<AutoScaleUp> getResult = environmentSetService.getAutoScaleUpList(1, col);

		if (!getResult.isEmpty()) {
			LOG.warn("Scale Up Checking Up Auto Scale...");
			for (int i = 0; i < getResult.size(); i++) {

				List<Vm_data_info> serviceInVMs = environmentSetService.getVMsInService(getResult.get(i).getService_id());

				if (serviceInVMs.isEmpty()) {
					LOG.warn("autoScaleUpUseChk Method Scale Up Failed : 1.autoScaleUpUseChk serviceInVMs Object is empty ");
				} else {

					HashMap<String, Object> getServiceInVMvalChk = menuservice.getServiceInVMvalChk(getResult.get(i).getService_id());
					if (getServiceInVMvalChk == null || getServiceInVMvalChk.isEmpty()) {
						LOG.warn("autoScaleUpUseChk Method Scale Up Failed : 2.getServiceInVMvalChk VMs value is null");
					} else {
						cpuAvg = (int) Math.round((Double) getServiceInVMvalChk.get("cpuAvg"));
						memAvg = (int) Math.round((Double) getServiceInVMvalChk.get("memAvg"));
					}

					if (cpuAvg > getResult.get(i).getCpuUp() || memAvg > getResult.get(i).getMemoryUp()) {
						action = true;
					} else {
						action = false;
					}

					LocalDateTime currentDateTime = LocalDateTime.now();
					LocalDateTime waitingTime = LocalDateTime.ofInstant(getResult.get(i).getUpdated_on().toInstant(), ZoneId.systemDefault());

					if (action && currentDateTime.isAfter(waitingTime)) {
						LOG.warn("Autoscale Up Action : Service - " + getResult.get(i).getService_ids() + " CPU usage -" + cpuAvg + "%, Memory usage -" + memAvg + "%");
						environmentSetService.upAutoScaleStatus(getResult.get(i).getId(), getResult.get(i).getWaiting(), 1);
						int cpuAdd = getResult.get(i).getCpuAdd();
						int memoryAdd = getResult.get(i).getMemoryAdd();
						for (Vm_data_info key : serviceInVMs) {
							int sumCPU = key.getVm_cpu() + cpuAdd;
							int sumMemory = key.getVm_memory() + memoryAdd;

							if (key.getHostCPU() < sumCPU || key.getHostMemory() < sumMemory) {
								LOG.warn("autoScaleUpUseChk Method Scale Up Failed : 3.VM " + key.getVm_name() + " Resource change failed : resource has exceeded the host's resource.");
							} else if (key.getVm_memory() <= 3) {
								LOG.warn("autoScaleUpUseChk Method Scale Up Failed : 4.VM " + key.getVm_name() + " Resource change failed : Less than 4GB of memory.");
							} else {
								Vm_create changeVMResource = new Vm_create();
								changeVMResource.setCr_vm_name(key.getVm_name());
								changeVMResource.setCr_cpu(Integer.toString(sumCPU));
								changeVMResource.setCr_memory(Integer.toString(sumMemory));
								api.autoVMResourceChange(changeVMResource);
								LOG.warn("Autoscale Up Action : VM " + key.getVm_name() + " Resource change Action");
								Thread.sleep(1000);
							}

						} //for end
						action = false;
					}
				}
			}
		}}*/

	

}
