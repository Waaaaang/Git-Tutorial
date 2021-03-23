<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<h1>상품 상세보기</h1>
<form method="post" id="form">
<input type="hidden" id="gdsNo" value="${goods.gdsNo }"/>
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
<button type="button" id="addCart">장바구니담기</button>
</c:if>
<button type="button" id="goList">목록보기</button>

</form>
