<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<title>VTEX SHOP</title>
</head>
<style>
body {
 background-color: #fafafa;
 margin: 10px;
}
.grid-item {
	background-color: rgba(255, 255, 255, 0.8);
	border: 1px solid;
	border-color: #d3d3d3;
	padding: 20px;
	font-size: 30px;
	text-align: center;
}
.grid-container {
	display: grid;
	grid-template-columns: auto auto auto;
/* 	background-color: #2196F3; */
	padding: 10px;
}
nav li { position:relative; }
nav li:hover { background:#eee; }   
nav li > ul.low { display:none; position:absolute;  background-color: #f9f9f9; min-width: 160px;box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 1; }
nav li:hover > ul.low { display:block; }
nav li:hover > ul.low li a { background:#eee; border:1px solid #eee;  text-decoration: none; }
nav li:hover > ul.low li a:hover { background:#fff;}
nav li > ul.low li { width:180px; }
</style>
<body>

<header>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="/">VTEX SHOP</a>
			</div>
			<ul class="nav navbar-nav navbar-left">		
				<li>
					<a href="/goods/goods">전체상품</a>
				</li>
			<c:forEach var="item" items="${cmmnCodeList}" varStatus="i">
				<li>
					<a href="/goods/men/menList?cateCode=${item.code_Id}">${item.code_Nm}</a>
					<ul class="low">
						<c:forEach var="item2" items="${cmmnDetailCodeList}" varStatus="j">
							<c:if test="${item.code_Id eq item2.code_Id}">
								<li>
									<a href="/goods/men/menList?cateCode=${item2.det_Code_Id }">${item2.det_Code_Nm }</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
			</c:forEach>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<c:choose>
				<c:when test="${empty sessionScope.member.mberId }">
				<li><a href="/member/login"><span class="glyphicon glyphicon-log-in" style="margin-right: 5px;"></span>로그인</a></li>
				</c:when>
				<c:when test="${(!empty sessionScope.member.mberId) && member.auth eq 'admin'}">
				<li><a href="/common/codePage">코드관리</a>
				<li><a href="/goods/register">상품등록</a>
				<li><a href="/goods/orderList">주문확인</a>
				<li><a href="/member/logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 5px;"></span>로그아웃</a></li>
				</c:when>
				<c:when test="${(!empty sessionScope.member.mberId) && member.auth eq 'user'}">
					<li><a href="/goods/cartList">장바구니</a></li>
					<li><a href="/member/myPage">마이페이지</a></li>
					<li><a href="/member/logout"><span class="glyphicon glyphicon-log-out" style="margin-right: 5px;"></span>로그아웃</a></li>
				</c:when>
				</c:choose>
			</ul>
		</div>
	</nav>
</header>