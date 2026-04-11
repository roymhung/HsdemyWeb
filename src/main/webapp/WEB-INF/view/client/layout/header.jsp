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
                                <li class="nav-item"><a class="nav-link" href="/courses">Khóa học</a></li>
                                <c:if test="${loggedIn}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="/home/my-courses/learning">Học tập</a>
                                    </li>
                                </c:if>
                                <li class="nav-item"><a class="nav-link" href="/learning-path">Lộ trình học tập</a></li>
                                <li class="nav-item"><a class="nav-link" href="/about-us">Về chúng tôi</a></li>
                            </ul>

                            <div class="d-flex align-items-center gap-3">
                                <form action="/" method="get" class="d-none d-md-block position-relative"
                                    id="globalSearchForm" autocomplete="off">
                                    <input class="form-control form-control-sm ps-4" type="search"
                                        id="globalSearchInput" name="q" value="${param.q}"
                                        placeholder="Tìm khóa học, kỹ năng, chứng chỉ..." style="width: 230px;">
                                    <i
                                        class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-2 text-muted"></i>
                                    <div id="globalSearchSuggestions" class="search-suggest-dropdown d-none"></div>
                                </form>

                                <c:choose>
                                    <c:when test="${loggedIn}">
                                        <span class="d-none" data-cart-user-key="${currentUser.id}"></span>
                                        <a href="/cart" class="position-relative text-dark fs-5" title="Giỏ hàng">
                                            <i class="bi bi-cart3"></i>
                                            <span data-cart-badge
                                                class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger d-none"
                                                style="font-size: 10px;">0</span>
                                        </a>

                                        <a href="/notifications" class="position-relative text-dark fs-5"
                                            title="Thông báo">
                                            <i class="bi bi-bell"></i>
                                            <span data-notification-badge class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger 
           ${notificationUnreadCount == 0 ? 'd-none' : ''}" style="font-size: 10px;">
                                                ${notificationUnreadCount}
                                            </span>
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
                                                <li><a class="dropdown-item" href="/home/my-courses/learning">Khóa học
                                                        của tôi</a></li>
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
                <c:if test="${not empty flashMessage}">
                    <div class="container" style="margin-top: 78px;">
                        <div class="alert alert-${empty flashType ? 'info' : flashType} alert-dismissible fade show mb-2"
                            role="alert">
                            ${flashMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"
                                aria-label="Close"></button>
                        </div>
                    </div>
                </c:if>
                <style>
                    .search-suggest-dropdown {
                        position: absolute;
                        left: 0;
                        top: calc(100% + 6px);
                        width: 560px;
                        max-height: 520px;
                        overflow: auto;
                        background: #fff;
                        border: 1px solid #dee2e6;
                        border-radius: .75rem;
                        box-shadow: 0 15px 40px rgba(0, 0, 0, .14);
                        z-index: 1200;
                    }

                    .search-suggest-item {
                        display: flex;
                        align-items: center;
                        gap: .75rem;
                        padding: .65rem .9rem;
                        text-decoration: none;
                        color: #212529;
                        border-bottom: 1px solid #f1f3f5;
                    }

                    .search-suggest-item:hover {
                        background: #f8f9ff;
                    }

                    .search-suggest-item:last-child {
                        border-bottom: none;
                    }

                    .search-suggest-thumb {
                        width: 32px;
                        height: 32px;
                        border-radius: .3rem;
                        object-fit: cover;
                        background: #e9ecef;
                    }

                    .search-suggest-title {
                        font-weight: 600;
                        line-height: 1.2;
                    }

                    .search-suggest-meta {
                        color: #6c757d;
                        font-size: .8rem;
                    }

                    .search-suggest-section {
                        padding: .45rem .9rem;
                        font-size: .75rem;
                        color: #6c757d;
                        text-transform: uppercase;
                        letter-spacing: .02em;
                        background: #f8f9fa;
                        border-top: 1px solid #f1f3f5;
                        border-bottom: 1px solid #f1f3f5;
                    }
                </style>
                <script src="/client/js/search-autocomplete.js"></script>