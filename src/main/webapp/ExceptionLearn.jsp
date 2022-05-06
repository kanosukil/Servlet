<%--
  Created by IntelliJ IDEA.
  User: VHBin
  Date: 2021/11/15
  Time: 22:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Exception</title>
    <meta charset="UTF-8">
</head>
<body>
    实际操作时抛出异常会导致代码冲突和复杂,代码中最好只有业务相关操作.<br>
    将所有异常throw出给service, service抛出给controller, controller抛出给前端控制器,前端控制器抛出给全局异常处理器,所有异常统一进行处理<br>
    exception(throw) -> service -> controller -> 前端控制器 -> 全局异常控制器(统一处理)<br>
    全局异常控制器:<br>
        解释出异常类型<br>
            系统自定义异常:直接取出,在错误页面展示<br>
            非系统自定义异常:构造一个自定义的异常类型,信息"未知错误"<br>
    统一处理异常的要处理的问题:<br>
        发现全体异常(遇到异常即抛出<br>
        捕获全局异常(定义全局捕获处理器<br>
        定义自定义异常(定义继承自Exception的类<br>
    简单的异常处理:<br>
        创建error.jsp<br>
        web.xml中注册该页面<br>
</body>
</html>
