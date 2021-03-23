package com.spm.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GoodsVO {

	private int gdsNo;				//상품번호
	private String gdsName;			//상품이름
	private String cateCode;		//상품코드
	private int gdsPrice;			//상품가격
	private String gdsDes;			//상품설명
	private String gdsImg;			//상품이미지
	private Date firstRegDate;		//최초등록일
	private String firstRegId;		//최초등록자
	private Date lastRegDate;		//최종수정일
	private String lastRegId;		//최종등록자	
	private String mberId;


}
