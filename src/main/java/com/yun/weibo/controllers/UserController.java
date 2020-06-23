package com.yun.weibo.controllers;

import com.yun.weibo.beans.User;
import com.yun.weibo.beans.WeiBo;
import com.yun.weibo.services.WeiBoService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
@Scope("prototype")
public class UserController {

    @Resource
    private WeiBoService weiboservice;


    @RequestMapping("/register.do")
    public ModelAndView registUser(User user, String repwd, Model model) {
        ModelAndView mav = new ModelAndView();
        if (!user.getUpwd().equals(repwd)) {
            model.addAttribute("repwd", "两次密码输入不一致");
            mav.setViewName("regist.jsp");
        } else if (weiboservice.userRegist(user)) {
            mav.setViewName("redirect:index.jsp");
        } else {
            model.addAttribute("userName", "邮箱已存在");
            mav.setViewName("regist.jsp");
        }
        return mav;
    }


    @RequestMapping("/login.do")
    @ResponseBody
    public Object loginUser(User user, HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        if (user.getUserName() != null && user.getUpwd() != null
                && !user.getUserName().equals("") && !user.getUpwd().equals("")) {
            User u = weiboservice.userLogin(user);
            if (u != null) {
                req.getSession().setAttribute("userName", u.getUserName());
                return u;
            } else {
                return 1;
            }
        } else {
            return 0;
        }

    }

    @RequestMapping("/loginout.do")
    public ModelAndView loginOutUser(HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        if (req.getSession().getAttribute("userName") != null) {
            req.getSession().removeAttribute("userName");
            mav.setViewName("redirect:index.jsp");
        } else {
            mav.setViewName("redirect:index.jsp");
        }
        return mav;
    }

    @RequestMapping("/userinfo.do")
    public ModelAndView userInfo(HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        String userName = (String) req.getSession().getAttribute("userName");
        if (userName != null) {
            int row = weiboservice.findUserWeiboCount(userName);
            int Attends_row = weiboservice.findUserAttendsCount(userName);
            int Fans_row = weiboservice.findUserFansCount(userName);
            List<WeiBo> userWeibo = weiboservice.findUserWeibo(userName);
            mav.addObject("Weibo_count", row);
            mav.addObject("Attends_count", Attends_row);
            mav.addObject("Fans_count", Fans_row);
            mav.addObject("userWeibo", userWeibo);
            mav.setViewName("userinfo.jsp");
        } else {
            mav.setViewName("redirect:index.jsp");
        }
        return mav;
    }

    @RequestMapping("/sendWeibo.do")
    public ModelAndView sendWeibo(WeiBo weiBo, HttpServletRequest req) {
        ModelAndView mav = new ModelAndView();
        String userName = (String) req.getSession().getAttribute("userName");
        if (userName != null) {
            boolean b = weiboservice.sendWeibo(weiBo, userName);
            if (b) {
                mav.addObject("sendWeibo", "发布成功！");
                mav.setViewName("userinfo.do");
            } else {
                mav.addObject("sendWeibo", "发布失败！");
                mav.setViewName("userinfo.do");
            }

        } else {
            mav.setViewName("redirect:index.jsp");
        }
        return mav;
    }

    @RequestMapping("/attendsjsp.do")
    public ModelAndView attends(String t,HttpServletRequest req,
                                HttpServletResponse resp) throws Exception {
        String userName = (String) req.getSession().getAttribute("userName");
        ModelAndView mav = new ModelAndView();
        if (userName != null && !"".equals(userName)) {
           if(t.equals("attends")){
               List<String> allAttends = weiboservice.findAllAttends(userName);
               List<User> list = new ArrayList<>();
               for (String name : allAttends) {
                   User user = weiboservice.findUserbyUserName(name);
                   list.add(user);
               }
               mav.addObject("UserAttends", list);
               mav.setViewName("attends.jsp?t=attends");
           }else if (t.equals("fans")){
               List<String> allAttends = weiboservice.findAllFans(userName);
               List<User> list = new ArrayList<>();
               for (String name : allAttends) {
                   User user = weiboservice.findUserbyUserName(name);
                   list.add(user);
               }
               List<String> attends = weiboservice.findAllAttends(userName);
               mav.addObject("UserFans", list);
               mav.addObject("Attends", attends);
               mav.setViewName("attends.jsp?t=fans");
           }else if (t.equals("weibo")){
               List<WeiBo> userWeibo = weiboservice.findUserWeibo(userName);
               mav.addObject("UserWeiboList", userWeibo);
               mav.setViewName("attends.jsp?t=weibo");
           }
        }
        return mav;
    }


    @RequestMapping("/attends.do")
    public void AttendsUser(String t,String AttendsUserName, HttpServletRequest req
            , HttpServletResponse resp) throws Exception {
        String type = t;
        String userName = (String) req.getSession().getAttribute("userName");
        if(userName != null && !"".equals(userName)){
            boolean attends = weiboservice.Attends(userName, AttendsUserName);
            boolean fans = weiboservice.Fans(AttendsUserName, userName);
            List<WeiBo> allWeibo = weiboservice.findAllWeibo();
            req.setAttribute("weibolist",allWeibo);
            if (attends && fans && t.equals("index")){
                resp.sendRedirect("index.jsp");
            }else if(attends && fans && t.equals("myfans")){
                resp.sendRedirect("attendsjsp.do?t=fans");
            }
        }
    }

    @RequestMapping("/cancelAttends.do")
    public void cancelAttendsUser(String t,String CancelAttendsUserName,
           HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String userName = (String) req.getSession().getAttribute("userName");
        if(userName != null && !"".equals(userName)){
            boolean Cancelattends =
                    weiboservice.CancelAttends(userName,CancelAttendsUserName);
            boolean CancelFans = weiboservice.CancelFans(CancelAttendsUserName, userName);
            List<WeiBo> allWeibo = weiboservice.findAllWeibo();
            req.setAttribute("weibolist",allWeibo);
            if(Cancelattends && CancelFans && t.equals("myattends")){
                resp.sendRedirect("attendsjsp.do?t=attends");
            }else if(Cancelattends && CancelFans && t.equals("myfans")){
                resp.sendRedirect("attendsjsp.do?t=fans");
            }else if(Cancelattends && CancelFans && t.equals("index")){
                resp.sendRedirect("index.jsp");
            }



        }
    }

    @RequestMapping("/appendWeibo.do")
    public void appendWeibo(String CancelAttendsUserName,
                     HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String userName = (String) req.getSession().getAttribute("userName");
        if(userName != null && !"".equals(userName)){
            boolean Cancelattends =
                    weiboservice.CancelAttends(userName,CancelAttendsUserName);
            boolean CancelFans = weiboservice.CancelFans(CancelAttendsUserName, userName);
            List<WeiBo> allWeibo = weiboservice.findAllWeibo();
            req.setAttribute("weibolist",allWeibo);
            if (Cancelattends && CancelFans){
                resp.sendRedirect("index.jsp");
            }else{
                resp.sendRedirect("index.jsp");
            }
        }
    }



}
