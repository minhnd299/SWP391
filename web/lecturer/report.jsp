<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!-- Including header -->
<jsp:include page="header.jsp"></jsp:include>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">

            <!-- Including header content -->
        <jsp:include page="header-content.jsp"></jsp:include>

            <!-- Task management -->
            <div class="container-fluid">
                <h1 class="h3 mb-2 text-gray-800">Report management</h1>
                <div class="card shadow mb-4">
                    <div class="card-header py-3">


                        <li class="nav-item dropdown" style="float: right">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Filter by Type
                            </a>
                            <div class="dropdown-menu dropdown-menu-right animated--grow-in" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item ${param.type == null ? 'active' : ''}" href="report?cid=${param.oid}">All</a>
                            <a class="dropdown-item ${param.type == 'Mid term' ? 'active' : ''}" href="report?cid=${param.oid}&amp;type=Mid term">Mid term</a>
                            <a class="dropdown-item ${param.type == 'Final' ? 'active' : ''}" href="report?cid=${param.oid}&amp;type=Final">Final</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown" style="float: right">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Filter by Class
                        </a>
                        <div class="dropdown-menu dropdown-menu-right animated--grow-in" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item ${param.cid == null ? 'active' : ''}" href="report?type=${param.type}">All</a>
                            <c:forEach var="q" items="${classes}" varStatus="status">
                                <a class="dropdown-item ${param.cid != null && param.cid == q.class_id ? 'active' : ''}" href="report?cid=${q.class_id}&amp;type=${param.type}">${q.class_name}</a>
                            </c:forEach>
                        </div>
                    </li>


                    <!-- Success Notification -->
                    <c:if test="${not empty sessionScope.notification}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert" style="text-align: center">
                            ${sessionScope.notification}
                            <button type="button" class="btn-danger" data-dismiss="alert" aria-label="Close">x</button>
                        </div>
                        <%
                            // Clear the notification after displaying it
                            session.removeAttribute("notification");
                        %>
                    </c:if>

                    <!-- Error Notification -->
                    <c:if test="${not empty sessionScope.notificationErr}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert"  style="text-align: center">
                            ${sessionScope.notificationErr}
                            <button type="button" class="btn-danger" data-dismiss="alert" >x</button>
                        </div>
                        <%
                            // Clear the notification after displaying it
                            session.removeAttribute("notificationErr");
                        %>
                    </c:if>

                </div>
                <div class="card-body">
                    <div class="table-responsive">

                        <table id="dataTable" class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Type</th>
                                    <th>Content</th>
                                    <th>Class</th>
                                    <th>Student</th>
                                    <th>Created at</th>
                                    <th>Update at</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="q" items="${questions}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td style=" color: ${q.type eq 'Mid term' ? 'green' : 'red'}">  ${q.type}    </td>
                                        <td>${q.content}</td>
                                        <td>${q.class_name}</td>
                                        <td>${q.student_name}</td>
                                        <td>${q.created_at.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"))}</td>

                                        <td>${q.updated_at.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"))}</td>
                                        <td>
                                            <i data-toggle="modal" data-target="#update${q.id}" class="fa fa-pen"></i>
                                        </td>
                                    </tr>

                                <div class="modal fade" id="update${q.id}" tabindex="-1" role="dialog" aria-labelledby="gradeModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-type" id="gradeModalLabel">Reply question</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <form name="updateForm${q.id}" id="updateForm${q.id}" action="report" method="POST" onsubmit="return validateUpdateForm(${q.id})">
                                                <div class="modal-body">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="id" value="${q.id}">

                                                    <label class="form-text">Type</label>
                                                    <input class="form-control" name="type" readonly="" value="${q.type}" type="text" placeholder="Enter question type">
                                                    <hr>
                                                    <label class="form-text">Content</label>
                                                    <textarea class="form-control" name="content" type="text" placeholder="Enter content" rows="6">${q.content}</textarea>
                                                    <span id="updateDescriptionError${q.id}" style="color: red; font-size: smaller"></span>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-success">Save changes</button>
                                                </div>
                                            </form>

                                        </div>
                                    </div>
                                </div>

                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function validateUpdateForm(id) {
        var isValid = true;

        // Get form elements
        var type = document.forms["updateForm" + id]["type"].value;
        var content = document.forms["updateForm" + id]["content"].value;

        // Clear previous error messages
        document.getElementById("updateDescriptionError" + id).innerText = "";

        // Validate content
        if (content === "") {
            document.getElementById("updateDescriptionError" + id).innerText = "Content is required.";
            isValid = false;
        }

        return isValid;
    }

</script>
<!-- Including footer -->
<jsp:include page="footer.jsp"></jsp:include>
