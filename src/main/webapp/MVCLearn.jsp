<%--
  Created by IntelliJ IDEA.
  User: VHBin
  Date: 2021/11/18
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="UTF-8" %>
<html>
<head>
    <title>MVC</title>
    <meta charset="UTF-8">
</head>
<body>
    <h1>经典MVC模式</h1>
    <pre>
        职责分离:
            M: Model        业务逻辑,数据接口 (持有所有数据,状态和业务逻辑
            V: View         GUI (呈现模型
            C: Controller   控制器 (负责用户输入, 应用逻辑的处理
        <img src="image/MVC.png" alt="MVC模式图">
    </pre><hr>
    <h2>经典MVC模式运作流程</h2>
    <pre>
        用户 (操作) -> View (捕获操作) -> Controller (预处理操作 决定调用的Model接口) -> Model (执行相关业务逻辑)
        Model (变更) -- 观察者模式(Observer Pattern) -> View (收到Model变更的消息) -- 请求最新数据 -> Model [View更新页面]
    </pre>
    <h2>经典MVC优缺点</h2>
    <pre>
        优:
            业务逻辑和展示逻辑分离,模块化程度高
            应用逻辑变更时,只需要变更Controller即可
            观察者模式可以实现多视图变化
        缺:
            Controller测试困难(视图同步操作需要View执行,而View1的执行需要有UI的环境下才能运行)
            View不能组件化(View强依赖Model View单独抽出去复用在另外的Model上可能很困难,不同Domain 不同Model)
    </pre> <br>
    <h2>Web上的经典MVC</h2>
    <pre>
        客户端: 浏览器
        View: HTML页面
        应用层协议: HTTP(无状态协议)
                (因此使用了cookie 和 session 的技术)

        因此 Model 更改很难通知到 View
    </pre>
    <h3>Web中实现MVC</h3>
    <pre>
        Web开发模式:
            1 单JSP开发
            2 JSP + JavaBean (适合业务逻辑不复杂的应用程序)
            <img src="images/Web开发模式1.png" alt="JSP+JavaBean">
            <a href="ExperimentSix/Exper6.jsp">实验六</a>
            3 JSP + JavaBean + Servlet (MVC模式)
                View        JSP     (没有业务逻辑,
                                    仅负责检索Servlet创建的对象或JavaBean
                                    然后从Servlet中提取状态内容到静态模板中进行页面显示)
                Model       JavaBean (执行业务逻辑)
                Controller  Servlet  (完成逻辑控制)
            <img src="images/Web开发模式2.png" alt="JSP+JavaBean+Servlet"><br>
            <a href="ExperimentSeven/category">实验七</a>
    </pre>
</body>
</html>
