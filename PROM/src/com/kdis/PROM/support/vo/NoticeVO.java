package com.kdis.PROM.support.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 공지사항 VO
 * 
 * @author KimHahn
 *
 */
public class NoticeVO {

	/** 공지사항 고유번호 */
	private Integer id;
	
	/** 제목 */
	private String title;
	
	/** 내용 */
	private String contents;
	
	/** 작성자 */
	private String writerID;
	
	/** 조회수 */
	private Integer viewCount;
	
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
	 * @return the contents
	 */
	public String getContents() {
		return contents;
	}

	/**
	 * @param contents the contents to set
	 */
	public void setContents(String contents) {
		this.contents = contents;
	}

	/**
	 * @return the writerID
	 */
	public String getWriterID() {
		return writerID;
	}

	/**
	 * @param writerID the writerID to set
	 */
	public void setWriterID(String writerID) {
		this.writerID = writerID;
	}

	/**
	 * @return the viewCount
	 */
	public Integer getViewCount() {
		return viewCount;
	}

	/**
	 * @param viewCount the viewCount to set
	 */
	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
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
