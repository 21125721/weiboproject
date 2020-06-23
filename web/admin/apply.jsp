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
		<!-- 搜索<select class="top_select" id="demoReload">
					<option  name="newsid">新闻编号</option>
					<option  name="userid">记者编号</option>
					<option  name="title">标题</option>
					<option  name="type">类型</option>
					<option  name="review">是否审核</option>
				</select>
		<div class="layui-inline">
			<input class="layui-input" name="newsid" id="demoReload" autocomplete="off">
		</div>
		<button class="layui-btn" data-type="reload">搜索</button> -->
	</div>
	<table class="layui-table" lay-data="{url:'${pageContext.request.contextPath}/apply.do',where:{applylevel:'${param.applylevel}'},width : 1219,height : 700, method: 'post', page:true, id:'Usertable'}" lay-filter="demo">
	<thead>
	    <tr>
	        <th lay-data="{field:'applyid',width: '14%', sort: true, fixed: 'left', align: 'center' }">申请id</th>
	        <th lay-data="{field:'userid' ,width: '15%', sort: true,align: 'center'}">用户id</th>
	        <th lay-data="{field:'nickname' ,width: '15%',align: 'center'}">昵称</th>
	        <th lay-data="{field:'applylevel', width:'14%', align: 'center',toolbar :'#level'}">申请职位</th>
	        <th lay-data="{field:'applyreview', width:'14%', align: 'center',toolbar :'#review'}">审核</th>
	        <th lay-data="{field:'applyhandle', width:'14%', align: 'center',toolbar :'#applyhandle'}">是否通过</th>
	        <th lay-data="{fixed: 'right', width:'16%', align:'center', toolbar: '#barDemo'}">操作</th>
	    </tr>
	</thead>
</table>
<script type="text/html" id="barDemo">
{{# if (d.applyreview === 'yes') { }}
    <a class="layui-btn layui-btn-xs  layui-btn-disabled">通过</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs  layui-btn-disabled">不通过</a>
{{# } else { }}
    <a class="layui-btn layui-btn-xs" lay-event="success">通过</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="faild">不通过</a>
{{# } }}
	
</script>
<script type="text/html" id="review">
{{# if (d.applyreview === 'yes') { }}
    <a class="layui-btn layui-btn-xs">已审核</a>
{{# } else { }}
    <a class="layui-btn layui-btn-danger layui-btn-xs">未审核</a>
{{# } }}
</script>
<script type="text/html" id="applyhandle">
{{# if (d.applyhandle === 'yes') { }}
    <a class="layui-btn layui-btn-xs">已通过</a>
{{# } else { }}
    <a class="layui-btn layui-btn-danger layui-btn-xs">未通过</a>
{{# } }}
</script>
<script type="text/html" id="level">
{{# if(d.applylevel == 1){ }}
    <span class="layui-badge layui-bg-blue">记者</span>
{{# } else if(d.applylevel == 2){ }}
	<span class="layui-badge layui-bg-blue">主编</span>
{{# } else { }}
{{# } }}
</script>
<script>
$(function(){
	$("#flushdata").click(function(){
		$("#body_div").load("apply.jsp");
	})
})
    $(function(){layui.use('table', function () {
        var table = layui.table
            , form = layui.form;
        table.init();
        form.render();
        //监听工具条
        table.on('tool(demo)', function (obj) {
            var data = obj.data;
            var article = data.article;
            var applyevent = "";
            var applyid = null;
            var userid = null;
            var applylevel = null;
            var msg ="";
            if (obj.event === 'success') {
            	applyevent = "yes";
            	applyid = data.applyid;
            	userid = data.userid;
            	applylevel = data.applylevel;
            	msg = "通过";
            }else if (obj.event === 'faild') {
            	applyevent = "no";
        		applyid = data.applyid;
        		userid = data.userid;
        		applylevel = data.applylevel;
        		msg = "不通过";
            }
            $.post("${pageContext.request.contextPath}/applyhandle.do",{applyhandle:applyevent,applyid:applyid,userid:userid,applylevel:applylevel},function(data){
            	var text = "";
            	if(data == 1){
            		text = "成功";
            	}else{
            		text = "失败";
            	}
            	layer.open({
	   		        type: 1
	   		        ,offset: 't' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
	   		        ,id: 'layerDemo' //防止重复弹出
	   		        ,content: '<div style="padding: 20px 100px;">'+msg+ text +'</div>'
	   		        ,btn: '关闭'
	   		        ,btnAlign: 'c' //按钮居中
	   		        ,shade: 0 //不显示遮罩
	   		        ,yes: function(){
	   		        	$("#body_div").load("apply.jsp?applylevel=${param.applylevel}");
	   		          	layer.closeAll();
	   		        }
	   		      });
            })
        });
        
        var $ = layui.$, active = {
       	    reload: function(){
       	      var demoReload = $('#demoReload');
       	      //执行重载
       	      table.reload('Usertable', {
       	        page: {
       	          curr: 1 //重新从第 1 页开始
       	        }
       	      }, '');
       	    }
       	  };
    });
})
</script> 
</html>