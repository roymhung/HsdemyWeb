<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Admin Dashboard</title>
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
                        <div>
                            <h1 class="mt-4 mb-1">Admin Dashboard</h1>
                            <p class="text-muted mb-4">Theo dõi hoạt động học tập, doanh thu và quản trị nội dung tại một nơi.</p>
                        </div>
                    </div>

                    <c:if test="${param.concurrentLogin != null}">
                        <div class="alert alert-warning">
                            Tài khoản của bạn đang được đăng nhập ở nơi khác. Phiên trước đó đã bị đăng xuất.
                        </div>
                    </c:if>

                    <div class="admin-hero-card mb-4">
                        <div class="d-flex flex-column flex-lg-row justify-content-between gap-3 align-items-start align-items-lg-center">
                            <div>
                                <span class="badge bg-light text-primary mb-2 px-3 py-2 rounded-pill">System Health: Stable</span>
                                <h4 class="mb-2">Vận hành hệ thống e-learning theo flow rõ ràng</h4>
                                <p class="mb-0 text-white-50">
                                    Tập trung vào 4 bước cốt lõi: tạo khóa học, xây chương-bài, xuất bản nội dung và xử lý mua hàng.
                                </p>
                            </div>
                            <div class="d-flex gap-2 flex-wrap">
                                <a href="/admin/course/create" class="btn btn-light btn-sm fw-semibold px-3">
                                    <i class="fas fa-plus-circle me-1"></i> Tạo khóa học
                                </a>
                                <a href="/admin/course" class="btn btn-outline-light btn-sm fw-semibold px-3">
                                    <i class="fas fa-table me-1"></i> Danh sách khóa học
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-primary-subtle text-primary">
                                    <i class="fas fa-book"></i>
                                </div>
                                <div>
                                    <div class="text-muted small">Tổng khóa học</div>
                                    <h4 class="mb-0">128</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-success-subtle text-success">
                                    <i class="fas fa-video"></i>
                                </div>
                                <div>
                                    <div class="text-muted small">Tổng bài học video</div>
                                    <h4 class="mb-0">1,584</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-warning-subtle text-warning">
                                    <i class="fas fa-users"></i>
                                </div>
                                <div>
                                    <div class="text-muted small">Học viên hoạt động</div>
                                    <h4 class="mb-0">3,926</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="admin-stat-card">
                                <div class="admin-stat-icon bg-danger-subtle text-danger">
                                    <i class="fas fa-wallet"></i>
                                </div>
                                <div>
                                    <div class="text-muted small">Doanh thu tháng</div>
                                    <h4 class="mb-0">742M</h4>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-xl-8">
                            <div class="card admin-card h-100">
                                <div class="card-header bg-white border-0 pb-0">
                                    <h5 class="fw-semibold mb-1">
                                        <i class="fas fa-diagram-project me-2 text-primary"></i>Kịch bản hệ thống
                                    </h5>
                                    <p class="text-muted small mb-0">Quy trình quản trị từ tạo khóa học đến thanh toán của học viên.</p>
                                </div>
                                <div class="card-body">
                                    <div class="admin-flow-timeline">
                                        <div class="admin-flow-item">
                                            <div class="admin-flow-dot">1</div>
                                            <div>
                                                <h6 class="mb-1">Admin thêm Course</h6>
                                                <p class="text-muted mb-0 small">Nhập thông tin khóa học, kiểm tra validation, submit và lưu DB.</p>
                                            </div>
                                        </div>
                                        <div class="admin-flow-item">
                                            <div class="admin-flow-dot">2</div>
                                            <div>
                                                <h6 class="mb-1">Admin thêm Chapter</h6>
                                                <p class="text-muted mb-0 small">Vào trang chi tiết khóa học, thêm chương theo thứ tự và mô tả.</p>
                                            </div>
                                        </div>
                                        <div class="admin-flow-item">
                                            <div class="admin-flow-dot">3</div>
                                            <div>
                                                <h6 class="mb-1">Admin thêm Topic (Video)</h6>
                                                <p class="text-muted mb-0 small">Upload video, cập nhật metadata bài học, bật/tắt preview.</p>
                                            </div>
                                        </div>
                                        <div class="admin-flow-item">
                                            <div class="admin-flow-dot">4</div>
                                            <div>
                                                <h6 class="mb-1">Student mua Course</h6>
                                                <p class="text-muted mb-0 small">Học viên thanh toán thành công qua VNPAY và được mở quyền học.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4">
                            <div class="card admin-card h-100">
                                <div class="card-header bg-white border-0 pb-0">
                                    <h5 class="fw-semibold mb-1">
                                        <i class="fas fa-bolt me-2 text-primary"></i>Quick Actions
                                    </h5>
                                </div>
                                <div class="card-body d-grid gap-2">
                                    <a href="/admin/course/create" class="btn btn-primary">
                                        <i class="fas fa-circle-plus me-1"></i> Tạo khóa học mới
                                    </a>
                                    <a href="/admin/course" class="btn btn-outline-primary">
                                        <i class="fas fa-table-list me-1"></i> Quản lý khóa học
                                    </a>
                                    <a href="/admin/user" class="btn btn-outline-secondary">
                                        <i class="fas fa-users me-1"></i> Quản lý người dùng
                                    </a>
                                    <a href="/admin/order" class="btn btn-outline-secondary">
                                        <i class="fas fa-file-invoice-dollar me-1"></i> Theo dõi đơn hàng
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-xl-7">
                            <div class="card admin-card h-100">
                                <div class="card-header bg-white">
                                    <h5 class="fw-semibold mb-0">
                                        <i class="fas fa-list-check me-2 text-primary"></i>Phân tích chức năng trọng tâm
                                    </h5>
                                </div>
                                <div class="card-body table-responsive">
                                    <table class="table table-hover align-middle mb-0 admin-table">
                                        <thead>
                                            <tr>
                                                <th>Function</th>
                                                <th>Validation / Logic</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td><strong>Add Course</strong></td>
                                                <td>
                                                    Title/Description/Category required; Type = Free/Paid; Price >= 0; Discount 0-100; Thumbnail là image.
                                                    <br />
                                                    <span class="text-primary">finalPrice = price - (price * discount / 100)</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Add Chapter</strong></td>
                                                <td>Quan hệ 1 Course - nhiều Chapter. Sr No phải unique trong từng course.</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Add Topic</strong></td>
                                                <td>Quan hệ 1 Chapter - nhiều Topic (video). Upload video, lưu đường dẫn, tăng video count.</td>
                                            </tr>
                                            <tr>
                                                <td><strong>My Listed Course</strong></td>
                                                <td>Hiển thị thumbnail, name, description, type, price, discount và action update/delete.</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-5">
                            <div class="card admin-card h-100">
                                <div class="card-header bg-white">
                                    <h5 class="fw-semibold mb-0">
                                        <i class="fas fa-table me-2 text-primary"></i>My Listed Course
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <p class="mb-3 text-muted">
                                        Danh sách quản trị khóa học nên hiển thị theo format rõ ràng để thao tác nhanh:
                                    </p>
                                    <div class="table-responsive">
                                        <table class="table table-sm align-middle admin-table">
                                            <thead>
                                                <tr>
                                                    <th>Thumbnail</th>
                                                    <th>Name</th>
                                                    <th>Description</th>
                                                    <th>Type</th>
                                                    <th>Price</th>
                                                    <th>Discount</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td colspan="7" class="text-center text-muted">
                                                        Dữ liệu thực tế hiển thị tại trang quản lý khóa học.
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <a href="/admin/course" class="btn btn-primary btn-sm px-3">
                                        <i class="fas fa-arrow-right me-1"></i> Đi tới My Listed Course
                                    </a>
                                </div>
                            </div>
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