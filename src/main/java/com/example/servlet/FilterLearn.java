package com.example.servlet;

import javax.servlet.*;
import java.io.IOException;

/**
 * @author VHBin
 * @date 2021/11/15 - 08:37
 */

/*
    filter:过滤器
        作用:
            对请求和响应统一处理
            对请求进行日志记录和审核
            对数据进行屏蔽和替换
            对数据进行加密和解密
        小巧可插入的Web组件, 对Web应用程序的前期和后期处理进行控制,拦截请求和响应,查看提取或其他方式的操作CS之间正在交换的数据
        动态拦截请求和响应,以交换或使用请求响应中的信息.
        可实现:
            拦截客户端访问后端资源的请求
            处理服务器发送回客户端的响应
        一般把Filter配置在所有Servlet之前.

        执行预处理工作的filter(没有拦截功能)(e.g.设置编码等)
        通过条件判断是否放行(有拦截操作)(e.g.会员有会员的权利,游客有游客的权利)
        目标资源执行后的一些后期特殊处理工作(e.g.处理目标资源输出的数据)

        需要filter的场景
            设置编码
            客户登录的检查
            不同权限的用户的管理
 */
public class FilterLearn implements Filter {
    /*
        void init() Filter 初始化,服务器启动时及创建并立即执行此方法,来初始化一些参数
        void doFilter(req, res, chain) 请求的Servlet或jsp在过滤器范围内将执行
            若方法体内没有chain.doFilter() 操作时,访问该过滤器范围内的资源将全被过滤
            若方法体内存在chain.doFilter() 操作时,将不对范围内的资源进行过滤
        void destroy() 服务器关闭时销毁Filter, 销毁前执行该方法, 用于释放非内存资源
     */

    /*
        多个过滤器:
            执行顺序:web.xml <filter-mapping>控制(自上而下)多个过滤器则形成过滤器链
            chain.dopFilter(request, response):
                将请求转发给过滤器链上的下一个对象(有filter即为下一个filter,没有即请求的资源

        请求方式:
            拦截直接请求 REQUEST
            拦截请求转发 FORWARD
            拦截请求包含 INCLUDE
            拦截错误转发 ERROR
        实现:
            在<filter-mapping>中进行配置
            <dispatcher>REQUEST</dispatcher>
            <dispatcher>FORWARD</dispatcher>
            <dispatcher>INCLUDE</dispatcher>
            <dispatcher>ERROR</dispatcher>
            没配置则只拦截请求
     */

    /*
        web服务器调用web资源:
            web服务器->filter的doFilter()->doFilter()内的filterChain对象的doFilter()方法->
            调用web资源的service方法
            重点:Filter对象的doFilter()方法内是否有filterChain对象的doFilter()方法
            没有filterChain.doFilter()被拦截
            不在filterChain.doFilter()范围内也将被拦截
     */

    /*
        过滤器配置:
            1 <filter>元素定义过滤器
                <filter>
                    <filter-name>name</filter-name>
                    <filter-class>class</filter-class>
                </filter>
                其他元素:
                    <description> 描述信息
                    <init-param> 过滤器指定初始化参数
            2 <filter-mapping>配置过滤器的映射, 过滤所有文件
                <filter-mapping>
                    <filter-name>FilterName</filter-name>
                    <url-pattern>Path</url-pattern>
                </filter-mapping>
                filter-mapping 设置该Filter所拦截的资源
                其他元素:
                    <servlet-name> 指定过滤器所拦截的Servlet的名称
                    <dispatcher> 指定过滤器所拦截的资源被Servlet容器调用的方式
     */

    /*
        Filter生命周期:
            Filter创建:Web服务器负责(启动)
            Filter销毁:Web服务器负责
            FilterConfig接口:获得部署描绘的Init-Param设置的参数
     */

    /*
        FilterConfig:
            getInitParameter() 获取初始化参数
            getInitParameterNames() 获取所有初始化参数名称
            getFilterName() 获取过滤器配置名
            getServletContext() 获取Application
        (!:FilterChain 的doFilter()与Filter的doFilter功能区别:
            FilterChain 的 doFilter 被调用为放行资源
            Filter 的 doFilter 被调用为拦截资源
     */

    /*
        Filter 的使用时机:
            获取请求数据并操作
            性能保障
            安全保障
            会话处理
     */
    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
    }
}
