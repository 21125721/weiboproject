<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html;" />
    <title>News</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link href="css/home.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="css/news.css">
    <script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="js/home.js"></script>
    <link href="layui/css/layui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="layui/layui.js"></script>
<style type="text/css"> 
	p{
		font-size:18px;
	}
	.main *{
		color:white !important;
	}
</style>
</head>

<body>
    <c:import url="newstop.jsp"></c:import>
    <div style="width:71%;margin:100px auto;">
	    <div id="comment_divl">
	    	<div style="width:50%;margin:-35px auto;margin-left:65px;">
	    		<a href="showOtherUserinfo.do?uid=${user.userid}">
	    			<img src="pic/userimg.png" width="70px" height="70px">
	    		</a>
	    	</div>
	    	<div style="margin-top:70px;text-align: center;">
	    		<a href="javascript:0;">${user.nickname}</a>
	    		<hr class="comment_divl_hr">
	    	</div>
	    	<div style="margin:10px auto;">
	    		<div class="comment_divl_divl">
	    			<a href="usernews.do?uid=${user.userid}"><h3>${usernewscount}</h3></a>
	    			<a href="usernews.do?uid=${user.userid}">文章</a>
	    		</div>
	    		<div class="comment_divl_divr">
	    			<h3>753亿</h3>
	    			<a>总阅读</a>
	    		</div>
	    		<div style="clear: both;"></div>
	    	</div>
	    	<div style="width:100%;height:46px;background:#f9f9f9;text-align: center;">
	    		<a href="usernews.do?uid=${user.userid}" style="font-size: 16px;line-height: 46px;">去看Ta的文章></a>
	    	</div>
	    </div>
	    <div class="newsContent" >
	        <div class="main">
	            <div class="link" style="text-align: left;padding-left: 28px;margin-bottom: 40px">
	                <a href="home.jsp">首页</a><a>></a><a href="politics.jsp">${news.type}</a>
	            </div>
	            <h1 style="font-family: 微软雅黑;    font-size: 30px; font-weight: normal; color: #fff">${news.title}</h1>
	            <hr style="margin: 40px 0">
	            <p>${user.nickname }</p>
	            <p>${news.releasetime}</p>
	            <p id="article">${news.article}</p>
	            <img src="images/logo2.png" class="logo" style="width: 85px;height: 50px;bottom: -20px;">
	        </div>
	    </div>
	    <div id="comment_divr">
	    	<h3>最新</h3>
	    	<c:forEach items="${lastnewslist}" var="lastnews" varStatus="i">
		    	<div style="width:100%;margin-top:10px;position: relative;">
		    		<div class="comment_divr_imgdiv" style="float:left;">
		    			<img src="images/nowhot.png" width="90px" height="60px" />
		    			<div>
		    				<br />
		    				<h3><b>&nbsp;${i.count}</b></h3>
		    			</div>
		    		</div>
		    		<div id="comment_divr_pdiv" >
			    		<a class="comment_divr_pdiv_a" href="news.do?nid=${lastnews.newsid}" style="font-size:13px;">${lastnews.title}</a>
		    		</div>
	   				<div style="clear:both;"></div>
		    	</div>
	    	</c:forEach>
	    	
	    </div>
	    <div style="clear: both;"></div>
	    
	    
		<!-- 评论列表 -->
    	<c:forEach items="${remarklist}" var="remark" varStatus="i">
    		<c:if test="${i.count<6}">
		    	<div style="width:58%;overflow:hidden;margin-left:17%;">
			    	<div style="margin-left:2%;margin-top:2%;">
				    	<a href="showOtherUserinfo.do?uid=${remark.userid}">
				    		<img src="pic/userimg.png" />
				    	</a>
				    	<div style="display: inline-block;margin-top:5px;">
				    		<span style="font-size:18px;"><a style="color:#FB7299">${remark.nickname}</a></span>
				    		<p style="font-size:16px;width:700px;word-break:break-word;">${remark.remark}</p>
				    	</div>
				    </div>
				</div>
			</c:if>
			<c:if test="${i.count>=6}">
				<div id="noneRemark" style="width:58%;overflow:hidden;margin-left:17%;display: none;">
			    	<div style="margin-left:2%;margin-top:2%;">
				    	<a href="showOtherUserinfo.do?uid=${remark.userid}">
				    		<img src="pic/userimg.png" />
				    	</a>
				    	<div style="display: inline-block;margin-top:5px;">
				    		<span style="font-size:18px;"><a style="color:#FB7299">${remark.nickname}</a></span>
				    		<p style="font-size:16px;width:700px;word-break:break-word;">${remark.remark}</p>
				    	</div>
				    </div>
				</div>
			</c:if>
	    </c:forEach>
	    <!--  显示全部评论的按钮 -->
	    <c:if test="${fn:length(remarklist) >= 6}">
			<div id="allRemarkdiv" style="text-align: center;margin:0 18%;width:55%;height:20px;">
				<a class="layui-btn layui-btn-primary layui-btn-sm" href="javascript:0;" style="color:black;" onclick="showAllRemark()">全部评论</a>
			</div>
			<div id="hideRemarkdiv" style="display:none;text-align: center;margin:0 18%;width:55%;height:20px;">
				<a class="layui-btn layui-btn-primary layui-btn-sm" href="javascript:0;" style="color:black;" onclick="hideRemark()">收起评论</a>
			</div>
		</c:if>
	    <!-- 发表评论 -->
	    <div style="margin-left:7%;margin-top:20px;">
	    	<c:if test='${username == null || username == ""}'>
		    	<div class="baffle" style="position: absolute;left: 43%;margin-top: 14px;">
		    		请先<a class="layui-btn layui-btn-sm layui-btn-normal" onclick="showlogin()">登录</a>后发表评论 (・ω・)
		    	</div>
	    	</c:if>
	    	<c:if test="${username != null && username != ''}">
		    	<a href="userinfo.jsp" style="margin-left:17%;">
		    		<img src="pic/userimg.png" style="margin-top:-54px;" />
		    	</a>
		    	<textarea rows="3" cols="80" id="textarea_comment" placeholder="请自觉遵守互联网相关的政策法规，严禁发布色情、暴力、反动的言论。" required></textarea>
		    	<button type="button" onclick="comment_submit()" class="comment-submit">发表评论</button>
	    	</c:if>
	    </div>
	    <div style="clear: both;"></div>
	    </div>
	    <div class="copyright">©2019 News-Team All rights reserved.</div>
	    <a href="#" id="back-to-top" title="回到顶部"><img src="images/rockets.png">
	    </a>
</body>
<script type="text/javascript">
layui.use(['form', 'layedit', 'laydate'], function(){
	  var form = layui.form
	  ,layer = layui.layer
	  ,layedit = layui.layedit
	  ,laydate = layui.laydate;
	});
	function comment_submit(){
		var remark = $("#textarea_comment").val();
		if(remark == null || remark == ""){
			layer.open({
   		        type: 1
   		        ,offset: 'auto' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
   		        ,id: 'layerDemo' //防止重复弹出
   		        ,content: '<div style="padding: 20px 100px;">请输入评论</div>'
   		        ,btn: '关闭'
   		        ,btnAlign: 'c' //按钮居中
   		        ,shade: 0 //不显示遮罩
   		        ,yes: function(){
   		          layer.closeAll();
   		        }
   		      });
		}else{
			//示范一个公告层
		    var index = layer.open({
		      type: 1
		      ,title: false //不显示标题栏
		      ,closeBtn: false
		      ,area: '300px;'
		      ,shade: 0.8
		      ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
		      ,btn: ['确认', '让我想想']
		      ,btnAlign: 'c'
		      ,moveType: 1 //拖拽模式，0或者1
		      ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">确认评论吗？<br><br><br>确认请点确认按钮</div>'
		      ,yes: function(){
		    	   $.post("${pageContext.request.contextPath}/remark.do",{remark:$("#textarea_comment").val(),userid:"${Newsuser.userid}",newsid:"${news.newsid}"},function(){
		    		   location.reload();
		    	   })
		    	   layer.closeAll();
		     }
		    });
		}
		
	}
	function showAllRemark(){
		$("#allRemarkdiv").hide();
		$("#noneRemark").show();
		$("#hideRemarkdiv").show();
	}
	function hideRemark(){
		$("#allRemarkdiv").show();
		$("#noneRemark").hide();
		$("#hideRemarkdiv").hide();
	}
</script>
</html>
