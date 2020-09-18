package com.kdis.PROM.support.dao;

import java.util.List;

import com.kdis.PROM.support.vo.QuestionVO;

/**
 * 문의사항 DAO interface
 * 
 * @author KimHahn
 *
 */
public interface QuestionDAO {

	/**
	 * 문의사항 목록 조회
	 * 
	 * @return
	 */
	public List<QuestionVO> selectQuestionList();

	/**
	 * 문의사항 고유번호로 문의사항 정보 조회
	 * 
	 * @param id
	 * @return
	 */
	public QuestionVO selectQuestion(int id);

	/**
	 * 지정한 문의사항 고유번호의 전 문의사항 정보  조회
	 * 
	 * @param id
	 * @return
	 */
	public QuestionVO selectPreQuestion(int id);

	/**
	 * 지정한 문의사항 고유번호의 다음 전 문의사항 정보  조회
	 * 
	 * @param id
	 * @return
	 */
	public QuestionVO selectNextQuestion(int id);
	
	/**
	 * 답변이 없는 문의사항 개수 얻기
	 * 
	 * @return
	 */
	public int countUnansweredQuestion();
	
	/**
	 * 문의사항 질문 등록
	 * 
	 * @param questionVO
	 * @return
	 */
	public int insertQuestion(QuestionVO questionVO);
	
	/**
	 * 문의사항 질문 수정
	 * 
	 * @param questionVO
	 * @return
	 */
	public int updateQuestion(QuestionVO questionVO);
	
	/**
	 * 문의사항 답변 수정
	 * 
	 * @param questionVO
	 * @return
	 */
	public int updateAnswer(QuestionVO questionVO);
	
	/**
	 * 문의사항 삭제
	 * 
	 * @param id
	 * @return
	 */
	public int deleteQuestion(int id);
	
	/**
	 * 문의사항 답변 삭제
	 * 
	 * @param id
	 * @return
	 */
	public int deleteAnswer(int id);
	
}
