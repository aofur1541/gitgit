package com.kdis.PROM.user.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.common.Constants;
import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.log.vo.LogVO;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.user.service.CompanyService;
import com.kdis.PROM.user.vo.CompanyVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 기초 데이터 > 회사 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class CompanyController {
	
	/** 회사 서비스 */
	@Autowired
	private CompanyService companyService;
	
	/** 이력 서비스 */
	@Autowired
	private LogService logService;
	
	/**
	 * 기초 데이터 > 회사 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/user/manageCompany.prom")
	public String manageCompany() {
		return "/user/manageCompany";
	}

	/**
	 * 회사 목록 얻기
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping("/user/selectCompanyList.do")
	public @ResponseBody List<CompanyVO> selectCompanyList(HttpSession session) {
		
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		List<CompanyVO> result = null;
		
		// 회사 목록 얻기
		if (loginInfo.getsCompany() > 0 && loginInfo.getnApproval() == Constants.USER_NUMBER) {
			// 로그인 정보에 회사 정보가 있고 사용자가 승인(권한)이 사용자인 경우에는 
			// 사용자의 회사ID로 회사 목록을 조회한다.
			result = companyService.selectCompanyListById(loginInfo.getsCompany());
		} else {
			result = companyService.selectCompanyList();
		}

		return result;
	}

	/**
	 * 회사 상세 조회
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/user/selectCompany.do", method=RequestMethod.POST)
	public @ResponseBody CompanyVO selectCompany(int id) {
		
		// 회사 고유번호로 회사 정보 조회
		CompanyVO result = companyService.selectCompanyById(id);
		return result;
	}

	/**
	 * 회사 등록
	 * 
	 * 결과
	 *  - 1 : 성공
	 *  - 2 : 회사명 중복
	 * 
	 * @param company
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/user/insertCompany.do", method=RequestMethod.POST)
	public @ResponseBody int insertCompany(CompanyVO company, HttpSession session) {
		int result = 0;
		
		// 회사명으로 회사 목록 조회
		List<CompanyVO> companyList = companyService.selectCompanyListByName(company.getName());
		
		// 회사명 중복 체크
		if(companyList != null && companyList.size() > 0) {
			// 동일한 회사명이 이미 등록된 경우
			result = 2;
			return result;
		}
		
		// 회사 등록
		result = companyService.insertCompany(company);
		
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		// 로그 등록
		LogVO notification = new LogVO();
		
		// 이력 내용
		String sContext = "[" + company.getName() + "] ";
		sContext += " 대표이사 : " + company.getRepresentative() + ",";
		sContext += " 사업자 등록번호 : " + company.getRegistrationNumber() + ",";
		sContext += " 주소 : " + company.getAddress() + ",";
		sContext += " 설명 : " + company.getDescription();
		
		notification.setsReceive(loginInfo.getsUserID());
		notification.setsContext(sContext);
		notification.setsTarget("회사");
		notification.setnCategory(0);
		notification.setsKeyword("Create");
		
		logService.insertLog(notification);
		
		return result;
	}
	
	/**
	 * 회사 수정
	 * 
	 * 결과
	 *  - 1 : 성공
	 *  - 2 : 회사명 중복
	 * 
	 * @param company
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/user/updateCompany.do", method=RequestMethod.POST)
	public @ResponseBody int updateCompany(CompanyVO company, HttpSession session) {
		
		// 결과
		int result = 0;
		
		// 회사명으로 회사 목록 조회
		List<CompanyVO> companyList = companyService.selectCompanyListByName(company.getName());
		
		// 회사명 중복 체크
		for(CompanyVO companyByName : companyList) {
			
			// 수정 대상과 다른 회사ID가 있는 경우 사용자가 입력한 회사명은 이미 등록되어 있는 것이다.
			if(companyByName.getId() != company.getId()) {
				// 동일한 회사명이 이미 등록된 경우
				result = 2;
				return result;
			}
		}
		
		// 변경 이력을 로그로 기록하기 위햇 DB에 저장된 회사 정보 조회
		CompanyVO preCompany = companyService.selectCompanyById(company.getId());
		
		// 변경전
		String beforeLog = "";
		// 변경후
		String afterLog = "";
		
		// 회사명이 변경된 경우
		if (company.getName() != null && 
				!company.getName().equals(preCompany.getName())) {
			beforeLog += ",이름 : " + preCompany.getName();
			afterLog += ",이름 : " + company.getName();
		}
		// 대표이사가 변경된 경우
		if (company.getRepresentative() != null && 
				!company.getRepresentative().equals(preCompany.getRepresentative())) {
			beforeLog += ",대표이사 : " + preCompany.getRepresentative();
			afterLog += ",대표이사 : " + company.getRepresentative();
		}
		// 사업자 등록번호가 변경된 경우
		if (company.getRegistrationNumber() != null && 
				!company.getRegistrationNumber().equals(preCompany.getRegistrationNumber())) {
			beforeLog += ",사업자 등록번호 : " + preCompany.getRegistrationNumber();
			afterLog += ",사업자 등록번호 : " + company.getRegistrationNumber();
		}
		// 주소가 변경된 경우
		if (company.getAddress() != null && 
				!company.getAddress().equals(preCompany.getAddress())) {
			beforeLog += ",주소 : " + preCompany.getAddress();
			afterLog += ",주소 : " + company.getAddress();
		}
		// 설명이 변경된 경우
		if (company.getDescription() != null && 
				!company.getDescription().equals(preCompany.getDescription())) {
			beforeLog += ",설명 : " + preCompany.getDescription();
			afterLog += ",설명 : " + company.getDescription();
		}
		
		// 변경된 것이 있는 경우만 수정, 로그를 기록한다.
		if (beforeLog.length() > 0 && afterLog.length() > 0) {
			
			// 회사 수정
			result = companyService.updateCompany(company);
			
			// 변경전, 변경후 문자열의 첫문자 "," 삭제
			if (beforeLog.startsWith(",")) {
				beforeLog = beforeLog.substring(1);
			}
			if (afterLog.startsWith(",")) {
				afterLog = afterLog.substring(1);
			}

			// 로그인 정보 얻기
			UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
			
			// 로그 기록
			LogVO notification = new LogVO();
			notification.setsReceive(loginInfo.getsUserID());
			String sContext = "[" + preCompany.getName() + "] " + beforeLog + " -> " + afterLog;
			notification.setsContext(sContext);
			notification.setsTarget("회사");
			notification.setnCategory(0);
			notification.setsKeyword("Update");
			
			logService.insertLog(notification);
			
		} else {
			// 변경된 것이 없어도 변경 성공으로 한다.
			result = 1;
		}
			
		return result;
	}

	/**
	 * 회사 삭제
	 * 
	 * 결과
	 *  - 1 : 성공
	 *  - 2 : 해당 회사에 속한 사용자 있음
	 *  - 3 : 회사가 속한 테넌트 있음
	 *  - 4 : 해당 회사에 속한 부서 있음
	 *  
	 * @param id
	 * @param name
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/user/deleteCompany.do", method=RequestMethod.POST)
	public @ResponseBody int deleteCompany(int id, String name, HttpSession session) {
		
		// 결과
		int result = 0;
		
		// 삭제 대상 회사에 속한 사용자 수 조회
		int userCount = companyService.countUserByComanyId(id);
		if(userCount > 0) {
			//  삭제 대상 회사에 속한 사용자가 있으면 회사를 삭제할 수 없다.
			result = 2;
			return result;
		}
		
		// 삭제 대상 회사가 속한 테넌트 수 조회
		int tenantsCount = companyService.countTenantsByComanyId(id);
		if(tenantsCount > 0) {
			//  삭제 대상 회사가 속한된  테넌트가 있으면 회사를 삭제할 수 없다.
			result = 3;
			return result;
		}
		
		// 삭제 대상 회사에 속한 부서 수 조회
		int deptCount = companyService.countDepartmentByComanyId(id);
		if(deptCount > 0) {
			//  삭제 대상 회사에 속한 부서가 있으면 회사를 삭제할 수 없다.
			result = 4;
			return result;
		}
		
		// 회사 삭제
		result = companyService.deleteCompany(id);

		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		// 로그 기록
		LogVO notification = new LogVO();
		notification.setsReceive(loginInfo.getsUserID());
		String sContext = "[" + name + "]";
		notification.setsContext(sContext);
		notification.setsTarget("회사");
		notification.setnCategory(0);
		notification.setsKeyword("Delete");

		logService.insertLog(notification);
		
		return result;
	}
}
