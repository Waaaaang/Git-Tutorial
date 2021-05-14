<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<title>충전하기</title>
</head>
<body>
<h2 style="color: red; text-align: center;">온라인 카드 결제</h2>
<div class="container">
<table class="table" cellspacing="0">
	<colgroup>
		<col width="40%">
		<col width="*"> 
	</colgroup>
	<tbody>
		<tr>
			<th>충전</th><td>ShoppingMall</td>
		</tr>
		<tr>
			<th>현재금액</th><td><fmt:formatNumber pattern="###,###,###" value="${member.point }"></fmt:formatNumber> 원</td>
		</tr>
		<tr>
			<th>이름</th><td><input type="text" id="name" value='<c:out value="${member.name }"/>'></td>
		</tr>
		<tr>
			<th>이메일</th><td><input type="text" id="email" value='<c:out value="${member.email }"/>'></td>
		</tr>
		<tr>
			<th>핸드폰</th><td><input type="text" id="tel" value='<c:out value="${member.phone }"/>'></td>
		</tr>
		<tr>
			<th>주소</th><td><input type="text" id="addr" value='<c:out value="${member.addr1 }"/><c:out value="${member.detailAddr }"/>'></td>
		</tr>
		<tr>
			<th>결제방법</th><td>신용카드</td>
		</tr>
		<tr>
			<th>결제금액</th>
			<td>
				<select class="cp_item">
						<option value="">선택</option>
				<c:forEach var="detailCodeList" items="${detailCodeList }" varStatus="i">	
						<option value="${detailCodeList.det_Code_Id }">${detailCodeList.det_Code_Nm }</option>
				</c:forEach>
            </td>
        </tr>
    </tbody>	        
 </table>
  			<div>
                <button type="button" class="btn btn-lg btn-block btn-info  btn-custom" id="charge">충 전 하 기</button>
                <button type="button" class="btn btn-lg btn-block  btn-custom" onclick="frameClose();">닫 기</button>
            </div>
</div>
</body>
</html>
<script>
    $('#charge').click(function () {
        // getter
        if($('#name').val() == null || $('#name').val() ==""){
        	alert("이름을 입력하세요");
        	return;
        }
        if($('#email').val() == null || $('#email').val() ==""){
        	alert("이메일을 입력하세요");
        	return;
        }
        if($('#tel').val() == null || $('#tel').val() ==""){
        	alert("핸드폰을 입력하세요");
        	return;
        }
        if($('#addr').val() == null || $('#addr').val() ==""){
        	alert("주소를 입력하세요");
        	return;
        }
        if($('.cp_item').val() == null || $('.cp_item').val() == ""){
        	alert("결제금액을 선택하세요");
        	return;
        }
        
        var IMP = window.IMP;
        IMP.init('imp69550409');
        var money = $('.cp_item').val();
		
        
        IMP.request_pay({
            pg: 'danal',
            merchant_uid: 'merchant_' + new Date().getTime(),
			pay_method : 'card',
            name: 'ShoppingMall 충전금액',
            amount: money,
            buyer_email: $('#email').val(),
            buyer_name: $('#name').val(),
            buyer_tel: $('#tel').val(),
            buyer_addr: $('#addr').val(),
            buyer_postcode: '123-456'
        }, function (rsp) {
            console.log(rsp);
            if (rsp.success) {
                var msg = '결제가 완료되었습니다.';
                msg += '고유ID : ' + rsp.imp_uid;
                msg += '상점 거래ID : ' + rsp.merchant_uid;
                msg += '결제 금액 : ' + rsp.paid_amount;
                msg += '카드 승인번호 : ' + rsp.apply_num;
                $.ajax({
                    type: "post", 
                    url: "/member/point", //충전 금액값을 보낼 url 설정
                    data: {
                        amount : money,
                        mberId : '<c:out value="${member.mberId }"/>'
                    },
                    success : function(data){
                    	if(data.result == "success"){
                    		alert(msg);
                    		frameClose();
                    	}
                    }
                });
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                alert(msg);
            }
        });
    });
    
    function frameClose(){
    	opener.parent.location.reload();
    	window.close();
    	self.close();
    		
    }
    
    
</script>