<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!-- Featured Courses Section -->
                <section class="py-5 bg-light">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-center mb-5">
                            <h2 class="fw-bold mb-0">Khóa Học Nổi Bật</h2>
                            <a href="/courses" class="btn btn-outline-primary">Xem tất cả <i
                                    class="bi bi-arrow-right"></i></a>
                        </div>
                        <div class="row g-4">

                            <div class="col-lg-4 col-md-6">
                                <div class="card course-card h-100 border-0 shadow-sm">
                                    <div class="position-relative">
                                        <img src="/client/img/anhnen.png" class="card-img-top"
                                            alt="Java Spring MVC Course" style="height: 200px; object-fit: cover;">
                                        <span class="badge bg-danger position-absolute top-0 start-0 m-2">Bán
                                            chạy</span>
                                    </div>

                                </div>
                            </div>

                            <div class="col-lg-4 col-md-6">
                                <div class="card course-card h-100 border-0 shadow-sm">
                                    <div class="position-relative">
                                        <img src="/client/img/excel.png" class="card-img-top" alt="React Course"
                                            style="height: 200px; object-fit: cover;">
                                        <span class="badge bg-success position-absolute top-0 start-0 m-2">Mới</span>
                                    </div>

                                </div>
                            </div>

                            <div class="col-lg-4 col-md-6">
                                <div class="card course-card h-100 border-0 shadow-sm">
                                    <div class="position-relative">
                                        <img src="/client/img/c_sharp_lv1.png" class="card-img-top"
                                            alt="Python Data Science Course" style="height: 200px; object-fit: cover;">
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>
                </section>