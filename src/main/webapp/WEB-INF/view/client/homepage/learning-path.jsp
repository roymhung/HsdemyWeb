<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lộ trình học tập | Hstudemy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/client/css/style.css">
    <style>
        .page-hero {
            margin-top: 76px;
            background: linear-gradient(120deg, #0f172a 0%, #1e293b 45%, #334155 100%);
            color: #fff;
        }

        .page-hero-kicker {
            text-transform: uppercase;
            letter-spacing: .06em;
            font-size: .78rem;
            font-weight: 600;
            color: rgba(226, 232, 240, .92);
            margin-bottom: .5rem;
        }

        .page-hero-title {
            font-weight: 800;
            margin-bottom: .6rem;
        }

        .page-hero-desc {
            color: rgba(226, 232, 240, .82);
            margin-bottom: 0;
            max-width: 700px;
        }

        .hero-stat {
            border: 1px solid rgba(255, 255, 255, .2);
            background: rgba(255, 255, 255, .08);
            border-radius: .75rem;
            padding: .65rem .8rem;
            text-align: center;
            height: 100%;
        }

        .path-card {
            border: 0;
            border-radius: 1rem;
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.09);
            height: 100%;
        }

        .path-badge {
            font-size: .75rem;
            border-radius: 999px;
            padding: .35rem .7rem;
        }

        .phase-card {
            border: 1px solid #e2e8f0;
            border-radius: 1rem;
            background: #fff;
            height: 100%;
            box-shadow: 0 8px 24px rgba(15, 23, 42, .06);
        }

        .phase-index {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: #eef2ff;
            color: #4f46e5;
            font-weight: 700;
        }
    </style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" />

    <section class="page-hero py-5">
        <div class="container py-4">
            <p class="page-hero-kicker">Định hướng học tập</p>
            <h1 class="page-hero-title">Lộ Trình Học Tập Theo Mục Tiêu</h1>
            <p class="page-hero-desc mb-4">Chọn một lộ trình phù hợp để học đúng thứ tự, tiết kiệm thời gian và tăng tốc kỹ năng.</p>
            <div class="row g-2 g-md-3">
                <div class="col-6 col-md-3">
                    <div class="hero-stat">
                        <div class="fw-bold fs-5">1.200+</div>
                        <div class="small text-white-50">Khóa học</div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="hero-stat">
                        <div class="fw-bold fs-5">6</div>
                        <div class="small text-white-50">Lộ trình chuẩn</div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="hero-stat">
                        <div class="fw-bold fs-5">4.8/5</div>
                        <div class="small text-white-50">Đánh giá học viên</div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="hero-stat">
                        <div class="fw-bold fs-5">24/7</div>
                        <div class="small text-white-50">Học mọi lúc</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 bg-light">
        <div class="container">
            <div class="text-center mb-4">
                <h2 class="fw-bold mb-2">Khung học tập 4 giai đoạn</h2>
                <p class="text-muted mb-0">Áp dụng cho mọi lộ trình để đảm bảo học đúng và học tới nơi.</p>
            </div>
            <div class="row g-3 mb-5">
                <div class="col-md-6 col-lg-3">
                    <div class="phase-card p-3">
                        <span class="phase-index mb-2">1</span>
                        <h6 class="fw-bold">Nền tảng</h6>
                        <p class="small text-muted mb-0">Làm vững kiến thức cơ bản và thuật ngữ trọng tâm.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="phase-card p-3">
                        <span class="phase-index mb-2">2</span>
                        <h6 class="fw-bold">Thực hành</h6>
                        <p class="small text-muted mb-0">Luyện tập có hướng dẫn qua bài tập và mini-project.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="phase-card p-3">
                        <span class="phase-index mb-2">3</span>
                        <h6 class="fw-bold">Ứng dụng</h6>
                        <p class="small text-muted mb-0">Tạo sản phẩm thực tế để tăng khả năng làm việc.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="phase-card p-3">
                        <span class="phase-index mb-2">4</span>
                        <h6 class="fw-bold">Nâng cao</h6>
                        <p class="small text-muted mb-0">Mở rộng chuyên sâu và chuẩn bị cho nghề nghiệp.</p>
                    </div>
                </div>
            </div>

            <div class="text-center mb-4">
                <h3 class="fw-bold mb-2">Lộ trình nổi bật</h3>
                <p class="text-muted mb-0">Bạn có thể bắt đầu từ một lộ trình và mở rộng dần theo mục tiêu cá nhân.</p>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="card path-card p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold mb-0">Web Developer</h5>
                            <span class="badge bg-primary-subtle text-primary path-badge">6-9 tháng</span>
                        </div>
                        <p class="text-muted mb-3">Lộ trình từ HTML/CSS đến Spring Boot và triển khai dự án thực tế.</p>
                        <ul class="text-muted small ps-3 mb-4">
                            <li>Nền tảng Frontend</li>
                            <li>Java Core + OOP</li>
                            <li>Spring MVC / Spring Boot</li>
                        </ul>
                        <a href="/courses?title=IT_DESIGN" class="btn btn-outline-primary mt-auto">Xem khóa học liên quan</a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="card path-card p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold mb-0">Business & Marketing</h5>
                            <span class="badge bg-success-subtle text-success path-badge">4-6 tháng</span>
                        </div>
                        <p class="text-muted mb-3">Tập trung phát triển kỹ năng bán hàng, marketing online và tăng trưởng doanh thu.</p>
                        <ul class="text-muted small ps-3 mb-4">
                            <li>Marketing nền tảng</li>
                            <li>Branding & Content</li>
                            <li>Digital Campaign</li>
                        </ul>
                        <a href="/courses?title=BUSINESS_MARKETING" class="btn btn-outline-success mt-auto">Bắt đầu lộ trình</a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="card path-card p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold mb-0">Ngoại ngữ ứng dụng</h5>
                            <span class="badge bg-warning-subtle text-warning-emphasis path-badge">3-5 tháng</span>
                        </div>
                        <p class="text-muted mb-3">Lộ trình thực hành ngoại ngữ theo bối cảnh công việc và học thuật.</p>
                        <ul class="text-muted small ps-3 mb-4">
                            <li>Phát âm & giao tiếp</li>
                            <li>Từ vựng chuyên ngành</li>
                            <li>Thực hành theo mục tiêu</li>
                        </ul>
                        <a href="/courses?title=LANGUAGE" class="btn btn-outline-warning mt-auto">Khám phá ngay</a>
                    </div>
                </div>
            </div>

            <div class="card border-0 shadow-sm mt-4">
                <div class="card-body p-4 p-md-5">
                    <h4 class="fw-bold mb-3">Gợi ý để học hiệu quả</h4>
                    <div class="row g-3">
                        <div class="col-md-4"><i class="bi bi-check-circle text-success me-2"></i>Đặt mục tiêu theo tuần</div>
                        <div class="col-md-4"><i class="bi bi-check-circle text-success me-2"></i>Học theo thứ tự từ cơ bản</div>
                        <div class="col-md-4"><i class="bi bi-check-circle text-success me-2"></i>Ứng dụng ngay qua dự án nhỏ</div>
                    </div>
                    <div class="mt-4 d-flex flex-wrap gap-2">
                        <a href="/courses" class="btn btn-primary">Khám phá khóa học</a>
                        <a href="/account/profile" class="btn btn-outline-secondary">Cập nhật mục tiêu học</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="../layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
