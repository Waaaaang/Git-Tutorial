<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.grid-container {
	display: grid;
	grid-template-columns: auto auto auto;
	background-color: #2196F3;
	padding: 10px;
}

.grid-item {
	background-color: rgba(255, 255, 255, 0.8);
	border: 1px solid rgba(0, 0, 0, 0.8);
	padding: 20px;
	font-size: 30px;
	text-align: center;
}
</style>
<div class="container">

    		   <div>
						<form id="searchForm" action="/goods/goods" method="post">
							<select name="type">
								<option value=""
								 	<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
								<option value="T" 
									<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>상품명</option>
								<option value="C"
									<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
								<option value="W" 
									<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>가격</option>
							</select>
							<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>' />
							<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>' />
							<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>' />
							<button class="btn btn-default">검색</button>
						</form>
				</div>
	
	<div class="grid-container">
		<c:forEach var="goods" items="${list }" varStatus="i">
			<div class="grid-item">
			<table>
				<tr>
					<td>
					<a class="move" href='<c:out value="${goods.gdsNo }"/>'>
					<img src="/resources/mainImg/${goods.gdsImg }" width="100%" height="auto" />
					</a>
					</td>
				</tr>
				<tr>
					<td><c:out value="${goods.gdsName }"></c:out></td>
				</tr>
				<tr>
					<td><c:out value="${goods.gdsPrice }"></c:out></td>
				</tr>
			</table>
			</div>
		</c:forEach>
	</div>
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
	
	<form id="actionForm" method="post" >
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
		<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
	</form>
</div>
