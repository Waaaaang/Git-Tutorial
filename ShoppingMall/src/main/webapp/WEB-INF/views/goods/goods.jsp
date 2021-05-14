<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<style>

.uploadResult ul li {
	list-style: none;
}
</style>

<div class="container">

    		   <div>
						<form id="searchForm" action="/goods/goods" method="post">
							<select name="type">
								<option value="TWC"
								 	<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>전체</option>
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
			<table class="t">
				<tr>
					<td>
					<a class="move" href='<c:out value="${goods.gdsNo }"/>'>
					<div class="uploadResult">
					<img src="/display?fileName=${goods.uploadPath}/thumb_${goods.fileId}_${goods.fileName}">
					</div>
					</a>
					</td>
				</tr>
				<tr>
					<td><c:out value="${goods.gdsName }"></c:out></td>
				</tr>
				<tr>
					<td><fmt:formatNumber pattern="###,###,###" value="${goods.gdsPrice }"></fmt:formatNumber>원</td>
				</tr>
				<tr>
					<td>[<c:out value="${goods.goodsReplyCnt }"/>]
						<c:if test="${goods.avgScore==0 }">
							<img src="/resources//mainImg/score/0star.png">
						</c:if>
						<c:if test="${goods.avgScore==1 }">
							<img src="/resources//mainImg/score/1star.png">
						</c:if>
						<c:if test="${goods.avgScore==2 }">
							<img src="/resources//mainImg/score/2star.png">
						</c:if>
						<c:if test="${goods.avgScore==3 }">
							<img src="/resources//mainImg/score/3star.png">
						</c:if>
						<c:if test="${goods.avgScore==4 }">
							<img src="/resources//mainImg/score/4star.png">
						</c:if>
						<c:if test="${goods.avgScore==5 }">
							<img src="/resources//mainImg/score/5star.png">
						</c:if>
					</td>
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

<script>
var actionForm = $("#actionForm");
$(".move").on("click",function(e){
	e.preventDefault();
	actionForm.append("<input type='hidden' name='gdsNo' value='"+$(this).attr("href")+"'>");
	actionForm.attr("action","/goods/detail");
	actionForm.attr("method","post");
	actionForm.submit();
});

$(".paginate_button a").on("click",function(e){
	e.preventDefault();
	actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	actionForm.attr("method","post");
	actionForm.submit();
});

var searchForm = $("#searchForm");
$("#searchForm button").on("click",function(e){
	if(!searchForm.find("input[name='keyword']").val()){
		alert("키워드를 입력하세요.");
		return false;
	}			
	
	searchForm.find("input[name='pageNum']").val("1");
	e.preventDefault();
	searchForm.submit();
});


</script>

<%@ include file="../includes/footer.jsp"%>