<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Khoa hoc cua toi</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
            <link rel="stylesheet" href="/client/css/style.css">
        </head>

        <body>
            <jsp:include page="../layout/header.jsp" />

            <section class="py-5 mt-5">
                <div class="container">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="fw-bold mb-0">Khoa hoc cua toi</h2>
                    </div>

                    <div class="row g-4">
                        <c:forEach var="course" items="${courses}">
                            <div class="col-lg-4 col-md-6">
                                <div class="card h-100 border-0 shadow-sm">
                                    <img src="/images/course/${course.thumbnail}" class="card-img-top"
                                        style="height: 190px; object-fit: cover;" alt="course">
                                    <div class="card-body">
                                        <span class="badge bg-primary mb-2">${course.level}</span>
                                        <h5 class="fw-bold">${course.name}</h5>
                                        <p class="text-muted mb-3">${course.author}</p>
                                        <a href="/learning/course/${course.id}" class="btn btn-primary w-100">
                                            Hoc ngay
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <c:if test="${empty courses}">
                        <div class="alert alert-info mt-4">
                            Ban chua co khoa hoc nao da thanh toan thanh cong.
                        </div>
                    </c:if>
                </div>
            </section>

            <jsp:include page="../layout/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>
