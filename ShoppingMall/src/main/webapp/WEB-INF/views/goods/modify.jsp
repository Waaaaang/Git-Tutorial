<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<h1>상품 수정하기</h1>
<form method="post" id="form">
<div>
	<label>상품번호 : </label><c:out value="${goods.gdsNo}"></c:out>
</div>
<div>
	<label>상품명 : </label><input type="text" name="gdsName" id="gdsName" value='<c:out value="${goods.gdsName }"/>'>
</div>
<div>
	<label>가격 :</label><input type="number" name="gdsPrice" id="gdsPrice" value='<c:out value="${goods.gdsPrice }"/>'>
</div>
<div>
	<label>상품내용</label><br>
	<textarea rows="10" cols="30" id="gdsDes" name="gdsDes"><c:out value="${goods.gdsDes }"></c:out></textarea>
</div>
<input type="file" name="gdsImg" id="gdsImg">
<div class="select_img"><img src="/resources/mainImg/${goods.gdsImg }" width="300px" height="300px" /></div>
<br>

<button type="submit" id="modify">수정하기</button>
<button type="button" onclick="remove();">삭제하기</button>
<button type="button" onclick="goList();">목록보기</button>
</form>

<script>
	//파일 이미지 등록
	$("#gdsImg").change(function(){
		if(this.files && this.files[0]){
			var reader = new FileReader;
			reader.onload = function(data){
			$(".select_img img").attr("src",data.target.result).width(300);
			}
		reader.readAsDataURL(this.files[0]);
		}
	});

	function goList() {
		location.href = "/goods/goods";
	}

	$("#modify").click(function(e){
		var form = $("#form");
		e.preventDefault();
		if ($("#gdsName").val() == '' || $("#gdsName").val() == null) {
			alert("상품명을 입력하세요");
			return false;
		}
		if ($("#gdsPrice").val() == '' || $("#gdsPrice").val() == null) {
			alert("상품가격을 입력하세요");
			return false;
		}
		if ($("#gdsDes").val() == '' || $("#gdsDes").val() == null) {
			alert("상품내용을 입력하세요");
			return false;
		}
		form.append("<input type='hidden' name='gdsNo' value='${goods.gdsNo}'/>");
		form.append("<input type='hidden' name='mberId' value='${member.mberId}'/>");
		form.attr("action","/goods/update");
		form.submit();
	});
	
	function remove(){
		if(confirm("정말 삭제하시겠습니까 ?")){
			var datas = {
					gdsNo : '${goods.gdsNo}'
			}
			$.ajax({
				type : "POST",
				url : "/goods/remove",
				data : datas,
				success : function(data){
					if(data.result == "success"){
						alert("상품 삭제 완료");
						location.href="/goods/goods";
					} else {
						alert("상품 삭제 실패");
					}
				}
			});
		}
	};
	
	var result = '${result}';
	if(result == "success"){
		alert("상품 수정 완료");
		location.href="/goods/goods";
	} else if (result =="fail"){
		alert("상품 수정 실패");
	}
</script>