<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <title>Manage Courses</title>

                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">

                    <!-- Header -->
                    <jsp:include page="../layout/header.jsp" />

                    <div id="layoutSidenav">

                        <!-- Sidebar -->
                        <jsp:include page="../layout/sidebar.jsp" />

                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Manage Courses</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item">
                                            <a href="/admin">Dashboard</a>
                                        </li>
                                        <li class="breadcrumb-item active">Courses</li>
                                    </ol>

                                    <!-- Course table -->
                                    <div class="mt-5">
                                        <div class="row">
                                            <div class="col-12 mx-auto">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <h3>Course Table</h3>
                                                    <a href="/admin/course/create" class="btn btn-primary">
                                                        Create Course
                                                    </a>
                                                </div>
                                                <hr />

                                                <table class="table table-bordered table-hover align-middle">
                                                    <thead class="table-dark">
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Name Course</th>
                                                            <th>Name Author</th>
                                                            <th>Price</th>
                                                            <th>Level</th>
                                                            <th>Thumbnail</th>
                                                            <th width="260">Action</th>
                                                        </tr>
                                                    </thead>

                                                    <tbody>
                                                        <c:forEach var="course" items="${courses}">
                                                            <tr>
                                                                <td>${course.id}</td>
                                                                <td>${course.name}</td>
                                                                <td>${course.author}</td>
                                                                <td>
                                                                    <fmt:formatNumber value="${course.price}"
                                                                        type="number" groupingUsed="true" /> vnd
                                                                </td>

                                                                <td>
                                                                    <span class="badge bg-info text-dark">
                                                                        ${course.level}
                                                                    </span>
                                                                </td>

                                                                <td>
                                                                    <c:if test="${not empty course.thumbnail}">
                                                                        <img src="${pageContext.request.contextPath}/images/course/${course.thumbnail}"
                                                                            width="70" style="object-fit: cover;" />
                                                                    </c:if>
                                                                </td>

                                                                <td>
                                                                    <a href="/admin/course/${course.id}"
                                                                        class="btn btn-success btn-sm">
                                                                        View
                                                                    </a>

                                                                    <a href="/admin/course/update/${course.id}"
                                                                        class="btn btn-warning btn-sm mx-1">
                                                                        Update
                                                                    </a>

                                                                    <a href="/admin/course/delete/${course.id}"
                                                                        class="btn btn-danger btn-sm">
                                                                        Delete
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>

                                                        <c:if test="${empty courses}">
                                                            <tr>
                                                                <td colspan="9" class="text-center">
                                                                    No courses found
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                    </tbody>
                                                </table>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </main>

                            <!-- Footer -->
                            <jsp:include page="../layout/footer.jsp" />

                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>