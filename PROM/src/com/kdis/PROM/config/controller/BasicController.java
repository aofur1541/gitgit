package com.kdis.PROM.config.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.common.CommonUtil;
import com.kdis.PROM.config.service.BasicService;
import com.kdis.PROM.config.vo.BasicVO;
import com.kdis.PROM.log.service.LogService;

/**
 * 인프라 관리 > 기본 기능 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class BasicController {
	
	/** 기본 기능 서비스 */
	@Autowired
	private BasicService basicService;
	
	/** 이력 서비스 */
	@Autowired
	private LogService logService;
	
	/**
	 * 인프라 관리 > 기본 기능 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("/config/basicConfig.prom")
	public String basicConfig() {
		return "config/basicConfig";
	}

	/**
	 * 기본 기능 목록 조회
	 * 
	 * @return
	 */
	@RequestMapping("/config/selectBasicList.do")
	public @ResponseBody List<BasicVO> selectBasicList() {
		List<BasicVO> result = basicService.selectBasicList();
		return result;
	}
	
	/**
	 * 기본 기능 조회
	 * 
	 * @param targetName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/config/selectBasic.do")
	public BasicVO selectBasic(String targetName) {
		BasicVO result = basicService.selectBasicByName(targetName);
		return result;
	}
	
	/**
	 * 기본 기능 수정
	 * 
	 * @param basicVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/config/updateBasic.do", method=RequestMethod.POST)
	public int updateBasic(BasicVO basicVO) {
		
		// 결과
		int result = 0;
		
		// DB에 저장된 기본 기능 정보 조회
		BasicVO dbBasic = basicService.selectBasicByName(basicVO.getName());
		
		// 변경 내용
		String context = this.getUpdateLogContext(basicVO, dbBasic);
		
		// 변경된 것이 있는 경우
		if(context.length() > 0) {	

			// 기본 기능 수정
			result = basicService.updateBasic(basicVO);
			
			// 이력 기록
			context = "[" + dbBasic.getDisplayName() + "] " + context;
			logService.insertLog(0, context, "기본 기능", "Update");
			
		} else {
			// 변경된 것이 없어도 변경 성공으로 한다.
			result = 1;
		}
		return result;
	}
	
	
	/**
	 * 기본 기능 수정 상세 이력 얻기
	 * 
	 * @param inputVO 입력한 기본 기능 정보
	 * @param dbVO DB에 저장된 기본 기능 정보
	 * @return
	 */
	private String getUpdateLogContext(BasicVO inputVO, BasicVO dbVO) {
		
		// 이력 내용
		StringBuffer contextBuffer = new StringBuffer();

		// 대시보드 새로고침 주기가 변경된 경우
		if (inputVO.getName().equals("reflashInterval") &&
				!inputVO.getValue().equals(dbVO.getValue())) {
			contextBuffer.append(dbVO.getValue() + "초");
			contextBuffer.append(" -> ");
			contextBuffer.append(inputVO.getValue() + "초");
		}
		
		// Agent 성능 데이터 사용 여부가 변경된 경우
		if (inputVO.getName().equals("agentOnOff") &&
				!inputVO.getValue().equals(dbVO.getValue())) {
			if(inputVO.getValue() == 1) {
				contextBuffer.append("미사용 -> 사용");
			} else {
				contextBuffer.append("사용 -> 미사용");
			}
		}
		
		// 비밀번호 만료기간이 변경된 경우
		if (inputVO.getName().equals("pwExpiration") &&
				!inputVO.getValue().equals(dbVO.getValue())) {
			contextBuffer.append(dbVO.getValue() + "일");
			contextBuffer.append(" -> ");
			contextBuffer.append(inputVO.getValue() + "일");
		}
		
		// 사용자 허용 네트워크 대역이 변경된 경우
		if (inputVO.getName().equals("userAccessNetwork") &&
				!CommonUtil.nullToBlank(inputVO.getValueStr()).equals(CommonUtil.nullToBlank(dbVO.getValueStr()))) {
			contextBuffer.append(dbVO.getValueStr());
			contextBuffer.append(" -> ");
			contextBuffer.append(inputVO.getValueStr());
		}
		
		// 오토 스케일 검사 주기가 변경된 경우
		if (inputVO.getName().equals("autoScaleInterval") &&
				!inputVO.getValue().equals(dbVO.getValue())) {
			contextBuffer.append(dbVO.getValue() + "초");
			contextBuffer.append(" -> ");
			contextBuffer.append(inputVO.getValue() + "초");
		}
		
		// OTP 사용 여부가 변경된 경우
		if (inputVO.getName().equals("useOTP") &&
				!inputVO.getValue().equals(dbVO.getValue())) {
			if(inputVO.getValue() == 1) {
				contextBuffer.append("미사용 -> 사용");
			} else {
				contextBuffer.append("사용 -> 미사용");
			}
		}
		
		// 사용자 가상머신 제어 기능 활성화 여부가 변경된 경우
		if (inputVO.getName().equals("userVMCtrl") &&
				!inputVO.getValue().equals(dbVO.getValue())) {
			if(inputVO.getValue() == 1) {
				contextBuffer.append("미사용 -> 사용");
			} else {
				contextBuffer.append("사용 -> 미사용");
			}
		}
		
		return contextBuffer.toString();
	}

}
