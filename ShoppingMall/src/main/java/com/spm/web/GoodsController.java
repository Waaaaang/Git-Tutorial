package com.spm.web;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spm.service.GoodsService;
import com.spm.utils.Criteria;
import com.spm.utils.PageDTO;
import com.spm.vo.CartVO;
import com.spm.vo.CategoryVO;
import com.spm.vo.GoodsVO;
import com.spm.vo.MemberVO;
import com.spm.vo.OrderDetailVO;
import com.spm.vo.OrderListVO;
import com.spm.vo.OrderVO;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/goods/*")
public class GoodsController {

	@Resource(name="goodsService")
	private GoodsService goodsService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	//상품리스트
	@RequestMapping("/goods")
	public ModelAndView goods(GoodsVO vo,Criteria cri) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list",goodsService.getList(cri));
		int total = goodsService.getTotal(cri);
		mav.addObject("pageMaker",new PageDTO(cri, total));
		mav.setViewName("/goods/goods");
		return mav;
	}
	
	//상세보기
	@RequestMapping("/detail")
	public ModelAndView detail(GoodsVO vo,@RequestParam("gdsNo") int gdsNo) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("goods",goodsService.detail(gdsNo));
		mav.setViewName("/goods/detail");
		return mav;
	}
	
	// 등록하러가기
	@RequestMapping("/register")
	public ModelAndView goRegister() {
		ModelAndView mav = new ModelAndView();
		List<CategoryVO> category = null;
		category = goodsService.category();
		mav.addObject("category",JSONArray.fromObject(category));
		mav.setViewName("/goods/register");
		return mav;
	}
	
	// 상품등록
	@RequestMapping("/insert")
	public ModelAndView insert(GoodsVO vo) throws  Exception {
		ModelAndView mav = new ModelAndView();
		
		String result = "";			// 결과
		int cnt = goodsService.insert(vo);
		if(cnt > 0 ) {
			result = "success";
			mav.addObject("result",result);
		} else {
			result = "fail";
			mav.addObject("result",result);
		}
		mav.setViewName("/goods/register");
		return mav;
	}
	
	//상품 수정하러 가기
	@RequestMapping("/modify")
	public ModelAndView modify(GoodsVO vo,@RequestParam("gdsNo") int gdsNo) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("goods",goodsService.detail(gdsNo));
		mav.setViewName("/goods/modify");
		return mav;
	}
	
	//상품수정
	@RequestMapping("/update")
	public ModelAndView update(GoodsVO vo) {
		ModelAndView mav = new ModelAndView();
		String result = "";
		
		if(goodsService.update(vo)) {
			result = "success";
			mav.addObject("result",result);
		} else {
			result = "fail";
			mav.addObject("result",result);
		}
		mav.setViewName("/goods/modify");
		return mav;
	}
	
	//상품 삭제
	@RequestMapping("/remove")
	public ModelAndView remove(GoodsVO vo) {
		ModelAndView mav = new ModelAndView();
		String result = "";
		
		if(goodsService.delete(vo.getGdsNo())) {
			result = "success";
			mav.addObject("result",result);
		} else {
			result = "fail";
			mav.addObject("result",result);
		}
		mav.setViewName("jsonView");
		return mav;
	}
	
	//장바구니담기
	@ResponseBody
	@RequestMapping("/addCart")
	public void addCart(CartVO vo) {
		goodsService.addCart(vo);
	}
	
	//장바구니 리스트
	@RequestMapping("/cartList")
	public ModelAndView cartList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		MemberVO member = (MemberVO)session.getAttribute("member");
		List<CartVO> cartList = goodsService.cartList(member.getMberId());
		mav.addObject("cartList",cartList);
		mav.setViewName("/goods/cartList");
		return mav;
	}
	
	//장바구니 목록 삭제
	@RequestMapping("/deleteCart")
	public ModelAndView deleteCart(CartVO vo) {
		ModelAndView mav = new ModelAndView();
		String result ="";
		int cnt = goodsService.deleteCart(vo);
		if(cnt > 0) {
			result = "success";
			mav.addObject("result",result);
		} else {
			result = "fail";
			mav.addObject("result",result);
		}
		mav.setViewName("jsonView");
		return mav;
	}
	
	//ajax
	//list
	@RequestMapping({"/men/men","/kids/kids","/women/women"})
	public ModelAndView categoryAjax(GoodsVO vo,int cateCode,Criteria cri) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("list",goodsService.categoryList(cateCode));
		int total = goodsService.categoryCount(cateCode);
		mav.addObject("pageMaker",new PageDTO(cri, total));
		if(cateCode == 100 || cateCode ==  101 || cateCode ==  102 || cateCode == 103) {
			mav.setViewName("/goods/men/men");
		} else if(cateCode == 200 || cateCode ==  201 || cateCode ==  202 || cateCode == 203) {
			mav.setViewName("/goods/women/women");
		} else if(cateCode == 300 || cateCode ==  301 || cateCode ==  302 || cateCode == 303) {
			mav.setViewName("/goods/kids/kids");
		}
		return mav;
	}
	
	//카테고리별 리스트
	@RequestMapping({"/men/menList","/women/womenList","/kids/kidsList"})
	public ModelAndView categoryList(@RequestParam("cateCode")int cateCode) {
		ModelAndView mav = new ModelAndView();
		if(cateCode == 100 || cateCode ==  101 || cateCode ==  102 || cateCode == 103) {
			mav.addObject("cateCode",cateCode);
			mav.setViewName("/goods/men/menList");
		} else if(cateCode == 200 || cateCode ==  201 || cateCode ==  202 || cateCode == 203) {
			mav.addObject("cateCode",cateCode);
			mav.setViewName("/goods/women/womenList");
		} else if(cateCode == 300 || cateCode ==  301 || cateCode ==  302 || cateCode == 303) {
			mav.addObject("cateCode",cateCode);
			mav.setViewName("/goods/kids/kidsList");
		}
		return mav;
	}
	
	//상세보기Ajax
	@RequestMapping({"/men/menDetailAjax","/women/womenDetailAjax","/kids/kidsDetailAjax"})
	public ModelAndView detailAjax(GoodsVO vo,@RequestParam("gdsNo") int gdsNo) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("goods",goodsService.detail(gdsNo));
		return mav;
	}
	
	//주문
	@RequestMapping("/order")
	public ModelAndView order(HttpSession session,OrderVO order,OrderDetailVO orderDetail) {
		
		ModelAndView mav = new ModelAndView();
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);	
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));	//년/월/일 
		String subNum ="";
		for(int i =1; i<=6; i++) {
			subNum += (int)(Math.random()*10);
		}
		String orderId = ymd + "_"+subNum; 		// ex) 20210318_random
				
		order.setMberId(member.getMberId());
		order.setOrderId(orderId);
		goodsService.orderInfo(order);
		
		orderDetail.setOrderId(orderId);
		goodsService.orderInfo_Detail(orderDetail);
		
		goodsService.cartAllDelete(member.getMberId());
	
		mav.addObject("result","success");
		mav.setViewName("/goods/cartList");
		return mav;
	}
	
	//유저 주문 목록
	@RequestMapping("/orderList")
	public ModelAndView orderList(OrderVO order,HttpSession session,Criteria cri) {
		ModelAndView mav = new ModelAndView();
		MemberVO member =  (MemberVO) session.getAttribute("member");
		order.setMberId(member.getMberId());
		if("admin".equals(member.getAuth())) {
			List<OrderVO> adminList = goodsService.adminList(cri);
			int total = goodsService.getOrderTotal(cri);
			mav.addObject("pageMaker",new PageDTO(cri, total));
			mav.addObject("orderList",adminList);
		} else if("user".equals(member.getAuth())){
			List<OrderVO> orderList = goodsService.orderList(order);
			mav.addObject("orderList",orderList);
		}
		mav.setViewName("/goods/orderList");
		return mav;
	}
	
	//주문한 상품번호에 따른 목록보기
	@RequestMapping("/orderView")
	public ModelAndView orderView(HttpSession session,OrderVO order,@RequestParam("orderId") String orderId,@RequestParam("mberId") String mberId) {
		ModelAndView mav = new ModelAndView();
		MemberVO member = (MemberVO)session.getAttribute("member");
		if("admin".equals(member.getAuth())) {
			order.setMberId(mberId);
			order.setOrderId(orderId);
		} else if("user".equals(member.getAuth())) {
			order.setMberId(member.getMberId());
			order.setOrderId(orderId);
		}
		List<OrderListVO> orderView = goodsService.orderView(order);
		
		mav.addObject("orderView",orderView);
		mav.setViewName("/goods/orderView");
		return mav;
	}
	
	//배송 상태
	@RequestMapping("/delivery")
	public ModelAndView delivery(OrderVO vo) {
		ModelAndView mav = new ModelAndView();
		int cnt = goodsService.delivery(vo);
		String result ="";
		if(cnt >0) {
			result ="success";
			mav.addObject("result",result);
		} else {
			result ="fail";
			mav.addObject("result",result);
		} 
			mav.setViewName("jsonView");
		return mav;
	}
}
