/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.lecturer.attendance;

import com.google.gson.Gson;
import dal.Dao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ViewAttendance", urlPatterns = {"/lecturer/viewAttendance"})
public class ViewAttendance extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("classId");
        String who = request.getParameter("who");
        String date = request.getParameter("date");
        if ("lec".equals(who)) {
            Dao d = new Dao();
            String jsonString = new Gson().toJson(d.getAttendentForLecturer(date, id));
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(jsonString);
        } else {

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
