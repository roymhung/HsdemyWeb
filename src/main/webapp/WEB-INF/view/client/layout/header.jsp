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
                                <li class="nav-item"><a class="nav-link" href="#">Khóa học</a></li>
                                <c:if test="${loggedIn}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="/home/my-courses/learning">Học tập</a>
                                    </li>
                                </c:if>
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

                                <c:choose>
                                    <c:when test="${loggedIn}">
                                        <a href="/cart" class="position-relative text-dark fs-5" title="Giỏ hàng">
                                            <i class="bi bi-cart3"></i>
                                            <span
                                                class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                                                style="font-size: 10px;">0</span>
                                        </a>

                                        <a href="/notifications" class="position-relative text-dark fs-5"
                                            title="Thông báo">
                                            <i class="bi bi-bell"></i>
                                            <span
                                                class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                                                style="font-size: 10px;">0</span>
                                        </a>

                                        <div class="dropdown">
                                            <button
                                                class="btn btn-light border dropdown-toggle d-flex align-items-center gap-2"
                                                type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                <c:choose>
                                                    <c:when test="${not empty currentUser.avatar}">
                                                        <img src="/images/avatar/${currentUser.avatar}" alt="avatar"
                                                            class="rounded-circle"
                                                            style="width: 32px; height: 32px; object-fit: cover;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="bi bi-person-circle fs-5"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                                <span>${currentUser.fullName}</span>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end">
                                                <li>
                                                    <h6 class="dropdown-header">${currentUser.fullName}</h6>
                                                </li>
                                                <li><a class="dropdown-item" href="/account/profile">Hồ sơ</a></li>
                                                <li><a class="dropdown-item" href="/account/purchase-history">Lịch sử
                                                        mua hàng</a>
                                                </li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li>
                                                    <form action="/logout" method="post" class="px-3">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <button type="submit"
                                                            class="btn btn-link p-0 text-decoration-none">Đăng
                                                            xuất</button>
                                                    </form>
                                                </li>
                                            </ul>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/login" class="btn btn-outline-primary btn-sm">Đăng nhập</a>
                                        <a href="/register" class="btn btn-primary btn-sm">Đăng ký</a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </nav>