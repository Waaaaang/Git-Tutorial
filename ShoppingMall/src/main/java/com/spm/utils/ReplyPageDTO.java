package com.spm.utils;

import java.util.List;

import com.spm.vo.ReplyVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor //생성자 자동 생성
public class ReplyPageDTO {

	private int replyCnt;			//댓글수
	private List<ReplyVO> list;		//댓글 목록
}
