package com.yun.weibo.services;

import com.yun.weibo.beans.WeiBo;
import com.yun.weibo.daoes.WeiBoDao;
import com.yun.weibo.beans.User;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class WeiBoService extends AbstractWeiboService {
    private WeiBoDao dao = null;
    @Override
    public boolean userRegist(User user) {
        try{
            if(dao.queryUser(user)){
                dao.saveUser(user);
            }else{
                return false;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return true;
    }

    @Override
    public User userLogin(User user) {
        User u = new User();
        try{
            u = dao.loginUser(user);
        }catch (Exception e){
            e.printStackTrace();
        }
        return u;
    }

    @Override
    public User findUserbyUserName(String userName) {
        User u = new User();
        try{
            u = dao.findUserbyUserName(userName);
        }catch (Exception e){
            e.printStackTrace();
        }
        return u;
    }

    @Override
    public int findUserWeiboCount(String userName) {
        int row = 0;
        try{
            row = dao.findUserWeiboCount(userName);
        }catch (Exception e){
            e.printStackTrace();
        }
        return row;
    }

    @Override
    public int findUserAttendsCount(String userName) {
        int row = 0;
        try{
            row = dao.findUserAttendsCount(userName);
        }catch (Exception e){
            e.printStackTrace();
        }
        return row;
    }

    @Override
    public int findUserFansCount(String userName) {
        int row = 0;
        try{
            row = dao.findUserFansCount(userName);
        }catch (Exception e){
            e.printStackTrace();
        }
        return row;
    }

    @Override
    public List<WeiBo> findAllWeibo() {
        List<WeiBo> allWeibo = null;
        try {
            allWeibo = dao.findAllWeibo();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return allWeibo;
    }

    @Override
    public List<WeiBo> findUserWeibo(String userName) {
        List<WeiBo> UserWeibo = null;
        try {
            UserWeibo = dao.findUserWeibo(userName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return UserWeibo;
    }

    @Override
    public boolean sendWeibo(WeiBo weiBo, String userName) {
        boolean flag = false ;
        try {
             flag =  dao.sendWeibo(weiBo,userName);
        }catch (Exception e){
            e.printStackTrace();
        }
        return flag;
    }

    public List<String> findAllAttends(String userName){
        List<String> list = null;
        try {
            list = dao.findAllAttends(userName);
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<String> findAllFans(String userName) throws Exception {
        List<String> list = null;
        try {
            list = dao.findAllFans(userName);
        }catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean Attends(String userName, String AttendsUserName) throws Exception {
        boolean flag = false ;
        try {
            flag =  dao.Attends(userName,AttendsUserName);
        }catch (Exception e){
            e.printStackTrace();
        }
        return flag;
    }

    @Override
    public boolean Fans(String userName, String FansUserName) throws Exception {
        boolean flag = false ;
        try {
            flag =  dao.Fans(userName,FansUserName);
        }catch (Exception e){
            e.printStackTrace();
        }
        return flag;
    }

    @Override
    public boolean CancelAttends(String userName, String CancelAttendsUserName) throws Exception {
        boolean flag = false ;
        try {
            flag =  dao.CancelAttends(userName,CancelAttendsUserName);
        }catch (Exception e){
            e.printStackTrace();
        }
        return flag;
    }

    @Override
    public boolean CancelFans(String userName, String CancelFansUserName) throws Exception {
        boolean flag = false ;
        try {
            flag =  dao.CancelFans(userName,CancelFansUserName);
        }catch (Exception e){
            e.printStackTrace();
        }
        return flag;
    }

    public WeiBoDao getDao() {
        return dao;
    }
    @Resource(name="weiBoDao")
    public void setDao(WeiBoDao dao) {
        this.dao = dao;
    }
}
