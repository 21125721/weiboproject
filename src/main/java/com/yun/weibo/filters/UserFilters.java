package com.yun.weibo.filters;

import com.yun.weibo.beans.User;
import com.yun.weibo.services.WeiBoService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.annotation.Resource;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class UserFilters implements Filter {
    //在Filter中注入service
    private static ApplicationContext ctx = null;
    //获取Service
    WeiBoService weiboService= null;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        String userName = (String) req.getSession().getAttribute("userName");
        if(userName != null && ! "".equals(userName)) {
            User user = weiboService.findUserbyUserName(userName);
            req.setAttribute("User", user);
            System.out.println("已登录:"+user.getLuckyName()+"用户");
            filterChain.doFilter(req, resp);
        }else {
            System.out.println("未登录");
            filterChain.doFilter(req, resp);
        }
    }
    @Resource(name="weiBoService")
    public void setWeiboService(WeiBoService weiboService) {
        this.weiboService = weiboService;
    }

    @Override
    public void destroy() {

    }
}
