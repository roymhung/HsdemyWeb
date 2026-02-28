<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Add Topic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
                    <h1 class="mt-4">Add Topic (Video)</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="/admin/course">Course</a></li>
                        <li class="breadcrumb-item"><a href="/admin/course/${course.id}">Course Detail</a></li>
                        <li class="breadcrumb-item active">Chapter ${chapter.position}</li>
                    </ol>

                    <div class="alert alert-info">
                        <strong>Chapter:</strong> ${chapter.title}
                    </div>

                    <div class="card mb-4">
                        <div class="card-header fw-semibold">Thêm Topic mới</div>
                        <div class="card-body">
                            <form:form method="POST" action="/admin/chapter/${chapter.id}/topic/create" modelAttribute="newTopic"
                                enctype="multipart/form-data" class="row g-3">
                                <div class="col-md-2">
                                    <label class="form-label">Sr No</label>
                                    <form:input path="position" type="number" min="1" class="form-control" />
                                    <form:errors path="position" cssClass="text-danger small d-block mt-1" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Title (Tên video)</label>
                                    <form:input path="title" class="form-control" />
                                    <form:errors path="title" cssClass="text-danger small d-block mt-1" />
                                </div>

                                <div class="col-md-2">
                                    <label class="form-label">Duration (phút)</label>
                                    <form:input path="duration" type="number" min="0" class="form-control" />
                                </div>

                                <div class="col-md-2 d-flex align-items-end">
                                    <div class="form-check">
                                        <form:checkbox path="preview" class="form-check-input" id="previewCheck" />
                                        <label class="form-check-label" for="previewCheck">Is Preview</label>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Description</label>
                                    <form:textarea path="description" rows="3" class="form-control" />
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Video Upload (mp4, mov)</label>
                                    <input type="file" name="videoFile" accept=".mp4,.mov,video/mp4,video/quicktime"
                                        class="form-control" required />
                                    <form:errors path="videoUrl" cssClass="text-danger small d-block mt-1" />
                                </div>

                                <div class="col-12 d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">Save Topic</button>
                                    <a href="/admin/course/${course.id}" class="btn btn-outline-secondary">Back Course Detail</a>
                                </div>
                            </form:form>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <div class="card-header fw-semibold">Danh sách Topic hiện tại</div>
                        <div class="card-body table-responsive">
                            <table class="table table-bordered align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Sr No</th>
                                        <th>Title</th>
                                        <th>Duration</th>
                                        <th>Preview</th>
                                        <th>Video Path</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="topic" items="${topics}">
                                        <tr>
                                            <td>${topic.position}</td>
                                            <td>${topic.title}</td>
                                            <td>${topic.duration} phút</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${topic.preview}">
                                                        <span class="badge bg-success">Yes</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">No</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><code>${topic.videoUrl}</code></td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty topics}">
                                        <tr>
                                            <td colspan="5" class="text-center text-muted">Chưa có topic nào.</td>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/js/scripts.js"></script>
</body>

</html>
