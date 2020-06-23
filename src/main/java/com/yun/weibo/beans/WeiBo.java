package com.yun.weibo.beans;

import java.io.Serializable;

/**
 * 微博实体类
 */
public class WeiBo implements Serializable {
    private String wbid;
    private String time;
    private String subject;
    private String content;
    private String imgurl;
    private byte[] image;
    private User user;

    public String getWbid() {
        return wbid;
    }

    public void setWbid(String wbid) {
        this.wbid = wbid;
    }

    public String getTime() { return time; }

    public void setTime(String time) { this.time = time; }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImgurl() {
        return imgurl;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = imgurl;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
