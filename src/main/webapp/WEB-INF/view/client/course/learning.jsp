<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Học: ${course.name}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background: #f7f9fc; color: #1f2937; }
        .learning-topbar {
            background: #111827;
            color: #f9fafb;
            height: 52px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 1rem;
            position: sticky;
            top: 0;
            z-index: 1030;
            border-bottom: 1px solid rgba(255, 255, 255, .12);
        }
        .learning-topbar .brand { font-weight: 700; letter-spacing: .2px; }
        .learning-topbar .progress-text { font-size: .9rem; color: #d1d5db; }
        .learning-topbar .account-btn {
            color: #e5e7eb;
            border: 1px solid rgba(255, 255, 255, .18);
            background: rgba(255, 255, 255, .06);
            border-radius: .45rem;
            padding: .25rem .55rem;
            font-size: .85rem;
        }
        .learning-topbar .account-btn:hover {
            background: rgba(255, 255, 255, .12);
            color: #fff;
        }
        .hero-learning {
            background: #111827;
            padding: 14px 12px 16px;
            display: grid;
            grid-template-columns: minmax(0, 1fr) 340px;
            gap: 10px;
        }
        .player-wrap {
            width: 100%;
            aspect-ratio: 16 / 9;
            background: #000;
            border-radius: .35rem;
            overflow: hidden;
        }
        .player-wrap video { width: 100%; height: 100%; object-fit: contain; }
        .curriculum-panel {
            background: #fff;
            border-radius: .35rem;
            border: 1px solid #e5e7eb;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            max-height: calc(100vh - 90px);
        }
        .curriculum-header {
            padding: .8rem .9rem;
            border-bottom: 1px solid #eef2f7;
            font-weight: 600;
            font-size: .95rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #fff;
        }
        .curriculum-body { overflow: auto; padding: .35rem; }
        .accordion-button { padding: .6rem .75rem; font-size: .88rem; font-weight: 600; }
        .lesson-item {
            cursor: pointer;
            border-left: 3px solid transparent !important;
            transition: all .2s ease;
            font-size: .86rem;
            padding: .55rem .6rem;
            color: #111827;
            background: #fff;
        }
        .lesson-item:hover {
            background: #f8fafc;
        }
        .lesson-item.active { background: #eef2ff !important; border-left: 3px solid #6366f1 !important; }
        .lesson-item.active .lesson-title { color: #0f172a; font-weight: 700; }
        .lesson-item.active .status-icon i { color: #4f46e5 !important; }
        .lesson-item.completed .lesson-title { color: #111827; font-weight: 600; }
        .chapter-meta { font-size: .78rem; color: #6b7280; }
        .status-icon { width: 22px; text-align: center; }
        .learning-content {
            max-width: 1180px;
            margin: 0 auto;
            padding: 1.2rem;
        }
        .tabs-line {
            border-bottom: 1px solid #e5e7eb;
            margin-bottom: 1rem;
            display: flex;
            gap: 1rem;
            font-size: .9rem;
        }
        .tabs-line .active {
            color: #4f46e5;
            border-bottom: 2px solid #4f46e5;
            padding-bottom: .45rem;
            margin-bottom: -1px;
            font-weight: 600;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 10px;
            margin: 1rem 0 1.3rem;
        }
        .stat-card {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: .75rem;
            padding: .8rem;
        }
        .stat-card .label { font-size: .78rem; color: #6b7280; }
        .stat-card .value { font-weight: 700; font-size: 1rem; margin-top: .25rem; }
        .progress-box {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: .75rem;
            padding: .9rem;
            margin-bottom: 1rem;
        }
        @media (max-width: 992px) {
            .hero-learning { grid-template-columns: 1fr; }
            .curriculum-panel { max-height: none; }
            .stats-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
        }
    </style>
</head>
<body>
    <div class="learning-topbar">
        <div class="d-flex align-items-center gap-3">
            <a href="/course/${course.id}" class="text-white text-decoration-none">
                <i class="bi bi-arrow-left"></i>
            </a>
            <span class="brand">${course.name}</span>
        </div>
        <div class="d-flex align-items-center gap-2">
            <div class="progress-text">
                Tiến độ của bạn:
                <strong><span id="completedLessons">0</span>/<span id="totalLessons">0</span></strong>
                (<span id="progressPercent">0</span>%)
            </div>
            <div class="dropdown">
                <button class="btn account-btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-person-circle me-1"></i> Tài khoản
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="/account/profile">Hồ sơ</a></li>
                    <li><a class="dropdown-item" href="/home/my-courses/learning">Khóa học của tôi</a></li>
                    <li><a class="dropdown-item" href="/account/purchase-history">Lịch sử mua</a></li>
                </ul>
            </div>
        </div>
    </div>

    <section class="hero-learning">
        <div>
            <div class="player-wrap">
                <video id="learningVideo" controls>
                    <source id="learningVideoSource" src="${defaultVideoUrl}" type="video/mp4">
                    Trình duyệt không hỗ trợ video.
                </video>
            </div>
        </div>
        <aside class="curriculum-panel">
            <div class="curriculum-header">
                <span>Nội dung khóa học</span>
                <span class="chapter-meta">${chapters.size()} chương</span>
            </div>
            <div class="curriculum-body">
                <div class="accordion" id="learningAccordion">
                    <c:forEach var="chapter" items="${chapters}" varStatus="chapterStatus">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button ${chapterStatus.first ? '' : 'collapsed'}" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#learningSection${chapter.id}">
                                    <div class="w-100 d-flex justify-content-between align-items-center me-2">
                                        <span>Phần ${chapter.position}: ${chapter.title}</span>
                                        <span class="chapter-meta">${chapter.lessons.size()} bài</span>
                                    </div>
                                </button>
                            </h2>
                            <div id="learningSection${chapter.id}" class="accordion-collapse collapse ${chapterStatus.first ? 'show' : ''}"
                                data-bs-parent="#learningAccordion">
                                <div class="accordion-body p-0">
                                    <c:if test="${not empty chapter.description}">
                                        <div class="px-3 py-2 chapter-meta">${chapter.description}</div>
                                    </c:if>
                                    <div class="list-group list-group-flush">
                                        <c:forEach var="topic" items="${chapter.lessons}" varStatus="lessonStatus">
                                            <button type="button"
                                                    class="list-group-item list-group-item-action lesson-item text-start ${chapterStatus.first && lessonStatus.first ? 'active' : ''}"
                                                    data-lesson-id="${topic.id}"
                                                    data-video-url="${topic.videoUrl}"
                                                    data-video-title="${topic.title}">
                                                <div class="d-flex justify-content-between align-items-center gap-2">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <span class="status-icon"><i class="bi bi-circle text-secondary"></i></span>
                                                        <span class="lesson-title">${chapter.position}.${topic.position} - ${topic.title}</span>
                                                    </div>
                                                    <span class="chapter-meta">${topic.duration} phút</span>
                                                </div>
                                            </button>
                                        </c:forEach>
                                        <c:if test="${empty chapter.lessons}">
                                            <div class="list-group-item text-muted">Chưa có bài học.</div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </aside>
    </section>

    <section class="learning-content">
        <div class="tabs-line">
            <span class="active">Tổng quan</span>
            <span>Hỏi & Đáp</span>
            <span>Ghi chú</span>
            <span>Đánh giá</span>
        </div>

        <h3 id="currentLessonTitle" class="mb-2">${defaultVideoTitle}</h3>
        <p class="text-muted mb-3">${course.shortDesc}</p>

        <div class="progress-box">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div>
                    <div class="fw-semibold">Đánh giá bằng tiến độ của bạn</div>
                    <div class="chapter-meta">Một bài học được đánh dấu hoàn thành khi xem >= 2/3 thời lượng video.</div>
                </div>
                <div class="text-end">
                    <div class="chapter-meta">Đã hoàn thành</div>
                    <div class="fw-bold"><span id="completedLessonsContent">0</span>/<span id="totalLessonsContent">0</span> video</div>
                </div>
            </div>
            <div class="progress mt-3" style="height: 10px; background: #e5e7eb;">
                <div id="progressBar" class="progress-bar bg-success" style="width: 0%"></div>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="label">Cấp độ</div>
                <div class="value">${course.level}</div>
            </div>
            <div class="stat-card">
                <div class="label">Số chương</div>
                <div class="value">${chapters.size()}</div>
            </div>
            <div class="stat-card">
                <div class="label">Ngôn ngữ</div>
                <div class="value">Tiếng Việt</div>
            </div>
            <div class="stat-card">
                <div class="label">Cập nhật gần đây</div>
                <div class="value">Mới nhất</div>
            </div>
        </div>

        <h4>Mô tả</h4>
        <p class="mb-0">${course.detailDesc}</p>
    </section>

    <jsp:include page="../layout/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const courseId = "${course.id}";
        const storageKey = "learning-progress-course-" + courseId;
        const activeLessonKey = "learning-active-lesson-" + courseId;
        const video = document.getElementById("learningVideo");
        const source = document.getElementById("learningVideoSource");
        const title = document.getElementById("currentLessonTitle");
        const lessonItems = document.querySelectorAll(".lesson-item");
        const totalLessonsEl = document.getElementById("totalLessons");
        const completedLessonsEl = document.getElementById("completedLessons");
        const totalLessonsContentEl = document.getElementById("totalLessonsContent");
        const completedLessonsContentEl = document.getElementById("completedLessonsContent");
        const progressPercentEl = document.getElementById("progressPercent");
        const progressBarEl = document.getElementById("progressBar");
        let activeLessonId = lessonItems.length ? lessonItems[0].getAttribute("data-lesson-id") : null;
        let progressMap = {};

        try {
            progressMap = JSON.parse(localStorage.getItem(storageKey) || "{}");
        } catch (e) {
            progressMap = {};
        }

        const saveProgress = () => {
            localStorage.setItem(storageKey, JSON.stringify(progressMap));
        };

        const expandParentChapter = (item) => {
            const collapseEl = item.closest(".accordion-collapse");
            if (!collapseEl) return;
            const collapseInstance = bootstrap.Collapse.getOrCreateInstance(collapseEl, { toggle: false });
            collapseInstance.show();
        };

        const setActiveLesson = (item, autoPlay = true) => {
            source.src = item.getAttribute("data-video-url") || "";
            title.textContent = item.getAttribute("data-video-title") || "";
            activeLessonId = item.getAttribute("data-lesson-id");
            localStorage.setItem(activeLessonKey, activeLessonId || "");
            lessonItems.forEach((x) => x.classList.remove("active"));
            item.classList.add("active");
            expandParentChapter(item);
            video.load();
            if (autoPlay) {
                video.play().catch(() => {});
            }
        };

        const updateProgressUI = () => {
            const total = lessonItems.length;
            const completed = Array.from(lessonItems)
                .filter((item) => progressMap[item.getAttribute("data-lesson-id")] === true).length;
            const percent = total === 0 ? 0 : Math.round((completed * 100) / total);
            totalLessonsEl.textContent = total;
            completedLessonsEl.textContent = completed;
            totalLessonsContentEl.textContent = total;
            completedLessonsContentEl.textContent = completed;
            progressPercentEl.textContent = percent;
            progressBarEl.style.width = percent + "%";
        };

        const updateLessonCheckUI = () => {
            lessonItems.forEach((item) => {
                const lessonId = item.getAttribute("data-lesson-id");
                const iconWrap = item.querySelector(".status-icon");
                if (!iconWrap) return;
                if (progressMap[lessonId] === true) {
                    item.classList.add("completed");
                    iconWrap.innerHTML = '<i class="bi bi-check-circle-fill text-success"></i>';
                } else {
                    item.classList.remove("completed");
                    iconWrap.innerHTML = '<i class="bi bi-circle text-secondary"></i>';
                }
            });
        };

        lessonItems.forEach((item) => {
            item.addEventListener("click", () => {
                setActiveLesson(item, true);
            });
        });

        video.addEventListener("timeupdate", () => {
            if (!activeLessonId) return;
            const duration = video.duration;
            if (!Number.isFinite(duration) || duration <= 0) return;
            if (video.currentTime >= (duration * 2 / 3) && progressMap[activeLessonId] !== true) {
                progressMap[activeLessonId] = true;
                saveProgress();
                updateLessonCheckUI();
                updateProgressUI();
            }
        });

        const savedActiveLessonId = localStorage.getItem(activeLessonKey);
        const initialLesson = Array.from(lessonItems).find((item) =>
            item.getAttribute("data-lesson-id") === savedActiveLessonId)
            || Array.from(lessonItems).find((item) => item.classList.contains("active"))
            || lessonItems[0];
        if (initialLesson) {
            setActiveLesson(initialLesson, false);
        }

        updateLessonCheckUI();
        updateProgressUI();
    </script>
</body>
</html>
