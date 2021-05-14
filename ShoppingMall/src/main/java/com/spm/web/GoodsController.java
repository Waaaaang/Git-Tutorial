package com.spm.web;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ccm.mapper.CmmnCodeMapper;
import com.ccm.service.DetailCodeService;
import com.ccm.vo.CmmnCodeVO;
import com.ccm.vo.DetailCodeVO;
import com.spm.service.GoodsService;
import com.spm.service.ReplyService;
import com.spm.utils.Criteria;
import com.spm.utils.PageDTO;
import com.spm.vo.AttachFileVO;
import com.spm.vo.CartVO;
import com.spm.vo.GoodsVO;
import com.spm.vo.MemberVO;
import com.spm.vo.OrderDetailVO;
import com.spm.vo.OrderListVO;
import com.spm.vo.OrderVO;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/goods/*")
public class GoodsController {

	@Resource
	private GoodsService goodsService;

	@Resource
	private ReplyService replyService;
	
	@Resource
	private DetailCodeService detailCodeService;
	
	@Resource
	private CmmnCodeMapper cmmnCodeMapper;
	
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
	public ModelAndView detail(@RequestParam("gdsNo") int gdsNo) {
		ModelAndView mav = new ModelAndView();
		//리뷰 댓글마다 달린 점수의 총 합
		int score = replyService.getScore(gdsNo);
		//리뷰댓글 수
		int replyCnt = goodsService.getReplyCnt(gdsNo);
		//평점
		int sumScore;
		if(score == 0 || replyCnt == 0) {
			sumScore = 0;
		} else {
			sumScore = score / replyCnt;
		}
		mav.addObject("score",sumScore);
		mav.addObject("goods",goodsService.detail(gdsNo));
		mav.setViewName("/goods/detail");
		return mav;
	}
	
	// 등록하러가기
	@RequestMapping("/register")
	public ModelAndView goRegister(HttpSession session)  {
		MemberVO member = (MemberVO) session.getAttribute("member");
		ModelAndView mav = new ModelAndView();
		// 하위 상품 분류
		String goods = "goods";
		DetailCodeVO detailCodeVO = new DetailCodeVO();
		CmmnCodeVO cmmnCodeVO = new CmmnCodeVO();
		cmmnCodeVO.setListType(goods);
		detailCodeVO.setListType(goods);
		List<CmmnCodeVO> cmmnCodeList = null;
		List<DetailCodeVO> cmmnDetailCodeList = null;
		if(member != null) {
			if("admin".equals(member.getAuth())) {
				cmmnCodeList = cmmnCodeMapper.cmmnCodeList(cmmnCodeVO);
				cmmnDetailCodeList = detailCodeService.cmmnDetailCodeList(detailCodeVO);
				mav.addObject("cmmnCodeList", cmmnCodeList);
				mav.addObject("detailCodeList", JSONArray.fromObject(cmmnDetailCodeList));
			} else if("user".equals(member.getAuth())) {
				mav.addObject("auth","권한이없습니다.");
				mav.addObject("url","/");
			}
		} else  {
			mav.addObject("auth","권한이없습니다.");
			mav.addObject("url","/member/login");
		}
		
		mav.setViewName("/goods/register");
		return mav;
	}
	
	// 상품등록
	@RequestMapping("/insert")
	public ModelAndView insert(GoodsVO vo) throws  Exception {
		ModelAndView mav = new ModelAndView();
		String result = "";			// 결과
	
		if(goodsService.insert(vo)) {
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
	public ModelAndView modify(GoodsVO vo,@RequestParam("gdsNo") int gdsNo,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		MemberVO member = (MemberVO) session.getAttribute("member");
		if(member != null) {
			if("admin".equals(member.getAuth())) {
				mav.addObject("goods",goodsService.detail(gdsNo));
			} else if("user".equals(member.getAuth())) {
				mav.addObject("auth","권한이없습니다.");
				mav.addObject("url","/");
			}
		} else  {
			mav.addObject("auth","권한이없습니다.");
			mav.addObject("url","/member/login");
		}
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
		mav.addObject("member",member);
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
		//리뷰 댓글마다 달린 점수의 총 합
		int score = replyService.getScore(gdsNo);
		//리뷰댓글 수	
		int replyCnt = goodsService.getReplyCnt(gdsNo);
		//평점
		int sumScore;
		if(score == 0 || replyCnt == 0) {
			sumScore = 0;
		} else {
			sumScore = score / replyCnt;
		}
		mav.addObject("score",sumScore);
		mav.addObject("goods",goodsService.detail(gdsNo));
		return mav;
	}
	
	//주문
	@RequestMapping("/order")
	public ModelAndView order(HttpSession session,OrderVO order,OrderDetailVO orderDetail) {
		
		ModelAndView mav = new ModelAndView();
		MemberVO member = (MemberVO)session.getAttribute("member");
		if(member.getPoint() < order.getAmount()) {
			mav.addObject("result","fail");
		} else {
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);	
			String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
			String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));	//년/월/일 
			String subNum =	UUID.randomUUID().toString().replaceAll("-", "").substring(0,6);
			
			String orderId = ymd + "_"+subNum; 		// ex) 20210318_random
					
			order.setMberId(member.getMberId());
			order.setOrderId(orderId);
			goodsService.orderInfo(order);
			
			orderDetail.setOrderId(orderId);
			orderDetail.setMberId(member.getMberId());
			goodsService.orderInfo_Detail(orderDetail);
			
			//상품 수량 조절 
			List<OrderListVO> orderView = goodsService.orderView(order);
			GoodsVO goods = new GoodsVO();
				for(OrderListVO i : orderView) {
					goods.setGdsNo(i.getGdsNo());
					goods.setGdsStock(i.getCartStock());
					goodsService.changeStock(goods);
			}
			
			goodsService.cartAllDelete(member.getMberId());	//장바구니 지우기
			goodsService.pointUpdate(order);	//주문후 금액변화
			mav.addObject("result","success");
		}
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
			cri.setAmount(5);
			List<OrderVO> adminList = goodsService.adminList(cri);
			int total = goodsService.getOrderTotal(cri);
			mav.addObject("total",total);
			mav.addObject("pageMaker",new PageDTO(cri, total));
			mav.addObject("orderList",adminList);
		} else if("user".equals(member.getAuth())){
			List<OrderVO> orderList = goodsService.orderList(order);
			int total = orderList.size();
			mav.addObject("total",total);
			mav.addObject("orderList",orderList);
		}
		mav.setViewName("/goods/orderList");
		return mav;
	}
	
	//주문한 상품번호에 따른 목록보기
	@RequestMapping("/orderView")
	public ModelAndView orderView(OrderVO order,@RequestParam("orderId") String orderId,@RequestParam("mberId") String mberId) {
		ModelAndView mav = new ModelAndView();
		order.setOrderId(orderId);
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
		OrderVO order = new OrderVO();
		//상품 수량 조절 
		if("주문취소완료".equals(vo.getDelivery())) {
			List<OrderListVO> orderView = goodsService.orderView(vo);
			GoodsVO goods = new GoodsVO();
				for(OrderListVO i : orderView) {
					goods.setGdsNo(i.getGdsNo());
					goods.setGdsStock(-(i.getCartStock()));
					goodsService.changeStock(goods);
				}
				
				order.setAmount(-(vo.getAmount()));		//주문취소후 금액변화
				order.setMberId(vo.getMberId());		
				goodsService.pointUpdate(order);	//주문취소후 금액변화
			}
		
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
	
	//사진 목록 가져오기
	@RequestMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody //서버와 클라이언트 간 통신 역할
	public ResponseEntity<List<AttachFileVO>> fileList(int gdsNo){
		return new ResponseEntity<>(goodsService.fileList(gdsNo),HttpStatus.OK);
	}
	
	
}
