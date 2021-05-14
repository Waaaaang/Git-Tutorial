<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>

<style>
/* 메인 슬라이드 Slideshow container */

/* Slideshow container */
* {
	box-sizing: border-box;

}

body {
	font-family: Verdana, sans-serif;
	overflow-x: hidden;
}

/* Slideshow container */
.slideshow-container {
	width: 100%;
	height: 50%;
}

.main_slideImg {
	width: 750px;
	object-fit: cover;
	margin: 0 auto;
	display: block;
}

/* Next & previous buttons */
.prev, .next {
	cursor: pointer;
	position: absolute;
	text-align: center;
	top: 0;
	top: 20%;
	width: 3%;
	padding: 16px;
	margin-top: -22px;
	color: white;
	font-weight: bold;
	font-size: 18px;
	transition: 0.6s ease;
	border-radius: 0 3px 3px 0;
	z-index: 100;
}

/* Position the "next button" to the right */
.next {
	right: 0;
	border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

/* Caption text */
.text {
	color: #f2f2f2;
	font-size: 50px;
	padding: 8px 12px;
	position: absolute;
	bottom: 50%;
	width: 100%;
	text-align: center;
	text-shadow: 1px 1px 2px black, 0 0 1em black, 0 0 0.2em white;
}

/* Number text (1/3 etc) */
.numbertext {
	color: #f2f2f2;
	font-size: 12px;
	padding: 8px 12px;
	position: absolute;
	top: 0;
}

/* The dots/bullets/indicators */
.dot {
	cursor: pointer;
	height: 13px;
	width: 13px;
	margin: 0 2px;
	background-color: #bbb;
	border-radius: 50%;
	display: inline-block;
	transition: background-color 0.6s ease;
}

.active, .dot:hover {
	background-color: #717171;
}

/* Fading animation */
.fade2 {
	-webkit-animation-name: fade;
	-webkit-animation-duration: 0.5s;
	animation-name: fade;
	animation-duration: 5s;
}

@
-webkit-keyframes fade2 {
	from {opacity: .4
}

to {
	opacity: 1
}

}
@
keyframes fade2 {
	from {opacity: .4
}

to {
	opacity: 1
}

}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
	.slprev, .slnext, .text {
		font-size: 11px
	}
}
</style>
<!-- 메인 슬라이드 -->

<div class="slideshow-container">

	<div class="mySlides fade2">

		<img class="main_slideImg" src="/resources/mainImg/1.jpg">

		<div class="text">VTEX SHOP</div>

	</div>

	<div class="mySlides fade2">

		<img class="main_slideImg" src="/resources/mainImg/2.jpg">

		<div class="text">VTEX SHOP</div>

	</div>

	<div class="mySlides fade2">

		<img class="main_slideImg" src="/resources/mainImg/3.jpg">

		<div class="text">VTEX SHOP</div>

	</div>
	<div class="mySlides fade2">

		<img class="main_slideImg" src="/resources/mainImg/4.jpg">

		<div class="text">VTEX SHOP</div>

	</div>
	<div class="mySlides fade2">

		<img class="main_slideImg" src="/resources/mainImg/5.jpg">

		<div class="text">VTEX SHOP</div>

	</div>

</div>

<br>

<div style="text-align: center">

	<span class="dot" onclick="currentSlide(1)"></span> <span class="dot"
		onclick="currentSlide(2)"></span> <span class="dot"
		onclick="currentSlide(3)"></span> <span class="dot"
		onclick="currentSlide(4)"></span> <span class="dot"
		onclick="currentSlide(5)"></span>
</div>

<!-- 메인 슬라이드 End -->
<script>
	//슬라이드 스크립

	var slideIndex = 0;
	showSlides();

	function showSlides() {

		var i;
		var slides = document.getElementsByClassName("mySlides");
		var dots = document.getElementsByClassName("dot");

		for (i = 0; i < slides.length; i++) {
			slides[i].style.display = "none";
		}

		slideIndex++;
		if (slideIndex > slides.length) {
			slideIndex = 1
		}

		for (i = 0; i < dots.length; i++) {
			dots[i].className = dots[i].className.replace(" active", "");
		}

		slides[slideIndex - 1].style.display = "block";
		dots[slideIndex - 1].className += " active";
		setTimeout(showSlides, 2000);
	}
</script>

<%@ include file="../includes/footer.jsp"%>