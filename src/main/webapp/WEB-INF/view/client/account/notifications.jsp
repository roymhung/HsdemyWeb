<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông báo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background: #f6f8fc; }
        .notify-card {
            border: 1px solid #e9eef6;
            border-radius: 1rem;
            box-shadow: 0 10px 26px rgba(15, 23, 42, .05);
        }
        .notify-item {
            border: 1px solid #e9eef6;
            border-radius: .9rem;
            padding: .9rem 1rem;
            background: #fff;
        }
        .notify-item.unread {
            border-color: #bdd8ff;
            background: #f4f9ff;
        }
        .notify-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />

    <section class="py-5" style="margin-top: 85px;">
        <div class="container" style="max-width: 980px;">
            <div class="card notify-card">
                <div class="card-body p-4">
                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2 mb-4">
                        <div>
                            <h3 class="fw-bold mb-1">Thông báo</h3>
                            <p class="text-muted mb-0">Bạn có <strong>${unreadCount}</strong> thông báo chưa đọc.</p>
                        </div>
                        <form action="/notifications/read-all" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button type="submit" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-check2-all me-1"></i> Đánh dấu tất cả đã đọc
                            </button>
                        </form>
                    </div>

                    <c:choose>
                        <c:when test="${empty notifications}">
                            <div class="alert alert-info mb-0">
                                Bạn chưa có thông báo nào.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="d-grid gap-3">
                                <c:forEach var="item" items="${notifications}">
                                    <div class="notify-item ${item.read ? '' : 'unread'}">
                                        <div class="d-flex justify-content-between gap-3">
                                            <div class="d-flex gap-3 flex-grow-1">
                                                <span class="notify-icon ${item.read ? 'bg-light text-muted' : 'bg-primary-subtle text-primary'}">
                                                    <c:choose>
                                                        <c:when test="${item.type == 'payment'}"><i class="bi bi-wallet2"></i></c:when>
                                                        <c:when test="${item.type == 'warning'}"><i class="bi bi-exclamation-triangle"></i></c:when>
                                                        <c:when test="${item.type == 'recommendation'}"><i class="bi bi-stars"></i></c:when>
                                                        <c:when test="${item.type == 'profile'}"><i class="bi bi-person-badge"></i></c:when>
                                                        <c:otherwise><i class="bi bi-bell"></i></c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <div>
                                                    <div class="d-flex align-items-center gap-2 mb-1">
                                                        <h6 class="mb-0">${item.title}</h6>
                                                        <c:if test="${!item.read}">
                                                            <span class="badge bg-primary">Mới</span>
                                                        </c:if>
                                                    </div>
                                                    <p class="text-muted small mb-2">${item.message}</p>
                                                    <div class="d-flex align-items-center gap-3">
                                                        <a href="${item.actionUrl}" class="small text-decoration-none">Mở liên quan</a>
                                                        <span class="small text-muted">${item.createdAt}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <c:if test="${!item.read}">
                                                <form action="/notifications/${item.id}/read" method="post">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <button type="submit" class="btn btn-sm btn-outline-secondary">
                                                        Đã đọc
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="../layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
