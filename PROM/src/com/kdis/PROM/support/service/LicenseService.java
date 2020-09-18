package com.kdis.PROM.support.service;

import java.util.List;

import com.kdis.PROM.support.vo.LicenseVO;

/**
 * 라이선스 서비스 interface
 * 
 * @author KimHahn
 *
 */
public interface LicenseService {

	/**
	 * 라이선스 목록 조회
	 * 
	 * @return
	 */
	public List<LicenseVO> selectLicenseList();
	
	/**
	 * 라이선스 정보 조회
	 * 
	 * @return
	 */
	public LicenseVO selectLicense();
	
	/**
	 * 미사용 라이선스 정보 조회
	 * 
	 * @return
	 */
	public LicenseVO selectUnusedLicense(LicenseVO licenseVO);
	
	/**
	 * 라이선스 등록
	 * 
	 * @return
	 */
	public int insertLicense(LicenseVO licenseVO);
	
	/**
	 * 라이선스 수정
	 * 
	 * @return
	 */
	public int updateLicense(LicenseVO licenseVO);
	
}
