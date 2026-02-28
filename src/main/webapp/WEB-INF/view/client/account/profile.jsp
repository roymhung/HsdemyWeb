<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Ho so ca nhan</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
            <link rel="stylesheet" href="/client/css/style.css">
        </head>

        <body>
            <jsp:include page="../layout/header.jsp" />

            <section class="py-5 mt-5">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 mx-auto">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body p-4 p-md-5">
                                    <h3 class="fw-bold mb-4">Update a user</h3>

                                    <form method="post" action="/account/profile/update" enctype="multipart/form-data"
                                        class="row g-3">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <input type="hidden" name="id" value="${newUser.id}" />

                                        <div class="col-md-6">
                                            <label class="form-label">Email:</label>
                                            <input type="email" class="form-control" name="email"
                                                value="${newUser.email}" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Phone number:</label>
                                            <input type="text" class="form-control" name="phone" value="${newUser.phone}">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Full Name:</label>
                                            <input type="text" class="form-control" name="fullName"
                                                value="${newUser.fullName}">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Address:</label>
                                            <input type="text" class="form-control" name="address"
                                                value="${newUser.address}">
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label">Avatar:</label>
                                            <input type="file" class="form-control" name="avatarFile"
                                                accept=".png,.jpg,.jpeg">
                                        </div>
                                        <div class="col-12">
                                            <c:if test="${not empty newUser.avatar}">
                                                <img src="/images/avatar/${newUser.avatar}" alt="avatar" class="rounded"
                                                    style="width: 120px; height: 120px; object-fit: cover;">
                                            </c:if>
                                        </div>
                                        <div class="col-12">
                                            <button class="btn btn-primary" type="submit">Cap nhat</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <jsp:include page="../layout/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>
