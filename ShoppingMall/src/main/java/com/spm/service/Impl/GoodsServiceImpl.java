package com.spm.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.spm.mapper.AttachFileMapper;
import com.spm.mapper.GoodsMapper;
import com.spm.service.GoodsService;
import com.spm.utils.Criteria;
import com.spm.vo.AttachFileVO;
import com.spm.vo.CartVO;
import com.spm.vo.CategoryVO;
import com.spm.vo.GoodsVO;
import com.spm.vo.OrderDetailVO;
import com.spm.vo.OrderListVO;
import com.spm.vo.OrderVO;

@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {

	@Resource
	private GoodsMapper goodsMapper;
	
	@Resource
	private AttachFileMapper fileMapper;
	
	//상품 목록
	@Override
	public List<GoodsVO> getList(Criteria cri) {
		return goodsMapper.getList(cri);
	}

	//상품등록
	@Override
	public boolean insert(GoodsVO vo) {
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return false;
		}
		vo.getAttachList().forEach(attach -> {
			attach.setGdsNo(vo.getGdsNo());
			vo.setFileId(attach.getFileId());
			fileMapper.insert(attach);
		});
		return goodsMapper.insert(vo) == 1;
	}

	//상품삭제
	@Override
	public boolean delete(int gdsNo) {
		fileMapper.deleteAll(gdsNo);
		return goodsMapper.delete(gdsNo) == 1;
	}
	
	//상품수정
	@Override
	public boolean update(GoodsVO vo) {
		fileMapper.deleteAll(vo.getGdsNo()); 
		if(vo.getAttachList() != null && vo.getAttachList().size() > 0) {
			vo.getAttachList().forEach(attach -> {
				attach.setGdsNo(vo.getGdsNo());
				vo.setFileId(attach.getFileId());
				fileMapper.insert(attach);
			});
		}
		return goodsMapper.update(vo) == 1;
	}

	//상품상세
	@Override
	public GoodsVO detail(int gdsNo) {
		return goodsMapper.detail(gdsNo);
	}

	//총 상품 수 
	@Override
	public int getTotal(Criteria cri) {
		return goodsMapper.getTotal(cri);
	}

	//카테고리
	@Override
	public List<CategoryVO> category() {
		return goodsMapper.category();
	}

	//장바구니 담기
	@Override
	public void addCart(CartVO vo) {
		goodsMapper.addCart(vo);
	}

	//장바구니 리스트
	@Override
	public List<CartVO> cartList(String mberId) {
		return goodsMapper.cartList(mberId);
	}

	//카트리스트삭제
	@Override
	public int deleteCart(CartVO vo) {
		return goodsMapper.deleteCart(vo);		
	}

	//카테고리별 상품리스트
	@Override
	public List<GoodsVO> categoryList(int cateCode) {
		return goodsMapper.categoryList(cateCode);
	}

	//카테고리별 상품수
	@Override
	public int categoryCount(int cateCode) {
		return goodsMapper.categoryCount(cateCode);
	}

	//주문정보
	@Override
	public void orderInfo(OrderVO vo) {
		goodsMapper.orderInfo(vo);
	}

	//주문 상세정보
	@Override
	public void orderInfo_Detail(OrderDetailVO vo) {
		goodsMapper.orderInfo_Detail(vo);		
	}
	
	//주문후 카트지우기
	@Override
	public void cartAllDelete(String mberId) {
		goodsMapper.cartAllDelete(mberId);		
	}

	//유저 주문 목록
	@Override
	public List<OrderVO> orderList(OrderVO vo) {
		return goodsMapper.orderList(vo);
	}
	
	//주문한 상품번호에 따른 목록보기
	@Override
	public List<OrderListVO> orderView(OrderVO vo) {
		return goodsMapper.orderView(vo);
	}
	
	//관리자가 유저 주문 목록
	@Override
	public List<OrderVO> adminList(Criteria cri) {
		return goodsMapper.adminList(cri);
	}
	
	//총 주문 수
	@Override
	public int getOrderTotal(Criteria cri) {
		return goodsMapper.getOrderTotal(cri);
	}
	
	//배송 상태
	@Override
	public int delivery(OrderVO vo) {
		return goodsMapper.delivery(vo);
	}
	
	//배송 후 상품 수량 조절
	@Override
	public void changeStock(GoodsVO vo) {
		goodsMapper.changeStock(vo);		
	}
	
	//첨부된 사진 목록
	@Override
	public List<AttachFileVO> fileList(int gdsNo) {
		return fileMapper.fileList(gdsNo);
	}

	// 총 리뷰댓글 수
	@Override
	public int getReplyCnt(int gdsNo) {
		return goodsMapper.getReplyCnt(gdsNo);
	}
	
	//주문후 금액변화
	@Override
	public void pointUpdate(OrderVO vo) {
		goodsMapper.pointUpdate(vo);
	}

}
