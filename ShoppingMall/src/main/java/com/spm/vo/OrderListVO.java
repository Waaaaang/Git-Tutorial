package com.spm.vo;


import java.util.Date;
import lombok.Getter;
import lombok.Setter;


//주문한 상품 목록 보기
@Getter
@Setter
public class OrderListVO {

    private String orderId;		//주문번호
 	private String mberId;		//아이디
 	private String orderRec;	//수신자
 	private String addr1;		//주소
 	private String detailAddr;	//상세주소
 	private String orderPhone;	//핸드폰
 	private int amount;			//총가격
 	private Date orderDate;		//주문날짜
 	private String delivery;	//배송
	
	private int orderDetailNo;	// 주문 상세 번호
	private int gdsNo;			//상품 번호
	private int cartStock;		//수량
	
	private String gdsName;		//상품이름
	private String gdsImg;		//상품이미지
	private int gdsPrice;		//상품가격
}
