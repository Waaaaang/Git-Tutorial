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
<title>ShoppingMall</title>
</head>
<style>
 li { position:relative; }
 li:hover { background:#eee; }   
 li > ul.low { display:none; position:absolute;  background-color: #f9f9f9; min-width: 160px;box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 1; }
 li:hover > ul.low { display:block; }
 li:hover > ul.low li a { background:#eee; border:1px solid #eee;  text-decoration: none; }
 li:hover > ul.low li a:hover { background:#fff;}
 li > ul.low li { width:180px; }
</style>
<body>

<header>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="/">ShoppingMall</a>
			</div>
			<ul class="nav navbar-nav navbar-left">		
				<li><a href="/goods/goods">전체상품</a></li>
				<li><a href="/goods/men/menList?cateCode=100">Men</a>
					<ul class="low">
						<li><a href="/goods/men/menList?cateCode=101">상의</a></li>
						<li><a href="/goods/men/menList?cateCode=102">하의</a></li>
						<li><a href="/goods/men/menList?cateCode=103">신발</a></li>
					</ul>
				</li>
				<li><a href="/goods/women/womenList?cateCode=200">Women</a>
					<ul class="low">
						<li><a href="/goods/women/womenList?cateCode=201">상의</a></li>
						<li><a href="/goods/women/womenList?cateCode=202">하의</a></li>
						<li><a href="/goods/women/womenList?cateCode=203">신발</a></li>
					</ul>
				</li>
				<li><a href="/goods/kids/kidsList?cateCode=300">Kids</a>
					<ul class="low">
						<li><a href="/goods/kids/kidsList?cateCode=301">상의</a></li>
						<li><a href="/goods/kids/kidsList?cateCode=302">하의</a></li>
						<li><a href="/goods/kids/kidsList?cateCode=303">신발</a></li>
					</ul>
				</li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<c:choose>
				<c:when test="${empty sessionScope.member.mberId }">
				<li><a href="/member/login"><span class="glyphicon glyphicon-log-in"></span>로그인</a></li>
				</c:when>
				<c:when test="${(!empty sessionScope.member.mberId) && member.auth eq 'admin'}">
				<li><a href="/goods/register">상품등록</a>
				<li><a href="/goods/orderList">주문확인</a>
				<li><a href="/member/logout"><span class="glyphicon glyphicon-log-out"></span>로그아웃</a></li>
				</c:when>
				<c:when test="${(!empty sessionScope.member.mberId) && member.auth eq 'user'}">
					<li><a href="/goods/cartList">장바구니</a></li>
					<li><a href="/member/myPage">마이페이지</a></li>
					<li><a href="/member/logout"><span class="glyphicon glyphicon-log-out"></span>로그아웃</a></li>
				</c:when>
				</c:choose>
			</ul>
		</div>
	</nav>
</header>