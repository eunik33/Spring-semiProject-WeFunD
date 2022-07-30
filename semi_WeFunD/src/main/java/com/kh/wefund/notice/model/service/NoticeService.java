package com.kh.wefund.notice.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wefund.common.model.vo.PageInfo;
import com.kh.wefund.notice.model.dao.NoticeDao;
import com.kh.wefund.notice.model.vo.Notice;

@Service
public class NoticeService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private NoticeDao noticeDao;
	
	public int selectListCount() {
		return noticeDao.selectListCount(sqlSession);
	}

	public ArrayList<Notice> selectNoticeList(PageInfo pi) {
		return noticeDao.selectNoticeList(sqlSession, pi);
	}

	public int increaseCount(int noticeNo) {
		return noticeDao.increaseCount(sqlSession, noticeNo);
	}

	public Notice selectNotice(int noticeNo) {
		return noticeDao.selectNotice(sqlSession, noticeNo);
	}

	public int updateNotice(Notice n) {
		return noticeDao.updateNotice(sqlSession, n);
	}
	
	public int deleteNotice(int noticeNo) {
		return noticeDao.deleteNotice(sqlSession, noticeNo);
	}

}
