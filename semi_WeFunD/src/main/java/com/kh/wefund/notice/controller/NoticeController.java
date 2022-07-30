package com.kh.wefund.notice.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wefund.common.model.vo.PageInfo;
import com.kh.wefund.common.template.Pagination;
import com.kh.wefund.notice.model.service.NoticeService;
import com.kh.wefund.notice.model.vo.Notice;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("list.not")
	public ModelAndView selectNoticeList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv){
		
		PageInfo pi = Pagination.getPageInfo(noticeService.selectListCount(), currentPage, 10, 10);
		
		mv.addObject("list", noticeService.selectNoticeList(pi))
		  .addObject("pi", pi)
		  .setViewName("notice/noticeListView");
		
		return mv;
	}
	
	@RequestMapping("detail.no")
	public ModelAndView selectNotice(int nno, ModelAndView mv) {
		
		int result = noticeService.increaseCount(nno);
		
		if(result > 0) { // 조회수 증가 성공할 경우
			Notice n = noticeService.selectNotice(nno); // 공지글 조회
			mv.addObject("n", n).setViewName("notice/noticeDetailView");
		} else {
			mv.addObject("errorMsg", "상세조회 실패").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	@RequestMapping("updateForm.no")
	public String updateNoticeForm(int nno, Model model) {
		
		model.addAttribute("n", noticeService.selectNotice(nno));
		
		return "notice/noticeUpdateForm";
	}
	
	@RequestMapping("update.no")
	public String updateNotice(Notice n, HttpSession session, Model model) {
		
		int result = noticeService.updateNotice(n);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "공지사항이 수정되었습니다.");
			return "redirect:detail.no?nno=" + n.getNoticeNo();
		} else {
			model.addAttribute("errorMsg", "공지사항 수정 실패");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("delete.no")
	public String deleteNotice(int nno, HttpSession session, Model model) {
		
		int result = noticeService.deleteNotice(nno);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "공지사항이 성공적으로 삭제되었습니다.");
			return "redirect:list.not";
		} else {
			model.addAttribute("errorMsg", "공지사항 삭제 실패");
			return "common/errorPage";
		}
	}
}
