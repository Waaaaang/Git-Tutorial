package com.spm.utils;

import java.util.List;

import com.ccm.vo.DetailCodeVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor //생성자 자동 생성
public class CodePageDTO {

	private int codeCnt;			//상세코드 수
	private List<DetailCodeVO> list;		//상세코드 목록
}
