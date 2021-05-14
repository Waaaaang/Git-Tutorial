package com.spm.web;

import javax.annotation.Resource;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spm.service.ReplyService;
import com.spm.utils.Criteria;
import com.spm.utils.ReplyPageDTO;
import com.spm.vo.ReplyVO;

@RestController		//Controller + ResponseBody
@RequestMapping("/reply")
public class ReplyController {

	@Resource(name="replyService")
	private ReplyService replyService;
	
	//댓글 등록							수신								
	@RequestMapping(value="/insert", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> insert(@RequestBody ReplyVO vo){
		
		if(replyService.checkReply(vo) >=1) {
			return new ResponseEntity<>("fail",HttpStatus.OK);
		} else  {
			int insertCount = replyService.insert(vo);
			return insertCount == 1 ?
				new ResponseEntity<>("success",HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	//댓글 목록
	@RequestMapping(value="/pages/{gdsNo}/{page}",produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("gdsNo") int gdsNO){
		Criteria cri = new Criteria(page, 10);
		return new ResponseEntity<>(replyService.replyPage(cri, gdsNO), HttpStatus.OK);
	}
	
	//@PathVariable : url 경로의 변수
	//댓글 상세
	@RequestMapping(value="/{replyNo}",produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("replyNo") int replyNo){
		return new ResponseEntity<>(replyService.read(replyNo), HttpStatus.OK);
	}
	
	//댓글 삭제
	@RequestMapping(value = "/{replyNo}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo, @PathVariable("replyNo")int replyNo){
		return replyService.delete(vo) == 1 ?
				new ResponseEntity<>("delete review",HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 수정
	@RequestMapping(value="/{replyNo}",method = {RequestMethod.PUT, RequestMethod.PATCH},consumes = "application/json")
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo,@PathVariable("replyNo")int replyNo){
		vo.setReplyNo(replyNo);
		return replyService.update(vo) == 1 ?
				new ResponseEntity<>("update review",HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
