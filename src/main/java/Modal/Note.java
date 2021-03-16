package Modal;

public class Note {
    private int id;
    private String title;
    private String body;
    private int user_id;

    public Note() {
    }

    public Note(int id, String title, String body, int user_id) {
        this.id = id;
        this.title = title;
        this.body = body;
        this.user_id = user_id;
    }

    public Note(String title, String body, int user_id) {
        this.title = title;
        this.body = body;
        this.user_id = user_id;
    }

    public Note(int id, String title, String body) {
        this.id = id;
        this.title = title;
        this.body = body;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    @Override
    public String toString() {
        return "Note{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", body='" + body + '\'' +
                ", user_id=" + user_id +
                '}';
    }
}
