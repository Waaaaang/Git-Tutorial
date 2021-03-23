package com.spm.mapper;

import java.util.List;

import com.spm.utils.Criteria;
import com.spm.vo.CartVO;
import com.spm.vo.CategoryVO;
import com.spm.vo.GoodsVO;
import com.spm.vo.OrderDetailVO;
import com.spm.vo.OrderListVO;
import com.spm.vo.OrderVO;

public interface GoodsMapper {

	//상품 목록
	public List<GoodsVO> getList(Criteria cri);
	
	//상품 등록
	public int insert(GoodsVO vo);
	
	//상풍 삭제
	public int delete(int gdsNo);
	
	//상품 수정
	public int update(GoodsVO vo);	
	
	//상품 상세
	public GoodsVO detail(int gdsNo);
	
	//총 상품 수
	public int getTotal(Criteria cri);
	
	//카테고리
	public List<CategoryVO> category();
	
	//카트담기
	public void addCart(CartVO vo);
	
	//카트리스트
	public List<CartVO> cartList(String mberId);
	
	//카트리스트 삭제
	public int deleteCart(CartVO vo);
	
	//카테고리별 상품리스트
	public List<GoodsVO> categoryList(int cateCode);
	
	//카테고리별 수
	public int categoryCount(int cateCode);
	
	//주문 정보
	public void orderInfo(OrderVO vo);
	
	//주문 상세 정보
	public void orderInfo_Detail(OrderDetailVO vo);
	
	//주문후 카트지우기
	public void cartAllDelete(String mberId);
	
	//유저 주문 목록
	public List<OrderVO> orderList(OrderVO vo);
	
	//관리자가 유저 주문 목록
	public List<OrderVO> adminList(Criteria cri);
	
	//총 주문 수
	public int getOrderTotal(Criteria cri);
	
	//주문한 상품번호에 따른 목록보기
	public List<OrderListVO> orderView(OrderVO vo);
	
	//배송 상태
	public int delivery(OrderVO vo);
	
}
