<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Lich su mua hang</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                <link rel="stylesheet" href="/client/css/style.css">
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <section class="py-5 mt-5">
                    <div class="container">
                        <h2 class="fw-bold mb-4">Lich su mua hang</h2>

                        <div class="table-responsive">
                            <table class="table table-bordered align-middle">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Ngay tao</th>
                                        <th>Trang thai</th>
                                        <th>Tong tien</th>
                                        <th>Khoa hoc</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td>${order.id}</td>
                                            <td>${order.createdAt}</td>
                                            <td>${order.status}</td>
                                            <td>
                                                <fmt:formatNumber value="${order.totalPrice}" type="number"
                                                    groupingUsed="true" maxFractionDigits="0" />
                                                ₫
                                            </td>
                                            <td>
                                                <c:forEach var="detail" items="${order.orderDetails}">
                                                    <div>
                                                        - ${detail.course.name}
                                                    </div>
                                                </c:forEach>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty orders}">
                                        <tr>
                                            <td colspan="5" class="text-center">Chua co don hang nao.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>

                <jsp:include page="../layout/footer.jsp" />
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>
