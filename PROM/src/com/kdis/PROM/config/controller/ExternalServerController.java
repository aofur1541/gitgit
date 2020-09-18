package com.kdis.PROM.config.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdis.PROM.common.AESUtil;
import com.kdis.PROM.config.service.ExternalServerService;
import com.kdis.PROM.config.vo.ExternalServerTypeEnum;
import com.kdis.PROM.config.vo.ExternalServerVO;
import com.kdis.PROM.log.service.LogService;

/**
 * 인프라 관리 > 외부 서버 연동 현황 Controller
 * 
 * @author KimHahn
 *
 */
@Controller
public class ExternalServerController {

	/** 외부 서버 서비스 */
	@Autowired
	private ExternalServerService serverService;
	
	/** 이력 서비스 */
	@Autowired
	private LogService logService;
	
	/**
	 * 인프라 관리 > 외부 서버 연동 현황 화면으로 이동
	 * 
	 * @return
	 */
	@RequestMapping("config/externalServerConfig.prom")
	public String externalServerConfig() {
		return "config/externalServerConfig";
	}
	
	/**
	 * 외부 서버 목록 조회
	 * 
	 * @return
	 */
	@RequestMapping("/config/selectExternalServerList.do")
	public @ResponseBody List<ExternalServerVO> selectExternalServerList() {
		List<ExternalServerVO> result = null;
		result = serverService.selectExternalServerList(new ExternalServerVO());
		return result;
	}
	
	/**
	 * 외부 서버 조회
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/config/selectExternalServer.do")
	public ExternalServerVO selectExternalServer(Integer id) throws Exception {
		// 외부 서버 조회
		ExternalServerVO result = serverService.selectExternalServer(id);

		// 비밀번호 복호화
		AESUtil aesUtil = new AESUtil();
		String decString = aesUtil.decrypt(result.getPassword());
		result.setPassword(decString);
		
		return result;
	}
	
	/**
	 * 서버 종류로 외부 서버  조회
	 * 
	 * @param serverType
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/config/selectExternalServerByServerType.do")
	public ExternalServerVO selectExternalServerByServerType(Integer serverType) throws Exception {
		// int 서버 종류로 부터 서버 종류 Enum 얻기
		ExternalServerTypeEnum serverTypeEnum = ExternalServerTypeEnum.valueOfServerType(serverType);
		// 서버 종류로 외부 서버  조회
		ExternalServerVO result = serverService.selectExternalServerByServerType(serverTypeEnum);
		return result;
	}
	
	/**
	 * 외부 서버 등록
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 서버 종류 중복
	 * 
	 * @param externalServerVO
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping(value="/config/insertExternalServer.do", method=RequestMethod.POST)
	public int insertExternalServer(ExternalServerVO externalServerVO) throws Exception {
		
		// 결과
		int result = 0;
		
		// 서버 종류 중복 체크
		ExternalServerVO searchVO = new ExternalServerVO();
		searchVO.setServerType(externalServerVO.getServerType());
		List<ExternalServerVO> serverListByServerType = serverService.selectExternalServerList(searchVO);
		if(serverListByServerType != null && serverListByServerType.size() > 0) {
			// 이미 등록된 서버 종류
			result = 2;
			return result;
		}
		
		// 비밀번호 AES 암호화
		AESUtil aesUtil = new AESUtil();
		String encString = aesUtil.encrypt(externalServerVO.getPassword());
		externalServerVO.setPassword(encString);
		
		// 외부 서버 등록
		result = serverService.insertExternalServer(externalServerVO);
		
		// 이력 기록
		String context = "[" + externalServerVO.getName() + "]";
		context += " 서버종류 : " + this.getServerTypeName(externalServerVO.getServerType()) + ",";
		context += " 연결 종류 : " + externalServerVO.getConnectString() + ",";
		context += " ID : " + externalServerVO.getAccount() + ",";
		context += " Port : " + externalServerVO.getPort() + ",";
		if (externalServerVO.getSsl() == 1) {
			context += " SSL : 사용,";
		} else {
			context += " SSL : 미사용,";
		}
		if (externalServerVO.getIsUse() == 1) {
			context += " 사용여부 : 사용";
		} else {
			context += " 사용여부 : 미사용";
		}
		
		logService.insertLog(0, context, "외부 서버", "Create");

		return result;
	}
	
	/**
	 * 외부 서버 수정
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 서버 종류 변경
	 * 
	 * @param externalServerVO
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/config/updateExternalServer.do", method=RequestMethod.POST)
	public int updateExternalServer(ExternalServerVO externalServerVO) throws Exception {
		
		System.out.println("1 자이제 시작");
		// 결과
		int result = 0;
		
		// DB에 저장된 외부 서버 정보 조회
		ExternalServerVO dbExternalServer = serverService.selectExternalServer(externalServerVO.getId());
		
		// 서버 종류가 변경된 경우
		if(!dbExternalServer.getServerType().equals(externalServerVO.getServerType())) {
			// 서버 종류는 변경할 수 없다
			result = 2;
			return result;
		}
		
		// 비밀번호 AES 암호화
		AESUtil aesUtil = new AESUtil();
		String encString = aesUtil.encrypt(externalServerVO.getPassword());
		externalServerVO.setPassword(encString);
				
		// 이력 내용
		String context = this.getUpdateLogContext(externalServerVO, dbExternalServer);
		
		// 변경된 것이 있는 경우
		if(context.length() > 0) {	
			
			// 외부 서버 수정
			result = serverService.updateExternalServer(externalServerVO);
			
			// 이력 기록
			context = "[" + dbExternalServer.getName() + "]" + context;
			logService.insertLog(0, context, "외부 서버", "Update");
			
		} else {
			// 변경된 것이 없어도 변경 성공으로 한다.
			result = 1;
		}
		return result;
	}
	
	/**
	 * 외부 서버 삭제
	 * 
	 * @param externalServerVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/config/deleteExternalServer.do", method=RequestMethod.POST)
	public int serverDelete(ExternalServerVO externalServerVO) {
		
		// 외부 서버 삭제
		int result = serverService.deleteExternalServer(externalServerVO.getId());
		
		// 이력 기록
		String context = "[" + externalServerVO.getName() + "]";
		logService.insertLog(0, context, "외부 서버", "Delete");
		
		return result;
	}
	
	/**
	 * 서버 종류명 얻기
	 * 
	 * @param type
	 * @return
	 */
	private String getServerTypeName(int type) {
		String result = "";

		switch (type) {
		case 1:
			result = "vCenter";
			break;
		case 2:
			result = "vRealize Orchestrator";
			break;
		case 3:
			result = "vRealize Operations";
			break;
		case 4:
			result = "vRealize Automation";
			break;
		case 5:
			result = "Email";
			break;
		case 6:
			result = "OTP Server";
			break;
		default:
			result = "";
			break;
		}
		return result;
	}
	
	/**
	 * 외부 서버 수정 상세 이력 얻기
	 * 
	 * @param inputVO 입력한 외부 서버 정보
	 * @param dbVO DB에 저장된 외부 서버 정보
	 * @return
	 */
	private String getUpdateLogContext(ExternalServerVO inputVO, ExternalServerVO dbVO) {
		
		// 이력 내용
		StringBuffer contextBuffer = new StringBuffer();

		// 서버 종류가 변경된 경우
		if (!dbVO.getServerType().equals(inputVO.getServerType())) {
			contextBuffer.append(", 서버 종류 : ");
			contextBuffer.append(this.getServerTypeName(dbVO.getServerType()));
			contextBuffer.append(" -> ");
			contextBuffer.append(this.getServerTypeName(inputVO.getServerType()));
		}
		
		// 이름이 변경된 경우
		if (!dbVO.getName().equals(inputVO.getName())) {
			contextBuffer.append(", 이름 : ").append(dbVO.getName() + " -> " + inputVO.getName());
		}
	
		// ID가 변경된 경우
		if (!dbVO.getAccount().equals(inputVO.getAccount())) {
			contextBuffer.append(", ID : ").append(dbVO.getAccount() + " -> " + inputVO.getAccount());
		}
		
		// 비밀번호가 변경된 경우
		if (!dbVO.getPassword().equals(inputVO.getPassword())) {
			contextBuffer.append(", 비밀번호 변경 ");
		}
	
		// Port가 변경된 경우
		if (!dbVO.getPort().equals(inputVO.getPort())) {
			contextBuffer.append(", Port : ").append(dbVO.getPort() + " -> " + inputVO.getPort());
		}
	
		// 사용 여부가 변경된 경우
		if (!dbVO.getIsUse().equals(inputVO.getIsUse())) {
			if(inputVO.getIsUse() == 1) {
				contextBuffer.append(", 사용여부 : 미사용 -> 사용 ");
			} else {
				contextBuffer.append(", 사용여부 : 사용 -> 미사용 ");
			}
		}
	
		// SSL가 변경된 경우
		if (dbVO.getSsl() != null && !dbVO.getSsl().equals(inputVO.getSsl())) {
			if(inputVO.getSsl() == 1) {
				contextBuffer.append(", SSL : 미사용 -> 사용 ");
			} else {
				contextBuffer.append(", SSL : 사용 -> 미사용 ");
			}
		}
	
		// 설명이 변경된 경우
		if (!dbVO.getDescription().equals(inputVO.getDescription())) {
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
