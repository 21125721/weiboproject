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
	<table class="layui-table" lay-data="{url:'${pageContext.request.contextPath}/showNews.do',width : 1219,height : 700, method: 'post', page:true, id:'Usertable'}" lay-filter="demo">
	<thead>
	    <tr>
	        <th lay-data="{field:'newsid', title: 'ID',width: '6%', sort: true, fixed: 'left', align: 'center' }">文章ID</th>
	        <th lay-data="{field:'userid', width:'7%', sort: true,align: 'center'}">用户id</th>
	        <th lay-data="{field:'title', width:'12%', align: 'center'}">标题</th>
	        <th lay-data="{field:'synopsis', width:'12%', align: 'center'}">简介</th>
	        <th lay-data="{field:'article', width:'22%', align: 'center'}">文章</th>
	        <th lay-data="{field:'type', width:'8%',edit: 'text',sort: true, align: 'center'}">类型</th>
	        <th lay-data="{field:'releasetime', width:'14%',sort: true, align: 'center'}">发布时间</th>
	        <th lay-data="{field:'review', width:'8%',align: 'center',sort: true,toolbar: '#review'}">状态</th>
	        <th lay-data="{fixed: 'right', width:'12%', align:'center', toolbar: '#barDemo'}">操作</th>
	    </tr>
	</thead>
</table>
<script type="text/html" id="barDemo">
{{# if (d.review === 'yes') { }}
    <a class="layui-btn layui-btn-xs layui-btn-disabled" lay-event="success">通过</a>
	<a class="layui-btn layui-btn-xs" lay-event="edit">查看详情</a>
{{# } else { }}
    <a class="layui-btn layui-btn-xs" lay-event="success">通过</a>
	<a class="layui-btn layui-btn-xs" lay-event="edit">查看详情</a>
{{# } }}
</script>
<script type="text/html" id="review">
{{# if (d.review === 'yes') { }}
    <a class="layui-btn layui-btn-xs">已通过</a>
{{# } else { }}
    <a class="layui-btn layui-btn-danger layui-btn-xs">未通过</a>
{{# } }}
</script>
<script>
$(function(){
	$("#flushdata").click(function(){
		$("#body_div").load("checknews.jsp");
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
            if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            } else if (obj.event === 'edit') {
                //layer.alert('编辑行：<br>' + JSON.stringify(data))
                 layer.open({
                    title: [data.title, 'font-size:18px;'],//title
                    type: 1,//入场方式
                    area: ['50%', '80%'],//页面比列
                    content: article
                });
            }else if (obj.event ==='success') {
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
        	    	   $.post("${pageContext.request.contextPath}/passNews.do",{'newsid':data.newsid},function(data){
        	   			var text ="";
        	   			if(data == 0){
        	   				text = "通过失败";
        	   			}else if(data == 1){
        	   				text = "通过成功";
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
       	      }, '');
       	    }
       	  };
        //监听搜索点击按钮
        $('.layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
})
</script> 
</html>