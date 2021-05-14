package com.spm.service;

import java.util.List;

import com.spm.utils.Criteria;
import com.spm.utils.ReplyPageDTO;
import com.spm.vo.ReplyVO;

public interface ReplyService {

		//댓글 추가
		public int insert(ReplyVO vo);	
		
		//댓글 상세보기
		public ReplyVO read(int replyNo);
		
		//댓글 삭제
		public int delete(ReplyVO vo);
		
		//댓글 수정
		public int update(ReplyVO vo);
		
		//댓글 목록
		public List<ReplyVO> replyList(Criteria cri, int gdsNo);
		
		//댓글 페이지 목록
		public ReplyPageDTO replyPage(Criteria cri, int gdsNo);
		
		//별점 총 합 
		public int getScore(int gdsNo);
		
		//리뷰 작성 체크
		public int checkReply(ReplyVO vo);
}
