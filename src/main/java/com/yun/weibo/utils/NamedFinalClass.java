package com.yun.weibo.utils;

/**
 * 该类用于在项目中应用的常量
 */
public final class NamedFinalClass {
    /**
     * 定义Hbase当中的命名空间的名称
     */
    public static final String NAMESPACE_NAME = "weibo";
    /**
     * 定义在HBase当中的表的名称
     * 存储用户关系的表，同时加上命名空间的名称
     */
    public static final String RELATIONS_TABLE_NAME = "weibo:relations";
    /**
     * 定义在HBase当中的表的名称
     * 存储用户发布微博内容的表，同时加上命名空间的名称
     */
    public static final String CONTENT_TABLE_NAME = "weibo:content";
    /**
     * 定义在HBase当中的表的名称
     * 存储用户收件箱信息的表，同时加上命名空间的名称
     */
    public static final String RECEIVE_CONTENT_EMAIL_TABLE_NAME
            = "weibo:receive_content_email";
    /**
     * 定义hbase操作的配置信息的常量
     */
    public static final String HBASE_MASTER = "hbase.master";
    public static final String HBASE_MASTER_VALUE = "hbase_master";
    public static final String HBASE_ZOOKEEPER_QUORUM ="hbase.zookeeper.quorum";
    public static final String HBASE_ZOOKEEPER_PROPERTY_CLIENT_PORT
            = "hbase.zookeeper.property.clientPort";
    public static final String HBASE_HOST = "hbase_host";
    public static final String HBASE_CLIENT_PORT = "hbase_client_port";
    public static final String COLUMN_FAMILY_INFO = "info";
    public static final String COLUMN_FAMILY_ATTENDS = "attends";
    public static final String COLUMN_FAMILY_FANS = "fans";
}
