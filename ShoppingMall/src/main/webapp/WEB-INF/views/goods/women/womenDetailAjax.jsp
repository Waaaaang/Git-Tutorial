<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<h1>상품 상세보기</h1>
<form method="post" id="form">
<input type="hidden" id="gdsNo" value="${goods.gdsNo }"/>
<div>
	<label>상품명 : </label><c:out value="${goods.gdsName }"></c:out>
</div>
<!-- 점수 -->
			<div>
			<label>평점</label><br>
			<c:set var="score" value="${score}"/>
			
      		<c:if test = "${fn:contains(score, '1')}">
        	<img src="/resources//mainImg/score/1star.png">
      		</c:if>
      		<c:if test = "${fn:contains(score, '2')}">
        	<img src="/resources/mainImg/score/2star.png">
      		</c:if>
      		<c:if test = "${fn:contains(score, '3')}">
        	<img src="/resources/mainImg/score/3star.png">
      		</c:if>
      		<c:if test = "${fn:contains(score, '4')}">
        	<img src="/resources/mainImg/score/4star.png">
      		</c:if>
      		<c:if test = "${fn:contains(score, '5')}">
        	<img src="/resources/mainImg/score/5star.png">
      		</c:if>
			</div>
<div class="uploadResult">
	<img src="/display?fileName=${goods.uploadPath}/thumb_${goods.fileId}_${goods.fileName}">
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
