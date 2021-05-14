package com.ccm.service;

import java.util.List;

import com.ccm.vo.CmmnCodeVO;
import com.spm.utils.Criteria;

public interface CmmnCodeService {

		//등록
		public boolean insert(CmmnCodeVO vo);
		
		//삭제
		public boolean delete(CmmnCodeVO vo);
		
		//수정
		public boolean update(CmmnCodeVO vo);
		
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
