package dao;

import model.User;
import util.DBConnection;
import util.ValidationUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Data Access Object for the User entity.
 * Encapsulates all SQL/JDBC logic so servlets never talk to the
 * database directly - they only call methods on this class.
 *
 * Matches the following table (PostgreSQL):
 *
 * CREATE TABLE Users (
 *     user_id SERIAL PRIMARY KEY,
 *     full_name VARCHAR(100) NOT NULL,
 *     username VARCHAR(50) NOT NULL UNIQUE,
 *     email VARCHAR(100) NOT NULL UNIQUE,
 *     password VARCHAR(255) NOT NULL,  -- stores "salt:hash"
 *     role VARCHAR(20) NOT NULL CHECK (role IN ('Storekeeper', 'Supervisor'))
 * );
 */
public class UserDAO {

    /**
     * Inserts a new user into the database. The plain-text password is
     * salted and hashed before being stored - it is never saved as-is.
     *
     * @param user User object populated with fullName, username, email,
     *             plain-text password, and role.
     * @return true if the insert succeeded, false otherwise
     */
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (full_name, username, email, password, role) "
                   + "VALUES (?, ?, ?, ?, ?)";

        // Generate a unique salt for this user and combine it with the hash
        // so both can be stored together in the single "password" column.
        String salt = ValidationUtil.generateSalt();
        String hashedPassword = ValidationUtil.hashPassword(user.getPassword(), salt);
        String storedPassword = salt + ":" + hashedPassword;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, storedPassword);
            stmt.setString(5, user.getRole());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Checks whether a username is already taken.
     */
    public boolean isUsernameTaken(String username) {
        String sql = "SELECT 1 FROM users WHERE username = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Checks whether an email is already registered.
     */
    public boolean isEmailTaken(String email) {
        String sql = "SELECT 1 FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Fetches a user by username, or null if no such user exists.
     */
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToUser(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Validates login credentials.
     *
     * @param username        the username entered at login
     * @param plainTextPassword the plain-text password entered at login
     * @return the matching User (with password field cleared) if credentials
     *         are correct, otherwise null
     */
    public User authenticate(String username, String plainTextPassword) {
        User user = getUserByUsername(username);
        if (user == null) {
            return null; // no such username
        }

        // Stored password is in "salt:hash" format - split it back apart.
        String[] parts = user.getPassword().split(":", 2);
        if (parts.length != 2) {
            return null; // corrupted/unexpected format, fail safely
        }
        String salt = parts[0];
        String storedHash = parts[1];

        boolean matches = ValidationUtil.verifyPassword(plainTextPassword, storedHash, salt);
        if (!matches) {
            return null; // wrong password
        }

        // Clear the password before handing the object back to the servlet/session
        // so the hash is never accidentally exposed further up the call chain.
        user.setPassword(null);
        return user;
    }

    /**
     * Maps the current row of a ResultSet to a User object.
     */
    private User mapRowToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("user_id"));
        user.setFullName(rs.getString("full_name"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password")); // still "salt:hash" here
        user.setRole(rs.getString("role"));
        return user;
    }
}