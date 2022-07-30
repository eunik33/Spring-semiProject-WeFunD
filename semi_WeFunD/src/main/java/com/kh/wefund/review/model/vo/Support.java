package com.kh.wefund.review.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class Support {
	
    private int supportNo;
    private int userNo;
    private int projectNo;
    private String orderName;
    private String orderPhone;
    private String orderEmail;
    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;
    private String orderComment;
    private String product;
    private int payment;
    private String supportDate;
    private String status;
    
    // PROJECT 테이블과 JOIN해서 받아온 값
    private String projectName; 
    
    
}
