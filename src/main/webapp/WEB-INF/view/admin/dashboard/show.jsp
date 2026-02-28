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
    <style>
        .hero-dashboard {
            background: linear-gradient(135deg, #0d6efd 0%, #6610f2 100%);
            border-radius: 1rem;
            padding: 1.5rem;
            color: #fff;
        }

        .quick-card,
        .flow-card {
            border: 1px solid #e9ecef;
            border-radius: 0.9rem;
            transition: all .2s ease;
            height: 100%;
        }

        .quick-card:hover,
        .flow-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 0.75rem 1.5rem rgba(13, 110, 253, 0.12);
        }

        .flow-index {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #0d6efd;
            background: #e7f1ff;
            font-weight: 700;
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
                    <h1 class="mt-4">Admin Course Dashboard</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">Dashboard</li>
                    </ol>

                    <c:if test="${param.concurrentLogin != null}">
                        <div class="alert alert-warning">
                            Tài khoản của bạn đang được đăng nhập ở nơi khác. Phiên trước đó đã bị đăng xuất.
                        </div>
                    </c:if>

                    <div class="hero-dashboard mb-4">
                        <div class="d-flex flex-column flex-lg-row justify-content-between gap-3 align-items-start align-items-lg-center">
                            <div>
                                <h4 class="mb-2">Quản trị nội dung khóa học theo quy trình chuẩn</h4>
                                <p class="mb-0 opacity-75">
                                    Flow tập trung vào 4 bước chính: Add Course, Add Chapter, Add Topic (Video), Student Purchase.
                                </p>
                            </div>
                            <div class="d-flex gap-2">
                                <a href="/admin/course/create" class="btn btn-light btn-sm fw-semibold">
                                    <i class="fas fa-plus-circle me-1"></i> Add Course
                                </a>
                                <a href="/admin/course" class="btn btn-outline-light btn-sm fw-semibold">
                                    <i class="fas fa-table me-1"></i> My Listed Course
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-xl-3 col-md-6">
                            <div class="quick-card p-3 bg-white">
                                <p class="text-muted small mb-2">Quick Action</p>
                                <h6 class="mb-2">Tạo khóa học mới</h6>
                                <p class="small text-muted mb-3">Nhập title, mô tả, category, pricing và thumbnail.</p>
                                <a href="/admin/course/create" class="btn btn-primary btn-sm">Start</a>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="quick-card p-3 bg-white">
                                <p class="text-muted small mb-2">Quick Action</p>
                                <h6 class="mb-2">Danh sách khóa học</h6>
                                <p class="small text-muted mb-3">Theo dõi toàn bộ khóa học đã publish.</p>
                                <a href="/admin/course" class="btn btn-outline-primary btn-sm">Open List</a>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="quick-card p-3 bg-white">
                                <p class="text-muted small mb-2">Quick Action</p>
                                <h6 class="mb-2">Chi tiết từng khóa học</h6>
                                <p class="small text-muted mb-3">Đi vào từng course để quản trị chapter/topic.</p>
                                <a href="/admin/course" class="btn btn-outline-primary btn-sm">Go to Detail</a>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="quick-card p-3 bg-white">
                                <p class="text-muted small mb-2">Quick Action</p>
                                <h6 class="mb-2">Purchased Courses</h6>
                                <p class="small text-muted mb-3">Kiểm tra các khóa học đã mua của user.</p>
                                <a href="/account/purchase-history" class="btn btn-outline-primary btn-sm">View</a>
                            </div>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <div class="card-header fw-semibold">
                            <i class="fas fa-diagram-project me-2 text-primary"></i>
                            Kịch bản hệ thống (System Flow)
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-lg-6">
                                    <div class="flow-card p-3">
                                        <div class="d-flex align-items-center gap-2 mb-2">
                                            <span class="flow-index">1</span>
                                            <h6 class="mb-0">Admin thêm Course</h6>
                                        </div>
                                        <p class="mb-2 text-muted small">Đăng nhập → Add Course → Submit → Lưu DB → Hiển thị trong My Listed Course.</p>
                                        <p class="mb-0"><strong>Data:</strong> Title, Description, Category, Type, Price, Discount, Author note, Special note, Prerequisite, Thumbnail.</p>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="flow-card p-3">
                                        <div class="d-flex align-items-center gap-2 mb-2">
                                            <span class="flow-index">2</span>
                                            <h6 class="mb-0">Admin thêm Chapter</h6>
                                        </div>
                                        <p class="mb-2 text-muted small">Vào chi tiết Course → Add Chapter → Lưu DB → Hiển thị trong danh sách chapter.</p>
                                        <p class="mb-0"><strong>Data:</strong> Sr No, Section Name, Section Description.</p>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="flow-card p-3">
                                        <div class="d-flex align-items-center gap-2 mb-2">
                                            <span class="flow-index">3</span>
                                            <h6 class="mb-0">Admin thêm Topic (Video)</h6>
                                        </div>
                                        <p class="mb-2 text-muted small">Vào Chapter → Add Topic → Upload Video → Lưu DB + lưu file → tăng video count.</p>
                                        <p class="mb-0"><strong>Data:</strong> Sr No (1.1, 1.2...), Topic Name, Description, Video.</p>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="flow-card p-3">
                                        <div class="d-flex align-items-center gap-2 mb-2">
                                            <span class="flow-index">4</span>
                                            <h6 class="mb-0">Student mua Course</h6>
                                        </div>
                                        <p class="mb-2 text-muted small">Student xem course giá discount → Purchase → Thanh toán → course nằm trong Purchased Courses.</p>
                                        <p class="mb-0"><strong>Outcome:</strong> Student có quyền xem video khóa học đã mua.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-xl-7">
                            <div class="card h-100">
                                <div class="card-header fw-semibold">
                                    <i class="fas fa-list-check me-2 text-primary"></i>
                                    Phân tích chức năng
                                </div>
                                <div class="card-body table-responsive">
                                    <table class="table table-bordered align-middle mb-0">
                                        <thead class="table-light">
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
                            <div class="card h-100">
                                <div class="card-header fw-semibold">
                                    <i class="fas fa-table me-2 text-primary"></i>
                                    My Listed Course
                                </div>
                                <div class="card-body">
                                    <p class="mb-3 text-muted">
                                        Danh sách quản trị khóa học nên hiển thị theo format rõ ràng để thao tác nhanh:
                                    </p>
                                    <div class="table-responsive">
                                        <table class="table table-sm table-bordered align-middle">
                                            <thead class="table-light">
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
                                    <a href="/admin/course" class="btn btn-primary btn-sm">
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