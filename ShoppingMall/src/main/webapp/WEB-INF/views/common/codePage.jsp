<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<style>



</style>
<div>
		<iframe id="cmmnList" src="/common/cmmnList" style="width: 50%; height: 500px; display: inline-block; float: left;"></iframe>
		<iframe id="cmmnCode" src="/common/cmmnCode" scrolling="no" style="width: 50%; height: 500px; display: inline-block; float: left;" ></iframe> 
		<iframe id="detailList" src="/common/detailList" style="width: 50%; height: 500px; display: inline-block; float: left;"></iframe>
		<iframe id="detailCode" src="/common/detailCode" style="width: 50%; height: 500px; display: inline-block; float: left;"></iframe> 
</div>

<script>

	test = function(e){
		document.getElementById("cmmnCode").src = "cmmnCode.html?code_Id="+e+" ";
		document.getElementById("detailList").src = "detailList.html?code_Id="+e+" ";
	}
	
	test2 = function(e){
		document.getElementById("detailCode").src = "detailCode.html?det_Code_Id="+e+" ";
	}
</script>