package Helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {

    public static Connection con;
    public static Connection getConnection(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            if (con==null){
//                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keepapp","keepapp","");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3307/jdbc_dokkho","root","0000");
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return con;
    }
}
