<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>

 .orderInfo { border:5px solid #eee; padding:10px 20px; margin:20px 0;}
 .orderInfo span { font-size:20px; font-weight:bold; display:inline-block; width:120px; }
 
 .orderView li { margin-bottom:20px; padding-bottom:20px; border-bottom:1px solid #999; list-style: none;}
 .orderView li::after { content:""; display:block; clear:both; }
 
 .thum { float:left; width:200px; }
 .thum img { width:200px; height:200px; }
 .gdsInfo { float:right; width:calc(100% - 220px); line-height:2; }
 .gdsInfo span { font-size:20px; font-weight:bold; display:inline-block; width:100px; margin-right:10px; }
 .deli { text-align:right; }
 .delivery_ing, .delivery_commit, .user_Cancel, .admin_Cancel, .goReply { font-size:16px;  border:1px solid #999; margin-left:10px; }

 .score .score_radio {
 	position: relative;
    display: inline-block;
    z-index: 20;
    opacity: 0.001;
    width: 60px;
    height: 60px;
    background-color: #fff;
    cursor: pointer;
    vertical-align: top;
    display: none;
 }

 .score .score_radio + label {
    position: relative;
    display: inline-block;
    margin-left: -4px;
    z-index: 10;
    width: 60px;
    height: 60px;
    background-image: url('/resources/mainImg/starrate.png');
    background-repeat: no-repeat;
    background-size: 60px 60px;
    cursor: pointer;
    background-color: #f0f0f0;
}
.score .score_radio:checked + label {
    background-color: #ff8;
}
.form-group {
    margin: 15px;
}
</style>

<section id="content" style="margin: 10px;">

 <div class="orderInfo">
  <c:forEach items="${orderView}" var="orderView" varStatus="status">
   
   <c:if test="${status.first}">
     <p><span>주문자</span>${orderView.mberId }</p>
     <p><span>수령인</span>${orderView.orderRec}</p>
   	 <p><span>주소</span>${orderView.addr1} ${orderView.detailAddr}</p>
     <p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.amount}" /> 원</p>
     <p><span>상태</span>
     	<span style="color:
	     	<c:choose>
	     		<c:when test='${orderView.delivery eq "배송준비"}'>
	     			red
	     		</c:when>
	     		<c:when test='${orderView.delivery eq "배송 중"}'>
	     			blue
	     		</c:when>
	     		 <c:when test='${orderView.delivery eq "배송 완료"}'>
	     			gray
	     		</c:when>
	     		<c:when test='${orderView.delivery eq "주문취소요청"}'>
	     			green
	     		</c:when>
	     		<c:when test='${orderView.delivery eq "주문취소"}'>
	     			yellow
	     		</c:when>
	     	</c:choose>
     		">
	     	${orderView.delivery}		
	     </span>
     </p>
       <c:if test='${orderView.delivery == "주문취소요청" && member.auth eq "admin"}'>
   	 		<div class="deli">
   				<button type="button" class="btn btn-success admin_Cancel">주문취소완료</button>
   			</div>
   	 	</c:if> 
   	 	<script>
	    $(document).ready(function(){
   		 	var delivery = '${orderView.delivery}';
	    	if('주문취소완료' == delivery){
		 		$(".admin_Cancel").css("display","none");
				}
			$(".admin_Cancel").click(function(){
			 	var datas = {
					 orderId : '${orderView.orderId }',
					 amount : '<c:out value="${orderView.amount}"/>',
					 mberId : '<c:out value="${orderView.mberId }"/>', 
				 	 delivery : '주문취소완료'
			 	}
				$.ajax({
					type : "post",
					url : "/goods/delivery",
					data : datas,
					success : function(data){
						if(data.result == "success"){
							location.reload();
						} else {
							alert("주문취소 실패");
						}
					}
		 		});
			});
	    });
	    </script> 
     
   	 <c:if test='${(orderView.delivery == "배송준비" || orderView.delivery == "배송 중") && member.auth eq "admin"}'>
     	<div class="deli">
   				<button type="button" class="btn btn-primary delivery_ing">배송 중</button>
   				<button type="button" class="btn btn-gray delivery_commit">배송 완료</button>			
    	 </div>
    	 
    	 <script>
    	 $(document).ready(function(){
    		 var delivery = '${orderView.delivery}';
    		 if('배송 중' == delivery){
    			 $(".delivery_ing").css("display","none");
    		 } else if('배송 완료' == delivery){
    			 $(".delivery_ing").css("display","none");
    			 $(".delivery_commit").css("display","none");
    		 }
    		 
    		 $(".delivery_ing").click(function(){
					 var datas = {
						 orderId : '${orderView.orderId }',
						 delivery : '배송 중'
					 }
	 				$.ajax({
						type : "post",
						url : "/goods/delivery",
						data : datas,
						success : function(data){
							if(data.result == "success"){
								location.reload();
							} else {
								alert("배송 실패");
							}
						}
				 	});
				});
    		 
    			$(".delivery_commit").click(function(){
 				    var datas = {
 	  					 orderId : '${orderView.orderId }',
 	  					 delivery : '배송 완료'
 	  				 }
 	  	 			$.ajax({
 	  					type : "post",
 	  					url : "/goods/delivery",
 	  					data : datas,
 	  					success : function(data){
 	  						if(data.result == "success"){
 	  							location.reload();
 	  						} else {
 	  							alert("배송 실패");
 	  						}
 	  					}
 	  				 });
 				});
    	 	});		 
		</script>
	 </c:if>
	 	<c:if test='${orderView.delivery eq "배송준비" && member.auth eq "user"}'>
	 		<div class="deli">
	     		<button type="button" class="btn btn-success user_Cancel">주문취소요청</button>
	     	</div>	
	    </c:if>  
	    <script>
	    $(document).ready(function(){
   		 	var delivery = '${orderView.delivery}';
	    	if('주문취소요청' == delivery){
		 		$(".user_Cancel").css("display","none");
				}
			$(".user_Cancel").click(function(){
			 	var datas = {
					 orderId : '${orderView.orderId }',
				 	 delivery : '주문취소요청'
			 	}
				$.ajax({
					type : "post",
					url : "/goods/delivery",
					data : datas,
					success : function(data){
						if(data.result == "success"){
							location.reload();
						} else {
							alert("주문취소 실패");
						}
					}
		 		});
			});
	    });
	    </script> 
	  </c:if>
  </c:forEach>
 </div>
 
 <ul class="orderView">
  <c:forEach items="${orderView}" var="orderView">     
  <li>
   <div class="thum">
    <img src="/display?fileName=${orderView.uploadPath}/thumb_${orderView.fileId}_${orderView.fileName}">
   </div>
   <div class="gdsInfo">
    <p>
     <span>상품명</span>${orderView.gdsName}<br />
     <span>개당 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.gdsPrice}" /> 원<br />
     <span>구입 수량</span>${orderView.cartStock} 개<br />
     <span>최종 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.gdsPrice * orderView.cartStock}" /> 원                  
    </p>
   </div>
   <c:if test='${orderView.delivery eq "배송 완료" && member.auth eq "user" && orderView.replyCnt == 0}'>
   <div class="deli">
   		<button type="button" class="btn btn-primary goReply_${orderView.gdsNo}">리뷰작성</button>
   </div>
   </c:if>
   <script type="text/javascript" src="/resources/js/reply.js"></script>
   <script>
  	
   		$(document).ready(function(){

   			var gdsNo = "";
   			var modal = $(".modal");
	   		var modalInputScore = modal.find("select[id='score']");
	   		var modalInputReply = modal.find("textarea[name='reply']");
	   		var modalInputReplyer = modal.find("input[name='mberId']");
	   		var modalInputReplyDate = modal.find("input[name='firstRegDate']");
	   		var modalRegisterBtn = $("#modalRegisterBtn");
	   		
   			$(".goReply_${orderView.gdsNo}").on("click",function(){
   			
   				gdsNo = '<c:out value="${orderView.gdsNo}"/>';
   				
   				modal.find("input[name='mberId']").val('<c:out value="${member.mberId}"/>');
   				modalInputReplyDate.closest("div").hide(); //날짜 숨기기
   				modal.find("button[id != 'modalCloseBtn']").hide(); //id가 다른 값 숨기기
   				
   				modalRegisterBtn.show();
   				$("#myModal").modal('show');
   				
   				//모달에 있는 등록 버튼 클릭
   				modalRegisterBtn.on("click", function(e){
   					
   					var reply = {
   							score : modalInputScore.val(),
   							reply : modalInputReply.val(),
   							mberId : modalInputReplyer.val(),
   							gdsNo: gdsNo
   							}; //댓글 정보	
   						
   						//실질적 댓글 등록
   						replyService.add(reply, function(result){
   							if(result =="success"){
   								alert("리뷰등록완료!");
   								modal.modal("hide");//모달 숨기기
   								location.reload();
   							} else if(result == "fail"){
   								alert("이미 후기를 남겼습니다.");
   								modal.modal("hide");//모달 숨기기
   								location.reload();
   							}	
   						});
   						
   					});	
   				});
   		});
   </script>
  </li>     
  </c:forEach>
 </ul>
</section>

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
			<button type="button" id='modalRegisterBtn' class="btn btn-primary">등록</button>
			<button type="button" id='modalCloseBtn' class="btn btn-default" data-dismiss="modal">닫기</button>
		</div>
		</div> <!-- modal-content -->
	</div> <!-- modal-dialog -->
</div> <!-- modal -->
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
  

</script>

