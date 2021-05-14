<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../includes/header.jsp"%>

<div id="listDiv">
</div>

<script>
	$(document).ready(function(){
		
		
		goListMen();
		
		//글 상세보기 이동
		$(document).on("click",'.move',function(e){
			e.preventDefault();
			var gdsNo = $(this).attr("href");
			var jsonData ={
					gdsNo : gdsNo
			}
			$.ajax({
				url : '/goods/men/menDetailAjax',
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
		
	});
	
	//리스트
	function goListMen(){
		var datas = {
				cateCode : '${cateCode}',
		}
		$.ajax({
			type : "post",
			url : "/goods/men/men",
			data : datas,
			success : function(data){
				console.log(data);
				$("#listDiv").empty();
				$("#listDiv").html(data);
			},
			error : function(error){
				alert("오류발생 : "+error);
			}
		});
	}
	
	function addCart(){
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
	};

	function goList(){
		location.reload();
	};
	

</script>

<%@ include file="../../includes/footer.jsp"%>