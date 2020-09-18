package com.kdis.PROM.user.service;

import java.util.List;

import com.kdis.PROM.user.vo.DepartmentVO;

/**
 * 부서 Service interface
 * 
 * @author KimHahn
 *
 */
public interface DepartmentService {

	/**
	 * 부서 목록 조회
	 * 
	 * @param departmentVO 검색 조건
	 * @return
	 */
	public List<DepartmentVO> selectDepartmentList(DepartmentVO departmentVO);
	
	/**
	 * 부서 정보 조회
	 * 
	 * @param departmentVO 검색 조건
	 * @return
	 */
	public DepartmentVO selectDepartment(DepartmentVO departmentVO);
	
	/**
	 * 부서 하위 계층 목록 조회
	 * 
	 * @param companyId
	 * @param deptId
	 * @return
	 */
	public List<DepartmentVO> selectDeptHierarchyList(int companyId, String deptId);
	
	/**
	 * 부서 상위 계층 목록 조회
	 * 
	 * @param departmentVO 검색 조건
	 * @return
	 */
	public List<DepartmentVO> selectDeptUpperHierarchyList(int companyId, String deptId);
	
	/**
	 * 해당 부서에 속한 하위 부서 수 조회
	 * 
	 * @param departmentVO 검색 조건
	 * @return
	 */
	public int countSubDepartment(int companyId, String upperdeptId);
	
	/**
	 * 부서 등록
	 * 
	 * @param departmentVO
	 * @return
	 */
	public int insertDepartment (DepartmentVO departmentVO);
	
	/**
	 * 부서 수정
	 * 
	 * @param departmentVO
	 * @return
	 */
	public int updateDepartment(DepartmentVO departmentVO);
	
	/**
	 * 부서 삭제
	 * 
	 * @param departmentVO
	 * @return
	 */
	public int deleteDepartment(DepartmentVO departmentVO);
	
}
