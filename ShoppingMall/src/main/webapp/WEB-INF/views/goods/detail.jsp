<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../includes/header.jsp"%>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
.uploadResult ul li {
	list-style: none;
}
.form-group {
    margin: 15px;
}
</style>
<h1>상품 상세보기</h1>
<form method="post" id="form">
<div>
	<label>상품명 : </label><c:out value="${goods.gdsName }"></c:out>
</div>
			<!-- 점수 -->
			<div>
			<label>평점</label><br>
			<c:set var="score" value="${score}"/>
			
      		<c:if test = "${fn:contains(score, '1')}">
        	<img src="/resources//mainImg/score/1star.png">
      		</c:if>
      		<c:if test = "${fn:contains(score, '2')}">
        	<img src="/resources/mainImg/score/2star.png">
      		</c:if>
      		<c:if test = "${fn:contains(score, '3')}">
        	<img src="/resources/mainImg/score/3star.png">
      		</c:if>
      		<c:if test = "${fn:contains(score, '4')}">
        	<img src="/resources/mainImg/score/4star.png">
      		</c:if>
      		<c:if test = "${fn:contains(score, '5')}">
        	<img src="/resources/mainImg/score/5star.png">
      		</c:if>
			</div>
			
<div class="uploadResult">
	<img src="/display?fileName=${goods.uploadPath}/${goods.fileId}_${goods.fileName}" style="width: 300px; height: 300px;">
</div>
<div>
	<label>가격 :</label><fmt:formatNumber pattern="###,###,###" value="${goods.gdsPrice }"></fmt:formatNumber>원
</div>
<c:if test="${goods.gdsStock !=0}">
<div>
	<label>재고 :</label><c:out value="${goods.gdsStock }"/> EA
</div>
<div>
	<label>구매 수량 : </label>
	<button type="button" class="btn btn-success btn-xs  plus">+</button>
	<input type="number" class="numBox" min="1" max="${goods.gdsStock }" value="1" readonly="readonly" />
	<button type="button" class="btn btn-success btn-xs minus">-</button>
</div>
</c:if>
<c:if test="${goods.gdsStock == 0}">
<div>
	<p style="color: red;">일시품절</p>
</div>
</c:if>
<div>
	<label>상품내용</label><br>
	<c:out value="${goods.gdsDes }"/>
</div>
<br>
<c:if test="${(!empty member.mberId) && (goods.gdsStock != 0) }">
<button type="button" class="btn btn-info" onclick="addCart();">장바구니담기</button>
</c:if>
<button type="button" class="btn btn-gray" onclick="goList();">목록보기</button>
<c:if test="${member.auth eq 'admin' }">
<button type="button" class="btn btn-primary" onclick="modify();">수정하기</button>
</c:if>
</form>
<br>
<div>
	<div class="divReply">
		<ul class="chat">
			<li></li>
		</ul>
	</div>
	<!-- 댓글 페이지 목록 -->
	<div class="panel-footer">
	
	</div>
</div>
<!-- Modal -->
<div class='modal fade' id='myModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">후기작성</h4>
			</div>
			
			<div class='form-group'>
				<label>점수</label><br>
				<select id="score">
				<option value="5" selected="selected">5점(매우 만족)</option>
				<option value="4">4점(만족)</option>
				<option value="3">3점(보통)</option>
				<option value="2">2점(불만족)</option>
				<option value="1">1점(매우 불만족)</option>
				</select>
			</div>
			
			<div class='form-group'>
				<label>리뷰 내용</label>
				<textarea rows="5" cols="4" class='form-control' name='reply' onkeyup="chkword(this, 1000)"></textarea>
			</div>
			<div class='form-group'>
				<label>작성자</label>
				<input class='form-control' name='mberId' value='<c:out value="${member.mberId }"/>' readonly="readonly">
			</div>
			<div class='form-group'>
				<label>작성일</label>
				<input class='form-control' name='firstRegDate' value="">
			</div>
		<div class="modal-footer">


			<button type="button" id='modalModBtn' class="btn btn-warning">수정</button>
			<button type="button" id='modalRemoveBtn' class="btn btn-danger">삭제</button>
			<button type="button" id='modalCloseBtn' class="btn btn-default" data-dismiss="modal">닫기</button>
		</div>
		</div> <!-- modal-content -->
	</div> <!-- modal-dialog -->
</div> <!-- modal -->


<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
	$(document).ready(function () {
		var modal = $(".modal");
   		var modalInputScore = modal.find("select[id='score']");
   		var modalInputReply = modal.find("textarea[name='reply']");
   		var modalInputReplyer = modal.find("input[name='mberId']");
   		var modalInputReplyDate = modal.find("input[name='firstRegDate']");
   		var modalModBtn = $("#modalModBtn");
   		var modalRemoveBtn = $("#modalRemoveBtn");
		var gdsNo = '<c:out value="${goods.gdsNo}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page){
			//page가 null 이거나 undefined면 1
			replyService.getList({gdsNo:gdsNo, page: page||1}, function(replyCnt, list){
				//댓글 단 페이지로 이동
				if(page==-1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				if(list == null || list.length == 0){
					replyUL.html("");
					return;
				}
				
				var str="";
				//댓글
				for(var i = 0, len = list.length || 0; i<len; i++){
					str += "<li class='left clearfix' style='list-style: none;' data-replyno='"+list[i].replyNo+"'>";
					str += " <div><div>";
					//댓글 점수별 별점 이미지 출력
					if(list[i].score=="1"){
						str += "<input type='image' src='/resources/mainImg/red/1red.png'>"
					}else if(list[i].score=="2"){
						str += "<input type='image' src='/resources/mainImg/red/2red.png'>"
					}else if(list[i].score=="3"){
						str += "<input type='image' src='/resources/mainImg/red/3red.png'>"		
					}else if(list[i].score=="4"){
						str += "<input type='image' src='/resources/mainImg/red/4red.png'>"		
					}else if(list[i].score=="5"){
						str += "<input type='image' src='/resources/mainImg/red/5red.png'>"
					}	
					str += "</div><div class='header'><strong class='primary-font'>["+list[i].replyNo+"] "+list[i].firstRegId+"</strong>";
					str += " <span>("+replyService.displayTime(list[i].firstRegDate)+")</span></div>";
					str += " <p>"+list[i].reply+"</p></div></li>";
				}
				replyUL.html(str);
				showReplyPage(replyCnt);
			});//end function
		}//end showList

		//페이지 목록 번호
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt){
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if(endNum * 10 < replyCnt){
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
			
			str += "</ul></div>"
			
			replyPageFooter.html(str);
		}
		
		var admin = 'admin';
		var mberId = '<c:out value="${member.mberId }"/>';
		
		//댓글 조회 처리
		if(mberId != null && mberId != ""){
			$(".chat").on("click","li",function(e){
		  		 var replyNo = $(this).data('replyno');
		 
		  		 replyService.get(replyNo, function(re){
		  			 modalInputScore.val(re.score);
		  			 modalInputReply.val(re.reply);
		  			 modalInputReplyer.val(re.firstRegId).attr("readonly","readonly");
		  			 modalInputReplyDate.val(replyService.displayTime(re.firstRegDate)).attr("readonly","readonly");
		  			 modal.data("replyNo", re.replyNo);
		  			 
		  			 modal.find("button[id !='modalCloseBtn']").hide();
		  			 modalModBtn.show();
		  			 modalRemoveBtn.show();
		  			 
		  			 $(".modal").modal("show");
		  		 });
		  	 });
		} 
	  	// 페이지 번호 클릭시 새댓글 가져오기
	  	replyPageFooter.on("click","li a", function(e){
	  		e.preventDefault();
	
	  		var targetPageNum = $(this).attr("href");
	  		
	  		pageNum = targetPageNum;
	  		showList(pageNum);
	  	});
	  	
	  	//댓글 수정
	  	modalModBtn.on("click", function(e){
	  		
	  		var originalReplyer = modalInputReplyer.val();
	  		var reply = {score: modalInputScore.val(), replyNo:modal.data("replyNo"), reply: modalInputReply.val(), mberId: '${member.mberId}'};
	  
	  		if(admin != '<c:out value="${member.auth}"/>'){
	  		if(originalReplyer != mberId){
	  			alert("자신의 글이 아닙니다.수정불가");
	  			modal.modal("hide");
	  			return;
	  			}
	  		}
	  		replyService.update(reply, function(result){
	  			 alert(result);
	  			 modal.modal("hide");
	  			 showList(pageNum);
	  		});
	  	});
	  	
	  	// 댓글 삭제
	  	modalRemoveBtn.on("click", function(e){
	  		var replyNo = modal.data("replyNo");
	  	
	  		var originalReplyer = modalInputReplyer.val();
	  
	  		if(admin != '<c:out value="${member.auth}"/>'){
	  		if(originalReplyer != mberId){
	  			alert("자신의 글이 아닙니다. 삭제 불가!");
	  			modal.modal("hide");
	  			return;
	  			}
	  		}


	  		replyService.remove(replyNo, originalReplyer, function(result){
	  			alert(result);
	  			modal.modal("hide");
	  			showList(pageNum);
	  		});

	  	});
	});
</script>
<script>

//리뷰내용 글자 수 제한
function chkword(obj, maxByte){
	var strValue = obj.value;
	var strLen = strValue.length;
	var totalByte = 0;
	var len=0;
	var oneChar="";
	var str2="";
	
	for(var i=0; i<strLen; i++){
		oneChar = strValue.charAt(i);
		if(escape(oneChar).length >4){
			totalByte +=3;
		} else {
			totalByte++;
		}
	
	//입력한 문자 길이보다 넘치면 잘라내기 위해 저장
		if(totalByte <= maxByte){
		len = i+1;
		}
	}	

// 넘어가는 글자는 자른다.
	if(totalByte > maxByte){
		alert(maxByte+"자를 초과 입력 할 수 없습니다.");
		str2= strValue.substr(0, len);
		obj.value = str2;
		chkword(obj, 1000);
	}
}
  

	$(".plus").click(function(){
 		var num = $(".numBox").val();
 		var plusNum = Number(num)+1;
 		console.log(plusNum);
 		if(plusNum > '${goods.gdsStock}') {
  			$(".numBox").val(num);
 		} else {
  			$(".numBox").val(plusNum);          
 		}
	});

	$(".minus").click(function(){
 		var num = $(".numBox").val();
 		var minusNum = Number(num)-1;
 
 		if(minusNum <= 0) {
  			$(".numBox").val(num);
 		} else {
  			$(".numBox").val(minusNum);          
 		}
	});

	function addCart(){
		var datas = {
			gdsNo :	'${goods.gdsNo}',
			mberId : '${member.mberId}',
			cartStock : $(".numBox").val()
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
		location.href="/goods/goods";
	};

	function modify(){
		var form = $("#form");
		form.append("<input type='hidden' name='gdsNo' value='${goods.gdsNo}'/>");
		form.attr("action","/goods/modify");
		form.submit();
	};
</script>