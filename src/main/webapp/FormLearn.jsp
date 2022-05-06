<%--
  Created by IntelliJ IDEA.
  User: VHBin
  Date: 2021/11/08
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Form 数据传输接收页面</title>
</head>
<body>
  <%
    request.setCharacterEncoding("UTF-8");
  %><br>
  <p id="test" style="background: aqua;font-weight: bold;">
    <%
      String str = request.getParameter("str");
      out.println("从上一个页面获取的信息为:" + str);
    %>
  </p>
  <%=request.getContextPath()%>
</body>
</html>
