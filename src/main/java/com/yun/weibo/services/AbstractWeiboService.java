package com.yun.weibo.services;

import com.yun.weibo.beans.User;
import com.yun.weibo.beans.WeiBo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public class AbstractWeiboService
        implements IWeiboService {
    @Override
    public boolean userRegist(User user) {
        return false;
    }

    @Override
    public User userLogin(User user) {
        return null;
    }

    @Override
    public boolean userLogout(User user) {
        return false;
    }

    @Override
    public boolean publishWeiBo(User user, WeiBo wb) {
        return false;
    }

    @Override
    public User findUserbyUserName(String userName) {
        return null;
    }

    @Override
    public int findUserWeiboCount(String userName) {
        return 0;
    }

    @Override
    public int findUserAttendsCount(String userName) {
        return 0;
    }

    @Override
    public int findUserFansCount(String userName) {
        return 0;
    }

    @Override
    public List<WeiBo> findAllWeibo() {
        return null;
    }

    @Override
    public List<WeiBo> findUserWeibo(String userName) {
        return null;
    }

    @Override
    public boolean sendWeibo(WeiBo weiBo, String userName) throws Exception {
        return false;
    }

    @Override
    public List<String> findAllAttends(String userName) throws Exception {
        return null;
    }

    @Override
    public List<String> findAllFans(String userName) throws Exception {
        return null;
    }

    @Override
    public boolean Attends(String userName, String AttendsUserName) throws Exception {
        return false;
    }

    @Override
    public boolean Fans(String userName, String FansUserName) throws Exception {
        return false;
    }

    @Override
    public boolean CancelAttends(String userName, String CancelAttendsUserName) throws Exception {
        return false;
    }

    @Override
    public boolean CancelFans(String userName, String CancelFansUserName) throws Exception {
        return false;
    }


}
