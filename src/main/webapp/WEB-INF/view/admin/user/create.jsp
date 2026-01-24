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
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
                                <h1 class="mt-4">Manage Order</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">
                                            Dashboard
                                        </a></li>
                                    <li class="breadcrumb-item active">User</li>
                                </ol>

                                <!-- create user -->
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Create a user</h3>
                                            <hr />

                                            <form:form method="POST" action="/admin/user/create"
                                                modelAttribute="newUser" class="row" enctype="multipart/form-data">

                                                <c:set var="errorEmail">
                                                    <form:errors path="email" cssClass="invalid-feedback" />
                                                </c:set>

                                                <c:set var="errorPassword">
                                                    <form:errors path="password" cssClass="invalid-feedback" />
                                                </c:set>

                                                <c:set var="errorPhone">
                                                    <form:errors path="phone" cssClass="invalid-feedback" />
                                                </c:set>

                                                <c:set var="errorFullName">
                                                    <form:errors path="fullName" cssClass="invalid-feedback" />
                                                </c:set>

                                                <c:set var="errorAddress">
                                                    <form:errors path="address" cssClass="invalid-feedback" />
                                                </c:set>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Email:</label>
                                                    <form:input path="email"
                                                        cssClass="form-control ${not empty errorEmail ? 'is-invalid':''}" />
                                                    ${errorEmail}
                                                </div>

                                                <!-- Start mau validate -->
                                                <!-- 
                                                c1: 
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Email:</label>
                                                    <form:input path="email" cssClass="form-control is-invalid" />
                                                    <form:errors path="email" cssClass="invalid-feedback" />
                                                </div> 
                                                c2 
                                                 <div class="mb-3 col-12 col-md-6">
                                                    <c:set var="errorPassword">
                                                        <form:errors path="password" cssClass="invalid-feedback" />
                                                    </c:set>

                                                    <label class="form-label">Password:</label>
                                                    <form:password path="password"
                                                        cssClass="form-control ${not empty errorPassword ? 'is-invalid':''}" />
                                                    ${errorPassword}
                                                </div> -->
                                                <!-- End mau validate -->

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Password:</label>
                                                    <form:password path="password"
                                                        cssClass="form-control ${not empty errorPassword ? 'is-invalid':''}" />
                                                    ${errorPassword}
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Phone number:</label>
                                                    <form:input path="phone"
                                                        cssClass="form-control ${not empty errorPhone ? 'is-invalid':''}" />
                                                    ${errorPhone}
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Full Name:</label>
                                                    <form:input path="fullName"
                                                        cssClass="form-control ${not empty errorFullName ? 'is-invalid':''}" />
                                                    ${errorFullName}
                                                </div>

                                                <div class="mb-3 ">
                                                    <label class="form-label">Address:</label>
                                                    <form:input path="address"
                                                        cssClass="form-control ${not empty errorAddress ? 'is-invalid':''}" />
                                                    ${errorAddress}
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Role:</label>
                                                    <form:select class="form-select" path="role.name">
                                                        <form:option value="ADMIN">ADMIN</form:option>
                                                        <form:option value="USER">USER</form:option>
                                                    </form:select>
                                                </div>

                                                <!-- Upload image -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="avatarFile" class="form-label">Avatar: </label>
                                                    <input class="form-control" type="file" id="avatarFile"
                                                        accept=".png, .jpg, .jpeg" name="hungFile" />
                                                </div>

                                                <!-- Preview -->
                                                <div class="col-12 mb-3">
                                                    <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                        id="avatarPreview" />
                                                </div>

                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-primary">Create</button>
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