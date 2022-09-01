package com.kh.wefund.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wefund.member.model.service.MemberService;
import com.kh.wefund.member.model.vo.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@RequestMapping("loginForm.me")
	public String loginForm() {
		return "member/login";
	}
	
	@RequestMapping("login.me")
	public ModelAndView loginMember(Member m, HttpSession session, ModelAndView mv) {
		
		Member loginUser = memberService.loginMember(m);
		
		
		if(loginUser == null) { // 로그인 실패
			
			mv.addObject("errorMsg", "로그인 실패").setViewName("common/errorPage");
		}else { // 로그인 성공
			
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "로그인성공");
			mv.setViewName("redirect:/");
		}
		
		return mv;
	}
	
}
