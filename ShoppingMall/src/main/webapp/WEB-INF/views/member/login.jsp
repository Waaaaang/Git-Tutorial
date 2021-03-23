<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
.regBtn:hover {
	color: white;
	background-color: skyblue;
}
</style>
<body>
	<form id="moveForm" onsubmit="return beforeValid();" name="moveForm" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" id="mberId" name="mberId" /></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" id="password" name="password" /></td>
			</tr>
		</table>
		<span style="padding-left: 70px"> 
			<a href="/member/findId">아이디찾기</a>
			<a href="/member/findPw">비밀번호찾기</a>
		</span><br><br>
		<div style="margin-left: 70px;">
		<button type="submit">로그인</button>
		<button type="button" class="regBtn" onclick="register();">회원가입</button>
		</div>
	</form>
</body>
<script>
	function loginInsert(){
		
		var datas = {
			mberId : $("#mberId").val(),
			password : $("#password").val()
		}
		$.ajax({
			type : "POST",
			url : "/member/loginInsert",
			data : datas,
			success : function(data){
				if(data.result == "success"){
					alert(data.mberId+"님 반갑습니다");
					location.href="/";
				} else {
					alert("아이디 또는 비밀번호가 틀렸습니다.");
				}
			}
		});
	}

function beforeValid(){
		
		if($('#mberId').val() == '' || $('#mberId').val() == null){
			alert('아이디를 입력하세요');
			return false;
		}
		
		if($('#password').val() == '' || $('#password').val() == null){
			alert('비밀번호를 입력하세요');
			return false;
		}

		loginInsert();
	}
	

	function register() {
		location.href = "/member/register";
	}
</script>

</head>
</html>