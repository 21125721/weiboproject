package com.yun.weibo.daoes;

import com.yun.weibo.beans.User;
import com.yun.weibo.beans.WeiBo;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface IWeiBoDao {
    public void init();
    public void saveUser(User user) throws Exception;
    public boolean saveWeiBo(User user, WeiBo wb) throws Exception;
    public boolean queryUser(User user) throws Exception;
    public User loginUser(User user) throws Exception;
    public User findUserbyUserName(String userName) throws Exception;
    public int findUserWeiboCount(String userName) throws IOException;
    public int findUserAttendsCount(String userName) throws IOException, Exception;
    public int findUserFansCount(String userName) throws IOException, Exception;
    public List<WeiBo> findAllWeibo() throws Exception;
    public List<WeiBo> findUserWeibo(String userName) throws Exception;
    public boolean sendWeibo(WeiBo weiBo,String userName) throws Exception;
    public String findUserIdbyUserName(String userName) throws Exception;
    public List<String> findAllAttends(String userName) throws Exception;
    public List<String> findAllFans(String userName) throws Exception ;
    public boolean Attends(String userName, String AttendsUserName) throws Exception;
    public boolean Fans(String userName, String FansUserName) throws Exception;
    public boolean CancelAttends(String userName, String CancelAttendsUserName) throws Exception;
    public boolean CancelFans(String userName, String CancelFansUserName) throws Exception;
}
