<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Tất cả khóa học | Hstudemy</title>

                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                    rel="stylesheet">
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

                    .filter-card {
                        position: sticky;
                        top: 92px;
                        border: 0;
                        border-radius: 1rem;
                        box-shadow: 0 12px 30px rgba(0, 0, 0, .08);
                    }

                    .course-card {
                        border: 0;
                        border-radius: .9rem;
                        box-shadow: 0 8px 24px rgba(0, 0, 0, .07);
                        transition: transform .18s ease, box-shadow .18s ease;
                    }

                    .course-card:hover {
                        transform: translateY(-4px);
                        box-shadow: 0 14px 26px rgba(0, 0, 0, .12);
                    }
                </style>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <section class="page-hero py-5">
                    <div class="container py-4">
                        <p class="page-hero-kicker">Trang chủ / Khóa học</p>
                        <h1 class="page-hero-title">Tất Cả Khóa Học</h1>
                        <p class="page-hero-desc">
                            Khám phá danh sách khóa học phù hợp với nhu cầu của bạn.
                        </p>
                    </div>
                </section>

                <section class="py-5 bg-light">
                    <div class="container">
                        <div class="row g-4">
                            <div class="col-lg-3">
                                <div class="card filter-card">
                                    <div class="card-body p-3 p-md-4">
                                        <h5 class="fw-bold mb-3"><i class="bi bi-funnel me-2"></i>Bộ lọc</h5>
                                        <form method="get" action="/courses">
                                            <div class="mb-3">
                                                <label class="form-label fw-semibold">Từ khóa</label>
                                                <input type="text" class="form-control" name="q"
                                                    value="${selectedKeyword}"
                                                    placeholder="Tên khóa học, giảng viên...">
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label fw-semibold">Trình độ</label>
                                                <select class="form-select" name="level">
                                                    <option value="">Tất cả</option>
                                                    <c:forEach var="item" items="${levels}">
                                                        <option value="${item}" ${selectedLevel==item ? 'selected' : ''
                                                            }>
                                                            <c:choose>
                                                                <c:when test="${item == 'BEGINNER' || item == 'beginner' || item == 'BIGINNER' || item == 'biginner'}">Cơ bản</c:when>
                                                                <c:when test="${item == 'INTERMEDIATE' || item == 'intermediate'}">Trung cấp</c:when>
                                                                <c:when test="${item == 'ADVANCED' || item == 'advanced'}">Nâng cao</c:when>
                                                                <c:otherwise>${item}</c:otherwise>
                                                            </c:choose>
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label fw-semibold">Chủ đề</label>
                                                <select class="form-select" name="title">
                                                    <option value="">Tất cả</option>
                                                    <c:forEach var="item" items="${titles}">
                                                        <option value="${item}" ${selectedTitle==item ? 'selected' : ''
                                                            }>${item}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label fw-semibold">Giá</label>
                                                <select class="form-select" name="priceRange">
                                                    <option value="ALL" ${selectedPriceRange=='ALL' ? 'selected' : '' }>
                                                        Tất cả</option>
                                                    <option value="PAID" ${selectedPriceRange=='PAID'
                                                        ? 'selected' : '' }>Có phí</option>
                                                    <option value="FREE" ${selectedPriceRange=='FREE'
                                                        ? 'selected' : '' }>Miễn phí</option>
                                                </select>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label fw-semibold">Sắp xếp</label>
                                                <select class="form-select" name="sort">
                                                    <option value="newest" ${selectedSort=='newest' ? 'selected' : '' }>
                                                        Mới nhất
                                                    </option>
                                                    <option value="price-asc" ${selectedSort=='price-asc' ? 'selected'
                                                        : '' }>Giá tăng
                                                        dần</option>
                                                    <option value="price-desc" ${selectedSort=='price-desc' ? 'selected'
                                                        : '' }>Giá giảm
                                                        dần</option>
                                                </select>
                                            </div>

                                            <div class="d-grid gap-2">
                                                <button type="submit" class="btn btn-primary">Áp dụng</button>
                                                <a href="/courses" class="btn btn-outline-secondary">Xóa bộ lọc</a>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-9">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h5 class="mb-0 fw-bold">${totalItems} khóa học</h5>
                                </div>

                                <div class="row g-4">
                                    <c:forEach var="course" items="${courses}">
                                        <div class="col-md-6 col-xl-4">
                                            <div class="card course-card h-100">
                                                <img src="/images/course/${course.thumbnail}" class="card-img-top"
                                                    alt="${course.name}" style="height: 180px; object-fit: cover;">
                                                <div class="card-body d-flex flex-column">
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <span class="badge bg-primary-subtle text-primary">
                                                            <c:choose>
                                                                <c:when test="${course.level == 'BEGINNER' || course.level == 'beginner' || course.level == 'BIGINNER' || course.level == 'biginner'}">Cơ bản</c:when>
                                                                <c:when test="${course.level == 'INTERMEDIATE' || course.level == 'intermediate'}">Trung cấp</c:when>
                                                                <c:when test="${course.level == 'ADVANCED' || course.level == 'advanced'}">Nâng cao</c:when>
                                                                <c:otherwise>${course.level}</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                    <h6 class="fw-bold mb-1">${course.name}</h6>
                                                    <p class="text-muted small mb-2">${course.author}</p>
                                                    <p class="text-muted small mb-3 flex-grow-1">${course.shortDesc}</p>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <c:choose>
                                                            <c:when test="${course.price <= 0}">
                                                                <span class="fw-bold text-primary">Miễn phí</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="fw-bold text-primary">
                                                                    <fmt:formatNumber value="${course.price}"
                                                                        type="number" groupingUsed="true"
                                                                        maxFractionDigits="0" /> ₫
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <a href="/course/${course.id}"
                                                            class="btn btn-sm btn-primary">Chi tiết</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <c:if test="${empty courses}">
                                        <div class="col-12">
                                            <div class="alert alert-warning mb-0">
                                                Không có khóa học phù hợp với bộ lọc hiện tại.
                                            </div>
                                        </div>
                                    </c:if>
                                </div>

                                <c:if test="${totalPages > 1}">
                                    <nav class="mt-4" aria-label="Course pagination">
                                        <ul class="pagination justify-content-center mb-0">
                                            <c:url var="prevUrl" value="/courses">
                                                <c:param name="q" value="${selectedKeyword}" />
                                                <c:param name="level" value="${selectedLevel}" />
                                                <c:param name="title" value="${selectedTitle}" />
                                                <c:param name="priceRange" value="${selectedPriceRange}" />
                                                <c:param name="sort" value="${selectedSort}" />
                                                <c:param name="page" value="${currentPage - 1}" />
                                            </c:url>
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="${currentPage == 1 ? '#' : prevUrl}">Trang
                                                    trước</a>
                                            </li>

                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                <c:url var="pageUrl" value="/courses">
                                                    <c:param name="q" value="${selectedKeyword}" />
                                                    <c:param name="level" value="${selectedLevel}" />
                                                    <c:param name="title" value="${selectedTitle}" />
                                                    <c:param name="priceRange" value="${selectedPriceRange}" />
                                                    <c:param name="sort" value="${selectedSort}" />
                                                    <c:param name="page" value="${i}" />
                                                </c:url>
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="${pageUrl}">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <c:url var="nextUrl" value="/courses">
                                                <c:param name="q" value="${selectedKeyword}" />
                                                <c:param name="level" value="${selectedLevel}" />
                                                <c:param name="title" value="${selectedTitle}" />
                                                <c:param name="priceRange" value="${selectedPriceRange}" />
                                                <c:param name="sort" value="${selectedSort}" />
                                                <c:param name="page" value="${currentPage + 1}" />
                                            </c:url>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link"
                                                    href="${currentPage == totalPages ? '#' : nextUrl}">Trang sau</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </section>

                <jsp:include page="../layout/footer.jsp" />

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/js/main.js"></script>
            </body>

            </html>