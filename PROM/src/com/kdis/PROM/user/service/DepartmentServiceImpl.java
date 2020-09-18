package com.kdis.PROM.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdis.PROM.user.dao.DepartmentDAO;
import com.kdis.PROM.user.vo.DepartmentVO;

/**
 * 부서 Service 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {

	/** 부서 DAO */
	@Autowired
	DepartmentDAO departmentDAO;
	
	/**
	 * 부서 목록 조회
	 * 
	 * @param departmentVO 검색 조건
	 * @return
	 */
	@Override
	public List<DepartmentVO> selectDepartmentList(DepartmentVO departmentVO) {
		return departmentDAO.selectDepartmentList(departmentVO);
	}
	
	/**
	 * 부서 정보 조회
	 * 
	 * @param id 부서 고유번호 
	 * @param companyId 회사 ID
	 * @param deptId 부서 ID
	 * @return
	 */
	@Override
	public DepartmentVO selectDepartment(DepartmentVO departmentVO) {
		return departmentDAO.selectDepartment(departmentVO);
	}
	
	/**
	 * 부서 하위 계층 목록 조회
	 * 
	 * @param departmentVO 검색 조건
	 * @return
	 */
	@Override
	public List<DepartmentVO> selectDeptHierarchyList(int companyId, String deptId) {
		DepartmentVO departmentVO = new DepartmentVO();
		departmentVO.setCompanyId(companyId);
		departmentVO.setDeptId(deptId);
		// 지정한 부서를 포함, 그  부서의 모든 하위 부서, 그 하위, 그 하위의 하위... 를 조회한다.
		return departmentDAO.selectDeptHierarchyList(departmentVO);
	}
	
	/**
	 * 부서 상위 계층 목록 조회
	 * 
	 * @param departmentVO 검색 조건
	 * @return
	 */
	public List<DepartmentVO> selectDeptUpperHierarchyList(int companyId, String deptId) {
		DepartmentVO departmentVO = new DepartmentVO();
		departmentVO.setCompanyId(companyId);
		departmentVO.setDeptId(deptId);
		// 지정한 부서를 포함, 그  부서의 상위 부서, 그 상위, 그 상위의 상위... 를 조회한다.
		return departmentDAO.selectDeptUpperHierarchyList(departmentVO);
	}
	
	/**
	 * 해당 부서에 속한 하위 부서 수 조회
	 * 
	 * @param companyId 회사 ID
	 * @param upperdeptId 상위 부서 ID
	 * @return
	 */
	@Override
	public int countSubDepartment(int companyId, String upperdeptId) {
		DepartmentVO departmentVO = new DepartmentVO();
		departmentVO.setCompanyId(companyId);
		departmentVO.setUpperdeptId(upperdeptId);
		return departmentDAO.countSubDepartment(departmentVO);
	}
	
	/**
	 * 부서 등록
	 * 
	 * @param departmentVO
	 * @return
	 */
	@Override
	@Transactional
	public int insertDepartment (DepartmentVO departmentVO) {
		return departmentDAO.insertDepartment(departmentVO);
	}
	
	/**
	 * 부서 수정
	 * 
	 * @param departmentVO
	 * @return
	 */
	@Override
	@Transactional
	public int updateDepartment(DepartmentVO departmentVO) {
		return departmentDAO.updateDepartment(departmentVO);
	}
	
	/**
	 * 부서 삭제
	 * 
	 * @param departmentVO
	 * @return
	 */
	@Override
	@Transactional
	public int deleteDepartment(DepartmentVO departmentVO) {
		return departmentDAO.deleteDepartment(departmentVO);
	}
}
