<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/5/18
  Time: 19:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/register.do" method="post">
    <a>邮箱：</a><input type="email" name="userName" /><br />
    <a>昵称：</a><input type="text" name="luckyName" /><br />
    <a>密码：</a><input type="password" name="upwd" /><br />
    <input type="submit" value="提交" />
</form>
</body>
</html>
