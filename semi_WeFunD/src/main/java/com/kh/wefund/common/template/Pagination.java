package com.kh.wefund.common.template;

import com.kh.wefund.common.model.vo.PageInfo;

public class Pagination {

	public static PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit); // 가장 마지막 페이지 수
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1; // 해당 페이지 보여질 페이징바의 시작 수
		int endPage = startPage + pageLimit - 1; // 해당 페이지에 보여질 페이징바의 끝 수
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		return new PageInfo(listCount, currentPage, pageLimit, boardLimit
									, maxPage, startPage, endPage);
		
	}
}
