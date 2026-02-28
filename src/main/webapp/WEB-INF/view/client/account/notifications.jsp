<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thong bao</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="/client/css/style.css">
    </head>

    <body>
        <jsp:include page="../layout/header.jsp" />

        <section class="py-5 mt-5">
            <div class="container">
                <h2 class="fw-bold mb-3">Thong bao</h2>
                <div class="alert alert-info mb-0">
                    Ban chua co thong bao nao.
                </div>
            </div>
        </section>

        <jsp:include page="../layout/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>
