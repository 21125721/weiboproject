<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <title></title>
 <link href="css/finish.css" rel="stylesheet" type="text/css" />
</head>
<body>
 <div id="menuBar">
    <div id="menu2" class="menu"><img src="images/news.png">
        <ul>
                <li>
                    <a href="home.jsp">首页</a>
                </li>
                <li>
                    <a href="sports.jsp">体育</a>
                </li>
                <li>
                    <a href="technoloy.jsp">科技</a>
                </li>
                <li>
                    <a href="entertainment.jsp">娱乐</a>
                </li>
                <li>
                    <a href="politics.jsp">时政</a>
                </li>
                <li>
                    <a href="views.jsp">观点</a>
                </li>
        </ul>
    </div>
    <div id="content">
        <ul id="ul1">
            <li><div class="step">1</div>   填写信息</li>
            <li><div class="step">2</div>验证</li>
            <li><div class="step">3</div>   注册成功</li>
        </ul>
        <div id="finish">
        <a href="home.jsp" class="link">注册成功！现在你可以尽情的浏览获取最新资讯！</a>
        </div>
    </div>
    <div id="bottom">©2017 News-Team All rights reserved.</div>
 </div>
 <script src="js/jquery-3.2.1.min.js"></script>
 <script src="js/home.js">
    </script>
</body>
    <script type="text/javascript">
        var step=document.getElementsByClassName('step');
        var content=document.getElementById('content');
        var finish=document.getElementById('finish');
        var btn=document.getElementById('btn');
        var li=content.getElementsByTagName('ul')[0].getElementsByTagName('li');
        li[2].style.color='black';
        step[2].style.background='#33cc66';
        
    </script>
</html>