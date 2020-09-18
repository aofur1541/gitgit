package com.kdis.PROM.support.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdis.PROM.support.dao.QuestionDAO;
import com.kdis.PROM.support.vo.QuestionVO;

/**
 * 문의사항 서비스 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class QuestionServiceImpl implements QuestionService {

	/** 문의사항 DAO */
	@Autowired
	QuestionDAO questionDAO;
	
	/**
	 * 문의사항 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<QuestionVO> selectQuestionList() {
		return questionDAO.selectQuestionList();
	}
	
	/**
	 * 문의사항 고유번호로 문의사항 정보 조회
	 * 
	 * @param id
	 * @return
	 */
	@Override
	public QuestionVO selectQuestion(int id) {
		return questionDAO.selectQuestion(id);
	}

	/**
	 * 지정한 문의사항 고유번호의 전 문의사항 정보  조회
	 * 
	 * @param id
	 * @return
	 */
	@Override
	public QuestionVO selectPreQuestion(int id) {
		return questionDAO.selectPreQuestion(id);
	}

	/**
	 * 지정한 문의사항 고유번호의 다음 전 문의사항 정보  조회
	 * 
	 * @param id
	 * @return
	 */
	@Override
	public QuestionVO selectNextQuestion(int id) {
		return questionDAO.selectNextQuestion(id);
	}
	
	/**
	 * 답변이 없는 문의사항 개수 얻기
	 * 
	 * @return
	 */
	@Override
	public int countUnansweredQuestion() {
		return questionDAO.countUnansweredQuestion();
	}
	
	/**
	 * 문의사항 질문 등록
	 * 
	 * @param questionVO
	 * @return
	 */
	@Override
	@Transactional
	public int insertQuestion(QuestionVO questionVO) {
		return questionDAO.insertQuestion(questionVO);
	}
	
	/**
	 * 문의사항 질문 수정
	 * 
	 * @param questionVO
	 * @return
	 */
	@Override
	@Transactional
	public int updateQuestion(QuestionVO questionVO) {
		return questionDAO.updateQuestion(questionVO);
	}
	
	/**
	 * 문의사항 답변 수정
	 * 
	 * @param questionVO
	 * @return
	 */
	@Override
	@Transactional
	public int updateAnswer(QuestionVO questionVO) {
		return questionDAO.updateAnswer(questionVO);
	}
	
	/**
	 * 문의사항 삭제
	 * 
	 * @param id
	 * @return
	 */
	@Override
	@Transactional
	public int deleteQuestion(int id) {
		return questionDAO.deleteQuestion(id);
	}
	
	/**
	 * 문의사항 답변 삭제
	 * 
	 * @param id
	 * @return
	 */
	@Override
	@Transactional
	public int deleteAnswer(int id) {
		return questionDAO.deleteAnswer(id);
	}
	
}
