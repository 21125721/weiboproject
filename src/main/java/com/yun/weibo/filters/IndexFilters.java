package com.yun.weibo.filters;

import com.yun.weibo.beans.User;
import com.yun.weibo.beans.WeiBo;
import com.yun.weibo.services.WeiBoService;
import org.springframework.context.ApplicationContext;

import javax.annotation.Resource;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class IndexFilters implements Filter {
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
        List<WeiBo> allWeibo = weiboService.findAllWeibo();
        req.setAttribute("weibolist",allWeibo);
        List<String> l = new ArrayList();
        String userName = (String) req.getSession().getAttribute("userName");
        if(userName != null && ! "".equals(userName)) {
            List<String> allAttends = weiboService.findAllAttends(userName);
            req.setAttribute("AttendsList", allAttends);
        }
        filterChain.doFilter(req,resp);
    }
    @Resource(name="weiBoService")
    public void setWeiboService(WeiBoService weiboService) {
        this.weiboService = weiboService;
    }

    @Override
    public void destroy() {

    }
}
