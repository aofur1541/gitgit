package com.kdis.PROM.support.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 문의사항 VO
 * 
 * @author KimHahn
 *
 */
public class QuestionVO {

	/** 문의사항 고유번호 */
	private Integer id;
	
	/** 질문 제목 */
	private String title;
	
	/** 질문 내용 */
	private String question;
	
	/** 답변 내용 */
	private String answer;
	
	/** 질문자 사용자 아이디 */
	private String questionerID;
	
	/** 답변자 사용자 아이디 */
	private String answerID;
	
	/** 답변 여부 */
	private int isAnswered;
	
	/** 생성일시 */
	private String createdOn;
	
	/** 변경일시 */
	private String updatedOn;
	
	/** 순번 */
	private Integer row;
	
	/** 업로드 파일 목록 */
	private String tempFilesName[];
	
	/** 삭제할 파일 목록 */
	private String tempDeleteName[];

	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return the question
	 */
	public String getQuestion() {
		return question;
	}

	/**
	 * @param question the question to set
	 */
	public void setQuestion(String question) {
		this.question = question;
	}

	/**
	 * @return the answer
	 */
	public String getAnswer() {
		return answer;
	}

	/**
	 * @param answer the answer to set
	 */
	public void setAnswer(String answer) {
		this.answer = answer;
	}

	/**
	 * @return the questionerID
	 */
	public String getQuestionerID() {
		return questionerID;
	}

	/**
	 * @param questionerID the questionerID to set
	 */
	public void setQuestionerID(String questionerID) {
		this.questionerID = questionerID;
	}

	/**
	 * @return the answerID
	 */
	public String getAnswerID() {
		return answerID;
	}

	/**
	 * @param answerID the answerID to set
	 */
	public void setAnswerID(String answerID) {
		this.answerID = answerID;
	}

	/**
	 * @return the isAnswered
	 */
	public int getIsAnswered() {
		return isAnswered;
	}

	/**
	 * @param isAnswered the isAnswered to set
	 */
	public void setIsAnswered(int isAnswered) {
		this.isAnswered = isAnswered;
	}

	/**
	 * @return the createdOn
	 */
	public String getCreatedOn() {
		return createdOn;
	}

	/**
	 * @param createdOn the createdOn to set
	 */
	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}

	/**
	 * @return the updatedOn
	 */
	public String getUpdatedOn() {
		return updatedOn;
	}

	/**
	 * @param updatedOn the updatedOn to set
	 */
	public void setUpdatedOn(String updatedOn) {
		this.updatedOn = updatedOn;
	}

	/**
	 * @return the row
	 */
	public Integer getRow() {
		return row;
	}

	/**
	 * @param row the row to set
	 */
	public void setRow(Integer row) {
		this.row = row;
	}

	/**
	 * @return the tempFilesName
	 */
	public String[] getTempFilesName() {
		return tempFilesName;
	}

	/**
	 * @param tempFilesName the tempFilesName to set
	 */
	public void setTempFilesName(String[] tempFilesName) {
		this.tempFilesName = tempFilesName;
	}

	/**
	 * @return the tempDeleteName
	 */
	public String[] getTempDeleteName() {
		return tempDeleteName;
	}

	/**
	 * @param tempDeleteName the tempDeleteName to set
	 */
	public void setTempDeleteName(String[] tempDeleteName) {
		this.tempDeleteName = tempDeleteName;
	}

	/**
	 * toString
	 */
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
    }
	
}
