/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;
import java.sql.Connection;
import util.DBConnection;
/**
 *
 * @author User
 */
public class TestdbConnection {

    public static void main(String[] args) {

        Connection conn = DBConnection.getConnection();

        if (conn != null) {
            System.out.println("Connected to Supabase successfully!");
        } else {
            System.out.println("Connection failed.");
        }

    }
}

