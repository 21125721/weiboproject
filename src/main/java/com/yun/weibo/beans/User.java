package com.yun.weibo.beans;

import java.io.Serializable;
import java.util.UUID;

/**
 * 用户注册实体类
 */
public class User implements Serializable {
    //用户ID
    private UUID userID;
    //在界面上显示的名称
    private String luckyName;
    //用于用户登录
    private String userName;
    //用户的密码
    private String upwd;

    /**
     * 使用一个默认的构造方法，生成用户的ID
     * 使用java.util.UUID随机生成一个UUID
     */
    public User() {
        this.userID = UUID.randomUUID();
    }

    public UUID getUserID() {
        return userID;
    }

    public void setUserID(UUID userID) {
        this.userID = userID;
    }

    public String getLuckyName() {
        return luckyName;
    }

    public void setLuckyName(String luckyName) {
        this.luckyName = luckyName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUpwd() {
        return upwd;
    }

    public void setUpwd(String upwd) {
        this.upwd = upwd;
    }
}
