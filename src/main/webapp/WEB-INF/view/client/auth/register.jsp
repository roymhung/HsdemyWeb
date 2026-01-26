<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Đăng ký | Hstudemyweb</title>

                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <!-- Bootstrap Icons -->
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                    <!-- Google Fonts -->
                    <link
                        href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                        rel="stylesheet">
                    <!-- Custom CSS -->
                    <link rel="stylesheet" href="/client/css/style.css">
                    <link rel="stylesheet" href="/client/css/auth-pages.css">
                </head>

                <body class="bg-light" data-page="signup">
                    <!-- Navigation -->
                    <nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top shadow-sm">
                        <div class="container">
                            <a class="navbar-brand fw-bold text-primary" href="index.html">
                                <i class="bi bi-code-slash me-2"></i>Hstudemyweb
                            </a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarNav">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav me-auto">
                                    <li class="nav-item"><a class="nav-link" href="index.html">Trang chủ</a></li>
                                    <li class="nav-item"><a class="nav-link" href="courses.html">Khóa học</a></li>
                                </ul>
                                <div class="d-flex align-items-center gap-3">
                                    <a href="cart.html" class="position-relative text-dark fs-5">
                                        <i class="bi bi-cart3"></i>
                                        <span data-cart-badge
                                            class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger d-none"
                                            style="font-size: 10px;">0</span>
                                    </a>
                                    <div data-auth-area="guest" class="d-flex gap-2">
                                        <a href="signin.html" class="btn btn-outline-primary btn-sm">Đăng nhập</a>
                                        <a href="signup.html" class="btn btn-primary btn-sm">Đăng ký</a>
                                    </div>
                                    <div data-auth-area="user" class="d-none">
                                        <div class="dropdown">
                                            <button class="btn btn-outline-primary btn-sm dropdown-toggle" type="button"
                                                data-bs-toggle="dropdown">
                                                <i class="bi bi-person-circle me-1"></i><span data-auth-user-name>Tài
                                                    khoản</span>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end">
                                                <li><a class="dropdown-item" href="course-player.html">Vào học</a></li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li><a class="dropdown-item" href="#" data-action="signout">Đăng
                                                        xuất</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </nav>


                    <!-- Page main -->
                    <div class="row align-items-center justify-content-center min-vh-100">
                        <!-- CỘT BÊN TRÁI: HÌNH ẢNH -->
                        <div class="col-lg-6 d-none d-lg-flex justify-content-center">
                            <img src="/images/signin_signup/anh.png" alt="Login Image" class="img-fluid"
                                style="max-height: 500px;">
                        </div>

                        <!-- CỘT BÊN PHẢI: FORM ĐĂNG KÝ -->
                        <div class="col-lg-4 col-md-6">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body p-4 p-md-5">
                                    <h3 class="fw-bold mb-1">Tạo tài khoản Hstudemyweb</h3>
                                    <p class="text-muted mb-4">Tham gia để học tập và theo dõi tiến độ của bạn.</p>

                                    <form:form method="post" action="/register" modelAttribute="registerUser">
                                        <div class="row g-3">

                                            <!-- ERROR VARS -->
                                            <c:set var="errorPassword">
                                                <form:errors path="confirmPassword"
                                                    cssClass="invalid-feedback d-block" />
                                            </c:set>

                                            <c:set var="errorEmail">
                                                <form:errors path="email" cssClass="invalid-feedback d-block" />
                                            </c:set>

                                            <c:set var="errorPassword">
                                                <form:errors path="confirmPassword"
                                                    cssClass="invalid-feedback d-block" />
                                            </c:set>

                                            <!-- HỌ & TÊN -->
                                            <div class="col-md-6">
                                                <label class="form-label fw-semibold">Họ (Last name)</label>
                                                <form:input class="form-control" type="text" path="lastName"
                                                    placeholder="Nguyễn" />
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label fw-semibold">Tên (First name)</label>
                                                <form:input class="form-control" type="text" path="firstName"
                                                    placeholder="Văn A" />
                                            </div>

                                            <!-- EMAIL -->
                                            <div class="col-12">
                                                <label class="form-label fw-semibold">Email</label>
                                                <form:input
                                                    class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                    type="email" path="email" placeholder="name@example.com" />
                                                ${errorEmail}
                                            </div>

                                            <!-- PASSWORD -->
                                            <div class="col-md-6">
                                                <label class="form-label fw-semibold">Mật khẩu</label>
                                                <form:input
                                                    class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                    type="password" path="password" placeholder="Tối thiểu 6 ký tự" />
                                                <form:errors path="confirmPassword" />
                                                ${errorPassword}
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label fw-semibold">Xác nhận mật khẩu</label>
                                                <form:input class="form-control" type="password" path="confirmPassword"
                                                    placeholder="Nhập lại mật khẩu" />
                                            </div>

                                            <!-- TERMS -->
                                            <div class="col-12">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" id="terms" />
                                                    <label class="form-check-label" for="terms">
                                                        Tôi đồng ý với điều khoản và chính sách
                                                    </label>
                                                </div>
                                            </div>
                                        </div>

                                        <button class="btn btn-primary w-100 mt-4" type="submit">
                                            Tạo tài khoản
                                        </button>
                                    </form:form>

                                    <div class="text-center mt-4">
                                        <span class="text-muted">Đã có tài khoản?</span>
                                        <a href="signin.html" class="text-primary fw-semibold text-decoration-none">
                                            Đăng nhập
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>


                    <!-- Footer -->
                    <footer class="bg-black text-white py-5">
                        <div class="container">
                            <div class="row g-4 mb-4">
                                <div class="col-lg-4 col-md-6">
                                    <h5 class="fw-bold mb-3 text-primary">
                                        <i class="bi bi-code-slash me-2"></i>Hsudemy
                                    </h5>
                                    <p class="text-white-50 mb-4">Nền tảng học lập trình trực tuyến hàng đầu Việt Nam.
                                        Giúp bạn phát
                                        triển kỹ năng lập trình từ cơ bản đến nâng cao với các khóa học chất lượng cao.
                                    </p>
                                    <div class="d-flex gap-3">
                                        <a href="#" class="text-white text-decoration-none">
                                            <div class="bg-dark rounded-circle d-inline-flex align-items-center justify-content-center"
                                                style="width: 40px; height: 40px;">
                                                <i class="bi bi-facebook"></i>
                                            </div>
                                        </a>
                                        <a href="#" class="text-white text-decoration-none">
                                            <div class="bg-dark rounded-circle d-inline-flex align-items-center justify-content-center"
                                                style="width: 40px; height: 40px;">
                                                <i class="bi bi-youtube"></i>
                                            </div>
                                        </a>
                                        <a href="#" class="text-white text-decoration-none">
                                            <div class="bg-dark rounded-circle d-inline-flex align-items-center justify-content-center"
                                                style="width: 40px; height: 40px;">
                                                <i class="bi bi-github"></i>
                                            </div>
                                        </a>
                                        <a href="#" class="text-white text-decoration-none">
                                            <div class="bg-dark rounded-circle d-inline-flex align-items-center justify-content-center"
                                                style="width: 40px; height: 40px;">
                                                <i class="bi bi-linkedin"></i>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <div class="col-lg-2 col-md-6 col-sm-6">
                                    <h6 class="fw-bold mb-3 text-primary">Khóa học</h6>
                                    <ul class="list-unstyled">
                                        <li class="mb-2"><a href="courses.html"
                                                class="text-white-50 text-decoration-none hover-primary">Tất cả khóa
                                                học</a></li>
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Web
                                                Development</a></li>
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Mobile
                                                App</a></li>
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Backend</a>
                                        </li>
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Cloud &
                                                DevOps</a></li>
                                    </ul>
                                </div>
                                <div class="col-lg-2 col-md-6 col-sm-6">
                                    <h6 class="fw-bold mb-3 text-primary">Công ty</h6>
                                    <ul class="list-unstyled">
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Về chúng
                                                tôi</a></li>
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Tuyển
                                                dụng</a></li>
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Liên
                                                hệ</a></li>
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Blog</a>
                                        </li>
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Đối
                                                tác</a></li>
                                    </ul>
                                </div>
                                <div class="col-lg-2 col-md-6 col-sm-6">
                                    <h6 class="fw-bold mb-3 text-primary">Hỗ trợ</h6>
                                    <ul class="list-unstyled">
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Trung tâm
                                                trợ giúp</a></li>
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Chính
                                                sách</a></li>
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Điều
                                                khoản</a></li>
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">FAQ</a>
                                        </li>
                                        <li class="mb-2"><a href="#"
                                                class="text-white-50 text-decoration-none hover-primary">Bảo
                                                mật</a></li>
                                    </ul>
                                </div>
                                <div class="col-lg-2 col-md-6 col-sm-6">
                                    <h6 class="fw-bold mb-3 text-primary">Đăng ký nhận tin</h6>
                                    <p class="text-white-50 small mb-3">Nhận thông tin về khóa học mới và ưu đãi đặc
                                        biệt</p>
                                    <form>
                                        <div class="mb-2">
                                            <input type="email"
                                                class="form-control form-control-sm bg-dark border-secondary text-white"
                                                placeholder="Email của bạn">
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-sm w-100">Đăng ký</button>
                                    </form>
                                </div>
                            </div>
                            <hr class="my-4 border-secondary">
                            <div class="row align-items-center">
                                <div class="col-md-6">
                                    <p class="text-white-50 mb-0 small">&copy; 2024 <span
                                            class="text-primary">Hsudemy</span>. All
                                        rights reserved.</p>
                                </div>
                                <div class="col-md-6 text-md-end">
                                    <div class="d-flex justify-content-md-end gap-3">
                                        <a href="#" class="text-white-50 text-decoration-none small hover-primary">Chính
                                            sách bảo
                                            mật</a>
                                        <a href="#" class="text-white-50 text-decoration-none small hover-primary">Điều
                                            khoản sử
                                            dụng</a>
                                        <a href="#"
                                            class="text-white-50 text-decoration-none small hover-primary">Sitemap</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </footer>

                    <!-- Bootstrap JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <!-- Custom JS -->
                    <script src="js/main.js"></script>
                </body>

                </html>