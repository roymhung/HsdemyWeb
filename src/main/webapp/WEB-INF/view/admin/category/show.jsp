<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Category Management</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />

    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <div class="admin-page-heading">
                        <h1 class="mt-4 mb-1">Category Management</h1>
                        <p class="text-muted mb-4">Quản trị nhóm chủ đề khóa học, theo dõi hiệu quả và chuẩn hóa category.</p>
                    </div>

                    <c:if test="${not empty message}">
                        <div class="alert alert-info border-0 shadow-sm">${message}</div>
                    </c:if>

                    <div class="row g-3 mb-4">
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-primary-subtle text-primary"><i class="fas fa-layer-group"></i></div>
                                <div>
                                    <div class="text-muted small">Tổng category</div>
                                    <h4 class="mb-0">${totalCategoryCount}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-success-subtle text-success"><i class="fas fa-book-open"></i></div>
                                <div>
                                    <div class="text-muted small">Tổng khóa học</div>
                                    <h4 class="mb-0">${totalCourseCount}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-warning-subtle text-warning"><i class="fas fa-triangle-exclamation"></i></div>
                                <div>
                                    <div class="text-muted small">Chưa phân loại</div>
                                    <h4 class="mb-0">${uncategorizedCount}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-danger-subtle text-danger"><i class="fas fa-ranking-star"></i></div>
                                <div>
                                    <div class="text-muted small">Category nổi bật</div>
                                    <h6 class="mb-0">${topCategory}</h6>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-xl-8">
                            <div class="card admin-card h-100">
                                <div class="card-header bg-white">
                                    <h5 class="fw-semibold mb-0"><i class="fas fa-filter me-2 text-primary"></i>Bộ lọc & sắp xếp</h5>
                                </div>
                                <div class="card-body">
                                    <form method="get" action="/admin/category" class="row g-3">
                                        <div class="col-md-7">
                                            <label class="form-label">Tìm category</label>
                                            <input type="text" class="form-control" name="q"
                                                value="${keyword}"
                                                placeholder="Ví dụ: LANGUAGE, Kỹ năng, Marketing...">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">Sắp xếp</label>
                                            <select class="form-select" name="sort">
                                                <option value="courses_desc" ${selectedSort == 'courses_desc' ? 'selected' : ''}>Nhiều khóa học nhất</option>
                                                <option value="revenue_desc" ${selectedSort == 'revenue_desc' ? 'selected' : ''}>Doanh thu cao nhất</option>
                                                <option value="name_asc" ${selectedSort == 'name_asc' ? 'selected' : ''}>Tên category A-Z</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2 d-flex align-items-end">
                                            <button class="btn btn-primary w-100" type="submit">
                                                <i class="fas fa-magnifying-glass me-1"></i>Lọc
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4">
                            <div class="card admin-card h-100">
                                <div class="card-header bg-white">
                                    <h5 class="fw-semibold mb-0"><i class="fas fa-wand-magic-sparkles me-2 text-primary"></i>Chuẩn hóa category</h5>
                                </div>
                                <div class="card-body">
                                    <form method="post" action="/admin/category/rename" class="d-grid gap-2">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <div>
                                            <label class="form-label">Category hiện tại</label>
                                            <select class="form-select" name="oldTitle" required>
                                                <c:forEach var="item" items="${categories}">
                                                    <option value="${item.key}">${item.displayName} (${item.courseCount})</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div>
                                            <label class="form-label">Category mới (mã)</label>
                                            <select class="form-select" name="newTitle" required>
                                                <option value="LANGUAGE">LANGUAGE</option>
                                                <option value="SOFT_SKILLS">SOFT_SKILLS</option>
                                                <option value="BUSINESS_MARKETING">BUSINESS_MARKETING</option>
                                                <option value="IT_DESIGN">IT_DESIGN</option>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn btn-outline-primary mt-2">
                                            <i class="fas fa-repeat me-1"></i>Cập nhật category hàng loạt
                                        </button>
                                        <small class="text-muted">Tác vụ này sẽ đổi category cho toàn bộ khóa học thuộc nhóm đã chọn.</small>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card admin-card mb-4">
                        <div class="card-header bg-white">
                            <h5 class="fw-semibold mb-0"><i class="fas fa-table me-2 text-primary"></i>Bảng category thực tế</h5>
                        </div>
                        <div class="card-body table-responsive">
                            <table class="table table-hover align-middle admin-table mb-0">
                                <thead>
                                    <tr>
                                        <th>Mã</th>
                                        <th>Tên hiển thị</th>
                                        <th>Số khóa học</th>
                                        <th>Giá trung bình</th>
                                        <th>Doanh thu tiềm năng</th>
                                        <th>Mốc mới nhất</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${categories}">
                                        <tr>
                                            <td><span class="badge text-bg-light">${item.key}</span></td>
                                            <td class="fw-semibold">${item.displayName}</td>
                                            <td>${item.courseCount}</td>
                                            <td>
                                                <fmt:formatNumber value="${item.avgPrice}" type="number" groupingUsed="true" maxFractionDigits="0" /> đ
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${item.totalRevenue}" type="number" groupingUsed="true" maxFractionDigits="0" /> đ
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty item.lastCreatedAt}">
                                                        ${item.lastCreatedAt}
                                                    </c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty categories}">
                                        <tr>
                                            <td colspan="6" class="text-center text-muted py-4">Không tìm thấy category phù hợp.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>

            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
    <script src="/js/scripts.js"></script>
</body>

</html>