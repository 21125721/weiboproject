<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="translated-ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>个人中心</title>
    <script src="js/popper.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/topstyle.css">
    <script src="js/jquery-3.2.1.js"></script>
    <link href="css/home.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        $(function () {
            if ("${userName}" != "") {
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
<body style="background-image: url(pic/body_bg.png);background-attachment:fixed">
<c:import url="top.jsp"></c:import>
<c:if test="${userName==null}">
    <div class="wrapper-box">
        <font style="font-size: 40px;">请先<a style="color: red;font-size: 40px;" href="index.jsp">登录</a></font>
    </div>
</c:if>
<c:if test="${userName!=null}">
    <div class="wrapper-box">

        <div style="position:fixed;top:40px;left:0;height:20px;width:100%;background:#F3F2F0;z-index:100;display:none;"></div>
        <div class="area clearfix">
            <div class="main" style="margin-top:60px;">
                <div id="main">
                    <div style="background-color: rgba(70,149,194,0.3);width:124px;height:300px;float: left;margin-left: 11%;text-align: left;">
                        <ul id="left_ul" style="margin-left: 20px;">
                            <li>
                                <a href="index.jsp">首页</a>
                            </li>
                            <li>
                                <a href="index.jsp">首页</a>
                            </li>
                            <li>
                                <a href="index.jsp">首页</a>
                            </li>
                            <li>
                                <a href="index.jsp">首页</a>
                            </li>
                        </ul>
                    </div>
                    <div style="width: 57%;float:left;margin-left: 1%;">
                        <div class="content_div" style="background: white;height:240px;">
                            <form action="sendWeibo.do" method="post">
                                <div style="text-align: center;padding: 10px 0;">
                                    <a style="color:#1b7fb6;font-family: WBswficon;float: left;margin-left: 20px;">有什么新鲜事想告诉大家?</a>
                                    <a style="color:red;font-family: 文鼎行楷碑體;float: right;margin-bottom:10px;margin-right: 20px;font-size: 14px;">最长2000字</a>
                                    <%--<textarea name="content" maxlength="2000" minlength="5" style="margin-top:10px;width: 558px;height:100px;resize: none;" required></textarea>--%>
                                    <div style="clear: both;"></div>
                                    <textarea id="WeiboText" name="content" style="display: none;"></textarea>
                                    <script>
                                        layui.use('layedit', function(){
                                            var layedit = layui.layedit;
                                            layedit.build('WeiboText', {
                                                tool: ['strong' //加粗
                                                    ,'italic' //斜体
                                                    ,'underline' //下划线
                                                    ,'del' //删除线
                                                    ,'|' //分割线
                                                    ,'left' //左对齐
                                                    ,'center' //居中对齐
                                                    ,'right' //右对齐
                                                    ,'link' //超链接
                                                    ,'unlink' //清除链接
                                                    ,'face' //表情
                                                    ],
                                                height: 100, //设置编辑器高度
                                                width:558,
                                            });
                                        });
                                    </script>
                                </div>
                                <div  style="text-align: center;float: right;margin-top: 2px;margin-right: 18px;margin-bottom: 10px;clear: both;">
                                    <span class="sendWeibo_span" style="color: red">${sendWeibo}</span>
                                    <button id="submit_weibo_btn" type="submit">发布</button>
                                </div>
                            </form>
                        </div>
                        <c:forEach items="${userWeibo}" var="weibo">
                            <div style="margin-top:10px;background: white;">
                                <div style="padding-top: 20px;">
                                    <img src="pic/userimg.png" class="layui-nav-img" style="display: inline-block;border: #a94442 solid 2px;margin-left: 20px;width: 50px;height:50px;">
                                    <div style="display: inline-block;">
                                        <a style="color: black;font-size: 18px;font-weight:bold;">${weibo.user.luckyName}</a><br />
                                        <a style="color: black;font-size: 12px;">${weibo.time}</a>
                                    </div>
                                    <div style="margin-left: 80px;width: 465px;padding-bottom:20px;overflow: hidden;">
                                        <p class="content_p" style="word-break: normal;font-size: 14px;">
                                            ${weibo.content}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div style="float: right;background-image:url(pic/userinfoimg.jpg);width: 240px;height: 180px;margin-right: -1%;">
                        <div style="width: 238px;height:78px;margin: 0 auto;text-align: center;">
                            <img src="pic/userimg.png" class="layui-nav-img" style="border: #a94442 solid 2px;margin-right: 0px;width: 60px;height:60px;margin-top:42px;">
                        </div>
                        <div style="background:white;width: 240px;height:120px;margin: 0 auto;
                        text-align: center;overflow: hidden;">
                            <div style="margin-top:40px;margin-bottom: -5px;">
                                <a style="display: inline-block;font-weight: bold;color: black;overflow: hidden">${User.luckyName}</a>
                            </div>
                            <div style="width:240px;height:47px;">
                                <ul class="attends_fans_weibo_count">
                                    <li>
                                        <a href="attendsjsp.do?t=attends">
                                            ${Attends_count}<br />
                                            <span>关注</span>
                                        </a>
                                    </li>
                                    <li class="attends_fans_weibo_count_li2">
                                        <a href="attendsjsp.do?t=fans">
                                            ${Fans_count}<br />
                                            <span>粉丝</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="attendsjsp.do?t=weibo">
                                            ${Weibo_count}<br />
                                            <span>微博</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                </div>
            </div>
        </div>

    </div>
</c:if>

</body>
<style>
    body::-webkit-scrollbar { display: none; }
    body,ul,li{
        padding:0;
        margin:0;
    }
    ul,li{
        list-style:none;
    }
    .title {
        width: 400px;
        height: 30px;
        margin-top: 50px;
    }

    .test {
        height: 320px;
        margin-top: 50px;

    }

    .button {
        margin-top: 50px;
    }

    .username {
        color: white;
    }
    #left_ul li{
        margin-top: 18px;
    }
    #left_ul a{
        font-family: Arial;
        font-weight: bold;
        font-size: 14px;
        color: white;
    }
    .attends_fans_weibo_count{
        margin-top:10px;
    }
    .attends_fans_weibo_count li{
        display: inline-block;
        width: 70px;
    }
    .attends_fans_weibo_count_li2{
        border-left:#d9d9d9 solid 1px;
        border-right:#d9d9d9 solid 1px;
    }
    .attends_fans_weibo_count li a{
        color: #333333;
        font-size: 18px;
        font-weight:bold;
    }
    .attends_fans_weibo_count li span{
        float: left;
        margin:-5px 0 0 23px;
        color: #808080;
        font-size: 12px;
        clear: both;
    }
    .content_div a,.content_div span{
        color: black;
    }
    textarea{
        -webkit-transition: all 0.30s ease-in-out;
        -moz-transition: all 0.30s ease-in-out;
        -ms-transition: all 0.30s ease-in-out;
        -o-transition: all 0.30s ease-in-out;
        box-shadow: 0 0 3px rgba(89, 89, 89, 1);
        padding: 3px 0px 3px 3px;
        margin: 5px 1px 3px 0px;
        border: 2px solid rgba(204, 204, 204, 1);
    }
    textarea:focus
    {
        box-shadow: 0 0 0 0;
        border: 2px solid orange;
    }

    .attend_btn{
        display: inline-block;
        line-height: 29px;
        font-size: 14px;
        color: #333333;
        width: 82px;
        height: 30px;
        background: white;
        border: 1px solid #d9d9d9;
        box-shadow: 0px 1px 2px rgba(0,0,0,0.1);
    }
    .attend_btn:hover{
        box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.25);
    }
    #submit_weibo_btn{
        display: inline-block;
        line-height: 29px;
        font-size: 14px;
        color: white;
        width: 82px;
        height: 30px;
        background: #ffc09f;
        border: 1px solid #fbbd9e;
        box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.25);
    }
    #submit_weibo_btn:hover{
        cursor: pointer;
        background: #ff8140;
        border:1px solid #f77c3d;;
    }
    .content_p a{
        color: black;
    }
</style>
<script>
    $(function () {
        if($('.sendWeibo_span').text()!=''){
            timedMsg()
        }
    })
    function timedMsg()
    {
        var t=setTimeout($('.sendWeibo_span').val(''),5000);
        t=window.clearInterval(t);
    }
</script>
</html>





