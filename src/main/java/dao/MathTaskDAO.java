package dao;

import config.DatabaseConnection;
import model.MathTask;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MathTaskDAO {
    private static final String SELECT_ALL_TASK = "SELECT * FROM math_tasks ORDER BY id";
    private static final String INSERT_TASK = "INSERT INTO math_tasks VALUES(?,?,?)";
    private static final String UPDATE_TASK = "UPDATE math_tasks SET title=?, description=?, answer=? WHERE id = ?";
    private static final String DELETE_TASK = "DELETE FROM math_tasks WHERE id = ?";

    public List<MathTask> getAllMathTask() throws SQLException {
        List<MathTask> tasks = new ArrayList<MathTask>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_TASK);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String description = rs.getString("description");
                float answer = rs.getFloat("answer");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return tasks;
    }

    public void insertMathTask(MathTask task) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_TASK)) {
            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            stmt.setFloat(3, task.getAnswer());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void updateMathTask(MathTask task) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_TASK)) {
            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            stmt.setFloat(3, task.getAnswer());
            stmt.setInt(4, task.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void deleteMathTask(int id) throws SQLException {
        try (Connection conn = DatabaseConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(DELETE_TASK)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
