package com.example.servlet;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "SelectOne", value = "/Servlet-doGet")
public class SelectOne_doGetApplication extends HttpServlet {
    private String message;

    @Override
    public void init() {
        message = "User Information";
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        PrintWriter out = response.getWriter();
        out.println("<html><body>");

        out.println("<h1>" + message + "</h1>");
        out.println("<p>" +
                "User Name: xxx" +
                "<br/>" +
                "Email: xxxxxxx@xxx.xx" +
                "<br/>" +
                "Address: xxx xx xxx" +
                "<br/>" +
                "CV: bala bala" +
                "<p/>");

        out.println("</body></html>");
    }

    @Override
    public void destroy() {
    }
}