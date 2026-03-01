<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Không có quyền truy cập | Hstudemy</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="/client/css/style.css">

    <style>
        .access-denied-wrapper {
            min-height: calc(100vh - 220px);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .access-denied-card {
            max-width: 640px;
            border: 0;
            border-radius: 1.25rem;
            box-shadow: 0 16px 40px rgba(0, 0, 0, 0.08);
        }

        .access-denied-icon {
            width: 86px;
            height: 86px;
            border-radius: 50%;
            margin: 0 auto 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #fff3cd;
            color: #996a00;
            font-size: 2rem;
        }
    </style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" />

    <main class="container access-denied-wrapper pt-5">
        <div class="card access-denied-card w-100">
            <div class="card-body p-4 p-md-5 text-center">
                <div class="access-denied-icon">
                    <i class="bi bi-shield-lock-fill"></i>
                </div>

                <div class="badge bg-warning-subtle text-warning-emphasis mb-3 px-3 py-2 rounded-pill">
                    Lỗi truy cập 403
                </div>

                <h1 class="h3 fw-bold mb-3">Bạn không có quyền truy cập trang này</h1>
                <p class="text-muted mb-4">
                    Tài khoản hiện tại không có quyền vào khu vực quản trị.
                    Nếu bạn cần quyền truy cập, vui lòng liên hệ quản trị viên hệ thống.
                </p>

                <div class="d-flex flex-column flex-sm-row justify-content-center gap-2">
                    <a href="/" class="btn btn-primary px-4">
                        <i class="bi bi-house-door me-1"></i> Về trang chủ
                    </a>
                    <button type="button" class="btn btn-outline-secondary px-4" onclick="history.back()">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại
                    </button>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../layout/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
