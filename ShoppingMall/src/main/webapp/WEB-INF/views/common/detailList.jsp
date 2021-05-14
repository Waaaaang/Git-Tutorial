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
<title></title>
</head>
<style>
.grid-container {
	display: grid;
	grid-template-columns: auto auto auto;
	background-color: #2196F3;
	padding: 10px;
}

.grid-item {
	background-color: rgba(255, 255, 255, 0.8);
	border: 1px solid rgba(0, 0, 0, 0.8);
	padding: 20px;
	font-size: 30px;
	text-align: center;
}

.uploadResult ul li {
	list-style: none;
}
</style>
<body>
<div class="row">
	<div class="col-lg-12">
		<h2 class="page-header">상세코드목록</h2>
	</div>
</div>
<div class="panel panel-default">
			<div class="panel-heading">상세코드목록	
			</div>
   	
	<div class="panel-body">
		<table class="table eable-striped table-bordered table-hover" >
			<thead>
				<tr>
<!-- 					<th style="width: 10%">코드ID</th> -->
					<th style="width: 10%">상세코드ID</th>
					<th style="width: 30%">상세코드명</th>
					<th style="width: 10%">상세코드설명</th>
					<th style="width: 10%">정렬순서</th>
					<th style="width: 10%">사용여부</th>
					<th style="width: 10%">등록일</th>
				</tr>
			</thead>
				<tbody class="tr"> 
				</tbody>
		</table>
		<div class="panel-footer">
		</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript" src="/resources/js/detailCode.js"></script>
<script>
$(document).ready(function(){
	

	<% String code_Id = request.getParameter("code_Id"); %>
	
	var code_Id = '<%=code_Id%>';
	if(code_Id != null){
		detailList(1);
	}
	
	function detailList(page){
		
		detailService.getList({code_Id:code_Id, page: page||1}, function(codeCnt, list){

			if(page == -1){
				pageNum = Math.ceil(codeCnt/10.0);
				detailList(pageNum);
				return;
			}
			if(list == null || list.length == 0){
				$(".tr").html("");
				return;
			}
			
			var str ="";
	
			for(var i = 0, len = list.length ||0; i<len; i++){
				str +="<tr class='move' href="+list[i].det_Code_Id+" style='cursor: pointer;'>";
// 				str += "<td>"+list[i].code_Id+"</td>";
				str += "<td>"+list[i].det_Code_Id+"</td>";
				str += "<td>"+list[i].det_Code_Nm+"</td>";
				str += "<td>"+list[i].det_Code_Dc+"</td>";
				str += "<td>"+list[i].sort_Ordr+"</td>";
				str += "<td>"+list[i].use_At+"</td>";
				str += "<td>"+detailService.displayTime(list[i].firstRegDate)+"</td>";
				str +="</tr>";
			}
			$(".tr").html(str);
			showDetailPage(codeCnt);
		});
	}
	
	var pageNum = 1;
	var detailPageFooter = $(".panel-footer");
	
	function showDetailPage(codeCnt){
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= codeCnt){
			endNum = Math.ceil(codeCnt/10.0);
		}
		
		if(endNum * 10 < codeCnt){
			next = true;
		}
		
		var str = "<ul class='pagination pull-right'>";
		
		if(prev){
			str += "<li class='page-item'><a class ='page-link' href='"+(startNum -1)+"'>Previous</a></li> ";
		}
		
		for(var i = startNum; i<=endNum; i++){
			var active = pageNum == i ? "active":"";				
			str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		
		if(next){
			str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li> ";
		}
		
		str += "</ul></div>";
		
		detailPageFooter.html(str);
	}
	
	// 페이지 번호 클릭시 새댓글 가져오기
  	detailPageFooter.on("click","li a", function(e){
  		e.preventDefault();

  		var targetPageNum = $(this).attr("href");
  		
  		pageNum = targetPageNum;
  		detailList(pageNum);
  	});
  	
  	$(document).on("click",'.move',function(e){
		e.preventDefault();
		var datas = $(this).attr("href");
		parent.test2(datas);			//부모 페이지와 통신
	
	});
});
</script>
