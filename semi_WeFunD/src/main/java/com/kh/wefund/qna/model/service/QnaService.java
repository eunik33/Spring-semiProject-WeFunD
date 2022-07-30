package com.kh.wefund.qna.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wefund.common.model.vo.PageInfo;
import com.kh.wefund.qna.model.dao.QnaDao;
import com.kh.wefund.qna.model.vo.Qna;

@Service
public class QnaService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private QnaDao qnaDao;
	
	public int selectListCount() {
		return qnaDao.selectListCount(sqlSession);
	}

	public ArrayList<Qna> selectQnaList(PageInfo pi) {
		return qnaDao.selectQnaList(sqlSession, pi);
	}

	public int insertQna(Qna q) {
		return qnaDao.insertQna(sqlSession, q);
	}

	public Qna selectQna(int qnaNo) {
		return qnaDao.selectQna(sqlSession, qnaNo);
	}
	
	public int updateQna(Qna q) {
		return qnaDao.updateQna(sqlSession, q);
	}
	
	public int deleteQna(int qnaNo) {
		return qnaDao.deleteQna(sqlSession, qnaNo);
	}
	
	public int insertAnswer(Qna q) {
		return qnaDao.insertAnswer(sqlSession, q);
	}
	
	public int updateAnswer(Qna q) {
		return qnaDao.updateAnswer(sqlSession, q);
	}

}
