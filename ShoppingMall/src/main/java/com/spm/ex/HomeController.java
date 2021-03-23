package com.spm.ex;


import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spm.vo.MemberVO;


@Controller
public class HomeController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(MemberVO vo) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("mberId",vo.getMberId());
		mav.setViewName("/main/main");
		return mav;
	}
	 
	
	
}
