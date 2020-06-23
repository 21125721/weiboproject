<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html >
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="logo" href="images/logo.png">
    <title>登录</title>
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/signin.css" rel="stylesheet">
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
 	<style type="text/css">
 		#checkcode{
 			margin-top:-10px;
 			margin-bottom: 10px;
 			margin-left:-4px;
 			width:78%;
 			display: inline-block;
 		}
 		#username{
 			margin-top: 6px;
 		}
 		.forgetpwd{
 			margin-left:100px;
 			color:blue;
 		}
 	</style>
  </head>
 
  <body class="text-center">
    <div class="container" style="width:64%">
      <form class="form-signin" action="index.jsp" method="get">
        <h2 class="form-signin-heading">登录</h2>
        <a href="regist.html" style='color: blue;font-size: 14px;' >注册账号</a>
        <label for="username" class="sr-only">用户名</label>
        <input type="text" id="username" class="form-control" placeholder="用户名" required autofocus>
        <label for="inputPassword" class="sr-only">密码</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="密码" required>
        <label>
            <input type="checkbox" value="remember-me"> 记住密码
            <a href="#" class="forgetpwd"> 忘记密码</a>
        </label>
        <button class="btn btn-lg btn-primary btn-block" id="check" type="submit">登录</button>
        <button class="btn btn-lg btn-primary btn-block" id="reset" type="reset">取消</button>
      </form>
    </div> 
  </body>
</html>