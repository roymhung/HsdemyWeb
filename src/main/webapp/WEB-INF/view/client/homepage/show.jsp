<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Hstudemy - Nền Tảng Học Trực Tuyến Đa Lĩnh Vực</title>

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
                </head>

                <body>
                    <!-- Start Header -->
                    <jsp:include page="../layout/header.jsp" />
                    <!-- End Header -->

                    <!-- Start banner -->
                    <jsp:include page="../layout/banner.jsp" />
                    <!-- End banner -->

                    <!-- Categories -->
                    <section class="py-5">
                        <div class="container">
                            <h2 class="text-center fw-bold mb-5">Khám Phá Theo Chủ Đề</h2>
                            <div class="row g-4">
                                <div class="col-md-3 col-sm-6">
                                    <div class="card h-100 border-0 shadow-sm text-center p-4">
                                        <i class="bi bi-translate fs-1 text-primary mb-3"></i>
                                        <h5 class="fw-bold">Ngoại ngữ</h5>
                                        <p class="text-muted small mb-0">Tiếng Anh, TOEIC, IELTS, Nhật, Hàn</p>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="card h-100 border-0 shadow-sm text-center p-4">
                                        <i class="bi bi-people fs-1 text-success mb-3"></i>
                                        <h5 class="fw-bold">Kỹ năng mềm</h5>
                                        <p class="text-muted small mb-0">Giao tiếp, thuyết trình, làm việc nhóm</p>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="card h-100 border-0 shadow-sm text-center p-4">
                                        <i class="bi bi-briefcase fs-1 text-info mb-3"></i>
                                        <h5 class="fw-bold">Kinh doanh & Marketing</h5>
                                        <p class="text-muted small mb-0">Marketing online, bán hàng, thương hiệu</p>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <div class="card h-100 border-0 shadow-sm text-center p-4">
                                        <i class="bi bi-laptop fs-1 text-warning mb-3"></i>
                                        <h5 class="fw-bold">Tin học & Thiết kế</h5>
                                        <p class="text-muted small mb-0">Excel, PowerPoint, Canva, Photoshop</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>


                    <!-- Start feature -->
                    <!-- Featured Courses Section -->
                    <section class="py-5 bg-light">
                        <div class="container">
                            <div class="d-flex justify-content-between align-items-center mb-5">
                                <h2 class="fw-bold mb-0">Khóa Học Nổi Bật</h2>
                                <a href="courses.html" class="btn btn-outline-primary">Xem tất cả <i
                                        class="bi bi-arrow-right"></i></a>
                            </div>
                            <div class="row g-4">

                                <c:forEach var="course" items="${courses}">
                                    <div class="col-lg-4 col-md-6">
                                        <div class="card course-card h-100 border-0 shadow-sm">
                                            <div class="position-relative">
                                                <img src="/images/course/${course.thumbnail}" class="card-img-top"
                                                    alt="course" style="height: 200px; object-fit: cover;">
                                                <span class="badge bg-danger position-absolute top-0 start-0 m-2">
                                                    ${course.createdAt.toString().substring(8,10)}/${course.createdAt.toString().substring(5,7)}/${course.createdAt.toString().substring(0,4)}
                                                </span>

                                            </div>
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-start mb-2">
                                                    <span
                                                        class="badge bg-primary bg-opacity-10 text-primary">${course.level}</span>
                                                    <a href="/cart/add/${course.id}" class="btn btn-sm btn-warning">
                                                        <i class="bi bi-cart-plus"></i>
                                                        Thêm vào giỏ
                                                    </a>
                                                </div>
                                                <h5 class="card-title fw-bold">${course.name}</h5>
                                                <p class="text-muted small mb-2">${course.author}</p>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <span class="fw-bold text-primary fs-5">
                                                            <fmt:formatNumber value="${course.price}" type="number"
                                                                groupingUsed="true" maxFractionDigits="0" />
                                                            ₫
                                                        </span>
                                                    </div>
                                                    <a href="/course/${course.id}" class="btn btn-sm btn-primary">Xem
                                                        chi
                                                        tiết</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>
                        </div>
                    </section>
                    <!-- End feature -->


                    <!-- Why Choose Us Section -->
                    <section class="py-5">
                        <div class="container">
                            <h2 class="text-center fw-bold mb-5">Tại Sao Chọn Hsudemy?</h2>
                            <div class="row g-4">
                                <div class="col-md-4">
                                    <div class="text-center">
                                        <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                            style="width: 80px; height: 80px;">
                                            <i class="bi bi-award text-primary fs-1"></i>
                                        </div>
                                        <h5 class="fw-bold">Chứng chỉ được công nhận</h5>
                                        <p class="text-muted">Nhận chứng chỉ hoàn thành khóa học được công nhận bởi các
                                            nhà tuyển
                                            dụng
                                        </p>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="text-center">
                                        <div class="bg-success bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                            style="width: 80px; height: 80px;">
                                            <i class="bi bi-clock-history text-success fs-1"></i>
                                        </div>
                                        <h5 class="fw-bold">Học mọi lúc mọi nơi</h5>
                                        <p class="text-muted">Truy cập khóa học 24/7 trên mọi thiết bị - máy tính,
                                            tablet, điện
                                            thoại
                                        </p>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="text-center">
                                        <div class="bg-info bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                            style="width: 80px; height: 80px;">
                                            <i class="bi bi-people text-info fs-1"></i>
                                        </div>
                                        <h5 class="fw-bold">Cộng đồng hỗ trợ</h5>
                                        <p class="text-muted">Tham gia cộng đồng học viên và nhận hỗ trợ từ giảng viên
                                            và bạn bè</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Start footer -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- End footer -->


                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/js/main.js"></script>
                </body>

                </html>