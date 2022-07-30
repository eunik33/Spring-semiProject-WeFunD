package com.kh.wefund.qna.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wefund.common.model.vo.PageInfo;
import com.kh.wefund.common.template.Pagination;
import com.kh.wefund.qna.model.service.QnaService;
import com.kh.wefund.qna.model.vo.Qna;

@Controller
public class QnaController {

	@Autowired
	private QnaService qnaService;
	
	@RequestMapping("list.qna")
	public ModelAndView selectQnaList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {

		PageInfo pi = Pagination.getPageInfo(qnaService.selectListCount(), currentPage, 10, 10);
		
		mv.addObject("list", qnaService.selectQnaList(pi))
		  .addObject("pi", pi)
		  .setViewName("qna/qnaListView");
		
		return mv;
	}
	
	@RequestMapping("enrollForm.qna")
	public String enrollQnaForm() {
		
		return "qna/qnaEnrollForm";
	}
	
	@RequestMapping("insert.qna")
	public String insertQna(Qna q, HttpSession session, Model model) {
		
		int result = qnaService.insertQna(q);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "문의글이 등록되었습니다.");
			return "redirect:list.qna";
		} else {
			model.addAttribute("errorMsg", "문의글 등록 실패");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("detail.qna")
	public ModelAndView selectQna(int qno, ModelAndView mv) {
		
		mv.addObject("q", qnaService.selectQna(qno))
		  .setViewName("qna/qnaDetailView");
		
		return mv;
	}
	
	@RequestMapping("updateForm.qna")
	public String updateQnaForm(int qnaNo, Model model) {
		
		model.addAttribute("q", qnaService.selectQna(qnaNo));
		
		return "qna/qnaUpdateForm";
	}
	
	@RequestMapping("update.qna")
	public String updateQna(Qna q, HttpSession session, Model model) {
		
		int result = qnaService.updateQna(q);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "QNA 글이 수정되었습니다.");
			return "redirect:detail.qna?qno=" + q.getQnaNo();
		} else {
			model.addAttribute("errorMsg", "QNA 글 수정 실패");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("delete.qna")
	public String deleteQna(int qnaNo, HttpSession session, Model model) {

		int result = qnaService.deleteQna(qnaNo);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "QNA글이 삭제되었습니다.");
			return "redirect:list.qna";
		} else {
			model.addAttribute("errorMsg", "QNA글 삭제 실패");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("insertAnswer.qna")
	public String insertAnswer(Qna q, HttpSession session, Model model) {
		
		int result = qnaService.insertAnswer(q);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "답변이 등록되었습니다.");
			return "redirect:detail.qna?qno=" + q.getQnaNo();
		} else {
			model.addAttribute("errorMsg", "답변 등록 실패");
			return "common/errorPage";
		}
	}
	
	@ResponseBody
	@RequestMapping("updateAnswer.qna")
	public String ajaxUpdateAnswer(Qna q) {
		
		return qnaService.updateAnswer(q) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping(value="selectAnswer.qna", produces="text/html; charset=UTF-8")
	public String ajaxSelectAnswer(int qno) {
		
		return qnaService.selectQna(qno).getAnswer();
	}
	
}
