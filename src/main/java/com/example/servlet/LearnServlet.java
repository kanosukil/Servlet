package com.example.servlet;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author VHBin
 * @date 2021/11/09 - 16:54
 */

/*
    Servlet(Server Applet 小服务程序/服务连接器)
        Java编写的服务器端程序,动态生成Web网页
        运行在服务器端 并由服务器执行调用
        只能对客户端的一些数据进行调取或在客户端展示数据

    客户端(发送请求)-->服务器端(发送请求信息)-->Servlet[生成相应内容并发送(响应动态生成并取决于客户请求)]-->服务器端[将响应发送]-->客户端
    Servlet不能独立运行,需要由Servlet引擎控制和调度Servlet的运行
    针对客户端的多次Servlet请求,通常服务器只会创造一个Servlet实例对象(即Servlet实例对象一旦被创建就会驻留在内存中,响应后续的请求,
    直到Web容器退出,Servlet实例对象才会销毁

    整个Servlet生命周期:
        init()方法只调用一次
        service()方法:每个访问请求都会使servlet引擎调用一次
            每次请求都会创建一个新的HttpServletRequest对象和一个新的HttpServletResponse对象,然后作为service()方法的参数被使用
            service()根据请求方式,分别调用doPost()或doGet()方法.
        (web.xml文件中的的<servlet>元素中配置了<load-on-startup>元素的话,servlet将会根据<load-on-startup>的值按顺序在Web应用
        启动时,装载并创建Servlet实例对象和调用servlet的init()方法)

    Servlet工作流程:
        1. 浏览器根据信息组装HTTP报文,并发送给指定服务器
        2. 服务器接收到报文后,利用web容器(Tomcat之类的)提取并解析HTTP报文,若是请求则将解析结果用request对象存储
        3. 服务器处理request后,将处理结果存放在response对象内,并封装成HTTP报文回传给浏览器
        4. 浏览器收到装着response的报文后解析,将处理结果显示在浏览器上
 */
/*Servlet使用时, Java VMS一直运行,因此接收到一个请求后, Java MVS创建一个Java线程马上处理.*/
@WebServlet(name = "LearnServlet", value = "/learn-servlet")
public class LearnServlet extends HttpServlet {
    /*servlet生命周期
        创建 init()       Servlet实例化时,init()将被调用(可放一些初始化代码,且只被调用一次
        服务 service()    一个请求创建一个新的进程,由service()方法决定调用doGet()还是doPost()
                          两者都是根据 ServletRequest获取客户端请求信息和相关信息 ServletResponse设置响应信息
                          (doGet() doPost() service())
        消亡 destroy()    Servlet消亡时自动调用destroy()方法,需要在消亡前完成的释放工作,可以通过重写destroy()完成(只被调用一次
        */

    // public ServletConfig getServletConfig(){}
    // 返回时调用init()方法时传给Servlet对象的ServletConfig对象(包含Servlet初始化参数

    // public void init(ServletConfig arg0){}
    // 参数为传入的配置文件
    public void init() {
    }
    /*
        Servlet 必须符合http协议才能被部署在web容器中(且必须要在web.xml中部署)
        由于是多线程程序,每一次请求都会创建一个进程并都会调用一次service()方法,且每个进程访问的全局变量共享,
        因此每个线程访问的数据都是同步的
     */

    /*
        Servlet内置对象:
            out:
                根据doPost()或doGet()内的response参数获取
                默认无法打印中文(需设置:response.setContextType("text/html;charset=UTF-8")[或gb2312])
            request 和 response :
                doGet() doPost()方法的参数直接对应
            session:
                HttpSession session = request.getSession();
            application:
                ServletContext application = this.getServletContext();
     */

    // public void service(ServletRequest request, ServletResponse response){}
    // Servlet的动作  request 请求 response 响应

    //表单可指定post方式
    public void doPost(ServletRequest request, ServletResponse response) throws IOException {
        doGet(request, response);
    }

    //超链接以及表单指定的get方式
    public void doGet(ServletRequest request, ServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8"); // 设置页面编码

        PrintWriter out = response.getWriter();
        out.println("Welcome!");
    }

    // 销毁时调用
    public void destroy() {
    }

    // public String getServletInfo(){}
    // 返回String字符串, 包含Servlet信息(作者 版本 版权等
}
