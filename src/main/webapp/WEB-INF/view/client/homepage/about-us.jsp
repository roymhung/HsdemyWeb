<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Về chúng tôi | Hstudemy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/client/css/style.css">
    <style>
        .page-hero {
            margin-top: 76px;
            background: linear-gradient(120deg, #0f172a 0%, #1e293b 55%, #334155 100%);
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

        .about-card {
            border: 0;
            border-radius: 1rem;
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.08);
            height: 100%;
        }

        .culture-card {
            border: 1px solid #e2e8f0;
            border-radius: 1rem;
            background: #fff;
            height: 100%;
            box-shadow: 0 8px 24px rgba(15, 23, 42, .06);
        }
    </style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" />

    <section class="page-hero py-5">
        <div class="container py-4">
            <p class="page-hero-kicker">Hstudemy</p>
            <h1 class="page-hero-title">Về Chúng Tôi</h1>
            <p class="page-hero-desc mb-4">Nền tảng học trực tuyến tập trung vào tính thực tế, dễ học và dễ áp dụng vào công việc.</p>
            <div class="row g-2 g-md-3">
                <div class="col-6 col-md-3">
                    <div class="hero-stat">
                        <div class="fw-bold fs-5">50.000+</div>
                        <div class="small text-white-50">Học viên</div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="hero-stat">
                        <div class="fw-bold fs-5">1.200+</div>
                        <div class="small text-white-50">Khóa học</div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="hero-stat">
                        <div class="fw-bold fs-5">150+</div>
                        <div class="small text-white-50">Giảng viên</div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="hero-stat">
                        <div class="fw-bold fs-5">4.8/5</div>
                        <div class="small text-white-50">Mức hài lòng</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 bg-light">
        <div class="container">
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card about-card p-4 text-center">
                        <i class="bi bi-mortarboard fs-1 text-primary mb-2"></i>
                        <h5 class="fw-bold">Sứ mệnh</h5>
                        <p class="text-muted mb-0">Giúp mọi người tiếp cận kiến thức chất lượng với chi phí hợp lý.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card about-card p-4 text-center">
                        <i class="bi bi-lightning-charge fs-1 text-warning mb-2"></i>
                        <h5 class="fw-bold">Tầm nhìn</h5>
                        <p class="text-muted mb-0">Trở thành hệ sinh thái học tập trực tuyến đa lĩnh vực hàng đầu Việt Nam.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card about-card p-4 text-center">
                        <i class="bi bi-people fs-1 text-success mb-2"></i>
                        <h5 class="fw-bold">Giá trị cốt lõi</h5>
                        <p class="text-muted mb-0">Thực tiễn, minh bạch, lấy học viên làm trung tâm.</p>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <div class="culture-card p-4">
                        <h5 class="fw-bold mb-3">Cách chúng tôi xây dựng khóa học</h5>
                        <ul class="list-unstyled text-muted mb-0">
                            <li class="mb-2"><i class="bi bi-check2-circle text-primary me-2"></i>Khảo sát nhu cầu thị trường trước khi biên soạn.</li>
                            <li class="mb-2"><i class="bi bi-check2-circle text-primary me-2"></i>Thiết kế lộ trình học từ cơ bản đến ứng dụng.</li>
                            <li class="mb-2"><i class="bi bi-check2-circle text-primary me-2"></i>Kiểm thử nội dung qua nhóm học viên thật.</li>
                            <li><i class="bi bi-check2-circle text-primary me-2"></i>Cập nhật định kỳ theo công nghệ và xu hướng mới.</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="culture-card p-4">
                        <h5 class="fw-bold mb-3">Cam kết với học viên</h5>
                        <ul class="list-unstyled text-muted mb-0">
                            <li class="mb-2"><i class="bi bi-shield-check text-success me-2"></i>Nội dung rõ ràng, có thể học ngay.</li>
                            <li class="mb-2"><i class="bi bi-shield-check text-success me-2"></i>Hỗ trợ giải đáp trong quá trình học.</li>
                            <li class="mb-2"><i class="bi bi-shield-check text-success me-2"></i>Trải nghiệm học mượt trên mọi thiết bị.</li>
                            <li><i class="bi bi-shield-check text-success me-2"></i>Minh bạch thông tin khóa học và lộ trình.</li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-body p-4 p-md-5">
                    <h4 class="fw-bold mb-3">Tại sao học viên chọn Hstudemy?</h4>
                    <div class="row g-3">
                        <div class="col-md-6"><i class="bi bi-check2-circle text-success me-2"></i>Lộ trình rõ ràng theo mục tiêu</div>
                        <div class="col-md-6"><i class="bi bi-check2-circle text-success me-2"></i>Bài giảng dễ hiểu, cập nhật liên tục</div>
                        <div class="col-md-6"><i class="bi bi-check2-circle text-success me-2"></i>Hỗ trợ cộng đồng và phản hồi nhanh</div>
                        <div class="col-md-6"><i class="bi bi-check2-circle text-success me-2"></i>Học mọi lúc trên nhiều thiết bị</div>
                    </div>
                    <div class="mt-4">
                        <a href="/courses" class="btn btn-primary me-2">Khám phá khóa học</a>
                        <a href="/learning-path" class="btn btn-outline-secondary">Xem lộ trình học tập</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="../layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
