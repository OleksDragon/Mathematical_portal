<%@ page import="dao.MathTaskDAO, model.MathTask" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    MathTaskDAO taskDAO = new MathTaskDAO();
    MathTask task = taskDAO.getTaskById(id);
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Розв’язання задачі</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <h1 class="mt-4"><%= task.getTitle() %></h1>
    <p><%= task.getDescription() %></p>
    <form method="post" action="">
        <input type="text" name="userAnswer" class="form-control" required
               onkeypress="if(event.key === ',') { event.preventDefault(); this.value += '.'; }">
        <button type="submit" class="btn btn-success mt-3">Перевірити</button>
    </form>

    <%
        String userAnswer = request.getParameter("userAnswer");
        if (userAnswer != null) {
            float correctAnswer = task.getAnswer();
            if (Float.parseFloat(userAnswer) == correctAnswer) {
    %>
    <p class="text-success">Правильно!</p>
    <% } else { %>
    <p class="text-danger">Неправильно. Спробуйте ще раз!</p>
    <% } } %>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
