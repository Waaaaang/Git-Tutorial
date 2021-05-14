package com.spm.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.spm.mapper.GoodsMapper;
import com.spm.mapper.ReplyMapper;
import com.spm.service.ReplyService;
import com.spm.utils.Criteria;
import com.spm.utils.ReplyPageDTO;
import com.spm.vo.ReplyVO;

@Service("replyService")
public class ReplyServiceImpl implements ReplyService {
	
	@Resource
	private ReplyMapper replyMapper;
	
	@Resource
	private GoodsMapper goodsMapper;

	//댓글 등록
	@Override
	public int insert(ReplyVO vo) {
		goodsMapper.updateReplyCnt(vo.getGdsNo(), 1);
		return replyMapper.insert(vo);
	}

	//댓글 상세보기
	@Override
	public ReplyVO read(int replyNo) {
		return replyMapper.read(replyNo);
	}

	//댓글 삭제
	@Override
	public int delete(ReplyVO vo) {
		ReplyVO rvo = replyMapper.read(vo.getReplyNo());
		goodsMapper.updateReplyCnt(rvo.getGdsNo(), -1);
		return replyMapper.delete(vo);
	}

	//댓글 수정
	@Override
	public int update(ReplyVO vo) {
		return replyMapper.update(vo);
	}

	//전체 댓글 목록
	@Override
	public List<ReplyVO> replyList(Criteria cri, int gdsNo) {
		return replyMapper.replyList(cri, gdsNo);
	}

	//댓글 페이징 처리 (댓글 목록, 총 댓글 수 필요)
	@Override
	public ReplyPageDTO replyPage(Criteria cri, int gdsNo) {
		return new ReplyPageDTO(replyMapper.countReply(gdsNo), replyMapper.replyList(cri, gdsNo));
	}

	//별점 총 합
	@Override
	public int getScore(int gdsNo) {
		String[] score = replyMapper.getScore(gdsNo);
		int total = 0;
		for(int i =0; i<score.length; i++) {
			total += Integer.parseInt(score[i]);
		}
		return total;
	}

	@Override
	public int checkReply(ReplyVO vo) {
		return replyMapper.checkReply(vo);
	}

}
