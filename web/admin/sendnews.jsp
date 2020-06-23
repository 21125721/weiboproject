<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>用户信息</title>

<link rel="stylesheet" href="../css/topstyle.css"> 
<link rel="stylesheet" href="../layui/css/layui.css"> 
<script src="../js/jquery-3.2.1.js"></script>
<script src="../js/popper.min.js"></script>
<script src="../layui/layui.js"></script>

<script type="text/javascript" charset="utf-8" src="../ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../ueditor/ueditor.all.js"></script>
<script type="text/javascript" charset="utf-8" src="../ueditor/lang/zh-cn/zh-cn.js"></script>
<style type="text/css">
.layui-input, .layui-textarea {
    width: 50%;
}
</style>
</head>
<body style="position: relative;min-width: 1680px;background:rgba(255,255,255,0);">
<div class="center_box" style="width:90%;margin:0 auto;">
	<div class="main_box">
		<div class="main_top">
			<form id="sendnewsform" action="sendnews.do" method="post">
				<div class="layui-form-item">
					<label class="layui-form-label">标题</label>
					<div class="layui-input-block">
						<input type="text" required style="width:900px;" name="title" lay-verify="title"
						autocomplete="off" id="newstitle" placeholder="请输入标题" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
				    <label class="layui-form-label">类别</label>
				    <div class="layui-input-block">
				      <select name="type" id="newstype">
				        <option value="体育" selected="selected">体育</option>
				        <option value="科技">科技</option>
				        <option value="娱乐">娱乐</option>
				        <option value="时政">时政</option>
				        <option value="观点">观点</option>
				      </select>
				    </div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">简介(200字以内)</label>
					<div class="layui-input-block">
						<input type="text" required style="width:900px;" name="synopsis" placeholder="请输入简介" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item layui-form-text">
					<label class="layui-form-label">内容</label>
					<div class="layui-input-block">
						<textarea id="container" name="article" placeholder="请输入内容" style="width:900px;height:550px;" required></textarea>
					</div>
				</div>
				<div style="width: 100px; margin: 0 auto;">
    				<button type="button" onclick="sendnew()" id="sendnews"" class="layui-btn layui-btn-fluid">发布</button>
  				</div>
				</form>
			<div style="clear: both;"></div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var ue = UE.getEditor("container");
	layui.use(['form', 'layedit', 'laydate'], function(){
	  var form = layui.form
	  ,layer = layui.layer
	  ,layedit = layui.layedit
	  ,laydate = layui.laydate;
	});
	function sendnew(){
		var title = $("#newstitle").val();
		var newshtml = 	ue.getAllHtml();
		var news = 	ue.getContentTxt();
		var i = $('#sendnewsform').serialize();
		 
		var args = $.param({
		    "userid" : "${Newsuser.userid}",
		}) + "&" +$('#sendnewsform').serialize();
		 if( title == null || title == "" || news == "" || news == null){
			var text = "请输入完整！";
			layer.open({
		        type: 1
		        ,offset: 'auto' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
		        ,id: 'layerDemo' //防止重复弹出
		        ,content: '<div style="padding: 20px 100px;">'+ text +'</div>'
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
	      ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">确认发布吗？<br><br><br>确认请点确认按钮</div>'
	      ,yes: function(){
	    	  $("#sendnews").attr("disable",true);
	    	   $.post("${pageContext.request.contextPath}/sendnews.do",args,function(data){
	   			var text ="";
	   			if(data == 0){
	   				text = "发布失败";
	   			}else{
	   				text = "发布成功";
	   			}
	    		  	layer.open({
	   		        type: 1
	   		        ,offset: 'auto' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
	   		        ,id: 'layerDemo' //防止重复弹出
	   		        ,content: '<div style="padding: 20px 100px;">'+ text +'</div>'
	   		        ,btn: '关闭'
	   		        ,btnAlign: 'c' //按钮居中
	   		        ,shade: 0 //不显示遮罩
	   		        ,yes: function(){
	   		          layer.closeAll();
	   		          $("#body_div").load("sendnews.jsp");
	   		        }
	   		      });
	    		 $("#sendnews").attr("disable",false);
	    	  })
	    	  layer.close(index);
	      }
	    }); 
	  }
	}
</script>
</body>
</html>