<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
                <!-- Navbar Brand-->

                <a class="navbar-brand ps-3 fs-3" href="/admin">HStudyUdemy</a>
                <!-- Sidebar Toggle-->
                <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
                        class="fas fa-bars"></i></button>
                <!-- Navbar Search-->
                <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                    <a class="navbar-brand ps-3 fs-3" href="/admin">Admin Dashboard</a>
                </form>

                <!-- Navbar-->
                <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" id="navbarDropdown" href="#"
                            role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <c:choose>
                                <c:when test="${not empty currentUser.avatar}">
                                    <img src="/images/avatar/${currentUser.avatar}" alt="avatar" class="rounded-circle"
                                        style="width: 32px; height: 32px; object-fit: cover;">
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-user fa-fw"></i>
                                </c:otherwise>
                            </c:choose>
                            <span class="text-white">${currentUser.fullName}</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                            <li>
                                <h6 class="dropdown-header">${currentUser.fullName}</h6>
                            </li>
                            <li><a class="dropdown-item" href="/account/profile">Hồ sơ</a></li>
                            <li><a class="dropdown-item" href="/account/purchase-history">Lịch sử mua hàng</a></li>
                            <li>
                                <hr class="dropdown-divider" />
                            </li>
                            <li>
                                <form action="/logout" method="post" class="px-3">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" class="btn btn-link p-0 text-decoration-none">Đăng xuất</button>
                                </form>
                            </li>
                        </ul>
                    </li>
                </ul>
            </nav>