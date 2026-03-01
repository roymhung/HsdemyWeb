<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>User Management</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .user-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e2e8f0;
        }

        .avatar-fallback {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: #eef2ff;
            color: #4f46e5;
            font-weight: 700;
            border: 2px solid #e2e8f0;
        }

        .role-pill {
            border-radius: 999px;
            padding: .25rem .65rem;
            font-size: .75rem;
            font-weight: 700;
            letter-spacing: .02em;
        }

        .action-btn-group .btn {
            min-width: 76px;
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
                        <h1 class="mt-4 mb-1">User Management</h1>
                        <p class="text-muted mb-4">Quản lý tài khoản người dùng, phân quyền và thông tin hồ sơ tập trung.</p>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-primary-subtle text-primary"><i class="fas fa-users"></i></div>
                                <div>
                                    <div class="text-muted small">Tổng người dùng</div>
                                    <h4 class="mb-0">${totalUsers}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-success-subtle text-success"><i class="fas fa-filter-circle-dollar"></i></div>
                                <div>
                                    <div class="text-muted small">Đang hiển thị</div>
                                    <h4 class="mb-0">${filteredUsers}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-warning-subtle text-warning"><i class="fas fa-user-shield"></i></div>
                                <div>
                                    <div class="text-muted small">Admin</div>
                                    <h4 class="mb-0">${adminUsers}</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-danger-subtle text-danger"><i class="fas fa-user-graduate"></i></div>
                                <div>
                                    <div class="text-muted small">Học viên</div>
                                    <h4 class="mb-0">${learnerUsers}</h4>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card admin-card mb-4">
                        <div class="card-header bg-white d-flex justify-content-between align-items-center">
                            <h5 class="fw-semibold mb-0"><i class="fas fa-filter me-2 text-primary"></i>Tìm kiếm & bộ lọc</h5>
                            <a href="/admin/user/create" class="btn btn-primary btn-sm">
                                <i class="fas fa-user-plus me-1"></i>Tạo user
                            </a>
                        </div>
                        <div class="card-body">
                            <form method="get" action="/admin/user" class="row g-3">
                                <div class="col-md-8">
                                    <label class="form-label">Từ khóa</label>
                                    <input type="text" class="form-control" name="q" value="${keyword}"
                                        placeholder="ID, email, họ tên, số điện thoại...">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Vai trò</label>
                                    <select class="form-select" name="role">
                                        <option value="ALL" ${selectedRole == 'ALL' ? 'selected' : ''}>Tất cả</option>
                                        <c:forEach var="roleName" items="${roleOptions}">
                                            <option value="${roleName}" ${selectedRole == roleName ? 'selected' : ''}>${roleName}</option>
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
                            <h5 class="fw-semibold mb-0"><i class="fas fa-table me-2 text-primary"></i>Danh sách người dùng</h5>
                        </div>
                        <div class="card-body table-responsive">
                            <table class="table table-hover align-middle admin-table mb-0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Người dùng</th>
                                        <th>Liên hệ</th>
                                        <th>Vai trò</th>
                                        <th style="min-width: 250px;">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${users1}">
                                        <tr>
                                            <td class="fw-semibold">#${user.id}</td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <c:choose>
                                                        <c:when test="${not empty user.avatar}">
                                                            <img src="${pageContext.request.contextPath}/images/avatar/${user.avatar}" alt="avatar"
                                                                class="user-avatar" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="avatar-fallback">
                                                                <i class="fas fa-user"></i>
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div>
                                                        <div class="fw-semibold">${user.fullName}</div>
                                                        <div class="small text-muted">${user.email}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="small">${empty user.phone ? '-' : user.phone}</div>
                                                <div class="small text-muted">${empty user.address ? '-' : user.address}</div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.role.name == 'ADMIN'}">
                                                        <span class="role-pill bg-danger-subtle text-danger">ADMIN</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="role-pill bg-primary-subtle text-primary">${user.role.name}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-2 action-btn-group">
                                                    <a href="/admin/user/${user.id}" class="btn btn-sm btn-outline-success">View</a>
                                                    <a href="/admin/user/update/${user.id}" class="btn btn-sm btn-outline-warning">Update</a>
                                                    <a href="/admin/user/delete/${user.id}" class="btn btn-sm btn-outline-danger">Delete</a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty users1}">
                                        <tr>
                                            <td colspan="5" class="text-center text-muted py-4">Không có user phù hợp bộ lọc.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <c:if test="${totalPages > 1}">
                        <div class="d-flex justify-content-center mb-4">
                            <ul class="pagination mb-0">
                                <c:url var="prevUrl" value="/admin/user">
                                    <c:param name="q" value="${keyword}" />
                                    <c:param name="role" value="${selectedRole}" />
                                    <c:param name="page" value="${currentPage - 1}" />
                                </c:url>
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="${currentPage == 1 ? '#' : prevUrl}">Previous</a>
                                </li>

                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <c:url var="pageUrl" value="/admin/user">
                                        <c:param name="q" value="${keyword}" />
                                        <c:param name="role" value="${selectedRole}" />
                                        <c:param name="page" value="${i}" />
                                    </c:url>
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${pageUrl}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:url var="nextUrl" value="/admin/user">
                                    <c:param name="q" value="${keyword}" />
                                    <c:param name="role" value="${selectedRole}" />
                                    <c:param name="page" value="${currentPage + 1}" />
                                </c:url>
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="${currentPage == totalPages ? '#' : nextUrl}">Next</a>
                                </li>
                            </ul>
                        </div>
                    </c:if>
                </div>
            </main>

            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/js/scripts.js"></script>
</body>

</html>