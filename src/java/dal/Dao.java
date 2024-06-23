/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.Account;
import model.Attendance;
import model.Role;
import model.Student;
import model.UserClass;

/**
 *
 * @author ADMIN
 */
public class Dao extends DBContext {

    public Account getAccountByEmail(String email) {
        String sql = """
                     select id,username,password,roleId from Account where email = ?
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            RoleDAO r = new RoleDAO();
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                Role role = r.getById(rs.getInt("roleId"));
                a.setRoleAccount(role);
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Account getAccountByID(int id) {
        String sql = """
                     select * from Account where id = ?""";
        try {
            RoleDAO r = new RoleDAO();
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setEmail(rs.getString("email"));
                a.setAddress(rs.getString("address"));
                a.setPhone(rs.getString("phone"));
                a.setStatus(rs.getString("status"));
                Role role = r.getById(rs.getInt("roleId"));
                a.setRoleAccount(role);
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Account getByUsernameAndPass(String username, String password) {
        String sql = """
                     select * 
                     from Account a, Student s 
                     where [username] = ? and [password] = ?""";
        RoleDAO r = new RoleDAO();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account();
                a.setId(rs.getInt("id"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setEmail(rs.getString("email"));
                a.setAddress(rs.getString("address"));
                a.setPhone(rs.getString("phone"));
                a.setStatus(rs.getString("status"));
                Role role = r.getById(rs.getInt("roleId"));
                a.setRoleAccount(role);
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean checkAccount(String userName, String password) {
        String sql = "select * from Account where [username] = ? and [password] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, userName);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public void setNewPassword(String userName, String password) {
        String sql = """
                     UPDATE [dbo].[Account]
                        SET [password] = ?
                      WHERE [username] = ?""";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, password);
            st.setString(2, userName);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    /**
     * ****************************************************************
     * @param password
     * @return 
     */
    
    public ArrayList<model.Class> getAllClassesByLecturer(int lecturerID) {
        ArrayList<model.Class> list = new ArrayList<>();
        String sql = "select * from Class where lecturer_id = ? and status like 'ACTIVE'";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, lecturerID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                model.Class c = new model.Class();
                int classId = rs.getInt("class_id");
                c.setClass_id(classId);
                c.setClass_name(rs.getString("class_name"));
                c.setStatus(rs.getString("status"));
                c.setCheckDate(checkAttendanceDate(classId));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    private String checkAttendanceDate(int idClass) {
        String sql = """
                     select *
                     from userClass uc, Attendance a
                     where  uc.userClass_id = a.userClass_id and uc.class_id = ? and date = ? """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, idClass);
            st.setDate(2, Date.valueOf(getDateNow()));
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return "1";
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return "0";
    }  
    
    public boolean addAttendance(String[] array, String classId) {
        if ("1".equals(checkAttendanceDate(Integer.parseInt(classId)))) {
            return false;
        }
        List<String> list = Arrays.asList(array);
        ArrayList<UserClass> students = new ArrayList<>();
        String sql = """
                     select * from Student s, userClass us
                     where s.student_id = us.student_id and us.class_id = ? """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, Integer.parseInt(classId));
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                UserClass uc = new UserClass();
                uc.setId(rs.getInt("userClass_id"));
                Student s = new Student();
                s.setRollNumber(rs.getString("rollNumber"));
                uc.setStudent(s);
                students.add(uc);
            }
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
        String sql1 = "";
        String date = getDateNow();
        for (int i = 0; i < students.size(); i++) {
            if (list.contains(students.get(i).getStudent().getRollNumber())) {
                sql1 = "INSERT INTO [dbo].[Attendance] ([userClass_id] ,[date], [status]) VALUES (?,?,'present')";
            } else {
                sql1 = "INSERT INTO [dbo].[Attendance] ([userClass_id] ,[date], [status]) VALUES (?,?,'absent')";
            }
            try {
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, students.get(i).getId());
                st1.setDate(2, Date.valueOf(date));
                st1.executeUpdate();
            } catch (SQLException e) {
                System.out.println(e);
                return false;
            }
        }
        return true;
    }
    
    public boolean updateAttendance(String[] array, String classId) {
        List<String> list = Arrays.asList(array);
        ArrayList<Student> students = new ArrayList<>();
        String sql = """
                     select * from Student s, userClass us, Attendance a
                     where s.student_id = us.student_id and us.class_id = ? and us.userClass_id = a.userClass_id and date = ? """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, Integer.parseInt(classId));
            st.setDate(2, Date.valueOf(getDateNow()));
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Student s = new Student();
                s.setRollNumber(rs.getString("rollNumber"));
                Attendance a = new Attendance();
                a.setAttendanceId(rs.getString("attendance_id"));
                s.setAttendance(a);
                students.add(s);
            }
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
        String sql1 = "";
        for (int i = 0; i < students.size(); i++) {
            if (list.contains(students.get(i).getRollNumber())) {
                sql1 = "UPDATE [dbo].[Attendance] SET [status] = 'present' WHERE attendance_id = ?";
            } else {
                sql1 = "UPDATE [dbo].[Attendance] SET [status] = 'absent' WHERE attendance_id = ?";
            }
            try {
                PreparedStatement st1 = connection.prepareStatement(sql1);
                st1.setInt(1, Integer.parseInt(students.get(i).getAttendance().getAttendanceId()));
                st1.executeUpdate();
            } catch (SQLException e) {
                System.out.println(e);
                return false;
            }
        }
        return true;
    }
    
    public ArrayList<Student> getStudentInClass(int lectureId, String classId, String today) {
        ArrayList<Student> list = new ArrayList<>();
        String sql;
        if ("0".equals(today)) {
            sql = """
                  select *
                  from Class c, userClass uc, Student s
                  where c.lecturer_id = ? and c.class_id = ? and c.class_id = uc.class_id and uc.student_id = s.student_id""";
            try {
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, lectureId);
                st.setString(2, classId);
                ResultSet rs = st.executeQuery();
                while (rs.next()) {
                    Student s = new Student();
                    s.setRollNumber(rs.getString("rollNumber"));
                    s.setFullName(rs.getString("fullName"));
                    list.add(s);
                }
            } catch (SQLException e) {
                System.out.println(e);
            }
        } else {
            sql = """
                  select *, a.status as stu
                  from Class c, userClass uc, Student s, Attendance a
                  where c.lecturer_id = ? and c.class_id = ? and c.class_id = uc.class_id and uc.student_id = s.student_id and uc.userClass_id = a.userClass_id and date like ? """;
            try {
                PreparedStatement st = connection.prepareStatement(sql);
                st.setInt(1, lectureId);
                st.setString(2, classId);
                st.setDate(3, Date.valueOf(getDateNow()));
                ResultSet rs = st.executeQuery();
                while (rs.next()) {
                    Student s = new Student();
                    s.setRollNumber(rs.getString("rollNumber"));
                    s.setFullName(rs.getString("fullName"));
                    s.setStatus(rs.getString("stu"));
                    list.add(s);
                }
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
        return list;
    }
    
    public ArrayList<Student> getAttendentForLecturer(String date, String classId) {
        ArrayList<Student> list = new ArrayList<>();
        String sql = "select *\n"
                + "from Attendance a, userClass uc, Student s\n"
                + "where uc.class_id = ? and uc.userClass_id = a.userClass_id and a.date = ? and uc.student_id = s.student_id\n"
                + "order by date asc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, Integer.parseInt(classId));
            st.setDate(2, Date.valueOf(date));
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Student s = new Student();
                s.setRollNumber(rs.getString("rollNumber"));
                s.setFullName(rs.getString("fullName"));
                s.setStatus(rs.getString("status"));
//                Attendance a = new Attendance();
//                a.setAttendanceId(rs.getString("attendance_id"));
//                a.setDate(rs.getString("date"));
//                a.setStatus(rs.getString("status"));
//                s.setAttendance(a);
                list.add(s);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    private String getDateNow() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("uuuu-MM-dd");
        LocalDate localDate = LocalDate.now();
        return dtf.format(localDate);
    }
    
    public boolean checkPassword(String password) {
        String regex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^*&+=-_])(?=\\S+$).{8,20}$";
        return password.matches(regex);
    }

    public static void main(String[] args) {
        Dao d = new Dao();
        Account a = d.getByUsernameAndPass("lecturer_user", "password123");
        String[] b = {};
        System.out.println(d.getStudentInClass(1, "1", "2024-06-13"));
    }
}
