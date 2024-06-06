/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.lecturer;

import dal.LecturerDAO;
import dal.ObjectiveDAO;
import java.io.IOException;
import model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ObjectiveManagement", urlPatterns = {"/lecturer/objective"})
public class ObjectiveManagement extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        ObjectiveDAO ob = new ObjectiveDAO();

        if (a != null && a.getRoleAccount().getRole_id() == 3) {

            int cid = Integer.parseInt(request.getParameter("cid"));
            List<Objective> o = ob.getAllObjectiveByClass(cid);
            System.out.println(o);
            request.setAttribute("o", o);

            request.getRequestDispatcher("objective_manage.jsp").forward(request, response);
        } else {
            response.sendRedirect("../login");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
