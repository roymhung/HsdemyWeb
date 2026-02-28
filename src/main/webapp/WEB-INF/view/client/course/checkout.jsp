<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán khóa học</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    <div class="container py-5" style="margin-top: 80px;">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-4 p-lg-5">
                        <h2 class="fw-bold mb-3">Trang thanh toán khóa học</h2>
                        <p class="text-muted mb-4">Chức năng thanh toán đang được hoàn thiện. Tạm thời giữ trang này theo luồng nghiệp vụ.</p>
                        <div class="border rounded p-3 mb-4">
                            <h5 class="mb-2">${course.name}</h5>
                            <p class="mb-2 text-muted">${course.shortDesc}</p>
                            <strong class="text-primary">
                                <fmt:formatNumber value="${course.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> ₫
                            </strong>
                        </div>
                        <div class="d-flex gap-2">
                            <a href="/course/${course.id}" class="btn btn-outline-secondary">Quay lại khóa học</a>
                            <button class="btn btn-primary" disabled>Thanh toán (sắp có)</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
