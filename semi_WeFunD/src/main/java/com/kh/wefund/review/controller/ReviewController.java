package com.kh.wefund.review.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.wefund.common.model.vo.PageInfo;
import com.kh.wefund.common.template.Pagination;
import com.kh.wefund.review.model.service.ReviewService;
import com.kh.wefund.review.model.vo.Reply;
import com.kh.wefund.review.model.vo.Report;
import com.kh.wefund.review.model.vo.Review;
import com.kh.wefund.review.model.vo.ReviewAttachment;

@Controller
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping("list.rv")
	public ModelAndView selectReviewList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		PageInfo pi = Pagination.getPageInfo(reviewService.selectListCount(), currentPage, 10, 12);
		
		mv.addObject("list", reviewService.selectReviewList(pi))
		  .addObject("pi", pi)
		  .setViewName("review/reviewListView");
		
		return mv;
	}
	
	@RequestMapping("enrollForm.rv")
	public String enrollReivewForm(int userNo, Model model) {
		// 후원프로젝트목록 가지고 리뷰글 작성페이지로 넘어가기
		model.addAttribute("sList", reviewService.selectUserSupportList(userNo));
		return "review/reviewEnrollForm";
	}
	
	@RequestMapping("insert.rv")
	public String insertReview(Review r, MultipartFile upfile, HttpSession session, Model model) {
		
		ReviewAttachment rat = null;
		
		if(!upfile.getOriginalFilename().equals("")) { // getOriginalFilename() == filename 필드값을 반환해줌
			
			String changeName = saveFile(upfile, session);
			
			rat = new ReviewAttachment();
			rat.setOriginName(upfile.getOriginalFilename()); // 원본명
			rat.setChangeName(changeName); // 수정파일명
			rat.setFilePath("resources/review_upfiles/");
		}
			
		int result = reviewService.insertReview(r, rat);
			
		if(result > 0) {
			session.setAttribute("alertMsg", "리뷰글이 작성되었습니다.");
			return "redirect:list.rv";
		} else {
			if(rat != null) { // 첨부파일이 있었는데 실패했다면 업로드된 첨부파일 지우기
				new File(session.getServletContext().getRealPath("resources/review_upfiles/"+rat.getChangeName())).delete();
			}
			model.addAttribute("errorMsg", "리뷰글 작성 실패");
			return "common/errorPage";
		}
			
	}
	
	// 실제 넘어온 파일을 이름을 변경해서 서버에 업로드
	public String saveFile(MultipartFile upfile, HttpSession session) {
		// 파일명 수정 후 서버에 업로드시키기("flower4.jpg" => WeFunD_20220722324823_43223.jpg")

		String originName = upfile.getOriginalFilename();
		
		// 2022072202251238012(년월일시분초)
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		// 5자리 랜덤값 추출 
		int ranNum = (int)(Math.random() * 90000) + 10000;
		// 확장자
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = "WeFunD_" + currentTime + "_" + ranNum + ext;
		
		// 업로드 시키고자 하는 폴더의 물리적인 경로를 알아내기
		String savePath = session.getServletContext().getRealPath("/resources/review_upfiles/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}
	
	@RequestMapping("detail.rv")
	public ModelAndView selectReview(int rno, ModelAndView mv) {

		// 조회수 증가
		int result = reviewService.increaseCount(rno);
		
		if(result > 0) {
			Review r = reviewService.selectReview(rno); // 리뷰글 조회
			ReviewAttachment rat = reviewService.selectReviewAttachment(rno); // 첨부파일 조회
			mv.addObject("r", r)
			  .addObject("rat", rat)
			  .setViewName("review/reviewDetailView");
		} else {
			mv.addObject("errorMsg", "없는 리뷰글입니다.").setViewName("common.errorPage");
		}
		
		return mv;
	}
	
	@RequestMapping("updateForm.rv")
	public String updateReviewForm(int rno, Model model) {
		
		model.addAttribute("r", reviewService.selectReview(rno))
		     .addAttribute("rat", reviewService.selectReviewAttachment(rno));
		
		return "review/reviewUpdateForm";
	}
	
	@RequestMapping("update.rv")
	public String updateReview(Review r, String originFileNo, String originFileName,
							   String checkDeleteOrigin, MultipartFile reUpfile,
					   		   HttpSession session, Model model) {
	
		ReviewAttachment rat = null;
		
		// 새로 첨부한 사진 있을 경우
		if(!reUpfile.getOriginalFilename().contentEquals("")) {
			
			String changeName = saveFile(reUpfile, session);
	
			rat = new ReviewAttachment();
			rat.setOriginName(reUpfile.getOriginalFilename());
			rat.setChangeName(changeName);
			rat.setFilePath("resources/review_upfiles/");
			
			// 기존에 원본파일도 있었을 경우
			if(originFileNo != null) {
				// 기존 파일이 존재했다
				// 기존파일에 대한 파일번호 rat에 담을 것(WHERE)
				rat.setFileNo(Integer.parseInt(originFileNo));
				
				// 기존에 서버에 존재하던 첨부파일 삭제
				new File(session.getServletContext().getRealPath("resources/review_upfiles/"+originFileName)).delete();
			} else {
				// 새로운 첨부파일이 넘어왔지만 기존파일이 없을 경우 => INSERT
				rat.setReviewNo(r.getReviewNo());
			}
			
		// 새로 첨부한 사진 없을 경우
		} else {
			// 원본파일이 삭제됐을 경우
			if(checkDeleteOrigin.equals("deleteOrigin")) {
				rat = new ReviewAttachment();
				rat.setFileNo(Integer.parseInt(originFileNo)); // 원본 파일번호
				new File(session.getServletContext().getRealPath("resources/review_upfiles/"+originFileName)).delete();
			}
		}
	
		
		int result = reviewService.updateReview(r, rat);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "리뷰글이 수정되었습니다.");
			return "redirect:detail.rv?rno=" + r.getReviewNo();
		} else {
			if(rat != null) { // 첨부파일이 있었는데 실패했다면 업로드된 첨부파일 지우기
				new File(session.getServletContext().getRealPath("resources/review_upfiles/"+originFileName)).delete();
			}
			model.addAttribute("errorMsg", "리뷰글 작성 실패");
			return "common/errorPage";
		}
		
	}
	
	@RequestMapping("delete.rv")
	public String deleteReview(int rno, HttpSession session, Model model) {

		int result = reviewService.deleteReview(rno);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "리뷰글이 삭제되었습니다.");
			return "redirect:list.rv";
		} else {
			model.addAttribute("errorMsg", "리뷰글 삭제 실패");
			return "common/errorPage";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="rlist.rv", produces="application/json; charset=UTF-8")
	public String ajaxSelectReplyList(int rno) {
		return new Gson().toJson(reviewService.selectReplyList(rno));
	}
	
	@ResponseBody
	@RequestMapping("rinsert.rv")
	public String ajaxInsertReply(Reply reply) {
		return reviewService.insertReply(reply) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping("rupdate.rv")
	public String ajaxUpdateReply(Reply reply) {
		return reviewService.updateReply(reply) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping("rdelete.rv")
	public String ajaxDeleteReply(int replyNo) {
		return reviewService.deleteReply(replyNo) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping("rreport.rv")
	public String ajaxReportReply(Report report) {

		int count = reviewService.selectReportCount(report);
		int result = 0;

		if(count <= 0){ // 해당 사용자가 신고 안 했을 경우 신고 가능 (중복 신고 방지)
			result = reviewService.insertReport(report);
		}
		
		return result > 0 ? "success" : "fail";
	}
	
}
