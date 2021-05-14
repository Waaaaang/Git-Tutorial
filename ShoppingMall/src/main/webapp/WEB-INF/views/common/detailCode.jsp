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
		<h2 class="page-header">상세코드관리</h2>
			
	</div>
</div>	
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading" >
					<button id="det_Register" class="btn btn-success">등록</button>
					<button id="det_Modify" class="btn btn-primary">수정</button>
					<button id="det_Remove" class="btn btn-danger">삭제</button>
			</div>
				<div class="panel-body">
					<div class="form-group">
					<label>코드ID</label> 
					<select class="codeList1">
						<option value="">선택</option>
					</select>
					</div>
					<div class="form-group">
					<label>상세코드ID</label> <input class="form-control" id="det_Code_Id" name="det_Code_Id">
					</div>
					<span class="det_CodeCk1" style="display: none; color: green;">중복된 상세코드ID가 없습니다. 사용가능</span>
					<span class="det_CodeCk2" style="display: none; color: red;">중복된 상세코드ID가 있습니다. 사용불가</span>
					<div class="form-group">
						<label>상세코드명</label> <input class="form-control" id="det_Code_Nm" name="det_Code_Nm">
					</div>
					<div class="form-group">
						<label>상세코드설명</label>
						<textarea class="form-control" rows="3" id="det_Code_Dc" name="det_Code_Dc"></textarea>
					</div>
					<div class="form-group">
						<label>정렬순서</label> <input type="number" class="form-control" id="sort_Ordr" name="sort_Ordr">
						<span class="sortCk1" style="display: none; color: green;">중복된 정렬순서가 없습니다. 사용가능</span>
						<span class="sortCk2" style="display: none; color: red;">중복된 정렬순서가 있습니다. 사용불가</span>
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
		
		var detailCodeCheck = false;
		var sortCheck = false;
		
		//상세코드ID 중복 검사
		$("#det_Code_Id").on("propertychange change keyup paste input",function(){
			var datas = {
					det_Code_Id : $("#det_Code_Id").val(),
					code_Id : $(".codeList1").val()
			}
			$.ajax({
				type : "post",
				url : "/common/detailCodeCheck",
				data : datas,
				success : function(result){
					if(result == "success"){
						$(".det_CodeCk1").css("display","inline-block");
						$(".det_CodeCk2").css("display","none");
						detailCodeCheck = true;
					} else {
						$(".det_CodeCk2").css("display","inline-block");
						$(".det_CodeCk1").css("display","none");
						detailCodeCheck = false;
					}
				}
			});
		});
		
		//정렬순서 중복 검사
		$("#sort_Ordr").on("propertychange change keyup paste input",function(){
			var datas = {
					sort_Ordr : $("#sort_Ordr").val(),
					code_Id : $(".codeList1").val()
			}
			$.ajax({
				type : "post",
				url : "/common/sortCheck",
				data : datas,
				success : function(result){
					if(result == "success"){
						$(".sortCk1").css("display","inline-block");
						$(".sortCk2").css("display","none");
						sortCheck = true;
					} else {
						$(".sortCk2").css("display","inline-block");
						$(".sortCk1").css("display","none");
						sortCheck = false;
					}
				}
			});
		});
		
		//등록
		$("#det_Register").on("click",function(){
			if( $(".codeList1").val() == null ||  $(".codeList1").val() ==""){
				alert("코드ID 확인!!");
				return false;
			}
			if(detailCodeCheck == false || $("#det_Code_Id").val() == null || $("#det_Code_Id").val() == ""){
				alert("상세코드ID 확인!!");
				return false;
			} 
			if($("#det_Code_Nm").val() == null || $("#det_Code_Nm").val() ==""){
				alert("상세코드명 확인!!");
				return false;
			}
			if($("#det_Code_Dc").val() == null || $("#det_Code_Dc").val() ==""){
				alert("상세코드내용 확인!!");
				return false;
			}
			if(sortCheck == false || $("#sort_Ordr").val() == null || $("#sort_Ordr").val() ==""){
				alert("정렬순서 확인!!");
				return false;
			}
			var datas = {
					code_Id : $(".codeList1").val(),
					det_Code_Id : $("#det_Code_Id").val(),
					det_Code_Nm : $("#det_Code_Nm").val(),
					det_Code_Dc : $("#det_Code_Dc").val(),
					sort_Ordr : $("#sort_Ordr").val(),
					use_At : $("#use_At").val(),
					mberId : '<c:out value="${member.mberId}"/>'
			}
			$.ajax({
				type : "post",
				url : "/common/detailRegister",
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
		$("#det_Modify").on("click",function(){
			var datas = {
					det_Code_Id : $("#det_Code_Id").val(),
					det_Code_Nm : $("#det_Code_Nm").val(),
					det_Code_Dc : $("#det_Code_Dc").val(),
					use_At : $("#use_At").val(),
					mberId : '<c:out value="${member.mberId}"/>'
			}
			$.ajax({
				type : "post",
				url : "/common/detailModify",
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
		$("#det_Remove").on("click",function(){
		
			var datas = {
					det_Code_Id : $("#det_Code_Id").val(),
					use_At : 'N',
					mberId : '<c:out value="${member.mberId}"/>'
			}
			$.ajax({
				type : "post",
				url : "/common/detailRemove",
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
		
	
			<% String det_Code_Id = request.getParameter("det_Code_Id"); %>
			var det_Id = <%=det_Code_Id%>
			if(det_Id != null){
				 $("#det_Code_Id").val(det_Id);
				 var datas = {
							det_Code_Id : $("#det_Code_Id").val()
				}
				 $.ajax({
					type : "post",
					url : "/common/detailCode",
					data : datas,
					success : function(result){
						
						$(".codeList1").append("<option value='${detail.code_Id}'>${detail.code_Nm}</option>");
						$("#det_Code_Id").val('${detail.det_Code_Id}');
						$("#det_Code_Nm").val('${detail.det_Code_Nm}');
						$("#det_Code_Dc").val('${detail.det_Code_Dc}');
						$("#sort_Ordr").val('${detail.sort_Ordr}');
						$("#use_At").val('${detail.use_At}');
						document.getElementById('det_Code_Id').readOnly = true;
						document.getElementById('sort_Ordr').readOnly = true;
					}
				 });
			}
			
		if('${codeList}' != '' && '${codeList}' != null){
			var jsonData = JSON.parse('${codeList}');
			var code1Arr = new Array();
			var code1Obj = new Object();
			
			for(var i =0; i<jsonData.length; i++){
				code1Obj = new Object();
				code1Obj.code_Id = jsonData[i].code_Id;
				code1Obj.code_Nm = jsonData[i].code_Nm;
				code1Arr.push(code1Obj);
			}
			
			var code1List = $("select.codeList1");
			for(var i=0; i<code1Arr.length; i++){
				code1List.append("<option value='"+code1Arr[i].code_Id+"'>"+code1Arr[i].code_Nm+"</option>");
			}
		}
		
		
	});

</script>
	