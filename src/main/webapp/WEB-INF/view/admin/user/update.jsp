<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Update-laptopWeb</title>

                <!-- Bootstrap 5 CSS -->
                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

                <!-- Bootstrap 5 JavaScript -->
                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
                </script>

                <!-- jQuery (tùy chọn, nếu bạn cần dùng) -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

                <link href="/css/demo.css" rel="stylesheet">
            </head>

            <body>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Update a user</h3>
                            <hr />

                            <form:form method="POST" action="/admin/user/update" modelAttribute="newUser">

                                <!-- ID -->
                                <div class="mb-3" style="display: none;">
                                    <label class="form-label">ID:</label>
                                    <form:input path="id" cssClass="form-control" />

                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Email:</label>
                                    <form:input path="email" cssClass="form-control" disabled="true" />
                                </div>


                                <div class="mb-3">
                                    <label class="form-label">Phone number:</label>
                                    <form:input path="phone" cssClass="form-control" />
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Full Name:</label>
                                    <form:input path="fullName" cssClass="form-control" />
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Address:</label>
                                    <form:input path="address" cssClass="form-control" />
                                </div>

                                <button class="btn btn-warning">Update</button>
                            </form:form>

                        </div>
                    </div>
                </div>
            </body>

            </html>