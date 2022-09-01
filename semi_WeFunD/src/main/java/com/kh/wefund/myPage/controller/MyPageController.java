package com.kh.wefund.myPage.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wefund.common.model.vo.PageInfo;
import com.kh.wefund.common.template.Pagination;
import com.kh.wefund.member.model.vo.Member;
import com.kh.wefund.myPage.model.service.MyPageService;
import com.kh.wefund.project.model.vo.Support;

@Controller
public class MyPageController {

	@Autowired
	private MyPageService myPageService;
	
	// 마이페이지 메인화면으로 연결되는 컨트롤러
	@RequestMapping("myPage.me")
	public String myPage(int userNo, Model model, HttpSession session) {
		
		int likesCount = myPageService.selectLikeListCount(userNo);
		int supportCount = myPageService.selectSupportListCount(userNo);
		int projectCount = myPageService.selectProjectListCount(userNo);
		
		model.addAttribute("likesCount", likesCount);
		model.addAttribute("supportCount", supportCount);
		model.addAttribute("projectCount", projectCount);
		
		// /WEB-INF/views/myPage/myPage.jsp
		return "myPage/myPage";
	}
	
	// 개인정보 수정 컨트롤러
	@RequestMapping("update.me")
	public String updateMember(Member m, Model model, HttpSession session) {
		
		int result = myPageService.updateMember(m);
		
		if(result > 0) {
			Member loginUser = myPageService.selectMember(m);
			
			session.setAttribute("alertMsg", "회원정보 수정 성공");
			session.setAttribute("loginUser", loginUser);
			return "redirect:myPage.me?userNo="+ loginUser.getUserNo();
		} else {
			model.addAttribute("errorMsg", "정보 수정 실패");
			return "common/errorPage";
		}
	}
	
	// 회원 탈퇴 컨트롤러
	@RequestMapping("delete.me")
	public String deletMember(String userId, HttpSession session) {
		
		int result = myPageService.deletMember(userId);
		
		if(result > 0) {
			session.removeAttribute("loginUser");
			session.setAttribute("alertMsg", "회원탈퇴가 완료되었습니다");
			return "redirect:/";
		} else {
			session.setAttribute("errorMsg", "회원탈퇴 실패");
			return "common/errorPage";
		}
	}
	
	// 비밀번호 변경 해야함(ajax만들어야함)
	

	// 마이페이지 메뉴 리스트 - 관심프로젝트 리스트 연결 컨트롤러
	@RequestMapping("myLikeListView.me")
	public ModelAndView selectLikeList(@RequestParam(value="pjpage", defaultValue="1") 
										int currentPage, int userNo, ModelAndView mv) {
		
		PageInfo pi = Pagination.getPageInfo(myPageService.selectLikeListCount(userNo), currentPage, 5, 4);
		
		mv.addObject("pi", pi)
		  .addObject("list", myPageService.selectLikeList(pi, userNo))
		  .setViewName("myPage/myLikeListView");
		
		return mv;
	}
	
	// 관심프로젝트 select 옵션 선택시 연결되는 컨트롤러
	@RequestMapping("selectedLike.me")
	public ModelAndView selectedLike(@RequestParam(value="pjpage", defaultValue="1") int currentPage, 
									String userId, @RequestParam(value="select") String select, ModelAndView mv) {
		
		HashMap<String, String> map = new HashMap<>();
		map.put("userId", userId);
		map.put("select", select);
		
		PageInfo pi = Pagination.getPageInfo(myPageService.selectLikeCount(map), currentPage, 5, 4);
		
		mv.addObject("pi", pi)
		  .addObject("list", myPageService.selectedLike(pi, map))
		  .addObject("select", select)
		  .setViewName("myPage/myLikeListView");
		
		return mv;
	}
	
	// 마이페이지 메뉴 리스트 - 나의 리뷰 조회 연결 메소드
	@RequestMapping("myReviewListView.me")
	public ModelAndView selectMyReviewList(@RequestParam(value="rvpage", defaultValue="1") 
											int currentPage, int userNo, ModelAndView mv) {
		
		PageInfo pi = Pagination.getPageInfo(myPageService.selectMyReviewListCount(userNo), currentPage, 5, 5);
		
		mv.addObject("pi", pi)
		  .addObject("list", myPageService.selectMyReviewList(pi, userNo))
		  .setViewName("myPage/myReviewListView");
		
		return mv;
	}
	
	// 마이페이지 메뉴 리스트 - 후원 현황 조회 연결 메소드
	@RequestMapping("mySupportListView.me")
	public ModelAndView selectMySupportList(@RequestParam(value="spage", defaultValue="1") int currentPage,
											@RequestParam(value="select", defaultValue="all") String status,
											int userNo, ModelAndView mv) {
		
		Support s = new Support();
		s.setUserNo(userNo);
		s.setStatus(status);
		
		PageInfo pi = Pagination.getPageInfo(myPageService.selectSupportCount(s), currentPage, 5, 4);
		
		mv.addObject("pi", pi)
		  .addObject("list", myPageService.selectMySupportList(pi, s))
		  .addObject("select", status)
		  .setViewName("myPage/mySupportListView");
		
		return mv;
	}
	
	
	
	
	
	
	
	
	
	
}
