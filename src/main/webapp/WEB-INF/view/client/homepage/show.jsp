<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hstudemy - Nền Tảng Học Trực Tuyến Đa Lĩnh Vực</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="/client/css/style.css">
    </head>

    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top shadow-sm">
            <div class="container">
                <a class="navbar-brand fw-bold text-primary" href="index.html">
                    <h1 class="text-primary display-6">Hstudemy</h1>
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link active" href="index.html">Trang chủ</a></li>
                        <li class="nav-item"><a class="nav-link" href="courses.html">Khóa học</a></li>
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

                        <a href="cart.html" class="position-relative text-dark fs-5">
                            <i class="bi bi-cart3"></i>
                            <span
                                class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                                style="font-size: 10px;">2</span>
                        </a>

                        <a href="#" class="btn btn-outline-primary btn-sm">Đăng nhập</a>
                        <a href="#" class="btn btn-primary btn-sm">Đăng ký</a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="hero-section bg-primary text-white py-5 mt-5">
            <div class="container py-5">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <h1 class="display-4 fw-bold mb-4">
                            Học Online Mọi Lĩnh Vực – Phát Triển Bản Thân Toàn Diện
                        </h1>
                        <p class="lead mb-4">
                            Nền tảng học trực tuyến cung cấp hàng ngàn khóa học chất lượng cao
                            về ngoại ngữ, kỹ năng mềm, kinh doanh, tin học, thiết kế và nhiều lĩnh vực khác.
                            Học mọi lúc – mọi nơi – theo tốc độ của bạn.
                        </p>
                        <div class="d-flex gap-3">
                            <a href="courses.html" class="btn btn-light btn-lg">Khám phá khóa học</a>
                            <a href="#" class="btn btn-outline-light btn-lg">Xem lộ trình học tập</a>
                        </div>
                        <div class="mt-4 d-flex align-items-center gap-4">
                            <div>
                                <h3 class="fw-bold mb-0">50,000+</h3>
                                <small>Học viên</small>
                            </div>
                            <div>
                                <h3 class="fw-bold mb-0">1,200+</h3>
                                <small>Khóa học</small>
                            </div>
                            <div>
                                <h3 class="fw-bold mb-0">4.8/5</h3>
                                <small>Đánh giá</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 text-center">
                        <img src="/client/img/anhnen.png" alt="Hero" class="img-fluid rounded-3 shadow-lg">
                    </div>
                </div>
            </div>
        </section>

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


        <!-- Featured Courses Section -->
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
                                <img src="/client/img/anhnen.png" class="card-img-top" alt="Java Spring MVC Course"
                                    style="height: 200px; object-fit: cover;">
                                <span class="badge bg-danger position-absolute top-0 start-0 m-2">Bán chạy</span>
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <span class="badge bg-primary bg-opacity-10 text-primary">Web Development</span>
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
                                    <a href="course-detail.html" class="btn btn-sm btn-primary">Xem chi tiết</a>
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
                                    <a href="course-detail.html" class="btn btn-sm btn-primary">Xem chi tiết</a>
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
                                    <a href="course-detail.html" class="btn btn-sm btn-primary">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

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
                            <p class="text-muted">Nhận chứng chỉ hoàn thành khóa học được công nhận bởi các nhà tuyển
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
                            <p class="text-muted">Truy cập khóa học 24/7 trên mọi thiết bị - máy tính, tablet, điện
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
                            <p class="text-muted">Tham gia cộng đồng học viên và nhận hỗ trợ từ giảng viên và bạn bè</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Footer -->
        <footer class="bg-black text-white py-5">
            <div class="container">
                <div class="row g-4 mb-4">
                    <div class="col-lg-4 col-md-6">
                        <h5 class="fw-bold mb-3 text-primary">
                            <i class="bi bi-code-slash me-2"></i>Hsudemy
                        </h5>
                        <p class="text-white-50 mb-4">Nền tảng học lập trình trực tuyến hàng đầu Việt Nam. Giúp bạn phát
                            triển kỹ năng lập trình từ cơ bản đến nâng cao với các khóa học chất lượng cao.</p>
                        <div class="d-flex gap-3">
                            <a href="#" class="text-white text-decoration-none">
                                <div class="bg-dark rounded-circle d-inline-flex align-items-center justify-content-center"
                                    style="width: 40px; height: 40px;">
                                    <i class="bi bi-facebook"></i>
                                </div>
                            </a>
                            <a href="#" class="text-white text-decoration-none">
                                <div class="bg-dark rounded-circle d-inline-flex align-items-center justify-content-center"
                                    style="width: 40px; height: 40px;">
                                    <i class="bi bi-youtube"></i>
                                </div>
                            </a>
                            <a href="#" class="text-white text-decoration-none">
                                <div class="bg-dark rounded-circle d-inline-flex align-items-center justify-content-center"
                                    style="width: 40px; height: 40px;">
                                    <i class="bi bi-github"></i>
                                </div>
                            </a>
                            <a href="#" class="text-white text-decoration-none">
                                <div class="bg-dark rounded-circle d-inline-flex align-items-center justify-content-center"
                                    style="width: 40px; height: 40px;">
                                    <i class="bi bi-linkedin"></i>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-6">
                        <h6 class="fw-bold mb-3 text-primary">Khóa học</h6>
                        <ul class="list-unstyled">
                            <li class="mb-2"><a href="courses.html"
                                    class="text-white-50 text-decoration-none hover-primary">Tất cả khóa học</a></li>
                            <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none hover-primary">Web
                                    Development</a></li>
                            <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none hover-primary">Mobile
                                    App</a></li>
                            <li class="mb-2"><a href="#"
                                    class="text-white-50 text-decoration-none hover-primary">Backend</a></li>
                            <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none hover-primary">Cloud
                                    &
                                    DevOps</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-6">
                        <h6 class="fw-bold mb-3 text-primary">Công ty</h6>
                        <ul class="list-unstyled">
                            <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none hover-primary">Về
                                    chúng
                                    tôi</a></li>
                            <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none hover-primary">Tuyển
                                    dụng</a></li>
                            <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none hover-primary">Liên
                                    hệ</a></li>
                            <li class="mb-2"><a href="#"
                                    class="text-white-50 text-decoration-none hover-primary">Blog</a>
                            </li>
                            <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none hover-primary">Đối
                                    tác</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-6">
                        <h6 class="fw-bold mb-3 text-primary">Hỗ trợ</h6>
                        <ul class="list-unstyled">
                            <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none hover-primary">Trung
                                    tâm
                                    trợ giúp</a></li>
                            <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none hover-primary">Chính
                                    sách</a></li>
                            <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none hover-primary">Điều
                                    khoản</a></li>
                            <li class="mb-2"><a href="#"
                                    class="text-white-50 text-decoration-none hover-primary">FAQ</a>
                            </li>
                            <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none hover-primary">Bảo
                                    mật</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-6">
                        <h6 class="fw-bold mb-3 text-primary">Đăng ký nhận tin</h6>
                        <p class="text-white-50 small mb-3">Nhận thông tin về khóa học mới và ưu đãi đặc biệt</p>
                        <form>
                            <div class="mb-2">
                                <input type="email"
                                    class="form-control form-control-sm bg-dark border-secondary text-white"
                                    placeholder="Email của bạn">
                            </div>
                            <button type="submit" class="btn btn-primary btn-sm w-100">Đăng ký</button>
                        </form>
                    </div>
                </div>
                <hr class="my-4 border-secondary">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <p class="text-white-50 mb-0 small">&copy; 2024 <span class="text-primary">Hsudemy</span>. All
                            rights reserved.</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <div class="d-flex justify-content-md-end gap-3">
                            <a href="#" class="text-white-50 text-decoration-none small hover-primary">Chính sách bảo
                                mật</a>
                            <a href="#" class="text-white-50 text-decoration-none small hover-primary">Điều khoản sử
                                dụng</a>
                            <a href="#" class="text-white-50 text-decoration-none small hover-primary">Sitemap</a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/client/js/main.js"></script>
    </body>

    </html>