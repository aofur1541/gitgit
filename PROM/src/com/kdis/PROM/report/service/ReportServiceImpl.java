package com.kdis.PROM.report.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.report.dao.ReportDAO;
import com.kdis.PROM.report.vo.HostReportVO;
import com.kdis.PROM.report.vo.VMReportVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 보고서 서비스 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class ReportServiceImpl implements ReportService {

	/** 보고서 DAO */
	@Autowired
	ReportDAO reportDAO;
	
	/**
	 * 가상머신 일반 성능 보고서 목록 조회
	 * 
	 * @param vmReportVO
	 * @return
	 */
	@Override
	public List<VMReportVO> selectVMReportList(VMReportVO vmReportVO) {
		// 세션에서 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		vmReportVO.setUserId(loginInfo.getId());
				
		return reportDAO.selectVMReportList(vmReportVO);
	}
	
	/**
	 * 가상머신 주야간 성능 보고서 목록 조회
	 * 
	 * @param vmReportVO
	 * @return
	 */
	@Override
	public List<VMReportVO> selectVMDayNightReportList(VMReportVO vmReportVO) {
		// 세션에서 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo();
		vmReportVO.setUserId(loginInfo.getId());
		
		return reportDAO.selectVMDayNightReportList(vmReportVO);
	}
	
	/**
	 * 호스트 일반 성능 보고서 목록 조회
	 * 
	 * @param hostReportVO
	 * @return
	 */
	@Override
	public List<HostReportVO> selectHostReportList(HostReportVO hostReportVO) {
		return reportDAO.selectHostReportList(hostReportVO);
	}
	
	/**
	 * 호스트 주야간 성능 보고서 목록 조회
	 * 
	 * @param hostReportVO
	 * @return
	 */
	@Override
	public List<HostReportVO> selectHostDayNightReportList(HostReportVO hostReportVO) {
		return reportDAO.selectHostDayNightReportList(hostReportVO);
	}
	
}
