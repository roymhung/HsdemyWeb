<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả thanh toán</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    <div class="container py-5" style="margin-top: 80px; max-width: 760px;">
        <div class="card border-0 shadow-sm">
            <div class="card-body p-4 p-lg-5">
                <c:choose>
                    <c:when test="${success}">
                        <div class="text-success fs-1 mb-3"><i class="bi bi-check-circle-fill"></i></div>
                        <h3 class="fw-bold mb-2">Thanh toán thành công</h3>
                        <p class="text-muted mb-4">Giao dịch VNPAY đã hoàn tất. Bạn có thể bắt đầu học ngay.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="text-danger fs-1 mb-3"><i class="bi bi-x-circle-fill"></i></div>
                        <h3 class="fw-bold mb-2">Thanh toán thất bại</h3>
                        <p class="text-muted mb-4">Giao dịch chưa thành công hoặc bị hủy. Vui lòng thử lại.</p>
                    </c:otherwise>
                </c:choose>

                <div class="border rounded p-3 bg-light mb-4">
                    <div class="small text-muted">Mã đơn hàng</div>
                    <div class="fw-semibold mb-2">#${orderId}</div>
                    <div class="small text-muted">Mã giao dịch</div>
                    <div class="fw-semibold mb-2">${txnRef}</div>
                    <div class="small text-muted">Response code</div>
                    <div class="fw-semibold">${responseCode}</div>
                </div>

                <div class="d-flex gap-2">
                    <a href="/home/my-courses/learning" class="btn btn-primary">Vào học ngay</a>
                    <a href="/" class="btn btn-outline-secondary">Về trang chủ</a>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <c:if test="${success and not empty purchasedCourseId}">
        <script>
            (function() {
                const CART_KEY = 'devacademy_cart';
                const purchasedCourseId = '${purchasedCourseId}';
                try {
                    const raw = localStorage.getItem(CART_KEY);
                    const items = raw ? JSON.parse(raw) : [];
                    if (Array.isArray(items)) {
                        const nextItems = items.filter(function(item) {
                            return String(item && item.id) !== String(purchasedCourseId);
                        });
                        localStorage.setItem(CART_KEY, JSON.stringify(nextItems));
                    }
                } catch (e) {
                    // no-op
                }
            })();
        </script>
    </c:if>
</body>
</html>
