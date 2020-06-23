$(function() {
    $("#menu2 li a").wrapInner('<span class="out"></span>'); //(内包裹)用span包围选取的a标签里的内容：<a><span>首页</span><a>

    $("#menu2 li a").each(function() { //.each():每个$("#menu2 li a")
        $('<span class="over">' + $(this).text() + '</span>').appendTo(this);
    });

    $("#menu2 li a").hover(function() {
        $(".out", this).stop().animate({
            'top': '40px'
        }, 300); // move down - hide
        $(".over", this).stop().animate({
            'top': '0px'
        }, 300); // move down - show

    }, function() {
        $(".out", this).stop().animate({
            'top': '0px'
        }, 600); // move up - show
        $(".over", this).stop().animate({
            'top': '-40px'
        }, 600); // move up - hide
    });

    // 图片轮播
    $(function() {
            var i = 0;
            var img = $(".banner .img");
            var clone = $(".banner .img li").first().clone();
            $(".banner .img").append(clone);
            var length = $(".banner .img li").length;
            for (j = 0; j < length - 1; j++) {
                var myli = document.createElement("li");
                document.getElementsByClassName("num")[0].appendChild(myli);
            }
            $(".banner .num li").first().addClass("on");

            //左按钮
            $(".banner .btn_l").click(function() {
                moveR();
            })


            //右按钮
            $(".banner .btn_r").click(function() {
                moveL();
            })

            function moveL() {
                i++;
                if (i == length) {
                    $(".banner .img").css({
                        left: 0
                    });
                    i = 1;
                }
                img.stop().animate({
                    // .stop停止所有在指定元素上正在运行的动画
                    left: -i * 600
                }, 600);
                if (i == length - 1) {
                    $(".newsTitle").first().css("left", "4230px");
                    $(".banner .num li").eq(0).addClass("on").siblings().removeClass("on");
                } else {
                    $(".banner .num li").eq(i).addClass("on").siblings().removeClass("on");
                }
            }

            function moveR() {
                i--;
                if (i == -1) {
                    $(".banner .img").css({
                        left: -(length - 1) * 600
                    });
                    i = length - 2;
                }
                img.stop().animate({
                    left: -i * 600
                }, 600);
                $(".banner .num li").eq(i).addClass("on").siblings().removeClass("on");
                // sibling()函数用于选取每个匹配元素的所有同辈元素(不包括自己)，并以jQuery对象的形式返回
            }

            // 定时轮播
            var t = setInterval(moveL, 3000);
            $(".banner .img").hover(function() {
                    clearInterval(t)
                },
                function() {
                    t = setInterval(moveL, 3000)
                });
                
            // 鼠标点击圆点
            $(".banner .num li").click(function() {
                var index = $(this).index();
                img.animate({
                    left: -index * 600
                }, 600);
                $(this).addClass("on").siblings().removeClass("on");
                i = index; //划出圆点时从下一张开始播放
                clearInterval(t);
            })
        })
    
        // 返回顶部
    if ($('#back-to-top').length) {
        var scrollTrigger = 100; // px

        // $(window).scrollTop()与 $(document).scrollTop()产生结果一样
        // 一般使用document注册事件，window使用情况如 scroll, scrollTop, resize
        $(window).on('scroll', function() {
            if ($(window).scrollTop() > scrollTrigger) {
                $('#back-to-top').addClass('show');
            } else {
                $('#back-to-top').removeClass('show');
            }
        });

        $('#back-to-top').on('click', function() {
            // html,body 都写是为了兼容浏览器
            $('html,body').animate({
                scrollTop: 0
            }, 600);
            return false; //在大多数情况下，为事件处理函数返回false，可以防止默认的事件行为。例如默认情况下点击一个<a>元素，页面会跳转到该元素href属性指定的页。
        });
    }

})
function login(){
	$(".login_childdiv").css("display","block");
		}
function closelogin(){
	$(".login_childdiv").css("display","none");
} 