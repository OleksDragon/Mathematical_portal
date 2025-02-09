<%@ page import="java.util.List, model.MathTask" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Список задач</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <h1 class="mt-4">Список математичних задач</h1>
    <a href="form.jsp" class="btn btn-success mb-3">Додати задачу</a>
    <table class="table table-bordered">
        <tr>
            <th>ID</th>
            <th>Назва</th>
            <th>Опис</th>
            <th>Дії</th>
        </tr>
        <%
            List<MathTask> tasks = (List<MathTask>) request.getAttribute("tasks");
            for (MathTask task : tasks) {
        %>
        <tr>
            <td><%= task.getId() %></td>
            <td><%= task.getTitle() %></td>
            <td><%= task.getDescription() %></td>
            <td>
                <a href="tasks?action=edit&id=<%= task.getId() %>" class="btn btn-warning">Редагувати</a>
                <a href="tasks?action=delete&id=<%= task.getId() %>" class="btn btn-danger">Видалити</a>
                <a href="solve.jsp?id=<%= task.getId() %>" class="btn btn-info">Розв’язати</a>
            </td>
        </tr>
        <% } %>
    </table>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
