package com.kh.wefund.project.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class Product {
	
	private int productNo;			//PRODUCT_NO NUMBER PRIMARY KEY,
	private int projectNo;			//PROJECT_NO NUMBER NOT NULL,
    private String productName;		//PRODUCT_NAME VARCHAR2(100) NOT NULL,
    private int price;				//PRICE NUMBER NOT NULL,
    
    private String productPrice;
    
}
