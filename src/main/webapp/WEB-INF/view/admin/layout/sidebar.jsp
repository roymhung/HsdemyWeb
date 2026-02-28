<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="currentUri" value="${pageContext.request.requestURI}" />
<c:set var="courseOpen" value="${currentUri == '/admin/course' || currentUri == '/admin/course/create' || fn:startsWith(currentUri, '/admin/course/')}" />

<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark admin-sidenav" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav py-2">
                <div class="sb-sidenav-menu-heading">Overview</div>

                <a class="nav-link ${currentUri == '/admin' ? 'active' : ''}" href="/admin">
                    <div class="sb-nav-link-icon"><i class="fas fa-gauge-high"></i></div>
                    Dashboard
                </a>

                <div class="sb-sidenav-menu-heading">Management</div>

                <a class="nav-link ${fn:startsWith(currentUri, '/admin/user') ? 'active' : ''}" href="/admin/user">
                    <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                    Users
                </a>
                <a class="nav-link ${fn:startsWith(currentUri, '/admin/category') ? 'active' : ''}" href="/admin/category">
                    <div class="sb-nav-link-icon"><i class="fas fa-layer-group"></i></div>
                    Categories
                </a>
                <a class="nav-link ${fn:startsWith(currentUri, '/admin/order') ? 'active' : ''}" href="/admin/order">
                    <div class="sb-nav-link-icon"><i class="fas fa-receipt"></i></div>
                    Orders
                </a>
                <a class="nav-link ${fn:startsWith(currentUri, '/admin/purchase') ? 'active' : ''}" href="/admin/purchase">
                    <div class="sb-nav-link-icon"><i class="fas fa-cart-shopping"></i></div>
                    Purchases
                </a>

                <div class="sb-sidenav-menu-heading">Course Builder</div>
                <a class="nav-link collapsed ${courseOpen ? '' : ''}" href="#" data-bs-toggle="collapse"
                    data-bs-target="#collapseCourse" aria-expanded="${courseOpen}" aria-controls="collapseCourse">
                    <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                    Courses
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                </a>
                <div class="collapse ${courseOpen ? 'show' : ''}" id="collapseCourse" data-bs-parent="#sidenavAccordion">
                    <nav class="sb-sidenav-menu-nested nav">
                        <a class="nav-link ${currentUri == '/admin/course' ? 'active' : ''}" href="/admin/course">
                            <i class="fas fa-table me-2"></i>My Listed Courses
                        </a>
                        <a class="nav-link ${currentUri == '/admin/course/create' ? 'active' : ''}" href="/admin/course/create">
                            <i class="fas fa-circle-plus me-2"></i>Add Course
                        </a>
                    </nav>
                </div>
            </div>
        </div>
        <div class="sb-sidenav-footer">
            <div class="small">Workspace</div>
            Admin Control Panel
        </div>
    </nav>
</div>