<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="dao.MathTaskDAO, model.MathTask, java.util.List, java.util.Collections" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Перевірка знань</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<%@ include file="header.jsp" %>
<%
    MathTaskDAO taskDAO = new MathTaskDAO();
    List<MathTask> allTasks = taskDAO.getAllMathTask();

    boolean newQuiz = request.getParameter("newQuiz") != null;
    if (newQuiz) {
        Collections.shuffle(allTasks);
        List<MathTask> quizTasks = allTasks.subList(0, Math.min(5, allTasks.size()));
        session.setAttribute("quizTasks", quizTasks);
        session.removeAttribute("quizResults");
    }

    // Отримуємо збережені задачі або генеруємо нові, якщо їх немає
    List<MathTask> quizTasks = (List<MathTask>) session.getAttribute("quizTasks");
    if (quizTasks == null) {
        Collections.shuffle(allTasks);
        quizTasks = allTasks.subList(0, Math.min(5, allTasks.size()));
        session.setAttribute("quizTasks", quizTasks);
    }

    // Перевіряємо, чи були введені відповіді
    boolean showResults = request.getMethod().equalsIgnoreCase("POST");

    // Якщо натиснули "Перевірити", зберігаємо результати у сесії
    if (showResults) {
        String[] results = new String[quizTasks.size()];
        int correctCount = 0;

        for (int i = 0; i < quizTasks.size(); i++) {
            String userAnswerStr = request.getParameter("answer" + i);
            float userAnswer = Float.parseFloat(userAnswerStr.replace(',', '.'));
            float correctAnswer = Float.parseFloat(request.getParameter("correctAnswer" + i));
            boolean isCorrect = userAnswer == correctAnswer;

            results[i] = isCorrect
                    ? "<p class='text-success'>Правильно!</p>"
                    : "<p class='text-danger'>Неправильно. Правильна відповідь: " + correctAnswer + "</p>";

            if (isCorrect) correctCount++;
        }

        session.setAttribute("quizResults", results);
        session.setAttribute("quizScore", correctCount);
    }

    // Отримуємо результати з сесії
    String[] quizResults = (String[]) session.getAttribute("quizResults");
    Integer quizScore = (Integer) session.getAttribute("quizScore");
%>

<div class="container">
    <h1 class="mt-4">Перевірка знань</h1>
    <form method="post" action="quiz.jsp">
        <% int index = 0; %>
        <% for (MathTask task : quizTasks) { %>
        <div class="mb-3">
            <label class="form-label"><%= task.getTitle() %>: <%= task.getDescription() %></label>
            <input type="text" name="answer<%= index %>" class="form-control" required>
            <input type="hidden" name="correctAnswer<%= index %>" value="<%= task.getAnswer() %>">
            <% if (quizResults != null) { %>
            <%= quizResults[index] %>
            <% } %>
        </div>
        <% index++; } %>

        <% if (quizResults == null) { %>
        <button type="submit" class="btn btn-primary">Перевірити</button>
        <% } %>
    </form>

    <% if (quizResults != null) { %>
    <h4 class="mt-3">Ваш результат: <%= quizScore %> / <%= quizTasks.size() %></h4>

    <form method="get" action="quiz.jsp">
        <input type="hidden" name="newQuiz" value="true">
        <button type="submit" class="btn btn-warning mt-3">Наступні завдання</button>
    </form>
    <% } %>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>