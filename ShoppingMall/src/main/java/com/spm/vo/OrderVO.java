package com.spm.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class OrderVO {
	    
	    private String orderId;		//주문번호
	 	private String mberId;		//아이디
	 	private String orderRec;	//수신자
	 	private String addr1;		//주소
	 	private String detailAddr;	//상세주소
	 	private String orderPhone;	//핸드폰
	 	private int amount;			//총가격
	 	private Date orderDate;		//주문날짜
	 	private String delivery;	//배송
	    
}
