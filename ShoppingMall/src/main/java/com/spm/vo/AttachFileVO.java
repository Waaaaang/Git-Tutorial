package com.spm.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AttachFileVO {

	private String fileId;			//파일식별
	private String uploadPath;		//파일경로
	private String fileName;		//파일이름
	private String fileType;		//파일타입
	private int gdsNo;				//상품번호
}
