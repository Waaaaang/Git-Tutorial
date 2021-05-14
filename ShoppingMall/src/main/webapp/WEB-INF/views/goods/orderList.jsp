<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<style>
 	section#content ul li { border:5px solid #eee; padding:10px 20px; margin-bottom:20px; list-style: none;}
 	section#content .orderList span { font-size:20px; font-weight:bold; display:inline-block; width:120px; margin-right:10px; }
</style>
<section id="content">
 <ul class="orderList">
 	<div style="text-align: left; margin-bottom : 10px; font-size:20px; font-weight:bold;">총 ${total }건</div>
  <c:forEach items="${orderList}" var="orderList">
  	<li>
  	<div>
   		<p><span>주문번호</span><a class="move_${orderList.orderId }" href="/goods/orderView?orderId=${orderList.orderId}">${orderList.orderId}</a></p>
   		<script>
			$(".move_${orderList.orderId }").click(function(e){
				e.preventDefault();
				var actionForm = $("#actionForm");		
				actionForm.append("<input type='hidden' name='orderId' value='${orderList.orderId}'>");
				actionForm.append("<input type='hidden' name='mberId' value='${orderList.mberId}'>");
				actionForm.attr("action","/goods/orderView");
				actionForm.attr("method","post");
				actionForm.submit();
			});
		</script>
   		<p><span>수령인</span>${orderList.orderRec}</p>
   		<p><span>주소</span>${orderList.addr1} ${orderList.detailAddr} </p>
   		<p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${orderList.amount}" /> 원</p>
   		<p><span>상태</span>
   			<span style="color:
	     	<c:choose>
	     		<c:when test='${orderList.delivery eq "배송준비"}'>
	     			red
	     		</c:when>
	     		<c:when test='${orderList.delivery eq "배송 중"}'>
	     			blue
	     		</c:when>
	     		 <c:when test='${orderList.delivery eq "배송 완료"}'>
	     			gray
	     		</c:when>
	     		 <c:when test='${orderList.delivery eq "주문취소요청"}'>
	     			green
	     		</c:when>
	     		 <c:when test='${orderList.delivery eq "주문취소"}'>
	     			yellow
	     		</c:when>
	     	</c:choose>
     		">
	     	${orderList.delivery}		
	     </span>
   		</p>   
   		
  </div>
  </li>
  </c:forEach>
 </ul>
 <form id="actionForm" method="post">
 </form>

</section>
	<div class="pull-right">
					<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							<li class="paginate_button previous"><a href="${pageMaker.startPage -1 }">이전</a></li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}"><a href="${num }">${num }</a></li>
						</c:forEach>
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next"><a href="${pageMaker.endPage +1 }">다음</a></li>
						</c:if>
					</ul>
	</div>
<script>
$(".paginate_button a").on("click",function(e){
	var amount = 5;
	var actionForm = $("#actionForm");		
	e.preventDefault();
	actionForm.append("<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>");
	actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	actionForm.append("<input type='hidden' name='amount' value="+amount+">");
	actionForm.attr("method","post");
	actionForm.submit();
});

</script>