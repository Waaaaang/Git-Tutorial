<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<title></title>
</head>
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

.uploadResult ul li {
	list-style: none;
}
</style>
<body>
<div class="row">
	<div class="col-lg-12">
		<h2 class="page-header">공통코드목록</h2>
	</div>
</div>
<div class="panel panel-default">
			<div class="panel-heading">공통코드목록	
			</div>
    		   		<div class="pull-right">
						<form id="searchForm" action="/common/cmmnList" method="post">
							<select name="type">
								<option value="TWC"
								 	<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>전체</option>
								<option value="T" 
									<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>코드ID</option>
								<option value="C"
									<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>코드명</option>
								<option value="W" 
									<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>코드설명</option>
							</select>
							<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>' />
							<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>' />
							<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>' />
							<button class="btn btn-default">검색</button>
						</form>
					</div>
	
	<div class="panel-body">
		<table class="table eable-striped table-bordered table-hover">
			<thead>
				<tr>
					<th style="width: 10%">코드ID</th>
					<th style="width: 20%">코드명</th>
					<th style="width: 30%">코드설명</th>
					<th style="width: 10%">사용여부</th>
					<th style="width: 10%">등록일</th>
				</tr>
			</thead>
			<c:forEach var="cmmn" items="${list }" varStatus="i">
				<tr class="move" href='<c:out value="${cmmn.code_Id }"/>' style="cursor: pointer;">
					<td><c:out value="${cmmn.code_Id }"/></td>
					<td><c:out value="${cmmn.code_Nm }"></c:out></td>
					<td><c:out value="${cmmn.code_Dc}"></c:out></td>
					<td><c:out value="${cmmn.use_At}"></c:out></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${cmmn.firstRegDate }"/></td>
				</tr>
			</c:forEach>
		</table>
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
</div>
</body>
</html>
<script>
$(document).ready(function(){
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click",function(e){
		e.preventDefault();
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click",function(e){
		e.preventDefault();
		var datas = $(this).attr("href");
		parent.test(datas);			//부모 페이지와 통신
	
	});
		
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click",function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색 종류를 선택하세요.");
			return false;
		}		
		
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요.");
			return false;
		}			
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
	});
	
	
});
</script>
