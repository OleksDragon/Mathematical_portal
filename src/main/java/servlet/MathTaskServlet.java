package servlet;

import dao.MathTaskDAO;
import model.MathTask;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/tasks")
public class MathTaskServlet extends HttpServlet {
    private MathTaskDAO taskDAO = new MathTaskDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            if (action == null) {
                List<MathTask> tasks = taskDAO.getAllMathTask();
                req.setAttribute("tasks", tasks);
                req.getRequestDispatcher("list.jsp").forward(req, res);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                taskDAO.deleteMathTask(id);
                res.sendRedirect("tasks");
            } else if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            MathTask task = taskDAO.getTaskById(id);

            if (task == null) {  // Якщо задача не знайдена
                res.sendError(HttpServletResponse.SC_NOT_FOUND, "Задача не знайдена!");
                return;
            }

            req.setAttribute("task", task);
            req.getRequestDispatcher("form.jsp").forward(req, res);
        }
        } catch (SQLException e) {
            throw new ServletException("Помилка при видаленні задачі", e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String idParam = req.getParameter("id");
        String title = req.getParameter("title");
        String description = req.getParameter("description");

        String answerStr = req.getParameter("answer").replace(',', '.');
        float answer;

        try {
            answer = Float.parseFloat(answerStr);
        } catch (NumberFormatException e) {
            throw new ServletException("Помилка формату числа!", e);
        }

        int id = (idParam == null || idParam.isEmpty()) ? 0 : Integer.parseInt(idParam);

        MathTask task = new MathTask(id, title, description, answer);

        try {
            if (id > 0) {
                taskDAO.updateMathTask(task);
            } else {
                taskDAO.insertMathTask(task);
            }
            res.sendRedirect("tasks");
        } catch (SQLException e) {
            throw new ServletException("Помилка при збереженні задачі", e);
        }
    }
}
