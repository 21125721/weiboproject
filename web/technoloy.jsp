 <%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html;" />
    <title>News-Technology</title>
    <link href="css/home.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="css/sports.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="js/home.js"></script>
</head>

<body>
    <c:import url="top.jsp"></c:import>
    <div style="width:70%;background:light-white;margin:0 auto;box-shadow: 0px 0px 10px 0px;padding:1px 1px;margin-top:50px;">
	    <div class="channel">
	        <div class="logo"><img src="images/technology.png" style="border-color: #1296db"></div>
	        <div class="channelName" style="color: #1296db">科技频道</div>
	        <hr style="background-color: #999999">
	        <h2>科学的永恒性就在于坚持不懈地寻求之中，科学就其容量而言，是不枯竭的，就其目标而言，是永远不可企及的。</h2>
	    </div>
	    <div class="mainContent" id="mainContent"  style="width: 90%;margin:0 auto;">
	        <c:forEach items="${typenewslist}" var="typenews">
		        <div class="newsCards">
		            <div class="cardsImg">
		                <a href="${pageContext.request.contextPath}/news.do?nid=${typenews.newsid}"><img src="pic/news.jpg" alt="${typenews.title}"></a>
		            </div>
		            <div class="cardsdiv">
			            <h2><a href="${pageContext.request.contextPath}/news.do?nid=${typenews.newsid}">${typenews.title}</a></h2>
			            <p><a href="${pageContext.request.contextPath}/news.do?nid=${typenews.newsid}">${typenews.synopsis}</a></p>
		        	</div>
	        	</div>
	        </c:forEach>
	    </div>
	    <div style="clear: both;"></div>
	  </div>
    <div class="copyright"> ©2019 News-Team All rights reserved.</div>
</body>

</html>
    