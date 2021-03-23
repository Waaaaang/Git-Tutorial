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

</div>
