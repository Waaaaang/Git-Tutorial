package com.spm.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
	
	private int mberNo;				//회원번호
	private String mberId;			//아이디
	private String password;		//패스워드
	private String name;			//이름
	private String phone;			//핸드폰
	private String email;			//이메일
	private String addr1;			//주소
	private String detailAddr;		//상세주소
	private Date firstRegDate;		//최초등록일
	private String firstRegId;		//최초등록자
	private Date lastRegDate;		//최종수정일
	private String lastRegId;		//최종등록자
	private String auth;			//권한
	private int point;				//충전금액
	
	

	
	
}
