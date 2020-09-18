package com.kdis.PROM.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.async.DeferredResult;

import com.kdis.PROM.apply.service.VMService;
import com.kdis.PROM.apply.vo.VMDataVO;
import com.kdis.PROM.common.CommonAPI;
import com.kdis.PROM.common.CommonUtil;
import com.kdis.PROM.common.Constants;
import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.log.vo.LogVO;
import com.kdis.PROM.logic.AutoScale;
import com.kdis.PROM.logic.Metering;
import com.kdis.PROM.logic.MeteringSum;
import com.kdis.PROM.logic.MeteringVMs;
import com.kdis.PROM.logic.MmonitoringJoin;

import com.kdis.PROM.logic.VmOneDetail;
import com.kdis.PROM.logic.Vm_data_info;
import com.kdis.PROM.logic.Vm_service;
import com.kdis.PROM.logic.Vm_service_graph;
import com.kdis.PROM.logic.Vm_storage;
import com.kdis.PROM.logic.WorkflowStatus;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.obj_common.service.CommonService;
import com.kdis.PROM.service.MenuService;
import com.kdis.PROM.tenant.service.TenantService;
import com.kdis.PROM.tenant.service.VMServiceService;
import com.kdis.PROM.tenant.vo.VMServiceVO;
import com.kdis.PROM.user.vo.UserVO;

@Controller
public class JqueryController {

	@Autowired
	private MenuService menuservice;

	@Autowired
	private CommonAPI api;
	
	/** 테넌트 서비스 */
	@Autowired
	private TenantService tenantService;
	
	/** 서비스 서비스 */
	@Autowired
	private VMServiceService vmServiceService;

	/** 가상머신 서비스 */
	@Autowired
	private VMService vmService;
	
	/** 이력 service */
	@Autowired
	private LogService logService;
	
	@Autowired
	CommonService commonService;

	private static final Log LOG = LogFactory.getLog(JqueryController.class);

	final String DATE_PATTERN = "yyyy-MM-dd";

	@RequestMapping("jquery/getTenantsInServiceOfVMs.do")
	public @ResponseBody List<Vm_data_info> getTenantsInServiceOfVMs(Integer serviceID, Integer tenantsID) {
		List<Vm_data_info> result = menuservice.getTenantsInServiceOfVMs(serviceID, tenantsID);
		return result;
	}

	@RequestMapping("jquery/getUserMeteringService.do")
	public @ResponseBody List<MmonitoringJoin> getUserMeteringService(HttpSession session) {
		int id = tenantService.getLoginUserTenantId(session);
		List<MmonitoringJoin> result = menuservice.getUserMeteringService(id);
		return result;
	}

	@RequestMapping("jquery/notAuthorityCheck.do")
	public @ResponseBody int notAuthorityCheck(HttpSession session) {
		int id = tenantService.getLoginUserTenantId(session);
		int result = 0;
		if (id == 0) {
			result = 1;
		} else {
			result = 2;
		}

		return result;
	}

	@RequestMapping("jquery/getTenantVM.do")
	public @ResponseBody HashMap<String, Object> getTenantVM(HttpSession session) {
		int id = tenantService.getLoginUserTenantId(session);
		HashMap<String, Object> result = menuservice.getTenantVM(id);
		return result;
	}

	@RequestMapping("jquery/getTenantlowerRank.do")
	public @ResponseBody List<Vm_service> getTenantlowerRank(HttpSession session) {
		int id = tenantService.getLoginUserTenantId(session);

		List<Vm_service> result = null;
		result = menuservice.getTenantlowerRank(id);
		return result;
	}

	@RequestMapping("jquery/getServiceRealTimeTotalCnt.do")
	public @ResponseBody HashMap<String, Object> getServiceRealTimeTotalCnt() {
		HashMap<String, Object> result = null;
		result = menuservice.serviceCount();
		return result;
	}

	@RequestMapping("jquery/getWorkflowStateList.do")
	public @ResponseBody List<WorkflowStatus> getWorkflowStateList() {
		List<WorkflowStatus> result = null;
		result = menuservice.getWorkflowStateList();
		return result;
	}

	@RequestMapping("jquery/undeployedautoFilter.do")
	public @ResponseBody List<Vm_data_info> undeployedautoFilter(String inputed, String order, String orderSwitch) {
		if (order == null) {
			order = "vm_name";
		}
		List<Vm_data_info> result = menuservice.undeployedautoFilter(inputed, order, orderSwitch);
		return result;
	}

	@RequestMapping("jquery/autoFilter.do")
	public @ResponseBody List<MmonitoringJoin> autoFilter(String inputed) {
		List<MmonitoringJoin> result = menuservice.autoFilter(inputed);
		return result;
	}

	@RequestMapping("jquery/autoSearchTenantsInServiceVMs.do")
	public @ResponseBody List<Vm_data_info> autoSearchTenantsInServiceVMs(int serviceID, int tenantsID, String inputed) {
		List<Vm_data_info> result = null;
		if (serviceID == 0) {
			result = null;
		} else {
			result = menuservice.autoSearchTenantsInServiceVMs(serviceID, tenantsID, inputed);
		}
		return result;
	}

	@RequestMapping("jquery/chartData.do")
	public @ResponseBody DeferredResult<Object> chartData() throws InterruptedException {
		DeferredResult<Object> deferredsult = new DeferredResult<>();
		deferredsult.setResult(menuservice.tempCount());
		Thread.sleep(2000);
		return deferredsult;
	}

	@RequestMapping("jquery/dateCalc.do")
	public @ResponseBody ArrayList<String> dateCalc(String vmUsageStartDatetime, String vmUsageEndDatetime) throws ParseException {

		SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
		Date startDate = sdf.parse(vmUsageStartDatetime);
		Date endDate = sdf.parse(vmUsageEndDatetime);
		Date now = new Date();
		String formatNow = sdf.format(now);
		Date current = sdf.parse(formatNow);
		Calendar cal = Calendar.getInstance();

		ArrayList<String> dates = new ArrayList<String>();
		cal.setTime(current);
		cal.add(Calendar.YEAR, -1);
		if (startDate.compareTo(cal.getTime()) == -1) {
			dates.add("yearError");
		} else {
			Date currentDate = startDate;
			while (currentDate.compareTo(endDate) <= 0) {
				dates.add(sdf.format(currentDate));
				Calendar c = Calendar.getInstance();
				c.setTime(currentDate);
				c.add(Calendar.DAY_OF_MONTH, 1);
				currentDate = c.getTime();
			}
		}

		if (endDate.compareTo(current) > 0) {
			dates = null;
		}
		return dates;
	}

	@RequestMapping("jquery/getAllvmInfo.do")
	public @ResponseBody List<Vm_data_info> getAllvmInfo() {
		List<Vm_data_info> result = menuservice.getAllvmInfo();
		return result;
	}

	@RequestMapping("jquery/getClusterinHostInfoinVM.do")
	public @ResponseBody List<Vm_data_info> getClusterinHostInfoinVM(String hostName) {
		List<Vm_data_info> result = menuservice.getClusterinHostInfoinVM(hostName);
		return result;
	}

	@RequestMapping("jquery/getSearchServiceInVM.do")
	public @ResponseBody List<Vm_data_info> getSearchServiceInVM(String inputed, int choiceServiceID) {
		List<Vm_data_info> result = menuservice.getSearchServiceInVM(inputed, choiceServiceID);
		return result;
	}

	@RequestMapping("jquery/getVMID.do")
	public @ResponseBody List<Vm_data_info> getVMID(String vm_name) {
		List<Vm_data_info> result = menuservice.getVMID(vm_name);
		return result;
	}

	@RequestMapping("jquery/getVMoslinuxListSearch.do")
	public @ResponseBody List<Vm_data_info> getVMoslinuxListSearch(String inputed) {
		List<Vm_data_info> result = menuservice.getVMoslinuxListSearch(inputed);
		return result;
	}

	@RequestMapping(value = "jquery/autoScaleDelete.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody int autoScaleDelete(@RequestBody AutoScale autoScale, HttpSession session, LogVO notification) {
		int result = 0;
		notification.setsReceive(LoginSessionUtil.getStringLoginInfo(session, "sUserID"));
		String sContext = "[오토스케일 아웃 삭제 : " + autoScale.getServiceName() + "]";
		notification.setsContext(sContext);
		notification.setsTarget("오토스케일");
		notification.setnCategory(0);
		notification.setsKeyword("Delete");
		logService.insertLog(notification);
		result = menuservice.autoScaleDelete(autoScale);
		return result;
	}

	@RequestMapping(value = "jquery/autoScaleUpdate.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody int autoScaleUpdate(@RequestBody AutoScale autoScale, HttpSession session, LogVO notification) {
		int result = 0;
		String col = "id";
		List<AutoScale> overlapChkAutoScale = menuservice.getAutoScaleList(autoScale.getId(), col);
		col = "service_id";
		List<AutoScale> overlapChkServiceAutoScale = menuservice.getAutoScaleList(autoScale.getService_id(), col);
		col = "next_vm";
		if (!overlapChkServiceAutoScale.isEmpty() && autoScale.getService_id() != overlapChkAutoScale.get(0).getService_id()) {
			result = 2;
		} else {

			String updatedBeforeLog = "";
			String updatedAfterLog = "";

			if (autoScale.getService_id() != overlapChkAutoScale.get(0).getService_id()) {
				updatedBeforeLog += ",서비스 : " + overlapChkAutoScale.get(0).getServiceName();
				updatedAfterLog += ",서비스 : " + autoScale.getService_ids();
			}

			if (autoScale.getCpuUp() != overlapChkAutoScale.get(0).getCpuUp()) {
				updatedBeforeLog += ",CPU Up : " + overlapChkAutoScale.get(0).getCpuUp();
				updatedAfterLog += ",CPU Up : " + autoScale.getCpuUp();
			}

			if (autoScale.getMemoryUp() != overlapChkAutoScale.get(0).getMemoryUp()) {
				updatedBeforeLog += ",Memory Up : " + overlapChkAutoScale.get(0).getMemoryUp();
				updatedAfterLog += ",Memory Up : " + autoScale.getMemoryUp();
			}

			if (autoScale.getCpuDown() != overlapChkAutoScale.get(0).getCpuDown()) {
				updatedBeforeLog += ",CPU Down : " + overlapChkAutoScale.get(0).getCpuDown();
				updatedAfterLog += ",CPU Down : " + autoScale.getCpuDown();
			}

			if (autoScale.getMemoryDown() != overlapChkAutoScale.get(0).getMemoryDown()) {
				updatedBeforeLog += ",Memory Down : " + overlapChkAutoScale.get(0).getMemoryDown();
				updatedAfterLog += ",Memory Down : " + autoScale.getMemoryDown();
			}

			if (autoScale.getMinVM() != overlapChkAutoScale.get(0).getMinVM()) {
				updatedBeforeLog += ",최소 가상머신 수 : " + overlapChkAutoScale.get(0).getMinVM();
				updatedAfterLog += ",최소 가상머신 수 : " + autoScale.getMinVM();
			}

			if (autoScale.getMaxVM() != overlapChkAutoScale.get(0).getMaxVM()) {
				updatedBeforeLog += ",최대 가상머신 수 : " + overlapChkAutoScale.get(0).getMaxVM();
				updatedAfterLog += ",최대 가상머신 수 : " + autoScale.getMaxVM();
			}

			if (!autoScale.getNaming().equals(overlapChkAutoScale.get(0).getNaming())) {
				updatedBeforeLog += ",네이밍 : " + overlapChkAutoScale.get(0).getNaming();
				updatedAfterLog += ",네이밍 : " + autoScale.getNaming();
			}

			if (!autoScale.getStartIP().equals(overlapChkAutoScale.get(0).getStartIP())) {
				updatedBeforeLog += ",시작 IP : " + overlapChkAutoScale.get(0).getStartIP();
				updatedAfterLog += ",시작 IP : " + autoScale.getStartIP();
			}

			if (!autoScale.getEndIP().equals(overlapChkAutoScale.get(0).getEndIP())) {
				updatedBeforeLog += ",끝 IP : " + overlapChkAutoScale.get(0).getEndIP();
				updatedAfterLog += ",끝 IP : " + autoScale.getEndIP();
			}

			if (autoScale.getIsUse() != overlapChkAutoScale.get(0).getIsUse()) {

				if (overlapChkAutoScale.get(0).getIsUse() == 0 && autoScale.getIsUse() == 1) {
					menuservice.autoScaleStatusUpdate(autoScale.getId(), 0, col);
				}

				if (overlapChkAutoScale.get(0).getIsUse() == 1) {
					updatedBeforeLog += ",사용 여부 : 사용";
				} else if (overlapChkAutoScale.get(0).getIsUse() == 0) {
					updatedBeforeLog += ",사용 여부 : 미사용";
				}

				if (autoScale.getIsUse() == 1) {
					updatedAfterLog += ",사용 여부 : 사용";
				} else if (autoScale.getIsUse() == 0) {
					updatedAfterLog += ",사용 여부 : 미사용";
				}
			}

			if (!autoScale.getTemplate_id().equals(overlapChkAutoScale.get(0).getTemplate_id())) {
				updatedBeforeLog += ",템플릿 : " + overlapChkAutoScale.get(0).getVmName();
				updatedAfterLog += ",템플릿 : " + autoScale.getTemplate_ids();
			}

			if (updatedBeforeLog.startsWith(",")) {
				updatedBeforeLog = updatedBeforeLog.substring(1);
			}
			if (updatedAfterLog.startsWith(",")) {
				updatedAfterLog = updatedAfterLog.substring(1);
			}

			result = menuservice.autoScaleUpdate(autoScale);
			notification.setsReceive(LoginSessionUtil.getStringLoginInfo(session, "sUserID"));
			String sContext = "[오토스케일 아웃 수정 : " + overlapChkAutoScale.get(0).getServiceName() + "] " + updatedBeforeLog + " -> " + updatedAfterLog;
			notification.setsContext(sContext);
			notification.setsTarget("오토스케일");
			notification.setnCategory(0);
			notification.setsKeyword("Update");
			if (updatedBeforeLog != "" && updatedAfterLog != "") {
				logService.insertLog(notification);
			}
		}
		return result;
	}

	@RequestMapping("jquery/getAutoScaleOneinfo.do")
	public @ResponseBody List<AutoScale> getAutoScaleOneinfo(int id) {
		String col = "id";
		List<AutoScale> result = menuservice.getAutoScaleList(id, col);
		return result;
	}

	@RequestMapping("jquery/getAutoScaleList.do")
	public @ResponseBody List<AutoScale> getAutoScaleList() {
		List<AutoScale> result = menuservice.getAutoScaleList();
		return result;
	}

	@RequestMapping(value = "jquery/autoScaleInsert.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public @ResponseBody int autoScaleInsert(@RequestBody AutoScale vm_autoScale, HttpSession session, LogVO notification) {
		int result = 0;
		String col = "service_id";
		List<AutoScale> overlapChkAutoScale = menuservice.getAutoScaleList(vm_autoScale.getService_id(), col);
		if (!overlapChkAutoScale.isEmpty()) {
			result = 2;
		} else {
			result = menuservice.autoScaleInsert(vm_autoScale);
			notification.setsReceive(LoginSessionUtil.getStringLoginInfo(session, "sUserID"));
			String sContext = "[오토스케일 아웃 적용 : " + vm_autoScale.getService_ids() + "] ";
			sContext += " 서비스 : " + vm_autoScale.getService_ids() + ",";
			sContext += " CPU Up : " + vm_autoScale.getCpuUp() + "%,";
			sContext += " Memory Up : " + vm_autoScale.getMemoryUp() + "%,";
			sContext += " CPU Down : " + vm_autoScale.getCpuDown() + "%,";
			sContext += " Memory Down : " + vm_autoScale.getMemoryDown() + "%,";
			sContext += " 최소 가상머신 수 : " + vm_autoScale.getMinVM() + "개,";
			sContext += " 최대 가상머신 수 : " + vm_autoScale.getMaxVM() + "개,";
			sContext += " 네이밍 : " + vm_autoScale.getNaming() + ",";
			sContext += " 포스트픽스 : " + vm_autoScale.getPostfix() + ",";
			sContext += " 시작 IP : " + vm_autoScale.getStartIP() + ",";
			sContext += " 끝 IP : " + vm_autoScale.getEndIP() + ",";
			if (vm_autoScale.getIsUse() == 0) {
				sContext += " 사용여부 : 미사용,";
			} else if (vm_autoScale.getIsUse() == 1) {
				sContext += " 사용여부 : 사용,";
			}
			sContext += " 템플릿 : " + vm_autoScale.getTemplate_ids() + "";

			notification.setsContext(sContext);
			notification.setsTarget("오토스케일");
			notification.setnCategory(0);
			notification.setsKeyword("Create");
			logService.insertLog(notification);
		}
		return result;
	}

	@RequestMapping("jquery/vmUseAutoScaleCheck.do")
	public @ResponseBody List<MmonitoringJoin> vmUseAutoScaleCheck() {
		List<MmonitoringJoin> result = menuservice.vmUseAutoScaleCheck();
		return result;
	}

	@RequestMapping("jquery/useDataStoreOrderby.do")
	public @ResponseBody List<Vm_storage> useDataStoreOrderby() {
		List<Vm_storage> storageResult = menuservice.storageUseList();
		return storageResult;
	}

	@RequestMapping("jquery/vmDetailNotService.do")
	public @ResponseBody List<Vm_data_info> vmDetailNotService() {
		List<Vm_data_info> result = menuservice.vmDetailNotService();
		return result;
	}

	@RequestMapping("jquery/vmDetailService.do")
	public @ResponseBody List<VmOneDetail> vmDetailService(int vm_service_ID) {
		List<VmOneDetail> result = menuservice.vmDetailService(vm_service_ID);
		return result;
	}

	@RequestMapping("jquery/getApprovalCheckcnt.do")
	public @ResponseBody HashMap<String, Object> getApprovalCheckcnt(UserVO sdsc_user, HttpSession session) {
		HashMap<String, Object> result = null;
		int stage = vmService.getStage();
		int stageDown = stage - 1;
		if (sdsc_user.getnApproval() != Constants.USER_NUMBER) {
			result = menuservice.getApprovalCheckcnt(stageDown);
		}
		return result;
	}

	public String getAvailableIP(List<Vm_data_info> dataInfo, int index) {
		String lastIPval = null;
		String cacheIP = null;
		int lastIndex = 0;

		if (dataInfo.get(0).getVm_ipaddr1() != null) {
			cacheIP = dataInfo.get(0).getVm_ipaddr1();
		} else if (dataInfo.get(0).getVm_ipaddr2() != null) {
			cacheIP = dataInfo.get(0).getVm_ipaddr2();
		} else if (dataInfo.get(0).getVm_ipaddr3() != null) {
			cacheIP = dataInfo.get(0).getVm_ipaddr3();
		} else {

		}
		if (cacheIP != null) {
			if (index == 1) {
				lastIndex = Integer.parseInt(cacheIP.substring(cacheIP.lastIndexOf('.') + 1)) + 1;
			} else if (index == 2) {
				lastIndex = Integer.parseInt(cacheIP.substring(cacheIP.lastIndexOf('.') + 1)) - 1;
			} else if (index == 3) {
				lastIndex = Integer.parseInt(cacheIP.substring(cacheIP.lastIndexOf('.') + 1));
			}
			lastIPval = CommonUtil.replaceLast(cacheIP, cacheIP.substring(cacheIP.lastIndexOf('.') + 1), lastIndex + "");
		}

		return lastIPval;
	}

	
	//@Scheduled Zone
	
	//AutoScale Out/In
	@Scheduled(fixedDelay = 30 * 1000)
	public void autoScaleOutUseChk() throws Exception {

		String col = "isUse";
		String namingAdd = null;
		String prenamingAdd = null;
		String avIP = null;
		VMDataVO vmOneInfo = null;
		int nPostfix = 0;
		int nMinPostfix = 0;
		int cpuAvg = 0;
		int memAvg = 0;
		List<AutoScale> getResult = menuservice.getAutoScaleList(1, col);

		if (!getResult.isEmpty()) { // 오토스케일 사용여부 체크
			LOG.warn("Scale Out/In Checking Out Auto Scale...");
			for (int i = 0; i < getResult.size(); i++) { // 사용하는게 다수일시 반복

				col = "status";
				List<Vm_data_info> maxChk = menuservice.service_INVMlist(getResult.get(i).getService_id());
				List<Vm_data_info> minChk = menuservice.service_INVMlist(getResult.get(i).getService_id(), col);
				if (!maxChk.isEmpty()) {
					VMServiceVO serviceVO = vmServiceService.selectVMService(getResult.get(i).getService_id());
					HashMap<String, Object> getServiceInVMvalChk = menuservice.getServiceInVMvalChk(getResult.get(i).getService_id());
					if (getServiceInVMvalChk != null) {
						cpuAvg = (int) Math.round((Double) getServiceInVMvalChk.get("cpuAvg"));
						memAvg = (int) Math.round((Double) getServiceInVMvalChk.get("memAvg"));
					} else {
						LOG.warn("autoScaleOutUseChk Method Autoscale Out/In failed : 1.getServiceInVMvalChk VMs value is null");
					}
					col = "limitChk";
					List<Vm_data_info> limitChk = menuservice.getTenantsInServiceOfVMs(getResult.get(i).getService_id(), col);
					if (limitChk.isEmpty()) {
						vmOneInfo = null;
					} else {
						vmOneInfo = vmService.selectVMData(limitChk.get(0).getVm_ID());
					}
					nMinPostfix = Integer.parseInt(getResult.get(i).getPostfix()) - 1;
					String ticket = getResult.get(i).getPostfix();
					String minticket = nMinPostfix + "";

					vmOneInfo.setVmName(getResult.get(i).getNaming());

					namingAdd = vmOneInfo.getVmName() + ticket;
					prenamingAdd = vmOneInfo.getVmName() + minticket;

					if (getResult.get(i).getStatus() == 1) {
						Vm_data_info vmSpec = menuservice.getVMoneinfoName(getResult.get(i).getNext_vm());
						if (getResult.get(i).getMaxVM() == maxChk.size()) {
							menuservice.autoScaleStatusUpdate(getResult.get(i).getId(), 0);
						}
						if (vmSpec != null) {
							if (vmSpec.getVm_ipaddr1() != null || vmSpec.getVm_ipaddr2() != null || vmSpec.getVm_ipaddr3() != null) {
								menuservice.autoScaleStatusUpdate(getResult.get(i).getId(), 0);
							}

						}
					} else if (getResult.get(i).getStatus() == 2) {
						avIP = getAvailableIP(limitChk, 2);
						if (getResult.get(i).getMinVM() == minChk.size()) {
							menuservice.autoScaleStatusUpdate(getResult.get(i).getId(), 0);
						}
						Vm_data_info vmSpec = menuservice.getVMoneinfoName(prenamingAdd);
						if (vmSpec != null) {
							if (vmSpec.getVm_ipaddr1() != null || vmSpec.getVm_ipaddr2() != null || vmSpec.getVm_ipaddr3() != null) {
								menuservice.autoScaleStatusUpdate(getResult.get(i).getId(), 0);
							}
						}
					}

					if (cpuAvg > getResult.get(i).getCpuUp() || memAvg > getResult.get(i).getMemoryUp()) { //맥스 VM을 넘지 않아야함.
						if (!getServiceInVMvalChk.isEmpty() && getResult.get(i).getStatus() == 0) {
							if (getResult.get(i).getMaxVM() > maxChk.size()) { // Up
								avIP = getAvailableIP(limitChk, 1);
								LOG.warn("Auto scale Out Action" + " At the time of operation CPU [" + cpuAvg + "] At the time of operation MEM [" + memAvg + "]");

								VMDataVO templateOneInfo = vmService.selectVMData(getResult.get(i).getTemplate_id());
								
								nPostfix = Integer.parseInt(getResult.get(i).getPostfix()) + 1;
								vmOneInfo.setVmName(namingAdd);
								api.autoScaleworkflow(vmOneInfo, serviceVO, avIP, templateOneInfo.getVmName());
								menuservice.autoScalePreVMUpdate(getResult.get(i).getId(), vmOneInfo.getVmName(), nPostfix);
								menuservice.autoScaleStatusUpdate(getResult.get(i).getId(), 1);
							}
						}
					} else if (cpuAvg < getResult.get(i).getCpuDown() || memAvg < getResult.get(i).getMemoryDown()) {
						if (getServiceInVMvalChk != null && getResult.get(i).getStatus() == 0 && !getServiceInVMvalChk.isEmpty()) {
							if (getResult.get(i).getMinVM() < minChk.size()) {
								LOG.warn("Auto scale In Action" + " At the time of operation CPU " + cpuAvg + " At the time of operation MEM " + memAvg);
								avIP = getAvailableIP(limitChk, 2);
								nPostfix = Integer.parseInt(getResult.get(i).getPostfix()) - 1;
								vmOneInfo.setVmName(getResult.get(i).getNaming() + nPostfix);
								api.autoExecuteVMStateChange(vmOneInfo.getVmName(), 4);
								menuservice.autoScalePreVMUpdate(getResult.get(i).getId(), vmOneInfo.getVmName(), nPostfix);
								menuservice.autoScaleStatusUpdate(getResult.get(i).getId(), 2);
							}
						} else if (getServiceInVMvalChk == null || getServiceInVMvalChk.isEmpty()) {
							LOG.warn("autoScaleOutUseChk Method Autoscale Out/In failed : 2.getServiceInVMval.isEmpty()");
						}
					}
				} else {
					LOG.warn("autoScaleOutUseChk Method Autoscale Out/In failed : 3.Target none Service Of empty VMs");
				}
			}
		}
	}

	@Scheduled(cron = "0 57 23 * * ?")
	@RequestMapping("jquery/DashServiceGraphInsert.do")
	public @ResponseBody void DS() {
		HashMap<String, Object> result = new HashMap<>();
		Vm_service_graph vm_service_graph = new Vm_service_graph();

		result = menuservice.serviceCount();
		vm_service_graph.setnServiceCount(((Long) result.get("nServiceCount")).intValue());
		vm_service_graph.setnFreeVMCount(((Long) result.get("nFreeVMCount")).intValue());
		vm_service_graph.setnVMCount(((Long) result.get("nVMCount")).intValue());
		menuservice.service_graph(vm_service_graph);
	}

	@Scheduled(cron = "0 58 23 * * ?")
	@RequestMapping("jquery/TotalMetering.do")
	public @ResponseBody void TotalMetering() {
		MeteringSum meteringSum = new MeteringSum();
		List<VMServiceVO> serviceList = vmServiceService.selectVMServiceList(new VMServiceVO());
		for (int i = 0; i < serviceList.size(); i++) {
			Metering meteringvalue = menuservice.meteringValue(serviceList.get(i).getVmServiceID());
			meteringSum.setnVm_service_ID(serviceList.get(i).getVmServiceID());
			meteringSum.setnTotal_cpu(meteringvalue.getTotal_cpu());
			meteringSum.setnTotal_memory(meteringvalue.getTotal_memory());
			menuservice.MeteringSum(meteringSum);
		}
	}

	@Scheduled(cron = "0 56 23 * * ?")
	@RequestMapping("jquery/TotalMeteringVMs.do")
	public @ResponseBody void TotalMeteringVMs() {
		SimpleDateFormat format1 = new SimpleDateFormat("yyyyMM");
		Date time = new Date();
		String FormatTime = format1.format(time);
		List<VMServiceVO> serviceList = vmServiceService.selectVMServiceList(new VMServiceVO());

		for (int i = 0; i < serviceList.size(); i++) {
			List<MmonitoringJoin> ServiceINVMList = menuservice.service_detailInfo(serviceList.get(i).getVmServiceID() + ""); // 그 시각에 서비스에 가상머신들 스펙
			MeteringVMs meteringVMsInsertObject = new MeteringVMs();

			if (ServiceINVMList != null) {
				for (int k = 0; k < ServiceINVMList.size(); k++) {
					if (ServiceINVMList.get(k).getVm_status().equals("poweredOn")) {
						meteringVMsInsertObject.setnVm_service_ID(ServiceINVMList.get(k).getVm_service_ID());
						meteringVMsInsertObject.setsVm_ID(ServiceINVMList.get(k).getVm_ID());
						meteringVMsInsertObject.setsVm_name(ServiceINVMList.get(k).getVm_name());
						meteringVMsInsertObject.setnVm_cpu(ServiceINVMList.get(k).getVm_cpu());
						meteringVMsInsertObject.setnVm_memory(ServiceINVMList.get(k).getVm_memory());
						meteringVMsInsertObject.setsVm_host(ServiceINVMList.get(k).getVm_host());
						meteringVMsInsertObject.setdMeteringDate(FormatTime);
						menuservice.meteringVMsInsert(meteringVMsInsertObject);
					}
				}
			}
		}
	}
	
	@RequestMapping("common/getOneVMInfo.do")
	public @ResponseBody List<Vm_data_info> getOneVMInfo(String vm_ID){
		List<Vm_data_info> result = commonService.getOneVMInfo(vm_ID);
		return result;
	}

}
