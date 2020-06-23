package com.yun.weibo.daoes;

import com.yun.weibo.beans.User;
import com.yun.weibo.beans.WeiBo;
import com.yun.weibo.utils.HBaseNamespaceUtil;
import com.yun.weibo.utils.NamedFinalClass;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomUtils;
import org.apache.hadoop.hbase.Cell;
import org.apache.hadoop.hbase.CellUtil;
import org.apache.hadoop.hbase.CompareOperator;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.*;
import org.apache.hadoop.hbase.filter.*;
import org.apache.hadoop.hbase.util.Bytes;
import com.yun.weibo.beans.User;
import com.yun.weibo.utils.NamedFinalClass;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class WeiBoDao extends AbstractWeiBoDao {
    private Connection connection=null;
    @Override
    public void saveUser(User user) throws Exception {
        System.out.println("查看Hbase的connection对象");
        //获得连接对象(连接对象使用SpringIoC注入）
        //获得注册时的时间
        long ts = System.currentTimeMillis();
        //获得要操作的表
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = connection.getTable(tableName);
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
    }

    @Override
    public boolean queryUser(User user) throws Exception {
        User user1 = new User();
        //获得要操作的表
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = connection.getTable(tableName);
        Scan scan =new Scan();
        //设置一个列的过滤器专门过滤age列
        FilterList flist = new FilterList();
        SingleColumnValueFilter f = new SingleColumnValueExcludeFilter(
                "info".getBytes(),
                "userName".getBytes(), CompareFilter.CompareOp.EQUAL,
                user.getUserName().getBytes());
        flist.addFilter(f);
        scan.setFilter(flist);
        ResultScanner scanner = table.getScanner(scan);
        Iterator<Result> it = scanner.iterator();
        if(it.hasNext()) {
            return false;
        }else{
            return true;
        }
    }

    @Override
    public User loginUser(User user) throws Exception {
        User user1 = null;
        //获得要操作的表
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = connection.getTable(tableName);
        Scan scan =new Scan();
        //设置一个列的过滤器专门过滤age列
        FilterList flist = new FilterList(FilterList.Operator.MUST_PASS_ALL);
        SingleColumnValueFilter f = new SingleColumnValueFilter(
                "info".getBytes(),
                "userName".getBytes(), CompareFilter.CompareOp.EQUAL,
                user.getUserName().getBytes());
        SingleColumnValueFilter f2 = new SingleColumnValueFilter(
                "info".getBytes(),
                "upwd".getBytes(), CompareFilter.CompareOp.EQUAL,
                user.getUpwd().getBytes());
        flist.addFilter(f);
        flist.addFilter(f2);
        scan.setFilter(flist);
        ResultScanner scanner = table.getScanner(scan);
        Iterator<Result> it = scanner.iterator();
        while (it.hasNext()) {
            Result r = it.next();
            Cell[]  cells = r.rawCells();
            for(Cell cell : cells){
                if(Bytes.toString(CellUtil.cloneFamily(cell)).equals("info") ){
                    user1 = new User();
                    user1.setLuckyName(Bytes.toString(
                            r.getValue(Bytes.toBytes("info")
                                    ,Bytes.toBytes("luckyName"))));
                    user1.setUserName(user.getUserName());
                }
            }
        }
        return user1;
    }

    @Override
    public User findUserbyUserName(String userName) throws Exception {
        User user1 = null;
        //获得要操作的表
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = connection.getTable(tableName);
        Scan scan =new Scan();
        //设置一个列的过滤器专门过滤age列
        FilterList flist = new FilterList(FilterList.Operator.MUST_PASS_ALL);
        SingleColumnValueFilter f = new SingleColumnValueFilter(
                "info".getBytes(),
                "userName".getBytes(), CompareFilter.CompareOp.EQUAL,
                userName.getBytes());
        flist.addFilter(f);
        scan.setFilter(flist);
        ResultScanner scanner = table.getScanner(scan);
        Iterator<Result> it = scanner.iterator();
        while (it.hasNext()) {
            Result r = it.next();
            Cell[]  cells = r.rawCells();
            for(Cell cell : cells){
                if(Bytes.toString(CellUtil.cloneFamily(cell)).equals("info") ){
                    user1 = new User();
                    user1.setLuckyName(Bytes.toString(
                            r.getValue(Bytes.toBytes("info")
                                    ,Bytes.toBytes("luckyName"))));
                    user1.setUserName(userName);
                }
            }
        }
        return user1;
    }

    @Override
    public int findUserWeiboCount(String userName) throws IOException {
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = connection.getTable(tableName);
        Scan scan =new Scan();
        FilterList flist = new FilterList(FilterList.Operator.MUST_PASS_ALL);
        SingleColumnValueFilter columnValueFilter = new SingleColumnValueFilter(
                "info".getBytes(),
                "userName".getBytes(),
                CompareOperator.EQUAL,
                userName.getBytes());
        FamilyFilter familyFilter = new FamilyFilter(CompareOperator.EQUAL,
                new BinaryComparator(Bytes.toBytes("weibo")));
        ColumnPrefixFilter cpfilter = new ColumnPrefixFilter(Bytes.toBytes(userName+"_"));
        flist.addFilter(familyFilter);
        flist.addFilter(cpfilter);
        flist.addFilter(columnValueFilter);
        scan.setFilter(flist);
        ResultScanner scanner = table.getScanner(scan);
        Iterator<Result> it = scanner.iterator();
        int row = 0;
        while (it.hasNext()){
            Result r = it.next();
            Cell[]  cells = r.rawCells();
            row = cells.length;
        }
        return row;
    }

    @Override
    public int findUserAttendsCount(String userName) throws Exception {
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = connection.getTable(tableName);
        Scan scan =new Scan();
        FilterList flist = new FilterList(FilterList.Operator.MUST_PASS_ALL);
        String userid = findUserIdbyUserName(userName);
        RowFilter rfilter = new RowFilter(
                CompareOperator.EQUAL,
                new BinaryComparator(Bytes.toBytes(userid)));
        FamilyFilter familyFilter = new FamilyFilter(CompareOperator.EQUAL,
                new BinaryComparator(Bytes.toBytes("attends")));
        flist.addFilter(rfilter);
        flist.addFilter(familyFilter);
        scan.setFilter(flist);
        ResultScanner scanner = table.getScanner(scan);
        Iterator<Result> it = scanner.iterator();
        int row = 0;
        while (it.hasNext()){
            Result r = it.next();
            Cell[]  cells = r.rawCells();
            row = cells.length;
        }
        return row;
    }


    @Override
    public int findUserFansCount(String userName) throws Exception {
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = connection.getTable(tableName);
        Scan scan =new Scan();
        FilterList flist = new FilterList(FilterList.Operator.MUST_PASS_ALL);
        String userid = findUserIdbyUserName(userName);
        RowFilter rfilter = new RowFilter(
                CompareOperator.EQUAL,
                new BinaryComparator(Bytes.toBytes(userid)));
        SingleColumnValueFilter columnValueFilter = new SingleColumnValueFilter(
                "info".getBytes(),
                "userName".getBytes(),
                CompareOperator.EQUAL,
                userName.getBytes());
        FamilyFilter familyFilter = new FamilyFilter(CompareOperator.EQUAL,
                new BinaryComparator(Bytes.toBytes("fans")));
        flist.addFilter(rfilter);
        flist.addFilter(familyFilter);
        flist.addFilter(columnValueFilter);
        scan.setFilter(flist);
        ResultScanner scanner = table.getScanner(scan);
        Iterator<Result> it = scanner.iterator();
        int row = 0;
        while (it.hasNext()){
            Result r = it.next();
            Cell[]  cells = r.rawCells();
            row = cells.length;
        }
        return row;
    }

    @Override
    public List<WeiBo> findAllWeibo() throws Exception {
        List<WeiBo> listweiBo = new ArrayList<>();
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = connection.getTable(tableName);
        Scan scan =new Scan();
        FilterList flist = new FilterList(FilterList.Operator.MUST_PASS_ALL);
        FamilyFilter familyFilter = new FamilyFilter(CompareOperator.EQUAL,
                new BinaryComparator(Bytes.toBytes("weibo")));
        flist.addFilter(familyFilter);
        scan.setFilter(flist);
        ResultScanner scanner = table.getScanner(scan);
        Iterator<Result> it = scanner.iterator();
        while (it.hasNext()){
            Result r = it.next();
            Map<byte[], byte[]> familyMap = r.getFamilyMap(Bytes.toBytes("weibo"));
            for(Map.Entry<byte[], byte[]> entry:familyMap.entrySet()){
                WeiBo weiBo = new WeiBo();
                weiBo.setWbid(Bytes.toString(entry.getKey()).split("_")[0]);
                weiBo.setTime(Bytes.toString(entry.getKey()).split("_")[1]);
                weiBo.setContent(Bytes.toString(entry.getValue()));
                User user = findUserbyUserName(Bytes.toString(entry.getKey()).split("_")[0]);
                weiBo.setUser(user);
                listweiBo.add(weiBo);
            }
        }
        listweiBo.sort(new Comparator<WeiBo>() {
            @Override
            public int compare(WeiBo o1, WeiBo o2) {
                if(o1.getTime()==null || o2.getTime()==null) return 0;
                return o2.getTime().compareTo(o1.getTime());
            }
        });
        return listweiBo;
    }

    @Override
    public List<WeiBo> findUserWeibo(String userName) throws Exception {
        List<WeiBo> listweiBo = new ArrayList<>();
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = connection.getTable(tableName);
        Scan scan =new Scan();
        FilterList flist = new FilterList(FilterList.Operator.MUST_PASS_ALL);
        ColumnPrefixFilter cpfilter = new ColumnPrefixFilter(
                Bytes.toBytes(userName));
        FamilyFilter familyFilter = new FamilyFilter(CompareOperator.EQUAL,
                new BinaryComparator(Bytes.toBytes("weibo")));
        flist.addFilter(cpfilter);
        flist.addFilter(familyFilter);
        scan.setFilter(flist);
        ResultScanner scanner = table.getScanner(scan);
        Iterator<Result> it = scanner.iterator();
        while (it.hasNext()){
            Result r = it.next();
            Map<byte[], byte[]> familyMap = r.getFamilyMap(Bytes.toBytes("weibo"));
            for(Map.Entry<byte[], byte[]> entry:familyMap.entrySet()){
                WeiBo weiBo = new WeiBo();
                weiBo.setWbid(Bytes.toString(entry.getKey()).split("_")[0]);
                weiBo.setTime(Bytes.toString(entry.getKey()).split("_")[1]);
                weiBo.setContent(Bytes.toString(entry.getValue()));
                User user = findUserbyUserName(Bytes.toString(entry.getKey()).split("_")[0]);
                weiBo.setUser(user);
                listweiBo.add(weiBo);
            }
        }
        listweiBo.sort(new Comparator<WeiBo>() {
            @Override
            public int compare(WeiBo o1, WeiBo o2) {
                if(o1.getTime()==null || o2.getTime()==null) return 0;
                return o2.getTime().compareTo(o1.getTime());
            }
        });
        return listweiBo;
    }

    @Override
    public String findUserIdbyUserName(String userName) throws Exception {
        User user1 = null;
        String userId = null;
        //获得要操作的表
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = connection.getTable(tableName);
        Scan scan =new Scan();
        //设置一个列的过滤器专门过滤age列
        FilterList flist = new FilterList(FilterList.Operator.MUST_PASS_ALL);
        SingleColumnValueFilter f = new SingleColumnValueFilter(
                "info".getBytes(),
                "userName".getBytes(), CompareFilter.CompareOp.EQUAL,
                userName.getBytes());
        flist.addFilter(f);
        scan.setFilter(flist);
        ResultScanner scanner = table.getScanner(scan);
        Iterator<Result> it = scanner.iterator();
        while (it.hasNext()) {
            Result r = it.next();
            Cell[]  cells = r.rawCells();
            for(Cell cell : cells){
                if(Bytes.toString(CellUtil.cloneFamily(cell)).equals("info") ){
                    userId = Bytes.toString(CellUtil.cloneRow(cell));
                }
            }
        }
        return userId;
    }

    @Override
    public boolean sendWeibo(WeiBo weiBo,String userName) throws Exception {
        if(weiBo.getContent()!=null && !"".equals(weiBo.getContent())
            && userName != null && !"".equals(userName)){
            //获得连接对象
            Connection conn = HBaseNamespaceUtil.getConnection();
            //获得当前时间戳
            long ts = System.currentTimeMillis();
            Date date = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = formatter.format(date);
            //获得要操作的表
            TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
            Table table = conn.getTable(tableName);
            //向表中插入数据，Put对象需要一个RowKey，而这个RowKey就是User对象中的userID
            String userId = findUserIdbyUserName(userName);
            Put put = new Put(Bytes.toBytes(userId));
            put.addColumn(Bytes.toBytes("weibo"),
                    (userName+"_"+time).getBytes(),ts,
                    Bytes.toBytes(weiBo.getContent()));
            //写入数据
            table.put(put);
            //关闭资源
            table.close();
            return true;
        }else{
            return false;
        }
    }

    @Override
    public List<String> findAllAttends(String userName) throws Exception {
        List<String> listAttends = new ArrayList<>();
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = connection.getTable(tableName);
        Scan scan =new Scan();
        String userId = findUserIdbyUserName(userName);
        RowFilter rf = new RowFilter(CompareOperator.EQUAL,
                new BinaryComparator(Bytes.toBytes(userId)));
        FilterList flist = new FilterList(FilterList.Operator.MUST_PASS_ALL);
        FamilyFilter familyFilter = new FamilyFilter(CompareOperator.EQUAL,
                new BinaryComparator(Bytes.toBytes("attends")));
        flist.addFilter(rf);
        flist.addFilter(familyFilter);
        scan.setFilter(flist);
        ResultScanner scanner = table.getScanner(scan);
        Iterator<Result> it = scanner.iterator();
        while (it.hasNext()){
            Result r = it.next();
            Cell[] cells = r.rawCells();
            for(Cell cell : cells){
                listAttends.add(Bytes.toString(CellUtil.cloneValue(cell)));
            }

        }
        return listAttends;
    }

    @Override
    public List<String> findAllFans(String userName) throws Exception {
        List<String> listAttends = new ArrayList<>();
        TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
        Table table = connection.getTable(tableName);
        Scan scan =new Scan();
        String userId = findUserIdbyUserName(userName);
        RowFilter rf = new RowFilter(CompareOperator.EQUAL,
                new BinaryComparator(Bytes.toBytes(userId)));
        FilterList flist = new FilterList(FilterList.Operator.MUST_PASS_ALL);
        FamilyFilter familyFilter = new FamilyFilter(CompareOperator.EQUAL,
                new BinaryComparator(Bytes.toBytes("fans")));
        flist.addFilter(rf);
        flist.addFilter(familyFilter);
        scan.setFilter(flist);
        ResultScanner scanner = table.getScanner(scan);
        Iterator<Result> it = scanner.iterator();
        while (it.hasNext()){
            Result r = it.next();
            Cell[] cells = r.rawCells();
            for(Cell cell : cells){
                listAttends.add(Bytes.toString(CellUtil.cloneValue(cell)));
            }

        }
        return listAttends;
    }

    @Override
    public boolean Attends(String userName, String AttendsUserName) throws Exception {
        boolean flag = false;
        if(userName != null && !"".equals(userName)
           && AttendsUserName != null && !"".equals(AttendsUserName)){
            //获得注册时的时间
            long ts = System.currentTimeMillis();
            //获得要操作的表
            TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
            Table table = connection.getTable(tableName);
            Date date = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = formatter.format(date);
            //向表中插入数据，Put对象需要一个RowKey，而这个RowKey就是User对象中的userID
            String userId = findUserIdbyUserName(userName);
            Put put = new Put(Bytes.toBytes(userId));
            put.addColumn(Bytes.toBytes("attends"),
                    Bytes.toBytes(AttendsUserName),ts,
                    Bytes.toBytes(AttendsUserName));
            flag = true;
            //写入数据
            table.put(put);
            //关闭资源
            table.close();
        }
        return flag;
    }

    @Override
    public boolean Fans(String userName, String FansUserName) throws Exception {
        boolean flag = false;
        if(userName != null && !"".equals(userName)
                && FansUserName != null && !"".equals(FansUserName)){
            //获得注册时的时间
            long ts = System.currentTimeMillis();
            //获得要操作的表
            TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
            Table table = connection.getTable(tableName);
            Date date = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time = formatter.format(date);
            //向表中插入数据，Put对象需要一个RowKey，而这个RowKey就是User对象中的userID
            String userId = findUserIdbyUserName(userName);
            Put put = new Put(Bytes.toBytes(userId));
            put.addColumn(Bytes.toBytes("fans"),
                    Bytes.toBytes(FansUserName),ts,
                    Bytes.toBytes(FansUserName));
            flag = true;
            //写入数据
            table.put(put);
            //关闭资源
            table.close();
        }
        return flag;
    }

    @Override
    public boolean CancelAttends(String userName, String CancelAttendsUserName) throws Exception {
        boolean flag = false;
        if(userName != null && !"".equals(userName)
                && CancelAttendsUserName != null && !"".equals(CancelAttendsUserName)){
            //获得注册时的时间
            long ts = System.currentTimeMillis();
            //获得要操作的表
            TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
            Table table = connection.getTable(tableName);
            //向表中插入数据，Put对象需要一个RowKey，而这个RowKey就是User对象中的userID
            String userId = findUserIdbyUserName(userName);
            Delete delete = new Delete(userId.getBytes());
            delete.addColumn(Bytes.toBytes("attends"),Bytes.toBytes(CancelAttendsUserName));
            table.checkAndDelete(
                    Bytes.toBytes(userId),
                    Bytes.toBytes("attends"),
                    Bytes.toBytes(CancelAttendsUserName),
                    CompareFilter.CompareOp.LESS_OR_EQUAL,
                    Bytes.toBytes(CancelAttendsUserName),delete);
            flag =  true;
            table.close();
        }
        return flag;
    }

    @Override
    public boolean CancelFans(String userName, String CancelFansUserName) throws Exception {
        boolean flag = false;
        if(userName != null && !"".equals(userName)
                && CancelFansUserName != null && !"".equals(CancelFansUserName)){
            //获得注册时的时间
            long ts = System.currentTimeMillis();
            //获得要操作的表
            TableName tableName = TableName.valueOf(NamedFinalClass.RELATIONS_TABLE_NAME);
            Table table = connection.getTable(tableName);
            //向表中插入数据，Put对象需要一个RowKey，而这个RowKey就是User对象中的userID
            String userId = findUserIdbyUserName(userName);
            Delete delete = new Delete(userId.getBytes());
            delete.addColumn(Bytes.toBytes("fans"),Bytes.toBytes(CancelFansUserName));
            table.checkAndDelete(
                    Bytes.toBytes(userId),
                    Bytes.toBytes("fans"),
                    Bytes.toBytes(CancelFansUserName),
                    CompareFilter.CompareOp.LESS_OR_EQUAL,
                    Bytes.toBytes(CancelFansUserName),delete);
            flag =  true;
            table.close();
        }
        return flag;
    }

    @Override
    @Resource(name="connection")
    public void setConnection(Connection connection) {
        this.connection = connection;
    }
}
