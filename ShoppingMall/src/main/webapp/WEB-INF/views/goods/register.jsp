<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<h1>상품 등록하기</h1>
<form method="post" id="form">	<!--모든 문자를 인코딩하지 않음을 명시함.이 방식은 <form> 요소가 파일이나 이미지를 서버로 전송할 때 주로 사용함. -->
<div>
	<label>1차 분류</label>
	<select class="category1">
		<option value="">--</option>	
	</select>
	<label>2차 분류</label>
	<select class="category2" name="cateCode">
		<option value="">--</option>	
	</select>
</div>
<div>
	<label>상품명</label><input type="text" name="gdsName" id="gdsName"/>
</div>
<div>
	<label>가격</label><input type="number" name="gdsPrice" id="gdsPrice"/>
</div>
<div>
	<label>상품내용</label><br>
	<textarea rows="10" cols="30" name="gdsDes" id="gdsDes"></textarea>
</div>
<div>
	<input type="file" name="gdsImg" id="gdsImg" />
</div>
<div class="select_img"><img src="" /></div>

<br>
<button type="button" id="register" >등록하기</button>
<button type="reset" id="reset">리셋</button>
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
	
	$("#reset").on("click",function(){
		location.reload();
	})
	
	

	//등록액션
 	$("#register").click(function(e){
 		e.preventDefault();
 		var form = $("#form");
 		if($("#gdsName").val() == '' || $("#gdsName").val() == null){
 			alert("상품명을 입력하세요");
 			return false;
 		}
 		if($("#gdsPrice").val() == '' || $("#gdsPrice").val() == null){
 			alert("상품가격을 입력하세요");
 			return false;
 		}
 		if($("#gdsDes").val() == '' || $("#gdsDes").val() == null){
 			alert("상품내용을 입력하세요");
 			return false;
 		} 
 		if($(".category1").val() == '' || $(".category1").val() == null){
 			alert("카테고리를 선택하세요");
 			return false;
 		} 
 		
 		form.append("<input type='hidden' name='mberId' value='${member.mberId}'/>");
 		form.attr("action","insert");
 		form.submit();
 	});


	var result ='${result}';
	if(result == 'success'){
		alert("상품등록성공");
		location.href="/";
	} else if(result =='fail'){
		alert("상품등록실패");
	}

	//1차분류
	var jsonData = JSON.parse('${category}');
	console.log(jsonData);
	var cate1Arr = new Array();
	var cate1Obj = new Object();
	
	for(var i=0; i<jsonData.length; i++){
		if(jsonData[i].level == "1"){
			cate1Obj = new Object(); //초기화
			cate1Obj.cateCode = jsonData[i].cateCode;
			cate1Obj.cateName = jsonData[i].cateName;
			cate1Arr.push(cate1Obj);
		}
	}
	
	var cate1Select = $("select.category1");
	
	for(var i=0; i<cate1Arr.length; i++){
		cate1Select.append("<option value='"+cate1Arr[i].cateCode+"'>"+cate1Arr[i].cateName+"</option>");
	}
	
	//2차분류
	$(document).on("change","select.category1",function(){
		
		var cate2Arr = new Array();
		var cate2Obj = new Object();
		
		for(var i=0; i<jsonData.length; i++){
			if(jsonData[i].level == "2"){
			cate2Obj = new Object(); //초기화
			cate2Obj.cateCode = jsonData[i].cateCode;
			cate2Obj.cateName = jsonData[i].cateName;
			cate2Obj.cateCodeRef = jsonData[i].cateCodeRef;
			cate2Arr.push(cate2Obj);
			}
		}
	
		var cate2Select = $("select.category2");
		
		cate2Select.children().remove();	//중복처리
		$("option:selected", this).each(function(){
			
			var selectVal = $(this).val();
			cate2Select.append("<option value='"+selectVal+"'>전체</option>");
			
			for(var i=0; i<cate2Arr.length; i++){
				if(selectVal == cate2Arr[i].cateCodeRef){
					cate2Select.append("<option value='"+cate2Arr[i].cateCode+"'>"+cate2Arr[i].cateName+"</option>");	
				}
			}
		});
	});
</script>