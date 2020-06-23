<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/bootstrap.css"> 
<link rel="stylesheet" href="css/topstyle.css"> 
<script src="js/jquery-3.2.1.js"></script>
</head>
<body>
<div style="width:246px;height:300px;background:red;">
	<div class="login">
		<form class="form-signin" action="login.action" method="post">
			<ul>
				<li class="login_li" style="margin-top:10px;">
					<a class="login_a"  href="javascript:0;">账号登录</a> 
					<div style="width:220px;margin:0 auto;">
						<div class="login_linediv login_linediv_left" style="margin-left:6px;"></div>
						<div class="login_linediv login_linediv_right" style="margin-left:-2px;"></div>
					</div>
				</li>
			</ul>
			<input type="text" id="username" name="username" class="form-control" placeholder="用户名" required autofocus>
			<input type="password" id="inputPassword"  name="pwd" class="form-control" placeholder="密码" required>
			<input type="text" id="checkcode" name="checkcode" class="form-control" placeholder="验证码" required> 
	<!-- 		<img alt="验证码" src="checkcode.do" onclick='this.src="checkcode.do?"+Math.random()' />
	 -->		<div style="margin-left: 19px; margin-top: -10px;">
				<label> 
					<input type="checkbox" value="remember-me" style="width: 14px;" /> 
					<a style="margin-left: -4px;; font-size: 12px;">记住密码</a>
				</label> 
					<a href="#" class="forgetpwd" style="margin-left: 87px; font-size: 12px; text-decoration: none;">忘记密码？</a>
			</div>
			<input type="submit" style="width: 200px; height: 30px;line-height: 14px;"
				class="btn btn-lg btn-primary btn-block" value="登录" /> 
			<input type="reset" style="width: 200px; height: 30px;line-height: 14px;"
				class="btn btn-lg btn-primary btn-block" value="取消" /><br />
		</form>
	</div>
</div>
</body>
</html>