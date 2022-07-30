package com.kh.wefund.review.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class Review {
	
    private int reviewNo;
    private String reviewWriter;
    private String supportNo;
    private String reviewTitle;
    private String reviewContent;
    private int rate;
    private int count;
    private String reviewDate;
    private String status;
    
    // PROJECT테이블과 JOIN해서 받아온 값
    private int projectNo;
    private String projectName;
    private String projectThumbnail;
    // REVIEW_ATTACHMENT테이블과 JOIN해서 받아온 값
    private String reviewImg;

    private String titleImg;
    
}
