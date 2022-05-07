# Servlet

> Server Applet 小服务程序/服务连接器
>
> Java编写的服务器端程序: <br>1. 动态生成Web网页<br>2. 运行在服务器端 并由服务器执行调用<br>3.只能对客户端的一些数据进行调取或在客户端展示数据
>
> 客户端(发送请求)-->服务器端(发送请求信息)-->Servlet[生成相应内容并发送(响应动态生成并取决于客户请求)]-->服务器端[将响应发送]-->客户端
>
> **Servlet不能独立运行,需要由Servlet引擎控制和调度Servlet的运行 (因此需要 Tomcat 网络服务器)**
>
> 针对同一个客户端的多次Servlet请求,通常服务器只会创造一个Servlet实例对象(即Servlet实例对象一旦被创建就会驻留在内存中,响应后续的请求,**直到Web容器退出,Servlet实例对象才会销毁**=>Servlet Application 的生命周期为整个应用的运行期间
>
> <hr>

## Servlet

> IDEA 部署
>
> 配置好 Artifacts 选择 Web Application: Exploded
>
> 再 Run 下 Edit Configuration 添加 Tomcat Server 点击 fix 即可
>
> Maven 设置 package 为 war

```java
/*
 * Servlet 结构
 */
@WebServlet(name = "Servlet_Name", value = "/path") // 在 web.xml 中配置了 <servlet> & <servlet-mapping> 对应到了此类, 可以不使用此注解; 或者是 使用了注解可以不用在 web.xml 中配置 <servlet> & <servlet-mapping>
public class Servlet_Name extends HttpServlet { // 类名最好和注解中的 name 对应(但也可以不一样), 继承 HttpServlet 类需要引入 javax.servlet:javax.servlet-api 依赖
    // 各个方法上的 @Overrider 注解可加可不加(最好加上)
    
    // @Override
    // public ServletConfig getServletConfig(){}
    // 返回时调用init()方法, 并将Servlet对象的ServletConfig对象传给 init() 方法(包含Servlet初始化参数)

    // @Override
    // public void init(ServletConfig arg0){}
    // 参数为传入的配置文件
    // @Override 
    // public void init() {}

    // @Override
    // public void service(ServletRequest request, ServletResponse response){}
    // Servlet的动作  request 请求 response 响应

    //表单可指定post方式
    @Override
    public void doPost(ServletRequest request, ServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
    //浏览器直接访问以及表单指定的get方式
    @Override
    public void doGet(ServletRequest request, ServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8"); // 设置页面编码
		// ... request 内的数据进行操作 ...
        PrintWriter out = response.getWriter(); // 获得 out 对象
    }

    // 销毁时调用
    // @Override
    // public void destroy() {}

    // public String getServletInfo(){}
    // 返回String字符串, 包含Servlet信息(作者 版本 版权等
}
```

+ 整个Servlet生命周期期间:

      1. init()方法只调用一次: Servlet 实例化时调用, 可添加一些初始化信息<br>
      
            > 可不写, 有初始化要求时再写
      
      2. service()方法:每个访问请求都会使servlet引擎调用一次<br>每次请求都会创建一个**新的HttpServletRequest对象**和一个**新的HttpServletResponse对象**,然后作为service()方法的参数被传入 (**Tomcat Connector 容器 & Engine 容器**)<br>
    service()根据请求方式,分别调用doPost()或doGet()方法.<br>
      (web.xml文件中的的`<servlet>`元素中配置了`<load-on-startup>`元素的话,servlet将会根据`<load-on-startup>`的值按顺序在Web应用启动时,装载并创建Servlet实例对象和调用servlet的init()方法)<br>

      3. destory()方法只调用一次: Servlet 消亡时调用, 可在消亡前执行一些释放操作<br>
      
            > 可不写, 有销毁前处理时再写

 <hr>

+ Servlet工作流程(B/S):
         1.  浏览器(客户端)根据信息组装HTTP报文,并发送给指定服务器
         2.  服务器接收到报文后,利用web容器(Tomcat之类的)提取并解析HTTP报文,若是请求则将解析结果用request对象存储
         3.  服务器处理request后,将处理结果存放在response对象内,并封装成HTTP报文回传给浏览器
         4.  浏览器(客户端)收到装着response的报文后解析,将处理结果显示在浏览器上
     
     > Servlet使用时, Java VMS一直运行,因此接收到一个请求后, Java MVS创建一个Java线程马上处理.(Web 容器/服务器)

<hr>

+ Servlet必须符合http协议才能被部署在web容器中(且必须要在web.xml中部署)
  且由于是多线程程序,每一次请求都会创建一个进程并都会调用一次service()方法,且每个进程访问的全局变量共享,因此每个线程访问的数据都是同步的

+ Servlet内置对象:

  1. out:

     可以从传入到 doPost() 或 doGet() 内的 response 参数获取

     > 默认无法打印中文
     >
     > 需设置:response.setContextType("text/html;charset=UTF-8") [或gb2312]

     ```java
     PrintWriter out = response.getWriter();
     out.println("html 代码可以编译, 也可以直接写字符串")
     ```

  2. request 和 response :
     和传入 doGet() & doPost()方法的参数对应

     > 可以实现重定向: 
     >
     > + request:
     >
     >   1. request.getRequestDispatcher(“jsp | html | servlet”).forward(request,response);
     >
     >      > 将请求从Servlet**转发**到服务器上的另一个资源（servlet，JSP页面或HTML文件）
     >      >
     >      > 最终返回的 response 为跳转资源的 response
     >      >
     >      > 地址栏中的 URL 不变化
     >
     >   2. request.getRequestDispatcher(“jsp | html | servlet”).include(request.response);
     >
     >      > 在响应中**插入**资源（servlet，JSP页面或HTML文件）的内容
     >      >
     >      > 最终返回的 response 为两者的 response 的结合
     >      >
     >      > 地址栏中的 URL 不变化
     >
     > + response: 
     >
     >   + response.sendRedirect("jsp | html | servlet");
     >
     >     > 生成 302 响应码 & Location 响应头, 并通知客户端重新访问 Location 响应头中指定 URL
     >     >
     >     > 客户端接收到 ;两个 response (一个 跳转 response; 一个 跳转目标资源返回的 response)
     >     >
     >     > 地址栏中的 URL 会变化
     
  3. session:
     `HttpSession session = request.getSession();`
  
  4. application:
     `ServletContext application = this.getServletContext();`

## Filter

> 特殊的 Servlet
>
> Filter 过滤器: 小巧可插入的 Web 组件
>
> 1. 控制 Web 前期和后期数据的处理
> 2. 拦截请求和响应, 查看提取或其他方式的操作 CS | BS 之间正在交换的数据
> 3. 动态拦截请求和响应, 以交换或使用请求和响应中的数据.

+ 作用

  1. 统一处理请求和响应
  2. 对请求进行日志记录和审核
  3. 对数据进行屏蔽或替换
  4. 对数据进行加密或解密

+ 使用时机

  + 获得请求数据并对其进行操作
  + 性能保障
  + 安全保障
  + 会话处理(Session)

+ 应用场景

  1. 拦截客户端访问后端资源的请求

     > 通过条件判断是否放行 (e.g.会员有会员的权利,游客有游客的权利)

  2. 处理服务器发送回客户端的响应

     > 目标资源执行后的一些后期特殊处理工作 (e.g.处理目标资源输出的数据)

  3. 执行预处理工作

     > 没有拦截功能 (e.g.修改请求和响应数据的编码)

+ Filter 结构

  ```java
  @WebFilter(filterName = "Filter_Name", urlPattern = "/*") // 和 web.xml 中的 <filter> & <filter-mapping> 对应, 两者选一即可(即, 写此注解可不写web.xml中配置; 写web.xml中配置可不写此注解)
  public class Filter_Name implements Filter {
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
  ```

  + Filter生命周期

    1. FilterConfig接口:获得部署描绘的Init-Param设置的参数

    2. Filter创建:Web服务器负责(启动)

       > 可使用 void init() Filter 初始化,服务器启动时及创建并立即执行此方法,来初始化一些参数

    3. doFilter执行: 对请求和响应数据做一些操作

       >  void doFilter(req, res, chain) 请求的Servlet或jsp在过滤器范围内将执行
       >
       > 1. 若方法体内没有chain.doFilter() 操作时,访问该过滤器范围内的资源将全被过滤
       > 2. 若方法体内存在chain.doFilter() 操作时,将不对范围内的资源进行过滤

    4. Filter销毁:Web服务器负责.

       > 可使用 void destroy() 服务器关闭时销毁Filter, 销毁前执行该方法, 用于释放非内存资源

  + 多个过滤器

    + 执行顺序

      由 web.xml 中的`<filter-mapping>`控制(自上而下)多个过滤器则形成过滤器链

      > chain.doFilter(request, response);
      >
      > chain.doFilter() 方法将请求转发给过滤器链上的下一个对象(有filter即转到下一个filter,没有即转到请求的资源) 

      > 其他关于 web.xml 中 `<filter>` & `<filter-mapping>` 见 <a href="#webxml">web.xml 解析</a>

  + Web 服务器调用 Web 资源

    + Web 请求流动顺序:

      Web 服务器 -> Filters 的 doFilter() 方法(Filter 链) ->  Servlet 的 service() 方法

    + 重点: Filter 链中的 Filter doFilter() 方法是否一直都会执行 filterChain.doFilter(request, response) 方法

      1. 若有一个不执行, 则请求被拦截
      2. 若全执行, 则 Web 请求最终会通过 Servlet 调用 Web 资源

  + FilterConfig

    > init() 方法传入参数 FilterConfig

    + 方法
      1. getInitParameter() 获取初始化参数
      2. getInitParameterNames() 获取所有初始化参数的名称
      3. getFilterName() 获取过滤器 配置的名称
      4. getServletContext() 获取 Application 对象

  + **Filter & FilterChain 的 doFilter() 方法**

    + FilterChain 的 doFilter() 方法: 将请求和响应对象传给下一个 Filter 或 Servlet

      > 接收参数: requset, response

    + Filter 的 doFilter() 方法: 处理请求和响应数据, 若其中没有执行 FilterChain 的 doFilter() 方法, 将拦截请求

      > 接收参数: requset, response, filterChain

## Tomcat

+ WebApp 下的各目录作用

  | dir-name | 作用 |
  | -------- | ---- |
  | WEB-ROOT | Web的根目录, (一般虚拟目录(定义在非 Tomcat webapps 目录下的站点目录)直接指向该目录, 且必包含WEB-INF) |
  | WEB-INF | Web下最安全的目录(包含各类第三放jar包&配置文件) |
  | web.xml | Web的部署描述符(部署配置文件) |
  | classes | 保存所有 JavaBean |
  | lib | 保存所有第三方 Jar 包 |
  | tags | 保存所有标签文件 |
  | jsp | 保存所有 JSP 文件(内含根据功能分定的子目录) |
  | js | 保存所有 JavaScript 文件 |
  | css | 保存所有 CSS 文件 |
  | images | 保存所有 图片 资源 |

+ 运行 Java 的网络服务器

+ JSP & Servlet 的容器

+ Tomcat 的配置文件

  + `server.xml`该文件用于配置 server 相关的信息，比如 tomcat 启动的端口号，配置主机(Host)

    + 文件结构: 

      + 最外层 `<server>` 

        + 代表整个Tomcat容器

        > 一个 Server 中可以有多个 Service

        + 属性: shutdown 属性表示关闭 Server 的指令, 而 port 属性表示 Server 接收 shutdown 指令的端口号(-1 表示禁用使用 shutdown 的端口).
        + 作用:
          + 提供一个接口让客户端能够访问到这个Service集合
          + 维护它所包含的所有的Service的生命周期(包括如何初始化、如何结束服务、如何找到客户端要访问的Service)

      + `<service>` 

        + 封装 Connector & Engine, 对外提供服务

        > **一个Service可以包含多个Connector，但是只能包含一个Engine**
        >
        > Connector: 从客户端接收请求
        >
        > Engine: 处理接收进来的请求
        >
        > Tomcat 中默认封装了一个 name 为 Catalina 的 Service

      + `<connector>`

        + 接受连接请求, 创建 Request & Response 对象用于和请求交换数据

        + 分配线程给 Engine 处理请求, 并将创建的 Request & Response 对象传给 Engine 处理数据

        + 配置 Connector 可控制请求 Service 的协议 & 端口号 等设置

        + Tomcat 默认 Connector

          ```xml
          <!--
          	port: 接收请求的端口号
          	protocol: 接收的协议
          	connectionTimeout: 链接超时时间
          	redirectPort: 重定向端口号(例如: 强制要求请求协议是 HTTPS 时, 但请求传过来的协议为 HTTP 时使用该端口)
          -->
          <Connector port="8080" 
                     protocol="HTTP/1.1"
                     connectionTimeout="20000"
                     redirectPort="8443" />
          ```

      + `<engine>`

        > **Engine组件在Service组件中有且只有一个；Engine是Service组件中的请求处理组件。**

        + 一个 Engine 可以处理一个或者多个 Connector 接收到的请求, 并将完成的响应返回给 Connect, 最终个 Client

        + Engine、Host和Context都是容器, 但它们不是平行的关系, 而是父子关系: Engine包含Host, Host包含Context

        + Tomcat 中默认 Engine: `<Engine name="Catalina" defaultHost="localhost">...</Engine>`

          > name 用于日志和错误信息(在整个 Server 中应该唯一)
          >
          > defaultHost 指定默认的 host 名(必须和 Host 标签 name 属性值匹配)

      + `<host>`

        + Host 为 Engine 的子容器, Engine 内可嵌入一个或对多个 Host 组件

        > **每个Host组件代表Engine中的一个虚拟主机**

        + 作用: 运行多个Web应用(一个Context代表一个Web应用), 并负责安装、展开、启动和结束每个Web应用

        + Host组件代表的虚拟主机, 对应了服务器中一个网络名实体(域名 或 IP地址)

        + Tomcat 中 Host 默认配置: `<Host name="localhost"  appBase="webapps" unpackWARs="true" autoDeploy="true">`

          > name 指定虚拟主机的主机名(一个 Engine 中 有且只有一个 Host 的 name 于 Engine 的 defaultHost 相匹配); 一般情况主机名应该为 DNS 服务器中注册的域名/网络名
          >
          > unpackWARs 是否将代表Web应用的WAR文件解压(true 则通过解压后的文件结构运行该 Web 应用; false 则直接使用 WAR 文件运行 Web 应用)
          >
          > autoDeploy & appBase 与Host内Web应用的自动部署有关(见 context)

      + `<context>`

        > Context元素代表在特定虚拟主机上运行的一个Web应用

        + 每个Web应用基于WAR文件, 或WAR文件解压后对应的目录(这里称为应用目录)

        + Context是Host的子容器, 每个Host中可以定义任意多的Context元素.

        + **默认情况下 Tomcat 中没有配置该标签**

        + Tomcat 自动部署配置:

          + Host 的属性: deployOnStartup & autoDeploy, 两者都设置为 true 时, Tomcat 启动自动部署

            > deployOnStartup Tomcat 启动时检测 Web 应用(检测到的都是新的 Web 应用)
            >
            > autoDeploy 运行时定期检测 Web 应用的修改和新添

          + Host 的属性: appBase & xmlBase

            > appBase 指定 Web 应用的所在目录, 默认值为 webapps (相对路径, 相对于 Tomcat 的根目录)
            >
            > xmlBase 指定 Web 应用的 xml 配置文件目录, 默认值为 `conf/<engine_name>/<host_name>`

          + 自动部署扫描顺序

            1. 虚拟主机指定的 xmlBase 下的 xml 配置文件
            2. 虚拟主机指定的 appBase 下的 WAR 文件
            3. 虚拟主机指定的 appBase 下的应用目录

        + Context 标签配置

          + 形式

            `<Context path="/web项目名" docBase="站点目录的绝对路径(项目的根目录)" reloadable="true"/>`

            > 但需要注意: 
            >
            > ​		在自动部署场景下, 不能指定path属性, path属性由**配置文件的文件名**、**WAR文件的文件名**或**应用目录的名称**自动推导出来
            >
            > docBase 指定了该Web应用使用的WAR包路径, 自动部署的环境下, 应用程序不在 appBase 指定目录下时, 才需要指定 WAR 包 或 应用目录
            >
            > reloadable 指示 tomcat 是否在**运行时**监控在 WEB-INF/classes 和 WEB-INF/lib 目录下class文件的改动

    + 由 `<context>` 标签可见, 设置 虚拟目录 的两种方法: 

      1. 在 Tomcat 的 server.xml 文件中, `<Host>` 标签下新建 `<Context>` 标签并设置 docBase 属性值

      2. 在 Tomcat 的 conf/Catalina/localhost 目录下, 创建以 Web 应用命名的 xml 配置文件, 内容为

         ```xml
         <?xml version="1.0" encoding="UTF-8"?> 
         <Context docBase="path" reloadable="true"> </Context> 
         ```

  + `web.xml`文件配置与 web 应用（web应用相当于一个web站点）

    + <a name="webxml"></a>Web 应用的 web.xml 文件

      ```xml
      <?xml version="1.0" encoding="UTF-8"?>
      <web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
               version="4.0">
          <!--
          	<load-on-startup> 指定Web应用启动时装载Servlet的次序.
              	值 >= 0 : 先加载小的,再加载大的
              	值 < 0 | 未定义: Servlet容器将在Web客户首次访问这个Servlet时加载它
          	<listener>
              	Listener元素指出事件监听程序类
      		    可配置 Spring 的 配置文件
          	<session-config>
              	配置会话超时,单位:分钟
          	<error-page>
              	返回特定http状态代码时或特定类型的异常被抛出时,指定将要显示的页面
          	-->
          <!--display-name 标注该Web项目的名字-->
          <display-name>Servlet First Test</display-name>
          <!--定义全局变量-->
          <!--
                  设置全局参数:(所有servlet都可使用)
                      <context-param>
                          <param-name>参数名</param-name>
                          <param-value>参数值</param-value>
                      </context-param>
                  Servlet设置全局参数:
                      ServletContext context = this.getServletContext();
                      context.setAttribute("name",value);
      		   Servlet获取全局参数:
                      context.getAttribute("参数名");
                  Servlet获取初始化参数:
                      context.getInitParameter("参数名");
                  -->
          <context-param>
              <param-name>javax.faces.CONFIG_FILES</param-name>
              <param-value>/mybatis-config-annotation.xml</param-value>
          </context-param>
          <!--description 对该Web项目的文本描述-->
          <description>Learn Servlet</description>
      	<!--welcome-list-file 定义首页文件-->
          <welcome-file-list>
              <welcome-file>index.jsp</welcome-file>
          </welcome-file-list>
      	<!--定义filter-->
          <filter>
              <filter-name>filter_test</filter-name><!--filte名-->
              <filter-class>com.example.servlet.FilterLearn</filter-class><!--filter所在的完全限定名-->
              <!--
      			其他属性: 
                   <description> 描述信息
                   <init-param> 指定过滤器初始化参数
      			-->
          </filter>
          <!--filter 映射配置: 设置该 Filter 所拦截的资源-->
          <filter-mapping>
              <filter-name>filter_test</filter-name><!--必须和前面 filter 标签定义的一致-->
              <url-pattern>/gather</url-pattern><!--filter起作用的路径, 每个 filter-mapping 中只能设定一个, 需要设置多个就需要创建多个 filter-mapping 标签-->
              <dispatcher>REQUEST</dispatcher><!--被拦截的请求别 Servlet 处理的方式, 默认REQUEST. 可选值: REQUEST,INCLUDE,FORWARD和ERROR-->
              <!--
      			REQUEST: 请求通过 RequestDispatcher 的 include() 或 forward() 方法访问时, 不调用 filter
      			INCLUDE: 请求通过 RequestDispatcher 的 include() 方法访问时, 才调用 filter
      			FORWARD: 请求通过 RequestDispatcher 的 forward() 方法访问时, 才调用 filter
      			ERROR: 请求通过 声明式异常处理机制 访问时, 才调用 filter
      		RequestDispatcher 的 include() 或 forward() 方法: 重定向
      			-->
              <!--
      			其他属性: 
      				<servlet-name> 指定过滤器所拦截的 Servlet 的名称
      			-->
          </filter-mapping>
      
          <servlet>
              <!--servlet-name 指定servlet的名称-->
              <servlet-name>Gather_Information</servlet-name>
      		<!--servlet-class 指定servlet的类名称-->
              <servlet-class>com.example.servlet.Gather_Information</servlet-class>
      		<!--
                  init-param 定义初始化参数
      				可有多个,且在servlet中可通过ServletConfig对象传入init函数中, 
      				可用ServletConfig对象的getInitParameter(String name)方法获取其值.
                  创建并访问初始化参数.
                  语法:
                          <init-param>
                              <param-name>string</param-name>
                              <param-value>object</param-value>
                          </init-param>
                  Servlet内:
                      public void init(ServletConfig config) throws ServletException {
                          super(config);
                          String str = config.getInitParameter("string");
                      }
                          -->
          </servlet>
          <servlet-mapping>
              <servlet-name>Gather_Information</servlet-name>
              <url-pattern>/gather</url-pattern>
              <url-pattern>/gather-inf</url-pattern>
          </servlet-mapping>
          <!--    
                  <servlet-mapping>
                      定义servlet所对应的url
                      包含属性:
                          <servlet-name>
                          <url-pattern> 指定servlet所对应的url
                      拓:
                          url-pattern 匹配规则:
                              优先级由高到低:
                              1. 精准匹配: 精准路线(绝对路径)(默认在项目名后添加匹配路径)
                              2. 通配符匹配: /* (/后所有都匹配)
                              3. 拓展名匹配: *.jsp *.html *.do *.action 等 (只看最后的拓展名)
                              4. 默认匹配: / (当之前的都不成功时, 匹配根目录下的所有资源路径)
                          (注:容器无法识别同时拥有两种匹配规则的pattern)
                          (一般不设置为 / 或 /* 因为如此设置整个项目的静态资源(非servlet)将无法访问)
              -->
      </web-app>
      ```
  
  + `tomcat-user.xml`配置用户名密码和相关权限.

## JSP

> 主体跟 HTML 文件一样, 可以通过特有语法使用 EL表达式 & Java代码

### 注释语法

1. JSP 特有

   `<%--注释--%>`

2. HTML

   `<!--注释-->`

3. 特定代码块内使用对应语言的注释语法

### EL 表达式的使用

+ 结构: `${expression}`

+ EL提供"."和"[]"两种运算符存取数据

   1. 当要存取的属性名称中包含一些特殊字符就必须要使用"[]"

  2. 当要动态取值时就可以用"[]",而"."无法做到动态取值

+ EL 存取 变量数据

  > e.g. `${username}` 去取**某一范围内**名称为 username 的变量值
  >
  > 在范围内找到了即返回其值(有多个, 则取第一个), 没有则返回 null

+ 属性范围 在 EL 中的名称

  | JSP 概念在 EL 中的名称 | 范围              |
  | ---------------------- | ----------------- |
  | page                   | pageScope         |
  | request                | requestScope      |
  | session                | sessionScope      |
  | application            | applicaitoonScope |

+ 常常使用 `${pageContext.request.contextPath}` 获取当前项目的 Classpath

  > `${pageContext.request.contextPath}` 等同于 `<%=request.getContextPath()%>` 获取部署的应用程序名


### Java 程序段

+ 结构: `<% Java 代码块 %>`

+ 跟 HTML 元素一样, 可以有很多, 且按顺序执行.

+ **和 MVC 前后端分离概念不符(前端页面内有逻辑处理)**

  > 这也因此是只用 JSP 就可以构建个站点的原因

```jsp
<p style="background: aqua;size: A4">
    <%
    out.println("PI = " + Math.PI);
    out.println("atan75 = " + str);
    %>
</p>
<!--可输出,无错误,但标签p未换行-->
```

### JSP 表达式

+ 结构: `<%=Java String%>` 

  > 其中可以为 Java 代码返回的 String 类型数据
  >
  > 例如: `<%=request.getContextPath()%>` 
  >
  > 也可以直接是 Java String

+ **不能以 ';' 结尾**

### JSP 声明

+ 结构: `<%! Java 代码段 %>`

  > 编写 class 或 函数, 供后面使用
  >
  > JSP 表达式可以使用; Java 程序段也可使用

+ JSP 声明 是定义一个 Java 类 或 方法 或 JSP 页面的成员变量(整个 JSP 页面都可以使用)

  1. 声明的变量可为Java允许的任何数据类型
  2. 声明的方法整个JSP页面有效,但方法中的变量仅在方法内有效
  3. 声明的类可以在JSP页面的Java程序段部分使用该类创建对象

```jsp
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
<%--声明在jsp中要尽量少用逻辑代码(逻辑代码应该放在业务代码中,而非页面代码中--%>
```

### JSP 页面 URL 传值

```JSP
<!--A.jsp 页面-->
...
<a href="B.jsp?id=${id}"></a>
...
<!--B.jsp 页面-->
<% String id=request.getParameter("id"); %>
<input name="id" value="<%=id%>">
```

+ 优点: 简单且全平台支持(URL 全平台都可用)
+ 缺点: 只能传字符串; 值将在 浏览器 的地址栏中显示(因此不能传递密码)

### JSP 指令

> JSP指令先被程序查找并转换成 servlet .在页面转换时期执行且只编译一次.
>
> 即: JSP 页面创建就执行一次 JSP 指令, 但之后没有执行的途径了, 因此只编译执行一遍

+ 结构: `<%@ 指令类型 属性1=value1 属性2=value2 ... %>`

  > 大小写敏感

+ JSP 指令类型: 

  1. page

     + 导包

       `<%@ page import="导入包名.类名" %>`

       > `<%@ page import="java.util.Date" %>`

     + 设定字符集

       `<%@ page pageEncoding="编码类名" %>`

     + 指定MIME类型 & 字符编码

       `<%@ page contentType="MIME类型;charset=字符编码" %>`

       > `<%@ page contentType="text/html;charset=UTF-8" language="java" %>`

     + 设定错误页面

       `<%@ page errorPage="anErrorPage.jsp" %>`

       > anErrorPage.jsp 内: 
       >
       > `<%@ page isErrorPage="true" %>`

  2. <a id="include"></a>>include

     + 用于在 JSP 文件中插入一个**包含文本或代码**的文件

     + 静态插入, 融合成一个页面, 且指定页面的 编译指令 将执行

       > `<% include file="jsp文件" %>`

  3. taglib

     + 用来声明 JSP 文件使用的自定义标签, 同时应用所指定的标签库以及设置标签库的前缀

       `<%@ taglib uri="URIToTagLibrary" prefix="tagePrefix" %>`

       > ```jsp
       > <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
       > <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
       > ...
       > <c:forEach items="${category}" var="category">
       >     <li>
       >         <a href="javascript:showBook(${category.id})">${category.name}</a>
       >     </li>
       > </c:forEach>
       > ...
       > ```

### JSP 动作

> JSP动作 客户端请求时按照在**页面的顺序**执行,且只有在**被执行时才实现具有的功能**,客户每请求一次,动作就被标识一次.
>
> 即: JSP 页面创建时, 只提供执行途径, 并不执行 JSP 动作; 待用户点击执行, 才会实现指定功能, 且执行后还可以再次执行

+ 使用XML语法格式的标记控制服务器的行为.可完成各种通用的JSP功能.

  > 动态插入文件,重定向用户页面;为java插件生成HTML代码等

+ 结构: `<jsp:动作名 属性1=value1 属性2=value2 ... />` 或 `<jsp:动作名> 相关内容 </jsp:动作名>`

+ 常见 JSP 动作:

  1. jsp:include: 当页面被请求时引入一个文件

     + 结构: `<jsp:include page="文件名" />`

     + **动态**的包含静态和动态的文件(可对include页面通过URL传值方式传输变量值)<br>即将指定的页面**插入**到本页面

       > 指定页面的编译指令不会执行, 仅为body页面插入
       >
       > 因为是插入, 因此 URL 不变
       >
       > 可以使用 `<jsp:param name="" value="" />` 添加参数

       + `<jsp:include page="包含文件URL地址|<%=expression%>" flush="true|false" />`

         > flush 缓存满了后是否清空, 默认 false

     + 静态导入见<a href="#include"> `<%@ include file="xxx.jsp" %>` </a>

     + 类 `request.getRequestDispatcher(“jsp | html | servlet”).include(request.response)` 方法

  2. jsp:forward: 将请求转到另一个页面

     + 结构: `<jsp:forward page="文件名" />`

     + 转移用户请求,使用户请求的页面从一个页面**跳转**到另一个页面.

       > 依然是一次请求, 请求参数和属性不改变.
       >
       > 可以使用 `<jsp:param name="" value="" />` 添加参数
       >
       > 跳转后, URL 不变

     + 类 `request.getRequestDispatcher(“jsp | html | servlet”).forward(request.response)` 方法

  3. jsp:param 参数传递

     + 配合 jsp:include | jsp:forward 使用
     + 结构: `<jsp:param name="参数名" value="参数值" />`

### 表单元素的获得 <a id="form"></a>

+ 单一表单元素 (非数组)

  > 送往服务器端时,仅为一个变量
  >
  > 包含:文本框 密码框 多行文本框 单选按钮 下拉菜单等

  + 获取方法:

    `request.getParameter("表单元素名name")`

    > 返回值: String

+ 捆绑表单元素 (数组)

  > 多个同名表单元素的值送往服务器时,是一个捆绑数组
  >
  > 包含:复选框 多选列表框 其他同名表单元素

  + 获取方法:

    `request.getParameterValues("表单元素名name")`

    > 返回值: String[]

### JSP 内置对象

> 九大: out request response session application exception page pageContext config
>
> JSP 页面中直接通过以上列出的名称使用 (JSP 表达式中, EL 表达式中略有不同)

+ out

  > 对应的 Java 类(接口): `javax.servlet.jsp.JspWriter`

  + 向客户端输出各类数据类型的内容

  + 对应用服务器上的输出缓冲区管理(缓冲区默认8KB)

  + 常用方法:

    > 输出
    >
    > 注: 服务端要输出到客户端的内容不是直接写到客户端,而是先写到一个输出缓存区中
    >
    > 将缓存区中的内容输出给客户端的条件:
    >
    > 1. JSP 页面已完成信息的输出
    > 2. 输出缓存区已满
    > 3. 在 JSP 调用 out.flush() | response.flushBuffer() 方法

    + void print()
    + void println()

    > 管理

    + int getBufferSize() // 获取缓存区大小

    + int getRemaining() // 获取缓存区没被占用的空间大小

    + void close() // 关闭输出流(强行终止当前页面的剩余部分向浏览器的输出, 即此命令以下的内容全部作废, 不会输出)

      > 一般时数据输出完毕时使用

    + void clearBuffer() // 清除当前缓存区的数据(**将数据写入到下一个输出语句, 并将在下一行开始输出**)(内容已经响应到了客户端也可使用)

    + void flush() // 输出缓存区的数据

    + void clear() // 清空缓存区数据(重置响应流: 响应流中的内容全部作废, 重新设置)[**若响应已经提交, 将出现 IOException 异常**]

+ request

  > 对应 Java 类(接口): `javax.servlet.http.HttpServletRequest`

  + 客户端请求的参数和流

    > 客户端的数据来源:
    >
    > 1. 表单
    > 2. 请求体参数

  + request 对象封装了客户端的请求信息(客户请求信息 & 客户端的信息)

    > 因此 request 封装的信息包括
    >
    > 1. 请求头信息 (包括了 客户请求信息 & 客户端信息)
    > 2. 请求体信息

  + 常用方法:

    + String getMethod() // 获取请求方法 Get Post Put Delete ...
    + String getRequestURI // 获取请求 URI 
    + StringBuffer getRequestURL // 获取请求 URL (StringBuffer 的形式)
    + String getProtocol() // 获得协议名
    + String getServletPath() // 获得客户端请求的服务器资源路径
    + String getQueryString() // 获取 URL 中的查询部分 (Post 请求无输出)
    + String getServerName() // 获取服务器名称
    + int getServerPort() // 获取服务器部署的端口号
    + String getRemoteAddr() // 获取客户端 ip 
    + String getParameter() // 获取请求的参数, 见<a href="#form">表单元素的获得</a>
    + String[] getParameterValues() // 获取请求的参数数组, 见<a href="#form">表单元素的获得</a>

+ response

  > 对应 Java 类(接口): `javax.servlet.http.HttpServletResponse`
  >
  > Cookie 小文本数据, 服务端生成, 客户端浏览器设置了接收 Cookie 将保存在本地文件中.
  >
  > + 下次使用本都存储了 Cookie 的网站, 将自动读取本地存储的 Cookie 并将数据发送到服务器端中
  > + Cookie 内数据形式: Key-Value 键值对的形式

  + 对客户端的响应

  + 向客户端发送数据

  + 常用方法: 

    + void addHeader(String key, String value) // 添加响应头信息

    + String encodeURL(String URL) // 以 response 内部设置的编码方式对 URL 进行编码, 返回 包括 SessionID 在内的 URL(?)

    + 重定向: response.sendRedirect( JSP | HTML | Servlet ) // 向客户端返回重定向响应, 让客户端再一次向重定向的地址发送一次请求

      > 和 request.getRequestDispatcher("URL").forward(request.response) 区分
      >
      > 1. 浏览器地址:
      >        forward 属于服务器去请求去直接访问,因此客户端地址不变
      >        redirect 是使浏览器去请求, 客户端浏览器地址会发生改变
      > 2. 共享数据:
      >        forward 转发的页面以及转发到的页面共享同一个 request 内的数据
      >        redirect 不能共享 request 内的数据
      > 3. 功能:
      >        forward 只能在同一个服务器内转发请求
      >        redirect 可以定向其他站点
      > 4. 效率:
      >        forward 只是服务器内跳转, 效率高
      >        redirect 相对较低
      >
      > 附: 使用率低的重定向: sendError();
      >
      > 向客户端发送 HTTP 状态码出错信息, 例:
      >
      > 400 请求出现语法错误
      >
      > 401 请求用户的权限不够
      >
      > 403 资源不可用
      >
      > 404 未定位到资源
      >
      > 500 服务内部代码逻辑错误

+ session

  > 通过 request 的 getSession() 方法获得
  >
  > 对应 Java 类(接口): `javax.servlet.http.HttpSession`

  + 会话: 用户请求使用即新建一个会话, **长时间不请求服务器会话将自动销毁**.在会话中, 可以操作在服务器中在自己权限内的资源.

  + 常用方法: 

    + void setAttribute(String name, Object obj); // 设置一个属性

      > 两次放入的 name 相等, 则后入覆盖前入

    + Object getAttribute(String name); // 获得 Session 内的指定属性

    + void removeAttribute(String name); // 移除指定属性

    + void invalidate(); // 移除全部属性

    + String getId(); // 获得 Session ID 

      > 同一个用户在服务器中使用资源的 Session 都是同一个
      >
      > 使用 SessionId 标识.

+ applicaiton

  > 对应 Java 类(接口): `javax.servlet.ServletContext`

  + 保存应用程序的公用数据

  + 服务器启动时即创建 Application , 服务器关闭才会销毁 Application.

    > application 的生命周期: 整个 Web 应用运行时间, 或 服务器的开启到关闭

  + 所有用户共享一个 Application

    > 所有用户的不同时间的链接都可以对 application 中的同一个或不同属性进行操作.
    >
    > 任何地方的操作都会影响其他用户的访问.

  + 常用方法:

    + void setAttribute(String name, Object obj); // 设置一个属性
    + Object getAttribute(String name); // 获得一个指定属性
    + Enumeration\<String\> getAttributeByNames(); // 获得 application 中的所有参数名
    + int getMajorVersion(); // 获得服务器支持的 Servlet 的主版本
    + int getMinorVersion(); // 获得服务器支持的 Servlet 的从版本
    + void removeAttribute(String name); // 移除一个指定属性

+ exception

  > 对应 Java 类(接口): `java.lanb.Exception`

  + 获得**没有被发现**或**不可避免**的异常信息

+ page

  > java.lang.Object 类的实例

  + 指向当前 JSP 页面本身的实例,使用其可调用 servlet 类中定义的方法,但只有在本页面内合法

    > 类似于 Java 类中的 this

  + JSP 中不常用

+ **pageContext**

  + 提供对 JSP页面 **所有对象**及**命名空间**的访问

    > 可以对**除自身以外的其他 8 个 JSP 对象** 以及 **绑定在 8 个 JSP 对象上的 Java 对象**进行访问

  + 访问JSP页面上的**所有对象及其属性**

  + example: ${pageContext.request.contextPath} 访问当前 Web 应用的 Classpath 目录

  + 常用方法:

    + void forward(String relativeUrlPath); // request 的 forward
    + void include(java.lang.String s); // request 的 include
    + JspWriter getOut(); // 获得 out 对象
    + Exception getException(); // 获得 exception 对象
    + ServletRequest getResquesr(); // 获得 requset 对象
    + ServletResponse getResponse(); // 获得 response 对象
    + Object getPage(); // 获得 page 对象
    + HttpSession getSession(); // 获得 session 对象
    + ServletConfig getServletConfig(); // 获得 config 对象
    + ServletContext getServletContext(); // 获得 ServletContext / Application 对象
    + Object getAttribute(String name); // 获得指定属性
    + Object getAttribute(String name, int Scope); // 获得指定范围内的属性
    + void setAttribute(Stirng name, Object attribute); // 设置属性
    + void setAttribute(String name, Object obj, int scope); // 在指定范围内设置属性
    + void removeAttribute(String name); // 移除属性
    + void removeAttribute(String name, int scope);  // 移除指定范围内的属性
    + void invalidate(); // 返回servletContext对象, 其余全部销毁

    > Scope 范围:
    >
    > 1. page
    > 2. request
    > 3. session
    > 4. application

+ config

  > 对应 Java 类(接口): `javax.servlet.ServletConfig`

  + JSP 页面初始化时所需要的参数以及服务器相关信息, 属性存在形式: Key - Value 键值对

    >  通过传递 ServletContext 对象实现

  + 使用少

  + 常用方法:

    > 可以通过其他对象实现

    + ServletContext getServletContext();

      > 可以通过 request 对象获得

    + String getServletName();

      > 可以通过 request 对象获得

    + String getInitParameter(String name);

      > 可以通过 application 对象获得

    + Enumeration\<String\> getInitParameterNames(); 

      > 可以通过 application 对象获得

### JSP 页面框架

```jsp
<%@ page import="" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="URIToTagLibrary" prefix="tagePrefix" %>
<%! JSP 声明 %>
<!--HTML 页面框架-->
<!--期间穿插 Java代码段, EL表达式, JSP表达式 ...-->
```

## Exception 处理

+ 后端**捕获所有 exception** 交由 **service**, **service** 交由 **controller** 返回给**前端控制器**, 而**前端控制器**应抛出给**全局的异常处理器**统一处理

+ 全局异常处理器:
  + 自定义异常: 直接取出反馈在错误页面上
  + 非自定义异常: 构建一个自定义的异常, 返回消息为 "未知错误", 在反馈显示页面
+ Exception 处理
  1. 捕获所有异常
  2. 自定义异常类, 用于反馈系统异常
  3. 反馈异常页面

## JDBC 简单使用

+ JDBC 功能

  1. 建立与数据库或其他数据源的链接
  2. 向数据库发送SQL语句
  3. 处理数据库返回结果

+ JDBC 驱动程序类型:

  1. JDBC-ODBC桥驱动程序
  2. 部分本地API部分Java的驱动程序
  3. JDBC网络纯Java驱动程序
  4. 本地协议的纯Java驱动程序

+ JDBC 对象

  + java.sql.Connection: 数据库链接对象
  + java.sql.Statement: SQL 语句执行对象
  + java.sql.ResultSet: SQL 语句结果存放对象

+ 基本操作

  1. 根据驱动获得连接对象

     > 常用驱动: 
     >
     > + MySQL:
     >   + com.mysql.jdbc.Driver (jdbc:mysql://IP:port/DataBaseName [default port:3306])
     >   + 

  2. 获得语句执行对象

  3. 执行语句

  4. 获得语句执行结果对象

  5. 关闭链接

  ```java
  Class.forName("指定驱动名"); // 注册驱动
  Connection con = DriveManager.getConnection("协议URL", "用户名", "密码");
  Statement stm = con.createStatement(); // 获取Statement接口实例
  stm.executeQuery("SQL查询语句");   // SQL查询
  stm.executeUpdate("SQL增删改语句");// SQL增加 删除 修改语句
  // con.commit(); catch (SQLException se) con.rollback();
  // 对数据库的操作完成需要提交更改(con.commit())
  // 不提交修改(con.rollback())
  // 对获取数据进行处理(略)
  
  // 关闭数据库
  stm.close();
  con.close();
  ```

+ SQL 语句执行对象

  > String sql = "对应操作的 SQL 语句";
  >
  > int i = stm.executeUpdate(sql); // 插入 删除 修改

  + 插入:

    + i 语句执行后插入的行数

  + 删除:

    + i 语句执行后删除的行数

  + 修改:

    + i 语句执行后修改的行数

  + 查询:

    ```java
    String sql_find;
    ResultSet rs = stm.executeQuery(sql_find);
    // 查找返回的数据需要存放在 RequestSet 对象中,然后从rs对象中取出数据进行处理
    // RequestSet 中存在小指针(游标)初始指向第一行的前一行,rs.next()可以使游标下移一行(返回boolean值)
    
    while(rs.next()) { // rs.next() 直接换下一行 (将rs认为是表,rs中的数据和数据库中的数据存在形式一致
        xxx var = rs.getXXX("列名"); // xxx为对应XXX的数据类型, XXX为列名对应的数据类型
        /*
        	rs 的 wasNull() 方法, 判断最后一个 getter 方法的值是否为 SQL NULL, 为空返回 true, 不为空返回 false
        	XXX: 
        	String getString(int column);  
        	boolean getBoolean(int column);
        	byte getByte(int column);
        	short getShort(int column);
        	int getInt(int column);
        	long getLong(int column);
        	float getFloat(int column);
        	double getDouble(int column);
        	BigDecimal getBigDecimal(int column, int scale);
        	byte[] getBytes(int columnIndex);
        	java.sql.Date getDate(int columnIndex);
        	java.sql.Time getTime(int columnIndex);
        	java.sql.Timestamp getTimestamp(int columnIndex);
        	!!: int column(第几列的数据, 列的顺序) 可重写为 String column(哪列的数据, 列名)
         */
        // 抛出的异常类型都为 SQLException
    }
    ```

  + **注**:  批量操作的方法之一

    ```java
    Statement stmt = con.createStatement();
    PreparedStatement pstmt = con.prepareStatement("INSERT INTO MyPlayers values (?, ?, ?, ?, ?, ? )");
    pstmt.setInt(1, 8);
    pstmt.setString(2, "Ryan");
    pstmt.setString(3, "McLaren");
    pstmt.setDate(4, new Date(413596800000L));
    pstmt.setString(5, "Kumberly");
    pstmt.setNull(6, java.sql.Types.VARCHAR);
    pstmt.executeUpdate();
    ```

+ JDBC 事务

  + JDBC 默认使用

    > 即 必须使用 con.commit() 方法才将操作应用到数据库中

  + 事务由一条或多条SQL语句组成,一旦其中一条语句失败,整个事务都将失败.

  + 主要控制语句:

    + con.commit();    // 更改是否作用于数据库
    + con.rollback();   // commit失败即回滚(放弃更改,返回上一次正确状态)

  + 由于事务语句中只要出现一次异常就将导致整个事务的失败, 因此可以使用 try-catch 代码块控制

    ```java
    try {
        Connection con = DriveManager.getConnection("URL", "userName", "password");
        Statement stm = con.createStatement();
        String sql_crud = "SQL Statement";
        int i = stm.executeUpdate(sql_crud);
        con.commit();
    } catch (SQLException se) {
        con.rollback();
    }
    ```

  + 保存点

    + 设置保存点,方便回滚.遇到错误,返回保存点,仅保存保存点之前的操作.

      ```java
      Savepoint sp1 = con.setSavepoint("name");   // 创建保存点
      con.rollback(sp1);                          // 回滚到保存点
      releaseSavepoint(sp1);                      // 删除保存点(对象通常为setSavepoint()生成的保存点)
      ```

## AJAX

> 异步 JavaScript & XML

+ 创建快速动态网页(通过在后台与服务器进行少量数据交换,使网页实验异步更新)

  > 不重新加载网页的情况下,对网页的某部分进行更新

+ Ajax开发模式采用异步概念. 客户端和服务器端不必再相互等待,而是并发进行.

+ 特点:

  + 页面只需要部分刷新
  + 页面不会重新加载, 只做必要的数据更新

+ Ajax 由五种技术组成:

  1. **异步数据获取技术 XMLHttpRequest (核心)**

     + 用于幕后服务器交换数据

       > 更新网页的部分, 不必要更新整个网页

     ```javascript
     variable = new XMLHttpRequest();
     variable = new ActiveXObject("Microsoft.XMLHTTP");
     ```

     > 老版本的IE5 IE6 使用 ActiveX对象

     + 属性

       1. onreadyStatechange // readyState属性变化时调用的函数

       2. readyState // 保存XMLHttpRequest状态

          > 0 请求未初始化
          > 1 服务器连接已建立
          > 2 请求已收到
          > 3 正在处理请求
          > 4 请求已完成且响应已就绪

       3. responseText // 以字符串的形式返回的响应数据

       4. responseXML // 以XML的形式返回的响应数据

       5. status // 返回请求状态号

          > 200 "OK"
          > 403 "Forbidden"
          > 404 "Not Found"

       6. statusText // 返回状态文本 (例: "OK" "Not Found")

     + 常用方法

       + new XMLHttpRequest() // 创建一个新的XMLHttpRequest对象

       + abort() // 取消当前响应

       + getAllResponseHeaders() // 获得HTTP响应头部作为未解析的字符串

       + getResponseHeader() // 获得指定HTTP响应头部的值

       + **open(method, url, async) // 初始化HTTP请求参数**

         > method : GET POST HEAD
         >
         > url : 服务器内部资源路径
         >
         > async : true 异步请求; false 同步请求

       + **send() // 将GET请求发送到服务器**

       + **send(String) // 将POST请求发送到服务器**

       + setRequestHeader() // 向请求头中添加参数

     + 发送请求

       ```javascript
       // GET 请求
       xmlHttp.open("GET", "getBook.jsp?id=" + categoryID, true);
       xmlHttp.send();
       // 显式请求参数 ?id= 或者时 /{id}
       
       // POST 请求
       xhttp.open("POST", "getBook.jsp", true);
       xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
       // application/x-www-form-urlencoded 表单字符类型
       // multiline/form-data 表单类型
       // application/json json数据类型
       // text/xml xml数据类型
       xhttp.send("请求参数字符串");
       // e.g. xhttp.send("stuName=" + stuName.value + "&score=" + score.value);
       // 没有添加HTTP头部, 将无法获得send()的内容
       ```

       > GET 方式 快并简单于 POST 方式 (适用于大多数情况)
       >
       > 但, 以下场景必须使用 POST 方式:
       >
       > 1. 上传数据
       > 2. 发送大量数据
       > 3. 发送用户的输入(可能有非英文字符, POST 请求可以设置请求头的字符编码)

  2. 基于标准的表示技术 XHTML 和 CSS

  3. 动态显示和交互技术 Document Object Model (文档对象模型)

  4. 数据互换和操作技术 XML 和 XSLT

  5. JavaScript 融合以上4种技术

+ Ajax 开发

  1. 创建 XMLHttpRequest 对象

     > 建议放在一个 js 文件中, 在 body 标签内使用 onload 属性.
     >
     > 即**此页面被加载时**就创建 XMLHttpRequest 对象

     ```javascript
     if (window.XMLHttpRequest) {
         xmlhttp = new XMLHttpRequest();
         // IE7+ Firefox Chrome Opera Safari 等浏览器
     }
     else {
         xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")
         // IE6 IE5 浏览器
     }
     ```

  2. 定义响应事件处理函数

     > 即 获得响应后, 该如何处理响应的数据

     ```javascript
     // onreadystatechange 事件为响应处理事件, 可把所有处理代码放入该事件对应函数中
     xmlhttp.onreadystatechange=function() {
         if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
             document.getElementById("myDiv").innerHTML = xmlhttp.responseText;
         }
     }
     ```

  3. 发送 HTTP 请求

     ```javascript
     xmlhttp.open("GET", "servlet/PhotoServlet?index=" + index, true);
     xmlhttp.send(null);
     ```

     
