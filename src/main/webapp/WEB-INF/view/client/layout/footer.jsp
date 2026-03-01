<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!-- Footer -->
                <footer class="bg-black text-white py-5">
                    <div class="container">
                        <div class="row g-4 mb-4">
                            <div class="col-lg-4 col-md-6">
                                <h5 class="fw-bold mb-3 text-primary">
                                    <i class="bi bi-code-slash me-2"></i>Hsudemy
                                </h5>
                                <p class="text-white-50 mb-4">Nền tảng học lập trình trực tuyến hàng đầu Việt Nam.
                                    Giúp bạn phát
                                    triển kỹ năng lập trình từ cơ bản đến nâng cao với các khóa học chất lượng cao.
                                </p>
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
                                    <li class="mb-2"><a href="/courses"
                                            class="text-white-50 text-decoration-none hover-primary">Tất cả khóa
                                            học</a></li>
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Ngoại ngữ</a></li>
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Kỹ năng mềm</a>
                                    </li>
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Kinh doanh &
                                            Marketing</a>
                                    </li>
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Tin học & Thiết
                                            kế</a></li>
                                </ul>
                            </div>
                            <div class="col-lg-2 col-md-6 col-sm-6">
                                <h6 class="fw-bold mb-3 text-primary">Công ty</h6>
                                <ul class="list-unstyled">
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Về
                                            chúng
                                            tôi</a></li>
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Tuyển
                                            dụng</a></li>
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Liên
                                            hệ</a></li>
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Blog</a>
                                    </li>
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Đối
                                            tác</a></li>
                                </ul>
                            </div>
                            <div class="col-lg-2 col-md-6 col-sm-6">
                                <h6 class="fw-bold mb-3 text-primary">Hỗ trợ</h6>
                                <ul class="list-unstyled">
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Trung
                                            tâm
                                            trợ giúp</a></li>
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Chính
                                            sách</a></li>
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Điều
                                            khoản</a></li>
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">FAQ</a>
                                    </li>
                                    <li class="mb-2"><a href="#"
                                            class="text-white-50 text-decoration-none hover-primary">Bảo
                                            mật</a></li>
                                </ul>
                            </div>
                            <div class="col-lg-2 col-md-6 col-sm-6">
                                <h6 class="fw-bold mb-3 text-primary">Đăng ký nhận tin</h6>
                                <p class="text-white-50 small mb-3">Nhận thông tin về khóa học mới và ưu đãi đặc
                                    biệt</p>
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
                                <p class="text-white-50 mb-0 small">&copy; 2024 <span
                                        class="text-primary">Hsudemy</span>. All
                                    rights reserved.</p>
                            </div>
                            <div class="col-md-6 text-md-end">
                                <div class="d-flex justify-content-md-end gap-3">
                                    <a href="#" class="text-white-50 text-decoration-none small hover-primary">Chính
                                        sách bảo
                                        mật</a>
                                    <a href="#" class="text-white-50 text-decoration-none small hover-primary">Điều
                                        khoản sử
                                        dụng</a>
                                    <a href="#"
                                        class="text-white-50 text-decoration-none small hover-primary">Sitemap</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>