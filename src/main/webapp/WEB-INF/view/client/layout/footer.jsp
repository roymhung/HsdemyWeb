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

                <div id="courseAdvisorWidget" class="course-advisor-widget">
                    <button id="courseAdvisorToggle" type="button" class="course-advisor-toggle" aria-label="Mở tư vấn khóa học">
                        <i class="bi bi-robot"></i>
                        <span>Tư vấn AI</span>
                    </button>

                    <div id="courseAdvisorPanel" class="course-advisor-panel d-none">
                        <div class="course-advisor-header">
                            <div>
                                <h6 class="mb-0 fw-bold">Trợ lý tư vấn khóa học</h6>
                                <small>Hỏi chủ đề, cấp độ, giá mong muốn</small>
                            </div>
                            <button id="courseAdvisorClose" type="button" class="btn btn-sm btn-light">
                                <i class="bi bi-x-lg"></i>
                            </button>
                        </div>

                        <div id="courseAdvisorMessages" class="course-advisor-messages"></div>

                        <div class="course-advisor-quick">
                            <button type="button" class="course-advisor-chip" data-chat-chip="Gợi ý khóa học miễn phí">Miễn phí</button>
                            <button type="button" class="course-advisor-chip" data-chat-chip="Tôi mới bắt đầu, học cơ bản">Cho người mới</button>
                            <button type="button" class="course-advisor-chip" data-chat-chip="Gợi ý khóa học marketing">Marketing</button>
                        </div>

                        <form id="courseAdvisorForm" class="course-advisor-form">
                            <input id="courseAdvisorInput" type="text" maxlength="240"
                                placeholder="Ví dụ: Tôi muốn học Java cơ bản, dưới 2 triệu..." autocomplete="off" />
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-send"></i>
                            </button>
                        </form>
                    </div>
                </div>

                <style>
                    .course-advisor-widget {
                        position: fixed;
                        right: 20px;
                        bottom: 20px;
                        z-index: 1400;
                        display: flex;
                        flex-direction: column;
                        align-items: flex-end;
                        gap: .65rem;
                    }

                    .course-advisor-toggle {
                        border: none;
                        border-radius: 999px;
                        background: linear-gradient(135deg, #6c63ff 0%, #4f46e5 100%);
                        color: #fff;
                        font-weight: 700;
                        padding: .68rem .95rem;
                        display: inline-flex;
                        align-items: center;
                        gap: .45rem;
                        box-shadow: 0 10px 24px rgba(79, 70, 229, .35);
                    }

                    .course-advisor-toggle:hover {
                        filter: brightness(.98);
                    }

                    .course-advisor-panel {
                        width: min(390px, calc(100vw - 28px));
                        max-height: min(72vh, 640px);
                        background: #fff;
                        border-radius: 1rem;
                        border: 1px solid #e6e8ff;
                        box-shadow: 0 18px 42px rgba(17, 24, 39, .2);
                        overflow: hidden;
                        display: flex;
                        flex-direction: column;
                    }

                    .course-advisor-header {
                        background: linear-gradient(135deg, #6c63ff 0%, #4f46e5 100%);
                        color: #fff;
                        padding: .8rem .85rem;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        gap: .8rem;
                    }

                    .course-advisor-header small {
                        color: rgba(255, 255, 255, .86);
                    }

                    .course-advisor-messages {
                        padding: .8rem;
                        display: grid;
                        gap: .6rem;
                        overflow: auto;
                        background: #f8f9ff;
                        min-height: 230px;
                        max-height: 380px;
                    }

                    .course-advisor-msg {
                        max-width: 92%;
                        border-radius: .8rem;
                        padding: .55rem .7rem;
                        font-size: .92rem;
                        line-height: 1.4;
                        white-space: pre-wrap;
                    }

                    .course-advisor-msg.user {
                        margin-left: auto;
                        background: #6c63ff;
                        color: #fff;
                        border-bottom-right-radius: .35rem;
                    }

                    .course-advisor-msg.bot {
                        margin-right: auto;
                        background: #fff;
                        color: #111827;
                        border: 1px solid #e5e7eb;
                        border-bottom-left-radius: .35rem;
                    }

                    .course-advisor-suggest {
                        margin-top: .35rem;
                        border: 1px solid #e5e7eb;
                        background: #fff;
                        border-radius: .75rem;
                        padding: .5rem;
                        display: flex;
                        align-items: center;
                        gap: .55rem;
                    }

                    .course-advisor-thumb {
                        width: 52px;
                        height: 36px;
                        border-radius: .4rem;
                        object-fit: cover;
                        background: #eef2ff;
                        flex: 0 0 52px;
                    }

                    .course-advisor-title {
                        font-size: .86rem;
                        font-weight: 700;
                        color: #111827;
                        line-height: 1.25;
                        margin-bottom: .1rem;
                    }

                    .course-advisor-meta {
                        font-size: .74rem;
                        color: #6b7280;
                    }

                    .course-advisor-link {
                        margin-left: auto;
                        white-space: nowrap;
                        font-size: .78rem;
                        color: #6c63ff;
                        text-decoration: none;
                        font-weight: 700;
                    }

                    .course-advisor-link:hover {
                        color: #4f46e5;
                    }

                    .course-advisor-quick {
                        padding: .5rem .75rem .2rem;
                        display: flex;
                        gap: .45rem;
                        flex-wrap: wrap;
                        border-top: 1px solid #eceff8;
                        background: #fff;
                    }

                    .course-advisor-chip {
                        border: 1px solid #d7dbff;
                        background: #f5f6ff;
                        color: #4f46e5;
                        padding: .2rem .5rem;
                        border-radius: 999px;
                        font-size: .75rem;
                        font-weight: 600;
                    }

                    .course-advisor-form {
                        padding: .65rem .75rem .75rem;
                        display: flex;
                        align-items: center;
                        gap: .5rem;
                        border-top: 1px solid #eceff8;
                        background: #fff;
                    }

                    .course-advisor-form input {
                        flex: 1;
                        border: 1px solid #d6d8e4;
                        border-radius: .65rem;
                        padding: .55rem .7rem;
                        font-size: .9rem;
                        outline: none;
                    }

                    .course-advisor-form input:focus {
                        border-color: #6c63ff;
                        box-shadow: 0 0 0 2px rgba(108, 99, 255, .15);
                    }

                    @media (max-width: 768px) {
                        .course-advisor-widget {
                            right: 12px;
                            bottom: 12px;
                        }

                        .course-advisor-toggle span {
                            display: none;
                        }
                    }
                </style>