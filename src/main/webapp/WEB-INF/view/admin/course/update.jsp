<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

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
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <!-- Đoạn script cho avatar -->
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        const orgImage = "${newCourse.thumbnail}";
                        if (orgImage) {
                            const urlImage = "/images/course/" + orgImage;
                            $("#avatarPreview").attr("src", urlImage);
                            $("#avatarPreview").css({ "display": "block" });
                        }
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });
                    });
                </script>
                <!-- Price + free course logic -->
                <script>
                    function formatCurrency(input) {
                        const hiddenPrice = document.getElementById('price');
                        let value = input.value.replace(/\D/g, '');
                        if (value === '') {
                            hiddenPrice.value = '0';
                            input.value = '';
                            return;
                        }
                        hiddenPrice.value = value;
                        input.value = new Intl.NumberFormat('vi-VN').format(value);
                    }

                    function toggleFreeCourse() {
                        const freeCheckbox = document.getElementById('freeCourse');
                        const priceDisplay = document.getElementById('priceDisplay');
                        const hiddenPrice = document.getElementById('price');
                        const paidHint = document.getElementById('paidHint');
                        const freeHint = document.getElementById('freeHint');

                        if (freeCheckbox.checked) {
                            hiddenPrice.value = '0';
                            priceDisplay.value = 'Miễn phí';
                            priceDisplay.setAttribute('disabled', 'disabled');
                            if (paidHint) paidHint.classList.add('d-none');
                            if (freeHint) freeHint.classList.remove('d-none');
                            return;
                        }

                        priceDisplay.removeAttribute('disabled');
                        if (hiddenPrice.value === '0' || hiddenPrice.value === '') {
                            priceDisplay.value = '';
                        } else {
                            priceDisplay.value = new Intl.NumberFormat('vi-VN').format(hiddenPrice.value);
                        }
                        if (paidHint) paidHint.classList.remove('d-none');
                        if (freeHint) freeHint.classList.add('d-none');
                    }

                    document.addEventListener('DOMContentLoaded', function () {
                        const hiddenPrice = document.getElementById('price');
                        const priceDisplay = document.getElementById('priceDisplay');
                        const freeCheckbox = document.getElementById('freeCourse');
                        const initialPrice = Number(hiddenPrice.value || 0);

                        if (initialPrice > 0) {
                            priceDisplay.value = new Intl.NumberFormat('vi-VN').format(initialPrice);
                        } else {
                            freeCheckbox.checked = true;
                        }
                        toggleFreeCourse();
                    });
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
                                <h1 class="mt-4">Manage Course</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">
                                            Dashboard
                                        </a></li>
                                    <li class="breadcrumb-item active">Course</li>
                                </ol>

                                <!-- update user -->
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Update Course</h3>
                                            <hr />

                                            <form:form method="POST" action="/admin/course/update"
                                                modelAttribute="newCourse" enctype="multipart/form-data" class="row">
                                                <!-- ID (hidden) -->
                                                <form:hidden path="id" />
                                                <!-- ERROR VARS -->
                                                <c:set var="errorName">
                                                    <form:errors path="name" cssClass="invalid-feedback d-block" />
                                                </c:set>

                                                <c:set var="errorAuthor">
                                                    <form:errors path="author" cssClass="invalid-feedback d-block" />
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

                                                <!-- NAME -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Course Name</label>
                                                    <form:input path="name"
                                                        cssClass="form-control ${not empty errorName ? 'is-invalid' : ''}" />
                                                    ${errorName}
                                                </div>

                                                <!-- Author -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Course Author</label>
                                                    <form:input path="author"
                                                        cssClass="form-control ${not empty errorAuthor ? 'is-invalid' : ''}" />
                                                    ${errorAuthor}
                                                </div>

                                                <!-- PRICE -->
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
                                                    <div class="form-check mt-2">
                                                        <input class="form-check-input" type="checkbox" id="freeCourse"
                                                            onchange="toggleFreeCourse()">
                                                        <label class="form-check-label fw-semibold" for="freeCourse">
                                                            Khóa học miễn phí
                                                        </label>
                                                    </div>
                                                    <small id="paidHint" class="text-muted">Nhập giá tiền nếu là khóa học trả phí.</small>
                                                    <small id="freeHint" class="text-success d-none">Người học có thể vào học ngay mà không cần thanh toán.</small>
                                                </div>


                                                <!-- LEVEL -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Level</label>
                                                    <form:select path="level" class="form-select">
                                                        <form:option value="BEGINNER">Beginner</form:option>
                                                        <form:option value="INTERMEDIATE">Intermediate</form:option>
                                                        <form:option value="ADVANCED">Advanced</form:option>
                                                    </form:select>
                                                </div>

                                                <!-- Title -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Chủ đề:</label>
                                                    <form:select path="title" class="form-select">
                                                        <form:option value="LANGUAGE">Ngoại ngữ</form:option>
                                                        <form:option value="SOFT_SKILLS">Kỹ năng mềm</form:option>
                                                        <form:option value="BUSINESS_MARKETING">Kinh doanh & Marketing
                                                        </form:option>
                                                        <form:option value="IT_DESIGN">Tin học & Thiết kế</form:option>
                                                    </form:select>
                                                </div>

                                                <!-- SHORT DESC -->
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Short Description</label>
                                                    <form:textarea path="shortDesc" rows="2"
                                                        cssClass="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}" />
                                                    ${errorShortDesc}
                                                </div>

                                                <!-- DETAIL DESC -->
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Detail Description</label>
                                                    <form:textarea path="detailDesc" rows="4"
                                                        cssClass="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}" />
                                                    ${errorDetailDesc}
                                                </div>

                                                <!-- UPLOAD THUMBNAIL -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Change Thumbnail</label>
                                                    <input class="form-control" type="file" id="avatarFile"
                                                        name="thumbnailFile" accept=".png,.jpg,.jpeg" />
                                                </div>

                                                <!-- CURRENT THUMBNAIL -->
                                                <div class="col-12 mb-3">
                                                    <label class="form-label">Current Thumbnail</label><br />
                                                    <c:if test="${not empty newCourse.thumbnail}">
                                                        <img id="avatarPreview"
                                                            src="/images/course/${newCourse.thumbnail}"
                                                            style="max-height: 250px;" />
                                                    </c:if>
                                                </div>

                                                <!-- SUBMIT -->
                                                <div class="col-12 mb-5">
                                                    <button class="btn btn-warning">
                                                        Update Course
                                                    </button>
                                                </div>
                                            </form:form>

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </main>
                        <!-- footer -->
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/scripts.js"></script>
            </body>

            </html>