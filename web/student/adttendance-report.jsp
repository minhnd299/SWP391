<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="header.jsp"></jsp:include>

    <div id="content-wrapper" class="d-flex flex-column">

        <div id="content">

            <!-- Including header content -->
        <jsp:include page="header-content.jsp"></jsp:include>

            <div class="container-fluid">
                <h1 class="h3 mb-2 text-gray-800">Class list: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="date-now"></span></h1>
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">All classes</h6>
                    </div>
                    <div class="card-body">

                        <div class="table-responsive">
                            <!--<form action="${run == "add" ? "attendance" : "updateAttendance"}" method="post" style="width: 100%">-->

                        <div style="text-align: center; margin: auto">

                            <select id="date-in" class="form-select" aria-label="Default select example">
                                <c:forEach items="${das}" var="d">
                                    <option value="${d}">${d}</option>
                                </c:forEach>
                            </select>

                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <tr>
                                    <th>STT</th>
                                    <th>Date</th>
                                    <th>Lecturer</th>
                                    <th>Attendance</th>
                                </tr>

                                <c:forEach items="${list}" var="att" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${att.date}</td>
                                        <td>${att.lec.fullName}</td>
                                        <td>
                                            <p style="color:${att.status == 'present' ? 'green' : 'red'};">${att.status}</p>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </table>

                        </div>
                        <!--</form>-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="../vendor/jquery/jquery.min.js"></script>
<script>
    $('#date-in').change(function () {
        changeAtt();
    });
    function changeAtt() {
        const options = {
            method: 'POST'
        };
        fetch(`attendanceReport?date=`+$('#date-in').val(), options)
                .then(function (response) {
                    return response.json(response);
                })
                .then(function (data) {
                    let read = `<tr>
                            <th>STT</th>
                            <th>Date</th>
                            <th>Lecturer</th>
                            <th>Attendance</th>
                        </tr>`;
                    let length = data.length;
                    if (length < 1) {
                        read += '<tr><td colspan="4">No Data</td></tr>';
                    }
                    for (i = 0; i < length; i++) {
                        read += '<tr><td>' + (i + 1) + '</td>'
                                + '<td>' + data[i].date + '</td>'
                                + '<td>' + data[i].lec.fullName + '</td><td>';
                        if (data[i].status === 'present') {
                            read += '<p style="color:green;">' + data[i].status + '</p></td></tr>';
                        } else {
                            read += '<p style="color:red;">' + data[i].status + '</p></td></tr>';
                        }
                    }
                    $('#dataTable').html(read);
                });
    }
    ;

</script>

<jsp:include page="footer.jsp"></jsp:include>
