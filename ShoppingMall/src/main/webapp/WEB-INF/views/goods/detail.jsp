<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<h1>상품 상세보기</h1>
<form method="post" id="form">
<div>
	<label>상품명 : </label><c:out value="${goods.gdsName }"></c:out>
</div>
<div>
	<img src="/resources/mainImg/${goods.gdsImg }" width="300px" height="300px" />
</div>
<div>
	<label>가격 :</label><c:out value="${goods.gdsPrice }"></c:out>
</div>
<div>
	<label>상품내용</label><br>
	<c:out value="${goods.gdsDes }"></c:out>
</div>
<br>
<c:if test="${!empty member.mberId }">
<button type="button" onclick="addCart();">장바구니담기</button>
</c:if>
<button type="button" onclick="goList();">목록보기</button>
<c:if test="${member.auth eq 'admin' }">
<button type="button" onclick="modify();">수정하기</button>
</c:if>
</form>

<script>

	function addCart(){
		var datas = {
			gdsNo :	'${goods.gdsNo}',
			mberId : '${member.mberId}',
			cartStock : 1
		}
		$.ajax({
			type : "post",
			url : "/goods/addCart",
			data : datas,
			success : function(){
				alert("장바구니 담기 완료");
				var confirm_val = confirm("장바구니 보기?");
				if(confirm_val){
					location.href="/goods/cartList";
				}
			},
			error : function(){
				alert("장바구니 담기 실패");
			}
		});
	};

	function goList(){
		location.href="/goods/goods";
	};

	function modify(){
		var form = $("#form");
		form.append("<input type='hidden' name='gdsNo' value='${goods.gdsNo}'/>");
		form.attr("action","/goods/modify");
		form.submit();
	};
</script>