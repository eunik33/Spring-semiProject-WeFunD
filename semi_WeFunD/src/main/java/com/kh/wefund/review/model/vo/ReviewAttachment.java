package com.kh.wefund.review.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class ReviewAttachment {
	
	private int fileNo;
	private int reviewNo;
    private String originName;
    private String changeName;
    private String filePath;
    private Date uploadDate;
    private String status;
	
}
