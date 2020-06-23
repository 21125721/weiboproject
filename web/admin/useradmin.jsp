<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Layui</title>
  <script src="../js/jquery-3.2.1.js" charset="utf-8"></script>
<style type="text/css">
	.top_div{
		width:49%;
		float:right;
		margin-bottom: -15px;
	}
	.layui-input{
		display: inline-block;
	}
	.topsearch_div{
		vertical-align: top;
		display: inline-block; 
	}
	.topselect_div{
		float:left;
		display: inline-block;
	}
	.top_select{
		display: inline-block;
		height:38px;
		border: 1px solid #ced4da;
  		border-radius: 0.25rem;
	}
	.topsearch_btn{
		margin-top:-3px;
  		display: inline-block; 
  	}
  	.layui-input-inline{
  		width:300px !important;
  	}
	input::-webkit-input-placeholder {
     /* placeholder颜色  */
     color: #aab2bd;
     /* placeholder字体大小  */
     font-size: 14px;
  	}
  	.layui-table-view{
  		display: inline-block;
  	}
</style>
</head>
<body>
	<div class="demoTable">
	<button type="button" class="layui-btn layui-inline" id="flushdata">刷新</button>
		<!-- 搜索<select class="top_select">
					<option>用户id</option>
					<option>用户名</option>
					<option>昵称</option>
					<option>性别</option>
					<option>邮箱</option>
					<option>等级</option>
					<option>状态</option>
				</select>
		<div class="layui-inline">
			<input class="layui-input" name="id" id="demoReload"
				autocomplete="off">
		</div>
		<button class="layui-btn" data-type="reload">搜索</button> -->
	</div>
	<table class="layui-table" lay-data="{url:'${pageContext.request.contextPath}/showUser.do',width : 1472,height : 700, method: 'post', page:true, id:'Usertable'}" lay-filter="demo">
	<thead>
	    <tr>
	        <th lay-data="{field:'userid', title: 'ID',sort: true, width: '8%', sort: true, fixed: 'left', align: 'center' }">用户ID</th>
	        <th lay-data="{field:'username', width:'12%', sort: true,align: 'center'}">用户名</th>
	        <th lay-data="{field:'nickname', width:'12%',sort: true, align: 'center'}">昵称</th>
	        <th lay-data="{field:'gender', width:'11%',sort: true, align: 'center'}">性别</th>
	        <th lay-data="{field:'email', width:'12%',sort: true, align: 'center'}">邮箱</th>
	        <th lay-data="{field:'level', width:'9%',align: 'center',toolbar:'#Userlevel'}">等级</th>
	        <th lay-data="{field:'regist_time', width:'12%',sort: true,align: 'center'}">注册时间</th>
	        <th lay-data="{field:'status', width:'9%',align: 'center',toolbar: '#Userstatus'}">状态</th>
	        <th lay-data="{fixed: 'right', width:'16%', align:'center',toolbar: '#barDemo'}">操作</th>
	    </tr>
	</thead>
</table>
<script type="text/html" id="barDemo">
{{# if (d.level == 3) { }}
	<a href="javascript:0;" class="layui-btn layui-btn-danger layui-btn-xs layui-btn-disabled" >封禁账号</a>
	<a href="javascript:0;" class="layui-btn layui-btn-xs layui-btn-disabled" >解禁账号</a>
{{# } else if(d.status=== 'on') { }}
	<a href="javascript:0;" lay-event="banuser" class="layui-btn layui-btn-danger layui-btn-xs" >封禁账号</a>
	<a href="javascript:0;" class="layui-btn layui-btn-xs layui-btn-disabled" >解禁账号</a>
{{# } else if(d.status=== 'off') { }}
	<a href="javascript:0;" class="layui-btn layui-btn-danger layui-btn-xs layui-btn-disabled" >封禁账号</a>
	<a href="javascript:0;" lay-event="unsealing" class="layui-btn layui-btn-xs" >解禁账号</a>
{{# } }}
</script>
<script type="text/html" id="Userstatus">
{{# if (d.status === 'on') { }}
    <a class="layui-btn layui-btn-xs" >激活</a>
{{# } else { }}
	<a class="layui-btn layui-btn-danger layui-btn-xs">封禁</a>
{{# } }}
</script>
<script type="text/html" id="Userlevel">
{{# if (d.level == 0) { }}
    <span class="layui-badge layui-bg-gray">普通</span>
{{# } else if(d.level == 1){ }}
    <span class="layui-badge layui-bg-blue">记者</span>
{{# } else if(d.level == 2){ }}
	<span class="layui-badge layui-bg-blue">主编</span>
{{# } else if(d.level == 3){ }}
	<span class="layui-badge">超级管理员</span>
{{# } else { }}
{{# } }}
</script>
<script>
	$(function(){
		$("#flushdata").click(function(){
			$("#body_div").load("useradmin.jsp");
		})
	})
	
    $(function(){layui.use('table', function () {
        var table = layui.table
            , form = layui.form;
        table.init();
        form.render();
      //监听锁定操作
        form.on('checkbox(demo)', function(obj){
          layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
        });
        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
            var article = data.article;
            if (obj.event === 'banuser') {
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
	       	      ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">确认封禁吗？<br><br><br>确认请点确认按钮</div>'
	       	      ,yes: function(){
	       	    	   $.post("${pageContext.request.contextPath}/banuser.do",{'userid':data.userid},function(data){
	       	   			var text ="";
	       	   			if(data == 0){
	       	   				text = "封禁失败";
	       	   			}else if(data == 1){
	       	   				text = "封禁成功";
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
	       	   		        	$("#flushdata").click();
	       	   		          	layer.closeAll();
	       	   		        }
	       	   		      });
	       	    	  })
	       	    	  layer.close(index);
	       	      }
	       	    });
            }else if (obj.event ==='unsealing') {
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
        	      ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; color: #fff; font-weight: 300;">确认解封吗？<br><br><br>确认请点确认按钮</div>'
        	      ,yes: function(){
        	    	   $.post("${pageContext.request.contextPath}/unsealing.do",{'userid':data.userid},function(data){
        	   			var text ="";
        	   			if(data == 0){
        	   				text = "解封失败";
        	   			}else if(data == 1){
        	   				text = "解封成功";
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
        	   		        	$("#flushdata").click();
        	   		          	layer.closeAll();
        	   		        }
        	   		      });
        	    	  })
        	    	  layer.close(index);
        	      }
        	    }); 
            }
        });
        
        var $ = layui.$, active = {
       	    reload: function(){
       	      var demoReload = $('#demoReload');
       	      //执行重载
       	      table.reload('Usertable', {
       	        page: {
       	          curr: 1 //重新从第 1 页开始
       	        }
       	      }, '${pageContext.request.contextPath}/json/data.json');
       	    }
       	  };
        //监听搜索点击按钮
        $('#flushdata').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
})
</script> 
</html>