package com.kdis.PROM.user.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.common.CommonUtil;
import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.tenant.service.TenantService;
import com.kdis.PROM.user.service.DepartmentService;
import com.kdis.PROM.user.service.UserService;
import com.kdis.PROM.user.vo.DepartmentVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 기초 데이터 > 부서 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class DepartmentController {

	/** 부서 서비스 */
	@Autowired
	private DepartmentService departmentService;

	/** 사용자 서비스 */
	@Autowired
	private UserService userService;

	/** 테넌트 서비스 */
	@Autowired
	private TenantService tenantService;
	
	/** 이력 서비스 */
	@Autowired
	private LogService logService;
	
	/**
	 * 기초 데이터 > 부서 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/user/manageDepartment.prom")
	public String manageDepartment() {
		return "/user/manageDepartment";
	}
	
	/**
	 * 부서 목록 조회
	 * 
	 * @param departmentVO
	 * @return
	 */
	@RequestMapping("/user/selectDeptList.do")
	public @ResponseBody List<DepartmentVO> selectDeptList(DepartmentVO departmentVO) {
		// 부서 목록 조회
		List<DepartmentVO> departmentList = departmentService.selectDepartmentList(departmentVO);
		return departmentList;
	}
	
	/**
	 * 부서 정보 조회
	 * 
	 * @param departmentVO
	 * @return
	 */
	@RequestMapping("/user/selectDept.do")
	public @ResponseBody DepartmentVO selectDept(DepartmentVO departmentVO) {
		// 부서 정보 조회
		DepartmentVO department = departmentService.selectDepartment(departmentVO);
		return department;
	}
	
	/**
	 * 부서 등록
	 * 
	 * 결과
	 * - 1 : 부서 등록 성공
	 * - 2 : 동일한 부서 코드 있음
	 * - 3 : 동일한 부서명 있음
	 * 
	 * @param departmentVO
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/user/insertDept.do", method=RequestMethod.POST)
	public @ResponseBody int insertDept(DepartmentVO departmentVO, HttpSession session) {
		
		// 결과
		int result = 0;

		// 부서 코드 중복 체크
		// 부서 코드로 부서 목록 조회
		DepartmentVO codeDuplicationParam = new DepartmentVO();
		codeDuplicationParam.setCompanyId(departmentVO.getCompanyId());
		codeDuplicationParam.setDeptId(departmentVO.getDeptId());
		List<DepartmentVO> departmentListByCode = departmentService.selectDepartmentList(codeDuplicationParam);
		
		if (!CommonUtil.isEmpty(departmentListByCode)) {
			// 해당 회사에 중복된 부서 코드 있음
			result = 2;
			return result;
		}
		
		// 부서명 중복 체크
		// 부서명으로 부서 목록 조회
		DepartmentVO nameDuplicationParam = new DepartmentVO();
		nameDuplicationParam.setCompanyId(departmentVO.getCompanyId());
		nameDuplicationParam.setName(departmentVO.getName());
		List<DepartmentVO> departmentListByName = departmentService.selectDepartmentList(nameDuplicationParam);
		
		if (!CommonUtil.isEmpty(departmentListByName)) {
			// 해당 회사에 중복된 부서명 있음
			result = 3;
			return result;
		}

		// 부서 등록
		result = departmentService.insertDepartment(departmentVO);
		
		// 로그 기록
		String isUseStr = "";
		if (departmentVO.getIsUse() == 1) {
			isUseStr = "ON";
		} else if (departmentVO.getIsUse() == 0) {
			isUseStr = "OFF";
		}

		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "[" + departmentVO.getName() + "] ";
		sContext += " 회사 : " + departmentVO.getCompanyName() + ",";
		sContext += " 상위 부서 : " + departmentVO.getUpperdeptName() + ",";
		sContext += " 부서 이름 : " + departmentVO.getName() + ",";
		sContext += " 부서 코드 : " + departmentVO.getDeptId() + ",";
		sContext += " 사용 여부 : " + isUseStr + ",";
		sContext += " 설명 : " + departmentVO.getDescription();

		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "부서", "Create");
		
		return result;
	}
	

	/**
	 * 부서 수정
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 부서명 중복
	 * 3 : 테넌트에 속해있는 부서는 미사용으로 변경한 경우
	 * 
	 * @param departmentVO
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/user/updateDept.do", method=RequestMethod.POST)
	public @ResponseBody int updateDept(DepartmentVO departmentVO, HttpSession session) {
		
		// 결과
		int result = 1;
		
		// 부서 정보 얻기
		DepartmentVO dbDepartment = departmentService.selectDepartment(departmentVO);
		
		// 부서명이 변경된 경우
		if(!dbDepartment.getName().equals(departmentVO.getName())) {
			
			// 부서명 중복 체크
			// 부서명으로 부서 목록 조회
			DepartmentVO nameDuplicationParam = new DepartmentVO();
			nameDuplicationParam.setCompanyId(departmentVO.getCompanyId());
			nameDuplicationParam.setName(departmentVO.getName());
			List<DepartmentVO> departmentListByName = departmentService.selectDepartmentList(nameDuplicationParam);
			
			if (!CommonUtil.isEmpty(departmentListByName)) {
				// 해당 회사에 중복된 부서명 있음
				result = 2;
				return result;
			}
		}
		
		// 미사용으로 변경되는 경우
		if(departmentVO.getIsUse() == 0 && departmentVO.getIsUse() != dbDepartment.getIsUse()) {
			// 해당 부서에 속한 테넌트 수 조회
			int tenantsCount = tenantService.countTenantsByDeptId(departmentVO.getCompanyId(), departmentVO.getDeptId());
			
			// 테넌트가 속해있는 부서는 미사용으로 변경할 수 없음
			if(tenantsCount > 0) {
				result = 3;
				return result;
			}
		}

		// 이력 내용
		StringBuffer contextBuffer = new StringBuffer();

		// 부서명이 변경된 경우
		if (!departmentVO.getName().equals(dbDepartment.getName())) {
			contextBuffer.append(", 부서명 : ").append(dbDepartment.getName() + " -> " + departmentVO.getName());
		}

		// 사용여부가 변경된 경우
		if (departmentVO.getIsUse() != dbDepartment.getIsUse()) {
			if (departmentVO.getIsUse() == 1) {
				contextBuffer.append(", 사용 여부 : ").append("OFF -> ON");
			} else if (departmentVO.getIsUse() == 0) {
				contextBuffer.append(", 사용 여부 : ").append("ON -> OFF");
			}
		}
		
		// 설명이 변경된 경우
		if (!departmentVO.getDescription().equals(dbDepartment.getDescription())) {
			contextBuffer.append(", 설명 : ").append(dbDepartment.getDescription() + " -> " +  departmentVO.getDescription());
		}

		// 변경된 것이 있는 경우
		if(contextBuffer.length() > 0) {
			
			// 부서 정보 수정
			result = departmentService.updateDepartment(departmentVO);

			// 로그인 정보 얻기
			UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
			
			// 로그 기록
			String sContext = "[" + dbDepartment.getName() + "] " + contextBuffer.toString().substring(1);
			logService.insertLog(loginInfo.getsUserID(), 0, sContext, "부서", "Update");
		} else {
			// 변경된 것이 없어도 변경 성공으로 한다.
			result = 1;
		}
		
		return result;
	}

	/**
	 * 부서 삭제
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 하위 부서 있음
	 * 3 : 테넌트에 속해 있음
	 * 4 : 사용자 있음
	 * 
	 * @param departmentVO
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/user/deleteDept.do", method=RequestMethod.POST)
	public @ResponseBody int deleteDept(DepartmentVO departmentVO, HttpSession session) {
		
		// 결과
		int result = 0;
		
		// 해당 부서에 속한 하위 부서가 있는지 조회
		int subDeptCount = departmentService.countSubDepartment(departmentVO.getCompanyId(), departmentVO.getDeptId());
		// 하위 부서가 있으면 삭제할 수 없음
		if(subDeptCount > 0) {
			result = 2;
			return result;
		}
		
		// 해당 부서에 속한 테넌트 수 조회
		int tenantsCount = tenantService.countTenantsByDeptId(departmentVO.getCompanyId(), departmentVO.getDeptId());
		// 테넌트가 속해있는 부서는 삭제할 수 없음
		if(tenantsCount > 0) {
			result = 3;
			return result;
		}
		
		// 해당 부서에 속한 사용자 수 조회
		int userCount = userService.countUserByDeptId(departmentVO.getCompanyId(), departmentVO.getDeptId());
		// 하위 부서가 있으면 삭제할 수 없음
		if(userCount > 0) {
			result = 4;
			return result;
		}

		// 부서 정보 얻기
		DepartmentVO dbDepartment = departmentService.selectDepartment(departmentVO);
		
		// 부서 삭제
		result = departmentService.deleteDepartment(departmentVO);
		
		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "[" + dbDepartment.getName() + "]";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "부서", "Delete");
		
		return result;
	}
}
