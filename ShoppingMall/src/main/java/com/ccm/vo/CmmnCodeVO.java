package com.ccm.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CmmnCodeVO {

	//cmmn_code table
	private String code_Id; 		//코드id
    private String code_Nm; 		//코드명
    private String code_Dc; 		//코드설명
    private String use_At; 			//사용여부
    private Date firstRegDate; 		//최초등록일
    private String firstRegId; 		//최초등록자
    private Date lastRegDate; 		//최종수정일
    private String lastRegId; 		//최종수정자
    private String listType;		//목록타입
    
    private String mberId;
}
