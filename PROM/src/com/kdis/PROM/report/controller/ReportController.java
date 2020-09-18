package com.kdis.PROM.report.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.common.CommonUtil;
import com.kdis.PROM.report.service.ReportService;
import com.kdis.PROM.report.vo.HostReportVO;
import com.kdis.PROM.report.vo.VMReportVO;

/**
 * 보고서 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class ReportController {
	
	private static final Log LOG = LogFactory.getLog(ReportController.class);

	/** 보고서 서비스 */
	@Autowired
	ReportService reportService;
	
	/**
	 * 보고서 > 일반 성능 > 가상머신 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/report/vmReport.prom")
	public String vmReport() {
		return "report/vmReport";
	}

	/**
	 * 가상머신 보고서 목록 조회
	 * 
	 * @param vmReportVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/report/selectVMReportList.do")
	public List<VMReportVO> selectVMReportList(VMReportVO vmReportVO) {
		List<VMReportVO> result = new ArrayList<VMReportVO>();
		
		// 검색 기간 얻기
		String[] searchDate = this.getSearchDate(vmReportVO.getTimeset(), vmReportVO.getStartDate(), vmReportVO.getEndDate());
		
		// 미래의 데이터는 결과가 없도록 한다.  
		// 시작일이 어제보다 크면 빈 목록의 return 한다.
		if(this.isBefore(searchDate[0])) {
			// 시작일이 오늘보다 작으면 조회를 한다.
			
			vmReportVO.setStartDate(searchDate[0] + " 00:00:00");
			vmReportVO.setEndDate(searchDate[1] + " 23:59:59");
			
			// 가상머신 보고서 목록 조회
			result = reportService.selectVMReportList(vmReportVO);
		}
		
		return result;
	}
	
	/**
	 * 보고서 > 주야간 성능 > 가상머신 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/report/vmDayNightReport.prom")
	public String vmDayNightReport() {
		return "report/vmDayNightReport";
	}

	/**
	 * 주야간 성능 가상머신 보고서 목록 조회
	 * 
	 * @param vmReportVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/report/selectVMDayNightReportList.do")
	public List<VMReportVO> selectVMDayNightReportList(VMReportVO vmReportVO) {
		List<VMReportVO> result = new ArrayList<VMReportVO>();
		
		// 검색 기간 얻기
		String[] searchDate = this.getSearchDate(vmReportVO.getTimeset(), vmReportVO.getStartDate(), vmReportVO.getEndDate());
		
		// 미래의 데이터는 결과가 없도록 한다.  
		// 시작일이 어제보다 크면 빈 목록의 return 한다.
		if(this.isBefore(searchDate[0])) {
			// 시작일이 오늘보다 작으면 조회를 한다.
			
			vmReportVO.setStartDate(searchDate[0] + " 00:00:00");
			vmReportVO.setEndDate(searchDate[1] + " 23:59:59");
		
			// 주야간 성능 가상머신 보고서 목록 조회
			result = reportService.selectVMDayNightReportList(vmReportVO);
		}
		
		return result;
	}
	
	/**
	 * 보고서 > 일반 성능 > 호스트 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/report/hostReport.prom")
	public String hostReport() {
		return "report/hostReport";
	}

	/**
	 * 호스트 보고서 목록 조회
	 * 
	 * @param hostReportVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/report/selectHostReportList.do")
	public List<HostReportVO> selectHostReportList(HostReportVO hostReportVO) {
		List<HostReportVO> result = new ArrayList<HostReportVO>();
		
		// 검색 기간 얻기
		String[] searchDate = this.getSearchDate(hostReportVO.getTimeset(), hostReportVO.getStartDate(), hostReportVO.getEndDate());
		
		// 미래의 데이터는 결과가 없도록 한다. 
		// 시작일이 어제보다 크면 빈 목록의 return 한다.
		if(this.isBefore(searchDate[0])) {
			// 시작일이 오늘보다 작으면 조회를 한다.
			hostReportVO.setStartDate(searchDate[0] + " 00:00:00");
			hostReportVO.setEndDate(searchDate[1] + " 23:59:59");
		
			// 호스트 보고서 목록 조회
			result = reportService.selectHostReportList(hostReportVO);
		}
		
		return result;
	}
	
	/**
	 * 보고서 > 주야간 성능 > 호스트 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/report/hostDayNightReport.prom")
	public String hostDayNightReport() {
		return "report/hostDayNightReport";
	}

	/**
	 * 호스트 주야간 성능 보고서 목록 조회
	 * 
	 * @param hostReportVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/report/selectHostDayNightReportList.do")
	public List<HostReportVO> selectHostDayNightReportList(HostReportVO hostReportVO) {
		List<HostReportVO> result = new ArrayList<HostReportVO>();
		
		// 검색 기간 얻기
		String[] searchDate = this.getSearchDate(hostReportVO.getTimeset(), hostReportVO.getStartDate(), hostReportVO.getEndDate());
		
		// 미래의 데이터는 결과가 없도록 한다.  
		// 시작일이 어제보다 크면 빈 목록의 return 한다.
		if(this.isBefore(searchDate[0])) {
			// 시작일이 오늘보다 작으면 조회를 한다.
			
			hostReportVO.setStartDate(searchDate[0] + " 00:00:00");
			hostReportVO.setEndDate(searchDate[1] + " 23:59:59");
		
			// 호스트 보고서 목록 조회
			result = reportService.selectHostDayNightReportList(hostReportVO);
		}
		
		return result;
	}
	
	/**
	 * 보고서 > 미터링 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("report/meteringReport.prom")
	public String meteringReport() {
		return "report/meteringReport";
	}
	
	/**
	 * 검색 기간 단위에 따라 검색 기간 얻기
	 * 
	 * @param timeset
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	private String[] getSearchDate(int timeset, String startDate, String endDate) {
		
		String[] searchDate = {"", ""};
		
		// 검색 기간 단위
		if(timeset == 1) {
			// 검색 기간 단위가 일(day)인 경우
			searchDate[0] = startDate;
			searchDate[1] = endDate;
			
		} else if(timeset == 2) {
			// 검색 기간 단위가 주(week)인 경우
			LOG.debug("StartDate : " + startDate);
			
			// 2020년 30번째 주라면 '2020-W30'라고 입력됨
			String yearWeek = CommonUtil.nullToBlank(startDate).replace("W", "");
			String[] yearWeekes = yearWeek.split("-");
			
			if(yearWeekes.length > 1) {
				
				int weekYear = 0;
				int weekOfYear = 0;
				
				try {
					weekYear = Integer.parseInt(yearWeekes[0]);
					weekOfYear = Integer.parseInt(yearWeekes[1]);
				} catch(NumberFormatException e) {
					LOG.warn("NumberFormatException : " + e.getMessage());
				}
				
				// 해당 년, 몇 번째 주의 시작일(월요일)과 마지막일(일요일)을 얻는다
				searchDate = this.getFirstAndLastDayOfWeek(weekYear, weekOfYear);
				
			}
			
		} else {
			// 검색 기간 단위가 월(month)인 경우
			startDate = startDate + "-01";
			
			// 해당 월의 마지막 일을 얻는다
			YearMonth yearMonth = YearMonth.from(LocalDate.parse(startDate, DateTimeFormatter.ofPattern("yyyy-MM-dd")));
			endDate = yearMonth.atEndOfMonth() + "";
			
			searchDate[0] = startDate;
			searchDate[1] = endDate;
		}
		
		LOG.debug("startDate : " + searchDate[0]);
		LOG.debug("endDate : " + searchDate[1]);
		
		return searchDate;
	}
	
	
	/**
	 * 해당 년, 몇 번째 주의 시작일(월요일)과 마지막일(일요일)을 얻는다
	 * 
	 * @param year 년도
	 * @param weekOfYear 해당 년도의 몇 번째 주
	 * @return {"시작일", " 마지막일"}
	 */
	private String[] getFirstAndLastDayOfWeek(int year, int weekOfYear) {
		String[] week = {"", ""}; 
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		// 그 주의 시작일(월요일) 얻기 
		Calendar startCalendar = Calendar.getInstance();
		// 주의 시작을 월요일로 설정
		startCalendar.setFirstDayOfWeek(Calendar.MONDAY);
		// year년 weekOfYear 번째 주의 월요일의 날짜를 얻는다
		startCalendar.setWeekDate(year, weekOfYear, Calendar.MONDAY);
		
		String startDate = dateFormat.format(startCalendar.getTime());
		LOG.debug("startDate : " + startDate);
		
		// 그 주의 마지막일(일요일) 얻기 
		Calendar endCalendar = Calendar.getInstance();
		// 주의 시작을 월요일로 설정
		endCalendar.setFirstDayOfWeek(Calendar.MONDAY);
		// year년 weekOfYear번째 주의 일요일의 날짜를 얻는다
		endCalendar.setWeekDate(year, weekOfYear, Calendar.SUNDAY);
		
		String endDate = dateFormat.format(endCalendar.getTime());
		LOG.debug("endDate : " + endDate);
		
		week[0] = startDate;
		week[1] = endDate;
		
		return week;
	}
	
	/**
	 * 대상 날짜가 오늘보다 과거인지 확인한다
	 * 
	 * 결과
	 * 오늘보다 과거 : true
	 * 오늘이거나 미래 : false  
	 * 
	 * @param targetDate
	 * @return
	 */
	private boolean isBefore(String targetDate) {
		
		LocalDate date = LocalDate.parse(targetDate);
		LocalDate currentDate = LocalDate.now();

		if(currentDate.isAfter(date)) {
			return true;
		} else {
			return false;
		}
	}
}
