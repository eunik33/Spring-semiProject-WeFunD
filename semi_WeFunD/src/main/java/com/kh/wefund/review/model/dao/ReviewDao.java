package com.kh.wefund.review.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.wefund.common.model.vo.PageInfo;
import com.kh.wefund.project.model.vo.Support;
import com.kh.wefund.review.model.vo.Reply;
import com.kh.wefund.review.model.vo.Report;
import com.kh.wefund.review.model.vo.Review;
import com.kh.wefund.review.model.vo.ReviewAttachment;

@Repository
public class ReviewDao {
	
	public int selectListCount(SqlSession sqlSession) {
		return sqlSession.selectOne("reviewMapper.selectListCount");
	}

	public ArrayList<Review> selectReviewList(SqlSession sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reviewMapper.selectReviewList", null, rowBounds);
	}

	public ArrayList<Support> selectUserSupportList(SqlSession sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("reviewMapper.selectUserSupportList", userNo);
	}

	public int insertReview(SqlSession sqlSession, Review r) {
		return sqlSession.insert("reviewMapper.insertReview", r);
	}
	
	public int insertReviewAttachment(SqlSession sqlSession, ReviewAttachment rat) {
		return sqlSession.insert("reviewMapper.insertReviewAttachment", rat);
	}

	public int increaseCount(SqlSession sqlSession, int reviewNo) {
		return sqlSession.update("reviewMapper.increaseCount", reviewNo);
	}

	public Review selectReview(SqlSession sqlSession, int reviewNo) {
		return sqlSession.selectOne("reviewMapper.selectReview", reviewNo);
	}

	public ReviewAttachment selectReviewAttachment(SqlSession sqlSession, int reviewNo) {
		return sqlSession.selectOne("reviewMapper.selectReviewAttachment", reviewNo);
	}

	public int updateReview(SqlSession sqlSession, Review r) {
		return sqlSession.update("reviewMapper.updateReview", r);
	}
	
	public int updateReviewAttachment(SqlSession sqlSession, ReviewAttachment rat) {
		return sqlSession.update("reviewMapper.updateReviewAttachment", rat);
	}
	
	public int insertNewReviewAttachment(SqlSession sqlSession, ReviewAttachment rat) {
		return sqlSession.insert("reviewMapper.insertNewReviewAttachment", rat);
	}
	
	public int deleteReviewAttachment(SqlSession sqlSession, ReviewAttachment rat) {
		return sqlSession.update("reviewMapper.deleteReviewAttachment", rat);
	}

	public int deleteReview(SqlSession sqlSession, int reviewNo) {
		return sqlSession.update("reviewMapper.deleteReview", reviewNo);
	}
	
	public ArrayList<Reply> selectReplyList(SqlSession sqlSession, int reviewNo) {
		return (ArrayList)sqlSession.selectList("reviewMapper.selectReplyList", reviewNo);
	}

	public int insertReply(SqlSession sqlSession, Reply rp) {
		return sqlSession.insert("reviewMapper.insertReply", rp);
	}

	public int updateReply(SqlSession sqlSession, Reply rp) {
		return sqlSession.update("reviewMapper.updateReply", rp);
	}

	public int deleteReply(SqlSession sqlSession, int replyNo) {
		return sqlSession.delete("reviewMapper.deleteReply", replyNo);
	}

	public int selectReportCount(SqlSession sqlSession, Report report) {
		return sqlSession.selectOne("reviewMapper.selectReportCount", report);
	}
	
	public int insertReport(SqlSession sqlSession, Report report) {
		return sqlSession.insert("reviewMapper.insertReport", report);
	}

	public int updateReplyStatusR(SqlSession sqlSession, Report report) {
		return sqlSession.update("reviewMapper.updateReplyStatusR", report);
	}

}
