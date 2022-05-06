<%--
  Created by IntelliJ IDEA.
  User: VHBin
  Date: 2021/11/20
  Time: 18:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="UTF-8" %>
<html>
<head>
    <title>DAO VO</title>
    <meta charset="UTF-8">
</head>
<body>
    <h1>DAO</h1>
    <pre>
        对数据库进行操作的类.
        DAO模式 整体设计流程:
                JSP -> 工场模式 -> 具体实现类 -> 完成数据库操作
        DAO设计模式 组成部分:
            DAO 接口:     DAO接口定义了所有用户操作(增删改查...)
            DAO 实现类:   DAO实现类实现DAO接口(在DAO实现类中通过 数据库连接类 操作数据库)
            DAO 工厂类:   通过自身的静态方法获得实例
                (数据库连接类: JDBC 通过连接数据库获得连接对象和关闭数据库)
    </pre>
    <hr>
    <h1>VO</h1>
    <pre>
        Value Object 值对象:
            前段数据和控件的绑定
        封装了某个对象属性的类.
        (VO 继承自某类,并对其做了一定的延申)
        提供getter/setter读取该类的属性
    </pre>
    <h2>VO类实例</h2>
    <pre>
        public class User {
            private String userId;
            private String name;
            private Integer status;
            private String headPicFileName;// 头像地址
            private String telephone;
            private Integer userLevel;
            private Doctor doctor;
            get/setXxx()....   }

        创建一个新类UserVO extends User,只在UserVO中添加更多 属性,而且以VO结尾表示用于返回前端的数据.

        List&lt;User&gt; users = userServiceImpl.findUsersByIds(userIds);
        //将User列表转换为UserVO列表:
        List&lt;CircleUserVO&gt; circleUserVOs = BeanUtil.copyList(users,CircleUserVO.class);
        //给UserVO添加角色属性
        wrapRole(circleUserVOs,circleId);
        wrapRole(List&lt;CircleUserVO&gt; circleUserVOs,Long circleId) {
            //所有角色权限
            List&lt;CircleUserVO&gt; circleUserVOList
                = circleMemberRoleMapper.selectAllMemberRoleByCircleId(circleId);
            for (CircleUserVO circleUserVO : circleUserVOList) {
                for (CircleUserVO circleUserVO1 : circleUserVOs) {
                    if (circleUserVO.getUserId().equals(circleUserVO1.getUserId())) {
                        circleUserVO1.setRole(circleUserVO.getRole());
                    }
                }
            }
        }

        原类:user
        其所有实例都添加属性,将有实例存入相对应的List中: users
        创建对应VO类的列表,并将所有实例存入: circleUsersVOs
        wrapRole函数:添加属性
        两个for:对应ID的相绑定

    </pre>
</body>
</html>
