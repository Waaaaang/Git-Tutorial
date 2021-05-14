<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<title>코드 등록 수정 삭제</title>
</head>
<body>
<div class="row">
	<div class="col-lg-12">
		<h2 class="page-header">공통코드관리</h2>
			
	</div>
</div>	
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading" >
					<button id="register" class="btn btn-success">등록</button>
					<button id="modify" class="btn btn-primary">수정</button>
					<button id="remove" class="btn btn-danger">삭제</button>
			</div>
				<div class="panel-body">
					<div class="form-group">
					<label>코드ID</label> <input class="form-control" id="code_Id" name="code_Id">
					</div>
					<span class="codeCk1" style="display: none; color: green;">중복된 코드ID가 없습니다. 사용가능</span>
					<span class="codeCk2" style="display: none; color: red;">중복된 코드ID가 있습니다. 사용불가</span>
					<div class="form-group">
						<label>코드명</label> <input class="form-control" id="code_Nm" name="code_Nm">
					</div>
					<div class="form-group">
						<label>코드설명</label>
						<textarea class="form-control" rows="3" id="code_Dc" name="code_Dc"></textarea>
					</div>
					<div class="form-group">
						<label>사용여부</label>
						<select id="use_At" name="use_At">
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>
			</div>
		</div>
	</div>
</div>
	

</body>
</html>
<script>
	$(document).ready(function(){
		
		var codeCheck = false;
		
		//이메일 실시간 중복 검사
		$("#code_Id").on("propertychange change keyup paste input",function(){
			var datas = {
					code_Id : $("#code_Id").val()
			}
			$.ajax({
				type : "post",
				url : "/common/codeCheck",
				data : datas,
				success : function(result){
					if(result == "success"){
						$(".codeCk1").css("display","inline-block");
						$(".codeCk2").css("display","none");
						codeCheck = true;
					} else {
						$(".codeCk2").css("display","inline-block");
						$(".codeCk1").css("display","none");
						codeCheck = false;
					}
				}
			});
		});
		
		//등록
		$("#register").on("click",function(){
			if(codeCheck == false || $("#code_Id").val() == null || $("#code_Id").val() == ""){
				alert("코드ID 확인!!");
				return false;
			} 
			if($("#code_Nm").val() == null || $("#code_Nm").val() ==""){
				alert("코드명 확인!!");
				return false;
			}
			if($("#code_Dc").val() == null || $("#code_Dc").val() ==""){
				alert("코드내용 확인!!");
				return false;
			}
			var datas = {
					code_Id : $("#code_Id").val(),
					code_Nm : $("#code_Nm").val(),
					code_Dc : $("#code_Dc").val(),
					use_At : $("#use_At").val(),
					mberId : '<c:out value="${member.mberId}"/>'
			}
			$.ajax({
				type : "post",
				url : "/common/register",
				data : datas,
				success : function(data){
					if(data.result == "success"){
						alert("등록완료");
						location.reload();
						window.parent.location.reload();
					} else {
						alert("등록실패");
					}
				}
			});
		});
		
		//수정
		$("#modify").on("click",function(){
			var datas = {
					code_Id : $("#code_Id").val(),
					code_Nm : $("#code_Nm").val(),
					code_Dc : $("#code_Dc").val(),
					use_At : $("#use_At").val(),
					mberId : '<c:out value="${member.mberId}"/>'
			}
			$.ajax({
				type : "post",
				url : "/common/modify",
				data : datas,
				success : function(data){
					if(data.result == "success"){
						alert("수정완료");
						location.reload();
						window.parent.location.reload();
					} else {
						alert("수정실패");
					}
				}
			});
		});
		
		//삭제
		$("#remove").on("click",function(){
		
			var datas = {
					code_Id : $("#code_Id").val(),
					use_At : 'N',
					mberId : '<c:out value="${member.mberId}"/>'
			}
			$.ajax({
				type : "post",
				url : "/common/remove",
				data : datas,
				success : function(data){
					if(data.result == "success"){
						alert("삭제완료");
						location.reload();
						window.parent.location.reload();
					} else {
						alert("삭제실패");
					}
				}
			});
		});
		
	
			<% String code_Id = request.getParameter("code_Id"); %>
			var id = '<%=code_Id%>';
			console.log(id);
			if(id != '' && id != 'null'){
				 $("#code_Id").val(id);
				 var datas = {
							code_Id : $("#code_Id").val()
				}
				 $.ajax({
					type : "post",
					url : "/common/cmmnCode",
					data : datas,
					success : function(){
						$("#code_Id").val('${cmmn.code_Id}');
						$("#code_Nm").val('${cmmn.code_Nm}');
						$("#code_Dc").val('${cmmn.code_Dc}');
						$("#use_At").val('${cmmn.use_At}');
						document.getElementById('code_Id').readOnly = true;
					}
				 });
			}

			
		
	});

</script>
	