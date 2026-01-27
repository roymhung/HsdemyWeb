<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!-- Navigation -->
                <nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top shadow-sm">
                    <div class="container">
                        <a class="navbar-brand fw-bold text-primary" href="/">
                            <h1 class="text-primary display-6">Hstudemy</h1>
                        </a>

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto">
                                <li class="nav-item"><a class="nav-link active" href="/">Trang chủ</a></li>
                                <li class="nav-item"><a class="nav-link" href="courses.html">Khóa học</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Lộ trình học tập</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Về chúng tôi</a></li>
                            </ul>

                            <div class="d-flex align-items-center gap-3">
                                <form class="d-none d-md-block position-relative">
                                    <input class="form-control form-control-sm ps-4" type="search"
                                        placeholder="Tìm khóa học, kỹ năng, chứng chỉ..." style="width: 230px;">
                                    <i
                                        class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-2 text-muted"></i>
                                </form>

                                <a href="cart.html" class="position-relative text-dark fs-5">
                                    <i class="bi bi-cart3"></i>
                                    <span
                                        class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                                        style="font-size: 10px;">2</span>
                                </a>

                                <a href="/login" class="btn btn-outline-primary btn-sm">Đăng nhập</a>
                                <a href="/register" class="btn btn-primary btn-sm">Đăng ký</a>
                            </div>
                        </div>
                    </div>
                </nav>