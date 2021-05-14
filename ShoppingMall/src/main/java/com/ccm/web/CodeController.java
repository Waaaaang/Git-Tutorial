package com.ccm.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ccm.service.CmmnCodeService;
import com.ccm.service.DetailCodeService;
import com.ccm.vo.CmmnCodeVO;
import com.ccm.vo.DetailCodeVO;
import com.spm.utils.CodePageDTO;
import com.spm.utils.Criteria;
import com.spm.utils.PageDTO;
import com.spm.vo.MemberVO;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/common/")
public class CodeController {

	@Resource
	private CmmnCodeService cmmnService;
	
	@Resource
	private DetailCodeService detailService;
	
	//jsp
	@RequestMapping("/codePage")
	public ModelAndView codePage(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		MemberVO member = (MemberVO) session.getAttribute("member");
		if(member != null) {
			if("admin".equals(member.getAuth())) {
				mav.setViewName("/common/codePage");
			} else {
				mav.setViewName("/main/main");
			}
		} else {
			mav.setViewName("/member/login");
		}
		return mav;
	}
	
	//코드목록
	@RequestMapping("/cmmnList")
	public ModelAndView cmmnList(CmmnCodeVO vo,Criteria cri) {
		ModelAndView mav = new ModelAndView();
		cri.setAmount(10);
		mav.addObject("list",cmmnService.list(cri));
		int total = cmmnService.getTotal(cri);
		mav.addObject("pageMaker",new PageDTO(cri, total));
		mav.setViewName("/common/cmmnList");
		return mav;
	}
	
	//code_Id에 따른 상세보기
	@RequestMapping("/cmmnCode")
	public ModelAndView cmmnCode(String code_Id) {
		ModelAndView mav = new ModelAndView();
		if(code_Id == null) {
			return mav;
		} else {
			CmmnCodeVO vo = cmmnService.detail(code_Id);
			mav.addObject("cmmn",vo);
			mav.setViewName("/common/cmmnCode");
			return mav;
		}
	}
	
	//코드Id 중복체크
	@RequestMapping("/codeCheck")
	@ResponseBody
	public String codeIdCheck(String code_Id) {
		int result = cmmnService.codeCheck(code_Id);
		if(result != 0) {
			return "fail";
		} else {
			return "success";
		}
	}
	
	//등록
	@RequestMapping("/register")
	public ModelAndView register(CmmnCodeVO vo) {
		ModelAndView mav = new ModelAndView();
		String result = "";
		
		if(cmmnService.insert(vo)) {
			result = "success";
			mav.addObject("result",result);
		} else {
			result = "fail";
			mav.addObject("result",result);
		}
		mav.setViewName("jsonView");
		return mav;
	}
	
	//수정
	@RequestMapping("/modify")
	public ModelAndView modify(CmmnCodeVO vo) {
		ModelAndView mav = new ModelAndView();
		String result = "";
		
		if(cmmnService.update(vo)) {
			result = "success";
			mav.addObject("result",result);
		} else {
			result = "fail";
			mav.addObject("result",result);
		}
		mav.setViewName("jsonView");
		return mav;
	}
	
	//삭제
	@RequestMapping("/remove")
	public ModelAndView remove(CmmnCodeVO vo) {
		ModelAndView mav = new ModelAndView();
		String result = "";
		
		if(cmmnService.delete(vo)) {
			result = "success";
			mav.addObject("result",result);
		} else {
			result = "fail";
			mav.addObject("result",result);
		}
		mav.setViewName("jsonView");
		return mav;
	}
	
	
	//상세코드목록
	@RequestMapping("/detailList")
	public void goDetailList() {
		
	}
	
	//상세 코드 목록 불러오기
	@ResponseBody
	@RequestMapping(value = "/detailList/{code_Id}/{page}",produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<CodePageDTO> detailList(@PathVariable("page")int page, @PathVariable("code_Id") String code_Id){
		Criteria cri  = new Criteria(page, 10);
		return new ResponseEntity<>(detailService.detailPage(cri, code_Id), HttpStatus.OK);
	}
	
	//del_Code_Id에 따른 상세보기
	@RequestMapping("/detailCode")
	public ModelAndView detailCode(String det_Code_Id) {
		ModelAndView mav = new ModelAndView();
		if(det_Code_Id == null) {
			List<CmmnCodeVO> codeList = null;
			codeList = detailService.codeList();
			mav.addObject("codeList",JSONArray.fromObject(codeList));
		} else {
			DetailCodeVO vo = detailService.detail(det_Code_Id);
			mav.addObject("detail",vo);			
		}
		mav.setViewName("/common/detailCode");
		return mav;
	}
	
	//상세등록
	@RequestMapping("/detailRegister")
		public ModelAndView detailRegister(DetailCodeVO vo) {
			ModelAndView mav = new ModelAndView();
			String result = "";
			if(detailService.insert(vo)) {
				result = "success";
				mav.addObject("result",result);
			} else {
				result = "fail";
				mav.addObject("result",result);
			}
			mav.setViewName("jsonView");
			return mav;
		}
		
		//상세수정
		@RequestMapping("/detailModify")
		public ModelAndView detailModify(DetailCodeVO vo) {
			ModelAndView mav = new ModelAndView();
			String result = "";
			
			if(detailService.update(vo)) {
				result = "success";
				mav.addObject("result",result);
			} else {
				result = "fail";
				mav.addObject("result",result);
			}
			mav.setViewName("jsonView");
			return mav;
		}
		
		//상세삭제
		@RequestMapping("/detailRemove")
		public ModelAndView detailRemove(DetailCodeVO vo) {
			ModelAndView mav = new ModelAndView();
			String result = "";
			
			if(detailService.delete(vo)) {
				result = "success";
				mav.addObject("result",result);
			} else {
				result = "fail";
				mav.addObject("result",result);
			}
			mav.setViewName("jsonView");
			return mav;
		}
		
		//코드Id 중복체크
		@RequestMapping("/detailCodeCheck")
		@ResponseBody
		public String detailCodeIdCheck(String det_Code_Id) {
			int result = detailService.detailCodeCheck(det_Code_Id);
			if(result != 0) {
				return "fail";
			} else {
				return "success";
			}
		}
		
		//정렬순서 중복체크
		@RequestMapping("/sortCheck")
		@ResponseBody
		public String sortCheck(DetailCodeVO vo) {
			int result = detailService.sortCheck(vo);
			if(result != 0) {
				return "fail";
			} else {
				return "success";
			}
		}
	
}
