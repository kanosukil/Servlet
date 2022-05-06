package com.example.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author VHBin
 * @date 2021/10/27 - 10:45
 */

@WebServlet(name = "PhoneJudge", value = "/phone-judge")
public class Judge extends HttpServlet {

    @Override
    public void init(){
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        String name = request.getParameter("user name");
        String phone = request.getParameter("phone number");
        out.println("<html><body>");

        out.println("<p>" + phone + "<br/>");
        out.println(phoneNumber(phone) ?
                ("欢迎用户" + name + "!") :
                ("未输入正确的电话形式!(格式为123-1234-1234)<br/>\n" +
                        "<form action = \"SeletctTwo_Servlet.html\" method = \"post\">" +
                        "<input type = \"submit\" value = \"返回\">" +
                        "</form>"));
        out.println("</p>");
        out.println("</body></html>");

    }

    private boolean phoneNumber(String number) {
        return number.trim().matches("[\\d]{3}-?[\\d]{4}-?[\\d]{4}");
    }

    @Override
    public void destroy() {
    }
}
