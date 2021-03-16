package DAO;

import java.sql.SQLException;
import java.util.List;

public interface Dao<Object,IdType> {

    int saveData(Object object) throws SQLException;
    List<Object> getAllData() throws SQLException;
    Object getById(IdType id);
    int update(Object object) throws SQLException;
    int delete(IdType id) throws SQLException;

}
