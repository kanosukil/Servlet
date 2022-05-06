package com.example.servlet;

/**
 * @author VHBin
 * @date 2021/11/16 - 18:41
 */
public class Student {
    private String name = null;
    private int age = 0;
    private int grade = 0;

    public void setName(String name) {
        this.name = name;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public int getGrade() {
        return grade;
    }
}
