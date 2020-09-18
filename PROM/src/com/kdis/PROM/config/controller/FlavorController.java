package com.kdis.PROM.config.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.common.CommonUtil;
import com.kdis.PROM.config.service.FlavorService;
import com.kdis.PROM.config.vo.FlavorVO;
import com.kdis.PROM.log.service.LogService;

/**
 * 인프라 관리 > 골든 이미지 > 가상머신 자원 설정 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class FlavorController {
	
	/** 가상머신 자원 서비스 */
	@Autowired
	private FlavorService flavorService;

	/** 이력 서비스 */
	@Autowired
	private LogService logService;

	/**
	 * 인프라 관리 > 골든 이미지 > 카탈로그 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/config/catalogConfig.prom")
	public String catalogConfig() {
		return "config/catalogConfig";
	}
	
	/**
	 * 가상머신 자원 목록 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/config/selectFlavorList.do")
	public List<FlavorVO> selectFlavorList() {
		List<FlavorVO> result = flavorService.selectFlavorList(new FlavorVO());
		return result;
	}
	
	/**
	 * 가상머신 자원 ID로 가상머신 자원 조회
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/config/selectFlavor.do")
	public FlavorVO selectFlavor(Integer id) {
		FlavorVO result = flavorService.selectFlavorById(id);
		return result;
	}
	
	/**
	 * 가상머신 자원 등록
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 동일한 이름 있음
	 * 
	 * @param flavorVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/config/insertFlavor.do", method=RequestMethod.POST)
	public int insertFlavor(FlavorVO flavorVO) {

		// 결과
		int result = 0;
		
		// 가상머신 자원명 중복 체크
		// 사용자가 가상머신 자원명으로 가상머신 자원 목록을 조회한다.
		FlavorVO searchVO = new FlavorVO();
		searchVO.setName(flavorVO.getName());
		List<FlavorVO> flavorListByName = flavorService.selectFlavorList(searchVO);
		
		if(flavorListByName != null && flavorListByName.size() > 0) {
			// 가상머신 자원명 중복
			result = 2;
			return result;
		}
		
		// 가상머신 자원 등록
		result = flavorService.insertFlavor(flavorVO);
		
		// 이력 기록
		String context = "[" + flavorVO.getName() + "] ";
		context += "CPU : " + flavorVO.getvCPU() + ", ";
		context += "Memory : " + flavorVO.getMemory() + "GB, ";
		context += "설명 : " + flavorVO.getDescription();
		logService.insertLog(0, context, "가상머신 자원", "Create");

		return result;
	}
	
	/**
	 * 가상머신 자원 수정
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 동일한 이름 있음
	 * 
	 * @param flavorVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/config/updateFlavor.do", method=RequestMethod.POST)
	public  int updateFlavor(FlavorVO flavorVO) {
		
		// 결과
		int result = 0;
		
		// DB에 저장된 가상머신 자원 정보 조회
		FlavorVO dbFlavor = flavorService.selectFlavorById(flavorVO.getId());
		
		// 가상머신 자원명이 변경되었으면 중복 체크를 실시한다
		if(dbFlavor != null && 
				!CommonUtil.nullToBlank(dbFlavor.getName()).equals(CommonUtil.nullToBlank(flavorVO.getName()))) {
		
			// 사용자가 가상머신 자원명으로 가상머신 자원 목록을 조회한다.
			FlavorVO searchVO = new FlavorVO();
			searchVO.setName(flavorVO.getName());
			List<FlavorVO> flavorListByName = flavorService.selectFlavorList(searchVO);
			
			if(flavorListByName != null && flavorListByName.size() > 0) {
				// 가상머신 자원명 중복
				result = 2;
				return result;
			}
		}
		
		// 이력 내용
		String context = this.getUpdateLogContext(flavorVO, dbFlavor);
		
		// 변경된 것이 있는 경우
		if(context.length() > 0) {	
			//가상머신 자원 수정
			result = flavorService.updateFlavor(flavorVO);
			
			// 이력 기록
			context = "[" + dbFlavor.getName() + "]" + context;
			logService.insertLog(0, context, "가상머신 자원", "Update");
			
			
		} else {
			// 변경된 것이 없어도 변경 성공으로 한다.
			result = 1;
		}
		
		return result;
	}

	/**
	 * 가상머신 자원 삭제
	 * 
	 * @param flavorVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/config/deleteFlavor.do", method=RequestMethod.POST)
	public int deleteFlavor(FlavorVO flavorVO) {
		
		// 결과
		int result = 0;
		
		// 가상머신 자원 삭제
		result = flavorService.deleteFlavor(flavorVO.getId());
		
		// 이력 기록
		String context = "[" + flavorVO.getName() + "]";
		logService.insertLog(0, context, "가상머신 자원", "Delete");
		
		return result;
	}

	/**
	 * 가상머신 자원 수정 상세 이력 얻기
	 * 
	 * @param inputVO 입력한 가상머신 자원 정보
	 * @param dbVO DB에 저장된 가상머신 자원 정보
	 * @return
	 */
	private String getUpdateLogContext(FlavorVO inputVO, FlavorVO dbVO) {
		
		// 이력 내용
		StringBuffer contextBuffer = new StringBuffer();
		
		// 이름이 변경된 경우
		if (!inputVO.getName().equals(dbVO.getName())) {
			contextBuffer.append(", 이름 : ").append(dbVO.getName() + " -> " + inputVO.getName());
		}
	
		// CPU가 변경된 경우
		if (!inputVO.getvCPU().equals(dbVO.getvCPU())) {
			contextBuffer.append(", CPU : ").append(dbVO.getvCPU() + " -> " + inputVO.getvCPU());
		}
		
		// Memory가 변경된 경우
		if (!inputVO.getMemory().equals(dbVO.getMemory())) {
			contextBuffer.append(", Memory : ").append(dbVO.getMemory() + "GB -> " + inputVO.getMemory() + "GB");
		}
	
		// 설명이 변경된 경우
		if (!inputVO.getDescription().equals(dbVO.getDescription())) {
			contextBuffer.append(", 설명 : ").append(dbVO.getDescription() + " -> " + inputVO.getDescription());
		}
		
		// , 을 삭제하고 리턴한다
		if(contextBuffer.length() > 0) {
			return contextBuffer.toString().substring(1);
		} else {
			return "";
		}
	}
	
}
