package com.ccm.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ccm.mapper.DetailCodeMapper;
import com.ccm.service.DetailCodeService;
import com.ccm.vo.CmmnCodeVO;
import com.ccm.vo.DetailCodeVO;
import com.spm.utils.CodePageDTO;
import com.spm.utils.Criteria;

@Service("detailCodeService")
public class DetailCodeServiceImpl implements DetailCodeService {

	@Resource
	private DetailCodeMapper detailMapper;
	
	//등록
	@Override
	public boolean insert(DetailCodeVO vo) {
		return detailMapper.insert(vo) == 1;
	}

	//사용여부 변경
	@Override
	public boolean delete(DetailCodeVO vo) {
		return detailMapper.delete(vo) == 1;
	}

	//수정
	@Override
	public boolean update(DetailCodeVO vo) {
		return detailMapper.update(vo) ==1;
	}

	//목록
	@Override
	public List<DetailCodeVO> list(Criteria cri,String code_Id) {
		return detailMapper.list(cri,code_Id);
	}
	
	//페이지 목록
	@Override
	public CodePageDTO detailPage(Criteria cri, String code_Id) {
		return new CodePageDTO(detailMapper.getTotal(code_Id), detailMapper.list(cri, code_Id));
	}

	//상세
	@Override
	public DetailCodeVO detail(String det_Code_Id) {
		return detailMapper.detail(det_Code_Id);
	}

	//상세코드중복검사
	@Override
	public int detailCodeCheck(String det_Code_Id) {
		return detailMapper.detailCodeCheck(det_Code_Id);
	}

	//codeId 목록
	@Override
	public List<CmmnCodeVO> codeList() {
		return detailMapper.codeList();
	}

	//정렬순서
	@Override
	public int sortCheck(DetailCodeVO vo) {
		return detailMapper.sortCheck(vo);
	}

	//공통상세코드목록
	@Override
	public List<DetailCodeVO> cmmnDetailCodeList(DetailCodeVO vo) {
		return detailMapper.cmmnDetailCodeList(vo);
	}
	

}
