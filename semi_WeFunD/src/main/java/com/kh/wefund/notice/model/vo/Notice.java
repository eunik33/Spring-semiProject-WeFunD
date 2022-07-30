package com.kh.wefund.notice.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class Notice {
	
	private int noticeNo;
    private String noticeWriter;
    private String noticeTitle;
    private String noticeContent;
    private int count;
    private String noticeDate;
    private String status;
	
}
