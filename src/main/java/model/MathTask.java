package model;

public class MathTask {
    private int id;
    private String title;
    private String description;
    private float answer;

    public MathTask(String title, String description, float answer) {
        this.title = title;
        this.description = description;
        this.answer = answer;
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getAnswer() {
        return answer;
    }

    public void setAnswer(float answer) {
        this.answer = answer;
    }
}
