<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="container">

	<div class="grid-container">
		<c:forEach var="goods" items="${list }" varStatus="i">
			<div class="grid-item">
			<table>
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
</div>
