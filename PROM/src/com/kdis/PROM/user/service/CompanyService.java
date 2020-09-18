package com.kdis.PROM.user.service;

import java.util.List;

import com.kdis.PROM.user.vo.CompanyVO;

/**
 * 회사 Service interface
 * 
 * @author KimHahn
 *
 */
public interface CompanyService {

	/**
	 * 회사 목록 조회
	 * 
	 * @return
	 */
	List<CompanyVO> selectCompanyList();
	
	/**
	 * 회사 고유번호로 회사 목록 조회
	 * 
	 * @param id 회사 고유번호
	 * @return
	 */
	List<CompanyVO> selectCompanyListById(int id);
	
	/**
	 * 회사 고유번호로 회사 정보 조회
	 * 
	 * @param id 회사 고유번호
	 * @return
	 */
	CompanyVO selectCompanyById(int id);
	
	/**
	 * 회사명으로 회사 목록 조회
	 * 
	 * @param Name 회사명
	 * @return
	 */
	List<CompanyVO> selectCompanyListByName(String name);
	
	/**
	 * 회사 고유번호로 사용자 수 조회
	 * 
	 * @param comanyId
	 * @return
	 */
	int countUserByComanyId(int comanyId);
	
	/**
	 * 회사 고유번호로 테넌트 수 조회
	 * 
	 * @param comanyId
	 * @return
	 */
	int countTenantsByComanyId(int comanyId);
	
	/**
	 * 회사 고유번호로 부서 수 조회
	 * 
	 * @param comanyId
	 * @return
	 */
	int countDepartmentByComanyId(int comanyId);
	
	/**
	 * 회사 등록
	 * 
	 * @param company
	 * @return
	 */
	int insertCompany(CompanyVO company);
	
	/**
	 * 회사 수정
	 * 
	 * @param company
	 * @return
	 */
	int updateCompany(CompanyVO company);
	
	/**
	 * 회사 삭제
	 * 
	 * @param id
	 * @return
	 */
	int deleteCompany(int id);
	
}
