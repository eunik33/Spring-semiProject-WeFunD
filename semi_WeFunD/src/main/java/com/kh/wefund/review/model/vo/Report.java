package com.kh.wefund.review.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class Report {
	
    private String replyNo;//R.REPLY_NO,
    private String reviewTitle;//REVIEW_TITLE,
    private String replyWriter;//REPLY_WRITER
    private String replyDate;//REPLY_DATE,
    private String replyContent;//REPLY_CONTENT
    private String replyReporter;//REPLY_REPORTER
    private String reportDate;//REPORT_DATE
    private String reviewNo;
    
}
