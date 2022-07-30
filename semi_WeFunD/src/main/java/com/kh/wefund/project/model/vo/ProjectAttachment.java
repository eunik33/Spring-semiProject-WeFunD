package com.kh.wefund.project.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class ProjectAttachment {

	private int fileNo;				//FILE_NO NUMBER PRIMARY KEY,
    private int projectNo;			//PROJECT_NO NUMBER NOT NULL,
    private String originName;		//ORIGIN_NAME VARCHAR2(255) NOT NULL,
    private String changeName;		//CHANGE_NAME VARCHAR2(255) NOT NULL,
    private String filePath;		//FILE_PATH VARCHAR2(1000) NOT NULL,
    private Date uploadDate;		//UPLOAD_DATE DATE DEFAULT SYSDATE,
    private int fileLevel;			//FILE_LEVEL NUMBER NOT NULL,
    private String status;			//STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN ('Y', 'N')),
    
}
