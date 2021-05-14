package com.spm.utils;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ccm.mapper.CmmnCodeMapper;
import com.ccm.mapper.DetailCodeMapper;
import com.ccm.vo.CmmnCodeVO;
import com.ccm.vo.DetailCodeVO;


public class AcceptInterceptor extends HandlerInterceptorAdapter {

	@Resource
	private CmmnCodeMapper cmmnCodeMapper;
	
	@Resource
	private DetailCodeMapper detailCodeMapper;
	
	   @Override
	   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {		  
	      
		  return super.preHandle(request, response, handler);
	   }
	   
	   @Override
	   public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
				ModelAndView modelAndView) throws Exception {
		
			CmmnCodeVO cmmnCodeVO = new CmmnCodeVO();
			
			String goods_Nm = "goods";
			// 상위 상품 분류
			cmmnCodeVO.setListType(goods_Nm);
			try {
				List<CmmnCodeVO> cmmnCodeList = null;
					cmmnCodeList = cmmnCodeMapper.cmmnCodeList(cmmnCodeVO);
			
				modelAndView.addObject("cmmnCodeList", cmmnCodeList);
				
				
				// 하위 상품 분류
				DetailCodeVO detailCodeVO = new DetailCodeVO();
				
				detailCodeVO.setListType(goods_Nm);
				List<DetailCodeVO> cmmnDetailCodeList = detailCodeMapper.cmmnDetailCodeList(detailCodeVO);
				modelAndView.addObject("cmmnDetailCodeList", cmmnDetailCodeList);
			} catch(NullPointerException e) {
				
			}
			
			
			super.postHandle(request, response, handler, modelAndView);
		}
}
