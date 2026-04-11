<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Khoá học của tôi</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
            <link rel="stylesheet" href="/client/css/style.css">
            <style>
                .page-hero {
                    margin-top: 76px;
                    background: linear-gradient(120deg, #0f172a 0%, #1e293b 45%, #334155 100%);
                    color: #fff;
                }

                .page-hero-kicker {
                    text-transform: uppercase;
                    letter-spacing: .06em;
                    font-size: .78rem;
                    font-weight: 600;
                    color: rgba(226, 232, 240, .92);
                    margin-bottom: .5rem;
                }

                .page-hero-title {
                    font-weight: 800;
                    margin-bottom: .6rem;
                }

                .page-hero-desc {
                    color: rgba(226, 232, 240, .82);
                    margin-bottom: 0;
                    max-width: 700px;
                }

                .hero-stat {
                    border: 1px solid rgba(255, 255, 255, .18);
                    border-radius: .75rem;
                    background: rgba(255, 255, 255, .08);
                    padding: .72rem .8rem;
                    height: 100%;
                }

                .my-course-card {
                    border-radius: 1rem;
                    overflow: hidden;
                    box-shadow: 0 10px 24px rgba(0, 0, 0, .08);
                    transition: transform .2s ease, box-shadow .2s ease;
                }

                .my-course-card:hover {
                    transform: translateY(-4px);
                    box-shadow: 0 16px 26px rgba(0, 0, 0, .12);
                }

                .my-course-card .card-body {
                    display: flex;
                    flex-direction: column;
                    padding: 1rem;
                }

                .my-course-card .course-name {
                    line-height: 1.35;
                    min-height: 3.6rem;
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    -webkit-box-orient: vertical;
                    overflow: hidden;
                }

                .my-course-card .course-author {
                    min-height: 1.35rem;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .my-course-card .course-level {
                    width: fit-content;
                    font-size: .72rem;
                    font-weight: 600;
                    letter-spacing: .01em;
                }

                .my-course-card .course-action {
                    margin-top: auto;
                }
            </style>
        </head>

        <body>
            <jsp:include page="../layout/header.jsp" />

            <section class="page-hero py-5">
                <div class="container py-4">
                    <p class="page-hero-kicker">Trung tâm học tập</p>
                    <h1 class="page-hero-title">Khoá học của tôi</h1>
                    <p class="page-hero-desc mb-4">Theo dõi tiến độ và tiếp tục học các khóa bạn đã đăng ký.</p>

                </div>
            </section>

            <section class="py-5 bg-light">
                <div class="container">
                    <div class="row g-4">
                        <c:forEach var="course" items="${courses}">
                            <div class="col-lg-4 col-md-6">
                                <div class="card h-100 border-0 shadow-sm my-course-card">
                                    <img src="/images/course/${course.thumbnail}" class="card-img-top"
                                        style="height: 190px; object-fit: cover;" alt="course">
                                    <div class="card-body">
                                        <span
                                            class="badge bg-primary-subtle text-primary border border-primary-subtle mb-2 course-level">
                                            <c:choose>
                                                <c:when
                                                    test="${course.level == 'BEGINNER' || course.level == 'beginner' || course.level == 'BIGINNER' || course.level == 'biginner'}">
                                                    Cơ bản</c:when>
                                                <c:when
                                                    test="${course.level == 'INTERMEDIATE' || course.level == 'intermediate'}">
                                                    Trung cấp</c:when>
                                                <c:when
                                                    test="${course.level == 'ADVANCED' || course.level == 'advanced'}">
                                                    Nâng cao</c:when>
                                                <c:otherwise>${course.level}</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <h5 class="fw-bold course-name mb-2">${course.name}</h5>
                                        <p class="text-muted mb-3 course-author">${course.author}</p>
                                        <div class="course-action">
                                            <a href="/learning/course/${course.id}" class="btn btn-primary w-100">
                                                Vào học ngay
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <c:if test="${totalPages > 1}">
                        <nav class="mt-4" aria-label="My courses pagination">
                            <ul class="pagination justify-content-center mb-0">
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link"
                                        href="${currentPage == 1 ? '#' : '/home/my-courses/learning?page='}${currentPage == 1 ? '' : currentPage - 1}">
                                        Trang trước
                                    </a>
                                </li>

                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="/home/my-courses/learning?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link"
                                        href="${currentPage == totalPages ? '#' : '/home/my-courses/learning?page='}${currentPage == totalPages ? '' : currentPage + 1}">
                                        Trang sau
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>

                    <c:if test="${empty courses}">
                        <div class="alert alert-info mt-4">
                            Bạn chưa có khóa học nào đã thanh toán thành công!
                        </div>
                    </c:if>
                </div>
            </section>

            <jsp:include page="../layout/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="/client/js/main.js"></script>
        </body>

        </html>