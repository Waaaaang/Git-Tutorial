<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div>
		<h3>비밀번호 찾기</h3>
			<form id="findForm" name="findForm" method="post">
				<label>아이디 :</label>
				<input type="text" name="mberId" id="mberId"><br>
				<label>이메일 :</label>
				<input type="text" name="email" id="email"  placeholder="이메일주소를 입력하세요" required><br>
				<button type="button" onclick="findPw();">비밀번호찾기</button>
				<button type="button" onclick="history.go(-1)">취소</button>
			</form>
	</div>

<form id="updatePwForm" onsubmit="return beforeValid();" name="updatePwForm" method="post" style="display: none">
	<div id="pwChange">
		<label>새 비밀번호 : </label><input type="password" id="password" name="password"/><br>
		<label>새 비밀번호 확인 :</label><input type="password" id="pw_Check" name="pw_Check"/><br>
	</div>
	<button type="submit">비밀번호 변경</button>
</form>
</body>

<script>
	function updatePw(){
		
		var datas = {
				mberId : $("#mberId").val(),
				password : $("#password").val()
		}
		$.ajax({
			type : "POST",
			url : "/member/updatePw",
			data : datas,
			success : function(data){
				if(data.result == "success"){
					alert("비밀번호변경성공!! 변경된 비밀번호로 로그인하세요");
					location.href="/member/login";
				} else {
					alert("비밀번호변경 실패");
				}
			}
		});
	}

	function findPw(){
		var datas  = {
				mberId : $("#mberId").val(),
				email : $("#email").val()
		}
		$.ajax({
			type : "POST",
			url : "/member/findPwInsert",
			data : datas,
			success : function(data){
				if(data.result == "success"){
					alert("현재 비밀번호는 "+data.password+" 입니다. 비밀번호를 변경하세요.");
					$("#updatePwForm").slideDown();
				} else {
					alert("회원정보가 올바르지 않습니다.");
				}
			}
		});
	}

	var passRegExp = /^[a-zA-Z0-9]{4,12}$/;
	function beforeValid(){
		
		if($('#password').val() == '' || $('#password').val() == null){
			alert('비밀번호를 입력하세요');
			return false;
		}
		
		if(!passRegExp.test($('#password').val())){
			alert("비밀번호는 영문 대소문자와 숫자포함 4~12 자리로 입력해야합니다.");
			return false;
		}
		
		
		if($('#pw_Check').val() == '' || $('#pw_Check').val() == null){
			alert('비밀번호 확인을 입력하세요');
			return false;
		}
		
		if($('#password').val() != $('#pw_Check').val()) {
			alert('비밀번호가 같지 않습니다');
			return false;
		}
		updatePw();
	}
	
</script>
</html>