package com.kh.wefund.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wefund.member.model.dao.MemberDao;
import com.kh.wefund.member.model.vo.Member;

@Service
public class MemberService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDao memberDao;
	
	public Member loginMember(Member m) {
		
		return memberDao.loginMember(sqlSession, m);

	}


	
}
