/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Student;
import model.UserClass;

/**
 *
 * @author ADMIN
 */
public class UserClassDAO extends DBContext {

    public void addStudentToClass(int studentId, int classId) {
        String query = "INSERT INTO userClass (student_id, class_id) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, studentId);
            ps.setInt(2, classId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isStudentInClass(int studentId) {
        String query = "SELECT COUNT(*) FROM UserClass WHERE student_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<UserClass> getAllUserClasses(int classId) {
        List<UserClass> userClasses = new ArrayList<>();
        StudentDAO sdao = new StudentDAO();
        ClasssDAO cdao = new ClasssDAO();
        String query = "SELECT * FROM UserClass WHERE class_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, classId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserClass userClass = new UserClass();
                    userClass.setId(rs.getInt("userClass_id"));
                    Student s = sdao.getById(rs.getInt("student_id"));
                    model.Class c = cdao.getById(rs.getInt("class_id"));
                    userClass.setClasses(c);
                    userClass.setStudent(s);
                    userClasses.add(userClass);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userClasses;
    }

    public List<String> getEmailsByClassId(int classId) {
        List<String> emails = new ArrayList<>();
        String query = """
                       SELECT a.email FROM Student s JOIN UserClass uc ON s.student_id = uc.student_id 
                       JOIN Account a on a.id = s.account_id
                       WHERE uc.class_id  = ? """;
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, classId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    emails.add(rs.getString("email"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return emails;
    }

    public static void main(String[] args) {
        UserClassDAO s = new UserClassDAO();
        List<String> l = s.getEmailsByClassId(2);
        System.out.println(l.size());
    }
}
