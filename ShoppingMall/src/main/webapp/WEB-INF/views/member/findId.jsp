<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div>
		<h3>아이디 찾기</h3>
			<form id="findForm" name="findForm" method="post">
				<label>이메일 :</label>
				<input type="text" name="email" id="email"  placeholder="이메일주소를 입력하세요" required><br>
				<button type="button" onclick="findId();">아이디찾기</button>
				<button type="button" onclick="history.go(-1)">취소</button>
			</form>
	</div>

</body>

<script>
	function findId(){
		var datas  = {
				email : $("#email").val()
		}
		$.ajax({
			type : "POST",
			url : "/member/findIdInsert",
			data : datas,
			success : function(data){
				console.log(data);
				if(data.result == "success"){
					alert("회원 아이디는 "+data.mberId+" 입니다.");
					$("#findForm").append("<button type='button' onclick='findPw();'>비밀번호 찾기</button>");
				} else {
					alert("이메일이 올바르지 않습니다.");
				}
			}
		});
	}
	
	function findPw(){
		location.href="/member/findPw";
	}

</script>
</html>