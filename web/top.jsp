<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Head</title>
	<script src="js/popper.min.js"></script>
	<%--<link rel="stylesheet" href="css/topstyle.css"> --%>
	<link rel="stylesheet" href="layui/css/layui.css"> 
	<script src="js/jquery-3.2.1.js"></script>
	<script src="layui/layui.js" ></script>
    <link href="css/home.css" rel="stylesheet" type="text/css" />
	<script src="js/home.js"></script>
    <script type="text/javascript">
    	function showlogin(){
    		$(".login_childdiv").toggle();
    	}
    	$(function(){
    		if("${userName}"!=""){
    			$(".regist_div").hide();
    			$('.login_div').hide();
    			$('.user_div').show();
    		}
    	});
    </script>
	<style>
		.top_ul li{
			background: #64b1db;
		}
		.top_ul li a{
			color: white !important;
		}
	</style>
</head>
<body>
<!-- 标题栏 -->
    <div class="menuBar" style="background: #64b1db;">
        <div id="menu2" class="menu">
            <a href="index.jsp">
                   <img src="images/news.png" alt="X-News">
            </a>
            <ul class="top_ul">
                <li>
                    <a href="index.jsp">首页</a>
                </li>
                <li>
                    <a href="javascript:void(0);">体育</a>
                </li>
                <li>
                    <a href="javascript:void(0);">科技</a>
                </li>
                <li>
                    <a href="javascript:void(0);">娱乐</a>
                </li>
                <li>
                    <a href="javascript:void(0);">时政</a>
                </li>
                <li>
                    <a href="javascript:void(0);">观点</a>
                </li>
                <li>
                    <a href="javascript:void(0);" onclick="owner()">关于</a>
                </li>
            </ul>
        </div>
        
       
        <div class="login_parent" style="background: #64b1db;">
            <svg height="40" width="200" xmlns="http://www.w3.org/2000/svg">
                <rect id="shape" height="40" width="200" />  <!-- 创建一个矩形 -->
                <div id="text">
                	<div class="user_div" >
                		<a id="usera" href="userinfo.jsp">
    						<img src="pic/userimg.png" class="layui-nav-img">
    						<span id="username" style="color:white;">${User.luckyName}</span>
    					</a>
    					<ul style="background:white;" class="quitlogin_div">
    						<li style="width:98%;"><a target="_blank" href="userinfo.do">个人中心</a></li>
    						<li style="width:98%;"><a href="${pageContext.request.contextPath}/loginout.do">退出登录</a></li>
    					</ul>
    				</div>
                	<div class="login_div"  style="display:inline-block;position: relative;">
                		<div>
	                		<a href="javascript:0;" onclick="showlogin()" class="logintop_a" style="color:white;"><span class="spot"></span>登录</a><a style="color:white;"> /</a>
	                		<div class="login_childdiv"   style="position: absolute;width:330px;height:300px;right:-145px;top:40px;">
	                			<div style="width:246px;height:300px;">
									<div class="login">
										<form id="form_signin" action="" method="">
											<ul>
												<li class="login_li" style="margin-top:10px;">
													<a class="login_a"  href="javascript:0;">账号登录</a> 
													<div style="width:220px;margin:-10px auto;">
														<a id="error_a" style="font-size:14px;color:red; width:100%;display: inline-block;">${userlogin}</a>
													</div>
												</li>
											</ul>
											<input type="email" id="username" name="userName" class="form-control" placeholder="邮箱" required autofocus>
											<input type="password" style="margin:10px auto;" id="inputPassword"  name="upwd" class="form-control" placeholder="密码" required >
											<input id="loginbutton" type="button" onclick="login()" style="margin:0 auto;width: 200px;height: 30px;line-height: 10px;background:#007bff;" class="btn btn-lg btn-primary btn-block" value="登录" />
											<input type="reset" style="margin:5px auto 0;width: 200px; height: 30px;line-height: 10px;background:#007bff;" class="btn btn-lg btn-primary btn-block" value="取消" />
										</form>
									</div>
								</div>
	                		</div>
	                		</div>
	                	</div>
                	<div class="regist_div" style="display:inline-block;">
                		<a href="regist.jsp" style="color:white;" class="registtop_a" target="_blank"><span class="spot"></span>注册</a>
                	</div>
                </div>
            </svg>
        </div>
    </div>
</body>
<script type="text/javascript">
layui.use(['form', 'layedit', 'laydate'], function(){
	  var form = layui.form
	  ,layer = layui.layer
	  ,layedit = layui.layedit
	  ,laydate = layui.laydate;
	});
//按下回车登录
$('.login_div').bind('keypress',function(event){
    if(event.keyCode == "13") {
    	login();
    }
});

//登录
function login(){
	$.post("${pageContext.request.contextPath}/login.do",$('#form_signin').serialize(),function(data){
		if(data == 1){
			$("#error_a").text("用户名或密码错误");
			$("#checkcodeimg").click();
		}else if(data == 0){
			$("#error_a").text("请填写完整");
			$("#checkcodeimg").click();
		}else{
			$(".regist_div").hide();
			$('.login_div').hide();
			$('.user_div').show();
			$("#username").text(data.luckyName);
			window.location.reload();
		}
	});
}

function owner(){
	layer.open({
	        type: 1
	        ,offset: 't' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
	        ,id: 'layerDemo' //防止重复弹出
	        ,title:'联系我'
	        ,content: '<div style="padding:1px 1px;">'
	        			+'<img style="width:300px;height:300px;display:inline-block;" src="pic/wechatimg.jpg">'
	        			+'</div>'
	        ,btn: '关闭'
	        ,btnAlign: 'c' //按钮居中
	        ,shade: 0.7 //不显示遮罩
	        ,yes: function(){
	          layer.closeAll();
	        }
	      });
}
</script>
</html>