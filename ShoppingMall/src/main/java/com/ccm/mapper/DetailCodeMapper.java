package com.ccm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ccm.vo.CmmnCodeVO;
import com.ccm.vo.DetailCodeVO;
import com.spm.utils.Criteria;

public interface DetailCodeMapper {

	//등록
	public int insert(DetailCodeVO vo);
	
	//삭제
	public int delete(DetailCodeVO vo);
	
	//수정
	public int update(DetailCodeVO vo);
	
	//codeId 목록
	public List<CmmnCodeVO> codeList();
	
	//목록
	public List<DetailCodeVO> list(@Param("cri") Criteria cri,@Param("code_Id")String code_Id);
	
	//상세조회
	public DetailCodeVO detail(String det_Code_Id);
	
	//상세코드id 중복검사
	public int detailCodeCheck(String det_Code_Id);
	
	//정렬순서 중복검사
	public int sortCheck(DetailCodeVO vo);
	
	//총 코드 수
	public int getTotal(String code_Id);
	
	//공통상세코드목록
	public List<DetailCodeVO> cmmnDetailCodeList(DetailCodeVO vo);
	
	
}
