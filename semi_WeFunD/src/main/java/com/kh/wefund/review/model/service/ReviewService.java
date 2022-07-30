package com.kh.wefund.review.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wefund.common.model.vo.PageInfo;
import com.kh.wefund.review.model.dao.ReviewDao;
import com.kh.wefund.review.model.vo.Reply;
import com.kh.wefund.review.model.vo.Report;
import com.kh.wefund.review.model.vo.Review;
import com.kh.wefund.review.model.vo.ReviewAttachment;
import com.kh.wefund.review.model.vo.Support;

@Service
public class ReviewService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ReviewDao reviewDao;
	
	public int selectListCount() {
		return reviewDao.selectListCount(sqlSession);
	}

	public ArrayList<Review> selectReviewList(PageInfo pi) {
		return reviewDao.selectReviewList(sqlSession, pi);
	}

	public ArrayList<Support> selectUserSupportList(int userNo) {
		return reviewDao.selectUserSupportList(sqlSession, userNo);
	}
	
	public int insertReview(Review r, ReviewAttachment rat) {
		int result1 = reviewDao.insertReview(sqlSession, r);
		int result2 = 1;
		if(rat != null)
			result2 = reviewDao.insertReviewAttachment(sqlSession, rat);
		return (result1 * result2);
	}

	public int increaseCount(int reviewNo) {
		return reviewDao.increaseCount(sqlSession, reviewNo);
	}

	public Review selectReview(int reviewNo) {
		return reviewDao.selectReview(sqlSession, reviewNo);
	}

	public ReviewAttachment selectReviewAttachment(int reviewNo) {
		return reviewDao.selectReviewAttachment(sqlSession, reviewNo);
	}

	public int updateReview(Review r, ReviewAttachment rat) {
		int result1 = reviewDao.updateReview(sqlSession, r);
		
		int result2 = 1;
		if(rat != null) {
			// 새로 첨부된 파일이 없을 경우
			if(rat.getChangeName() == null) {
				if(rat.getFileNo() != 0) { // 기존에 첨부파일 있었을 경우
					result2 = reviewDao.deleteReviewAttachment(sqlSession, rat);
				} 
				
			// 새로운 파일 첨부했을 경우
			} else {
				if(rat.getFileNo() != 0) { // 기존에 첨부파일 있었을 경우
					result2 = reviewDao.updateReviewAttachment(sqlSession, rat);
				} else { // 없었을 경우
					result2 = reviewDao.insertNewReviewAttachment(sqlSession, rat);
				}
			}
		}
		return (result1 * result2);
	}

	public int deleteReview(int reviewNo) {
		return reviewDao.deleteReview(sqlSession, reviewNo);
	}
	
	public ArrayList<Reply> selectReplyList(int reviewNo) {
		return reviewDao.selectReplyList(sqlSession, reviewNo);
	}

	public int insertReply(Reply reply) {
		return reviewDao.insertReply(sqlSession, reply);
	}

	public int updateReply(Reply rp) {
		return reviewDao.updateReply(sqlSession, rp);
	}

	public int deleteReply(int replyNo) {
		return reviewDao.deleteReply(sqlSession, replyNo);
	}

	public int selectReportCount(Report report) {
		return reviewDao.selectReportCount(sqlSession, report);
	}
	
	public int insertReport(Report report) {
		int result1 = reviewDao.insertReport(sqlSession, report);
		int result2 = reviewDao.updateReplyStatusR(sqlSession, report);
		return (result1 * result2);
	}

}
