package com.kh.wefund.myPage.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wefund.common.model.vo.PageInfo;
import com.kh.wefund.member.model.vo.Member;
import com.kh.wefund.myPage.model.dao.MyPageDao;
import com.kh.wefund.project.model.vo.Project;
import com.kh.wefund.project.model.vo.Support;
import com.kh.wefund.review.model.vo.Review;

@Service
public class MyPageService {

	@Autowired
	private MyPageDao myPageDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int selectLikeListCount(int userNo) {
		return myPageDao.selectLikeListCount(sqlSession, userNo);
	}

	public int selectSupportListCount(int userNo) {
		return myPageDao.selectSupportListCount(sqlSession, userNo);
	}

	public int selectProjectListCount(int userNo) {
		return myPageDao.selectProjectListCount(sqlSession, userNo);
	}
	
	public int selectMyReviewListCount(int userNo) {
		return myPageDao.selectMyReviewListCount(sqlSession, userNo);
	}

	public int updateMember(Member m) {
		return myPageDao.updateMember(sqlSession, m);
	}

	public Member selectMember(Member m) {
		return myPageDao.selectMember(sqlSession, m);
	}

	public int deletMember(String userId) {
		return myPageDao.deletMember(sqlSession, userId);
	}

	public ArrayList<Project> selectLikeList(PageInfo pi, int userNo) {
		return myPageDao.selectLikeList(sqlSession, pi, userNo);
	}

	public int selectLikeCount(HashMap<String, String> map) {
		return myPageDao.selectLikeCount(sqlSession, map);
	}

	public ArrayList<Project> selectedLike(PageInfo pi, HashMap<String, String> map) {
		return myPageDao.selectedLike(sqlSession, pi, map);
	}

	public ArrayList<Review> selectMyReviewList(PageInfo pi, int userNo) {
		return myPageDao.selectMyReviewList(sqlSession, pi, userNo);
	}

	public int selectSupportCount(Support s) {
		return myPageDao.selectSupportCount(sqlSession, s);
	}

	public ArrayList<Support> selectMySupportList(PageInfo pi, Support s) {
		return myPageDao.selectMySupportList(sqlSession, pi, s);
	}

	
}
