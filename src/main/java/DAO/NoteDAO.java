package DAO;

import Modal.Note;
import Modal.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NoteDAO implements Dao<Note, Integer> {

    private final Connection con;

    public NoteDAO(Connection con) {
        this.con = con;
    }

    @Override
    public int saveData(Note note) throws SQLException {
        String query = "insert into notes(title,body,user_id) value(?,?,?)";

        PreparedStatement pst = this.con.prepareStatement(query);
        pst.setString(1, note.getTitle());
        pst.setString(2, note.getBody());
        pst.setInt(3, note.getUser_id());
        int i = pst.executeUpdate();
        return i;
    }

    @Override
    public List<Note> getAllData() throws SQLException {
        String query = "select * from notes";
        PreparedStatement pst = this.con.prepareStatement(query);
        ResultSet resultSet = pst.executeQuery();


        List<Note> notes = new ArrayList<>();
        Note note = new Note();

        while (resultSet.next()) {
            note.setId(resultSet.getInt("id"));
            note.setTitle(resultSet.getString("title"));
            note.setBody(resultSet.getString("body"));
            note.setUser_id(resultSet.getInt("user_id"));
            notes.add(note);
        }
        return notes;
    }
    public List<Note> getAllByUserId(Integer id) {
        String query = "select * from notes where user_id = ? order by id desc";
        List<Note> notes = new ArrayList<>();
        try {
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1,id);
            ResultSet resultSet = pst.executeQuery();
            while (resultSet.next()) {
                Note note = new Note();
                note.setId(resultSet.getInt("id"));
                note.setTitle(resultSet.getString("title"));
                note.setBody(resultSet.getString("body"));
                note.setUser_id(resultSet.getInt("user_id"));
                notes.add(note);
            }
            resultSet.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notes;
    }

    @Override
    public Note getById(Integer id) {
        String query = "select * from user where id = ?";
        PreparedStatement pst = null;
        Note note = null;
        try {
            pst = this.con.prepareStatement(query);
            pst.setInt(1,id);
            ResultSet resultSet = pst.executeQuery();

            if ( resultSet.next()){
                note = new Note(
                        resultSet.getInt("id"),
                        resultSet.getString("title"),
                        resultSet.getString("body"),
                        resultSet.getInt("user_id")

                );
            }

            resultSet.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return note;
    }


    @Override
    public int update(Note note) throws SQLException {
        String query = "update notes set title =?, body =? where id =?";

        PreparedStatement pst = this.con.prepareStatement(query);
        pst.setString(1, note.getTitle());
        pst.setString(2, note.getBody());
        pst.setInt(3, note.getId());
        int i = pst.executeUpdate();
        return i;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        String query = "delete from notes where id =?";
        PreparedStatement pst = this.con.prepareStatement(query);
        pst.setInt(1, id);
        int i = pst.executeUpdate();
        return i;
    }
}
