<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<h1>상품 등록하기</h1>
<style>
	 td {
		float: left;
	}
	.uploadResult {
		width: 100%;
	}

	.uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;	
	}

	.uploadResult ul li {
		list-style: none;
		padding: 10px;
	}

	.uploadResult ul li img {
		width: 300px;
	}

	#register {
		margin-right: 3px;
	}
	
</style>
<form method="post" id="form">	<!--모든 문자를 인코딩하지 않음을 명시함.이 방식은 <form> 요소가 파일이나 이미지를 서버로 전송할 때 주로 사용함. -->
<table>
	<tr>
		<td><label>1차 분류</label>
			<select class="cmmnCodeList">
				<option value="">선택</option>
				<c:forEach var="cmmnCodeList" items="${cmmnCodeList }" varStatus="i">
					<option value="${cmmnCodeList.code_Id }">${cmmnCodeList.code_Nm }</option>
				</c:forEach>
			</select>
		</td>
		<td><label style="margin-left: 10px;">2차 분류</label>
			<select class="detailCodeList">
				<option value="">선택</option>
			</select>
	</tr>
	<tr>
		<td><label>상품명</label></td>
		<td><input type="text" name="gdsName" id="gdsName" style="margin-left: 15px;"/></td>
	</tr>
	<tr>
		<td><label>가격</label></td>
		<td><input type="number" name="gdsPrice" id="gdsPrice" style="margin-left: 30px;"/></td>
	</tr>
	<tr>
		<td><label>수량</label></td>
		<td><input type="number" name="gdsStock" id="gdsStock" style="margin-left: 30px;"/></td>
	</tr>
	<tr>
		<td><label>상품내용</label></td>
		<td><textarea rows="10" cols="30" name="gdsDes" id="gdsDes"></textarea></td>
	</tr>
	<tr>
		<td><input type="file" name="gdsImg" id="gdsImg" multiple="multiple" /></td>
	</tr>
	<tr>
		<td>
			<div class="uploadResult">
				<ul>
				</ul>
			</div>
		</td>
	</tr>
	<tr>
		<td><button type="button" class="btn btn-info" id="register" >등록하기</button></td>
		<td><button type="reset" class="btn btn-success" id="reset">리셋</button></td>
	</tr>
</table>
</form>

<script>

	//파일 검사
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; //5MB

	function checkExtension(fileName, fileSize){
		if(fileSize>=maxSize){
			alert("파일 사이즈 초과");
			return false;
		}	
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;	
	}
	
	$("input[type='file']").change(function(e){
		var formData = new FormData();	//<form> 과 같은 효과를 가져다주는 key/value 가 저장되는 객체
		var inputFile = $("input[name='gdsImg']");
		var files = inputFile[0].files;
		for(var i = 0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("gdsImg",files[i]);
		}
		
		$.ajax({
			url : '/uploadAjaxAction',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			dataType : 'json',
			success : function(result){
				console.log(result);
				showUploadResult(result);
			}
		});//$.ajax
	});		
		function showUploadResult(uploadResultArr){
			if(!uploadResultArr || uploadResultArr.length==0){
				return;
			}
			
		var uploadUL = $(".uploadResult ul");
		var str = "";

		$(uploadResultArr).each(function(i,obj){
			var image = obj.image;
			if(image=="Y"){//이미지 파일일 때
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/thumb_"+obj.fileId+"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"'";
				str += " data-fileId='"+obj.fileId+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
				str += "<span> "+obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>";
				str += "<i class='fa fa-times-circle'></i></button><br>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div></li>";
			} else{//일반 파일일 때
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.fileId+"_"+obj.fileName);
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
						
				str += "<li data-path='"+obj.uploadPath+"'";
				str += " data-fileid='"+obj.fileId+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
				str += "<span>"+obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'>";
				str += "<i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/mainImg/attach.jpg'>";
				str += "</div></li>";		
			}
		});
		uploadUL.append(str);
		}	

		//업로드된 파일의 버튼을 클릭했을 때
	$(".uploadResult").on("click","button",function(e){
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url : '/deleteFile',
			data : {fileName : targetFile, type : type},
			dataType : 'text',
			type : 'POST',
			success : function(result){
				targetLi.remove();
			}
		});// $.ajax
	});//$(".uploadResult")

	//파일 이미지 등록
// 	$("#gdsImg").change(function(){
// 		if(this.files && this.files[0]){
// 			var reader = new FileReader;
// 			reader.onload = function(data){
// 				//data.target.result == event.target.result 나중에 이미지를 다운받거나 그 이미지를 그대로 사용해야하는 경우가 생길때를 대비해서 기본적으로 이미지에 대한 경로를 미리 세팅
// 				$(".uploadResult ul img").attr("src",data.target.result).width(300);
// 			}
// 			//file input 에서 change 이벤트 발생
// 			reader.readAsDataURL(this.files[0]);
// 		}
// 	});
	
	$("#reset").on("click",function(){
		location.reload();
	})
	
	

	//등록액션
 	$("#register").click(function(e){
 		e.preventDefault();
 		var form = $("#form");
 		var str ="";
 		
 		if($(".cmmnCodeList").val() == '' || $(".cmmnCodeList").val() == null){
 			alert("1차분류를 선택하세요");
 			return false;
 		} 
 		if($(".detailCodeList").val() == '' || $(".detailCodeList").val() == null){
 			alert("2차분류를 선택하세요");
 			return false;
 		} 
 		if($("#gdsName").val() == '' || $("#gdsName").val() == null){
 			alert("상품명을 입력하세요");
 			return false;
 		}
 		if($("#gdsPrice").val() == '' || $("#gdsPrice").val() == null){
 			alert("상품가격을 입력하세요");
 			return false;
 		}
 		if($("#gdsStock").val() == '' || $("#gdsStock").val() == null){
 			alert("상품수량을 입력하세요");
 			return false;
 		}
 		if($("#gdsDes").val() == '' || $("#gdsDes").val() == null){
 			alert("상품내용을 입력하세요");
 			return false;
 		} 
 		
 		var cateCode = $(".detailCodeList").val();
 		//파일 업로드
 	 	$(".uploadResult ul li").each(function(i, obj){
 			 var jobj = $(obj);
 		 		
 			 str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
 			 str += "<input type='hidden' name='attachList["+i+"].fileId' value='"+jobj.data("fileid")+"'>";
 			 str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
 			 str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
 	 	});
 	
 		form.append(str);
 		form.append(cateCode); 
 		form.append("<input type='hidden' name='mberId' value='${member.mberId}'/>");
 		form.append("<input type='hidden' name='cateCode' value='"+cateCode+"'/>");
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
	
	var url = '${url}';
	var auth ='${auth}';
	if(auth != '' && url != ''){
		alert(auth);
		location.href=url;
	}

	//1차분류
	//컨트롤러에서 데이터받기
	
// 	console.log(jsonData);
// 	var cate1Arr = new Array();
// 	var cate1Obj = new Object();
	
	
// 	//1차 분류 셀렉트 박스(select class)에 삽입할 데이터 준비
// 	for(var i=0; i<jsonData.length; i++){
// 			cate1Obj = new Object(); //초기화
// 			cate1Obj.code_Id = jsonData[i].code_Id;
// 			cate1Obj.code_Nm = jsonData[i].code_Nm;
// 			cate1Arr.push(cate1Obj);
// 		}
// 	console.log(cate1Arr);
// 	HashSet<String> hs = new HashSet<String>(cate1Arr);
// 	console.log(hs);
// 	var cate1Select = $("select.cmmnCodeList");
//  	//셀렉트 박스(select class)에 데이터 삽입
// 	for(var i=0; i<cate1Arr.length; i++){
// 		cate1Select.append("<option value='"+cate1Arr[i].code_Id+"'>"+cate1Arr[i].code_Nm+"</option>");
// 	}
	
	//2차분류
	//1차분류가 실행되고 나서 변경이 된다면 실행되는 함수
	$(document).on("change","select.cmmnCodeList",function(){	
		var jsonData = JSON.parse('${detailCodeList}');
		var cate2Arr = new Array();
		var cate2Obj = new Object();
		
		for(var i=0; i<jsonData.length; i++){
			if(jsonData[i].code_Id == $(".cmmnCodeList").val()){
			cate2Obj = new Object(); //초기화
			cate2Obj.det_Code_Id = jsonData[i].det_Code_Id;
			cate2Obj.det_Code_Nm = jsonData[i].det_Code_Nm;
			cate2Arr.push(cate2Obj);
			}
		}
		
		var cate2Select = $("select.detailCodeList");
		cate2Select.children().remove();	//중복처리
		cate2Select.append("<option value=''>선택</option>");
		for(var i=0; i<cate2Arr.length; i++){
			cate2Select.append("<option value='"+cate2Arr[i].det_Code_Id+"'>"+cate2Arr[i].det_Code_Nm+"</option>");	
		}
		

	});

// 		$("option:selected", this).each(function(){
			
// 			var selectVal = $(this).val();
// 			cate2Select.append("<option value=''>선택</option>");
			
// 			for(var i=0; i<cate2Arr.length; i++){
// 				if(selectVal == cate2Arr[i].cateCodeRef){
// 					cate2Select.append("<option value='"+cate2Arr[i].cateCode+"'>"+cate2Arr[i].cateName+"</option>");	
// 				}
// 			}
// 		});

</script>