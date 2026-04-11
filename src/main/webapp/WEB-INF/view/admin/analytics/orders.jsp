<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <title>${pageTitle}</title>
            <link href="/css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <style>
                .orders-hero-card {
                    border: 0;
                    border-radius: 1rem;
                    padding: 1.15rem;
                    color: #fff;
                    background: linear-gradient(130deg, #2563eb 0%, #4f46e5 52%, #7c3aed 100%);
                    box-shadow: 0 16px 36px rgba(37, 99, 235, .28);
                }

                .summary-stat-card {
                    border: 1px solid #e5e7eb;
                    border-radius: .9rem;
                    padding: .9rem 1rem;
                    background: #fff;
                }

                .summary-stat-label {
                    color: #64748b;
                    font-size: .82rem;
                    margin-bottom: .2rem;
                }

                .summary-stat-value {
                    font-weight: 800;
                    font-size: 1.4rem;
                    line-height: 1.15;
                }

                .chart-shell {
                    position: relative;
                    width: min(380px, 100%);
                    margin: 0 auto;
                }

                .chart-center-text {
                    position: absolute;
                    inset: 0;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    pointer-events: none;
                }

                .chart-center-text .label {
                    font-size: .78rem;
                    color: #64748b;
                }

                .chart-center-text .value {
                    font-size: 1.9rem;
                    font-weight: 800;
                    color: #0f172a;
                    line-height: 1.1;
                }

                .status-list {
                    display: grid;
                    gap: .75rem;
                }

                .status-item {
                    border: 1px solid #e5e7eb;
                    border-radius: .85rem;
                    padding: .7rem .8rem;
                    background: #fff;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    gap: .75rem;
                }

                .status-left {
                    display: flex;
                    align-items: center;
                    gap: .6rem;
                    min-width: 0;
                }

                .status-dot {
                    width: 11px;
                    height: 11px;
                    border-radius: 50%;
                    flex: 0 0 11px;
                }

                .status-name {
                    font-weight: 600;
                    color: #0f172a;
                    font-size: .9rem;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .status-right {
                    text-align: right;
                    white-space: nowrap;
                }

                .status-count {
                    font-weight: 700;
                    color: #0f172a;
                    font-size: .95rem;
                }

                .status-percent {
                    color: #64748b;
                    font-size: .8rem;
                }
            </style>
        </head>

        <body class="sb-nav-fixed">
            <jsp:include page="../layout/header.jsp" />
            <div id="layoutSidenav">
                <jsp:include page="../layout/sidebar.jsp" />
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">
                            <div class="admin-page-heading">
                                <h1 class="mt-4 mb-1">${pageTitle}</h1>
                                <p class="text-muted mb-4">${pageDescription}</p>
                            </div>

                            <div class="orders-hero-card mb-4">
                                <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                                    <div>
                                        <h5 class="mb-1 fw-bold"><i class="fas fa-chart-pie me-2"></i>Phân tích trạng
                                            thái đơn hàng</h5>
                                        <p class="mb-0 text-white-50">Theo dõi nhanh tỷ lệ đơn thành công, chờ xử lý và
                                            lỗi để tối ưu vận hành.</p>
                                    </div>
                                    <a href="/admin/analytics/categories" class="btn btn-light btn-sm fw-semibold">
                                        Trang tiếp: Danh mục
                                    </a>
                                </div>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-md-4">
                                    <div class="summary-stat-card">
                                        <div class="summary-stat-label">Tổng đơn hàng</div>
                                        <div class="summary-stat-value" id="sumTotalOrders">0</div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="summary-stat-card">
                                        <div class="summary-stat-label">Đơn thành công (PAID)</div>
                                        <div class="summary-stat-value text-success" id="sumPaidOrders">0</div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="summary-stat-card">
                                        <div class="summary-stat-label">Đơn chờ xử lý</div>
                                        <div class="summary-stat-value text-warning" id="sumPendingOrders">0</div>
                                    </div>
                                </div>
                            </div>

                            <div class="card admin-card mb-4">
                                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                    <h5 class="fw-semibold mb-0">
                                        <i class="fas fa-chart-pie me-2 text-primary"></i>Biểu đồ trạng thái đơn hàng
                                    </h5> <a href="/admin/analytics/categories" class="btn btn-sm btn-outline-primary">
                                        Trang tiếp: Danh mục
                                    </a>
                                </div>
                                <div class="card-body">
                                    <div class="row g-4 align-items-center">
                                        <div class="col-lg-6">
                                            <div class="chart-shell">
                                                <canvas id="orderStatusChart"></canvas>
                                                <div class="chart-center-text">
                                                    <div class="label">Tổng đơn</div>
                                                    <div class="value" id="chartTotalCenter">0</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="status-list" id="statusBreakdownList"></div>
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
                const statusLabels = [<c:forEach var="l" items="${chartLabels}" varStatus="s">'${l}'<c:if test="${!s.last}">,</c:if></c:forEach>];
                const statusData = [<c:forEach var="d" items="${chartData}" varStatus="s">${d}<c:if test="${!s.last}">,</c:if></c:forEach>];
                const statusColorMap = {
                    PENDING_PAYMENT: '#f59e0b',
                    PAID: '#10b981',
                    FAILED: '#ef4444',
                    CANCELLED: '#64748b',
                    REFUNDED: '#8b5cf6',
                    FREE_ENROLLED: '#06b6d4'
                };

                const statusLabelMap = {
                    PENDING_PAYMENT: 'Chờ thanh toán',
                    PAID: 'Thành công',
                    FAILED: 'Thất bại',
                    CANCELLED: 'Đã hủy',
                    REFUNDED: 'Hoàn tiền',
                    FREE_ENROLLED: 'Ghi danh miễn phí'
                };

                const totalOrders = statusData.reduce((sum, v) => sum + Number(v || 0), 0);
                const formatPercent = (value) => Number(value || 0).toLocaleString('vi-VN', {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                });
                const paidOrders = statusLabels.reduce((sum, label, idx) =>
                    sum + (label === 'PAID' ? Number(statusData[idx] || 0) : 0), 0);
                const pendingOrders = statusLabels.reduce((sum, label, idx) =>
                    sum + (label === 'PENDING_PAYMENT' ? Number(statusData[idx] || 0) : 0), 0);

                document.getElementById('sumTotalOrders').textContent = totalOrders.toLocaleString('vi-VN');
                document.getElementById('sumPaidOrders').textContent = paidOrders.toLocaleString('vi-VN');
                document.getElementById('sumPendingOrders').textContent = pendingOrders.toLocaleString('vi-VN');
                document.getElementById('chartTotalCenter').textContent = totalOrders.toLocaleString('vi-VN');

                const statusBreakdownList = document.getElementById('statusBreakdownList');
                statusLabels.forEach((code, idx) => {
                    const count = Number(statusData[idx] || 0);
                    const percent = totalOrders === 0 ? 0 : (count * 100) / totalOrders;
                    const color = statusColorMap[code] || '#334155';
                    const label = statusLabelMap[code] || code;
                    const row = document.createElement('div');
                    row.className = 'status-item';
                    row.innerHTML =
                        '<div class="status-left">' +
                        '<span class="status-dot" style="background:' + color + ';"></span>' +
                        '<span class="status-name">' + label + '</span>' +
                        '</div>' +
                        '<div class="status-right">' +
                        '<div class="status-count">' + count.toLocaleString('vi-VN') + ' đơn</div>' +
                        '<div class="status-percent">' + formatPercent(percent) + '%</div>' +
                        '</div>';
                    statusBreakdownList.appendChild(row);
                });

                const chartColors = statusLabels.map(code => statusColorMap[code] || '#334155');
                const chartLabelsVi = statusLabels.map(code => statusLabelMap[code] || code);

                new Chart(document.getElementById('orderStatusChart'), {
                    type: 'doughnut',
                    data: {
                        labels: chartLabelsVi,
                        datasets: [{
                            data: statusData,
                            backgroundColor: chartColors,
                            borderWidth: 0,
                            hoverOffset: 8
                        }]
                    },
                    options: {
                        cutout: '66%',
                        plugins: {
                            legend: { display: false },
                            tooltip: {
                                callbacks: {
                                    label: (ctx) => {
                                        const value = Number(ctx.raw || 0);
                                        const percent = totalOrders === 0 ? 0 : (value * 100) / totalOrders;
                                        return ' ' + ctx.label + ': ' + value.toLocaleString('vi-VN') + ' đơn (' + formatPercent(percent) + '%)';
                                    }
                                }
                            }
                        }
                    }
                });
            </script>
        </body>

        </html>