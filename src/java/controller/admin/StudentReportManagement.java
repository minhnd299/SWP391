package controller.admin;

import dal.StudentReportDAO;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.Account;
import model.StudentReport;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet(name = "StudentReportManagement", urlPatterns = {"/admin/student-report"})
public class StudentReportManagement extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        int cid = Integer.parseInt(request.getParameter("class"));
        String type = request.getParameter("type");
        System.out.println(cid + "   " + type);
        if (a != null && a.getRoleAccount().getRole_id() == 1) {
            String filePath = getServletContext().getRealPath("/") + "static/evaluation.xlsx";
            try (FileInputStream fis = new FileInputStream(new File(filePath))) {
                Workbook workbook = new XSSFWorkbook(fis);
                Sheet sheet = workbook.getSheetAt(0);

                // Define the cell style for centering text and adding borders
                CellStyle cellStyle = workbook.createCellStyle();
                cellStyle.setAlignment(HorizontalAlignment.CENTER);
                cellStyle.setBorderBottom(BorderStyle.THIN);
                cellStyle.setBorderTop(BorderStyle.THIN);
                cellStyle.setBorderLeft(BorderStyle.THIN);
                cellStyle.setBorderRight(BorderStyle.THIN);
                StudentReportDAO srdao = new StudentReportDAO();
                List<StudentReport> list = srdao.getAllStudentsByClassId(cid, type);
                list.forEach(System.out::println);
                // Write data to the Excel file
                int startRow = 13; // Row index starts at 0, so 13 means row 14
                for (StudentReport report : list) {
                    Row row = sheet.getRow(startRow++);
//                    for (int j = 0; j < 12; j++) {
//                        Cell cell = row.createCell(j);
//                        cell.setCellStyle(cellStyle);
//                    }
//                    row.getCell(0).setCellValue(startRow - 13); // No
                    row.getCell(1).setCellValue(report.getStudent().getRollNumber()); // Student ID
                    row.getCell(2).setCellValue(""); // Mã nhân viên
                    row.getCell(3).setCellValue(report.getStudent().getFullName()); // Fullname
                    row.getCell(4).setCellValue(report.getStudent().getJobTitle()); // Bộ phận
                    row.getCell(5).setCellValue(report.getLecturer().getFullName()); // cán bộ quản lý
                    row.getCell(6).setCellValue(""); // Trợ cấp
                    row.getCell(7).setCellValue(report.getReport().getContent()); // Nhận xét
                    row.getCell(8).setCellValue(getTwoDecimal(report.getReport().getKnowledge())); // kn
                    row.getCell(9).setCellValue(getTwoDecimal(report.getReport().getSoft_skill())); // s
                    row.getCell(10).setCellValue(getTwoDecimal(report.getReport().getAttitude())); // a
                    row.getCell(11).setCellValue(getTwoDecimal(report.getReport().getFinal_grade())); // f

                }
                Row dateRow = sheet.getRow(35);
                Cell dateCell = dateRow.getCell(10);
                System.out.println("++++++" + dateCell.getStringCellValue());
                // Save to a new file
                dateCell.setCellValue("Ha Noi, " + getCurrentTimeStamp());
                String newFilePath = getServletContext().getRealPath("/") + "static/student-report.xlsx";
                try (FileOutputStream fos = new FileOutputStream(new File(newFilePath))) {
                    workbook.write(fos);
                }
                workbook.close();

                // Prepare for download
                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-Disposition", "attachment; filename=student-report.xlsx");
                try (FileInputStream downloadFis = new FileInputStream(new File(newFilePath)); OutputStream out = response.getOutputStream()) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = downloadFis.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    public final String getCurrentTimeStamp() {
        SimpleDateFormat formDate = new SimpleDateFormat("dd-MM-yyyy");
        String strDate = formDate.format(new Date());
        return strDate;
    }

    private String getTwoDecimal(float value) {
        return String.format("%.2f", value);
    }

}
