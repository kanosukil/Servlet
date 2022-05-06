package com.example.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.InputMismatchException;

/**
 * @author VHBin
 * @date 2021/11/03 - 09:33
 */

public class Gather_Information extends HttpServlet {
    private Interest interest = new Interest();

    @Override
    public void init() {
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HashMap<Integer, String> li = new HashMap<>();
        li.put(0, "游戏");
        li.put(1, "购物");
        li.put(2, "学习");
        li.put(3, "运动");
        li.put(4, "其他");

        String a = request.getParameter("single");
        String[] b = request.getParameterValues("multiple");
        String c = request.getParameter("drop-down box");

        interest.input(a);
        interest.input(c);
        for (String e : b) {
            interest.input(e);
        }
        Integer[] list = interest.get();

        PrintWriter out = response.getWriter();
        out.println("<html><body>");

        out.println("<form>");
        for (int i = 0; i < list.length; i ++) {
            out.println("有" + list[i] + "人喜欢" + li.get(i) + "<hr/>");
        }
        out.println("<form/>");

        out.println("<body/><html/>");

    }

    @Override
    public void destroy(){
    }
}

class Interest {

    private final Integer GAME = 1;
    private final Integer SHOP = 2;
    private final Integer LEARN = 3;
    private final Integer SPORT = 4;
    private final Integer OTHER = 5;

    private static HashMap<Integer, Integer> inter_list = new HashMap<>();

    public Interest() {
        inter_list.put(GAME, 0);
        inter_list.put(SHOP, 0);
        inter_list.put(LEARN, 0);
        inter_list.put(SPORT, 0);
        inter_list.put(OTHER, 0);
    }

    public void input(String str) throws InputMismatchException {
        if ("GAME".equalsIgnoreCase(str.trim())) {
            inter_list.put(GAME,inter_list.get(GAME) + 1);
        } else if ("SHOP".equalsIgnoreCase(str.trim())) {
            inter_list.put(SHOP, inter_list.get(SHOP) + 1);
        } else if ("LEARN".equalsIgnoreCase(str.trim())) {
            inter_list.put(LEARN, inter_list.get(LEARN) + 1);
        } else if ("SPORT".equalsIgnoreCase(str.trim())) {
            inter_list.put(SPORT, inter_list.get(SPORT) + 1);
        } else if ("OTHER".equalsIgnoreCase(str.trim())) {
            inter_list.put(OTHER, inter_list.get(OTHER) + 1);
        } else {
            throw new InputMismatchException();
        }
    }

    public Integer[] get() {
        return new Integer[]{inter_list.get(GAME), inter_list.get(SHOP),
                inter_list.get(LEARN), inter_list.get(SPORT), inter_list.get(OTHER)};
    }

}