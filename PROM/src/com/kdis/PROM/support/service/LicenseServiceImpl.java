package com.kdis.PROM.support.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdis.PROM.support.dao.LicenseDAO;
import com.kdis.PROM.support.vo.LicenseVO;
/**
 * 라이선스 서비스 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class LicenseServiceImpl implements LicenseService {

	/** 라이선스 DAO */
	@Autowired
	LicenseDAO licenseDAO;
	
	/**
	 * 라이선스 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<LicenseVO> selectLicenseList() {
		return licenseDAO.selectLicenseList();
	}
	
	/**
	 * 라이선스 정보 조회
	 * 
	 * @return
	 */
	@Override
	public LicenseVO selectLicense() {
		return licenseDAO.selectLicense();
	}
	
	/**
	 * 미사용 라이선스 정보 조회
	 * 
	 * @return
	 */
	@Override
	public LicenseVO selectUnusedLicense(LicenseVO licenseVO) {
		return licenseDAO.selectUnusedLicense(licenseVO);
	}
	
	/**
	 * 라이선스 등록
	 * 
	 * @return
	 */
	@Override
	@Transactional
	public int insertLicense(LicenseVO licenseVO) {
		// 라이선스 고유번호 최고값 얻어서 그 값에 +1 해서 새로운 라이선스 고유번호 설정
		int maxSerialNum = licenseDAO.selectLicenseMaxSerialNum();
		
		// 라이선스 키 생성
		String SerialNumber = UUID.randomUUID().toString().replaceAll("-", "");
		
		licenseVO.setnSerialNum(maxSerialNum + 1);
		licenseVO.setsSerialKey(SerialNumber);
				
		return licenseDAO.insertLicense(licenseVO);
	}
	
	/**
	 * 라이선스 수정
	 * 
	 * @return
	 */
	@Override
	@Transactional
	public int updateLicense(LicenseVO licenseVO) {
		return licenseDAO.updateLicense(licenseVO);
	}
	
}
