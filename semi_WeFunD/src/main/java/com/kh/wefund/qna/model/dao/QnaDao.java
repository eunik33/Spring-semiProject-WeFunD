package com.kh.wefund.qna.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.wefund.common.model.vo.PageInfo;
import com.kh.wefund.qna.model.vo.Qna;

@Repository
public class QnaDao {
	
	public int selectListCount(SqlSession sqlSession) {
		return sqlSession.selectOne("qnaMapper.selectListCount");
	}

	public ArrayList<Qna> selectQnaList(SqlSession sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("qnaMapper.selectQnaList", null, rowBounds);
	}

	public int insertQna(SqlSession sqlSession, Qna q) {
		return sqlSession.insert("qnaMapper.insertQna", q);
	}

	public Qna selectQna(SqlSession sqlSession, int qnaNo) {
		return sqlSession.selectOne("qnaMapper.selectQna", qnaNo);
	}

	public int updateQna(SqlSession sqlSession, Qna q) {
		return sqlSession.update("qnaMapper.updateQna", q);
	}
	
	public int deleteQna(SqlSession sqlSession, int qnaNo) {
		return sqlSession.update("qnaMapper.deleteQna", qnaNo);
	}
	
	public int insertAnswer(SqlSession sqlSession, Qna q) {
		return sqlSession.insert("qnaMapper.insertAnswer", q);
	}
	
	public int updateAnswer(SqlSession sqlSession, Qna q) {
		return sqlSession.update("qnaMapper.updateAnswer", q);
	}

}
