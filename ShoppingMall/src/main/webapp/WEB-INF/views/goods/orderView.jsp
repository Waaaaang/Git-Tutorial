<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<style>

 .orderInfo { border:5px solid #eee; padding:10px 20px; margin:20px 0;}
 .orderInfo span { font-size:20px; font-weight:bold; display:inline-block; width:90px; }
 
 .orderView li { margin-bottom:20px; padding-bottom:20px; border-bottom:1px solid #999; list-style: none;}
 .orderView li::after { content:""; display:block; clear:both; }
 
 .thum { float:left; width:200px; }
 .thum img { width:200px; height:200px; }
 .gdsInfo { float:right; width:calc(100% - 220px); line-height:2; }
 .gdsInfo span { font-size:20px; font-weight:bold; display:inline-block; width:100px; margin-right:10px; }
 .deli { text-align:right; }
 .delivery_ing, .delivery_commit { font-size:16px; background:#fff; border:1px solid #999; margin-left:10px; }
</style>

<section id="content">

 <div class="orderInfo">
  <c:forEach items="${orderView}" var="orderView" varStatus="status">
   
   <c:if test="${status.first}">
     <p><span>주문자</span>${orderView.mberId }</p>
     <p><span>수령인</span>${orderView.orderRec}</p>
   	 <p><span>주소</span>${orderView.addr1} ${orderView.detailAddr}</p>
     <p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.amount}" /> 원</p>
     <p><span>상태</span>${orderView.delivery}</p>
     
   	 <c:if test="${member.auth eq 'admin'}">
     	<div class="deli">
   				<button type="button" class="delivery_ing">배송 중</button>
   				<button type="button" class="delivery_commit">배송 완료</button>			
    	 </div>
    	 <script>
    	 $(document).ready(function(){
    		 var delivery = '${orderView.delivery}';
    		 if('배송 중' == delivery){
    			 $(".delivery_ing").css("display","none");
    		 } else if('배송 완료' == delivery){
    			 $(".delivery_ing").css("display","none");
    			 $(".delivery_commit").css("display","none");
    		 }
    		 
    		 $(".delivery_ing").click(function(){
					 var datas = {
						 orderId : '${orderView.orderId }',
						 delivery : '배송 중'
					 }
	 				$.ajax({
						type : "post",
						url : "/goods/delivery",
						data : datas,
						success : function(data){
							if(data.result == "success"){
								location.reload();
							} else {
								alert("배송 실패");
							}
						}
				 	});
				});
    		 
    			$(".delivery_commit").click(function(){
 				    var datas = {
 	  					 orderId : '${orderView.orderId }',
 	  					 delivery : '배송 완료'
 	  				 }
 	  	 			$.ajax({
 	  					type : "post",
 	  					url : "/goods/delivery",
 	  					data : datas,
 	  					success : function(data){
 	  						if(data.result == "success"){
 	  							location.reload();
 	  						} else {
 	  							alert("배송 실패");
 	  						}
 	  					}
 	  				 });
 				});
    	 	});		
		</script>
	 </c:if>    
   </c:if>
   
  </c:forEach>
 </div>
 
 <ul class="orderView">
  <c:forEach items="${orderView}" var="orderView">     
  <li>
   <div class="thum">
    <img src="/resources/mainImg/${orderView.gdsImg}" />
   </div>
   <div class="gdsInfo">
    <p>
     <span>상품명</span>${orderView.gdsName}<br />
     <span>개당 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.gdsPrice}" /> 원<br />
     <span>구입 수량</span>${orderView.cartStock} 개<br />
     <span>최종 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.gdsPrice * orderView.cartStock}" /> 원                  
    </p>
   </div>
  </li>     
  </c:forEach>
 </ul>
</section>


