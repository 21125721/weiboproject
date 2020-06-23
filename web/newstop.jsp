<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Head</title>
<script src="js/popper.min.js"></script>
	<link rel="stylesheet" href="css/topstyle.css"> 
	<link rel="stylesheet" href="layui/css/layui.css"> 
	<script src="js/jquery-3.2.1.js"></script>
	<script src="layui/layui.js" ></script>
    <link href="css/home.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    	function showlogin(){
    		$(".login_childdiv").toggle();
    	}
    	$(function(){
    		if("${username}"!=""){
    			$(".regist_div").hide();
    			$('.login_div').hide();
    			$('.user_div').show();
    		}
    	});
    </script>
</head>
<body>
<!-- 标题栏 -->
    <div class="menuBar">
        <div id="menu2" class="menu">
            <a href="index.jsp">
                   <img src="images/news.png" alt="X-News">
            </a>
            <ul>
                <li>
                    <a href="index.jsp">首页</a>
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
        
       
        <div class="login_parent">
            <svg height="40" width="200" xmlns="http://www.w3.org/2000/svg">
                <rect id="shape" height="40" width="200" />  <!-- 创建一个矩形 -->
                <div id="text">
                	<div class="user_div" >
	                	<a href="admin/administrator.jsp">
	    					<img src="pic/userimg.png" class="layui-nav-img">
	    					<span class="username">${Newsuser.nickname}</span>
	    					</a>
	    					<dl class="layui-nav-child layui-anim layui-anim-upbit">
					          <dd><a href="">基本资料</a></dd>
					          <dd><a href="">安全设置</a></dd>
					        </dl>
	    					<ul style="background:white;" class="quitlogin_div">
	    						<li style="width:98%;"><a target="_blank" href="userinfo.jsp">个人中心</a></li>
	    						<li style="width:98%;"><a href="javascript:0;" onclick="loginout()">退出登录</a></li>
	    					</ul>
    				</div>
                	<div class="login_div"  style="display:inline-block;position: relative;">
                		<div>
	                		<a href="javascript:0;" onclick="showlogin()" class="logintop_a"><span class="spot"></span>登录</a><a style="color:white;"> /</a>
	                		<div class="login_childdiv"   style="position: absolute;width:330px;height:300px;right:-145px;top:40px;">
	                			<div style="width:246px;height:300px;">
									<div class="login">
										<form id="form_signin" action="login.do" method="post">
											<ul>
												<li class="login_li" style="margin-top:10px;">
													<a class="login_a"  href="javascript:0;">账号登录</a> 
													<div style="width:220px;margin:0 auto;">
														<a id="error_a" style="font-size:14px;color:red; width:100%;display: inline-block;"></a>
													</div>
												</li>
											</ul>
											<input type="text" id="username" name="username" class="form-control" placeholder="用户名" required autofocus>
											<input type="password" id="inputPassword"  name="pwd" class="form-control" placeholder="密码" required>
											<input type="text" id="checkcode" name="checkcode" class="form-control" placeholder="验证码" required> 
									 		<img id="checkcodeimg" alt="验证码" src="checkcode.do" onclick='this.src="${pageContext.request.contextPath}/checkcode.do?time="+new Date().getTime()'/>
									 		<!-- <div style="margin-left: 19px; margin-top: -10px;">
												<label> 
													<input type="checkbox" value="remember-me" style="width: 14px;" /> 
													<a style="margin-left: -4px;color:blue; font-size: 12px;">记住密码</a>
												</label> 
													<a href="#" class="forgetpwd" style="margin-left: 87px; font-size: 12px; text-decoration: none;">忘记密码？</a>
											</div> -->
											<input type="button" onclick="login()" style="width: 200px;height: 30px;line-height: 10px;background:#007bff;" class="btn btn-lg btn-primary btn-block" value="登录" /> 
											<input type="reset" style="width: 200px; height: 30px;line-height: 10px;background:#007bff;" class="btn btn-lg btn-primary btn-block" value="取消" />
										</form>
									</div>
								</div>
	                		</div>
	                		</div>
	                	</div>
                	<div class="regist_div" style="display:inline-block;">
                		<a href="regist.jsp"  class="registtop_a" target="_blank"><span class="spot"></span>注册</a>
                	</div>
                </div>
            </svg>
        </div>
    </div>
</body>
<script type="text/javascript">
//按下回车登录
$('.login_div').bind('keypress',function(event){
    if(event.keyCode == "13") {
    	login();
    }
});
function login(){
	$.post("${pageContext.request.contextPath}/login.do",$('#form_signin').serialize(),function(data){
		if(data == 2){
			$("#error_a").text("验证码错误");
			$("#checkcodeimg").click();
		}else if(data == 1){
			$("#error_a").text("用户名密码错误");
			$("#checkcodeimg").click();
		}else{
			$(".regist_div").hide();
			$('.login_div').hide();
			$('.user_div').show();
			$('.username').text(data.nickname);
			location.reload();
		}
	});
}
function loginout(){
	$.post("${pageContext.request.contextPath}/loginout.do",function(){
		$(".regist_div").show();
		$('.login_div').show();
		$('.user_div').hide();
		location.reload();
	})
}
</script>
</html>