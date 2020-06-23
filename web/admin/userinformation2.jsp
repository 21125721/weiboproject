<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="translated-ltr"><head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>个人中心</title>
    <link rel="stylesheet" href="../css/base.css" type="text/css" />
    <link rel="stylesheet" href="../css/common-less(1).css" type="text/css" />
    <link rel="stylesheet" href="../css/moco.min.css" type="text/css" />
    <link rel="stylesheet" href="../css/common-less.css" type="text/css" />
    <link rel="stylesheet" href="../css/profile-less.css" type="text/css" />
    <link rel="stylesheet" href="../layui/css/layui.css" type="text/css" />
    <script type="text/javascript" src="../layui/layui.js"></script>
    <script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
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
<script src="../layui/layui.js"></script>
<link rel="stylesheet" href="../layui/css/layui.css">    
<link type="text/css" rel="stylesheet" href="//statics.itc.cn/pc/ucenter/static/css/main-84d99eacb9.css">
</head>
<body>
<c:if test="${username==null}">
	<div class="wrapper-box">
		<font style="font-size: 40px;">请先<a style="color: red;font-size: 40px;" href="../home.jsp">登录</a></font>
	</div>
</c:if>
<c:if test="${username!=null}">
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
									<c:if test="${Newsuser.status =='on'}">
		                                <label  class="lh16"><a class="layui-btn layui-btn-xs" >激活</a></label>
		                            </c:if>
		                            <c:if test="${Newsuser.status =='off'}">
		                                <label  class="lh16"><a class="layui-btn layui-btn-danger layui-btn-xs" >封禁中</a></label>
		                            </c:if>
	                            </div>
                            </div>
                            <div class="wlfg-wrap clearfix">
                                <br /><label class="label-name" for="username" >用户名：</label>
                                <div class="rlf-group">
                                    <input type="text" name="username" autocomplete="off" readonly data-validate="require-nick"  class="moco-form-control" value="${Newsuser.username}" placeholder="请输入昵称."/>
                                </div>
                            </div>
                            <div class="wlfg-wrap clearfix">
                                <br /><label class="label-name" for="nick" >昵称：</label>
                                <div class="rlf-group">
                                    <input type="text" name="nickname" id="nick"  autocomplete="off"  data-validate="require-nick"  class="moco-form-control" value="${Newsuser.nickname}" placeholder="请输入昵称."/>
                                    <p class="rlf-tip-wrap errorHint color-red" ></p>
                                </div>
                            </div>
                            
                            <div class="wlfg-wrap clearfix">
                                <label class="label-name h16 lh16" >性别：</label>
                                <div class="rlf-group rlf-radio-group">
                                	<c:if test="${Newsuser.gender =='男'}">
                                    <label  class="lh16"><input type="radio" value="男" name="gender" checked="checked" disabled="disabled">男</label>
                                    <label  class="lh16"><input type="radio" value="女" name="gender"  disabled="disabled">女</label>
                                    </c:if>
                                    <c:if test="${Newsuser.gender =='女'}">
                                    <label  class="lh16"><input type="radio" value="男" name="gender"  disabled="disabled">男</label>
                                    <label  class="lh16"><input type="radio" value="女" name="gender" checked="checked"  disabled="disabled">女</label>
                                    </c:if>
                                    <p class="rlf-tip-wrap errorHint color-red"></p>
                                </div>
                            </div>
                            <div class="wlfg-wrap clearfix">
                                <label class="label-name" for="nick" >邮箱：</label>
                                <div class="rlf-group">
                                    <input type="email" name="email" id="email"  autocomplete="off"  data-validate="require-email"  class="moco-form-control" value="${Newsuser.email}" placeholder="请输入邮箱."/>
                                    <p class="rlf-tip-wrap errorHint color-red" ></p>
                                </div>
                            </div>
                            <div class="wlfg-wrap clearfix">
                                <label class="label-name" for="profile-submit"></label>
                                <div class="rlf-group">
                                    <button type="button" id="updateuserinfo" class="layui-btn layui-btn-lg">保存</button>
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
</c:if>
</body>
<script type="text/javascript">
layui.use(['form', 'layedit', 'laydate'], function(){
	  var form = layui.form
	  ,layer = layui.layer
	  ,layedit = layui.layedit
	  ,laydate = layui.laydate;
	});
	
$(function() {
	var dataformInit = $("#profile").serializeArray();
	var jsonTextInit = JSON.stringify({
		dataform : dataformInit
	});
	$("#updateuserinfo").click(function() {
		var dataform = $("#profile").serializeArray();
		var jsonText = JSON.stringify({
			dataform : dataform
		});
		if (jsonTextInit == jsonText) {
				layer.open({
						type : 1,
						offset : 't' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
						,
						id : 'layerDemo' //防止重复弹出
						,
						content : '<div style="padding: 20px 100px;">请先修改再保存</div>',
						btn : '确认',
						btnAlign : 'c' //按钮居中
						,
						shade : 0.7 //不显示遮罩
						,
						yes : function() {
							layer.closeAll();
						}
					});
			return false;
		} else {
			if ($("#nick").val() == null || $("#nick").val() == "") {
					layer.open({
							type : 1,
							offset : 't' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
							,
							id : 'layerDemo' //防止重复弹出
							,
							content : '<div style="padding: 20px 100px;">昵称不能为空！</div>',
							btn : '确认',
							btnAlign : 'c' //按钮居中
							,
							shade : 0.7 //不显示遮罩
							,
							yes : function() {
								layer.closeAll();
							}
						});
			}else if ($("#email").val() == null || $("#email").val() == "") {
					layer.open({
							type : 1,
							offset : 't' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
							,
							id : 'layerDemo' //防止重复弹出
							,
							content : '<div style="padding: 20px 100px;">邮箱不能为空！</div>',
							btn : '确认',
							btnAlign : 'c' //按钮居中
							,
							shade : 0.7 //不显示遮罩
							,
							yes : function() {
								layer.closeAll();
							}
						});
			}else{
				$.post("../updateUserInfo.do",{userid:"${Newsuser.userid}",nickname:$("#nick").val(),email:$("#email").val()},function(data){
					if(data == 1){
						layer.open({
							type : 1,
							offset : 't' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
							,id : 'layerDemo' //防止重复弹出
							,content : '<div style="padding: 20px 100px;">修改成功！</div>',
							btn : '确认',
							btnAlign : 'c' //按钮居中
							,shade : 0.7 //不显示遮罩
							,yes : function() {
								layer.closeAll();
								$("#body_div").load("userinformation2.jsp");
							}
						});
					}else{
						layer.open({
							type : 1,
							offset : 't' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
							,id : 'layerDemo' //防止重复弹出
							,content : '<div style="padding: 20px 100px;">修改失败！</div>',
							btn : '确认',
							btnAlign : 'c' //按钮居中
							,shade : 0.7 //不显示遮罩
							,yes : function() {
								layer.closeAll();
								$("#body_div").load("userinformation2.jsp");
							}
						});
					}
				})
			}
			return false;
		}
	})
})
</script>
</html>