<%--
  Created by IntelliJ IDEA.
  User: VHBin
  Date: 2021/11/22
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Mybatis</title>
</head>
<body>
    <h1>Mybatis简介</h1>
    <pre>
        半自动映射框架(相对于Hibernate的全映射而言)[ORM框架]
            需要手动提供POJO SQL和映射关系(可使用数据库内的所有特性)
            可配置动态SQL并优化SQL
        将对象的操作和关系数据库的操作语句建立映射关系(因此需要建立接口表示对象的操作)
    </pre><br>
    <h5>ORM框架</h5>
    <pre>
        解决面向对象与关系数据库中数据类型不匹配的技术
        描述Java对象与数据库之间的映射关系
        自动转换数据形式(Java --> 数据库)
    </pre><br>
    <h2>Mybatis工作原理</h2>
    <pre>
        详:
        1 读取Mybatis配置文件(主要是数据库链接信息)
        2 加载映射文件Mapper.xml (或注解)[在映射文件中编写sql语句完成业务]
        3 构建会话工厂
        4 创建SqlSession对象
        5 通过Executor接口操作数据库
        6 在Executor接口的执行方法中包含一个MappedStatement类型的参数
        7 输入参数映射
        8 输入结果映射
        总结为三阶段:
            加载配置文件(读取配置文件)
                -->创建数据库会话对象(创建会话工厂;创建会话对象)
                    -->SQL语句的执行(输入参数的匹配;输出结果的解析;映射到Java类)
    </pre><br>
    <h2>MyBatis示例</h2>
    <pre>
        导包/Maven构建:
            Maven依赖代码:
            &lt;dependency&gt;
                &lt;groupId&gt;org.mybatis&lt;/groupId&gt;
                &lt;artifactId&gt;mybatis&lt;/artifactId&gt;
                &lt;version&gt;x.x.x&lt;/version&gt;
            &lt;/dependency&gt;
            SqlSessionFactory的构建:
                xml构建:
                    详见mybatis-config.xml文件 (!⚝!)
                java构建:
                    DataSource dataSource = BlogDataSourceFactory.getBlogDataSource();
                    TransactionFactory transactionFactory = new JdbcTransactionFactory();
                    Environment environment = new Environment("development", transactionFactory, dataSource);
                    Configuration configuration = new Configuration(environment);
                    configuration.addMapper(BlogMapper.class);
                        // 添加了一个映射器类(mapper class)[包含sql映射注解从而避免依赖xml文件(但要使用大多数高级映射,仍需xml配置)]
                    SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(configuration);
                创建Java接口:(由于和数据库的连接方式不同[与关系数据库的语句建立映射关系])
                    在Dao接口中定义好SQL的各项操作.
                    定义SQL语句之前,需要告诉Mybatis去哪找SQL的各项语句(即在配置文件中的mappers元素体内加入映射配置文件的位置信息)
                配置好后创建配置文件并对其进行编写(编写查看BookMapper.xml)
    </pre>
    <hr>
    <pre>
                每个基于 MyBatis 的应用都是以一个 SqlSessionFactory 的实例为中心的。
                SqlSessionFactory 的实例可以通过 SqlSessionFactoryBuilder 获得。
                SqlSessionFactoryBuilder 则可以
                    从 XML 配置文件
                    或一个预先定制的 Configuration 的实例
                构建出 SqlSessionFactory 的实例。
                SqlSession 实例可以通过 SqlSessionFactory 实例的openSession() 方法创建获得.
                sqlSession 的实例通过 getMapper() 的方法和数据库操纵接口的绑定获得对应实例,
                此时的实例即可直接调用接口定义的各项方法对数据库进行各项操作.

                总结:
                    1 在mybatis-config.xml中配置好数据库链接的相关参数(数据库对应驱动 JDBC 数据库URL/本地数据库文件)并准备好VO
                        xml需要准备好Dao;注解的Dao需要配置操作,不需要事先准备
                    2
                        xml方式配置Mapper:在xml的Mappers元素体内定义映射器的源地址
                            e.g. mybatis-config.xml
                        注解配置Mapper:xml中无需其他操作
                            e.g. mybatis-config-annotation.xml
                    3
                        xml:在映射器的xml中配置各项操作
                            e.g. BookMapper.xml
                        注解:在Dao接口中使用配置各项操作
                            e.g. BookDaoAnnotation.java
                    4 在项目中:
                        a. InputStream 获得配置文件 config [<i>class.getClassLoader().getResourceAsStream(path)方法</i>]
                        b. SqlSessionFactory 通过 <i>new SqlSessionFactoryBuilder().build(config)</i> 获得
                    <strong>仅注解方式需要:[配置 SqlSessionFactory : sqlSessionFactory.getConfiguration().addMapper(Dao接口的class)]</strong>
                        c. SqlSession 通过 SqlSessionFactory 的 <i>openSession()</i> 方法获得
                        d. Dao接口 的实例化: SqlSession和Dao接口绑定创建 [<i>getMapper(Dao接口的class)方法</i>]
                        e. 使用Dao接口的实例进行数据库操作 (更新 添加 删除等操作需要<b>SqlSession.commit()</b>才能作用到数据库)


        <strong><i>dao.java -> config.xml -> mapper.xml -> test.java</i></strong>
        <strong><i>config-annotation.xml -> dao-annotation.java -> test-annotation.java</i></strong>
        ------------------------------------------------------------------------------------------------
        <strong><i>config -> SqlSessionFactory -> SqlSession -> Dao接口的实例化 -> 数据库操作></i></strong>
    </pre>
    <hr>
    <hr>
    <h2>MyBatis使用细节</h2>
    <pre>
        resultType 适应较为简单的输出结果映射
        resultMap  复杂结果映射(多表关联查询)

        e.g.
            在mapper.xml中:
                &lt;%--定义resultMap:--%&gt;
                &lt;mapper&gt;
                    &lt;resultMap id="resultMapName" type="mainVO"&gt;
                &lt;%-- id 为唯一标识; type--%&gt;
                        &lt;id property="VO中的属性" column="数据库中列"/&gt; &lt;%-- 主键 --%&gt;
                        &lt;result property="" column=""/&gt; &lt;%-- 其他属性 --%&gt;
                        &lt;association porperty="链接表名" javaType="对应VO"&gt;
                            &lt;id property="" column=""/&gt;
                            &lt;result property="" column=""/&gt;
                        &lt;/association&gt;
                    &lt;/resultMap&gt;
                &lt;%--使用resultMap:--%&gt;
                    &lt;select id="selectName" resultMap="resultMapName" &gt;
                        SQL语句(结果结构要符合resultMap的描述)
                    &lt;/select&gt;
                            &lt;id为select的标识符;resultMap为定义的resultMap的id&gt;
                &lt;/mapper&gt;

        resultMap中:
            association: 一对一
            collection:  一对多
    </pre>
    <hr>
    <h2>MyBatis缓存</h2>
    <pre>
        (默认开启)一级缓存[SqlSession层面]:
            [同一个SqlSession多次调用同一个映射文件中的同一个方法使用同一个参数时的第一次结果将存入缓存,之后相同的查询将直接从缓存中取出数据不进行进一步访问]
            [不同的SqlSession对象使用相同的方法还是会访问]
            缓存机制:HashMap实现[key:sql的id相关内容, value:数据库查询结果]
                <i>执行<b>增删改</b>操作后,无论是否提交(即进行SqlSession.commit()), 都会清空一级缓存(同时清空二级缓存)</i>
        二级缓存[namespace层面]:
            整个生命周期和整个应用同步(与SqlSession无关)
            MyBatis查询缓存作用域根据Mapper.xml文件中mapper的namespace划分.
            由于从缓存中读取数据的依据是sql的id,因此其目的非共享数据而是<b><i>延长查询结果的保存时间,提高系统性能</i></b>
            使用步骤:
                序列化实体(实现序列化接口[<b><i>java.io.Serializable</i></b>] 父类和域属性类也要实现)
                在mapper映射文件中添加&lt;cache/&gt;标签/

            二级缓存的清空并非删除缓存对象,而是将其对应值置空.
    </pre>
</body>
</html>
