<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title></title>
 <link href="css/confirm.css" rel="stylesheet" type="text/css" />
</head>
<body>
 	<c:import url="top.jsp"></c:import>
 	<div id="content">
 	    <ul id="ul1">
 	    	<li><div class="step">1</div><div style="position: absolute;left:100px;">填写信息</div></li>
 	    	<li><div class="step">2</div><div style="position: absolute;left:100px;">验证</div></li>
 	    	<li><div class="step">3</div><div style="position: absolute;left:100px;">注册成功</div></li>
 	    </ul>
 		<div id="confirm">
 		    <!-- <img src="" class="img"> -->
 			 <div id="time"></div>
                <input type="button" id="check" value="发送验证码" onclick="timecut()">
                <input type="text" id="text" placeholder="请输入验证码" >
                <input id="btn" type="button" value="确认" width="400px" disabled="true">
            </div>
 		</div>
 	</div>
 	<div id="bottom">©2019 News-Team All rights reserved.</div>
 </div>
 <script src="js/jquery-3.2.1.min.js"></script>
 <script src="js/home.js">
    </script>
</body>
    <script type="text/javascript">
    	var step=document.getElementsByClassName('step');
    	var content=document.getElementById('content');
    	var confirm=document.getElementById('confirm');
    	var btn=document.getElementById('btn');
    	var li=content.getElementsByTagName('ul')[0].getElementsByTagName('li');
    	li[1].style.color='black';
    	step[1].style.background='#33cc66';
    	// confirm.getElementsByTagName('img')[0].src='images/'+1+'.jpg';
    	window.onload=function(){
    		var a=document.getElementById('text');
        a.onfocus=function(){
             if (a.value!=null) {
                a.value='';
             }
        }
        var b=document.getElementById('check');
        var i=5;
        var d;
        b.onclick=function timecut(){
               
                var c=document.getElementById('time');
                var e=document.getElementById('check');
                c.innerHTML=i;
                i--;
                
             if(c.innerHTML==0){
                     d=Math.floor(Math.random()*10000)+10000;
                    alert(d);
                    i=5;
                   e.value="重新发送验证码";
                clearTimeout(timer);
                return;
                
                }
                timer=setTimeout(timecut,1000);
        }
        a.onblur=function(){
            a.value==a.innerHTML;
            if(a.value!=d){
                alert('验证码错误！');
                btn.style.background="#d4d4d4";
                btn.disabled=true;
            }
            if (a.value==d) {
                btn.style.background="#33cc66";
                btn.disabled=false;
            }
        }
		    btn.onclick=function(){
		    	window.location.href="finish.jsp";
		    }
    	}
    	
    </script>
</html>