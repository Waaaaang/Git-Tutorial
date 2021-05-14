//장소게시판 리뷰 댓글
var detailService = (function(){
	
	//목록
	function getList(param, callback, error){
		var code_Id = param.code_Id;
		var page = param.page || 1; // 페이지 목록

		$.getJSON("/common/detailList/" + code_Id + "/" + page + ".json",
			function(data){
				if(callback){
					callback(data.codeCnt, data.list);
				}
			}).fail(function(xhr, status, err){
			if(error) {
			error();
			}
		});
	}
	
	//시간
	function displayTime(timeValue){
		var today = new Date();
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		
		//연/월/일	
		var yy = dateObj.getFullYear();
		var mm = dateObj.getMonth() + 1;
		var dd = dateObj.getDate();		
		return [ yy, '-', (mm > 9 ? '' : '0') + mm,'-',(dd > 9 ? '' : '0') + dd].join('');
	};
	
	return {
		getList:getList,
		displayTime:displayTime
		};
})();
