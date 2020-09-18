package com.kdis.PROM.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdis.PROM.user.dao.CompanyDAO;
import com.kdis.PROM.user.vo.CompanyVO;

/**
 * 회사 Service 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class CompanyServiceImpl implements CompanyService {

	/** 회사 DAO */
	@Autowired
	CompanyDAO companyDAO;
	
	/**
	 * 회사 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<CompanyVO> selectCompanyList() {
		return companyDAO.selectCompanyListById(null);
	}
	
	/**
	 * 회사 고유번호로 회사 목록 조회
	 * 
	 * @param id 회사 고유번호
	 * @return
	 */
	@Override
	public List<CompanyVO> selectCompanyListById(int id) {
		return companyDAO.selectCompanyListById(id);
	}
	
	/**
	 * 회사명으로 회사 목록 조회
	 * 
	 * @param Name 회사명
	 * @return
	 */
	@Override
	public List<CompanyVO> selectCompanyListByName(String name) {
		return companyDAO.selectCompanyListByName(name);
	}
	
	/**
	 * 회사 고유번호로 회사 정보 조회
	 * 
	 * @param id 회사 고유번호
	 * @return
	 */
	@Override
	public CompanyVO selectCompanyById(int id) {
		return companyDAO.selectCompanyById(id);
	}
	
	/**
	 * 회사 고유번호로 사용자 수 조회
	 * 
	 * @param comanyId
	 * @return
	 */
	@Override
	public int countUserByComanyId(int comanyId) {
		return companyDAO.countUserByComanyId(comanyId);
	}
	
	/**
	 * 회사 고유번호로 테넌트 수 조회
	 * 
	 * @param comanyId
	 * @return
	 */
	@Override
	public int countTenantsByComanyId(int comanyId) {
		return companyDAO.countTenantsByComanyId(comanyId);
	}
	
	/**
	 * 회사 고유번호로 부서 수 조회
	 * 
	 * @param comanyId
	 * @return
	 */
	@Override
	public int countDepartmentByComanyId(int comanyId) {
		return companyDAO.countDepartmentByComanyId(comanyId);
	}
	
	/**
	 * 회사 등록
	 * 
	 * @param company
	 * @return
	 */
	@Override
	@Transactional
	public int insertCompany(CompanyVO company) {
		return companyDAO.insertCompany(company);
	}
	
	/**
	 * 회사 수정
	 * 
	 * @param company
	 * @return
	 */
	@Override
	@Transactional
	public int updateCompany(CompanyVO company) {
		return companyDAO.updateCompany(company);
	}
	
	/**
	 * 회사 삭제
	 * 
	 * @param id
	 * @return
	 */
	@Override
	@Transactional
	public int deleteCompany(int id) {
		return companyDAO.deleteCompany(id);
	}
}
