<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f6f7fb; }
        .checkout-hero {
            border: 0;
            border-radius: 1rem;
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            color: #fff;
            box-shadow: 0 14px 34px rgba(79, 70, 229, .28);
        }
        .checkout-card {
            border: 1px solid #e5e7eb;
            border-radius: .9rem;
            box-shadow: 0 6px 20px rgba(15, 23, 42, .06);
        }
        .course-thumb {
            width: 100%;
            max-height: 220px;
            object-fit: cover;
            border-radius: .75rem;
        }
        .pay-method-item {
            border: 1px solid #e5e7eb;
            border-radius: .7rem;
            padding: .75rem;
            background: #fff;
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    <div class="container py-5" style="margin-top: 80px; max-width: 1100px;">
        <div class="card checkout-hero mb-4">
            <div class="card-body p-4">
                <h3 class="mb-1">Thanh toán khóa học</h3>
                <p class="mb-0 opacity-75">Bảo mật thanh toán qua cổng VNPAY.</p>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="card checkout-card">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-3">Thông tin khóa học</h5>
                        <div class="row g-3 align-items-center">
                            <div class="col-md-4">
                                <img src="/images/course/${course.thumbnail}" class="course-thumb" alt="${course.name}">
                            </div>
                            <div class="col-md-8">
                                <h5 class="mb-2">${course.name}</h5>
                                <p class="text-muted mb-2">${course.shortDesc}</p>
                                <div class="small text-muted mb-1">Giảng viên: ${course.author}</div>
                                <div class="small text-muted mb-1">Cấp độ:
                                    <c:choose>
                                        <c:when test="${course.level == 'BEGINNER' || course.level == 'beginner' || course.level == 'BIGINNER' || course.level == 'biginner'}">CƠ BẢN</c:when>
                                        <c:when test="${course.level == 'INTERMEDIATE' || course.level == 'intermediate'}">TRUNG CẤP</c:when>
                                        <c:when test="${course.level == 'ADVANCED' || course.level == 'advanced'}">NÂNG CAO</c:when>
                                        <c:otherwise>${course.level}</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <hr class="my-4" />
                        <h6 class="fw-semibold mb-3">Phương thức thanh toán</h6>
                        <div class="pay-method-item mb-2">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <div class="fw-semibold">VNPAY QR / ATM / Thẻ quốc tế</div>
                                    <div class="small text-muted">Thanh toán an toàn qua cổng VNPAY Sandbox</div>
                                </div>
                                <span class="badge bg-primary">VNPAY</span>
                            </div>
                            <div class="small fw-semibold mb-2">Chọn kênh thanh toán</div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="bankCode" id="bankDefault" value="" checked form="vnpay-create-form">
                                <label class="form-check-label" for="bankDefault">Cổng thanh toán VNPAY (khuyến nghị)</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="bankCode" id="bankQr" value="VNPAYQR" form="vnpay-create-form">
                                <label class="form-check-label" for="bankQr">Ứng dụng hỗ trợ VNPAYQR</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="bankCode" id="bankAtm" value="VNBANK" form="vnpay-create-form">
                                <label class="form-check-label" for="bankAtm">Thẻ ATM / tài khoản nội địa</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="bankCode" id="bankInt" value="INTCARD" form="vnpay-create-form">
                                <label class="form-check-label" for="bankInt">Thẻ quốc tế</label>
                            </div>
                            <div class="small fw-semibold mt-3 mb-2">Ngôn ngữ hiển thị</div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="language" id="langVn" value="vn" checked form="vnpay-create-form">
                                <label class="form-check-label" for="langVn">Tiếng Việt</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="language" id="langEn" value="en" form="vnpay-create-form">
                                <label class="form-check-label" for="langEn">English</label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card checkout-card">
                    <div class="card-body p-4">
                        <h6 class="text-muted mb-1">Tổng thanh toán</h6>
                        <h3 class="fw-bold text-primary mb-3">
                            <fmt:formatNumber value="${course.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> ₫
                        </h3>

                        <c:if test="${param.configError == 'true'}">
                            <div class="alert alert-warning py-2 small">
                                VNPAY chưa được cấu hình. Vui lòng thêm thông số vào `application.properties`.
                            </div>
                        </c:if>

                        <c:choose>
                            <c:when test="${vnpayReady}">
                                <form action="/payment/vnpay/create" method="post" id="vnpay-create-form">
                                    <input type="hidden" name="courseId" value="${course.id}">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button class="btn btn-primary w-100 mb-2" type="submit">
                                        Thanh toán với VNPAY
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-secondary w-100 mb-2" type="button" disabled>
                                    Thanh toán với VNPAY
                                </button>
                            </c:otherwise>
                        </c:choose>

                        <a href="/course/${course.id}" class="btn btn-outline-secondary w-100">Quay lại khóa học</a>
                        <div class="small text-muted mt-2">Sau khi thanh toán thành công, bạn sẽ được chuyển vào trang học.</div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <jsp:include page="../layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
