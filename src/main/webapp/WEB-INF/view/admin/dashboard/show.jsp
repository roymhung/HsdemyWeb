<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="" />
            <meta name="author" content="" />
            <title>Admin Dashboard</title>
            <link href="/css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        </head>

        <body class="sb-nav-fixed">
            <jsp:include page="../layout/header.jsp" />

            <div id="layoutSidenav">
                <jsp:include page="../layout/sidebar.jsp" />

                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">
                            <div class="admin-page-heading">
                                <div>
                                    <h1 class="mt-4 mb-1">Bảng điều khiển quản trị</h1>
                                    <p class="text-muted mb-4">Trung tâm phân tích người dùng để tối ưu hiệu quả học tập
                                        và chất lượng nội dung.</p>
                                </div>
                            </div>

                            <c:if test="${param.concurrentLogin != null}">
                                <div class="alert alert-warning">
                                    Tài khoản của bạn đang được đăng nhập ở nơi khác. Phiên trước đó đã bị đăng xuất.
                                </div>
                            </c:if>

                            <div class="admin-hero-card mb-4">
                                <div
                                    class="d-flex flex-column flex-lg-row justify-content-between gap-3 align-items-start align-items-lg-center">
                                    <div>
                                        <span class="badge bg-light text-primary mb-2 px-3 py-2 rounded-pill">Learning
                                            Analytics Hub</span>
                                        <h4 class="mb-2">Phân tích hành vi học tập để nâng cao chất lượng đào tạo</h4>
                                        <p class="mb-0 text-white-50">
                                            Dashboard tập trung vào mức độ tham gia của học viên, tỷ lệ thanh toán, phân
                                            bổ category và độ sâu nội dung khóa học.
                                        </p>
                                    </div>
                                    <div class="d-flex gap-2 flex-wrap">
                                        <a href="/admin/purchase" class="btn btn-light btn-sm fw-semibold px-3">
                                            <i class="fas fa-cart-shopping me-1"></i> Xem Lượt mua
                                        </a>
                                        <a href="/admin/order" class="btn btn-outline-light btn-sm fw-semibold px-3">
                                            <i class="fas fa-receipt me-1"></i> Quản lý Đơn hàng
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-xl-3 col-md-6">
                                    <div class="admin-stat-card">
                                        <div class="admin-stat-icon bg-primary-subtle text-primary">
                                            <i class="fas fa-users"></i>
                                        </div>
                                        <div>
                                            <div class="text-muted small">Tổng người dùng</div>
                                            <h4 class="mb-0">${totalUsers}</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6">
                                    <div class="admin-stat-card">
                                        <div class="admin-stat-icon bg-success-subtle text-success">
                                            <i class="fas fa-user-check"></i>
                                        </div>
                                        <div>
                                            <div class="text-muted small">Học viên đã thanh toán</div>
                                            <h4 class="mb-0">${paidLearners}</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6">
                                    <div class="admin-stat-card">
                                        <div class="admin-stat-icon bg-warning-subtle text-warning">
                                            <i class="fas fa-fire"></i>
                                        </div>
                                        <div>
                                            <div class="text-muted small">Học viên hoạt động (30 ngày)</div>
                                            <h4 class="mb-0">${activeLearners30d}</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6">
                                    <div class="admin-stat-card">
                                        <div class="admin-stat-icon bg-danger-subtle text-danger">
                                            <i class="fas fa-wallet"></i>
                                        </div>
                                        <div>
                                            <div class="text-muted small">Doanh thu đã thanh toán (VND)</div>
                                            <h4 class="mb-0">
                                                <fmt:formatNumber value="${paidRevenue}" type="number" groupingUsed="true"
                                                    maxFractionDigits="0" />
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row g-4 mb-4">
                                <div class="col-xl-8">
                                    <div class="card admin-card h-100">
                                        <div class="card-header bg-white border-0 pb-0">
                                            <h5 class="fw-semibold mb-1">
                                                <i class="fas fa-chart-line me-2 text-primary"></i>Xu hướng học viên
                                                hoạt động (6 tháng)
                                            </h5>
                                            <p class="text-muted small mb-0">Số lượng học viên có đơn PAID theo từng
                                                tháng.</p>
                                        </div>
                                        <div class="card-body">
                                            <canvas id="learnerTrendChart" height="95"></canvas>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-4">
                                    <div class="card admin-card h-100">
                                        <div class="card-header bg-white border-0 pb-0">
                                            <h5 class="fw-semibold mb-1">
                                                <i class="fas fa-circle-nodes me-2 text-primary"></i>Tỷ lệ trạng thái
                                                đơn
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <canvas id="statusChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row g-4 mb-4">
                                <div class="col-xl-6">
                                    <div class="card admin-card h-100">
                                        <div class="card-header bg-white">
                                            <h5 class="fw-semibold mb-0">
                                                <i class="fas fa-layer-group me-2 text-primary"></i>Phân bổ lượt mua
                                                theo danh mục
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <canvas id="categoryChart" height="120"></canvas>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-xl-6">
                                    <div class="card admin-card h-100">
                                        <div class="card-header bg-white">
                                            <h5 class="fw-semibold mb-0">
                                                <i class="fas fa-book-open-reader me-2 text-primary"></i>Độ sâu nội dung
                                                khóa học
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <canvas id="depthChart" height="120"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row g-4 mb-4">
                                <div class="col-12">
                                    <div class="card admin-card">
                                        <div class="card-header bg-white">
                                            <h5 class="fw-semibold mb-0"><i
                                                    class="fas fa-lightbulb me-2 text-primary"></i>Gợi ý tối ưu hiệu quả
                                                học tập</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="row g-3">
                                                <div class="col-lg-4">
                                                    <div class="admin-flow-item h-100">
                                                        <div class="admin-flow-dot"><i
                                                                class="fas fa-graduation-cap"></i></div>
                                                        <div>
                                                            <h6 class="mb-1">Số bài học trung bình mỗi khóa</h6>
                                                            <p class="small text-muted mb-0">Trung bình mỗi khóa có
                                                                <strong>${avgLessonsPerCourse}</strong> bài học. Dùng
                                                                chỉ số này để chuẩn hóa khung nội dung giữa các khóa.
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="admin-flow-item h-100">
                                                        <div class="admin-flow-dot"><i class="fas fa-eye"></i></div>
                                                        <div>
                                                            <h6 class="mb-1">Tỷ lệ bài học xem trước</h6>
                                                            <p class="small text-muted mb-0">Tỷ lệ bài học preview hiện
                                                                tại là <strong>${previewRate}%</strong>. Tăng preview ở
                                                                khóa mới giúp cải thiện chuyển đổi mua.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-4">
                                                    <div class="admin-flow-item h-100">
                                                        <div class="admin-flow-dot"><i class="fas fa-chart-simple"></i>
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-1">Ưu tiên hành động</h6>
                                                            <p class="small text-muted mb-0">Ưu tiên tối ưu các category
                                                                có lượt mua cao và các khóa có nội dung mỏng để tăng giữ
                                                                chân người học.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>

                    <jsp:include page="../layout/footer.jsp" />
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                crossorigin="anonymous"></script>
            <script src="/js/scripts.js"></script>
            <script>
                const learnerTrendLabels = [<c:forEach var="l" items="${learnerTrendLabels}" varStatus="s">'${l}'<c:if test="${!s.last}">,</c:if></c:forEach>];
                const learnerTrendData = [<c:forEach var="d" items="${learnerTrendData}" varStatus="s">${d}<c:if test="${!s.last}">,</c:if></c:forEach>];
                const statusLabels = [<c:forEach var="l" items="${statusLabels}" varStatus="s">'${l}'<c:if test="${!s.last}">,</c:if></c:forEach>];
                const statusData = [<c:forEach var="d" items="${statusData}" varStatus="s">${d}<c:if test="${!s.last}">,</c:if></c:forEach>];
                const categoryLabels = [<c:forEach var="l" items="${categoryLabels}" varStatus="s">'${l}'<c:if test="${!s.last}">,</c:if></c:forEach>];
                const categoryData = [<c:forEach var="d" items="${categoryData}" varStatus="s">${d}<c:if test="${!s.last}">,</c:if></c:forEach>];
                const depthLabels = [<c:forEach var="l" items="${depthLabels}" varStatus="s">'${l}'<c:if test="${!s.last}">,</c:if></c:forEach>];
                const depthData = [<c:forEach var="d" items="${depthData}" varStatus="s">${d}<c:if test="${!s.last}">,</c:if></c:forEach>];

                new Chart(document.getElementById('learnerTrendChart'), {
                    type: 'line',
                    data: {
                        labels: learnerTrendLabels,
                        datasets: [{
                            label: 'Active learners',
                            data: learnerTrendData,
                            borderColor: '#2563eb',
                            backgroundColor: 'rgba(37, 99, 235, .18)',
                            fill: true,
                            tension: 0.35
                        }]
                    },
                    options: { scales: { y: { beginAtZero: true } } }
                });

                new Chart(document.getElementById('statusChart'), {
                    type: 'doughnut',
                    data: {
                        labels: statusLabels,
                        datasets: [{
                            data: statusData,
                            backgroundColor: ['#f59e0b', '#10b981', '#ef4444', '#6b7280', '#8b5cf6']
                        }]
                    },
                    options: { plugins: { legend: { position: 'bottom' } } }
                });

                new Chart(document.getElementById('categoryChart'), {
                    type: 'bar',
                    data: {
                        labels: categoryLabels,
                        datasets: [{
                            label: 'Lượt mua',
                            data: categoryData,
                            backgroundColor: 'rgba(14, 165, 233, .75)',
                            borderRadius: 8
                        }]
                    },
                    options: {
                        plugins: { legend: { display: false } },
                        scales: { y: { beginAtZero: true } }
                    }
                });

                new Chart(document.getElementById('depthChart'), {
                    type: 'bar',
                    data: {
                        labels: depthLabels,
                        datasets: [{
                            label: 'Số bài học',
                            data: depthData,
                            backgroundColor: 'rgba(139, 92, 246, .78)',
                            borderRadius: 8
                        }]
                    },
                    options: {
                        indexAxis: 'y',
                        plugins: { legend: { display: false } },
                        scales: { x: { beginAtZero: true } }
                    }
                });
            </script>
        </body>

        </html>