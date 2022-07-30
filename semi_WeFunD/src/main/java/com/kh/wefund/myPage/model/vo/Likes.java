package com.kh.wefund.myPage.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class Likes {

	private int userNo;			//USER_NO NUMBER NOT NULL,
    private int projectNo;		//PROJECT_NO NUMBER NOT NULL,
    private Date likeDate;		//LIKE_DATE DATE DEFAULT SYSDATE NOT NULL,
    
}
