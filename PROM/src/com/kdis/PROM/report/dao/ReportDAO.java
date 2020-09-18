package com.kdis.PROM.report.dao;

import java.util.List;

import com.kdis.PROM.report.vo.HostReportVO;
import com.kdis.PROM.report.vo.VMReportVO;

/**
 * 보고서 DAO interface
 * 
 * @author KimHahn
 *
 */
public interface ReportDAO {

	/**
	 * 가상머신 일반 성능 보고서 목록 조회
	 * 
	 * @param vmReportVO
	 * @return
	 */
	public List<VMReportVO> selectVMReportList(VMReportVO vmReportVO);

	/**
	 * 가상머신 주야간 성능 보고서 목록 조회
	 * 
	 * @param vmReportVO
	 * @return
	 */
	public List<VMReportVO> selectVMDayNightReportList(VMReportVO vmReportVO);
	
	/**
	 * 호스트 일반 성능 보고서 목록 조회
	 * 
	 * @param hostReportVO
	 * @return
	 */
	public List<HostReportVO> selectHostReportList(HostReportVO hostReportVO);
	
	/**
	 * 호스트 주야간 성능 보고서 목록 조회
	 * 
	 * @param hostReportVO
	 * @return
	 */
	public List<HostReportVO> selectHostDayNightReportList(HostReportVO hostReportVO);
	
}
