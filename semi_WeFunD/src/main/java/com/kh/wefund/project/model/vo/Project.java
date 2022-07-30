package com.kh.wefund.project.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class Project {
	
    private int projectNo; // PROJECT_NO NUMBER PRIMARY KEY,
	private int projectCreator; //PROJECT_CREATOR	NUMBER NOT NULL,
    private String projectName; // PROJECT_NAME VARCHAR2(100) NOT NULL,
    private int categoryNo; // CATEGORY_NO NUMBER NOT NULL,
    private String categoryName; // CATEGORY_NAME VARCHAR2(30) NOT NULL,
    private String startDate; // START_DATE DATE,
    private String endDate; // END_DATE DATE NOT NULL,
    private String goalAmount; // GOAL_AMOUNT NUMBER NOT NULL,
    private String bank; // BANK VARCHAR2(20) NOT NULL,
    private String accountNo; // ACCOUNT_NO VARCHAR2(20) NOT NULL,
    private String accountName; // ACCOUNT_NAME VARCHAR2(15) NOT NULL,
    private String projectContent; // PROJECT_CONTENT VARCHAR2(3000) NOT NULL,
    private int count; // COUNT NUMBER DEFAULT 0,
    private String applyDate;
    private String status;
    
    private String userId;
    private String titleImg;
    private String nickname;
    
    private int totalPrice; // 모인금액
    private int percent;
	private int dDay;
	private Double Rate;
	
}
