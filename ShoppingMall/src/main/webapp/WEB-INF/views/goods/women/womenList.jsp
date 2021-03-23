<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../includes/header.jsp"%>

<div id="listDiv">
</div>

<script>
	$(document).ready(function(){
		
		
		goListWomen();
		
		function goListWomen(){
			var datas = {
					cateCode : '${cateCode}'
			}
			$.ajax({
				type : "post",
				url : "/goods/women/women",
				data : datas,
				success : function(data){
					$("#listDiv").empty();
					$("#listDiv").html(data);
				},
				error : function(error){
					alert("오류발생 : "+error);
				}
			});
		}
		
		//글 상세보기 이동
		$(document).on("click",'.move',function(e){
			e.preventDefault();
			var gdsNo = $(this).attr("href");
			var jsonData ={
					gdsNo : gdsNo
			}
			$.ajax({
				url : '/goods/women/womenDetailAjax',
				type : 'POST',
				data : jsonData,
				dataType : 'html',
				success : function(data){
					$('#listDiv').empty();
					$('#listDiv').html(data);
				},
				error : function(error){
					alert("오류발생: "+error);
				}
			});
		});
	
		$(document).on("click",'#addCart',function(e){
		var gdsNo = $("#gdsNo").val();
		var datas = {
			gdsNo :	gdsNo,
			mberId : '${member.mberId}',
			cartStock : 1
		}
		$.ajax({
			type : "post",
			url : "/goods/addCart",
			data : datas,
			success : function(){
				alert("장바구니 담기 완료");
				var confirm_val = confirm("장바구니 보기?");
				if(confirm_val){
					location.href="/goods/cartList";
				}
			},
			error : function(){
				alert("장바구니 담기 실패");
			}
		});
	});

	$(document).on("click",'#goList',function(e){
		location.reload();
	});

		
});

</script>

<%@ include file="../../includes/footer.jsp"%>