package com.yun.weibo.services;

import com.yun.weibo.beans.User;
import com.yun.weibo.beans.WeiBo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface IWeiboService {
    public boolean userRegist(User user);
    public User userLogin(User user);
    public boolean userLogout(User user);
    public boolean publishWeiBo(User user, WeiBo wb);
    public User findUserbyUserName(String userName);
    public int findUserWeiboCount(String userName);
    public int findUserAttendsCount(String userName);
    public int findUserFansCount(String userName);
    public List<WeiBo> findAllWeibo();
    public List<WeiBo> findUserWeibo(String userName);
    public boolean sendWeibo(WeiBo weiBo,String userName) throws Exception;
    public List<String> findAllAttends(String userName) throws Exception;
    public List<String> findAllFans(String userName) throws Exception ;
    public boolean Attends(String userName, String AttendsUserName) throws Exception;
    public boolean Fans(String userName, String FansUserName) throws Exception;
    public boolean CancelAttends(String userName, String CancelAttendsUserName) throws Exception;
    public boolean CancelFans(String userName, String CancelFansUserName) throws Exception;
}
