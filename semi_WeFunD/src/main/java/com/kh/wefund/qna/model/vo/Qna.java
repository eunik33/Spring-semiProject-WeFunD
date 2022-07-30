package com.kh.wefund.qna.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class Qna {
	
    private int qnaNo;
    private String qnaWriter;
    private String qnaTitle;
    private String qnaContent;
    private String qnaDate;
    private String answer;
    private String answerDate;
    private String status;
    
}
