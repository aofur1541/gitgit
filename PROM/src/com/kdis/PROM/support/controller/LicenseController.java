package com.kdis.PROM.support.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.support.service.LicenseService;
import com.kdis.PROM.support.vo.LicenseVO;

/**
 * 기초 데이터 > 라이선스 Controller class
 * 
 * @author KimHahn
 *
 */
@Controller
public class LicenseController {

	/** 라이선스 서비스 */
	@Autowired
	private LicenseService licenseService;
	
	/**
	 * 기초 데이터 > 라이선스 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/support/promLicense.prom")
	public String promLicense() {
		return "support/promLicense";
	}
	
	/**
	 * 라이선스 정보 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/support/selectLicense.do")
	public LicenseVO selectLicense() {
		LicenseVO licenseVO = licenseService.selectLicense();
		return licenseVO;
	}
	
	/**
	 * 라이선스 관리 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/support/createLicense.prom")
	public String createLicense() {
		return "support/createLicense";
	}
	
	/**
	 * 라이선스 목록 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/support/selectLicenseList.do")
	public List<LicenseVO> selectLicenseList() {
		List<LicenseVO> licenseList = licenseService.selectLicenseList();
		return licenseList;
	}
	
	/**
	 * 라이선스 등록
	 * 
	 * @param sSerialCategory 라이선스 구분자(Month or Year)
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/support/insertLicense.do")
	public int insertLicense(LicenseVO licenseVO) {
		int result = licenseService.insertLicense(licenseVO);
		return result;
	}
	
	/**
	 * 미사용 라이선스 정보 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/support/selectUnusedLicense.do")
	public LicenseVO selectUnusedLicense(LicenseVO licenseVO) {
		LicenseVO result = licenseService.selectUnusedLicense(licenseVO);
		return result;
	}
	
	/**
	 * 라이선스 수정
	 * 
	 * @param sSerialCategory 라이선스 구분자(Month or Year)
	 * @param nSerialNum 라이선스 고유번호
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/support/updateLicense.do")
	public int updateLicense(LicenseVO licenseVO) {
		int result = licenseService.updateLicense(licenseVO);
		return result;
	}
}
