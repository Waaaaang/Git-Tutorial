package com.ccm.service;

import java.util.List;

import com.ccm.vo.CmmnCodeVO;
import com.ccm.vo.DetailCodeVO;
import com.spm.utils.CodePageDTO;
import com.spm.utils.Criteria;

public interface DetailCodeService {

		//등록
		public boolean insert(DetailCodeVO vo);
		
		//삭제
		public boolean delete(DetailCodeVO vo);
		
		//수정
		public boolean update(DetailCodeVO vo);
		
		//codeId 목록
		public List<CmmnCodeVO> codeList();
		
		//목록
		public List<DetailCodeVO> list(Criteria cri,String code_Id);
		
		//페이지 목록
		public CodePageDTO detailPage(Criteria cri,String code_Id);
		
		//상세조회
		public DetailCodeVO detail(String det_Code_Id);
		
		//상세코드id 중복검사
		public int detailCodeCheck(String det_Code_Id);
		
		//정렬순서 중복검사
		public int sortCheck(DetailCodeVO vo);
		
		//공통상세코드목록
		public List<DetailCodeVO> cmmnDetailCodeList(DetailCodeVO vo);

}
