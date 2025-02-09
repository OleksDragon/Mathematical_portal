<%@ page import="model.MathTask" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Редагування задачі</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <h1 class="mt-4">Форма задачі</h1>
    <%
        MathTask task = (MathTask) request.getAttribute("task");
        boolean isEdit = (task != null);
    %>
    <form method="post" action="tasks">
        <input type="hidden" name="id" value="<%= isEdit ? task.getId() : "" %>">
        <div class="mb-3">
            <label class="form-label">Назва задачі:</label>
            <input type="text" name="title" class="form-control" required value="<%= isEdit ? task.getTitle() : "" %>">
        </div>
        <div class="mb-3">
            <label class="form-label">Опис задачі:</label>
            <textarea name="description" class="form-control" required><%= isEdit ? task.getDescription() : "" %></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Правильна відповідь:</label>
            <input type="text" name="answer" class="form-control" required pattern="[0-9]+([.,][0-9]+)?"
                   oninput="this.value = this.value.replace(',', '.');"
                   value="<%= isEdit ? task.getAnswer() : "" %>">
        </div>
        <button type="submit" class="btn btn-primary">Зберегти</button>
    </form>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
