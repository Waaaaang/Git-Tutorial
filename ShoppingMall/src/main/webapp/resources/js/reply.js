//장소게시판 리뷰 댓글
var replyService = (function(){
	//댓글 등록
	function add(reply, callback, error){
		
		$.ajax({
			type : 'post',
			url : '/reply/insert',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {//xhr:객체	
				if (error) {
				error(er);
				}
			}
		});
	}	
	
	//댓글 목록
	function getList(param, callback, error){
		var gdsNo = param.gdsNo;
		var page = param.page || 1; //댓글 페이지 목록

		$.getJSON("/reply/pages/" + gdsNo + "/" + page + ".json",
			function(data){
				if(callback){
					callback(data.replyCnt, data.list);
				}
			}).fail(function(xhr, status, err){
			if(error) {
			error();
			}
		});
	}
	
	//댓글 삭제
	function remove(replyNo, firstRegId, callback, error){
		
		$.ajax({
			type : 'delete',
			url : '/reply/' + replyNo,
			data : JSON.stringify({replyNo:replyNo, firstRegId:firstRegId}),
			contentType : "application/json; charset=utf-8",
			success : function(deleteResult, status, xhr) {
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
				error(er);
				}
			}
		});
	}
	
	//댓글 수정
	function update(reply, callback, error){	
		$.ajax({
			type : 'put',
			url : '/reply/' + reply.replyNo,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
				error(er);
				}
			}
		});
	}
	
	//댓글 상세보기
	function get(replyNo, callback, error) {
		$.get("/reply/" + replyNo + ".json", function(result){
			if(callback){
					callback(result);
				}
		}).fail(function(xhr, status, error) {
			if (error) {
				error();
			}
		});
	}
	
	//댓글 시간
	function displayTime(timeValue){
		var today = new Date();
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		
		//하루 이내 댓글
		if(gap < (1000 * 60 * 60 * 24)){
		
		var hh = dateObj.getHours();
		var mi = dateObj.getMinutes();
		var ss = dateObj.getSeconds();
		//시/분/초
		return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0')+ mi,':',(ss > 9 ? '' : '0') + ss].join('');
		} else {//연/월/일	
		var yy = dateObj.getFullYear();
		var mm = dateObj.getMonth() + 1;
		var dd = dateObj.getDate();		
		return [ yy, '/', (mm > 9 ? '' : '0') + mm,'/',(dd > 9 ? '' : '0') + dd].join('');
	}
};
	return {
		add:add,
		getList:getList,
		remove:remove,
		update:update,
		get:get,
		displayTime:displayTime
		};
})();
