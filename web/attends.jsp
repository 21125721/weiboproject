<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/5/18
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>微博</title>
    <script src="js/popper.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/topstyle.css">
    <script src="js/jquery-3.2.1.js"></script>
    <link href="css/home.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-image: url(pic/body_bg.png);">
    <c:import url="top.jsp"></c:import>
    <div style="width:920px;height: 70%;margin:100px auto 0;text-align: center">
        <div style="height: 282px;background: url(pic/001_s.png)no-repeat;">
            <div style="width: 238px;height:78px;margin: 0 auto;text-align: center;">
                <img src="pic/userimg.png" class="layui-nav-img" style="border: #a94442 solid 2px;margin-right: 0px;width: 100px;height:100px;margin-top:42px;">
            </div>
            <div style="margin-top:80px;margin-bottom: -5px;">
                <h1 style="font-weight: normal;font-size: 22px;display: inline-block;color: white;overflow: hidden;text-shadow: 0 0 4px rgba(0,0,0,0.5);">${User.luckyName}</h1>
            </div>
        </div>
        <div style="height: 40px;background:white;">
            <ul id="attends_fans_weibo_div">
                <li class="active_li">
                    <a class="myattends">我的关注</a>
                </li>
                <li style="margin-left: 100px;">
                    <a class="myfans">我的粉丝</a>
                </li>
                <li style="margin-left: 100px;">
                    <a class="myweibo">我的微博</a>
                </li>
            </ul>
        </div>
        <div style="background:white;margin-top: 20px;padding-bottom: 20px;">
            <ul class="attends_ul" style="padding-left: 55px;">
                <li style="padding:20px 16px 0 0">
                    <c:if test="${param.t == 'attends'}">
                        <c:forEach items="${UserAttends}" var="user">
                            <div style="background: #f2f2f5;display: inline-block;width: 260px;padding-bottom: 25px;">
                                <div style="padding-top: 20px;display: inline-block;">
                                    <img src="pic/userimg.png" class="layui-nav-img" style="border: #a94442 solid 2px;width: 60px;height:60px;">
                                </div>
                                <div style="width: 100px;margin-top: 20px;display: inline-block;">
                                    <div style="">
                                        <a style="color: black;font-size: 14px;">${user.luckyName}</a>
                                    </div>
                                    <div style="display: inline-block;float: right;clear: both;margin:10px 10px 0 0;">
                                        <form action="cancelAttends.do?t=myattends" method="post">
                                            <input style="display: none;" name="CancelAttendsUserName" value="${user.userName}"/>
                                            <input class="cancel_attend attend_btn" type="button" value="已关注" />
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${param.t == 'fans'}">
                        <c:forEach items="${UserFans}" var="fans">
                            <div style="background: #f2f2f5;display: inline-block;width: 260px;padding-bottom: 25px;">
                                <div style="padding-top: 20px;display: inline-block;">
                                    <img src="pic/userimg.png" class="layui-nav-img" style="border: #a94442 solid 2px;width: 60px;height:60px;">
                                </div>
                                <div style="width: 100px;margin-top: 20px;display: inline-block;">
                                    <div style="">
                                        <a style="color: black;font-size: 14px;">${fans.luckyName}</a>
                                    </div>
                                    <c:if test="${fn:length(Attends) > 0}">
                                        <c:set var="attendField" value="no"></c:set>
                                        <c:forEach items="${Attends}" var="Attend">
                                            <c:if test="${fans.userName == Attend}">
                                                <c:set var="attendField" value="yes"></c:set>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${attendField == 'yes'}">
                                            <div style="display: inline-block;float: right;clear: both;margin:10px 10px 0 0;">
                                                <form action="cancelAttends.do?t=myfans" method="post">
                                                    <input style="display: none;" name="CancelAttendsUserName" value="${fans.userName}"/>
                                                    <input class="attend_btn cancel_attend" type="button" value="已关注" />
                                                </form>
                                            </div>
                                        </c:if>
                                        <c:if test="${attendField == 'no'}">
                                             <div style="display: inline-block;float: right;clear: both;margin:10px 10px 0 0;">
                                                <form action="attends.do?t=myfans" method="post">
                                                    <input style="display: none;" name="AttendsUserName" value="${fans.userName}"/>
                                                    <input class="attend_btn attend" type="button" value="关注Ta" />
                                                </form>
                                             </div>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${fn:length(Attends) == 0}">
                                        <div style="display: inline-block;float: right;clear: both;margin:10px 10px 0 0;">
                                            <form action="attends.do?t=myfans" method="post">
                                                <input style="display: none;" name="AttendsUserName" value="${fans.userName}"/>
                                                <input class="attend_btn attend" type="button" value="关注Ta" />
                                            </form>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${param.t == 'weibo'}">
                        <c:forEach items="${UserWeiboList}" var="weibo">
                            <div style="width: 810px;margin-top:10px;background: #f2f2f5;padding:20px 20px;">
                                <div style="margin-left: 40px;width: 80%;overflow: hidden;">
                                    <p class="content_p" style="word-break: break-all;font-size: 14px;text-align: left;">
                                        ${weibo.content}
                                    </p>
                                </div><br />
                                <div style="float: right;">
                                    <span>${weibo.time}</span>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </li>
                <div style="clear: both;"></div>
            </ul>
        </div>
    </div>
</body>
<style>
    body::-webkit-scrollbar { display: none; }
    #text{
        margin-top:-42px;
    }
    .attends_ul li{
        float: left;
        display: inline-block;
    }
    #attends_fans_weibo_div li{
        display: inline-block;
        width:80px;
        height:40px;
    }
    #attends_fans_weibo_div li:hover{
        cursor: pointer;
        border-bottom: orange 2px solid;
    }
    .active_li{
        border-bottom: orange 2px solid;
    }
    #attends_fans_weibo_div a{
        color: black;
        font-size: 14px;
        line-height: 40px;
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
    .content_p a{
        color: black;
    }
</style>
<script type="text/javascript">
    $(function () {
        $(".attend").click(function () {
            var userName = "${userName}";
            if( userName== ""){
                showlogin();
            }else{
                $(this).parent().submit();
            }
        })
        $(".cancel_attend").click(function () {
            var userName = "${userName}";
            if( userName== ""){
                showlogin();
            }else{
                $(this).parent().submit();
            }
        })
        $(".cancel_attend").mouseover(function () {
            this.value = "取消关注";
        })
        $(".cancel_attend").mouseout(function () {
            this.value = "已关注";
        })
    })
    $(function(){
        var url = '${param.t}';
        if(url == 'attends'){
            $('.myttends').parent().addClass('active_li').siblings('li').removeClass('active_li');
        }else if(url == 'fans'){
            $('.myfans').parent().addClass('active_li').siblings('li').removeClass('active_li');
        }else if (url == 'weibo'){
            $('.myweibo').parent().addClass('active_li').siblings('li').removeClass('active_li');
        }

        $('#attends_fans_weibo_div li a').click(function(){
            $(this).parent().addClass('active_li').siblings('li').removeClass('active_li');
        })
        $('.myattends').click(function () {
            window.location.href='${pageContext.request.contextPath}/attendsjsp.do?t=attends';
        })
        $('.myfans').click(function () {
            window.location.href='${pageContext.request.contextPath}/attendsjsp.do?t=fans';
        })
        $('.myweibo').click(function () {
            window.location.href='${pageContext.request.contextPath}/attendsjsp.do?t=weibo';
        })
    })
    /*$(function () {
        var i = getQueryString("t");
        //alert((""));
        /!*if(i == "attends"){

        }else if (i == "fans"){

        }else if (i == "weibo"){

        }*!/
    })
    $(function(){
        $('#attends_fans_weibo_div li').click(function(){
            $(this).addClass('active_li').siblings('li').removeClass('active_li');
        })

    })
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }*/
</script>
</html>
