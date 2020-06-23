<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>News-Administrator</title>
  <link rel="shortcut icon" href="../pic/logoxh.ico" type="image/x-icon">
  <link rel="stylesheet" href="../layui/css/layui.css" media="all">
  <script src="../js/jquery-3.2.1.js" ></script>
  <script src="../layui/layui.js" charset="utf-8"></script>
  
  <style type="text/css">
  	a:hover{
  		text-decoration: none !important;
  	}
  	#layui-layer1{
  		overflow: hidden;
  	}
  	
  </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">新闻系统后台</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a href="../index.jsp">首页</a></li>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <img src="../pic/userimg.png" class="layui-nav-img">
          <span class="username"></span>
        </a>
        <dl class="layui-nav-child" style="z-index: 11;">
          <dd><a href="javascript:0;" onclick="showuserinfo()">基本资料</a></dd>
          <dd><a href="">安全设置</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="../loginout.do">退出账号</a></li>
    </ul>
  </div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  >
      	<li class="layui-nav-item">
          <a href="javascript:0;">个人</a>
          <dl class="layui-nav-child">
            <dd ><a class="general" href="javascript:0;">个人信息</a></dd>
          </dl>
        </li>
        <c:if test="${Newsuser.level==1 && Newsuser.status=='on'}">
	        <li class="layui-nav-item">
	          <a href="javascript:0;">记者</a>
	          <dl class="layui-nav-child">
	            <dd><a class="reporter" href="javascript:0;">新闻发布</a></dd>
	            <dd><a class="mynews" href="javascript:0;">我的新闻</a></dd>
	          </dl>
	        </li>
        </c:if>
        
        
        <c:if test="${Newsuser.level==2 && Newsuser.status=='on'}">
        <li class="layui-nav-item">
          <a href="javascript:0;">主编</a>
          <dl class="layui-nav-child">
            <dd><a class="editor" href="javascript:0;">新闻审核</a></dd>
            <dd><a class="applytorepoter" href="javascript:0;">记者申请</a></dd>
          </dl>
        </li>
        </c:if>
        <c:if test="${Newsuser.level==3}">
	        <li class="layui-nav-item">
	          <a href="javascript:0;">超级管理员</a>
	          <dl class="layui-nav-child">
	            <dd><a class="admin" href="javascript:0;">用户管理</a></dd>
	            <dd><a class="applytoeditor" href="javascript:0;">主编申请</a></dd>
	            <!-- <dd><a href="javascript:0;">列表二</a></dd>
	            <dd><a href="javascript:0;">列表三</a></dd>
	            <dd><a href="javascript:0;">超链接</a></dd> -->
	          </dl>
	        </li>
        </c:if>
      </ul>
    </div>
  </div>
  
  <!-- 内容主体区域 -->
	<div class="layui-body">
		<div id="body_div" style="width:100%;height:96%;padding: 15px 15px;">
			<div style="width:100%;height:100%;background: url('../pic/adminwelcome.png');">
			</div>
		</div>
	</div>

	<div class="layui-footer">
    <!-- 底部固定区域 -->
    ©呆呆Yun
  </div>
</div>

<script>

//JavaScript代码区域
layui.use(['layer', 'form', 'element'], function(){
    var layer = layui.layer
        ,form = layui.form
        ,element = layui.element;
        element.init();
        form.render();
});

function showuserinfo(){
	$("#body_div").load("userinformation2.jsp");
}

$(function(){
	$(".general").click(function(){
		$("#body_div").load("userinformation2.jsp");
	})
	$(".reporter").click(function(){
		$("#body_div").load("sendnews.jsp");
	});
	$(".mynews").click(function(){
		$("#body_div").load("mynews.jsp");
	});
	$(".editor").click(function(){
		$("#body_div").load("checknews.jsp");
	});
	$(".admin").click(function(){
		$("#body_div").load("useradmin.jsp");
	});
	$(".applytorepoter").click(function(){
		$("#body_div").load("apply.jsp?applylevel=1");
	})
	$(".applytoeditor").click(function(){
		$("#body_div").load("apply.jsp?applylevel=2");
	})
	
});

</script>
</body>
</html>
