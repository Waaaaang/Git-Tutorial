<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<style>
.uploadResult ul li {
	list-style: none;
}
</style>
<h1>상품 수정하기</h1>
<form method="post" id="form">
<div>
	<label>상품명 : </label><input type="text" name="gdsName" id="gdsName" value='<c:out value="${goods.gdsName }"/>'>
</div>
<div>
	<label>가격 :</label><input type="number" name="gdsPrice" id="gdsPrice" value='<c:out value="${goods.gdsPrice }"/>'>
</div>
<div>
	<label>수량 :</label><input type="number" name="gdsStock" id="gdsStock" value='<c:out value="${goods.gdsStock }"/>'>
</div>
<div>
	<label>상품내용</label><br>
	<textarea rows="10" cols="30" id="gdsDes" name="gdsDes"><c:out value="${goods.gdsDes }"></c:out></textarea>
</div>
<input type="file" name="gdsImg" id="gdsImg">
<div class="uploadResult">
	<ul>
	</ul>
</div>
<br>

<button type="submit" id="modify">수정하기</button>
<button type="button" onclick="remove();">삭제하기</button>
<button type="button" onclick="goList();">목록보기</button>
</form>

<script>
$(document).ready(function(){
					  
	    var gdsNo = '<c:out value="${goods.gdsNo}"/>';

	    $.getJSON("/goods/getAttachList", {gdsNo: gdsNo}, function(arr){ //사진 목록 가져오기
					        
	    console.log(arr);
					       
   	    var str = "";
					       
       	$(arr).each(function(i, obj){	
       		var type = obj.fileType;
            //image type
            if(type==="Y"){
	        	 var fileCallPath =  encodeURIComponent(obj.uploadPath+ "/thumb_"+obj.fileId +"_"+obj.fileName); 	
	        	 str += "<li data-path='"+obj.uploadPath+"' data-fileid='"+obj.fileId+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"' ><div>";
		         str += "<img src='/display?fileName="+fileCallPath+"'>";
	             str += "</div>";
	             str +="</li>";
            }else{          
	             str += "<li data-path='"+obj.uploadPath+"' data-fileid='"+obj.fileId+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"' ><div>";
	             str += "<span style='color:black;'> "+ obj.fileName+"</span><br/>";
	             str += "<img src='/resources/mainImg/attach.png'>";
	             str += "</div>";
	             str +="</li>";
	        }
       	});    
      		$(".uploadResult ul").append(str);            
   		});//end getjson   
});
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
			$(".uploadResult ul").empty();
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
</script>
<script>
	function goList() {
		location.href = "/goods/goods";
	}

	$("#modify").click(function(e){
		var form = $("#form");
		var str ="";
		e.preventDefault();
		if ($("#gdsName").val() == '' || $("#gdsName").val() == null) {
			alert("상품명을 입력하세요");
			return false;
		}
		if ($("#gdsPrice").val() == '' || $("#gdsPrice").val() == null) {
			alert("상품가격을 입력하세요");
			return false;
		}
		if ($("#gdsStock").val() == '' || $("#gdsStock").val() == null) {
			alert("상품가격을 입력하세요");
			return false;
		}
		if ($("#gdsDes").val() == '' || $("#gdsDes").val() == null) {
			alert("상품내용을 입력하세요");
			return false;
		}
		if ($("#gdsImg").val() == '' || $("#gdsImg").val() == null) {
			alert("상품내용을 입력하세요");
			return false;
		}
		
		//파일 업로드
 	 	$(".uploadResult ul li").each(function(i, obj){
 			 var jobj = $(obj);
 		 
 			 str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
 			 str += "<input type='hidden' name='attachList["+i+"].fileId' value='"+jobj.data("fileid")+"'>";
 			 str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
 			 str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
 	 	});
 	
 		form.append(str);
		form.append("<input type='hidden' name='gdsNo' value='${goods.gdsNo}'/>");
		form.append("<input type='hidden' name='mberId' value='${member.mberId}'/>");
		form.attr("action","/goods/update");
		form.submit();
	});
	
	function remove(){
		if(confirm("정말 삭제하시겠습니까 ?")){
			var datas = {
					gdsNo : '${goods.gdsNo}',
					fileId : '${goods.fileId}'
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
	
	var url = '${url}';
	var auth ='${auth}';
	if(auth != '' && url != ''){
		alert(auth);
		location.href=url;
	}
	
</script>