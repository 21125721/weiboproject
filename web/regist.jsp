<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>注册</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="layuiadmin/style/admin.css" media="all">
  <link rel="stylesheet" href="layuiadmin/style/login.css" media="all">
	<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
	<style type="text/css">
		.layadmin-user-login {
			padding:30px 0;
		}
		input[type=date]::-webkit-inner-spin-button {
			visibility: hidden;
		}
	</style>
</head>
<body>


  <div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">
    <div class="layadmin-user-login-main" style="margin: 100px auto;">
      <div class="layadmin-user-login-box layadmin-user-login-header">
        <h2>注册</h2>
        <p><a href="index.jsp">首页</a></p>
      </div>
        <form action="${pageContext.request.contextPath}/register.do" method="post">
			<div style="width:100%;;text-align: center;">
				<font color="red">${userName}${repwd}</font>
			</div>
			<div class="layui-form-item">
				<input type="email" name="userName" id="LAY-user-login-email" lay-verify="required" placeholder="邮箱" class="layui-input" required="required">
			</div>
	        <div style="width:100%;;text-align: center;">
	        	<font color="red">${errormap.nickname}</font>
	        </div>
	        <div class="layui-form-item">
	          	<input type="text" name="luckyName" id="LAY-user-login-nickname" lay-verify="nickname" placeholder="昵称" class="layui-input" required="required">
	        </div>

	        <div class="layui-form-item">
	          <input type="password" name="upwd" id="LAY-user-login-password" lay-verify="pass" placeholder="密码" class="layui-input" required="required">
	        </div>
	        <div class="layui-form-item">
	          <input type="password" name="repwd" id="LAY-user-login-repass" lay-verify="required" placeholder="确认密码" class="layui-input" required="required">
	        </div>
	        <%--<div class="layui-form-item">
	          <div class="layui-row">
	            <div class="layui-col-xs7">
	              <input type="text" name="checkcode" id="LAY-user-login-vercode" lay-verify="required" placeholder="验证码" class="layui-input" required="required">
	            </div>
	            <div class="layui-col-xs5">
	              <div style="margin-left: 10px;">
	                <img id="checkcodeimg" width="130px" height="38px" alt="验证码" src="/checkcode.do" onclick='this.src="/checkcode.do?time="+new Date().getTime()'/>
	              </div>
	            </div>
	          </div>
	        </div>
	        <div class="layui-form-item">
	          <input type="checkbox" name="agreement" lay-skin="primary" title="同意用户协议" checked>
	        </div>--%>
	        <div class="layui-form-item">
	          <button id="regist_button" class="layui-btn layui-btn-fluid" type="submit" lay-filter="LAY-user-reg-submit">注 册</button>
	        </div>
	        <div class="layui-trans layui-form-item layadmin-user-login-other">
	          <label>社交账号注册</label>
	          <a href="javascript:0;"><i class="layui-icon layui-icon-login-qq"></i></a>
	          <a href="javascript:0;"><i class="layui-icon layui-icon-login-wechat"></i></a>
	          <a href="javascript:0;"><i class="layui-icon layui-icon-login-weibo"></i></a>
	          <a href="index.jsp" class="layadmin-user-jump-change layadmin-link layui-hide-xs">用已有帐号登入</a>
	          <a href="index.jsp" class="layadmin-user-jump-change layadmin-link layui-hide-sm layui-show-xs-inline-block">登入</a>
	        </div>
        </form>
      </div>
    </div>
    
  </div>

  <script src="layui/layui.js"></script>  
  <script>
  layui.config({
    base: 'layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'user'], function(){
    var $ = layui.$
    ,setter = layui.setter
    ,admin = layui.admin
    ,form = layui.form
    ,router = layui.router();

    form.render();

    //提交
    form.on('submit(LAY-user-reg-submit)', function(obj){
      var field = obj.field;
      
      //确认密码
      if(field.pwd !== field.repass){
        return layer.msg('两次密码输入不一致');
      }
      
      //是否同意用户协议
      if(!field.agreement){
        return layer.msg('你必须同意用户协议才能注册');
      }
      
      /* //请求接口
      admin.req({
        url: 'regist.do' //实际使用请改成服务端真实接口
        ,data: field
        ,done: function(res){        
          layer.msg('注册成功', {
            offset: '15px'
            ,icon: 1
            ,time: 1000
          }, function(){
            location.hash = 'home.jsp'; //跳转到登入页
          });
        }
      }); */
      
      return false;
    });
  });
</script>
</body>
</html>
