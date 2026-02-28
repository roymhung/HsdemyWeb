<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quen mat khau | Hstudemyweb</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                <link rel="stylesheet" href="/client/css/style.css">
                <link rel="stylesheet" href="/client/css/auth-pages.css">
            </head>

            <body class="bg-light">
                <nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top shadow-sm">
                    <div class="container">
                        <a class="navbar-brand fw-bold text-primary" href="/">
                            <i class="bi bi-code-slash me-2"></i>Hstudemyweb
                        </a>
                    </div>
                </nav>

                <div class="row align-items-center justify-content-center min-vh-100">
                    <div class="col-lg-5 col-md-7">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body p-4 p-md-5">
                                <h3 class="fw-bold mb-2">Dat lai mat khau</h3>
                                <p class="text-muted mb-4">Nhap email da dang ky va mat khau moi.</p>

                                <form:form method="post" action="/forgot-password" modelAttribute="resetPassword">
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Email</label>
                                        <form:input path="email" type="email" cssClass="form-control"
                                            placeholder="name@example.com" />
                                        <form:errors path="email" cssClass="invalid-feedback d-block" />
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Mat khau moi</label>
                                        <form:password path="password" cssClass="form-control"
                                            placeholder="Toi thieu 6 ky tu" />
                                        <form:errors path="password" cssClass="invalid-feedback d-block" />
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label fw-semibold">Nhap lai mat khau moi</label>
                                        <form:password path="confirmPassword" cssClass="form-control"
                                            placeholder="Nhap lai mat khau moi" />
                                        <form:errors path="confirmPassword" cssClass="invalid-feedback d-block" />
                                    </div>

                                    <div><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /></div>

                                    <button class="btn btn-primary w-100" type="submit">Dat lai mat khau</button>
                                </form:form>

                                <div class="text-center mt-4">
                                    <a href="/login" class="text-primary fw-semibold text-decoration-none">Quay ve dang
                                        nhap</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>
