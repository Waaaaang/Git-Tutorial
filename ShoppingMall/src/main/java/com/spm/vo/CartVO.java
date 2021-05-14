package com.spm.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CartVO {

	private int cartNo;				//카트번호
	private String mberId;			//유저아이디
	private int gdsNo;				//상품번호
	private int cartStock;			//수량
	private Date addDate;			//날짜
	
	//카트 리스트 
	private int num;
	private String gdsName;			//상품 이름
	private int gdsPrice;			//상품가격
	private String gdsImg;			//상품이미지
	
	
	//업로드
	private String fileId;			//파일아이디
	private String uploadPath;			//파일업로드
	private String fileName;			//파일이름
}
