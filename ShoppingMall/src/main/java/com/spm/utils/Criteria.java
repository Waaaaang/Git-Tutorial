package com.spm.utils;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum; //페이지 번호
	private int amount; //한 페이지당 글의 개수
	
	private String type; //검색 조건
	private String keyword; //검색 키워드(검색 분류)
	
	public Criteria() {
		this(1,9); //1페이당 10개씩이 default
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum; 
		this.amount = amount;
	}
	
	//검색 조건을 배열로 받아서 구분
	public String[] getTypeArr() {
		return type == null? new String[] {} : type.split("");
	}
	
	public String getListLink() {
		//여러 개 파라미터들을 연결하여 하나의 URL 링크로 만들어서 반환
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("") 
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
}
