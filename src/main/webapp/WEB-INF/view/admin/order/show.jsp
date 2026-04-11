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
                    <title>Order Management</title>
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <style>
                        .order-id-badge {
                            display: inline-flex;
                            align-items: center;
                            justify-content: center;
                            min-width: 56px;
                            height: 32px;
                            border-radius: 999px;
                            background: #e8f0ff;
                            color: #1d4ed8;
                            font-weight: 700;
                            font-size: .9rem;
                        }

                        .order-date-chip {
                            display: inline-flex;
                            align-items: center;
                            gap: .35rem;
                            border-radius: .6rem;
                            background: #f8fafc;
                            border: 1px solid #e2e8f0;
                            padding: .35rem .55rem;
                            font-size: .82rem;
                            color: #334155;
                            font-weight: 600;
                        }

                        .order-time-chip {
                            display: inline-flex;
                            align-items: center;
                            gap: .35rem;
                            border-radius: .6rem;
                            background: #f8fafc;
                            border: 1px solid #e2e8f0;
                            padding: .35rem .55rem;
                            font-size: .8rem;
                            color: #64748b;
                            margin-top: .35rem;
                        }
                    </style>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />

                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />

                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <div class="admin-page-heading">
                                        <h1 class="mt-4 mb-1">Quản lý đơn hàng</h1>
                                        <p class="text-muted mb-4">Theo dõi trạng thái thanh toán, kiểm soát đơn lỗi và
                                            cập nhật xử lý thủ công.</p>
                                    </div>

                                    <c:if test="${not empty message}">
                                        <div class="alert alert-info border-0 shadow-sm">${message}</div>
                                    </c:if>

                                    <div class="row g-3 mb-4">
                                        <div class="col-xl-3 col-md-6">
                                            <div class="admin-stat-card">
                                                <div class="admin-stat-icon bg-primary-subtle text-primary"><i
                                                        class="fas fa-receipt"></i></div>
                                                <div>
                                                    <div class="text-muted small">Tổng đơn hàng</div>
                                                    <h4 class="mb-0">${totalOrders}</h4>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-3 col-md-6">
                                            <div class="admin-stat-card">
                                                <div class="admin-stat-icon bg-warning-subtle text-warning"><i
                                                        class="fas fa-hourglass-half"></i></div>
                                                <div>
                                                    <div class="text-muted small">Đơn chờ thanh toán</div>
                                                    <h4 class="mb-0">${pendingOrders}</h4>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-3 col-md-6">
                                            <div class="admin-stat-card">
                                                <div class="admin-stat-icon bg-success-subtle text-success"><i
                                                        class="fas fa-circle-check"></i></div>
                                                <div>
                                                    <div class="text-muted small">Đơn thành công</div>
                                                    <h4 class="mb-0">${paidOrders}</h4>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-3 col-md-6">
                                            <div class="admin-stat-card">
                                                <div class="admin-stat-icon bg-danger-subtle text-danger"><i
                                                        class="fas fa-wallet"></i></div>
                                                <div>
                                                    <div class="text-muted small">Doanh thu đã ghi nhận</div>
                                                    <h6 class="mb-0">
                                                        <fmt:formatNumber value="${totalRevenue}" type="number"
                                                            groupingUsed="true" maxFractionDigits="0" /> đ
                                                    </h6>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card admin-card mb-4">
                                        <div class="card-header bg-white">
                                            <h5 class="fw-semibold mb-0"><i
                                                    class="fas fa-filter me-2 text-primary"></i>Tìm kiếm & lọc đơn hàng
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <form method="get" action="/admin/order" class="row g-3">
                                                <div class="col-md-8">
                                                    <label class="form-label">Từ khóa</label>
                                                    <input type="text" class="form-control" name="q" value="${keyword}"
                                                        placeholder="Tìm theo mã đơn, tên user, email, tên khóa học...">
                                                </div>
                                                <div class="col-md-3">
                                                    <label class="form-label">Trạng thái</label>
                                                    <select class="form-select" name="status">
                                                        <option value="ALL" ${selectedStatus=='ALL' ? 'selected' : '' }>
                                                            Tất cả</option>
                                                        <c:forEach var="st" items="${statusOptions}">
                                                            <option value="${st}" ${selectedStatus==st ? 'selected' : ''
                                                                }>${st}</option>
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
                                            <h5 class="fw-semibold mb-0"><i
                                                    class="fas fa-table-list me-2 text-primary"></i>Danh sách đơn hàng
                                            </h5>
                                        </div>
                                        <div class="card-body table-responsive">
                                            <table class="table table-hover align-middle admin-table mb-0">
                                                <thead>
                                                    <tr>
                                                        <th>Mã đơn</th>
                                                        <th>Người mua</th>
                                                        <th>Khóa học</th>
                                                        <th>Tổng tiền</th>
                                                        <th>Trạng thái</th>
                                                        <th>Thời gian</th>
                                                        <th style="min-width: 280px;">Cập nhật trạng thái</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="order" items="${orders}">
                                                        <tr>
                                                            <td><span class="order-id-badge">#${order.id}</span></td>
                                                            <td>
                                                                <div class="fw-semibold">${order.userName}</div>
                                                                <div class="small text-muted">${order.userEmail}</div>
                                                            </td>
                                                            <td class="small">${order.courseNames}</td>
                                                            <td>
                                                                <fmt:formatNumber value="${order.totalPrice}"
                                                                    type="number" groupingUsed="true"
                                                                    maxFractionDigits="0" /> đ
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${order.status == 'PAID'}">
                                                                        <span
                                                                            class="badge text-bg-success">${order.status}</span>
                                                                    </c:when>
                                                                    <c:when
                                                                        test="${order.status == 'FAILED' || order.status == 'CANCELLED'}">
                                                                        <span
                                                                            class="badge text-bg-danger">${order.status}</span>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'PENDING_PAYMENT'}">
                                                                        <span
                                                                            class="badge text-bg-warning">${order.status}</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span
                                                                            class="badge text-bg-secondary">${order.status}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <div class="order-date-chip">
                                                                    <i class="far fa-calendar"></i>
                                                                    <span>${order.createdDateDisplay}</span>
                                                                </div>
                                                                <div class="order-time-chip">
                                                                    <i class="far fa-clock"></i>
                                                                    <span>${order.createdTimeDisplay}</span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <form method="post"
                                                                    action="/admin/order/${order.id}/status"
                                                                    class="d-flex gap-2">
                                                                    <input type="hidden" name="${_csrf.parameterName}"
                                                                        value="${_csrf.token}" />
                                                                    <input type="hidden" name="q" value="${keyword}" />
                                                                    <input type="hidden" name="statusFilter"
                                                                        value="${selectedStatus}" />
                                                                    <input type="hidden" name="page"
                                                                        value="${currentPage}" />
                                                                    <select class="form-select form-select-sm"
                                                                        name="status">
                                                                        <c:forEach var="st" items="${statusOptions}">
                                                                            <option value="${st}" ${order.status==st
                                                                                ? 'selected' : '' }>${st}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                    <button type="submit" formmethod="post"
                                                                        class="btn btn-sm btn-primary">Lưu</button>
                                                                </form>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty orders}">
                                                        <tr>
                                                            <td colspan="7" class="text-center text-muted py-4">Không có
                                                                đơn hàng phù hợp bộ lọc.</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <c:if test="${totalPages > 1}">
                                        <div class="d-flex justify-content-center mb-4">
                                            <ul class="pagination mb-0">
                                                <c:url var="prevUrl" value="/admin/order">
                                                    <c:param name="q" value="${keyword}" />
                                                    <c:param name="status" value="${selectedStatus}" />
                                                    <c:param name="page" value="${currentPage - 1}" />
                                                </c:url>
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link"
                                                        href="${currentPage == 1 ? '#' : prevUrl}">Trang trước</a>
                                                </li>

                                                <c:forEach var="i" begin="1" end="${totalPages}">
                                                    <c:url var="pageUrl" value="/admin/order">
                                                        <c:param name="q" value="${keyword}" />
                                                        <c:param name="status" value="${selectedStatus}" />
                                                        <c:param name="page" value="${i}" />
                                                    </c:url>
                                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                        <a class="page-link" href="${pageUrl}">${i}</a>
                                                    </li>
                                                </c:forEach>

                                                <c:url var="nextUrl" value="/admin/order">
                                                    <c:param name="q" value="${keyword}" />
                                                    <c:param name="status" value="${selectedStatus}" />
                                                    <c:param name="page" value="${currentPage + 1}" />
                                                </c:url>
                                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <a class="page-link"
                                                        href="${currentPage == totalPages ? '#' : nextUrl}">Trang
                                                        sau</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </c:if>
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