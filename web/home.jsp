<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html;" />
    <title>News</title>
    <script src="js/popper.min.js"></script>
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/topstyle.css"> 
	<script src="js/jquery-3.2.1.js"></script>
    <link href="css/home.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		.newstitle1{
			left: 30px;
		}
		.newstitle2{
			left: 630px;
		}
		.newstitle3{
			left: 1230px;
		}
		.newstitle4{
			left: 1830px;
		}
		.newstitle5{
			left: 2430px
		}
		.newstitle6{
			left: 3030px;
		}
		.newstitle7{
			left: 3630px;
		}
	</style>
</head>

<body style="background: url(pic/body_bg.png) no-repeat;background-attachment:fixed">
    <c:import url="top.jsp"></c:import>
	<div class="wrapper-box">

		<div style="position:fixed;top:40px;left:0;height:20px;width:100%;background:#F3F2F0;z-index:100;display:none;"></div>
		<div class="area clearfix">
			<div class="main" style="margin-top:60px;">
				<div id="main">
					<div style="width: 40%;margin: 0 auto;">
						<c:forEach items="${weibolist}" var="weibo">
							<div style="margin-top:10px;background: white;">
								<div style="padding-top: 20px;">
									<img src="pic/userimg.png" class="layui-nav-img" style="display: inline-block;border: #a94442 solid 2px;margin-left: 20px;width: 50px;height:50px;">
									<div style="display: inline-block;">
										<a style="color: black;font-size: 18px;font-weight:bold;">${weibo.user.luckyName}</a><br />
										<a style="color: black;font-size: 12px;">${weibo.time}</a>
									</div>
									<div style="display: inline-block;float: right;clear: both;margin-right: 20px;">
										<c:if test="${fn:length(AttendsList) > 0}">
											<c:set var="attendField" value="no"></c:set>
											<c:forEach items="${AttendsList}" var="Attend">
												<c:if test="${weibo.wbid == Attend && userName != weibo.wbid}">
													<c:set var="attendField" value="yes"></c:set>
												</c:if>
												<c:if test="${userName == weibo.wbid}">
													<c:set var="attendField" value="none"></c:set>
												</c:if>
											</c:forEach>
											<c:if test="${attendField == 'yes'}">
												<form action="cancelAttends.do?t=index" method="post">
													<input style="display: none;" name="CancelAttendsUserName" value="${weibo.wbid}"/>
													<input class="attend_btn cancel_attend" type="button" value="已关注" />
												</form>
											</c:if>
											<c:if test="${attendField == 'none'}">

											</c:if>
											<c:if test="${attendField == 'no'}">
												<form action="attends.do?t=index" method="post">
													<input style="display: none;" name="AttendsUserName" value="${weibo.wbid}"/>
													<input class="attend_btn attend" type="button" value="关注Ta" />
												</form>
											</c:if>
										</c:if>
										<c:if test="${fn:length(AttendsList) == 0 && userName != weibo.wbid}">
											<form class="attends_form" action="attends.do?t=index" method="post">
												<input style="display: none;" name="AttendsUserName" value="${weibo.wbid}"/>
												<input class="attend_btn attend" type="button" value="关注Ta" />
											</form>
										</c:if>
									</div>
									<div style="margin-left: 80px;width: 80%;padding-bottom: 20px;overflow: hidden;">
										<p class="content_p" style="word-break: break-all;font-size: 14px;">
											${weibo.content}
										</p>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					<div style="clear: both;"></div>
				</div>
			</div>
		</div>

	</div>
    <div class="copyright" style="background: rgba(0,0,0,0);">©2020 Weibo-Team All rights reserved.</div>
    <a href="#" id="back-to-top" title="回到顶部"><img src="images/rockets.png"></a>
</body>
<style>
	body::-webkit-scrollbar { display: none; }
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
</script>
</html>


