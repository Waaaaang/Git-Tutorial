package com.spm.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spm.service.MemberService;
import com.spm.vo.MemberVO;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Resource(name="memberService")
	private MemberService memberService;
	
	//회원가입 jsp
	@RequestMapping("/register")
	public String register(HttpServletRequest req, HttpServletResponse res, MemberVO vo) {
		return "/member/register";
	}
	
	//회원가입등록처리
	@RequestMapping("/insert")
	public ModelAndView insert(MemberVO vo) {
		
		ModelAndView mav = new ModelAndView();

		String result = "";			// 결과

		int cnt = memberService.insert(vo);
		if(cnt > 0 ) {
			result = "success";
			mav.addObject("result",result);
		} else {
			result = "fail";
			mav.addObject("result",result);
		}
		mav.setViewName("jsonView");
		return mav;
	}
	
	//로그인 jsp
	@RequestMapping("/login")
	public String login() {
		return "/member/login";
	}
	
	//로그인
	@RequestMapping("/loginInsert")
	public ModelAndView loginInsert(MemberVO vo,HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		String result = "";
		MemberVO member = memberService.login(vo);
		if(member != null) {
			result = "success";
			mav.addObject("result",result);
			mav.addObject("mberId",member.getMberId());
			session.setAttribute("member", member);
		} else {
			result = "fail";
			mav.addObject("result",result);
		}
		mav.setViewName("jsonView");
		return mav;
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	
	//아이디 중복 검사 
	@RequestMapping("/mberIdCheck")
	@ResponseBody
	public String mberIdCheck(String mberId) {
		int result = memberService.mberIdCheck(mberId);
		if(result != 0) {
			return "fail";
		} else {
			return "success";
		}
	}
	
	//이메일 중복 체크
	@RequestMapping("/emailCheck")
	@ResponseBody
	public String emailCheck(String email) {
		int result = memberService.emailCheck(email);
		if(result != 0) {
			return "fail";
		} else {
			return "success";
		}
	}
	
	//아이지 찾기 jsp
	@RequestMapping("/findId")
	public String findId() {
		return "/member/findId";
	}
	
	//아이디 찾기 
	@RequestMapping("/findIdInsert")
	public ModelAndView findIdInsert(HttpServletRequest req, String email) {
		
		ModelAndView mav = new ModelAndView();

		String mberId = memberService.findId(email);
		String result = "";
		
		if((!"".equals(mberId)) && mberId != null) {
		
			result = "success";
			mav.addObject("mberId",mberId);
			mav.addObject("result",result);

		} else {
			result = "fail";
			mav.addObject("result",result);
			
		}
		
		mav.setViewName("jsonView");
		return mav;

	}
	
	//비밀번호 찾기
	@RequestMapping("/findPw")
	public String findPw() {
		return "/member/findPw";
	}
	
	//비밀번호 찾기 
	@RequestMapping("/findPwInsert")
	public ModelAndView findPwInsert(HttpServletRequest req, MemberVO vo) {
			
		ModelAndView mav = new ModelAndView();
		
		String password = memberService.findPw(vo);

		String result = "";
		
		if((!"".equals(password)) && password != null) {
			
			result = "success";
			mav.addObject("password",password);
			mav.addObject("result",result);
			
		} else {
			result = "fail";
			mav.addObject("result",result);
				
		}
			mav.setViewName("jsonView");
			return mav;

	}
	
	//비밀번호 변경
	@RequestMapping("/updatePw")
	public ModelAndView updatePw(MemberVO vo) {
		
		ModelAndView mav = new ModelAndView();
		String result = "";
		
		int cnt = memberService.updatePw(vo);
		if(cnt > 0 ) {
			result = "success";
			mav.addObject("result",result);
		} else {
			result = "fail";
			mav.addObject("result",result);
		}
		mav.setViewName("jsonView");
		return mav;
		
	}
	
	//마이페이지
	@RequestMapping("/myPage")
	public ModelAndView myPage(MemberVO vo,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		MemberVO member = (MemberVO)session.getAttribute("member");
		mav.addObject("member",memberService.myPage(member.getMberId()));
		mav.setViewName("/member/myPage");
		return mav;
	}
	
	//회원탈퇴
	@RequestMapping("/member/myPageRemove")
	public ModelAndView myPageRemove(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		MemberVO member = (MemberVO)session.getAttribute("member");
		String result = "";
		if(memberService.deleteMember(member.getMberId())) {
			result ="success";
			mav.addObject("result",result);
			session.invalidate();
		} else {
			result = "fail";
			mav.addObject("result",result);
		}
		mav.setViewName("jsonView");
		return mav;
	}
	
	//회원정보수정
	@RequestMapping("/member/myPageModify")
	@ResponseBody
	public String myPageModify(MemberVO vo) {
		if(memberService.updateMember(vo)) {
			return "success"; 
		} else {
			return "fail";
		}
	}
	
}
