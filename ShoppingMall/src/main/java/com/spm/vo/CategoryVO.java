package com.spm.vo;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CategoryVO {

	private String cateName;		//상품이름
	private String cateCode;		//상품코드
	private String cateCodeRef;		//상품코드나누기
	private int level;				//카테고리 계층 구분 
}
