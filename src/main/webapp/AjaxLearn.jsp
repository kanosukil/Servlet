<%--
  Created by IntelliJ IDEA.
  User: VHBin
  Date: 2021/11/17
  Time: 21:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
pageEncoding="UTF-8" %>
<html>
<head>
    <title>Ajax</title>
    <meta charset="UTF-8">
</head>
<body>
    <h1>Ajax</h1>
    <pre>
        Ajax (异步JavaScript和XML)
            创建快速动态网页(通过在后台与服务器进行少量数据交换,使网页实验异步更新)
                [即 不重新加载网页的情况下,对网页的某部分进行更新]
    </pre><hr>
    <h2>Ajax与传统Web开发</h2>
    <pre>
        <b>传统Web</b>应用采用同步交互式过程.
            用户(发送请求/触发行为) -> HTTP服务器(按预先编写好的代码执行业务逻辑处理) -> 用户浏览器(以HTTP 和 CSS 数据的形式接受结果)
        特点:
            响应用户请求, 页面完全刷新
            简单的操作也会使页面刷新
            同步访问服务器端,用户体验不佳

        <b>Ajax开发模式</b>采用异步概念.
            客户端和服务器端不必再相互等待,而是并发进行.
            用户(发送请求) -> 用户继续自己的工作/浏览/提交信息
                |(异步请求)            |(HTML+CSS数据)
                            Ajax引擎
                |(HTTP请求)           |(XML数据)
            Web服务器(接收请求) -> 业务逻辑处理
        特点:
            页面只要部分刷新
            页面不会重新加载且只做必要的数据更新
            一部访问服务器端,用户体验良好

        异步:
            异步过程被调用 调用者不需立即获得结果 可继续其他事情 当过程调用完成时再通过回调函数通知调用方
        同步:
            同步过程被调用 调用者必须等待结果完成 才能继续其他事情
    </pre> <hr>
    <h2>请求方式</h2>
    <pre>
        同步请求:
            需执行同步请求,open()第三个参数需设置为 false (有时该设置作为快速测试
            xhttp.open("GET", "ajax_info.txt", false);
        异步请求:
            open()第三个参数为 true
            xhttp.open("GET", "ajax_test.asp", true);
    </pre> <hr>
    <h2>Ajax技术</h2>
    <pre>
        Ajax 由五种技术组成:
            异步数据获取技术 XMLHttpRequest (核心)
            基于标准的表示技术 XHTML 和 CSS
            动态显示和交互技术 Document Object Model (文档对象模型)
            数据互换和操作技术 XML 和 XSLT
            JavaScript 融合以上4种技术
    </pre> <br>
    <h3>XMLHttpRequest对象</h3>
    <pre>
        用于幕后服务器交换数据(更新网页的部分, 不必要更新整个网页)
        创建XMLHttpRequest对象语法:
            variable = new XMLHttpRequest();
            variable = new ActiveXObject("Microsoft.XMLHTTP"); (老版本的IE5 IE6 使用 ActiveX对象)
    </pre> <br>
    <h4>XMLHttpRequest对象属性</h4>
    <pre>
        onreadyStatechange      readyState属性变化时调用的函数
        readyState              保存XMLHttpRequest状态:
                                    0 请求未初始化
                                    1 服务器连接已建立
                                    2 请求已收到
                                    3 正在处理请求
                                    4 请求已完成且响应已就绪
        responseText            以字符串的形式返回响应数据
        responseXML             以XML的形式返回响应数据
        status                  返回请求状态号
                                    200 "OK"
                                    403 "Forbidden"
                                    404 "Not Found"
        statusText              返回状态文本 (例: "OK" "Not Found")
    </pre> <br>
    <h4>XMLHttpRequest对象方法</h4>
    <pre>
        new XMLHttpRequest()    创建一个新的XMLHttpRequest对象
        abort()                 取消当前响应
        getAllResponseHeaders() 获得HTTP响应头部作为未解析的字符串
        getResponseHeader()     获得指定HTTP响应头部的值
        open()                  初始化HTTP请求参数
        send()                  将GET请求发送到服务器
        send(String)            将POST请求发送到服务器
        setRequestHeader()      向要发送的报头添加标签/值对

        和服务器交换数据的方法:
            open(method, url, async)
                method 请求类型包括 GET POST HEAD
                url 服务器文件的位置
                async true:异步 false:同步
            send()          GET请求发送到服务器
            send(String)    POST请求发送到服务器
    </pre> <hr>
    <h2>Ajax请求</h2>
    <pre>
        GET请求
            e.g.
                xhttp.open("GET", "demo_get.asp", true); xhttp.send();                          // 将获得一个缓存的结果(即每次都读缓存的内容
                xhttp.open("GET", "demo_get.asp?fname=Bill&lname=Gates", true);xhttp.send();    // 添加唯一ID避免缓存结果
        POST请求
            e.g.
                xhttp.open("POST", "demo_get.asp", true); xhttp.send();                         // 请求获得的是txt文件
                // 如需像HTML表单那样POST数据,则需要通过 setRequestHeader() 设置HTTP头部,并在send()方法中添加需要发送的数据
                xttp.open("POST", "ajax_text", true);
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                    // name:头部名         value:头部值
                xhttp.send("fname=Bill&lname=Gates");
                // 没有添加HTTP头部, 将无法获得send()的内容

        URL地址请求
            e.g.
                xttp.open("GET", "ajax_test.asp", true);
                // open()方法内的URL为服务器上文件地址(该文件可为任何类型的文件 例 .txt .xml

        GET 比 POST 更简单更快，可用于大多数情况下。
        不过，请在以下情况始终使用 POST：
            缓存文件不是选项（更新服务器上的文件或数据库）
            向服务器发送大量数据（POST 无大小限制）
            发送用户输入（可包含未知字符），POST 比 GET 更强大更安全
    </pre> <hr>
    <h2>Ajax开发</h2>
    <pre>
        1 创建XMLHttpRequest对象
            写法:
                if (window.XMLHttpRequest) {
                    xmlhttp = new XMLHttpRequest();
                    // IE7+ Firefox Chrome Opera Safari 等浏览器
                }
                else {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")
                    // IE6 IE5 浏览器
                }

        2 定义响应事件处理函数
            写法:
                // onreadystatechange 事件为响应处理事件, 可把所有处理代码放入该事件对应函数中
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        document.getElementById("myDiv").innerHTML = xmlhttp.responseText;
                    }
                }

        3 发送HTTP请求
            写法:
                xmlhttp.open("GET", "servlet/PhotoServlet?index=" + index, true);
                xmlhttp.send(null);
    </pre>
</body>
</html>
