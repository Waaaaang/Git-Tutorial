package com.spm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spm.utils.Criteria;
import com.spm.vo.ReplyVO;

public interface ReplyMapper {

	//댓글 추가
	public int insert(ReplyVO vo);	
	
	//댓글 상세보기
	public ReplyVO read(int replyNo);
	
	//댓글 삭제
	public int delete(ReplyVO vo);
	
	//댓글 수정
	public int update(ReplyVO vo);
	
	//댓글 목록
	public List<ReplyVO> replyList(@Param("cri")Criteria cri, @Param("gdsNo")int gdsNo);
	
	//총 댓글 수
	public int countReply(int gdsNo);
	
	//별점 총 합 
	public String[] getScore(int gdsNo);
	
	//리뷰 체크
	public int checkReply(ReplyVO vo);
}
