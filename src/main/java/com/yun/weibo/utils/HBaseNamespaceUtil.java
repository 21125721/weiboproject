
package com.yun.weibo.utils;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.*;
import org.apache.hadoop.hbase.client.*;
import org.apache.hadoop.hbase.filter.*;
import org.apache.hadoop.hbase.util.Bytes;
import org.jetbrains.annotations.NotNull;
import com.yun.weibo.beans.User;
import com.yun.weibo.beans.WeiBo;
import org.junit.Test;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 该类用于实现对HBase当中的命名空间的操作
 */

public class HBaseNamespaceUtil {
    private static Configuration configuration;
    private static Connection connection;


    /**
     * 获得用于HBase连接的连接对象
     * @return HBase的连接对象
     * @throws IOException
     */

    public static Connection getConnection() throws IOException {
        //创建HBase操作的Configuration对象
        configuration = HBaseConfiguration.create();
        //读取属性文件，获得配置信息
        Properties prop = System.getProperties();
        InputStream is = HBaseNamespaceUtil.class.getClassLoader()
                .getResourceAsStream("hbase_conf.properties");
        prop.load(is);
        //设置配置属性
        configuration.set(NamedFinalClass.HBASE_ZOOKEEPER_QUORUM,
                prop.getProperty(NamedFinalClass.HBASE_HOST));
        configuration.set(NamedFinalClass.HBASE_ZOOKEEPER_PROPERTY_CLIENT_PORT,
                prop.getProperty(NamedFinalClass.HBASE_CLIENT_PORT));
        configuration.set(NamedFinalClass.HBASE_MASTER,
                prop.getProperty(NamedFinalClass.HBASE_MASTER_VALUE));
        //先获得HBase的连接对象
        connection = ConnectionFactory.createConnection(configuration);
        return connection;
    }


    /**
     * 判断命名空间是否存在
     * @param namespace
     * @return
     */

    public boolean namespaceExists(String namespace) {
        boolean flag = false;
        Connection conn = null;
        Admin admin = null;
        NamespaceDescriptor nd = null;
        try {
            conn = getConnection();
            admin = conn.getAdmin();
            nd = admin.getNamespaceDescriptor(namespace);
            flag = true;
        }
        catch (NamespaceNotFoundException ne){
            ne.printStackTrace();
            flag = false;
        }
        catch (IOException e){
            e.printStackTrace();
            flag = false;
        }
        return flag;
    }


    /**
     * 创建HBase的命名空间
     * @throws IOException
     */

    public void createNameSpace(String namespace) throws IOException {
        //获得Connection对象
        Connection connection = getConnection();
        //获取Admin对象
        Admin admin = connection.getAdmin();
        //判断HBase库中是否存在指定名称的命名空间
        if(namespaceExists(namespace)){
            System.out.println("指定名称的命名空间已经存在.........");
            return;
        }
        //获得NamespaceDescriptor对象
        NamespaceDescriptor descriptor = NamespaceDescriptor
                .create(namespace).build();
        //创建NameSpace
        admin.createNamespace(descriptor);
        //关闭资源
        admin.close();
        connection.close();
    }


    /**
     * 创建HBase表
     * @throws IOException
     */

    public void createTable(String tableName, @NotNull String...columnFamily)
            throws IOException {
        //在创建表时，至少要有一个列簇
        if(columnFamily.length<1){
            System.out.println("在HBase当中创建表，必须至少要有一个列簇.....");
            return;
        }
        //获得连接对象
        Connection connection = getConnection();
        //获得Admin对象
        Admin admin = connection.getAdmin();
        //定义列簇集合
        List<ColumnFamilyDescriptor> columnList = new ArrayList<>();
        //创建表的列簇描述器对象
        for(String cf : columnFamily) {
            ColumnFamilyDescriptorBuilder cfBuilder = ColumnFamilyDescriptorBuilder
                    .newBuilder(Bytes.toBytes(cf));
            ColumnFamilyDescriptor cfd = cfBuilder.build();
            columnList.add(cfd);
        }
        //创建表描述器对象
        TableName tName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        TableDescriptorBuilder builder = TableDescriptorBuilder.newBuilder(tName);
        //在表描述器对象上加入列簇
        builder.setColumnFamilies(columnList);
        TableDescriptor tableDescriptor = builder.build();
        //判断要创建的表是否存在
        if(admin.tableExists(tName)){
            System.out.println("表已经存在......");
            return;
        }
        //创建表
        admin.createTable(tableDescriptor);
        //关闭资源
        admin.close();
        connection.close();
    }

    /**
     * 用户注册就是向HBase中的weibo:relations表中插入数据，
     * 写的列簇是info
     * @param user
     */
    public void registUser(User user) throws IOException {

        //获得连接对象
        Connection conn = getConnection();
        //获得注册时的时间
        long ts = System.currentTimeMillis();
        //获得要操作的表
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = conn.getTable(tableName);
        //向表中插入数据，Put对象需要一个RowKey，而这个RowKey就是User对象中的userID
        Put put = new Put(Bytes.toBytes(user.getUserID().toString()));
        put.addColumn(Bytes.toBytes("info"),
                Bytes.toBytes("userName"),ts,
                Bytes.toBytes(user.getUserName()));
        put.addColumn(Bytes.toBytes("info"),
                Bytes.toBytes("luckyName"),ts,
                Bytes.toBytes(user.getLuckyName()));
        put.addColumn(Bytes.toBytes("info"),
                Bytes.toBytes("upwd"),ts,
                Bytes.toBytes(user.getUpwd()));
        //写入数据
        table.put(put);
        //关闭资源
        table.close();
        conn.close();
    }

    @Test
    public void test(){
        String text = "hadoop_2020";
        String[] s = text.split("_");
        System.out.println(s.length);
        System.out.println(s[0]);
        System.out.println(s[1]);
    }

    /**
     * 用户注册就是向HBase中的weibo:relations表中插入数据，
     * 写的列簇是info
     *
     */
    @Test
    public void registWeibo() throws IOException {

        //获得连接对象
        Connection conn = getConnection();
        //获得注册时的时间
        long ts = System.currentTimeMillis();
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = formatter.format(date);
        //获得要操作的表
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = conn.getTable(tableName);
        //向表中插入数据，Put对象需要一个RowKey，而这个RowKey就是User对象中的userID
        Put put = new Put(Bytes.toBytes(/*UUID.randomUUID().toString()*/
                "c4941c35-0c6f-4ac0-877d-a1453f612702"));
        put.addColumn(Bytes.toBytes("attends"),
                Bytes.toBytes("attends_mike@163.com"),ts,
                Bytes.toBytes("smith@163.com"));
        /*put.addColumn(Bytes.toBytes("weibo"),
                Bytes.toBytes("content"),ts,
            Bytes.toBytes("要想赢，就一定不能怕输。不怕输，结果未必能赢。但是怕输，结果则一定是输。"));*/
        /*put.addColumn(Bytes.toBytes("weibo"),
                ("mike@163.com_"+time).getBytes(),ts,
                Bytes.toBytes("今天天气真好啊！！！！！"));*/
        /*put.addColumn(Bytes.toBytes("info"),
                Bytes.toBytes("luckyName"),ts,
                Bytes.toBytes("Mike"));
        put.addColumn(Bytes.toBytes("info"),
                Bytes.toBytes("upwd"),ts,
                Bytes.toBytes("mike"));
        put.addColumn(Bytes.toBytes("info"),
                Bytes.toBytes("userName"),ts,
                Bytes.toBytes("mike@163.com"));*/
        //写入数据
        table.put(put);
        /*Scan scan =new Scan();
        SingleColumnValueFilter f = new SingleColumnValueExcludeFilter(
                "weibo".getBytes(),
                "userName".getBytes(), CompareFilter.CompareOp.EQUAL,
                "mike@163.com".getBytes());
        FamilyFilter ffliter = new FamilyFilter(CompareOperator.EQUAL,new BinaryComparator(Bytes.toBytes("info")));
        scan.setFilter(f);
        ResultScanner scanner = table.getScanner(scan);
        Iterator<Result> it = scanner.iterator();
        int row = 0;
        while (it.hasNext()){
            Result r = it.next();
            Cell[]  cells = r.rawCells();
            for(Cell cell : cells){
                //if(Bytes.toString(CellUtil.cloneQualifier(cell)).equals("content") ){
                    System.out.println(new String(CellUtil.cloneRow(cell)));
                    System.out.println(new String(CellUtil.cloneFamily(cell)));
                    System.out.println(new String(CellUtil.cloneValue(cell)));
                    row += 1;
                //}
            }
        }
        System.out.println(row);*/
        //关闭资源
        table.close();
        conn.close();
    }

    /* 用户注册
     * @param user
     * @param tname
     * @param cfamily
     * @param cname
     * @throws IOException
     */

    public void registUser(User user,String tname,String cfamily,String ... cname)
            throws IOException {
        //获得连接对象
        Connection conn = getConnection();
        //创建一个当前时间戳
        long ts = System.currentTimeMillis();
        //获得要操作的表
        TableName tableName = TableName.valueOf(tname);
        Table table = conn.getTable(tableName);
        //向表中插入数据，Put对象需要一个RowKey，而这个RowKey就是User对象中的userID
        Put put = new Put(Bytes.toBytes(user.getUserID().toString()));
        //定义列簇
        byte[] cf = Bytes.toBytes(cfamily);
        for(String col : cname){
            //定义列名的字节数组
            byte[] qualifer = Bytes.toBytes(col);
            //获得列的值——使用反射机制
            try {
                //从传入的对象当中查找相应的域
                Field field = user.getClass().getDeclaredField(col);
                //直接使用域访问
                byte[] value = null;
                field.setAccessible(true);
                Class clazz = field.getType();
                if(clazz.getName().contains("String")){
                    //获得值
                    value = Bytes.toBytes((String) field.get(user));
                }
                put.addColumn(cf,qualifer,ts,value);
            }
            catch (NoSuchFieldException e){
                e.printStackTrace();
            }
            catch (IllegalAccessException e){
                e.printStackTrace();
            }
        }
        //写入数据
        table.put(put);
        //关闭资源
        table.close();
        conn.close();
    }


    /**
     * 发布微博
     * @param wb
     * @param tname
     * @param cname
     */

    public void publishWeibo(WeiBo wb,String tname,String cfamily,String ... cname)
            throws IOException {
        //获得连接对象
        Connection conn = getConnection();
        //获得表对象
        TableName contentName = TableName.valueOf(tname);
        Table content = conn.getTable(contentName);
        //在表微博内容表中存储微博信息
        long ts = System.currentTimeMillis();
        String uid = wb.getUser().getUserID().toString();
        String contentId = uid + "_" + ts;
        Put put = new Put(Bytes.toBytes(contentId));
        byte[] cf = Bytes.toBytes(cfamily);
        //列簇
        for (String col : cname){
            byte[] qualifer = Bytes.toBytes(col);
            byte[] value = null;
            try {
                Field field = wb.getClass().getDeclaredField(col);
                field.setAccessible(true);
                Class clazz = field.getType();
                if(clazz.getName().contains("String")){
                    value = Bytes.toBytes((String)field.get(wb));
                }
                else{
                    value = wb.getImage();
                }
            }
            catch (Exception e){
                e.printStackTrace();
            }
            put.addColumn(cf,qualifer,ts,value);
        }
        content.put(put);
        //从用户关系表中查询好友（关注，粉丝）
        TableName relationsName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table relations = conn.getTable(relationsName);
        Get get = new Get(Bytes.toBytes(wb.getUser().getUserID().toString()));
        //如果仅给粉丝推送消息，在此只需要获得粉丝用户列表即可
        //get.addFamily(Bytes.toBytes("attends"));
        get.addFamily(Bytes.toBytes("fans"));
        Result result = relations.get(get);
        //无论是attends还是fans都需要在receive_content_email中插入数据
        //使用一个列表存储用户ID
        List<byte[]> userids = new ArrayList<>();
        for(Cell cell : result.listCells()){
            userids.add(CellUtil.cloneValue(cell));
        }
        //在表收件箱发送发布微博通知
        TableName receiveContentEmailName = TableName.valueOf(
                NamedFinalClass.RECEIVE_CONTENT_EMAIL_TABLE_NAME);
        Table receiveContentEmail = conn.getTable(receiveContentEmailName);
        //如果用户是互相关注，在此插入数据就会有两条相同的数据
        for (byte[] userid : userids){
            Put tmp = new Put(userid);
            tmp.addColumn(Bytes.toBytes("info"),userid,ts,Bytes.toBytes(contentId));
            receiveContentEmail.put(put);
        }
        //关闭资源
        relations.close();
        content.close();
        receiveContentEmail.close();
        conn.close();
    }




    /**
     * 关注
     * @param userid
     * @param wbid
     * @param cfamily
     */
    public void attend(String tname,String userid,String wbid,String cfamily,String strFans)
            throws IOException {
        Connection conn = getConnection();
        TableName relationsName = TableName.valueOf(tname);
        Table relations = conn.getTable(relationsName);
        long ts = System.currentTimeMillis();
        String[] strs = wbid.split("_");
        Put attends = new Put(Bytes.toBytes(userid));
        attends.addColumn(Bytes.toBytes(cfamily),Bytes.toBytes(strs[0]),ts,Bytes.toBytes(strs[0]));
        relations.put(attends);
        Put fans = new Put(Bytes.toBytes(strs[0]));
        fans.addColumn(Bytes.toBytes(strFans),Bytes.toBytes(userid),ts,Bytes.toBytes(userid));
        relations.put(fans);
        relations.close();
        conn.close();
    }

    @Test
    public void TestDelete() throws Exception {
        String userName = "mike@163.com";
        String CancelFansUserName = "smith@163.com";
        Connection connection = getConnection();
            //获得注册时的时间
            long ts = System.currentTimeMillis();
            //获得要操作的表
            TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
            Table table = connection.getTable(tableName);
            //向表中插入数据，Put对象需要一个RowKey，而这个RowKey就是User对象中的userID
            Delete delete = new Delete(Bytes.toBytes("c4941c35-0c6f-4ac0-877d-a1453f612702"));
            delete.addColumn(Bytes.toBytes("fans"),Bytes.toBytes("fans_"+userName));
            table.checkAndDelete(
                    Bytes.toBytes("c4941c35-0c6f-4ac0-877d-a1453f612702"),
                    Bytes.toBytes("fans"),
                    Bytes.toBytes("fans_"+userName),
                    CompareFilter.CompareOp.LESS_OR_EQUAL,
                    Bytes.toBytes(CancelFansUserName),delete);

    }
}

