<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <title>Course Detail</title>

                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <style>
                        .admin-course-wrap {
                            max-width: 1280px;
                            margin: 0 auto;
                        }

                        .hero-admin {
                            border: 0;
                            border-radius: 1rem;
                            background: linear-gradient(135deg, #2f80ed 0%, #6a5cff 100%);
                            color: #fff;
                            box-shadow: 0 10px 26px rgba(47, 128, 237, .22);
                        }

                        .hero-admin .meta-badge {
                            background: rgba(255, 255, 255, .22);
                            color: #fff;
                            border-radius: 999px;
                            padding: .3rem .7rem;
                            font-size: .82rem;
                            margin-right: .4rem;
                        }

                        .thumbnail-admin {
                            border-radius: 1rem;
                            width: 100%;
                            max-height: 260px;
                            object-fit: cover;
                            box-shadow: 0 10px 24px rgba(0, 0, 0, .18);
                            border: 3px solid rgba(255, 255, 255, .32);
                        }

                        .section-card {
                            border: 1px solid #e9edf3;
                            border-radius: 1rem;
                        }

                        .chapter-box {
                            border: 1px solid #ececec;
                            border-radius: .75rem;
                            overflow: hidden;
                            margin-bottom: 1rem;
                        }

                        .chapter-header {
                            background: #f7b733;
                            color: #222;
                            font-weight: 700;
                            padding: .65rem .9rem;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                        }

                        .chapter-body {
                            padding: .9rem;
                            background: #fff;
                        }

                        .topic-row {
                            padding: .5rem .75rem;
                            background: #f8f9fc;
                            border: 1px solid #eef1f5;
                            border-radius: .6rem;
                            margin-top: .45rem;
                        }

                        .video-container {
                            width: 100%;
                            aspect-ratio: 16 / 9;
                            background: #000;
                            overflow: hidden;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                        }

                        .video-container video {
                            height: 100%;
                            width: auto;
                            max-width: 86%;
                            object-fit: contain;
                            display: block;
                        }
                    </style>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />

                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />

                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4 admin-course-wrap">
                                    <h1 class="mt-4">Chi tiết khóa học</h1>

                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Bảng điều khiển</a></li>
                                        <li class="breadcrumb-item"><a href="/admin/course">Khóa học</a></li>
                                        <li class="breadcrumb-item active">Chi tiết</li>
                                    </ol>

                                    <div class="card hero-admin mb-4">
                                        <div class="card-body p-4 p-lg-5">
                                            <div class="row g-4 align-items-center">
                                                <div class="col-lg-8">
                                                    <div
                                                        class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-2">
                                                        <h2 class="mb-0">${course.name}</h2>
                                                        <a href="/admin/course" class="btn btn-light btn-sm">Quay lại
                                                            danh sách khóa học</a>
                                                    </div>
                                                    <p class="mb-3 opacity-75">${course.shortDesc}</p>
                                                    <div class="mb-3">
                                                        <span class="meta-badge">Tác giả: ${course.author}</span>
                                                        <span class="meta-badge">Cấp độ: ${course.level}</span>
                                                        <span class="meta-badge">Danh mục: ${course.title}</span>
                                                    </div>
                                                    <h4 class="mb-0">
                                                        <fmt:formatNumber value="${course.price}" pattern="#,##0" /> VNĐ
                                                    </h4>
                                                </div>
                                                <div class="col-lg-4">
                                                    <c:if test="${not empty course.thumbnail}">
                                                        <img src="${pageContext.request.contextPath}/images/course/${course.thumbnail}"
                                                            alt="${course.name}" class="thumbnail-admin" />
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row g-4">
                                        <div class="col-xl-8">
                                            <div class="card section-card mb-4">
                                                <div
                                                    class="card-header bg-white d-flex justify-content-between align-items-center">
                                                    <span class="fw-semibold">
                                                        <i class="fas fa-list me-2 text-primary"></i>
                                                        Danh sách chương
                                                    </span>
                                                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                                        data-bs-target="#addChapterModal">
                                                        <i class="fas fa-plus me-1"></i> Thêm chương
                                                    </button>
                                                </div>
                                                <div class="card-body">
                                                    <c:forEach var="chapter" items="${chapters}">
                                                        <div class="chapter-box">
                                                            <div class="chapter-header">
                                                                <span>${chapter.position}. ${chapter.title}</span>
                                                                <span
                                                                    class="badge bg-dark">${chapter.lessons.size()}</span>
                                                            </div>
                                                            <div class="chapter-body">
                                                                <div class="d-flex flex-wrap gap-2 mb-2">
                                                                    <button type="button"
                                                                        class="btn btn-warning btn-sm open-topic-modal"
                                                                        data-chapter-id="${chapter.id}"
                                                                        data-chapter-title="${chapter.title}"
                                                                        data-next-topic-no="${chapter.lessons.size() + 1}"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target="#addTopicModal">
                                                                        Thêm bài học
                                                                    </button>
                                                                    <a href="/admin/course/${course.id}/chapter/${chapter.id}/update"
                                                                        class="btn btn-outline-warning btn-sm">Cập
                                                                        nhật</a>
                                                                    <form
                                                                        action="/admin/course/${course.id}/chapter/${chapter.id}/delete"
                                                                        method="post" class="d-inline"
                                                                        onsubmit="return confirm('Bạn có chắc muốn xóa chapter này?');">
                                                                        <input type="hidden"
                                                                            name="${_csrf.parameterName}"
                                                                            value="${_csrf.token}" />
                                                                        <button type="submit"
                                                                            class="btn btn-outline-danger btn-sm">Xóa</button>
                                                                    </form>
                                                                    <span
                                                                        class="badge ${chapter.status == 'ACTIVE' ? 'bg-success' : 'bg-secondary'} ms-auto">
                                                                        ${chapter.status}
                                                                    </span>
                                                                </div>
                                                                <p class="text-muted mb-2">${empty chapter.description ?
                                                                    'Chưa có mô tả chương.' : chapter.description}</p>

                                                                <c:forEach var="topic" items="${chapter.lessons}">
                                                                    <div
                                                                        class="topic-row d-flex justify-content-between align-items-center">
                                                                        <button type="button"
                                                                            class="btn btn-link p-0 text-start text-decoration-none open-admin-video-topic"
                                                                            data-video-url="${topic.videoUrl}"
                                                                            data-video-title="${topic.title}"
                                                                            data-bs-toggle="modal"
                                                                            data-bs-target="#adminVideoPreviewModal">
                                                                            <i class="fas fa-video me-2 text-dark"></i>
                                                                            <span class="text-dark">
                                                                                <strong>${chapter.position}.${topic.position}</strong>
                                                                                - ${topic.title}
                                                                            </span>
                                                                            <c:if test="${topic.preview}">
                                                                                <span class="badge bg-success ms-1">Học
                                                                                    thử</span>
                                                                            </c:if>
                                                                        </button>
                                                                        <span
                                                                            class="badge bg-light text-dark">${topic.duration}
                                                                            phút</span>
                                                                    </div>
                                                                </c:forEach>
                                                                <c:if test="${empty chapter.lessons}">
                                                                    <p class="text-center text-muted mb-0">Hiện tại chưa
                                                                        có chương học nào được tạo cho khóa học này.</p>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </c:forEach>

                                                    <c:if test="${empty chapters}">
                                                        <p class="mb-0 text-muted">Chưa có chủ đề nào.</p>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-xl-4">
                                            <div class="card section-card">
                                                <div class="card-header bg-white fw-semibold">Mô tả chi tiết khóa học
                                                </div>
                                                <div class="card-body">
                                                    <p class="mb-0">${course.detailDesc}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </main>

                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </div>

                    <div class="modal fade" id="addChapterModal" tabindex="-1">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header bg-warning">
                                    <h5 class="modal-title">Thêm chương học</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <form:form method="POST" action="/admin/course/${course.id}/chapter/create"
                                        modelAttribute="newChapter" class="row g-3">
                                        <div class="col-md-3">
                                            <label class="form-label">Số thứ tự</label>
                                            <form:input path="position" type="number" min="1" class="form-control" />
                                            <form:errors path="position" cssClass="text-danger small d-block mt-1" />
                                        </div>
                                        <div class="col-md-9">
                                            <label class="form-label">Tên chương</label>
                                            <form:input path="title" class="form-control" />
                                            <form:errors path="title" cssClass="text-danger small d-block mt-1" />
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label">Mô tả chương</label>
                                            <form:textarea path="description" rows="3" class="form-control" />
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label">Trạng thái</label>
                                            <form:select path="status" class="form-select">
                                                <form:option value="ACTIVE">Hoạt động</form:option>
                                                <form:option value="DRAFT">Bản nháp</form:option>
                                            </form:select>
                                        </div>
                                        <div class="col-12">
                                            <button type="submit" class="btn btn-warning">Thêm chương học</button>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="addTopicModal" tabindex="-1">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header bg-warning">
                                    <h5 class="modal-title">Thêm bài học</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <form id="addTopicForm" method="POST" enctype="multipart/form-data" class="row g-3">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <div class="col-md-3">
                                            <label class="form-label">Số thứ tự</label>
                                            <input id="topicPosition" name="position" type="number" min="1"
                                                class="form-control" required />
                                            <div class="form-text">Thứ tự hiển thị trên giao diện được định dạng theo
                                                chương.chủ đề (ví dụ: 2.1).</div>
                                        </div>
                                        <div class="col-md-9">
                                            <label class="form-label">Tên chương</label>
                                            <input name="title" class="form-control" required />
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label">Mô tả chương</label>
                                            <textarea name="description" rows="3" class="form-control"></textarea>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label">Thời lượng (phút)</label>
                                            <input name="duration" type="number" min="0" class="form-control"
                                                value="0" />
                                        </div>
                                        <div class="col-md-4 d-flex align-items-end">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="preview"
                                                    id="previewInline">
                                                <label class="form-check-label" for="previewInline">Xem trước</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label">Chọn video bài học (mp4, mov)</label>
                                            <input name="videoFile" type="file"
                                                accept=".mp4,.mov,video/mp4,video/quicktime" class="form-control"
                                                required />
                                        </div>
                                        <div class="col-12">
                                            <button type="submit" class="btn btn-warning">Thêm chủ đề bài học</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="adminVideoPreviewModal" tabindex="-1">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="adminVideoPreviewTitle">Xem video topic</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body p-0">
                                    <div class="video-container">
                                        <video id="adminVideoPlayer" controls>
                                            <source id="adminVideoSource" src="" type="video/mp4">
                                            Trình duyệt của bạn không hỗ trợ video.
                                        </video>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script src="/js/scripts.js"></script>
                    <script>
                        document.querySelectorAll(".open-topic-modal").forEach(function (btn) {
                            btn.addEventListener("click", function () {
                                const chapterId = btn.getAttribute("data-chapter-id");
                                const nextTopicNo = btn.getAttribute("data-next-topic-no") || "1";
                                const form = document.getElementById("addTopicForm");
                                const positionInput = document.getElementById("topicPosition");
                                form.action = "/admin/course/${course.id}/chapter/" + chapterId + "/topic/create-inline";
                                positionInput.value = nextTopicNo;
                            });
                        });

                        const adminVideoModal = document.getElementById("adminVideoPreviewModal");
                        const adminVideoTitle = document.getElementById("adminVideoPreviewTitle");
                        const adminVideoPlayer = document.getElementById("adminVideoPlayer");
                        const adminVideoSource = document.getElementById("adminVideoSource");

                        document.querySelectorAll(".open-admin-video-topic").forEach(function (btn) {
                            btn.addEventListener("click", function () {
                                const videoUrl = btn.getAttribute("data-video-url") || "";
                                const videoTitle = btn.getAttribute("data-video-title") || "Xem video topic";
                                adminVideoTitle.textContent = videoTitle;
                                adminVideoSource.src = videoUrl;
                                adminVideoPlayer.load();
                            });
                        });

                        adminVideoModal.addEventListener("hidden.bs.modal", function () {
                            adminVideoPlayer.pause();
                            adminVideoPlayer.currentTime = 0;
                        });
                    </script>
                </body>

                </html>