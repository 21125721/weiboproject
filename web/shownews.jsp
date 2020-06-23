<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
<script type="text/javascript">
	$(function(){
		$.post("${pageContext.request.contextPath}/showallNews.do");
	})
</script>
</head>
<body>
	<c:forEach items="${list}" var="news">
		<div style="text-align: center;">
			<p style="font-size: 20px;">${news.title}</p>
		</div>
		<p>${news.article}</p>
	</c:forEach>
</body>
</html>