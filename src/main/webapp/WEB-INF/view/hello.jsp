<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>JSP</title>

            <!-- Bootstrap 5 CSS -->
            <!-- Latest compiled and minified CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

            <!-- Bootstrap 5 JavaScript -->
            <!-- Latest compiled JavaScript -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
            </script>

            <!-- jQuery (tùy chọn, nếu bạn cần dùng) -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

            <link rel="stylesheet" href="/css/demo.css">

        </head>

        <body>
            Hello from JSP
            <h1>
                ${roy}
            </h1>
            <h2>
                ${royhung}
            </h2>
            <button>Submit</button>
        </body>

        </html>