<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Purchase Management</title>
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
                        <h1 class="mt-4 mb-1">Purchase Management</h1>
                        <p class="text-muted mb-4">Theo dõi từng lượt mua khóa học, trạng thái thanh toán và hiệu suất doanh thu theo category.</p>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-primary-subtle text-primary"><i class="fas fa-cart-shopping"></i></div>
                                <div>
                                    <div class="text-muted small">Lượt mua hiển thị</div>
                                    <h4 class="mb-0">${totalPurchaseCount}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-success-subtle text-success"><i class="fas fa-circle-check"></i></div>
                                <div>
                                    <div class="text-muted small">Thanh toán thành công</div>
                                    <h4 class="mb-0">${paidPurchaseCount}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-warning-subtle text-warning"><i class="fas fa-users"></i></div>
                                <div>
                                    <div class="text-muted small">Học viên đã mua</div>
                                    <h4 class="mb-0">${uniqueStudents}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-danger-subtle text-danger"><i class="fas fa-wallet"></i></div>
                                <div>
                                    <div class="text-muted small">Doanh thu (PAID)</div>
                                    <h6 class="mb-0"><fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true" maxFractionDigits="0" /> đ</h6>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card admin-card mb-4">
                        <div class="card-header bg-white">
                            <h5 class="fw-semibold mb-0"><i class="fas fa-filter me-2 text-primary"></i>Bộ lọc giao dịch mua</h5>
                        </div>
                        <div class="card-body">
                            <form method="get" action="/admin/purchase" class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Từ khóa</label>
                                    <input type="text" class="form-control" name="q" value="${keyword}"
                                        placeholder="Mã đơn, tên học viên, email, tên khóa học...">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Trạng thái</label>
                                    <select class="form-select" name="status">
                                        <option value="ALL" ${selectedStatus == 'ALL' ? 'selected' : ''}>Tất cả</option>
                                        <c:forEach var="st" items="${statusOptions}">
                                            <option value="${st}" ${selectedStatus == st ? 'selected' : ''}>${st}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">Category</label>
                                    <select class="form-select" name="category">
                                        <option value="ALL" ${selectedCategory == 'ALL' ? 'selected' : ''}>Tất cả</option>
                                        <c:forEach var="cat" items="${categoryOptions}">
                                            <option value="${cat}" ${selectedCategory == cat ? 'selected' : ''}>${cat}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-1 d-flex align-items-end">
                                    <button class="btn btn-primary w-100" type="submit">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="card admin-card mb-4">
                        <div class="card-header bg-white">
                            <h5 class="fw-semibold mb-0"><i class="fas fa-table me-2 text-primary"></i>Danh sách lượt mua</h5>
                        </div>
                        <div class="card-body table-responsive">
                            <table class="table table-hover align-middle admin-table mb-0">
                                <thead>
                                    <tr>
                                        <th>Purchase ID</th>
                                        <th>Order</th>
                                        <th>Học viên</th>
                                        <th>Khóa học</th>
                                        <th>Category</th>
                                        <th>Số tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Thời gian mua</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="row" items="${rows}">
                                        <tr>
                                            <td class="fw-semibold">#${row.purchaseId}</td>
                                            <td>
                                                <a href="/admin/order?q=${row.orderId}" class="text-decoration-none">#${row.orderId}</a>
                                            </td>
                                            <td>
                                                <div class="fw-semibold">${row.studentName}</div>
                                                <div class="small text-muted">${row.studentEmail}</div>
                                            </td>
                                            <td>${row.courseName}</td>
                                            <td><span class="badge text-bg-light">${row.category}</span></td>
                                            <td><fmt:formatNumber value="${row.amount}" type="number" groupingUsed="true" maxFractionDigits="0" /> đ</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${row.status == 'PAID'}">
                                                        <span class="badge text-bg-success">${row.status}</span>
                                                    </c:when>
                                                    <c:when test="${row.status == 'FAILED' || row.status == 'CANCELLED'}">
                                                        <span class="badge text-bg-danger">${row.status}</span>
                                                    </c:when>
                                                    <c:when test="${row.status == 'PENDING_PAYMENT'}">
                                                        <span class="badge text-bg-warning">${row.status}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge text-bg-secondary">${row.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="small">${row.purchasedAt}</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty rows}">
                                        <tr>
                                            <td colspan="8" class="text-center text-muted py-4">Không có lượt mua phù hợp bộ lọc.</td>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/js/scripts.js"></script>
</body>

</html>