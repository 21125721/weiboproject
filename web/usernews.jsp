<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/home.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="css/news.css">
    <script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="js/home.js"></script>
    <link href="layui/css/layui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="layui/layui.js"></script>
<style type="text/css"> 
	p{
		font-size:18px;
	}
	.main *{
		color:white !important;
	}
</style>
</head>
<body>
<c:import url="top.jsp"></c:import>
	<div style="width:71%;margin:100px auto;">
	    <div id="comment_divl">
	    	<div style="width:50%;margin:-35px auto;margin-left:65px;">
	    		<a>
	    			<img src="pic/userimg.png" width="70px" height="70px">
	    		</a>
	    	</div>
	    	<div style="margin-top:70px;text-align: center;">
	    		<a href="javascript:0;">${user.nickname}</a>
	    		<hr class="comment_divl_hr">
	    	</div>
	    	<div style="margin:10px auto;">
	    		<div class="comment_divl_divl">
	    			<a href="usernews.do?uid=${user.userid}"><h3>${usernewscount}</h3></a>
	    			<a href="usernews.do?uid=${user.userid}">文章</a>
	    		</div>
	    		<div class="comment_divl_divr">
	    			<h3>753亿</h3>
	    			<a>总阅读</a>
	    		</div>
	    		<div style="clear: both;"></div>
	    	</div>
	    </div>
	</div>	
	<div class="newsContent" style="width:60%;background: white;padding:0;">
		<c:forEach items="${newslist}" var="news">
	        <div class="newsCards">
	            <div class="cardsImg">
	                <a href="${pageContext.request.contextPath}/news.do?nid=${news.newsid}"><img src="pic/news.jpg" alt="${news.title}"></a>
	            </div>
	            <div class="cardsdiv" style="width:74%;text-align: left;">
		            <h2><a style="font-size:24px;" href="${pageContext.request.contextPath}/news.do?nid=${news.newsid}">${news.title}</a></h2>
		            <p><a style="font-size:16px;" href="${pageContext.request.contextPath}/news.do?nid=${news.newsid}">${news.synopsis}</a></p>
	        	</div>
	        </div>
	    </c:forEach>
	</div>    
</body>
</html>