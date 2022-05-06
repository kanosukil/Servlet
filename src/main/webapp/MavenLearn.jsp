<%--
  Created by IntelliJ IDEA.
  User: VHBin
  Date: 2021/11/23
  Time: 22:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Maven</title>
    <meta charset="UTF-8">
</head>
<body>
    <h1>Maven</h1>
    <pre>
        本质:项目管理工具
            将项目开发和管理过程抽象为POM(项目对象模型)
        pom.xml文件配置Maven的配置信息(一个项目一个pom.xml)

        依赖管理(Dependency)控制项目使用的资源(保存在本地仓库)(私服仓库:保存公共资源;来源:中央仓库)
        构建生命周期/阶段(对应若干个插件)(插件:产生构建结果;插件Maven已经定义好了,只要调用即可)

        作用:
            项目构建(提供标准 跨平台的自动化构建方式)
            依赖管理(管理jar包,并避免版本冲突)
            统一开发结构
    </pre>
    <h2>仓库</h2>
    <pre>
        远程仓库:
            中央仓库:
                云端,且Maven团队管理,开源资料
            私服仓库:
                本地到中央的缓冲区,提高下载到本地的速度;保存具有版权的资源
        本地仓库:
            中央仓库的子集,本地项目的jar包(资源)保存点
    </pre>
    <h2>坐标</h2>
    <pre>
        描述仓库中资源的位置
        组成:
            groupId:    隶属组织(公司 企业)[通常域名反写]
            artifactId  当前项目名[通常模块名]
            version     版本号
                packaging   打包方式 // 非Maven坐标

        使用唯一标识,唯一定位资源位置,机器自动识别

        配置本地仓库:
            打开Maven/conf文件夹 打开settings.xml文件,
            其中 settings 元素下加入
                &lt;repository&gt;Path&lt;/repository&gt;
            (默认在 C:\user\.m2\repository下)

        镜像远程仓库配置:
            Maven/conf/settings.xml
            mirrors 元素体内配置:
                阿里云:
            &lt;mirror&gt;
                &lt;id&gt;nexus-aliyun&lt;/id&gt;
                &lt;mirrorOf&gt;central&lt;/mirrorOf&gt;
                &lt;name&gt;Nexus aliyun&lt;/name&gt;
                &lt;url&gt;http://maven.aliyun.com/nexus/content/groups/public&lt;/url&gt;
            &lt;/mirror&gt;
    </pre>
    <h2>Maven项目文件结构</h2>
    <pre>
        project---src---main---java(放置java源文件)
                |     |      |_recourses(配置文件)
                |     |_test---java
                |            |_recourses
                |_pom.xml
    </pre>
    <h2>Maven项目构建命令</h2>
    <pre>
        mvn compile     编译
        mvn clean       清理
        mvn test        测试
        mvn package     打包(只打包源程序)
        mvn install     安装到本地仓库
    </pre>
    <h3>Idea创建Maven</h3>
    <pre>
        Project Structure -> Module 加新(可选依赖模板)
            [生成后若和Maven项目结构不一致需要手动创建,并在Project Structure内设好目录结构(也可在Module内创建)]
    </pre>
</body>
</html>
