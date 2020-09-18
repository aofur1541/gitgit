package com.kdis.PROM.support.dao;

import java.util.List;

import com.kdis.PROM.support.vo.NoticeVO;

/**
 * 공지사항 DAO interface
 * 
 * @author KimHahn
 *
 */
public interface NoticeDAO {

	/**
	 * 공지사항 목록 조회
	 * 
	 * @return
	 */
	public List<NoticeVO> selectNoticeList();
	
	/**
	 * 공지사항 고유번호로 공지사항 정보  조회
	 * 
	 * @param id
	 * @return
	 */
	public NoticeVO selectNotice(int id);
	
	/**
	 * 지정한 공지사항 고유번호의 전 공지사항 정보  조회
	 * 
	 * @param id
	 * @return
	 */
	public NoticeVO selectPreNotice(int id);
	
	/**
	 * 지정한 공지사항 고유번호의 다음 전 공지사항 정보  조회
	 * 
	 * @param id
	 * @return
	 */
	public NoticeVO selectNextNotice(int id);
	
	/**
	 * 공지사항 등록
	 * 
	 * @param noticeVO
	 * @return
	 */
	public int insertNotice(NoticeVO noticeVO);
	
	/**
	 * 공지사항  수정
	 * 
	 * @param noticeVO
	 * @return
	 */
	public int updateNotice(NoticeVO noticeVO);
	
	/**
	 * 공지사항 조회 수 증가
	 * 
	 * @param id
	 * @return
	 */
	public int increaseNoticeViewCount(int id);

	/**
	 * 공지사항 삭제
	 * 
	 * @param id
	 * @return
	 */
	public int deleteNotice(int id);
	
}
