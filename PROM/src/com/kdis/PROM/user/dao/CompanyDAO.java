package com.kdis.PROM.user.dao;

import java.util.List;

import com.kdis.PROM.user.vo.CompanyVO;

/**
 * 회사 DAO interface
 * 
 * @author KimHahn
 *
 */
public interface CompanyDAO {
	
	/**
	 * 회사 고유번호로 회사 목록 조회
	 * 
	 * @param id 회사 고유번호
	 * @return
	 */
	public List<CompanyVO> selectCompanyListById(Integer id);
	
	/**
	 * 회사명으로 회사 목록 조회
	 * 
	 * @param Name 회사명
	 * @return
	 */
	public List<CompanyVO> selectCompanyListByName(String name);

	/**
	 * 회사 고유번호로 회사 정보 조회
	 * 
	 * @param id 회사 고유번호
	 * @return
	 */
	public CompanyVO selectCompanyById(int id);
	
	/**
	 * 회사 고유번호로 사용자 수 조회
	 * 
	 * @param comanyId
	 * @return
	 */
	public int countUserByComanyId(int comanyId);
	
	/**
	 * 회사 고유번호로 테넌트 수 조회
	 * 
	 * @param comanyId
	 * @return
	 */
	public int countTenantsByComanyId(int comanyId);
	
	/**
	 * 회사 고유번호로 부서 수 조회
	 * 
	 * @param comanyId
	 * @return
	 */
	public int countDepartmentByComanyId(int comanyId);
	
	/**
	 * 회사 등록
	 * 
	 * @param company
	 * @return
	 */
	public int insertCompany(CompanyVO company);
	
	/**
	 * 회사 수정
	 * 
	 * @param company
	 * @return
	 */
	public int updateCompany(CompanyVO company);
	
	/**
	 * 회사 삭제
	 * 
	 * @param id
	 * @return
	 */
	public int deleteCompany(int id);
}
