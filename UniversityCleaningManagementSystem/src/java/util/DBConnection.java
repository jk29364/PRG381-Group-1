package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    private static final String URL = "jdbc:postgresql://localhost:5433/NEEDSNAME";
    private static final String USER = "NEEDSUSER";
    private static final String PASSWORD = "NEEDSPASSWORD!";

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            System.out.println("❌ - Database connection failed!");
            e.printStackTrace();
            return null;
        }
    }
}
