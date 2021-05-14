package com.ccm.mapper;

import java.util.List;

import com.ccm.vo.CmmnCodeVO;
import com.spm.utils.Criteria;

public interface CmmnCodeMapper {

	//등록
	public int insert(CmmnCodeVO vo);
	
	//삭제
	public int delete(CmmnCodeVO vo);
	
	//수정
	public int update(CmmnCodeVO vo);
	
	//목록
	public List<CmmnCodeVO> list(Criteria cri);
	
	//상세조회
	public CmmnCodeVO detail(String code_Id);
	
	//코드id 중복검사
	public int codeCheck(String code_Id);
	
	//총 코드 수
	public int getTotal(Criteria cri);
	
	// 공통 코드 목록
	public List<CmmnCodeVO> cmmnCodeList(CmmnCodeVO vo);
}
