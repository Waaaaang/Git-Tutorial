<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	
	var emailCheck = false;
	var mberIdCheck = false;
	var idRegExp = /^[a-zA-Z0-9]{4,12}$/;
	var nameRegExp = /^[가-힣]{2,4}$/;
	var passRegExp = /^[a-zA-Z0-9]{4,12}$/;
	var emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;

	
	function memberInsert(){
		var datas = {
				mberId : $("#mberId").val(),
				password : $("#password").val(),
				name : $("#name").val(),
				phone : $("#phone").val(),
				email : $("#email").val(),
				addr1 : $("#addr1").val(),
				detailAddr : $("#detailAddr").val(),
				auth : $("#auth").val()
		}
		$.ajax({
			type : "POST",
			url : "/member/insert",
			data : datas,
			success : function(data){
				if(data.result == "success"){
					alert("회원가입성공!! 로그인하세요");
					location.href="/member/login";
				} else {
					alert("회원가입실패");
				}
			}
		});
	}
	
	function beforeValid(){
			
		if($('#name').val() == '' || $('#name').val() == null){
			alert('이름을 입력하세요');
			return false;
		}
		
		if(!nameRegExp.test($('#name').val())){
			alert("이름이 올바르지 않습니다.");
			return false;
		}	
		
		if($('#mberId').val() == '' || $('#mberId').val() == null){
			alert('아이디를 입력하세요');
			return false;
		}
		
		if(!idRegExp.test($('#mberId').val())){
			alert("아이디는 영문 대소문자와 숫자를 포함 4~12자리로 입력해야합니다.");
			return false;
		}
		
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
		
		if($('#phone').val() == '' || $('#phone').val() == null) {
			alert('핸드폰을 입력하세요');
			return false;
		}
		
		if($('#email').val() == '' || $('#email').val() == null) {
			alert('이메일을 입력하세요');
			return false;
		}
		
		if(!emailRegExp.test($('#email').val())){
			alert('이메일 형식이 올바르지 않습니다.');
			return false;
		}
		
		if(mberIdCheck == false){
			alert("중복검사를 하세요")
			return false;
		}
		
		if(emailCheck == false){
			alert("중복된 이메일입니다.")
			return false;
		}
		memberInsert();
	}
	
	function checkId(){
		var mberId = $('#mberId').val();
		var data = {
				mberId : mberId
				}
		
		$.ajax({
			type : "post",
			url : "/member/mberIdCheck",
			data : data,
			success : function(result){
				if(result != "fail"){
					alert("중복된 아이디가 없습니다. 사용가능");
					mberIdCheck = true;
				} else {
					alert("중복된 아이디가 있습니다. 사용불가");
					mberIdCheck = false;
				}
			}
		});
	};
	$(document).ready(function(){
		
	
	$("#email").on("propertychange change keyup paste input",function(){
		var email = $("#email").val();
		var datas = {
				email : email
		}
		$.ajax({
			type : "post",
			url : "/member/emailCheck",
			data : datas,
			success : function(result){
				if(result == "success"){
					$(".emailCk1").css("display","inline-block");
					$(".emailCk2").css("display","none");
					emailCheck = true;
				} else {
					$(".emailCk2").css("display","inline-block");
					$(".emailCk1").css("display","none");
					emailCheck = false;
				}
			}
		});
	});
	
	});
</script>
</head>
<body>
	<form id="insertForm" onsubmit="return beforeValid();" name="insertForm" method="post">
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name" id="name" placeholder="한글만 입력하세요"></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="mberId" id="mberId" placeholder="4~12자 영문,숫자만 입력가능">
					<button type="button" onclick="checkId();">중복검사</button></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="password" id="password" placeholder="4~12자 영문,숫자만 입력가능"></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="pw_Check" id="pw_Check" placeholder="4~12자 영문,숫자만 입력가능"></td>
			</tr>
			<tr>
				<td>핸드폰</td>
				<td><input type="text" name="phone" id="phone" placeholder="01012345678"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email" id="email" placeholder="예)abcd@naver.com">
				<span class="emailCk1" style="display: none; color: green;">중복된 이메일이 없습니다. 사용가능</span>
				<span class="emailCk2" style="display: none; color: red;">중복된 이메일이 있습니다. 사용불가</span>
				</td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="addr1" id="addr1"></td>
			</tr>
			<tr>
				<td>상세주소</td>
				<td><input type="text" name="detailAddr" id="detailAddr"></td>
			</tr>
			<input type="hidden" name="auth" id="auth" value="user"/>
		</table>
		<br>
		<input type="submit" value="회원가입" /> 
		<input type="reset" value="리셋" />
	</form>
</body>
</html>