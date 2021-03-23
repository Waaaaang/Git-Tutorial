package com.spm.vo;

import lombok.Getter;
import lombok.Setter;

//각 상품의 정보를 제외하고 모두 중복 데이터이기 때문에 두개의 테이블로 분류
@Getter
@Setter
public class OrderDetailVO {
	    
	   private int orderDetailNo;	// 주문 상세 번호
	   private String orderId;		//주문 번호
	   private int gdsNo;			//상품 번호
	   private int cartStock;		//수량
}
