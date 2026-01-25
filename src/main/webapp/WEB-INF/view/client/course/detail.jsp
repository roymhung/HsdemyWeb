<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Java Spring MVC - Chi Tiết Khóa Học | DevAcademy</title>

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

                    <!-- Course Header -->
                    <section class="bg-dark text-white mt-5">
                        <div class="container py-5">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item"><a href="index.html"
                                            class="text-white text-decoration-none">Trang
                                            chủ</a></li>
                                    <li class="breadcrumb-item"><a href="courses.html"
                                            class="text-white text-decoration-none">Khóa
                                            học</a></li>
                                    <li class="breadcrumb-item active text-white">Java Spring MVC</li>
                                </ol>
                            </nav>
                        </div>
                    </section>

                    <section class="bg-dark text-white">
                        <div class="container py-5">
                            <div class="row">
                                <div class="col-lg-8">
                                    <h1 class="display-5 fw-bold mb-3">Java Spring MVC - Xây Dựng FullStack Website với
                                        Spring Boot</h1>
                                    <p class="lead mb-4">Học Spring MVC Chưa Từng Dễ Tới Vậy - Master backend
                                        architecture and security.
                                    </p>
                                    <div class="d-flex flex-wrap align-items-center gap-3 mb-3">
                                        <div class="d-flex align-items-center">
                                            <span class="text-warning me-1">
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-fill"></i>
                                                <i class="bi bi-star-half"></i>
                                            </span>
                                            <span class="ms-2">4.6</span>
                                            <span class="text-muted ms-1">(275 đánh giá)</span>
                                        </div>
                                        <span><i class="bi bi-people me-1"></i>1,193 học viên</span>
                                    </div>
                                    <p class="mb-0">Được tạo bởi: <a href="#"
                                            class="text-white text-decoration-none">Hỏi Dân IT
                                            @hoidanit</a></p>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Main Content -->
                    <section class="py-5">
                        <div class="container">
                            <div class="row">
                                <!-- Left Content -->
                                <div class="col-lg-8">
                                    <!-- What You'll Learn -->
                                    <div class="card border-0 shadow-sm mb-4">
                                        <div class="card-body p-4">
                                            <h3 class="fw-bold mb-4">Bạn sẽ học được gì?</h3>
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <div class="d-flex align-items-start">
                                                        <i class="bi bi-check-circle-fill text-success me-2 mt-1"></i>
                                                        <span>Xây dựng niềm đam mê với một ngôn ngữ lập trình
                                                            Java</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="d-flex align-items-start">
                                                        <i class="bi bi-check-circle-fill text-success me-2 mt-1"></i>
                                                        <span>Học Java Spring không khó đến vậy</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="d-flex align-items-start">
                                                        <i class="bi bi-check-circle-fill text-success me-2 mt-1"></i>
                                                        <span>Nắm vững kiến thức của Spring và mô hình MVC</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="d-flex align-items-start">
                                                        <i class="bi bi-check-circle-fill text-success me-2 mt-1"></i>
                                                        <span>Thực hành Spring MVC để tạo một website hoàn chỉnh</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="d-flex align-items-start">
                                                        <i class="bi bi-check-circle-fill text-success me-2 mt-1"></i>
                                                        <span>Debug Ứng Dụng Java Spring Siêu Dễ</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="d-flex align-items-start">
                                                        <i class="bi bi-check-circle-fill text-success me-2 mt-1"></i>
                                                        <span>Học và hiểu rõ cơ chế Spring Security</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Course Content -->
                                    <div class="card border-0 shadow-sm mb-4">
                                        <div class="card-body p-4">
                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                <h3 class="fw-bold mb-0">Nội dung khóa học</h3>
                                                <button class="btn btn-sm btn-outline-primary">Mở rộng tất cả</button>
                                            </div>
                                            <div class="accordion" id="courseAccordion">
                                                <div class="accordion-item">
                                                    <h2 class="accordion-header">
                                                        <button class="accordion-button" type="button"
                                                            data-bs-toggle="collapse" data-bs-target="#section1">
                                                            <div class="d-flex justify-content-between w-100 me-3">
                                                                <span><strong>Phần 1: Giới thiệu & Cài
                                                                        đặt</strong></span>
                                                                <span class="text-muted small">5 bài giảng • 45
                                                                    phút</span>
                                                            </div>
                                                        </button>
                                                    </h2>
                                                    <div id="section1" class="accordion-collapse collapse show"
                                                        data-bs-parent="#courseAccordion">
                                                        <div class="accordion-body">
                                                            <div class="list-group list-group-flush">
                                                                <a href="course-player.html"
                                                                    class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                                                    <div>
                                                                        <i class="bi bi-play-circle me-2"></i>
                                                                        1. Lời chào và giới thiệu khóa học
                                                                    </div>
                                                                    <span class="badge bg-secondary">05:35</span>
                                                                </a>
                                                                <a href="course-player.html"
                                                                    class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                                                    <div>
                                                                        <i class="bi bi-play-circle me-2"></i>
                                                                        2. Hướng dẫn cài đặt môi trường Java
                                                                    </div>
                                                                    <span class="badge bg-secondary">12:10</span>
                                                                </a>
                                                                <a href="course-player.html"
                                                                    class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                                                    <div>
                                                                        <i class="bi bi-play-circle me-2"></i>
                                                                        3. Spring Boot là gì?
                                                                    </div>
                                                                    <span class="badge bg-secondary">08:45</span>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="accordion-item">
                                                    <h2 class="accordion-header">
                                                        <button class="accordion-button collapsed" type="button"
                                                            data-bs-toggle="collapse" data-bs-target="#section2">
                                                            <div class="d-flex justify-content-between w-100 me-3">
                                                                <span><strong>Phần 2: Kiến trúc MVC Cơ
                                                                        bản</strong></span>
                                                                <span class="text-muted small">8 bài giảng • 1 giờ 20
                                                                    phút</span>
                                                            </div>
                                                        </button>
                                                    </h2>
                                                    <div id="section2" class="accordion-collapse collapse"
                                                        data-bs-parent="#courseAccordion">
                                                        <div class="accordion-body">
                                                            <p class="text-muted">Nội dung sẽ được cập nhật...</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="accordion-item">
                                                    <h2 class="accordion-header">
                                                        <button class="accordion-button collapsed" type="button"
                                                            data-bs-toggle="collapse" data-bs-target="#section3">
                                                            <div class="d-flex justify-content-between w-100 me-3">
                                                                <span><strong>Phần 3: Database & JPA</strong></span>
                                                                <span class="text-muted small">12 bài giảng • 2 giờ 45
                                                                    phút</span>
                                                            </div>
                                                        </button>
                                                    </h2>
                                                    <div id="section3" class="accordion-collapse collapse"
                                                        data-bs-parent="#courseAccordion">
                                                        <div class="accordion-body">
                                                            <p class="text-muted">Nội dung sẽ được cập nhật...</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Requirements -->
                                    <div class="card border-0 shadow-sm mb-4">
                                        <div class="card-body p-4">
                                            <h3 class="fw-bold mb-4">Yêu cầu</h3>
                                            <ul class="list-unstyled">
                                                <li class="mb-2"><i class="bi bi-check-circle me-2 text-primary"></i>Có
                                                    hiểu biết về
                                                    Java là một lợi thế</li>
                                                <li class="mb-2"><i class="bi bi-check-circle me-2 text-primary"></i>Có
                                                    kiến thức về cú
                                                    pháp HTML, CSS và Javascript là lợi thế</li>
                                            </ul>
                                        </div>
                                    </div>

                                    <!-- Description -->
                                    <div class="card border-0 shadow-sm mb-4">
                                        <div class="card-body p-4">
                                            <h3 class="fw-bold mb-4">Mô tả</h3>
                                            <p>Spring Framework là công cụ rất nổi tiếng trong cộng đồng Java, và một
                                                trong các tác dụng
                                                của nó là xây dựng một website hoàn chỉnh và chuyên nghiệp.</p>
                                            <p>Bằng cách áp dụng mô hình MVC (Model-View-Controller) và kiến trúc của
                                                Spring giúp chúng
                                                ta tiết kiệm thời gian xây dựng một website.</p>
                                        </div>
                                    </div>

                                    <!-- Instructor -->
                                    <div class="card border-0 shadow-sm">
                                        <div class="card-body p-4">
                                            <h3 class="fw-bold mb-4">Giảng viên</h3>
                                            <div class="d-flex gap-4">
                                                <img src="img/avatar.jpg" alt="Instructor" class="rounded-circle"
                                                    style="width: 100px; height: 100px; object-fit: cover;">
                                                <div>
                                                    <h5 class="fw-bold mb-1"><a href="#"
                                                            class="text-primary text-decoration-none">Hỏi
                                                            Dân IT @hoidanit</a></h5>
                                                    <p class="text-muted mb-3">Expert Fullstack Developer</p>
                                                    <div class="row g-3">
                                                        <div class="col-auto">
                                                            <i class="bi bi-star-fill text-warning"></i>
                                                            <span>4.8 xếp hạng giảng viên</span>
                                                        </div>
                                                        <div class="col-auto">
                                                            <i class="bi bi-people"></i>
                                                            <span>9,056 học viên</span>
                                                        </div>
                                                        <div class="col-auto">
                                                            <i class="bi bi-play-circle"></i>
                                                            <span>18 khóa học</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Right Sidebar -->
                                <div class="col-lg-4">
                                    <div class="card border-0 shadow-lg sticky-top" style="top: 80px;">
                                        <div class="position-relative">
                                            <img src="https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800&h=450&fit=crop"
                                                class="card-img-top" alt="Java Spring MVC Course Preview"
                                                style="height: 200px; object-fit: cover;">
                                            <div class="position-absolute top-50 start-50 translate-middle">
                                                <button class="btn btn-light btn-lg rounded-circle"
                                                    data-bs-toggle="modal" data-bs-target="#previewModal">
                                                    <i class="bi bi-play-fill fs-3"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body p-4">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <h3 class="fw-bold mb-0 text-primary">699.000đ</h3>
                                            </div>
                                            <a href="course-player.html" class="btn btn-primary w-100 btn-lg mb-3">Vào
                                                học ngay</a>
                                            <p class="text-center text-muted small mb-4">Đảm bảo hoàn tiền trong 30 ngày
                                            </p>
                                            <div>
                                                <h6 class="fw-bold mb-3">Khóa học này bao gồm:</h6>
                                                <ul class="list-unstyled">
                                                    <li class="mb-2"><i class="bi bi-play-circle me-2"></i>30,5 giờ
                                                        video theo yêu cầu
                                                    </li>
                                                    <li class="mb-2"><i class="bi bi-file-text me-2"></i>3 bài viết</li>
                                                    <li class="mb-2"><i class="bi bi-phone me-2"></i>Truy cập trên thiết
                                                        bị di động và
                                                        TV</li>
                                                    <li class="mb-2"><i class="bi bi-award me-2"></i>Giấy chứng nhận
                                                        hoàn thành</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Preview Modal -->
                    <div class="modal fade" id="previewModal" tabindex="-1">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Xem trước khóa học</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body p-0">
                                    <div class="ratio ratio-16x9">
                                        <iframe src="https://www.youtube.com/embed/dQw4w9WgXcQ"
                                            allowfullscreen></iframe>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Start footer -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- End footer -->

                    <!-- Bootstrap JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <!-- Custom JS -->
                    <script src="js/main.js"></script>
                </body>

                </html>