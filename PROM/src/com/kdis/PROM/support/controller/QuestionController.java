package com.kdis.PROM.support.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.support.service.QuestionService;
import com.kdis.PROM.support.vo.QuestionVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 고객 지원 > 문의 사항 Controller class
 * 
 * @author KimHahn
 *
 */
@Controller
public class QuestionController {

	private static final Log LOG = LogFactory.getLog(QuestionController.class);

	/** 문의사항 서비스 */
	@Autowired
	private QuestionService questionService;
	
	/** 이력 service */
	@Autowired
	private LogService logService;
	
	/**
	 * 고객 지원 > 문의 사항 화면으로 이동
	 * 
	 * @return
	 */
	// TODO 새로운 화면 적용 이후에 /support/question.do 로 변경해 줘야 함
	//@RequestMapping("/support/question.do")
	@RequestMapping("/support/question.prom")
	public String question() {
		//return "/support/questions";
		return "/support/question";
	}
	
	/**
	 * 문의사항 목록 조회
	 * 
	 * @return
	 */
	@RequestMapping("/support/selectQuestionList.do")
	public @ResponseBody List<QuestionVO> selectQuestionList() {
		List<QuestionVO> result = questionService.selectQuestionList();
		return result;
	}
	
	/**
	 * 고객 지원 > 문의사항 질문 등록 화면으로 이동
	 * 
	 * @return
	 */
	// TODO 새로운 화면 적용 이후에 /support/addQuestion.do 로 변경해 줘야 함
	//@RequestMapping("/support/addQuestion.do")
	@RequestMapping("/support/addQuestion.prom")
	public ModelAndView addQuestion() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("support/addQuestion");
		return mav;
	}
	
	/**
	 * 고객 지원 > 문의사항 상세 화면으로 이동
	 * 
	 * @param mv
	 * @param id
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	

	/*
	 * .do 사용 시 v1 UI가 나오는 현상 해결법
	 * .prom 으로 변경 (v1이 덜 걷혀서 v1에 연결된 css로 출력됨)
	 * v1 걷어낸 후에 다시 .do로 변경하거나 .prom을 화면이동할 때 URL용으로 분리해서 사용
	 */	
	
	
	// TODO 새로운 화면 적용 이후에 /support/viewQuestion.do 로 변경해 줘야 함
	//@RequestMapping("/support/viewQuestion.do")
	
	@RequestMapping("/support/viewQuestion.prom")
	public ModelAndView viewQuestion(ModelAndView mv, int id) throws UnsupportedEncodingException {
		
		// 해당 문의사항 정보 얻기
		QuestionVO viewQuestion = questionService.selectQuestion(id);
		// 해당 문의사항의 전 문의사항 정보 얻기
		QuestionVO preQuestion = questionService.selectPreQuestion(id);
		// 해당 문의사항의 다음 문의사항 정보 얻기
		QuestionVO nextQuestion = questionService.selectNextQuestion(id);
		
		// 질문 url 디코딩
		String decodedQuestion = URLDecoder.decode(viewQuestion.getQuestion(), "UTF-8")
				.replaceAll("\\%20", " ").replace("\\%2B", "+").replaceAll("\\%21", "!").replaceAll("\\%27", "'")
				.replaceAll("\\%28", "(").replaceAll("\\%29", ")").replaceAll("\\%7E", "~");
		viewQuestion.setQuestion(decodedQuestion);
		
		// 답변이 있으면 url 디코딩
		if(viewQuestion.getAnswer() != null && !"".equals(viewQuestion.getAnswer())) {
			String decodedAnswer = URLDecoder.decode(viewQuestion.getAnswer(), "UTF-8")
					.replaceAll("\\%20", " ").replace("\\%2B", "+").replaceAll("\\%21", "!")
					.replaceAll("\\%27", "'").replaceAll("\\%28", "(").replaceAll("\\%29", ")")
					.replaceAll("\\%7E", "~");
			viewQuestion.setAnswer(decodedAnswer);
		}
		
		mv.addObject("viewQuestions", viewQuestion);
		mv.addObject("getPre", preQuestion);
		mv.addObject("getNext", nextQuestion);
		
		// FIXME 새로운 화면 적용 이후에 /support/viewQuestions 로 변경해 줘야 함
		mv.setViewName("/support/viewQuestion");
		
		return mv;
	}
	
	/**
	 * 고객 지원 > 문의사항 질문 수정 화면으로 이동
	 * 
	 * @param mv
	 * @param id
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	// TODO 새로운 화면 적용 이후에 /support/editQuestion.do 로 변경해 줘야 함
	//@RequestMapping("/support/editQuestion.do")
	@RequestMapping(value = "/support/editQuestion.prom")
	public ModelAndView updateSelectQuestions(ModelAndView mv, int id) throws UnsupportedEncodingException {
		
		// 해당 문의사항 정보 얻기
		QuestionVO viewQuestion = questionService.selectQuestion(id);
				
		// 질문, 답변 URL 디코딩
		if(viewQuestion.getQuestion() != null && !"".equals(viewQuestion.getQuestion())) {
			String decodedQuestion = URLDecoder.decode(viewQuestion.getQuestion(), "UTF-8").replaceAll("\\%20", " ")
					.replace("\\%2B", "+").replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(")
					.replaceAll("\\%29", ")").replaceAll("\\%7E", "~");
			viewQuestion.setQuestion(decodedQuestion);
		}
		mv.addObject("updateQuestions", viewQuestion);
		mv.setViewName("support/editQuestion");//FIXME 새로운 화면 적용 이후에 /support/updateAnswer 로 변경해 줘야 함
		//data/updateQuestions
		return mv;
	}
	
	/**
	 * 고객 지원 > 문의사항 답변 등록 화면으로 이동
	 * 
	 * @param mv
	 * @param id
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/support/addAnswer.prom")
	public ModelAndView getQuestions(ModelAndView mv, int id) throws UnsupportedEncodingException {
		// 해당 문의사항 정보 얻기
		QuestionVO viewQuestion = questionService.selectQuestion(id);
		
		// 질문, 답변 URL 디코딩
		if(viewQuestion.getQuestion() != null && !"".equals(viewQuestion.getQuestion())) {
			String decodedQuestion = URLDecoder.decode(viewQuestion.getQuestion(), "UTF-8").replaceAll("\\%20", " ")
				.replace("\\%2B", "+").replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(")
				.replaceAll("\\%29", ")").replaceAll("\\%7E", "~");
			viewQuestion.setQuestion(decodedQuestion);
		}
		if(viewQuestion.getAnswer() != null && !"".equals(viewQuestion.getAnswer())) {
			String decodedAnswer = URLDecoder.decode(viewQuestion.getAnswer(), "UTF-8").replaceAll("\\%20", " ")
				.replace("\\%2B", "+").replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(")
				.replaceAll("\\%29", ")").replaceAll("\\%7E", "~");
			viewQuestion.setAnswer(decodedAnswer);
		}
		
		mv.addObject("getQuestions", viewQuestion);
		mv.setViewName("support/addAnswer");//FIXME 새로운 화면 적용 이후에 /support/editAnswer 로 변경해 줘야 함
		
		return mv;
	}
	
	/**
	 * 고객 지원 > 문의사항 답변 수정 화면으로 이동
	 * 
	 * @param mv
	 * @param id
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	// TODO 새로운 화면 적용 이후에 /support/editAnswer.do 로 변경해 줘야 함
	//@RequestMapping("/support/editAnswer.do")
	@RequestMapping(value = "/support/editAnswer.prom")
	public ModelAndView editAnswer(ModelAndView mv, int id) throws UnsupportedEncodingException {
		
		// 해당 문의사항 정보 얻기
		QuestionVO viewQuestion = questionService.selectQuestion(id);
		
		// 질문, 답변 URL 디코딩
		if(viewQuestion.getQuestion() != null && !"".equals(viewQuestion.getQuestion())) {
			String decodedQuestion = URLDecoder.decode(viewQuestion.getQuestion(), "UTF-8").replaceAll("\\%20", " ")
				.replace("\\%2B", "+").replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(")
				.replaceAll("\\%29", ")").replaceAll("\\%7E", "~");
			viewQuestion.setQuestion(decodedQuestion);
		}
		if(viewQuestion.getAnswer() != null && !"".equals(viewQuestion.getAnswer())) {
			String decodedAnswer = URLDecoder.decode(viewQuestion.getAnswer(), "UTF-8").replaceAll("\\%20", " ")
				.replace("\\%2B", "+").replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(")
				.replaceAll("\\%29", ")").replaceAll("\\%7E", "~");
			viewQuestion.setAnswer(decodedAnswer);
		}
		
		mv.addObject("updateAnswer", viewQuestion);
		mv.setViewName("/support/editAnswer");//FIXME 새로운 화면 적용 이후에 /support/updateAnswer 로 변경해 줘야 함
		
		return mv;
	}
	
	/**
	 * 답변이 없는 문의사항 개수 얻기
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/support/countUnansweredQuestion.do")
	public  int countUnansweredQuestion() {
		// 답변이 없는 문의사항 개수 얻기
		int result = questionService.countUnansweredQuestion();
		return result;
	}
	
	/**
	 * 문의사항 질문 등록
	 * 
	 * @param questionVO
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@ResponseBody
	@RequestMapping(value = "/support/insertQuestion.do", method = RequestMethod.POST)
	public void insertQuestion(QuestionVO questionVO, HttpSession session) throws UnsupportedEncodingException {
		
		String sysdate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		// tomcat 위치
		String catalina = System.getProperty("catalina.home");
		
		// 임시 저장 디렉토리
		String tempFolder = catalina + "/attachedFile/questionsTemp";
		
		// 정식 저장 디렉토리
		String imageFolder = catalina + "/attachedFile/images/" + sysdate;
		
		// 업로드한 이미지 파일를 임시 저장 공간에서 정식 저장 공간으로 이동시키기
		if(questionVO.getTempFilesName() != null && questionVO.getTempFilesName().length > 0) {
			for (int i = 0; i < questionVO.getTempFilesName().length; i++) {
				
				// 임시 파일이 실제 문의사항 본문에 포함 안된 경우에는 그냥 패스
				if (!questionVO.getQuestion().contains(questionVO.getTempFilesName()[i])) {
					continue;
				}
				
				// 파일 url에서 파일명만 얻기
				String fileName = questionVO.getTempFilesName()[i].replaceAll("img/attachedFile/questionsTemp/" + sysdate + "/", "");
				
				// 임시 파일 경로
				String tempPath = tempFolder + "/" + sysdate + fileName;
				
				// 정식 파일 경로
				String imagePath = imageFolder + fileName;
				
				try {
					
					File in = new File(tempPath);
					File out = new File(imagePath);
					File outFile = new File(imageFolder);
					
					// 정식 저장 디렉토리가 없는 경우에는 생성
					if (!outFile.exists()) {
						outFile.mkdirs();
					}
					
					// 이미지 파일을 임시 저장 공간에서 정식 공간으로 복사하고 임시 저장 공간의 파일을 삭제한다.
					// 파일 복사
					FileCopyUtils.copy(in, out);
					// 임시 파일 삭제
					in.delete();
					
				} catch (IOException e) {
					LOG.error(e);
				}
			}
		}
		
		// 질문에 있는 이미지 파일의 url을 임시에서 정식으로 변경
		questionVO.setQuestion(questionVO.getQuestion().replaceAll("src=\"/img/attachedFile/questionsTemp",
				"src=\"/img/attachedFile/images"));
		
		// url 인코딩
		String encodedQuestion = URLEncoder.encode(questionVO.getQuestion(), "UTF-8").replaceAll(" ", "\\%20")
				.replace("\\+", "\\%2B").replaceAll("\\!", "\\%21").replaceAll("\\'", "\\%27")
				.replaceAll("\\(", "\\%28").replaceAll("\\)", "\\%29").replaceAll("\\~", "\\%7E");
		questionVO.setQuestion(encodedQuestion);
		
		// 문의사항 질문 등록
		questionService.insertQuestion(questionVO);
		
		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "[" + questionVO.getTitle() + "]" + " 문의 작성";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "문의사항", "Create");
		
	}
	
	/**
	 * 문의사항 질문 수정
	 * 
	 * @param questions
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@ResponseBody
	@RequestMapping(value = "/support/updateQuestion.do", method = RequestMethod.POST)
	public int updateQuestion(QuestionVO questionVO, HttpSession session) throws UnsupportedEncodingException {
		
		// 결과
		int result = 0;
		
		// DB에서 저장된 문의사항 정보(원본)를 조회한다.
		QuestionVO dbQuestion = questionService.selectQuestion(questionVO.getId());
		
		// tomcat 위치
		String catalina = System.getProperty("catalina.home");
		
		// 업로드한 이미지 파일를 임시 저장 공간에서 정식 저장 공간으로 이동시키기
		if(questionVO.getTempFilesName() != null && questionVO.getTempFilesName().length > 0) {
			for (int i = 0; i < questionVO.getTempFilesName().length; i++) {
				
				// 임시 파일이 실제 문의사항 본문에 포함 안된 경우에는 그냥 패스
				if (!questionVO.getQuestion().contains(questionVO.getTempFilesName()[i])) {
					continue;
				}
				
				// 임시 파일 경로
				String tempPath = questionVO.getTempFilesName()[i].replace("/img/attachedFile/questionsTemp/",
						catalina + "/attachedFile/questionsTemp/");
				
				// 정식 파일 경로
				String imagePath = questionVO.getTempFilesName()[i].replace("/img/attachedFile/questionsTemp/",
						catalina + "/attachedFile/images/");
				
				// 정식 파일의 디렉토리 경로
				String folder = imagePath.substring(0, imagePath.lastIndexOf("/"));
				
				try {
					
					File inFile = new File(tempPath);
					File outFile = new File(imagePath);
					File folderFile = new File(folder);
					
					// 정식 저장 디렉토리가 없는 경우에는 생성
					if (!folderFile.exists()) {
						folderFile.mkdirs();
					}
					
					// 이미지 파일을 임시 저장 공간에서 정식 공간으로 복사하고 임시 저장 공간의 파일을 삭제한다.
					// 파일 복사
					FileCopyUtils.copy(inFile, outFile);
					
					// 임시 파일 삭제
					inFile.delete();
					
				} catch (IOException e) {
					LOG.error(e);
				}
			}
		}
		
		// 에디터에서 삭제한 이미지의 물리적 파일도 삭제한다.
		if(questionVO.getTempDeleteName() != null && questionVO.getTempDeleteName().length > 0) {
			for (int i = 0; i < questionVO.getTempDeleteName().length; i++) {
				
				LOG.debug("TempDeleteName : " + questionVO.getTempDeleteName()[i]);
				
				// 삭제된 이미지 파일을 물리적으로도 삭제한다.
				// 정식 파일 경로
				String deleteImagePath = questionVO.getTempDeleteName()[i].replace("/img/attachedFile/images/",
						catalina + "/attachedFile/images/");
				
				LOG.debug("deleteImagePath : " + questionVO.getTempDeleteName()[i]);
				
				File deleteFile = new File(deleteImagePath);
				deleteFile.delete();
			}
		}
		
		// 질문에 있는 이미지 파일의 url을 임시에서 정식으로 변경
		questionVO.setQuestion(questionVO.getQuestion().replaceAll("src=\"/img/attachedFile/questionsTemp",
				"src=\"/img/attachedFile/images"));
		
		// 질문 URL 인코딩
		String encodedQuestion = URLEncoder.encode(questionVO.getQuestion(), "UTF-8").replaceAll(" ", "\\%20")
				.replace("\\+", "\\%2B").replaceAll("\\!", "\\%21").replaceAll("\\'", "\\%27")
				.replaceAll("\\(", "\\%28").replaceAll("\\)", "\\%29").replaceAll("\\~", "\\%7E");
		questionVO.setQuestion(encodedQuestion);
		
		result = questionService.updateQuestion(questionVO);
		
		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "";
		if(dbQuestion.getTitle().equals(questionVO.getTitle())) {
			sContext = "[" + dbQuestion.getTitle() + "]";
		} else {
			sContext = "[" + dbQuestion.getTitle() + "]" + " -> " + questionVO.getTitle();
		}
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "문의사항", "Update");
		
		return result;
	}
	
	/**
	 * 문의사항 문의 삭제
	 * 
	 * @param id
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@ResponseBody
	@RequestMapping(value = "/support/deleteQuestion.do", method = RequestMethod.POST)
	public int deleteQuestion(int id, HttpSession session) throws UnsupportedEncodingException {
		
		// 결과
		int result = 0;
		
		// tomcat 위치	
		String catalina = System.getProperty("catalina.home");
		
		// DB에서 저장된 문의사항 정보(원본)를 조회한다.
		QuestionVO dbQuestion = questionService.selectQuestion(id);
		
		// 질문에 이미지가 첨부가 있는 경우에 질문에서 첨부된 이미지 파일명을 얻는다.
		// 질문 url 디코딩
		if(dbQuestion.getQuestion() != null && !"".equals(dbQuestion.getQuestion())) {
			String encodedDBQuestion = URLDecoder.decode(dbQuestion.getQuestion(), "UTF-8").replaceAll("\\%20", " ")
					.replace("\\%2B", "+").replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(")
					.replaceAll("\\%29", ")").replaceAll("\\%7E", "~");
			
			// 질문의 이미지 파일명 목록 얻기
			List<String> dbImageFileList = this.getImageFileListFromContents(encodedDBQuestion);
			
			// 질문에 첨부된 이미지 삭제
			for (int i = 0; i < dbImageFileList.size(); i++) {
				String deletePath = dbImageFileList.get(i).replace("src=\"/img", catalina);
				File deleteFile = new File(deletePath);
				deleteFile.delete();
			}
		}
		
		// 답변에 이미지가 첨부가 있는 경우에 답변에서 첨부된 이미지 파일명을 얻는다.
		// 답변 url 디코딩
		if(dbQuestion.getAnswer() != null && !"".equals(dbQuestion.getAnswer())) {
			String encodedDBAnswer = URLDecoder.decode(dbQuestion.getAnswer(), "UTF-8").replaceAll("\\%20", " ")
					.replace("\\%2B", "+").replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(")
					.replaceAll("\\%29", ")").replaceAll("\\%7E", "~");
			
			// 답변의 이미지 파일명 목록 얻기
			List<String> dbImageFileList = this.getImageFileListFromContents(encodedDBAnswer);
			
			// 답변에 첨부된 이미지 삭제
			for (int i = 0; i < dbImageFileList.size(); i++) {
				String deletePath = dbImageFileList.get(i).replace("src=\"/img", catalina);
				File deleteFile = new File(deletePath);
				deleteFile.delete();
			}
		}
		
		// 문의사항 삭제
		result = questionService.deleteQuestion(id);
		
		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "[" + dbQuestion.getTitle() + "]" + " 삭제";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "문의사항", "Delete");
				
		return result;
	}
	
	/**
	 * 문의사항 답변 등록
	 * 
	 * @param Answer
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@ResponseBody
	@RequestMapping(value = "/support/insertAnswer.do", method = RequestMethod.POST)
	public int insertAnswer(QuestionVO answerVO, HttpSession session) throws UnsupportedEncodingException {
		
		String sysdate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		// tomcat 위치
		String catalina = System.getProperty("catalina.home");
		
		// 임시 저장 디렉토리
		String tempFolder = catalina + "/attachedFile/questionsTemp";
		
		// 정식 저장 디렉토리
		String imageFolder = catalina + "/attachedFile/images/" + sysdate;

		// 업로드한 이미지 파일를 임시 저장 공간에서 정식 저장 공간으로 이동시키기
		if(answerVO.getTempFilesName() != null && answerVO.getTempFilesName().length > 0) {
			for (int i = 0; i < answerVO.getTempFilesName().length; i++) {
				
				// 임시 파일이 실제 문의사항 본문에 포함 안된 경우에는 그냥 패스
				if (!answerVO.getAnswer().contains(answerVO.getTempFilesName()[i])) {
					continue;
				}
				
				// 파일 url에서 파일명만 얻기
				String fileName = answerVO.getTempFilesName()[i].replaceAll("img/attachedFile/questionsTemp/" + sysdate + "/", "");
				
				// 임시 파일 경로
				String tempPath = tempFolder + "/" + sysdate + fileName;
				
				// 정식 파일 경로
				String imagePath = imageFolder + fileName;
				
				try {
					
					File in = new File(tempPath);
					File out = new File(imagePath);
					File outFile = new File(imageFolder);
					
					// 정식 저장 디렉토리가 없는 경우에는 생성
					if (!outFile.exists()) {
						outFile.mkdirs();
					}
					
					// 이미지 파일을 임시 저장 공간에서 정식 공간으로 복사하고 임시 저장 공간의 파일을 삭제한다.
					// 파일 복사
					FileCopyUtils.copy(in, out);
					// 임시 파일 삭제
					in.delete();
					
				} catch (IOException e) {
					LOG.error(e);
				}
			}
		}
		
		// 답변에 있는 이미지 파일의 url을 임시에서 정식으로 변경
		answerVO.setAnswer(answerVO.getAnswer().replaceAll("src=\"/img/attachedFile/questionsTemp",
				"src=\"/img/attachedFile/images"));
		
		// url 인코딩
		String encodedAnswer = URLEncoder.encode(answerVO.getAnswer(), "UTF-8").replaceAll(" ", "\\%20")
				.replace("\\+", "\\%2B").replaceAll("\\!", "\\%21").replaceAll("\\'", "\\%27")
				.replaceAll("\\(", "\\%28").replaceAll("\\)", "\\%29").replaceAll("\\~", "\\%7E");
		answerVO.setAnswer(encodedAnswer);
		
		// 문의사항 답변 등록
		int data = questionService.updateAnswer(answerVO);
		
		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "[" + answerVO.getTitle() + "]" + " 답변 작성";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "문의사항", "Create");
		
		return data;
	}
	
	/**
	 * 문의사항 답변 수정
	 * 
	 * @param answerVO
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value = "/support/updateAnswer.do", method = RequestMethod.POST)
	public int updateAnswer(QuestionVO answerVO, HttpSession session) throws UnsupportedEncodingException {
		
		// 결과
		int result = 0;
		
		// DB에서 저장된 문의사항 정보(원본)를 조회한다.
		QuestionVO dbQuestion = questionService.selectQuestion(answerVO.getId());
		
		// tomcat 위치
		String catalina = System.getProperty("catalina.home");
		
		// 업로드한 이미지 파일를 임시 저장 공간에서 정식 저장 공간으로 이동시키기
		if(answerVO.getTempFilesName() != null && answerVO.getTempFilesName().length > 0) {
			for (int i = 0; i < answerVO.getTempFilesName().length; i++) {
				
				// 임시 파일이 실제 문의사항 본문에 포함 안된 경우에는 그냥 패스
				if (!answerVO.getAnswer().contains(answerVO.getTempFilesName()[i])) {
					continue;
				}
				
				// 임시 파일 경로
				String tempPath = answerVO.getTempFilesName()[i].replace("/img/attachedFile/questionsTemp/",
						catalina + "/attachedFile/questionsTemp/");
				
				// 정식 파일 경로
				String imagePath = answerVO.getTempFilesName()[i].replace("/img/attachedFile/questionsTemp/",
						catalina + "/attachedFile/images/");
				
				// 정식 파일의 디렉토리 경로
				String folder = imagePath.substring(0, imagePath.lastIndexOf("/"));
				
				try {
					
					File inFile = new File(tempPath);
					File outFile = new File(imagePath);
					File folderFile = new File(folder);
					
					// 정식 저장 디렉토리가 없는 경우에는 생성
					if (!folderFile.exists()) {
						folderFile.mkdirs();
					}
					
					// 이미지 파일을 임시 저장 공간에서 정식 공간으로 복사하고 임시 저장 공간의 파일을 삭제한다.
					// 파일 복사
					FileCopyUtils.copy(inFile, outFile);
					
					// 임시 파일 삭제
					inFile.delete();
					
				} catch (IOException e) {
					LOG.error(e);
				}
			}
		}
		
		// 에디터에서 삭제한 이미지의 물리적 파일도 삭제한다.
		if(answerVO.getTempDeleteName() != null && answerVO.getTempDeleteName().length > 0) {
			for (int i = 0; i < answerVO.getTempDeleteName().length; i++) {
				
				LOG.debug("TempDeleteName : " + answerVO.getTempDeleteName()[i]);
				
				// 삭제된 이미지 파일을 물리적으로도 삭제한다.
				// 정식 파일 경로
				String deleteImagePath = answerVO.getTempDeleteName()[i].replace("/img/attachedFile/images/",
						catalina + "/attachedFile/images/");
				
				LOG.debug("deleteImagePath : " + answerVO.getTempDeleteName()[i]);
				
				File deleteFile = new File(deleteImagePath);
				deleteFile.delete();
			}
		}
		
		// 답변에 있는 이미지 파일의 url을 임시에서 정식으로 변경
		answerVO.setAnswer(answerVO.getAnswer().replaceAll("src=\"/img/attachedFile/questionsTemp",
				"src=\"/img/attachedFile/images"));
		
		// 답변 URL 인코딩
		String encodedAnswer = URLEncoder.encode(answerVO.getAnswer(), "UTF-8").replaceAll(" ", "\\%20").replace("\\+", "\\%2B")
				.replaceAll("\\!", "\\%21").replaceAll("\\'", "\\%27").replaceAll("\\(", "\\%28")
				.replaceAll("\\)", "\\%29").replaceAll("\\~", "\\%7E");
		answerVO.setAnswer(encodedAnswer);
		
		result = questionService.updateAnswer(answerVO);
		
		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "[" + dbQuestion.getTitle() + "] 답변 수정";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "문의사항", "Update");
		
		return result;
	}
	
	/**
	 * 문의사항 답변 삭제
	 * 
	 * @param id
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value = "/support/deleteAnswer.do", method = RequestMethod.POST)
	public int deleteAnswer(int id, HttpSession session) throws UnsupportedEncodingException {
		
		// 결과
		int result = 0;
				
		// tomcat 위치	
		String catalina = System.getProperty("catalina.home");
		
		// DB에서 저장된 문의사항 정보(원본)를 조회한다.
		QuestionVO dbQuestion = questionService.selectQuestion(id);
		
		// 답변에 이미지가 첨부가 있는 경우에 답변에서 첨부된 이미지 파일명을 얻는다.
		if(dbQuestion.getAnswer() != null && !"".equals(dbQuestion.getAnswer())) {
			// 답변 url 디코딩
			String encodedDBAnswer = URLDecoder.decode(dbQuestion.getAnswer(), "UTF-8").replaceAll("\\%20", " ")
					.replace("\\%2B", "+").replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(")
					.replaceAll("\\%29", ")").replaceAll("\\%7E", "~");
			
			// 답변의 이미지 파일명 목록 얻기
			List<String> dbImageFileList = this.getImageFileListFromContents(encodedDBAnswer);
			
			// 답변에 첨부된 이미지 삭제
			for (int i = 0; i < dbImageFileList.size(); i++) {
				String deletePath = dbImageFileList.get(i).replace("src=\"/img", catalina);
				File deleteFile = new File(deletePath);
				deleteFile.delete();
			}
		}
		
		// 답변 삭제
		result = questionService.deleteAnswer(id);
		
		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "[" + dbQuestion.getTitle() + "]" + " 답변 삭제";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "문의사항", "Delete");
		
		return result;
	}
	
	/**
	 * 본문에서 첨부된 이미지 파일 목록을 얻는다.
	 * 
	 * @param contents
	 * @return
	 */
	private List<String> getImageFileListFromContents(String contents) {
		
		ArrayList<String> fileList = new ArrayList<String>();
		int fileStartIndex = 0;
		int fileEndIndex = 0;
		
		// 본문에 이미지가 첨부가 있는 경우에 본문에서 첨부된 이미지 파일명을 얻는다.
		if (contents != null && contents.length() > 0 && 
				contents.indexOf("src=\"/img/attachedFile") > -1) {
			
			do {
				// 이미지 파일 위치를 찾고 반복문으로 찾았던 위치 다음에서 또 이미지 파일이 있는지 찾는다.
				fileStartIndex = contents.indexOf("src=\"/img/attachedFile", fileStartIndex + 1);
				fileEndIndex = contents.indexOf("\" style=", fileStartIndex + 1);
				if (fileStartIndex != -1) {
					contents.substring(fileStartIndex, fileEndIndex);

					fileList.add(contents.substring(fileStartIndex, fileEndIndex));
				}
			// 	이미지 파일이 더이상 없을 때까지 반복
			} while (fileStartIndex + 1 < contents.length() && fileStartIndex > -1);	
		}
		return fileList;
	}
		
}
