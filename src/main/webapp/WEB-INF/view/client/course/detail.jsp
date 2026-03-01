<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>${course.name} - Hstudemy </title>

                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <!-- Bootstrap Icons -->
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                    <!-- Google Fonts -->
                    <link
                        href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                        rel="stylesheet">
                    <!-- Custom CSS -->
                    <link rel="stylesheet" href="/client/css/style.css">
                    <style>
                        .preview-modal .modal-content {
                            border: 1px solid rgba(255, 255, 255, .14);
                            border-radius: 1.1rem;
                            overflow: hidden;
                            background: linear-gradient(160deg, #0f172a 0%, #121b34 45%, #111827 100%);
                            box-shadow: 0 24px 50px rgba(2, 8, 23, .55);
                            backdrop-filter: blur(8px);
                        }

                        .preview-modal .modal-header {
                            background: linear-gradient(90deg, rgba(255, 255, 255, .08), rgba(255, 255, 255, .02));
                            border-bottom: 1px solid rgba(255, 255, 255, .12);
                            padding: .95rem 1.1rem;
                        }

                        .preview-modal .modal-title {
                            color: #f8fafc;
                            font-weight: 600;
                        }

                        .preview-modal .btn-close {
                            filter: invert(1) brightness(1.15);
                            opacity: .9;
                        }

                        .video-container {
                            width: 94%;
                            aspect-ratio: 16 / 9;
                            background: #0b1020;
                            overflow: hidden;
                            position: relative;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            margin: 16px auto 18px;
                            border-radius: .8rem;
                            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .06);
                        }

                        .preview-modal .modal-body {
                            background: radial-gradient(circle at top, rgba(99, 102, 241, .08), rgba(15, 23, 42, .96));
                        }

                        .video-container video {
                            position: absolute;
                            inset: 0;
                            width: 100%;
                            height: 100%;
                            object-fit: cover;
                            display: block;
                        }
                    </style>
                </head>

                <body>
                    <!-- Start Header -->
                    <jsp:include page="../layout/header.jsp" />
                    <!-- End Header -->

                    <!-- Course Header -->
                    <section class="text-white mt-5"
                        style="background-image: linear-gradient(rgba(0,0,0,0.72), rgba(0,0,0,0.72)), url('/images/course/${course.thumbnail}'); background-size: cover; background-position: center;">
                        <div class="container py-5">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item"><a href="/"
                                            class="text-white text-decoration-none">Trang
                                            chủ</a></li>
                                    <li class="breadcrumb-item"><a href="/courses"
                                            class="text-white text-decoration-none">Khóa
                                            học</a></li>
                                    <li class="breadcrumb-item active text-white">${course.name}</li>
                                </ol>
                            </nav>
                        </div>
                    </section>

                    <section class="text-white"
                        style="background-image: linear-gradient(rgba(0,0,0,0.72), rgba(0,0,0,0.72)), url('/images/course/${course.thumbnail}'); background-size: cover; background-position: center;">
                        <div class="container py-5">
                            <div class="row">
                                <div class="col-lg-8">
                                    <h1 class="display-5 fw-bold mb-3">${course.name}</h1>
                                    <p class="lead mb-4">${course.shortDesc}
                                    </p>
                                    <div class="d-flex flex-wrap align-items-center gap-3 mb-3">
                                        <div class="d-flex align-items-center">
                                            LEVEL:
                                            <span class="ms-2">${course.level}</span>
                                            <span class="text-muted ms-1">(275 đánh giá)</span>
                                        </div>
                                        <span>Ngày tạo:
                                            ${course.createdAt.toString().substring(8,10)}/${course.createdAt.toString().substring(5,7)}/${course.createdAt.toString().substring(0,4)}</span>
                                    </div>
                                    <p class="mb-0">Được tạo bởi: <a href="#"
                                            class="text-white text-decoration-none">${course.author}</a></p>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Main Content -->
                    <section class="py-5">
                        <div class="container">
                            <div class="row">
                                <!-- Left Content -->
                                <div class="col-lg-8">

                                    <!-- Course Content -->
                                    <div class="card border-0 shadow-sm mb-4">
                                        <div class="card-body p-4">
                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                <h3 class="fw-bold mb-0">Nội dung khóa học</h3>
                                                <span class="text-muted small">${chapters.size()} chương</span>
                                            </div>
                                            <div class="accordion" id="courseAccordion">
                                                <c:forEach var="chapter" items="${chapters}" varStatus="status">
                                                    <div class="accordion-item">
                                                        <h2 class="accordion-header">
                                                            <button class="accordion-button ${status.first ? '' : 'collapsed'}"
                                                                type="button" data-bs-toggle="collapse"
                                                                data-bs-target="#section${chapter.id}">
                                                                <div class="d-flex justify-content-between w-100 me-3">
                                                                    <span>
                                                                        <strong>Phần ${chapter.position}: ${chapter.title}</strong>
                                                                    </span>
                                                                    <span class="text-muted small">${chapter.lessons.size()} bài giảng</span>
                                                                </div>
                                                            </button>
                                                        </h2>
                                                        <div id="section${chapter.id}"
                                                            class="accordion-collapse collapse ${status.first ? 'show' : ''}"
                                                            data-bs-parent="#courseAccordion">
                                                            <div class="accordion-body">
                                                                <c:if test="${not empty chapter.description}">
                                                                    <p class="text-muted mb-3">${chapter.description}</p>
                                                                </c:if>
                                                                <div class="list-group list-group-flush">
                                                                    <c:forEach var="topic" items="${chapter.lessons}">
                                                                        <c:choose>
                                                                            <c:when test="${topic.preview}">
                                                                                <button type="button"
                                                                                    class="list-group-item list-group-item-action d-flex justify-content-between align-items-center open-video-topic border-0 text-start w-100"
                                                                                    data-video-url="${topic.videoUrl}"
                                                                                    data-video-title="${topic.title}"
                                                                                    data-bs-toggle="modal"
                                                                                    data-bs-target="#previewModal">
                                                                                    <div>
                                                                                        <i class="bi bi-play-circle me-2"></i>
                                                                                        ${topic.position}. ${topic.title}
                                                                                        <span class="badge bg-success ms-2">Preview</span>
                                                                                    </div>
                                                                                    <span class="badge bg-secondary">${topic.duration} phút</span>
                                                                                </button>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div
                                                                                    class="list-group-item d-flex justify-content-between align-items-center text-muted">
                                                                                    <div>
                                                                                        <i class="bi bi-lock me-2"></i>
                                                                                        ${topic.position}. ${topic.title}
                                                                                    </div>
                                                                                    <span class="badge bg-secondary">${topic.duration} phút</span>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:forEach>
                                                                    <c:if test="${empty chapter.lessons}">
                                                                        <p class="text-muted mb-0">Nội dung sẽ được cập nhật...</p>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                                <c:if test="${empty chapters}">
                                                    <p class="text-muted">Nội dung khóa học đang được cập nhật...</p>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>



                                    <!-- Description -->
                                    <div class="card border-0 shadow-sm mb-4">
                                        <div class="card-body p-4">
                                            <h3 class="fw-bold mb-4">Mô tả</h3>
                                            <p>${course.detailDesc}</p>
                                        </div>
                                    </div>


                                </div>

                                <!-- Right Sidebar -->
                                <div class="col-lg-4">
                                    <div class="card border-0 shadow-lg sticky-top" style="top: 80px;">
                                        <div class="position-relative">
                                            <img src="/images/course/${course.thumbnail}" class="card-img-top"
                                                alt="Java Spring MVC Course Preview"
                                                style="height: 200px; object-fit: cover;">
                                            <div class="position-absolute top-50 start-50 translate-middle">
                                                <button class="btn btn-light btn-lg rounded-circle"
                                                    data-bs-toggle="modal" data-bs-target="#previewModal"
                                                    data-video-url="${firstPreviewVideoUrl}"
                                                    data-video-title="${firstPreviewVideoTitle}"
                                                    id="defaultPreviewBtn">
                                                    <i class="bi bi-play-fill fs-3"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body p-4">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <h3 class="fw-bold mb-0 text-primary"> <span>
                                                        <fmt:formatNumber value="${course.price}" type="number"
                                                            groupingUsed="true" maxFractionDigits="0" />
                                                        ₫
                                                    </span></h3>
                                            </div>
                                            <a href="/course/${course.id}/start" class="btn btn-primary w-100 btn-lg mb-3">
                                                Vào học ngay
                                            </a>
                                            <p class="text-center text-muted small mb-4">Đảm bảo hoàn tiền trong 30 ngày
                                            </p>
                                            <div>
                                                <h6 class="fw-bold mb-3">Khóa học này bao gồm:</h6>
                                                <ul class="list-unstyled">
                                                    <li class="mb-2"><i class="bi bi-play-circle me-2"></i>${totalVideos} video theo yêu cầu
                                                    </li>
                                                    <li class="mb-2"><i class="bi bi-clock me-2"></i>${totalMinutes} phút nội dung video</li>
                                                    <li class="mb-2"><i class="bi bi-file-text me-2"></i>${chapters.size()} chương học</li>
                                                    <li class="mb-2"><i class="bi bi-phone me-2"></i>Truy cập trên thiết
                                                        bị di động và
                                                        TV</li>
                                                    <li class="mb-2"><i class="bi bi-award me-2"></i>Giấy chứng nhận
                                                        hoàn thành</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Preview Modal -->
                    <div class="modal fade preview-modal" id="previewModal" tabindex="-1">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="previewModalTitle">Xem trước khóa học</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body p-0">
                                    <div class="video-container">
                                        <video id="coursePreviewVideo" controls>
                                            <source id="coursePreviewSource" src="" type="video/mp4">
                                            Trình duyệt của bạn không hỗ trợ video.
                                        </video>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Start footer -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- End footer -->

                    <!-- Bootstrap JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        const previewModal = document.getElementById("previewModal");
                        const modalTitle = document.getElementById("previewModalTitle");
                        const video = document.getElementById("coursePreviewVideo");
                        const source = document.getElementById("coursePreviewSource");

                        document.querySelectorAll(".open-video-topic").forEach((item) => {
                            item.addEventListener("click", () => {
                                const url = item.getAttribute("data-video-url");
                                const title = item.getAttribute("data-video-title");
                                modalTitle.textContent = title || "Xem trước khóa học";
                                source.src = url || "";
                                video.load();
                            });
                        });

                        document.querySelectorAll("[data-bs-target='#previewModal']").forEach((item) => {
                            item.addEventListener("click", () => {
                                if (item.classList.contains("open-video-topic")) {
                                    return;
                                }
                                const url = item.getAttribute("data-video-url");
                                const title = item.getAttribute("data-video-title");
                                modalTitle.textContent = title || "Xem trước khóa học";
                                source.src = url || "";
                                video.load();
                            });
                        });

                        previewModal.addEventListener("hidden.bs.modal", () => {
                            video.pause();
                            video.currentTime = 0;
                        });
                    </script>
                    <!-- Custom JS -->
                    <script src="js/main.js"></script>
                </body>

                </html>