package DAO;


import Modal.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO implements Dao<User, Integer> {

    private final Connection con;

    public UserDAO(Connection con) {
        this.con = con;
    }

    @Override
    public int saveData(User user) throws SQLException {
        String query = "insert into user(name,email,password) value(?,?,?)";

        PreparedStatement pst = this.con.prepareStatement(query);
        pst.setString(1, user.getName());
        pst.setString(2, user.getEmail());
        pst.setString(3, user.getPassword());
        int i = pst.executeUpdate();
        return i;
    }

    @Override
    public List<User> getAllData() throws SQLException {
        String query = "select * from user";
        PreparedStatement pst = this.con.prepareStatement(query);
        ResultSet resultSet = pst.executeQuery();


        List<User> users = new ArrayList<>();
        User user = new User();

        if (resultSet.next()) {

            user.setId(resultSet.getInt("id"));
            user.setName(resultSet.getString("name"));
            user.setEmail(resultSet.getString("email"));
            user.setPassword(resultSet.getString("password"));
            users.add(user);
        }
        return users;
    }

    @Override
    public User getById(Integer id) {
        return null;
    }

    public User getByEmail(String email) {
        String query = "select * from user where email = ?";
        PreparedStatement pst = null;
        User user = null;
        try {
            pst = this.con.prepareStatement(query);
            pst.setString(1,email);
            ResultSet resultSet = pst.executeQuery();

            while ( resultSet.next()){
                user = new User(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("password")

                );
            }

            resultSet.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return user;
    }

    @Override
    public int update(User user) throws SQLException {
        String query = "update user set name =?, email =?, password =?  where id =?";

        PreparedStatement pst = this.con.prepareStatement(query);
        pst.setString(1, user.getName());
        pst.setString(2, user.getEmail());
        pst.setString(3, user.getPassword());
        pst.setInt(4, user.getId());
        int i = pst.executeUpdate();
        return i;
    }

    @Override
    public int delete(Integer id) throws SQLException {
        String query = "delete from user where id =?";
        PreparedStatement pst = this.con.prepareStatement(query);
        pst.setInt(1, id);
        int i = pst.executeUpdate();
        return i;
    }
}
