<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<nav class="sb-topnav navbar navbar-expand navbar-dark admin-topbar">
    <a class="navbar-brand ps-3 d-flex align-items-center gap-2" href="/admin">
        <span class="admin-brand-dot"></span>
        <span class="fw-bold">HStudy Admin</span>
    </a>

    <button class="btn btn-link btn-sm order-1 order-lg-0 me-3 me-lg-2 text-white" id="sidebarToggle" href="#!">
        <i class="fas fa-bars"></i>
    </button>

    <div class="d-none d-md-flex align-items-center ms-2">
        <span class="badge text-bg-light-subtle admin-topbar-badge">
            <i class="fas fa-shield-halved me-1 text-primary"></i>
            Control Center
        </span>
    </div>

    <ul class="navbar-nav ms-auto align-items-center me-3 me-lg-4">
        <li class="nav-item d-none d-md-block me-3">
            <a href="/" target="_blank" class="btn btn-sm btn-outline-light border-0">
                <i class="fas fa-up-right-from-square me-1"></i> View Site
            </a>
        </li>
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" id="navbarDropdown" href="#"
                role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <c:choose>
                    <c:when test="${not empty currentUser.avatar}">
                        <img src="/images/avatar/${currentUser.avatar}" alt="avatar" class="rounded-circle"
                            style="width: 34px; height: 34px; object-fit: cover; border: 2px solid rgba(255,255,255,.3);">
                    </c:when>
                    <c:otherwise>
                        <span class="admin-avatar-fallback">
                            <i class="fas fa-user fa-fw"></i>
                        </span>
                    </c:otherwise>
                </c:choose>
                <span class="text-white fw-semibold">${currentUser.fullName}</span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0" aria-labelledby="navbarDropdown">
                <li>
                    <h6 class="dropdown-header">${currentUser.fullName}</h6>
                </li>
                <li><a class="dropdown-item" href="/account/profile"><i class="fas fa-id-card me-2 text-primary"></i>Hồ sơ</a></li>
                <li><a class="dropdown-item" href="/home/my-courses/learning"><i class="fas fa-graduation-cap me-2 text-primary"></i>Khóa học của tôi</a></li>
                <li><a class="dropdown-item" href="/account/purchase-history"><i class="fas fa-clock-rotate-left me-2 text-primary"></i>Lịch sử mua hàng</a></li>
                <li>
                    <hr class="dropdown-divider" />
                </li>
                <li>
                    <form action="/logout" method="post" class="px-3">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <button type="submit" class="btn btn-link p-0 text-decoration-none text-danger">
                            <i class="fas fa-right-from-bracket me-1"></i>Đăng xuất
                        </button>
                    </form>
                </li>
            </ul>
        </li>
    </ul>
</nav>