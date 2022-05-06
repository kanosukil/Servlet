<%--
  Created by IntelliJ IDEA.
  User: VHBin
  Date: 2021/11/17
  Time: 09:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="UTF-8" %>
<html>
<head>
    <title>JDBC</title>
    <meta  charset="UTF-8">
</head>
<body>
    <h1>JDBC</h1>
    <pre>
        功能:
            1 建立与数据库或其他数据源的链接
            2 向数据库发送SQL语句
            3 处理数据库返回结果
        JDBC驱动程序:
            类别:
            1 JDBC-ODBC桥驱动程序
            2 部分本地API部分Java的驱动程序
            3 JDBC网络纯Java驱动程序
            4 本地协议的纯Java驱动程序
    </pre>
    <h1>常用库</h1>
    <pre>
        java.sql.Connection; 链接数据库
            Connection con = DriveManager.getConnection("jdbc:odbc:wombat", "login", "password");
        java.sql.Statement;  执行语句
            Statement stm = con.creatStatement();
            ResultSet rs = stm.executeQuery("SQL语句");
        java.sql.ResultSet; 存放查询结果
            while(rs.next()) {
                对应数据类型的变量 = rs.getXXX("对应SQL语句中的数据名"); // xxx表示数据类型
            }
    </pre>
    <hr>
    <h1>JDBC操作</h1>
    <pre>
        Class.forName("指定驱动名"); // 注册驱动
        Connection con = DriveManager.getConnection("协议URL", "用户名", "密码");
        Statement stm = con.createStatement(); // 获取Statement接口实例对象
        stm.executeQuery("SQL查询语句");   // SQL查询
        stm.executeUpdate("SQL增删改语句");// SQL增加 删除 修改语句
        // con.commit(); catch (SQLException se) con.rollback();
        // 对数据库完成更改后需要提交更改,则需要使用语句con.commit() 否则则需要使用语句 con.rollback()
        // 对获取数据进行处理(略)

        // 关闭数据库
        stm.close();
        con.close();
    </pre> <hr>
    <h2>增删改查细节</h2>
    <h5>增加数据</h5>
    <pre>
        String sql_plus = "SQL语句";
        int i = stm.executeUpdate(sql_plus);
        // 返回的是这条SQL语句执行后添加的行数(即 添加了几行)
    </pre> <br>
    <h5>删除数据</h5>
    <pre>
        String sql_min = "SQL语句";
        int i = stm.executeUpdate(sql_min);
        // 返回的为执行这条SQL语句后删除的行数(即 删除了几行)
    </pre> <br>
    <h5>修改数据</h5>
    <pre>
        String sql_upd = "SQL语句";
        int i = stm.executeUpdate(sql_upd);
        // 返回的为执行这条SQL语句后修改的行数(即 修改了几行)
    </pre> <br>
    <h5><b>查询数据</b></h5>
    <pre>
        String sql_find;
        ResultSet rs = stm.executeQuery(sql_find);
        // 查找返回的数据需要存放在 RequestSet 对象中,然后从rs对象中取出数据进行处理
        // RequestSet 中存在小指针(游标)初始指向第一行的前一行,rs.next()可以使游标下移一行(返回boolean值)

        while(rs.next()) { // rs.next() 直接换下一行 (将rs中的数据认为是表,和数据库中的数据存在形式一致
            xxx var = rs.getXXX("列名"); // xxx为对应XXX的数据类型, XXX为列名对应的数据类型
        }
    </pre>
    <hr>
    <hr>
    <h1>JDBC事务</h1>
    <pre>
        数据库事务,一组对数据库进行控制的逻辑单元,可以控制何时将更改应用于数据库.
        事务由一条或多条SQL语句组成,一旦其中一条语句失败,整个事务都将失败.
            主要控制语句:
                con.commit();    // 更改是否作用于数据库
                con.rollback();  // commit失败即回滚(放弃更改,返回上一次正确状态)
            主要作用结构:
                try {
                    Connection con = DriveManager.getConnection("URL", "userName", "password");
                    Statement stm = con.createStatement();
                    String sql_crud = "SQL Statement";
                    int i = stm.executeUpdate(sql_crud);
                    con.commit() // There is no error
                } catch (SQLException se) {
                    con.rollback();
                }
        <b>保存点</b>:
            设置保存点,方便回滚.遇到错误,返回保存点,仅保存保存点之前的操作.
            语句:
                Savepoint sp1 = con.setSavepoint("name");   // 创建保存点
                con.rollback(sp1);                          // 回滚到保存点
                releaseSavepoint(sp1);                      // 删除保存点(对象通常为setSavepoint()生成的保存点)
    </pre> <hr>

    <h6>补:JDBC常用驱动</h6>
    <pre>
        <b>各数据库的JDBC驱动都需自行下载!</b>
        驱动类名:                               JDBC URL
            MySQL:com.mysql.jdbc.Driver (jdbc:mysql://IP:port/DataBaseName [default port:3306
            JDBC-ODBC桥:sun.jdbc.odbc.jdbcOdbcDriver (jdbc:odbc:DSSchool Java1.8后删除
    </pre>

</body>
</html>
