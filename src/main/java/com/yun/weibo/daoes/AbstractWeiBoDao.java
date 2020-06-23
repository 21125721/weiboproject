package com.yun.weibo.daoes;

import org.apache.hadoop.hbase.client.Connection;
import com.yun.weibo.beans.User;
import com.yun.weibo.beans.WeiBo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class AbstractWeiBoDao implements IWeiBoDao {
    //@Resource(name="connection")
    protected Connection connection;
    public AbstractWeiBoDao(){

    }
    public AbstractWeiBoDao(Connection connection){
        this.connection = connection;
    }
    @Override
    public void init() {

    }

    @Override
    public void saveUser(User user) throws Exception {
    }

    @Override
    public boolean saveWeiBo(User user, WeiBo wb) throws Exception {
        return false;
    }

    @Override
    public boolean queryUser(User user) throws Exception {
        return true;
    }

    @Override
    public User loginUser(User user) throws Exception {
        return null;
    }

    @Override
    public User findUserbyUserName(String userName) throws Exception {
        return null;
    }

    @Override
    public int findUserWeiboCount(String userName) throws IOException {
        return 0;
    }

    @Override
    public int findUserAttendsCount(String userName) throws Exception {
        return 0;
    }

    @Override
    public int findUserFansCount(String userName) throws Exception {
        return 0;
    }

    @Override
    public List<WeiBo> findAllWeibo() throws Exception {
        return null;
    }

    @Override
    public List<WeiBo> findUserWeibo(String userName) throws Exception {
        return null;
    }

    @Override
    public boolean sendWeibo(WeiBo weiBo,String userName) throws Exception {
        return false;
    }

    @Override
    public String findUserIdbyUserName(String userName) throws Exception {
        return null;
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

    public void setConnection(Connection conn){
        this.connection = conn;
    }
}
