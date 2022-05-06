<%--
  Created by IntelliJ IDEA.
  User: VHBin
  Date: 2021/11/16
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
            pageEncoding="UTF-8" %>
<html>
<head>
    <title>JavaBean</title>
    <meta charset="UTF-8">
</head>
<body>
<h1>JavaBean</h1>
<p>减少对数据库进行处理的大量重复代码<br>
可重用的Java组件<br>
可封装任何Java代码创造的对象(功能 处理 值 数据库访问等) 并可通过内部JSP页面 Servlet 其他JavaBean applet程序或应用使用</p><br>

<h3>特性</h3>
<pre>
    Methods
    Events
    ...
</pre><br>

<h3>分类:</h3>
<pre>
    可视化:
        有GUI,对最终用户可见(UI, User Interface)
    不可视化:(JSP通常访问
        不要求继承且更多使用在JSP中.负责处理事务
        通常用来:
            封装业务逻辑
            数据分页逻辑
            数据库操作
            事务逻辑
</pre>
<br>

<p>
    可复用 平台独立 软件组件
    可在软件构造器中直接进行可视化操作(软件构造器:Web页面构造器, 可视化应用程序构造器, GUI设计构造器, 服务器应用程序构造器等)
</p>
<hr>

<h3>每个JavaBean都必须支持的特性:</h3>

一个bean没有必须继承的特定接口或基类
可视化bean必须继承的类为java.awt.Component, 非可视化不需要继承
不是所有软件模块都需要转换成bean bean比较适合于具有可视化操作和定制特性的软件组件

<h4>JavaBean的属性:</h4>
<i>属性获得属性读取(get)和属性写入(set)的API支持.属性值都可以通过适当bean方法进行调用.</i><br>
<h4>JavaBean的方法:</h4>
<i>即为通常的Java方法,可被其他组件或脚本环境中调用.默认下,所有bean方法都可被外部调用(当bean一般只引出其公有方法的一个子集</i><br>
<i>JavaBean内没有可以被外部世界直接访问的字段(没有public字段),因此只能通过JavaBean方法访问JavaBean的内部字段</i><br>
<h4>JavaBean事件:</h4>
<i>Bean与其他软件组件交流信息的主要方式是 发送和接受事件</i><hr>

<h3>优:</h3>
<b>较强的对组装环境适应能力</b><br>
<b>将领域知识和计算机实现分离(构件内部对象分为:实现用户功能的对象集 用于组装的对象集</b><hr>

<h3>编写JavaBean</h3>
<pre>
    JavaBean内成员变量都为private
    且每一个成员变量都有一个setter/getter方法
    <b>设计原则</b>
        1. 公有类 (public声明类)
        2. 无参的构造函数 (必须有一个无参的构造函数)
            [没有显式构造函数,类就会有默认的构造方法;定义了一个显式的有参构造方法,就必须再定义一个无参的构造方法]
        3. 属性私有 (属性必须定义为private)
            [对属性进行私有化封装,对外提供getter和setter方法,提高安全性]
        4. getter 和 setter 方法
            [成员变量的读写只能通过getter和setter方法进行.每一个可读属性必定义一个getter方法,每一个可写属性必定义一个setter方法]

        (注:由于通过 getter/setter方法读/写变量的值,因此对应的变量首字母必须大写,属性名由 getter 和 setter 方法决定)
</pre>

<h3>JSP搭配JavaBean使用</h3>
<pre>
    1. 可使HTML代码和Java代码分离,方便日后维护
    2. 将日常需要的程序写成JavaBean组件,当JSP需要使用时,只要调用JavaBean组件即可执行指定功能,不需要重复写相同的程序
</pre>
<br>
<h3>JSP应用JavaBean标签操作简单类时 类的开发要求</h3>
<pre>
    1. 所有类都必须在一个包内(Web中没有包即为不存在
    2. 所有类都必须声明public class(这样才能被外部访问
    3. 类中所有属性都必须封装 (private 声明
    4. 封装的属性如果需要被外部所操作, 及必须有getter/setter方法
    5. 一个JavaBean中必须有一个无参构造方法(才能被JSP中标签使用
</pre>

<hr>
<h3>访问JavaBean</h3>
<h5>JSP Page指令:(可在JSP页面内随便放置,一般放在页首)</h5>
<pre>
    常用属性:
        <b>language</b>:
            有默认,写成别的编译不了
        写法:
            <b> &lt;%@ page language="java"%&gt; </b>
        <b>extends</b>:
            表明JSP编译时需要加入的class的全名(最好不用,会限制JSP的编译能力)
        写法:
            <b> &lt;%@ page extends="package.class"%&gt; </b>
        <b>import</b>:
            写了之后将自动添加到servlet的import语句中,但不检查包的存在性
        写法:
            <b> &lt;%@ page import="java.util.*"%&gt; </b>
        <b>session</b>:
            Session对象是否参与对话,session="false"就没有了session对象
        写法:
            <b> &lt;%@ page session="false"%&gt; </b>
        <b>buffer</b>:
            指定out对象(JSPWriter)的缓冲区大小,单位kb,默认8kb
        写法:
            <b> &lt;%@ page buffer="none"%&gt; </b>
        <b>autoFlush</b>:
            控制当缓冲区满时,是自动清空输出缓冲区(默认true),还是在缓冲区溢出后抛出异常(false)
        写法:
            <b> &lt;%@ page autoFlush="ture"%&gt; </b>
        <b>isThreadSafe</b>:
            询问程序员线程是否安全,缺省值为ture,表示线程安全,可以同时响应多个请求.若设置为false,则一次只能处理一个用户的请求
        写法:
            <b> &lt;%@ page isThreadSafe="false"%&gt; </b>
        <b>info</b>:
            定义一个字符串,servlet中可以通过getServletInfo方法获取的该字符串.
        写法:
            <b> &lt;%@ page info="info text"%&gt; </b>
        <b>errorPage</b>:
            errorPage 设置处理异常事件的JSP文件
            isErrorPage 设置此页是否为出错页.若为true,则可以使用Exception对象
        写法:
            <b> &lt;%@ page errorPage="relativeURL"%&gt; </b>
            <b> &lt;%@ page isErrorPage="true"%&gt; </b>
        <b>isELIgnored</b>:
            是否忽视EL表达式:
        写法:
            <b> &lt;%@ page isELIgnored="true"%&gt; </b>
        <b>contentType</b>:
            设置发送到客户端文档的响应报头类型和字符编码.多个使用 ";" 隔开.pageEncoding只用于修改字符编码.
            charset设置页面字符集, pageEncoding定义输出流字符集.
        写法:
            <b> &lt;%@ page contentType="text/html;charset=UTF-8"%&gt; </b>
</pre>
<h5>JSP useBean标签:</h5>
<pre>
    &lt;jsp:useBean&gt;标签
        可以在JSP中声明一个JavaBean,然后使用.声明后JavaBean对象变成了脚本变量, 可以通过脚本元素或其他自定义标签访问
    语法格式:
        &lt;jsp:useBean id="bean name" class="bean class path" scope="bean action scope" typeSpec /&gt;
    根据情况
        scope值可为 page request session application
        id值可为 任意只要不和JSP文件中其他 &lt;jsp:useBean&gt; 中id值一样的即可

    在 &lt;jsp:useBean&gt; 标签主体中
        使用 &lt;jsp:getProperty /&gt; 标签调用getter方法
        使用 &lt;jsp:setProperty /&gt; 标签调用setter方法
</pre><br>
<h2>简单的useBean实例演示</h2>
<jsp:useBean id="date" class="java.util.Date" />
<p>
    现在的时间:<%= date %>
</p><br>
<hr>
<h2>get 和 set 属性实例演示</h2>
<jsp:useBean id="students" class="com.example.servlet.Student">
    <jsp:setProperty name="students" property="name"
                     value="卡侬"/>
    <jsp:setProperty name="students" property="age"
                     value="17"/>
    <jsp:setProperty name="students" property="grade"
                     value="3"/>
</jsp:useBean>

<p>
    姓名:
    <jsp:getProperty name="students" property="name"/><br>
    年龄:
    <jsp:getProperty name="students" property="age"/><br>
    年级:
    <jsp:getProperty name="students" property="grade"/><br>
</p>

<hr>

<pre>
    scope 表示JavaBean的作用范围
        page        表示JavaBean对象的作用范围只是在实例化该JavaBean的也,页面上可用,在别的页面中不能识别
                    (常用来一次性操作
        request     表示JavaBean对象除了可以在当前页面上可用外,还可以在通过forward方法跳转的目标页面中被识别
                    (常用于共享同一请求的JSP页面,转发后的页面依旧可获得表单提交的信息,且实例对象为同一个
        session     表示JavaBean对象可以存在session中,该对象可以被同一个用户一次会话的所有页面识别
                    (基于session,session创建,JavaBean被创建;session销毁,JavaBean被销毁
        application 表示JavaBean对象可以存在application中,该对象可以被所有用户的所有页面识别
                    (服务器创建 application创建 JavaBean也被创建;服务器销毁 application被销毁 JavaBean也被销毁
</pre>
</body>
</html>
