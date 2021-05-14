package com.spm.utils;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class AttachFileDTO {

	private String fileId;		//파일식별
	private String uploadPath;	//파일경로
	private String fileName;	//파일네임
	private String image;		//이미지 확인
}