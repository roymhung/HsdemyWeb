<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <title>Manage Course</title>

            <link href="/css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        </head>

        <body class="sb-nav-fixed">

            <!-- HEADER -->
            <jsp:include page="../layout/header.jsp" />

            <div id="layoutSidenav">

                <!-- SIDEBAR -->
                <jsp:include page="../layout/sidebar.jsp" />

                <!-- CONTENT -->
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

                            <div class="mt-5">
                                <div class="row">
                                    <div class="col-12 mx-auto">

                                        <div class="d-flex justify-content-between align-items-center">
                                            <h3>Course Table</h3>
                                            <a href="/admin/Course/create" class="btn btn-primary">
                                                Create Course
                                            </a>
                                        </div>

                                        <hr />

                                        <table class="table table-bordered table-hover align-middle">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Title</th>
                                                    <th>Image</th>
                                                    <th>Price</th>
                                                    <th>Category</th>
                                                    <th>Created By</th>
                                                    <th>Created At</th>
                                                    <th width="260">Action</th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                                <c:forEach var="course" items="${courses}">
                                                    <tr>
                                                        <td>${course.courseId}</td>

                                                        <td>${course.title}</td>

                                                        <td>
                                                            <c:if test="${not empty course.image}">
                                                                <img src="${pageContext.request.contextPath}/images/course/${course.image}"
                                                                    width="70" height="50" style="object-fit: cover;" />
                                                            </c:if>
                                                        </td>

                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${course.isFree}">
                                                                    <span class="badge bg-success">FREE</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${course.price}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>

                                                        <td>${course.category.name}</td>

                                                        <td>${course.createdBy.fullName}</td>

                                                        <td>${course.createdAt}</td>

                                                        <td>
                                                            <a href="/admin/course/${course.courseId}"
                                                                class="btn btn-success btn-sm">View</a>

                                                            <a href="/admin/course/update/${course.courseId}"
                                                                class="btn btn-warning btn-sm mx-1">Update</a>

                                                            <a href="/admin/course/delete/${course.courseId}"
                                                                class="btn btn-danger btn-sm">Delete</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                                <c:if test="${empty courses}">
                                                    <tr>
                                                        <td colspan="8" class="text-center">
                                                            No course found
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

                    <!-- FOOTER -->
                    <jsp:include page="../layout/footer.jsp" />
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                crossorigin="anonymous"></script>
            <script src="/js/scripts.js"></script>

        </body>

        </html>