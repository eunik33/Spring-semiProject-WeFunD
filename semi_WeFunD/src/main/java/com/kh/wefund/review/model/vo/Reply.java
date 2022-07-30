package com.kh.wefund.review.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class Reply {
	
    private int replyNo;
    private int reviewNo;
    private String replyWriter;
    private String replyContent;
    private String replyDate;
    private String status;

}
