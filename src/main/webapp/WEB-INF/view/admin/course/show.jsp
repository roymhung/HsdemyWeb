<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Quản lý khóa học</title>

    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">

    <jsp:include page="../layout/header.jsp" />

    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Quản lý khóa học</h1>

                    <c:if test="${not empty message}">
                        <div class="alert alert-${empty messageType ? 'info' : messageType} border-0 shadow-sm mt-3 mb-3">
                            ${message}
                        </div>
                    </c:if>

                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Bảng điều khiển</a></li>
                        <li class="breadcrumb-item active">Khóa học</li>
                    </ol>

                    <div class="mt-3">
                        <div class="row">
                            <div class="col-12 mx-auto">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h3 class="mb-0">Danh sách khóa học</h3>
                                    <c:if test="${selectedView != 'trash'}">
                                        <a href="/admin/course/create" class="btn btn-primary">Tạo khóa học</a>
                                    </c:if>
                                </div>

                                <div class="d-flex gap-2 mb-3">
                                    <a href="/admin/course?view=active"
                                        class="btn ${selectedView == 'active' ? 'btn-primary' : 'btn-outline-primary'}">
                                        Đang hiển thị (${activeCount})
                                    </a>
                                    <a href="/admin/course?view=trash"
                                        class="btn ${selectedView == 'trash' ? 'btn-warning' : 'btn-outline-warning'}">
                                        Đã ẩn / Thùng rác (${trashCount})
                                    </a>
                                </div>

                                <table class="table table-bordered table-hover align-middle">
                                    <thead class="table-dark">
                                        <tr>
                                            <th width="50">ID</th>
                                            <th>Tên khóa học</th>
                                            <th width="140">Tác giả</th>
                                            <th>Giá</th>
                                            <th width="110">Cấp độ</th>
                                            <th>Ảnh đại diện</th>
                                            <th width="390">Hành động</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach var="course" items="${courses}">
                                            <tr>
                                                <td>${course.id}</td>
                                                <td>${course.name}</td>
                                                <td>${course.author}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${course.price <= 0}">
                                                            <span class="badge bg-success">MIỄN PHÍ</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${course.price}" type="number" groupingUsed="true" /> VND
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <span class="badge bg-info text-dark">${course.level}</span>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty course.thumbnail}">
                                                        <img src="${pageContext.request.contextPath}/images/course/${course.thumbnail}"
                                                            width="70" style="object-fit: cover;" />
                                                    </c:if>
                                                </td>

                                                <td>
                                                    <c:choose>
                                                        <c:when test="${selectedView == 'trash'}">
                                                            <form action="/admin/course/restore/${course.id}" method="post" class="d-inline">
                                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                                <button type="submit" class="btn btn-sm btn-success">Khôi phục</button>
                                                            </form>

                                                            <form action="/admin/course/purge/${course.id}" method="post" class="d-inline ms-1"
                                                                onsubmit="return confirm('Xóa vĩnh viễn khóa học này khỏi hệ thống?');">
                                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                                <button type="submit" class="btn btn-sm btn-danger">Xóa vĩnh viễn</button>
                                                            </form>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="/admin/course/${course.id}" class="btn btn-success btn-sm">
                                                                Thiết kế khóa học
                                                            </a>

                                                            <a href="/admin/course/update/${course.id}" class="btn btn-warning btn-sm mx-1">
                                                                Cập nhật
                                                            </a>

                                                            <a href="/admin/course/delete/${course.id}" class="btn btn-danger btn-sm">
                                                                Xóa
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                        <c:if test="${empty courses}">
                                            <tr>
                                                <td colspan="9" class="text-center text-muted">
                                                    <c:choose>
                                                        <c:when test="${selectedView == 'trash'}">
                                                            Thùng rác đang trống.
                                                        </c:when>
                                                        <c:otherwise>
                                                            Không tìm thấy khóa học.
                                                        </c:otherwise>
                                                    </c:choose>
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

            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
