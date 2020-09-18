package com.kdis.PROM.config.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.apply.service.VMService;
import com.kdis.PROM.apply.vo.VMDataVO;
import com.kdis.PROM.log.service.LogService;

/**
 * 인프라 관리 > 골든 이미지 > 템플릿 선택 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class VMTemplateController {

	/** 가상머신 서비스 */
	@Autowired
	private VMService vmDataService;

	/** 이력 서비스 */
	@Autowired
	private LogService logService;
	
	/**
	 * 인프라 관리 > 골든 이미지 > 템플릿 선택 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/config/templateConfig.prom")
	public String templateConfig() {
		return "config/templateConfig";
	}
	
	/**
	 * 가상머신 템플릿 목록 조회
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/config/selectVMTemplateList.do")
	public List<VMDataVO> selectVMTemplateList() {
		List<VMDataVO> result = vmDataService.selectVMTemplateList();
		return result;
	}

	/**
	 * 가상머신 템플릿 조회
	 * 
	 * @param vmID 가상머신 아이디
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/config/selectVMTemplate.do")
	public VMDataVO templateOneInfo(String vmID) {
		VMDataVO result = vmDataService.selectVMData(vmID);
		return result;
	}
	
	/**
	 * 가상머신 템플릿 수정
	 * 
	 * @param VMDataVO
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/config/updateVMTemplate.do", method=RequestMethod.POST)
	public int updateVMTemplate(VMDataVO template, HttpSession session) {
		
		// 결과
		int result = 0;
		
		// DB에 저장된 템플릿 정보 조회
		VMDataVO dbVMTemplate = vmDataService.selectVMData(template.getVmID());
		
		// 변경내용
		String context = "";
		// 적용 여부
		if (!template.getTemplateOnoff().equals(dbVMTemplate.getTemplateOnoff())) {
			if(template.getTemplateOnoff() == 1) {
				context += ", 적용 여부 : 미적용 - > 적용";
			} else {
				context += ", 적용 여부 : 적용 - > 미적용";
			}
		}
		// 설명
		if (!template.getDescription().equals(dbVMTemplate.getDescription())) {
			context += ", 설명 : ";
			context += dbVMTemplate.getDescription();
			context += " -> ";
			context += template.getDescription();
		}
		
		if(context.length() > 0) {
			// 변경된 것이 있는 경우

			// 가상머신 템플릿 수정
			result = vmDataService.updateVMTemplate(template);
			
			//이력 기록
			context = "[" + dbVMTemplate.getVmName() + "] " + context.substring(1);
			logService.insertLog(0, context, "템플릿", "Update");
			
		} else {
			// 변경된 것이 없어도 변경 성공으로 한다.
			result = 1;
		}
		
		return result;
	}
}
