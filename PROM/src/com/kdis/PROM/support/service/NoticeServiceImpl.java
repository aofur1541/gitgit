package com.kdis.PROM.support.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdis.PROM.support.dao.NoticeDAO;
import com.kdis.PROM.support.vo.NoticeVO;

/**
 * 공지사항 서비스 구현 class
 * 
 * @author KimHahn
 *
 */
@Service
public class NoticeServiceImpl implements NoticeService {

	/** 공지사항 DAO */
	@Autowired
	NoticeDAO noticeDAO;
	
	/**
	 * 공지사항 목록 조회
	 * 
	 * @return
	 */
	@Override
	public List<NoticeVO> selectNoticeList() {
		return noticeDAO.selectNoticeList();
	}
	
	/**
	 * 공지사항 고유번호로 공지사항 정보  조회
	 * 
	 * @param id
	 * @return
	 */
	@Override
	public NoticeVO selectNotice(int id) {
		return noticeDAO.selectNotice(id);
	}
	
	/**
	 * 지정한 공지사항 고유번호의 전 공지사항 정보  조회
	 * 
	 * @param id
	 * @return
	 */
	@Override
	public NoticeVO selectPreNotice(int id) {
		return noticeDAO.selectPreNotice(id);
	}
	
	/**
	 * 지정한 공지사항 고유번호의 다음 전 공지사항 정보  조회
	 * 
	 * @param id
	 * @return
	 */
	@Override
	public NoticeVO selectNextNotice(int id) {
		return noticeDAO.selectNextNotice(id);
	}
	
	/**
	 * 공지사항 등록
	 * 
	 * @param noticeVO
	 * @return
	 */
	@Override
	@Transactional
	public int insertNotice(NoticeVO noticeVO) {
		return noticeDAO.insertNotice(noticeVO);
	}
	
	/**
	 * 공지사항  수정
	 * 
	 * @param noticeVO
	 * @return
	 */
	@Override
	@Transactional
	public int updateNotice(NoticeVO noticeVO) {
		return noticeDAO.updateNotice(noticeVO);
	}
	
	/**
	 * 공지사항 조회 수 증가
	 * 
	 * @param id
	 * @return
	 */
	@Override
	@Transactional
	public int increaseNoticeViewCount(int id) {
		return noticeDAO.increaseNoticeViewCount(id);
	}
	
	/**
	 * 공지사항 삭제
	 * 
	 * @param id
	 * @return
	 */
	@Override
	@Transactional
	public int deleteNotice(int id) {
		return noticeDAO.deleteNotice(id);
	}
}
