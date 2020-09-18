package com.kdis.PROM.performance.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.apply.service.VMService;
import com.kdis.PROM.apply.vo.VMDataVO;
import com.kdis.PROM.common.MakeExcel;
import com.kdis.PROM.performance.service.PerformanceService;
import com.kdis.PROM.performance.vo.AgentVO;
import com.kdis.PROM.performance.vo.PerformanceVO;
import com.kdis.PROM.status.service.StatusService;
import com.kdis.PROM.tenant.vo.VMHostVO;

/**
 * 성능 > 일반 > 가상머신 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class PerformanceController {

	/** 성능 서비스 */
	@Autowired
	PerformanceService performanceService;

	/** 가상머신 서비스 */
	@Autowired
	private VMService vmService;
	
	/** 호스트 서비스 */
	@Autowired
	private StatusService hostService;
	
	/**
	 * 성능 > 일반 > 가상머신 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/performance/vmPerformance.prom")
	public String vmPerformance() {
		return "performance/vmPerformance";
	}
	
	/**
	 * 가상머신 목록의 리소스 통계 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/performance/selectVMResourceStatistics.do")
	public PerformanceVO selectVMResourceStatistics(PerformanceVO performanceVO) {
		PerformanceVO result = performanceService.selectVMResourceStatistics(performanceVO);
		return result;
	}
	
	/**
	 * 가상머신의 성능 통계 목록 조회
	 * 
	 * @param serviceId
	 * @param period
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/performance/selectVMPerformanceStatistics.do")
	public List<PerformanceVO> selectVMPerformanceStatistics(PerformanceVO performanceVO) {
		List<PerformanceVO> result = performanceService.selectVMPerformanceStatisticsList(performanceVO);
		return result;
	}
	
	/**
	 * 가상머신의 성능 목록 조회
	 * 
	 * @param vmID
	 * @param period
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/performance/selectVMPerformanceList.do")
	public List<PerformanceVO> selectVMPerformanceList(String vmID, int period) {
		List<PerformanceVO> result = performanceService.selectVMPerformanceList(vmID, period);
		return result;
	}
	
	/**
	 * 가상머신 일반 성능 Excel 내보내기
	 * 
	 * @param performanceVO
	 * @param request
	 * @param response
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value="/performance/exportVMPerformance.do", method=RequestMethod.POST)
	public void exportVMPerformance(PerformanceVO performanceVO, 
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		
		// 주기
		String dateCheck = "";
		// 템플릿 Excel 파일명
		String templateExcelFile = "";

		if(performanceVO.getPeriod() != null) {
			if (performanceVO.getPeriod() == 0) {
				dateCheck = "실시간";
			} else if (performanceVO.getPeriod() == 1) {
				dateCheck = "최근 하루";
			} else if (performanceVO.getPeriod() == 2) {
				dateCheck = "최근 한주";
			}
		} else {
			performanceVO.setPeriod(0);
			dateCheck = "실시간";
		}

		PerformanceVO allVMStatistics = new PerformanceVO();
		List<PerformanceVO> allVMPerformanceList = new ArrayList<PerformanceVO>();
		VMDataVO vmData = new VMDataVO();
		List<PerformanceVO> vmPerformanceList = new ArrayList<PerformanceVO>();
		Map<String, Object> excelMap = new HashMap<String, Object>();
		
		if ("vmAll".equals(performanceVO.getVmID())) {
			// 가상머신 전체 선택
			templateExcelFile = "perfVMInServiceTemplate.xlsx";
			
			// 카테고리별로 필요한 검색 조건만 설정해서 조회한다
			PerformanceVO searchVO = new PerformanceVO();
			searchVO.setPeriod(performanceVO.getPeriod());
			if("serviceGroup".equals(performanceVO.getCategory())) {
				// 서비스 그룹별 조회
				searchVO.setTenantId(performanceVO.getTenantId());
				searchVO.setServiceId(performanceVO.getServiceId());
				searchVO.setIsUserTenantMapping(performanceVO.getIsUserTenantMapping());
			} else {
				// 클러스터별 조회
				searchVO.setClusterId(performanceVO.getClusterId());
				searchVO.setHostId(performanceVO.getHostId());
			}
			
			// 해당 서비스에 속한 가상머신의 리소스 통계 조회
			allVMStatistics = performanceService.selectVMResourceStatistics(searchVO);
			
			// 해당 서비스에 속한 가상머신의 성능 통계 목록 조회
			allVMPerformanceList = performanceService.selectVMPerformanceStatisticsList(searchVO);
			
			excelMap.put("result", allVMStatistics);
			excelMap.put("perfResult", allVMPerformanceList);
			
		} else {
			// 가상머신 선택
			templateExcelFile = "perfVMexcel.xlsx";
			
			// 가상머신 조회
			vmData = vmService.selectVMData(performanceVO.getVmID());
			
			// 가상머신의 성능 목록 조회
			vmPerformanceList = performanceService.selectVMPerformanceList(performanceVO.getVmID(), performanceVO.getPeriod());
			
			excelMap.put("result", vmData);
			excelMap.put("perfResult", vmPerformanceList);
			
		}

		String docName = URLEncoder.encode("가상머신_성능", "UTF-8");
		
		excelMap.put("dateCheck", dateCheck);
		if("serviceGroup".equals(performanceVO.getCategory())) {
			excelMap.put("categoryLevel1", "서비스그룹");
			excelMap.put("categoryLevel2", "서비스");
			excelMap.put("categoryLevel1Name", performanceVO.getTenantName());
			excelMap.put("categoryLevel2Name", performanceVO.getServiceName());
		} else {
			excelMap.put("categoryLevel1", "클러스터");
			excelMap.put("categoryLevel2", "호스트");
			excelMap.put("categoryLevel1Name", performanceVO.getClusterName());
			excelMap.put("categoryLevel2Name", performanceVO.getHostName());
		}
		
		// Excel 파일 생성
		MakeExcel me = new MakeExcel();
		me.download(request, response, excelMap, docName, templateExcelFile);
		
	}
	
	/**
	 * 성능 > 고급 > 가상머신 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/performance/vmCustomPerformance.prom")
	public String vmCustomPerformance() {
		return "performance/vmCustomPerformance";
	}
	
	/**
	 * 가상머신 고급 성능 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 * @throws ParseException
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonGenerationException 
	 */
	@ResponseBody
	@RequestMapping("/performance/selectVMPerformanceTotalList.do")
	public List<PerformanceVO> selectVMPerformanceTotalList(PerformanceVO performanceVO) throws ParseException, JsonGenerationException, JsonMappingException, IOException {
		
		List<PerformanceVO> result = new ArrayList<PerformanceVO>();
		
		// 너무 많은 데이터를 조회하면 성능에 문제가 있기 때문에 주기에 따라 검색 가능한 기간을 한정한다.
		// 기간이 넘으면 빈값을 보낸다
		long datePe = this.getBetweenDays(performanceVO.getStartDate(), performanceVO.getEndDate());
		
		// 검색 기간이 보기 단위가 20초 경우는 3일, 5분은 7일, 30분은 30일, 2시간은 365일 이내인 경우만 조회를 한다. 
		if (!((performanceVO.getPeriod() == 0 && datePe > 3) ||
				(performanceVO.getPeriod() == 1 && datePe > 7) ||
				(performanceVO.getPeriod() == 2 && datePe > 30) ||
				(performanceVO.getPeriod() == 3 && datePe > 365))) {
			performanceVO.setStartDate(performanceVO.getStartDate() + " " + performanceVO.getStartTime() + ":00");
			performanceVO.setEndDate(performanceVO.getEndDate() + " " + performanceVO.getEndTime() + ":59");
			result = performanceService.selectVMPerformanceTotalList(performanceVO);
			
	
			System.out.println(result);
			
			
			
		} 
		return result;
	}
	
	/**
	 * 성능 > 일반 > 호스트 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/performance/hostPerformance.prom")
	public String hostPerformance() {
		return "performance/hostPerformance";
	}
	
	/**
	 * 해당 클러스터에 속한 호스트의 리소스 통계 조회
	 * 
	 * @param clusterId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/performance/selectHostResourceStatistics.do")
	public PerformanceVO selectHostResourceStatistics(String clusterId) {
		PerformanceVO result = performanceService.selectHostResourceStatistics(clusterId);
		return result;
	}
	
	/**
	 * 해당 클러스터에 속한 호스트의 성능 통계 목록 조회
	 * 
	 * @param clusterId
	 * @param period
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/performance/selectHostPerformanceStatisticsList.do")
	public List<PerformanceVO> selectHostPerformanceStatisticsList(String clusterId, int period) {
		List<PerformanceVO> result = performanceService.selectHostPerformanceStatisticsList(clusterId, period);
		return result;
	}
	
	/**
	 * 호스트 성능 목록 조회
	 * 
	 * @param hostId
	 * @param period
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping("/performance/selectHostPerformanceList.do")
	public List<PerformanceVO> selectHostPerformanceList(String hostId, int period) throws ParseException {
		List<PerformanceVO> result =performanceService.selectHostPerformanceList(hostId, period);
		return result;
	}
	
	/**
	 * 호스트 일반 성능 Excel 내보내기
	 * 
	 * @param clusterId
	 * @param clusterName
	 * @param hostId
	 * @param period 주기
	 * @param request
	 * @param response
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value="/performance/exportHostPerformance.do", method=RequestMethod.POST)
	public @ResponseBody void exportHostPerformance(String clusterId, String clusterName, String hostId, Integer period, 
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		
		// 주기
		String dateCheck = "";
		// 템플릿 Excel 파일명
		String templateExcelFile = "";

		if(period != null) {
			if (period == 0) {
				dateCheck = "실시간";
			} else if (period == 1) {
				dateCheck = "최근 하루";
			} else if (period == 2) {
				dateCheck = "최근 한주";
			}
		} else {
			period = 0;
		}
		
		Map<String, Object> excelMap = new HashMap<String, Object>();
		
		if ("hostAll".equals(hostId)) {
			// 호스트 전체 선택
			templateExcelFile = "perfHostInClusterTemplate.xlsx";
			
			// 해당 클러스터에 속한 호스트의 리소스 통계 조회
			PerformanceVO allHostStatistics = performanceService.selectHostResourceStatistics(clusterId);
			
			// 해당 클러스터에 속한 호스트의 성능 통계 목록 조회
			List<PerformanceVO> allHostPerformanceList = performanceService.selectHostPerformanceStatisticsList(clusterId, period);
			
			excelMap.put("result", allHostStatistics);
			excelMap.put("perfResult", allHostPerformanceList);
			
		} else {
			// 개별 호스트 선택
			templateExcelFile = "perfHostexcel.xlsx";
			
			// 호스트 조회
			VMHostVO hostData = hostService.selectVMHost(hostId);
			
			// 호스트 성능 목록 조회
			List<PerformanceVO> hostPerformanceList =performanceService.selectHostPerformanceList(hostId, period);
			
			excelMap.put("result", hostData);
			excelMap.put("perfResult", hostPerformanceList);
		}

		String docName = URLEncoder.encode("호스트_성능", "UTF-8");
		excelMap.put("clusterName", clusterName);
		excelMap.put("dateCheck", dateCheck);
		
		// Excel 파일 생성
		MakeExcel me = new MakeExcel();
		me.download(request, response, excelMap, docName, templateExcelFile);
	}
	
	/**
	 * 성능 > 고급 > 호스트 화면을 이동
	 * 
	 * @return
	 */
	@RequestMapping("/performance/hostCustomPerformance.prom")
	public String hostCustomPerformance() {
		return "performance/hostCustomPerformance";
	}
	
	/**
	 * 호스트 고급 성능 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping("/performance/selectHostPerformanceTotalList.do")
	public List<PerformanceVO> selectHostPerformanceTotalList(PerformanceVO performanceVO) throws ParseException {
		
		List<PerformanceVO> result = new ArrayList<PerformanceVO>();
		
		// 너무 많은 데이터를 조회하면 성능에 문제가 있기 때문에 주기에 따라 검색 가능한 기간을 한정한다.
		// 기간이 넘으면 빈값을 보낸다
		long datePe = this.getBetweenDays(performanceVO.getStartDate(), performanceVO.getEndDate());
		
		// 검색 기간이 보기 단위가 20초 경우는 3일, 5분은 7일, 30분은 30일, 2시간은 365일 이내인 경우만 조회를 한다. 
		if (!((performanceVO.getPeriod() == 0 && datePe > 3) ||
				(performanceVO.getPeriod() == 1 && datePe > 7) ||
				(performanceVO.getPeriod() == 2 && datePe > 30) ||
				(performanceVO.getPeriod() == 3 && datePe > 365))) {
			performanceVO.setStartDate(performanceVO.getStartDate() + " " + performanceVO.getStartTime() + ":00");
			performanceVO.setEndDate(performanceVO.getEndDate() + " " + performanceVO.getEndTime() + ":59");
			result = performanceService.selectHostPerformanceTotalList(performanceVO);
		} 
		return result;
	}
	
	/**
	 * 성능 > 고급 > 자원 기준 화면을 이동
	 * 
	 * @return
	 */
	@RequestMapping("/performance/cpuCustomPerformance.prom")
	public String cpuCustomPerformance() {
		return "performance/cpuCustomPerformance";
	}
	
	
	@RequestMapping("/performance/memoryCustomPerformance.prom")
	public String memoryCustomPerformance() {
		return "performance/memoryCustomPerformance";
	}
	
	/**
	 * 자원 기준치를 넘은 가상머신 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/performance/selectVMOvercpuList.do")
	public List<PerformanceVO> selectVMOverResourceList(PerformanceVO performanceVO) {
		List<PerformanceVO> result = performanceService.selectVMOvercpuList(performanceVO);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/performance/selectVMOvermemoryList.do")
	public List<PerformanceVO> selectVMOverResourceList2(PerformanceVO performanceVO) {
		List<PerformanceVO> result = performanceService.selectVMOvermemoryList(performanceVO);
		return result;
	}
	
	
	
	
	/**
	 * 성능 > 고급 > OS 화면을 이동
	 * 
	 * @return
	 */
	@RequestMapping("/performance/osCustomPerformance.prom")
	public String osCustomPerformance() {
		return "performance/osCustomPerformance";
	}
	
	/**
	 * 에이전트 OS 목록 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/performance/selectAgentOSList.do")
	public List<AgentVO> selectAgentOSList() {
		List<AgentVO> result = performanceService.selectAgentOSList();
		return result;
	}

	/**
	 * 에이전트 성능 목록 조회
	 * 
	 * @param performanceVO
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping("/performance/selectAgentPerformanceList.do")
	public List<PerformanceVO> selectAgentPerformanceList(PerformanceVO performanceVO) throws ParseException {
		performanceVO.setStartDate(performanceVO.getStartDate() + " " + performanceVO.getStartTime() + ":00");
		performanceVO.setEndDate(performanceVO.getEndDate() + " " + performanceVO.getEndTime() + ":59");
		List<PerformanceVO> result = performanceService.selectAgentPerformanceList(performanceVO);
		return result;
	}
	
	/**
	 * 두 날짜 사이의 일 수
	 * 
	 * @param startDate
	 * @param endDate
	 * @return
	 * @throws ParseException
	 */
	private long getBetweenDays(String startDate, String endDate) throws ParseException {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		LocalDate startLocalDate = LocalDate.parse(startDate, formatter);
		LocalDate endLocalDate = LocalDate.parse(endDate, formatter);

		long result = ChronoUnit.DAYS.between(startLocalDate, endLocalDate);

		return result;
	}
	
	@ResponseBody
	@RequestMapping("/performance/selectPNICPerformanceList.do")
	public List<PerformanceVO> selectPNICPerformanceList(PerformanceVO performanceVO)  {
	   List<PerformanceVO> result = null;
	   if(performanceVO.getAdaptersName() != null && performanceVO.getPeriod() != null) {
	       result = performanceService.selectPNICPerformanceList(performanceVO);
	   }
	   
	   return result;
	}
	
}
