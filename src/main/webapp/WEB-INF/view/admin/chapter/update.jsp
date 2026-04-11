<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Update Chapter</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
                                <h1 class="mt-4">Cập nhật chương</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Bảng điều khiển</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/course">Khóa học</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/course/${course.id}">Chi tiết</a></li>
                                    <li class="breadcrumb-item active">Cập nhật chương</li>
                                </ol>

                                <div class="card">
                                    <div class="card-header fw-semibold">Chỉnh sửa chương #${newChapter.id}</div>
                                    <div class="card-body">
                                        <form:form method="POST" action="/admin/course/${course.id}/chapter/update"
                                            modelAttribute="newChapter" class="row g-3">
                                            <form:hidden path="id" />
                                            <div class="col-md-2">
                                                <label class="form-label">Số thứ tự</label>
                                                <form:input path="position" type="number" min="1"
                                                    class="form-control" />
                                                <form:errors path="position"
                                                    cssClass="text-danger small d-block mt-1" />
                                            </div>
                                            <div class="col-md-5">
                                                <label class="form-label">Tên chương</label>
                                                <form:input path="title" class="form-control" />
                                                <form:errors path="title" cssClass="text-danger small d-block mt-1" />
                                            </div>
                                            <div class="col-md-5">
                                                <label class="form-label">Trạng thái</label>
                                                <form:select path="status" class="form-select">
                                                    <form:option value="ACTIVE">Hoạt động</form:option>
                                                    <form:option value="DRAFT">Bản nháp</form:option>
                                                </form:select>
                                            </div>
                                            <div class="col-12">
                                                <label class="form-label">Mô tả mục / chương (optional)</label>
                                                <form:textarea path="description" rows="4" class="form-control" />
                                            </div>
                                            <div class="col-12 d-flex gap-2">
                                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                                <a href="/admin/course/${course.id}"
                                                    class="btn btn-outline-secondary">Huỷ</a>
                                            </div>
                                        </form:form>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>