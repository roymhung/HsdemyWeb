<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="/client/css/style.css">
        <style>
            body.cart-page-shell {
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            .cart-page-main {
                flex: 1 0 auto;
            }

            .cart-page-title {
                font-size: clamp(1.9rem, 2.7vw, 2.5rem);
                font-weight: 900;
            font-family: "Roboto", sans-serif;
                letter-spacing: -0.02em;
                color: #1f2937;
                display: inline-flex;
                align-items: center;
                gap: .6rem;
                margin-bottom: .5rem;
            }

            .cart-page-title-icon {
                width: 2.05rem;
                height: 2.05rem;
                border-radius: .55rem;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                background: #eef2ff;
                color: #6c63ff;
                font-size: 1.05rem;
            }

            .cart-page-subtitle {
                color: #6b7280;
                font-size: .95rem;
                margin-bottom: 1.35rem;
            }

            .cart-course-item {
                border-top: 1px solid #eceff4;
                padding: 1rem 0;
            }

            .cart-thumb {
                width: 130px;
                height: 74px;
                object-fit: cover;
                border-radius: .35rem;
                border: 1px solid #e5e7eb;
            }

            .cart-summary-box {
                border: 1px solid #e5e7eb;
                border-radius: .75rem;
                padding: 1rem;
                position: sticky;
                top: 90px;
            }

            .cart-empty-state {
                border-top: 1px solid #eceff4;
                padding: 2.2rem 0 2.5rem;
                color: #6b7280;
                font-style: italic;
                font-size: .98rem;
            }
        </style>
    </head>

    <body data-page="cart" class="cart-page-shell">
        <jsp:include page="../layout/header.jsp" />

        <section class="cart-page-main py-5 mt-5">
            <div class="container">
                <h1 class="cart-page-title">
                    <span class="cart-page-title-icon"><i class="bi bi-cart3"></i></span>
                    Giỏ hàng
                </h1>
                <p class="cart-page-subtitle">Quản lý khóa học bạn muốn thanh toán trong một lần.</p>

                <div data-cart-empty class="cart-empty-state">
                    Giỏ hàng của bạn trống - hãy thay đổi điều đó. Bằng việc học thêm kỹ năng mới!
                </div>

                <div data-cart-list class="d-none">
                    <div class="row g-4">
                        <div class="col-lg-8">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="mb-0"><span data-cart-count-label>0</span> khóa học trong giỏ hàng</h6>
                            </div>
                            <div data-cart-items></div>
                        </div>

                        <div class="col-lg-4">
                            <div class="cart-summary-box">
                                <div class="text-muted">Tổng:</div>
                                <div class="fw-bold fs-2 mb-2" data-cart-total>0 đ</div>
                                <button class="btn btn-primary w-100 mb-2" type="button" data-action="checkout-cart">
                                    Tiến hành thanh toán
                                </button>
                                <button class="btn btn-outline-secondary w-100" type="button" data-action="clear-cart">
                                    Hủy đơn hàng
                                </button>
                                <div class="small text-muted mt-2">Bạn sẽ không bị tính phí ngay bây giờ</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <jsp:include page="../layout/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/client/js/main.js"></script>
    </body>

    </html>