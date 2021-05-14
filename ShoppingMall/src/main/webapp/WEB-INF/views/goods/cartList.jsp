<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<style>
 section#content ul li { margin:10px 0; list-style: none;}
 section#content ul li img { width:250px; height:250px; }
 section#content ul li::after { content:""; display:block; clear:both; }
 section#content div.thumb { float:left; width:250px; }
 section#content div.gdsInfo { float:right; width:calc(100% - 270px); }
 section#content div.gdsInfo { font-size:20px; line-height:2; }
 section#content div.gdsInfo span { display:inline-block; width:100px; font-weight:bold; margin-right:10px; }
 section#content div.gdsInfo .delete { font-size:22px; padding:5px 10px; border:1px solid #eee; background:#eee;}
.listResult { padding:20px; background:#eee; }
.listResult .sum { float:left; width:45%; font-size:22px; }

.listResult .order { float:right; width:45%; text-align:right; }
.listResult .order button { font-size:18px; padding:5px 10px; border:1px solid #999; background:#fff;}
.listResult::after { content:""; display:block; clear:both; }

.orderInfo { border: 3px solid #eee; padding:20px; display: none; }

#order label {width: 100px; }

</style>

<section id="content">
 
 <ul>
 
 	<c:set var="sum" value="0" />
 
  <c:forEach items="${cartList}" var="cartList">
  <li>
   <div class="thumb">
    <img src="/display?fileName=${cartList.uploadPath}/thumb_${cartList.fileId}_${cartList.fileName}">
   </div>
   <div class="gdsInfo">
    <p>
     <span>상품명 : </span>${cartList.gdsName}<br />
     <span>개당 가격 : </span><fmt:formatNumber pattern="###,###,###" value="${cartList.gdsPrice}" /><br />
     <span>구입 수량 : </span>${cartList.cartStock}<br />
     <span>최종 가격 : </span><fmt:formatNumber pattern="###,###,###" value="${cartList.gdsPrice * cartList.cartStock}" />
    </p> 
    
    <div>
    	<button type="button" class="delete_${cartList.cartNo }" >삭제</button>
    	<script>
			$(".delete_${cartList.cartNo}").click(function(){
				var confirm_val = confirm("삭제하시겠습니까?");
				if(confirm_val){
				var checkArr = new Array();
				checkArr.push($(this).attr("data-cartNo"));
				var datas = {
					cartNo : '${cartList.cartNo}',
					mberId : '${member.mberId}'
				}
				$.ajax({
					url : "/goods/deleteCart",
					type: "post",
					data : datas,
					success : function(data){
						if(data.result == 'success'){
							alert("삭제 완료");
							location.reload();
						} else {
							alert("삭제 실패");
						}
					}
				});
			}
			})
	</script>
    </div>
       
   </div>   
  </li>
  
  <c:set var="sum" value="${sum+(cartList.gdsPrice * cartList.cartStock) }"></c:set>
  
  </c:forEach>
 </ul>
 
 	<div class="listResult">
 		<div class="sum">
 			총 합계 : <fmt:formatNumber pattern="###,###,###" value="${sum }"/>원
 		</div>
 		<div class="order">
 			<button type="button" class="order_Btn">주문 정보 입력</button>
 		</div>
 	</div>
 	
 	<div class="orderInfo">
 		<form id="order" method="post" action="/goods/order">
 			<input type="hidden" name="amount" value="${sum }"/>
 			<div>
 				<label>수령인</label><input type="text" name="orderRec" id="orderRec" required="required" value="${member.name }">
 			</div>
 			<div>
 				<label>연락처</label><input type="text" name="orderPhone" id="orderPhone" required="required" value="${member.phone }">
 			</div>
 			<div>
 				<label>주소</label><input type="text" name="addr1" id="addr1" required="required" value="${member.addr1 }">
 			</div>
 			<div>
 				<label>상세주소</label><input type="text" name="detailAddr" id="detailAddr" required="required" value="${member.detailAddr }">
 			</div>
 			<div>
 				<label>충전금액</label><fmt:formatNumber pattern="###,###,###" value="${member.point }"/>
 			</div>
 			<div>
 				<button type="submit" class="btn btn-primary">주문</button>
 				<button type="button" class="btn btn-danger cancel">취소</button>
 			</div>
 		</form>
 	</div>
 	
</section>
<script>
	$(".order_Btn").click(function(){
		var sum = '${sum}';
		if(sum != 0){
		
			$(".orderInfo").slideDown();
			$(".order_Btn").slideUp();
		} else {
			return false;
		}
		
	})
	$(".cancel").click(function(){
		$(".orderInfo").slideUp();
		$(".order_Btn").slideDown();
	});
	
	var result = '${result}';
	if(result == 'success'){
		alert("주문완료");
		location.href="/";
	} else if(result == 'fail'){
		alert('금액이 부족합니다.');
		var cv = confirm("충전하시겠습니까?");
		if(cv){
			location.href="/member/myPage";
		} else {
			location.href="/goods/cartList";
		}
	}
</script>
