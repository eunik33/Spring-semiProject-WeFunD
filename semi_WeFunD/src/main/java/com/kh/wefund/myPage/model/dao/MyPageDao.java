package com.kh.wefund.myPage.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.wefund.common.model.vo.PageInfo;
import com.kh.wefund.member.model.vo.Member;
import com.kh.wefund.project.model.vo.Project;
import com.kh.wefund.project.model.vo.Support;
import com.kh.wefund.review.model.vo.Review;

@Repository
public class MyPageDao {
	
	public int selectLikeListCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("myPageMapper.selectLikeListCount", userNo);
	}

	public int selectSupportListCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("myPageMapper.selectSupportListCount", userNo);
	}

	public int selectProjectListCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("myPageMapper.selectProjectListCount", userNo);
	}
	
	public int selectMyReviewListCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("myPageMapper.selectMyReviewListCount", userNo);
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("myPageMapper.updateMember", m);
	}

	public Member selectMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("myPageMapper.selectMember", m);
	}

	public int deletMember(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.delete("myPageMapper.deletMember", userId);
	}

	public ArrayList<Project> selectLikeList(SqlSessionTemplate sqlSession, PageInfo pi, int userNo) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("myPageMapper.selectLikeList", userNo, rowBounds);
	}

	public int selectLikeCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("myPageMapper.selectLikeCount", map);
	}

	public ArrayList<Project> selectedLike(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("myPageMapper.selectedLike", map, rowBounds);
	}

	public ArrayList<Review> selectMyReviewList(SqlSessionTemplate sqlSession, PageInfo pi, int userNo) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("myPageMapper.selectMyReviewList", userNo, rowBounds);
	}

	public int selectSupportCount(SqlSessionTemplate sqlSession, Support s) {
		return sqlSession.selectOne("myPageMapper.selectSupportCount", s);

	}

	public ArrayList<Support> selectMySupportList(SqlSessionTemplate sqlSession, PageInfo pi, Support s) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);	
		
		return (ArrayList)sqlSession.selectList("myPageMapper.selectMySupportList", s, rowBounds);
	}

}
