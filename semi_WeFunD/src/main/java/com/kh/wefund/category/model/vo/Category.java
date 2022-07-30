package com.kh.wefund.category.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class Category {

	private int projectNo;
	private String nickname;
	private String projectName;
	private int categoryNo;
	private String categoryName;
	private Date endDate;
	private int dDay;
	private int goalAmount;
	private String filePath;
	private int paymentSum;
	private String thumbnailImg;
	
}
