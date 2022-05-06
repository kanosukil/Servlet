<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>First Servlet Application Test</title>
    <script src="js/FirstJavaScript.js"></script>
</head>
<body>
<% request.setCharacterEncoding("UTF-8");%>
<h1><%= "ServletTest" %></h1>
<br/>
<h1>!!pom.xml!!Maven配置文件</h1>
<%--
<a href="hello-servlet">Hello Servlet</a>
--%>

<form name="form1" id="input_form">
    <label name="label1" id="lab1" for="user_text">请输入你的名字:</label>
    <input type="text" name="user_name" id="user_text" value=${param["user_name"]}><br/>
    <button type="submit" name="btn1" id="btn" value="按钮" onclick="btnBand()">
        <img src="images/button1.png" width="100" height="50">
    </button><br/>
</form>
<br/>
<a href="SelectOne.html">doGet</a>
<br/>
<a href="SelectTwo.html">HTML</a>
<br/>
<a href="SelectThree.html">Statistic</a>
<br/>
<a href="${pageContext.request.contextPath}/LearnJSP.jsp" style="color: aquamarine;width: 10px;height: 10px">学JSP</a><br>
<!--${pageContext.request.contextPath} 等同于 <%=request.getContextPath()%> 获取部署的应用程序名-->
<a href="ExceptionLearn.jsp">Exception</a><br>
<a href="JavaBeanLearn.jsp">JavaBean</a><br>
<a href="JDBCLearn.jsp">JDBC</a><br>
<a href="AjaxLearn.jsp">Ajax</a><br>
<a href="DAOandVOLearn.jsp">DAO VO</a><br>
<a href="MVCLearn.jsp">MVC</a><br>
<a href="MybatisLearn.jsp">MyBatis</a><br>
<a href="MavenLearn.jsp">Maven</a>
<hr>
<a href="ExperimentSix/Exper6.jsp">实验六</a>
<p>JSP + JDBC Web开发</p> <hr>
<a href="ExperimentSeven/category">实验七</a>
<p>JSP + JavaBean + Servlet Web开发</p>

<hr>
<h1>Web项目各个目录的作用</h1>
<pre>
    1   WEB-ROOT      Web的根目录(一般虚拟目录直接指向该目录, 且必包含WEB-INF
    2   WEB-INF       Web目录中最安全的文件夹(保存各种类 第三方jar包 配置文件
    3   web.xml       Web的部署描述符
    4   classes       保存所有JavaBean,若不存在, 可手工创建
    5   lib           保存所有第三方jar包
    6   tags          保存所有标签文件
    7   jsp           存放*.jsp文件,一般根据功能再创建子文件夹
    8   js            存放所以需要的*.js文件
    9   css           样式表文件的保存路径
    10  images        存放所有图片(如 *.gif *.jpg文件)
</pre>

</body>
</html>

<!--HTML格式注释(可多行)-->
<%--
/*CSS格式注释
  JavaScript格式注释
  Java格式注释*/
(多行)
// JavaScript Java 单行注释
JSP特有注释
--%>

<%--
    JSP表达式
        其中只能写一条语句
        表达式不能以";"结束
        JSP表达式的内容一定是字符串类型
        或者能通过toString()函数转换成字符串的形式
--%>
<%--
    EL表达式
        结构:${expression}
        EL提供"."和"[]"两种运算符存取数据
        **当要存取的属性名称中包含一些特殊字符就必须要使用"[]"
        **当要动态取值时就可以用"[]",而"."无法做到动态取值

        EL存取变量数据:
        e.g. ${username} 取出某一范围内的名称为username的变量
        找到就返回(即遇到第一个就不会找后面的),没有则返回null
        属性范围在EL中的名称:
            Page        PageScope
            Request     RequestScope
            Session     SessionScope
            Application ApplicationScope
--%>
<%--
    程序段
    <% Java代码 %>
    一个页面可以有很多,且执行时按顺序执行
--%>
<%--
    JSP声明
        定义网页的全局变量(JSP页面的成员变量)
        实际应用中,方法(内部的变量仅在方法内有效) 页面全局变量 类的声明都可放在JSP声明中
        格式:
        <%! 代码 %>
        声明的变量可为Java允许的任何数据类型
        声明的方法整个JSP页面有效,但方法中的变量仅在方法内有效
        声明的类可以在JSP页面的Java程序段部分使用该类创建对象
--%>
<%--
    URL传值
        缺:
        只能传字符串
        值将在浏览器的地址栏显示(不能传密码)
        优:
        简单且平台支持
--%>