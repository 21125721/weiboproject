<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="translated-ltr"><head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>个人中心</title>
    <link rel="stylesheet" href="css/base.css" type="text/css" />
    <link rel="stylesheet" href="css/common-less(1).css" type="text/css" />
    <link rel="stylesheet" href="css/moco.min.css" type="text/css" />
    <link rel="stylesheet" href="css/common-less.css" type="text/css" />
    <link rel="stylesheet" href="css/profile-less.css" type="text/css" />
    <link rel="stylesheet" href="layui/css/layui.css" type="text/css" />
    <script type="text/javascript" src="layui/layui.js"></script>
    <script type="text/javascript" src="js/jquery-3.2.1.js"></script>
    <style>
    .title{
		width:400px;
		height:30px;
		margin-top:50px;
	}
	.test{
		height:320px;
		margin-top:50px;
	
	}
	.button{
		margin-top:50px;
	}
	.username{
		color:white;
	}
    </style>
<script type="text/javascript">
	$(function(){
		if("${username}"!=""){
			$(".regist_div").hide();
			$('.login_div').hide();
			$('.user_div').show();
		}
	});
</script>
<script src="layui/layui.js"></script>
<link rel="stylesheet" href="layui/css/layui.css">    
<link type="text/css" rel="stylesheet" href="//statics.itc.cn/pc/ucenter/static/css/main-84d99eacb9.css">
</head>
<body>
<c:import url="top.jsp"></c:import>
<div class="wrapper-box">

    <div style="position:fixed;top:40px;left:0;height:20px;width:100%;background:#F3F2F0;z-index:100;display:none;"></div>
    <div class="area clearfix">
<div class="main" style="margin-top:60px;">
	<div id="main">
    <div class="page-settings">
        <div class="setting pb10">
            <div class="nav-tabs pa">
                <h2 class="baseinfo fl active">基本信息</h2>
                <div class="cb"></div>
            </div>
            <div class="contentBox">
                <div class="formBox">
                    <div id="setting-profile" class="setting-wrap setting-profile">
                        <form id="profile" >
							<div class="wlfg-wrap clearfix">
                            	<label class="label-name h16 lh16" >状态：</label>
                                <div class="rlf-group rlf-radio-group">
									<c:if test="${ouser.status =='on'}">
		                                <label  class="lh16"><a class="layui-btn layui-btn-xs" >激活</a></label>
		                            </c:if>
		                            <c:if test="${ouser.status =='off'}">
		                                <label  class="lh16"><a class="layui-btn layui-btn-danger layui-btn-xs" >封禁中</a></label>
		                            </c:if>
	                            </div>
                            </div>
                            <div class="wlfg-wrap clearfix">
                                <br /><label class="label-name" for="nick" >昵称：</label>
                                <div class="rlf-group">
                                    <span class="moco-form-control">${ouser.nickname}</span>
                                    <p class="rlf-tip-wrap errorHint color-red" ></p>
                                </div>
                            </div>
                            
                            <div class="wlfg-wrap clearfix">
                                <label class="label-name h16 lh16" >性别：</label>
                                <div class="rlf-group rlf-radio-group">
                                	<c:if test="${ouser.gender =='男'}">
                                    <label  class="lh16"><input type="radio" value="男" name="gender" checked="checked" disabled="disabled">男</label>
                                    <label  class="lh16"><input type="radio" value="女" name="gender"  disabled="disabled">女</label>
                                    </c:if>
                                    <c:if test="${ouser.gender =='女'}">
                                    <label  class="lh16"><input type="radio" value="男" name="gender"  disabled="disabled">男</label>
                                    <label  class="lh16"><input type="radio" value="女" name="gender" checked="checked"  disabled="disabled">女</label>
                                    </c:if>
                                    <p class="rlf-tip-wrap errorHint color-red"></p>
                                </div>
                            </div>
                            <div class="wlfg-wrap clearfix">
                                <label class="label-name" for="nick" >邮箱：</label>
                                <div class="rlf-group">
                                    <span class="moco-form-control">${ouser.email}</span>
                                    <p class="rlf-tip-wrap errorHint color-red" ></p>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>

    </div>

</div>

</div>
  </div>

    </div>
</body>
</html>





