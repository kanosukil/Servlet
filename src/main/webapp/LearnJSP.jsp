<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: VHBin
  Date: 2021/11/05
  Time: 18:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学</title>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
    %>
    <a href="LearnJSP.jsp" target="_self" id="time" style="color: red;background: aqua"><%=new Date().toString()%></a><br/>
    <a href="LearnJSP.jsp" target="_self" id="label"><%="学"%></a><br/>
<%--    <input type="text" id="username" name="username" value=${param["user_name"]}><br/>--%>
<%--    <input type="submit" id="submitBtn" name="submitBtn" value="测试" onclick="test()"><br/>--%>
<%--    <script>--%>
<%--        function test() {--%>
<%--            alert(${param["user_name"]});--%>
<%--        }--%>
<%--    </script>--%>
<%--    EL表达式跳过--%>
    <%
        String str = String.valueOf(Math.atan(75));
    %>
    <p style="background: aqua;size: A4"><%
        out.println("PI = " + Math.PI);
        out.println("atan75 = " + str);
    %></p>
<!--可输出,无错误,但标签p未换行-->
    <%!
        class is_Prime {
            private Integer num;
            public is_Prime(Object o) {
                if (o instanceof String && String.valueOf(o).matches("^-?\\d*\\.?\\d*$"))
                    try {
                        num = Integer.parseInt(String.valueOf(o));
                    } catch (NumberFormatException nf) {
                        nf.printStackTrace();
                        num = -1;// 浮点数
                    }
                else if (!(o instanceof Integer))
                    num = -2;// 非数符
                else
                    num = (Integer) o;
            }

            public boolean is() {
                if (num <= 0) return false;
                for (int n = 2; n < num/2 + 1; n ++)
                    if (num % n == 0)
                        return false;

                return true;
            }
        }
    %>
<%--    声明在jsp中要尽量少用逻辑代码(逻辑代码应该放在业务代码中,而非页面代码中--%>
    <p>
        <%=String.valueOf(new is_Prime(str).is())%>
    </p>

<%--
    JSP指令
    形式:
    <%@ 指令类型 属性1="属性" 属性2="属性" ... %>
    注:大小写敏感
    JSP指令(3种):page include taglib
        page:
        1.导入包                   <%@ page import="导入包名.类名" %>
        2.设定字符集                <%@ page pageEncoding="编码类名" %>
        3.设定MIME类型和字符编码     <%@ page contentType="MIME类型;charset=字符编码" %>
        4.设定错误页面               <%@ page errorPage="anErrorPage.jsp" %>
                         anErrorPage.jsp:
                            <%@ page isErrorPage="true" %>
        include:
        用于在JSP文件中插入一个包含文本或代码的文件
        taglib:
        用来声明此JSP文件使用了自定义的标签,同时引用所指定的标签库以及设置标签库的前缀
            语法格式: <%@ taglib uri="URIToTagLibrary" prefix="tagePrefix" %>
    --%>
<%--
    JSP动作
        使用XML语法格式的标记控制服务器的行为.可完成各种通用的JSP功能.(动态插入文件,重定向用户页面;为java插件生成HTML代码等)
        形式:
            <jsp:动作名 属性1="属性值" 属性n="属性值" />
            <jsp:动作名> 相关内容 </jsp:动作名>
        常见JSP动作:
            jsp:include:当页面被请求时引入一个文件
                <jsp:include page="文件名" />
            jsp:forward:将请求转到另一个页面
                <jsp:forward page="文件名" />

        include 页面包含操作:
            <jsp:include> 动态的包含静态和动态的文件(可对include页面通过URL传值方式传输变量值)
                静态页面仅被加入页面没有任何处理
                动态文件会进行处理后再将结果加入页面
            语法格式:
                <jsp:include page="包含文件URL地址" flush="true|false" />
                flush 确定缓冲区满时是否清空(true是,false否) 默认为false
        forward 请求转发操作:
            <jsp:forward> 转移用户请求,使用户请求的页面从一个页面跳转到另一个页面.
                改为服务器端的跳转,因此用户端的地址栏没有任何变化.
            语法格式:
                <jsp:forward page="跳转文件URL地址" />
        param 参数传递操作
            <jsp:param> 用来传递参数
                一般和 <jsp:include> <jsp:forward>作用联合使用
            语法格式:
                <jsp:param name="参数名" value="参数值" />
                name 传递参数的名称;value 传递参数的值
    --%>
<%--JSP指令先被程序查找并转换成servlet.在页面转换时期执行且编写一次.--%>
<%--JSP动作客户端请求时按照在页面的顺序执行,且只有在被执行时才实现具有的功能,客户每请求一次,动作就被标识一次--%>
<%--
    表单:
        可输入一些内容(控件 即表单元素提供
        一个按钮进行提交
        点击按钮后,表单中的内容被提交到服务器端
        表单元素放在 <form></form> 之间

    单一表单元素:
        送往服务器端时,仅为一个变量
        包含:文本框 密码框 多行文本框 单选按钮 下拉菜单等
        获取方式:
            request.getParameter("表单元素名name")
            return string
    捆绑表单元素:
        多个同名表单元素的值送往服务器时,是一个捆绑数组
        包含:复选框 多选列表框 其他同名表单元素
        获取方式:
            request.getParameterValues("表单元素名name")
            return string[]

    传输方式:
        post:密码等敏感信息,隐式传输 不可见
        get:将请求的编码信息添加在网址之后,使用"?"分隔(浏览器默认)
            get的传输数据的大小有限制,最大1024字节(参数个数另当别论)
        JS提交:
            对表单内容进行验证. 点击提交按钮后,调用js进行验证,再提交.
            因此按钮类型不能设置为 submit ,而是 button .

    隐藏表单:
        <input type="hidden">
            不在网页中显示.(实现隐藏表单的方法)
        作用:
            1.收集或发送插入信息, 以利于被处理表单的程序使用
            2.内容可以是用户的信息,提交表单时确定用户身份(可用 cookies 但隐藏域简单于cookies且不会有浏览器不支持和用户禁用cookies的影响
            3.存储js不能使用的全局变量值
        如果 form 的 method 值为 get 隐藏表单的值仍会显示在地址栏, 因此需要将值设为 post
        弊端:
            只能传字符串(对数据类型有一定限制
            传输数据的值虽然地址栏看不见,但不是客户端源码中还是可以看见
    --%>
<%--
    乱码:
    Tomcat乱码:编码问题
        <%@ page language="java" contentTyoe="text/html;charset=gb2312" %>
        <%@ page language="java" pageEncoding="gb2312" %>
    提交时乱码:服务器接收时乱码
        1. 字符串改为 gb2312
            var(string) = new String(var (string).getBytes("ISO-8859-1"),"gb2312");
        2. 修改 request 编码
            request.setCharacterEncoding("gb2312");
        3. 利用过滤器
            过滤器 对整个Web应用程序进行统一编码过滤
    --%>

    <form action="FormLearn.jsp" method="post">
        <%
            out.println("12321是不是素数:" + new is_Prime(12321).is());
        %><br>
        <input type="text" name="str"><br>
        <input type="submit" value="提交">
    </form><br>

<%--        <a href="JSPInclude.jsp">JSP Include动作</a><br>--%>
<%--        <a href="JSPForward.jsp">JSP Forward动作</a><br>--%>

<%--
    JSP内置对象:
        JSP页面无需定义即可直接使用的对象
            特点: 自动载入, 无需定义;Web容器实现并管理;所有的JSP页面直接调用内置对象都合法
        九大内置对象:
            out
            request
            response
            session
            application
            exception
            page
            pageContext
            config
    --%>
    <%--
        out:
            向客户端输出各类数据类型的内容
            对应用服务器上的输出缓冲区管理(缓冲区默认8KB
        对应Java类(接口):
            javax.servlet.jsp.JspWriter
        利用方式:
            void print()
            void println()
            管理缓冲区:
            int getBufferSize() 获得缓存区大小
            int getRemaining()  获得缓存区没被占用的空间大小
                (上两者的单位:kb)
            void close()        关闭输出流,强行终止当前页面的剩余部分向浏览器输出(数据输出完毕应及时使用
            void clearBuffer()  清除缓冲区当前的数据,将数据写入下一个输出语句并将在下一行开始输出(即使内容已经反应给客户端也能使用
            void flush()        输出缓冲区的数据
            void clear()        清除缓存区内容,类似于重置响应流以便重新开始操作(若响应已经提交,则会IOException
        (注:服务端要输出到客户端的内容不是直接写到客户端,而是先写到一个输出缓存区中
        (仅在下面三种情况下才会将缓存区内容输出到客户端:
            1. JSP网页已完成信息的输出
            2. 输出缓存区已满
            3. JSP中调用了out.flush() 或 response.flushBuffer()
        --%>
    <%--
        request:
            客户端请求的参数和流(客户端的数据来源:表单以及网页地址后的参数
            (且request对象封装了客户的请求信息[客户请求信息及客户端的信息]
        对应Java接口(类):
            javax.servlet.http.HttpServletRequest
        请求信息包括:
            标题头 信息(浏览器版本信息 语言 编码方式等
        利用方式:
            String getMethod()                          得到提交方式
            String getRequestURI()                      得到请求的URL地址
            (** StirngBuffer getRequestURL()
            String getProtocol()                        得到协议名称
            String getServletPath()                     获得客户端请求的服务器文件路径
            String getQueryString()                     获得URL的查询部分(post请求没有任何信息输出
            String getServername()                      获得服务器名称
            String getServerPort()                      获得服务器端口号
            String getRemoteAddr()                      获得客户端IP地址
            String getParameter(String name)
            String[] getParameterValues(String name)
        --%>
    <%--
        response;
            可理解为客户端的响应
            向客户端输出信息
        对应Java接口(类):
            javax.servlet.http.HttpServletResponse
        response常用方法:
            void addHeader(String name, String value)           添加HTTP文件指定的头信息
            String encodeURL(String URL)                        将URL给予编码,回传包含SessionID的URL
            利用response进行重定向(把响应发送到另一个位置进行处理):
            response.sendRedirect(目标页面路径)

            类似于 JSP forward动作指令
                <JSP:forward page="目标页面路径"></JSP:forward>

            两者的区别:
                1. 浏览器地址:
                    forward 属于服务器去请求去直接访问,因此客户端地址不变
                    redirect 是使浏览器去请求, 客户端浏览器地址会发生改变
                2.共享数据:
                    forward 转发的页面以及转发到的页面共享 request 内的数据
                    redirect 不能共享 request内的数据
                3.功能:
                    forward 只能在同一个服务器内转发请求
                    redirect 可以定向其他站点
                4. 效率:
                    forward 只能服务器内跳转, 效率高
                    redirect 相对较低

        使用率不高的重定向:
            sendError();
                向客户端发送HTTP状态码的出错信息
                400 请求出现语法错误
                401 客户试图未经授权访问受密码保护的页面
                403 资源不可用
                404 未找到指定位置的资源
                500 服务器遇到无法预料的情况,不能完成客户的请求

        cookie:
            小文本数据,服务端生成,客户端浏览器若设置接受cookie则将会保存再某个文本文件中,
            下次登录同一网站,浏览器自动读取cookie并传给服务器端.
            cookie采用键值对(key-value)的形式表达

        服务器(通过脚本发送一系列cookie)-->浏览器(保存到本地)[下一次请求将cookie]-->服务器[识别用户以及其他事情]
        --%>
    <%--
        session:
            类似于购物车(一个用户可以在多个柜台收入或取出商品,每个用户互不干扰)
            一个客户端一个session(多个页面)
            利用方式:
                放入:
                void session.setAttribute(String name, Object obj);
                    两次放入name相同,则后输入覆盖前输入的
                    第二个参数为 object 类型的,因此不仅可以放 String
                取出:
                Object session.getAttribute(String name);
                移除:
                void session.removeAttribute(String name); 指定
                void session.invalidate(); 全部
        sessionId 标识给予服务器判断每个页面使用的session是否为同一个session
                String session.getId();
        --%>
    <%--
        application:
            保存应用程序的公用数据
            服务器启动并自动创建application后,只要不关闭服务器,application就会一直存在,一个Web的所有用户共享一个application
            对应接口(类):javax.servlet.ServletContext
            生命周期:服务器的开启到关闭
            用户的前后链接或不同用户的连接中可以对application的同意属性进行操作,任何地方的操作对会影响其他用户的访问
            (全局对象/静态对象)
            使用方式:
                存入:
                    void application.setAttribute(String name, Object obj);
                读取:
                    Object application.getAttribute(String name);
                                        getAttributeNames(); 获取application的所有参数名
                                        getMajorVersion(); 获取服务器支持的Servlet的主版本号
                                        getMinorVersion(); 获取服务器支持的Servlet的从版本号
                移除:
                    void application.removeAttribute(String name);
        --%>
    <%--
        Session 与 Application 的区别:
        session 设置的属性仅在当前用户的会话范围有效,且在用户超过预期时间不发送请求后session将被回收
        application 作用于整个应用程序,即使所有用户都不发送请求,只要服务器不关闭,其中的属性都是有效的
        --%>
    <%--
        exceotion:
            获取异常信息(没被发现或不可避免
            对应接口:java.lanb.Exception
        --%>
    <%--
        page:
            指向当前JSP程序本身的对象,使用其可调用servlet类中定义的方法,只有在本页面内合法(类似于Java类中的this
            为 java.lang.Object类的实例对象
            可使用Object的方法
            JSP中应用并不广泛
            常用方法:
                class getClass();               返回当前Object的类
                int hashCode();                 返回Object的hash码
                String toString();              把Object对象转换成String类的对象
                boolean equals(Object obj);     比较对象和指定对象是否相等
                void copy(Object obj);          把对象拷贝到指定对象中
                Object clone();                 复制对象
        --%>
    <%--
        config:
            JSP程序初始化时所需要的参数以及服务器相关信息,以属性名和属性值构成,通过传递servletContext对象
            范围:本页面
            对应接口:javax.servlet.ServletConfig
            (该接口使用较少
            常用方法:
                ServletContext getServletContext();     返回所执行的Servlet的环境对象
                String getServletName();                返回所执行的Servlet的名字
                String getInitParameter(String name);   返回指定名字的初始参数值
                Enumeration getInitParameterName();     返回该JSP中所有初始参数名,枚举类
        --%>
    <%--
        pageContext:
            提供对JSP页面所有对象及命名空间的访问(除自己以外的8个JSP内部对象以及绑定在application page request session
            上的Java对象
            访问JSP页面上的所有对象及其属性
        常用方法:
            void forward(String relativeUrlPath);                       把页面转发到另一个页面或Servlet组件上
            Exception getException();                                   返回当前页面的Exception对象
            ServletRequest getResquesr();                               返回当前页面的Request对象
            ServletResponse getResponse();                              返回当前页面的Response对象
            ServletConfig getServletConfig();                           返回当前页面的ServletConfig对象
            HttpSession getSession();                                   返回当前页面的Session对象
            Object getPage();                                           返回当前页面的Page对象
            ServletContext getServletContext();                         返回当前页面的Application对象
            public Object getAttribute(String name);                    获取属性值
            Object getAttribute(String name, int scope);                获取指定范围内的属性值
            void setAttribute(Stirng name, Object attribute);           设置属性名以及属性值
            void setAttribute(String name, Object obj, int scope);      设置指定范围内的属性名以及属性值
            void removeAttribute(String name);                          删除指定属性
            void removeAttribute(String name, int scope);               删除指定范围内的属性
            void invalidate();                                          返回servletContext对象, 其余全部销毁
        --%>

<%--    pageContext 应用 (但是在实际JSP开发过程中很少使用 --%>
<form>
    <%
        request.setAttribute("info","value of request scope");
        session.setAttribute("info","value of request scope");
        application.setAttribute("info","value of application scope");
    %>
    利用 pageContext 取出以下范围内各值(方法一)：<br>
    request 设定的值：<%=pageContext.getRequest().getAttribute("info") %> <br>
    session 设定的值：<%=pageContext.getSession().getAttribute("info") %> <br>
    application 设的值：<%=pageContext.getServletContext().getAttribute("info") %> <hr>
    利用pageContext取出以下范围内各值(方法二)：<br>
    范围1(page)内的值：<%=pageContext.getAttribute("info",1) %> <br>
    范围2(request)内的值：<%=pageContext.getAttribute("info",2) %> <br>
    范围3(session)内的值：<%=pageContext.getAttribute("info",3) %> <br>
    范围4(application)内的值：<%=pageContext.getAttribute("info",4) %> <hr>
    利用 pageContext 修改或删除某个范围内的值：
    <% pageContext.setAttribute("info","value of request scope is modified by pageContext",2); %> <br>
    修改 request 设定的值：<br>
    <%=pageContext.getRequest().getAttribute("info") %> <br>
    <% pageContext.removeAttribute("info"); %>
    删除 session 设定的值：<%=session.getAttribute("info") %>
</form>



</body>
</html>
