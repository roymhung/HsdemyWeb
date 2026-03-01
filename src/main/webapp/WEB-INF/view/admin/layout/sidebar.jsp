<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
                <c:set var="currentUri" value="${pageContext.request.requestURI}" />
                <c:set var="courseOpen"
                    value="${currentUri == '/admin/course' || currentUri == '/admin/course/create' || fn:startsWith(currentUri, '/admin/course/')}" />
                <c:set var="analyticsOpen" value="${fn:startsWith(currentUri, '/admin/analytics/')}" />

                <div id="layoutSidenav_nav">
                    <nav class="sb-sidenav accordion sb-sidenav-dark admin-sidenav" id="sidenavAccordion">
                        <div class="sb-sidenav-menu">
                            <div class="nav py-2">
                                <div class="sb-sidenav-menu-heading">Tổng quan</div>

                                <a class="nav-link ${currentUri == '/admin' ? 'active' : ''}" href="/admin">
                                    <div class="sb-nav-link-icon"><i class="fas fa-gauge-high"></i></div>
                                    Bảng điều khiển
                                </a>

                                <div class="sb-sidenav-menu-heading">Quản lý</div>

                                <a class="nav-link ${fn:startsWith(currentUri, '/admin/user') ? 'active' : ''}"
                                    href="/admin/user">
                                    <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                                    Người dùng
                                </a>
                                <a class="nav-link ${fn:startsWith(currentUri, '/admin/category') ? 'active' : ''}"
                                    href="/admin/category">
                                    <div class="sb-nav-link-icon"><i class="fas fa-layer-group"></i></div>
                                    Danh mục
                                </a>
                                <a class="nav-link ${fn:startsWith(currentUri, '/admin/order') ? 'active' : ''}"
                                    href="/admin/order">
                                    <div class="sb-nav-link-icon"><i class="fas fa-receipt"></i></div>
                                    Đơn hàng
                                </a>
                                <a class="nav-link ${fn:startsWith(currentUri, '/admin/purchase') ? 'active' : ''}"
                                    href="/admin/purchase">
                                    <div class="sb-nav-link-icon"><i class="fas fa-cart-shopping"></i></div>
                                    Lượt mua
                                </a>

                                <div class="sb-sidenav-menu-heading">Phân tích dữ liệu</div>
                                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                    data-bs-target="#collapseAnalytics" aria-expanded="${analyticsOpen}"
                                    aria-controls="collapseAnalytics">
                                    <div class="sb-nav-link-icon"><i class="fas fa-chart-line"></i></div>
                                    Biểu đồ
                                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                </a>
                                <div class="collapse ${analyticsOpen ? 'show' : ''}" id="collapseAnalytics"
                                    data-bs-parent="#sidenavAccordion">
                                    <nav class="sb-sidenav-menu-nested nav">
                                        <a class="nav-link ${currentUri == '/admin/analytics/revenue' ? 'active' : ''}"
                                            href="/admin/analytics/revenue">
                                            <i class="fas fa-sack-dollar me-2"></i>Doanh thu
                                        </a>
                                        <a class="nav-link ${currentUri == '/admin/analytics/orders' ? 'active' : ''}"
                                            href="/admin/analytics/orders">
                                            <i class="fas fa-circle-nodes me-2"></i>Đơn hàng
                                        </a>
                                        <a class="nav-link ${currentUri == '/admin/analytics/categories' ? 'active' : ''}"
                                            href="/admin/analytics/categories">
                                            <i class="fas fa-layer-group me-2"></i>Danh mục
                                        </a>
                                        <a class="nav-link ${currentUri == '/admin/analytics/purchases' ? 'active' : ''}"
                                            href="/admin/analytics/purchases">
                                            <i class="fas fa-bag-shopping me-2"></i>Lượt mua
                                        </a>
                                    </nav>
                                </div>

                                <div class="sb-sidenav-menu-heading">Xây dựng khóa học</div>
                                <a class="nav-link collapsed ${courseOpen ? '' : ''}" href="#" data-bs-toggle="collapse"
                                    data-bs-target="#collapseCourse" aria-expanded="${courseOpen}"
                                    aria-controls="collapseCourse">
                                    <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                    Khóa học
                                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                </a>
                                <div class="collapse ${courseOpen ? 'show' : ''}" id="collapseCourse"
                                    data-bs-parent="#sidenavAccordion">
                                    <nav class="sb-sidenav-menu-nested nav">
                                        <a class="nav-link ${currentUri == '/admin/course' ? 'active' : ''}"
                                            href="/admin/course">
                                            <i class="fas fa-table me-2"></i>Danh sách khóa học
                                        </a>
                                        <a class="nav-link ${currentUri == '/admin/course/create' ? 'active' : ''}"
                                            href="/admin/course/create">
                                            <i class="fas fa-circle-plus me-2"></i>Thêm khóa học
                                        </a>
                                    </nav>
                                </div>
                            </div>
                        </div>
                        <div class="sb-sidenav-footer">
                            <div class="small">Không gian làm việc</div>
                            Bảng điều khiển quản trị
                        </div>
                    </nav>
                </div>