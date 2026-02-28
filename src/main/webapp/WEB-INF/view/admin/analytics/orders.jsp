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
                        <h5 class="fw-semibold mb-0"><i class="fas fa-chart-pie me-2 text-primary"></i>Order Status Split</h5>
                        <a href="/admin/analytics/categories" class="btn btn-sm btn-outline-primary">Trang tiếp: Categories</a>
                    </div>
                    <div class="card-body d-flex justify-content-center">
                        <div style="max-width: 440px; width: 100%;">
                            <canvas id="orderStatusChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script>
    const statusLabels = [<c:forEach var="l" items="${chartLabels}" varStatus="s">'${l}'<c:if test="${!s.last}">,</c:if></c:forEach>];
    const statusData = [<c:forEach var="d" items="${chartData}" varStatus="s">${d}<c:if test="${!s.last}">,</c:if></c:forEach>];

    new Chart(document.getElementById('orderStatusChart'), {
        type: 'doughnut',
        data: {
            labels: statusLabels,
            datasets: [{
                data: statusData,
                backgroundColor: ['#f59e0b', '#10b981', '#ef4444', '#6b7280', '#8b5cf6']
            }]
        },
        options: {
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });
</script>
</body>
</html>
