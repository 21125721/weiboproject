package com.yun.weibo.utils;

import javax.servlet.*;
import java.io.IOException;

public class InitWebContext extends GenericServlet {
    @Override
    public void init(ServletConfig config) throws ServletException {
        String path = config.getServletContext().getContextPath();
        config.getServletContext().setAttribute("path",path);
        System.out.println(path);
    }

    @Override
    public void service(ServletRequest req, ServletResponse res)
            throws ServletException, IOException {

    }
}
