package com.ccm.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ccm.mapper.CmmnCodeMapper;
import com.ccm.service.CmmnCodeService;
import com.ccm.vo.CmmnCodeVO;
import com.spm.utils.Criteria;

@Service("CmmnCodeService")
public class CmmnCodeServiceImpl implements CmmnCodeService {

	@Resource
	private CmmnCodeMapper codeMapper;
	
	//등록
	@Override
	public boolean insert(CmmnCodeVO vo) {
		return codeMapper.insert(vo) ==1;
	}

	//사용여부 변경
	@Override
	public boolean delete(CmmnCodeVO vo) {
		return codeMapper.delete(vo) ==1;
	}

	//변경
	@Override
	public boolean update(CmmnCodeVO vo) {
		return codeMapper.update(vo) ==1;
	}

	//목록
	@Override
	public List<CmmnCodeVO> list(Criteria cri) {
		return codeMapper.list(cri);
	}

	//상세
	@Override
	public CmmnCodeVO detail(String code_Id) {
		return codeMapper.detail(code_Id);
	}

	//코드중복검사
	@Override
	public int codeCheck(String code_Id) {
		return codeMapper.codeCheck(code_Id);
	}
	
	//총 코드 수
	@Override
	public int getTotal(Criteria cri) {
		return codeMapper.getTotal(cri);
	}
	
	// 공통 코드 목록
	@Override
	public List<CmmnCodeVO> cmmnCodeList(CmmnCodeVO vo) {
		
		return codeMapper.cmmnCodeList(vo);
	}

}
