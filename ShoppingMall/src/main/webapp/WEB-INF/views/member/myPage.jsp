<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp"%>


	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="col-sm-2"></div>
				<div class="col-sm-9">
					<h2 class="text-center">마이페이지</h2>
					<table class="table table-striped">
						<tr>
							<td>이름</td>
							<td>${member.name }</td>
						</tr>
						<tr>
							<td>아이디</td>
							<td>${member.mberId }</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>${member.email }</td>
						</tr>
						<tr>
							<td>핸드폰</td>
							<td>${member.phone }</td>
						</tr>
						<tr>
							<td>주소</td>
							<td>${member.addr1 }</td>
						</tr>
						<tr>
							<td>상세주소</td>
							<td>${member.detailAddr }</td>
						</tr>
						<tr>
							<td class="text-center" colspan="2">
								<button class="btn btn-success" onclick="order();">주문확인</button>
								<button class="btn btn-primary" onclick="check();">회원정보수정</button>
								<button class="btn btn-warning" onclick="main();">메인화면</button>
								<button class="btn btn-danger" onclick="myPageRemove();">회원탈퇴</button>
							</td>
						</tr>
					</table>
					<div class="text-center" id="pwCheck" style="display: none">
						<p>비밀번호를 입력하세요</p><br>
						<input type="password" id="pw" >
						<button type="button" onclick="pwCheck();">확인</button>
					</div>
					<div class="text-center" id="myPageModify" style="display: none">
						<form>
							<div>
								<label>이름</label><p><c:out value="${member.name }"/></p>
							</div>
							<div>
								<label>아이디</label><p><c:out value="${member.mberId }"/></p>
							</div>
							<div>
								<label>이메일</label><p><c:out value="${member.email }"/></p>
							</div>
							<div>
								<label>비밀번호</label><input type="password" id="password"  >
							</div>
							<div>
								<label>핸드폰</label><input id="phone" value='<c:out value="${member.phone }"/>'>
							</div>
							<div>
								<label>주소</label><input id="addr1" value='<c:out value="${member.addr1 }"/>'>
							</div>
							<div>
								<label>상세주소</label><input id="detailAddr" value='<c:out value="${member.detailAddr }"/>'>
							</div>
							<button type="button" onclick="myPageModify()">수정하기</button>
							<button type="button" onclick="esc();">취소</button>
						</form>
					</div>
					<div class="text-center" id="orderList">
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
	//주문리스트
	function order(){
		$.ajax({
			type : "post",
			url : "/goods/orderList",
			success : function(data){
				var result = $("#orderList").html(data).find("section");
				$("#orderList").empty();
				$("#orderList").slideDown();
				$("#pwCheck").slideUp();
				$("#myPageModify").slideUp();
				$("#orderList").html(result);
				
			},
			error : function(error){
				alert("오류 발생 : "+error);
			}
		});
	}

	//회원정보 수정
	function myPageModify(){
		var data ={
				mberId : '${member.mberId }',
				password : $("#password").val(),
				phone : $("#phone").val(),
				addr1 : $("#addr1").val(),
				detailAddr : $("#detailAddr").val()
		}
		var passRegExp = /^[a-zA-Z0-9]{4,12}$/;
		if(!passRegExp.test(data.password)){
			alert("비밀번호는 영문 대소문자와 숫자포함 4~12 자리로 입력해야합니다.");
			$("#password").focus();
			return false;
		}
		$.ajax({
			type : "POST",
			url : "/member/myPageModify",
			data : data,
			success : function(result){
				if(result == "success"){
					alert("회원정보수정완료");
					location.reload();
				} else {
					alert("회원정보수정실패");
				}
			}
		});
	};

	//비밀번호 확인
	function pwCheck(){
		var pw = $("#pw").val();
		var password = '${member.password}';
		if(password == pw){
				$("#pwCheck").slideUp();
				$("#myPageModify").slideDown(1000);
		} else{
			alert("비밀번호를 확인하세요");
		};
	};
	
	function esc(){
		$("#myPageModify").slideUp();
		$("#orderList").slideUp();
	}

	function check(){
		$("#orderList").slideUp();
		$("#pwCheck").slideDown();
	};
	
	//메인페이지 이동
	function main(){
		location.href="/";
	};
	
	//회원탈퇴
	function myPageRemove(){
		if(confirm("정말 탈퇴하시겠습니까?")){
			var datas = {
					mberId : '${member.mberId }'
			}
			$.ajax({
				type : "POST",
				url : "/member/myPageRemove",
				data : datas,
				success : function(data){
					if(data.result == "success"){
						alert("회원탈퇴성공!! 이용해주셔서 감사합니다.");
						location.href="/";
					} else {
						alert("회원탈퇴실패");
					}
				}
			});
		}
				
	};

	
</script>