<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Dashboard - SB Admin</title>
                <!-- Bootstrap 5 CSS -->
                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

                <!-- Bootstrap 5 JavaScript -->
                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
                </script>

                <!-- jQuery (tùy chọn, nếu bạn cần dùng) -->
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <!-- Đoạn script cho avatar -->
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });
                    });
                </script>
                <!-- Đoạn script cho Nhập giá tiền -->
                <script>
                    function formatCurrency(input) {
                        // Lấy số, bỏ hết ký tự không phải số
                        let value = input.value.replace(/\D/g, '');
                        if (value === '') {
                            document.getElementById('price').value = '';
                            input.value = '';
                            return;
                        }

                        // Gán giá trị thật cho hidden input
                        document.getElementById('price').value = value;

                        // Format hiển thị: 1.200.000
                        input.value = new Intl.NumberFormat('vi-VN').format(value);
                    }
                </script>

                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">

                <jsp:include page="../layout/header.jsp" />

                <div id="layoutSidenav">
                    <!-- side bar -->
                    <jsp:include page="../layout/sidebar.jsp" />
                    <!-- side nav content -->
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Create Course</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/course">Courses</a></li>
                                    <li class="breadcrumb-item active">Create</li>
                                </ol>

                                <!-- create user -->
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Create a Course</h3>
                                            <hr />

                                            <form:form method="POST" action="/admin/course/create"
                                                modelAttribute="newCourse" class="row" enctype="multipart/form-data">

                                                <!-- ERROR VARS -->
                                                <c:set var="errorName">
                                                    <form:errors path="name" cssClass="invalid-feedback d-block" />
                                                </c:set>

                                                <c:set var="errorPrice">
                                                    <form:errors path="price" cssClass="invalid-feedback d-block" />
                                                </c:set>

                                                <c:set var="errorShortDesc">
                                                    <form:errors path="shortDesc" cssClass="invalid-feedback d-block" />
                                                </c:set>

                                                <c:set var="errorDetailDesc">
                                                    <form:errors path="detailDesc"
                                                        cssClass="invalid-feedback d-block" />
                                                </c:set>

                                                <!-- Name course -->
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Course Name:</label>
                                                    <form:input path="name"
                                                        cssClass="form-control ${not empty errorName ? 'is-invalid' : ''}" />
                                                    ${errorName}
                                                </div>

                                                <!-- PRICE -->
                                                <!-- <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Price:</label>
                                                    <form:input path="price" type="number" step="1000" min="0"
                                                        placeholder="Nhập giá khóa học (VNĐ)"
                                                        cssClass="form-control ${not empty errorPrice ? 'is-invalid' : ''}" />
                                                    ${errorPrice}
                                                </div> -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Price</label>

                                                    <div class="input-group">
                                                        <input type="text" id="priceDisplay"
                                                            class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                                            placeholder="Ví dụ: 1.200.000 VNĐ"
                                                            oninput="formatCurrency(this)" />
                                                        ${errorPrice}
                                                    </div>

                                                    <!-- input ẩn để submit lên server -->
                                                    <form:hidden path="price" id="price" />
                                                </div>

                                                <!-- LEVEL -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Level:</label>
                                                    <form:select path="level" class="form-select">
                                                        <form:option value="BEGINNER">Beginner</form:option>
                                                        <form:option value="INTERMEDIATE">Intermediate</form:option>
                                                        <form:option value="ADVANCED">Advanced</form:option>
                                                    </form:select>
                                                </div>

                                                <!-- SHORT DESC -->
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Short Description:</label>
                                                    <form:textarea path="shortDesc" rows="2"
                                                        cssClass="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}" />
                                                    ${errorShortDesc}
                                                </div>

                                                <!-- DETAIL DESC -->
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Detail Description:</label>
                                                    <form:textarea path="detailDesc" rows="4"
                                                        cssClass="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}" />
                                                    ${errorDetailDesc}
                                                </div>

                                                <!-- THUMBNAIL UPLOAD -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="avatarFile" class="form-label">Course Thumbnail:</label>
                                                    <input class="form-control" type="file" id="avatarFile"
                                                        accept=".png, .jpg, .jpeg" name="thumbnailFile" />
                                                </div>

                                                <!-- PREVIEW -->
                                                <div class="col-12 mb-3">
                                                    <img style="max-height: 250px; display: none;"
                                                        alt="thumbnail preview" id="avatarPreview" />
                                                </div>

                                                <!-- SUBMIT -->
                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-primary">
                                                        Create Course
                                                    </button>
                                                </div>

                                            </form:form>

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </main>

                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>

            </body>

            </html>