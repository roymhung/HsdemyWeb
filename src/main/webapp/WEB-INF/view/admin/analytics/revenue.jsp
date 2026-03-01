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

                            <div class="card admin-card mb-4">
                                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                    <h5 class="fw-semibold mb-0">
                                        <i class="fas fa-chart-column me-2 text-primary"></i>Xu hướng doanh thu
                                    </h5>
                                    <a href="/admin/analytics/orders" class="btn btn-sm btn-outline-primary">
                                        Trang tiếp: Đơn hàng
                                    </a>
                                </div>
                                <div class="card-body">
                                    <canvas id="revenueChart" height="110"></canvas>
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
                const revenueLabels = [<c:forEach var="l" items="${chartLabels}" varStatus="s">'${l}'<c:if test="${!s.last}">,</c:if></c:forEach>];
                const revenueData = [<c:forEach var="d" items="${chartData}" varStatus="s">${d}<c:if test="${!s.last}">,</c:if></c:forEach>];

                new Chart(document.getElementById('revenueChart'), {
                    type: 'bar',
                    data: {
                        labels: revenueLabels,
                        datasets: [{
                            label: 'Doanh thu (VND)',
                            data: revenueData,
                            backgroundColor: 'rgba(37, 99, 235, 0.75)',
                            borderRadius: 8
                        }]
                    },
                    options: {
                        plugins: {
                            legend: { display: false }
                        },
                        scales: {
                            y: { beginAtZero: true }
                        }
                    }
                });
            </script>
        </body>

        </html>