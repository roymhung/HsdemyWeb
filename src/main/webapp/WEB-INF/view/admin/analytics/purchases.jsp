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
                <div class="row g-4 mb-4">
                    <div class="col-xl-6">
                        <div class="card admin-card h-100">
                            <div class="card-header bg-white">
                                <h5 class="fw-semibold mb-0"><i class="fas fa-fire me-2 text-primary"></i>Top khóa học mua nhiều</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="topPurchaseChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6">
                        <div class="card admin-card h-100">
                            <div class="card-header bg-white">
                                <h5 class="fw-semibold mb-0"><i class="fas fa-chart-line me-2 text-primary"></i>Xu hướng lượt mua theo tháng</h5>
                            </div>
                            <div class="card-body">
                                <canvas id="purchaseMonthChart"></canvas>
                            </div>
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
    const topCourseLabels = [<c:forEach var="l" items="${topCourseLabels}" varStatus="s">'${l}'<c:if test="${!s.last}">,</c:if></c:forEach>];
    const topCourseData = [<c:forEach var="d" items="${topCourseData}" varStatus="s">${d}<c:if test="${!s.last}">,</c:if></c:forEach>];
    const monthLabels = [<c:forEach var="l" items="${monthLabels}" varStatus="s">'${l}'<c:if test="${!s.last}">,</c:if></c:forEach>];
    const monthData = [<c:forEach var="d" items="${monthData}" varStatus="s">${d}<c:if test="${!s.last}">,</c:if></c:forEach>];

    new Chart(document.getElementById('topPurchaseChart'), {
        type: 'bar',
        data: {
            labels: topCourseLabels,
            datasets: [{
                label: 'Lượt mua',
                data: topCourseData,
                backgroundColor: 'rgba(14, 165, 233, .75)',
                borderRadius: 8
            }]
        },
        options: {
            indexAxis: 'y',
            plugins: { legend: { display: false } },
            scales: { x: { beginAtZero: true } }
        }
    });

    new Chart(document.getElementById('purchaseMonthChart'), {
        type: 'line',
        data: {
            labels: monthLabels,
            datasets: [{
                label: 'Lượt mua (PAID)',
                data: monthData,
                borderColor: '#2563eb',
                backgroundColor: 'rgba(37, 99, 235, .18)',
                fill: true,
                tension: 0.35
            }]
        },
        options: {
            scales: { y: { beginAtZero: true } }
        }
    });
</script>
</body>
</html>
