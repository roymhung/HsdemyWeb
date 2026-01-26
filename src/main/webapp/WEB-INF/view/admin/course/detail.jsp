<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <title>Dashboard - SB Admin</title>

                    <!-- Bootstrap 5 -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">

                    <jsp:include page="../layout/header.jsp" />

                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />

                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Manage Course</h1>

                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item">
                                            <a href="/admin">Dashboard</a>
                                        </li>
                                        <li class="breadcrumb-item active">Course</li>
                                    </ol>

                                    <!-- COURSE DETAIL -->
                                    <div class="mt-5">
                                        <div class="row">
                                            <div class="col-12 mx-auto">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <h3>Course Detail (ID = ${course.id})</h3>
                                                    <a href="/admin/course/create" class="btn btn-primary">
                                                        Create Course
                                                    </a>
                                                </div>
                                                <hr />

                                                <div class="card" style="width: 72rem;">
                                                    <div class="card-header">
                                                        Course Information
                                                    </div>

                                                    <ul class="list-group list-group-flush">
                                                        <li class="list-group-item">
                                                            <strong>Name:</strong> ${course.name}
                                                        </li>

                                                        <li class="list-group-item">
                                                            <strong>Price:</strong>
                                                            <fmt:formatNumber value="${course.price}" pattern="#,##0" />
                                                            VNĐ
                                                        </li>

                                                        <li class="list-group-item">
                                                            <strong>Level:</strong> ${course.level}
                                                        </li>

                                                        <li class="list-group-item">
                                                            <strong>Short Description:</strong>
                                                            ${course.shortDesc}
                                                        </li>

                                                        <li class="list-group-item">
                                                            <strong>Description:</strong>
                                                            ${course.detailDesc}
                                                        </li>

                                                        <li class="list-group-item">
                                                            <strong>Thumbnail:</strong><br>
                                                            <c:if test="${not empty course.thumbnail}">
                                                                <img src="${pageContext.request.contextPath}/images/course/${course.thumbnail}"
                                                                    width="180" height="120" />
                                                            </c:if>
                                                        </li>
                                                    </ul>
                                                </div>

                                                <a href="/admin/course" class="btn btn-success mt-3">Back</a>

                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </main>

                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </div>

                    <script src="/js/scripts.js"></script>
                </body>

                </html>