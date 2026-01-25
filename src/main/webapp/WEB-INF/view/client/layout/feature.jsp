<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!-- Featured Courses Section -->
                <section class="py-5 bg-light">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-center mb-5">
                            <h2 class="fw-bold mb-0">Khóa Học Nổi Bật</h2>
                            <a href="courses.html" class="btn btn-outline-primary">Xem tất cả <i
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
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <span class="badge bg-primary bg-opacity-10 text-primary">Web
                                                Development</span>
                                            <div class="text-warning">
                                                <i class="bi bi-star-fill"></i>
                                                <span class="text-dark small">4.8</span>
                                            </div>
                                        </div>
                                        <h5 class="card-title fw-bold">Java Spring MVC - FullStack Website</h5>
                                        <p class="text-muted small mb-2">Hỏi Dân IT</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="fw-bold text-primary fs-5">699.000đ</span>
                                            </div>
                                            <a href="course-detail.html" class="btn btn-sm btn-primary">Xem chi
                                                tiết</a>
                                        </div>
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
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <span class="badge bg-primary bg-opacity-10 text-primary">React</span>
                                            <div class="text-warning">
                                                <i class="bi bi-star-fill"></i>
                                                <span class="text-dark small">4.9</span>
                                            </div>
                                        </div>
                                        <h5 class="card-title fw-bold">React Complete Guide 2024</h5>
                                        <p class="text-muted small mb-2">Maximilian Schwarzmüller</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="fw-bold text-primary fs-5">899.000đ</span>
                                            </div>
                                            <a href="course-detail.html" class="btn btn-sm btn-primary">Xem chi
                                                tiết</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-6">
                                <div class="card course-card h-100 border-0 shadow-sm">
                                    <div class="position-relative">
                                        <img src="/client/img/c_sharp_lv1.png" class="card-img-top"
                                            alt="Python Data Science Course" style="height: 200px; object-fit: cover;">
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <span class="badge bg-primary bg-opacity-10 text-primary">Python</span>
                                            <div class="text-warning">
                                                <i class="bi bi-star-fill"></i>
                                                <span class="text-dark small">4.7</span>
                                            </div>
                                        </div>
                                        <h5 class="card-title fw-bold">Python for Data Science</h5>
                                        <p class="text-muted small mb-2">Jose Portilla</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="fw-bold text-primary fs-5">599.000đ</span>
                                                <span
                                                    class="text-muted text-decoration-line-through small ms-2">1.299.000đ</span>
                                            </div>
                                            <a href="course-detail.html" class="btn btn-sm btn-primary">Xem chi
                                                tiết</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </section>