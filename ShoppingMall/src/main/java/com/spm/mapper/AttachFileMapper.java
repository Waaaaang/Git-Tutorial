package com.spm.mapper;

import java.util.List;

import com.spm.vo.AttachFileVO;

public interface AttachFileMapper {

	//파일 하나 추가
	public void insert(AttachFileVO avo);
	
	//파일 하나 삭제
	public void delete(String fileId);
	
	//파일 목록
	public List<AttachFileVO> fileList(int gdsNo);
	
	//상품 삭제시 파일 모두 삭제
	public void deleteAll(int gdsNo);
}
