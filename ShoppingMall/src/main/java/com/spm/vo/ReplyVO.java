package com.spm.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ReplyVO {

	private int replyNo;			//댓글번호
    private String reply;			//댓글
    private int score;				//별점
    private Date firstRegDate;		//최초등록일
    private String firstRegId;		//최초등록자
    private Date lastRegDate;		//최종등록일
    private String lastRegId;		//최종수정자
    private int gdsNo;				//상품번호
    
    private String mberId;			//작성자
}
