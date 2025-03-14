package org.example;

import java.sql.*;
import java.time.LocalDateTime;

public class OptimisticConcurrencyExample {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/test";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static void main(String[] args) {
        // Simulate two admins trying to update the same tournament concurrently
        int tournament_id = 1;

        // Create two threads for admin1 and admin2
        Thread admin1 = new Thread(() -> updateTournament(tournament_id, "Admin1"));
        Thread admin2 = new Thread(() -> updateTournament(tournament_id, "Admin2"));

        // Start both threads to simulate concurrent updates
        admin1.start();
        admin2.start();
    }

    public static void updateTournament(int tournament_id, String adminName) {
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASSWORD)) {
            conn.setAutoCommit(false); // Start transaction

            // Step 1: Read the tournament details with version
            String selectSQL = "SELECT version FROM tournaments WHERE tournament_id = ?";
            int currentVersion;

            try (PreparedStatement selectStmt = conn.prepareStatement(selectSQL)) {
                selectStmt.setInt(1, tournament_id);
                ResultSet rs = selectStmt.executeQuery();

                if (!rs.next()) {
                    System.out.println(adminName + " - Tournament not found.");
                    return;
                }

                currentVersion = rs.getInt("version");
                System.out.println(adminName + " - Read tournament version: " + currentVersion);
            }

            // Get the current date and time for start_date using LocalDateTime
            LocalDateTime currentDateTime = LocalDateTime.now();  // Get the current date and time

            // Convert LocalDateTime to Timestamp for MySQL DATETIME compatibility
            Timestamp timestamp = Timestamp.valueOf(currentDateTime);

            // Step 2: Attempt to update with OCC and update start_date
            String updateSQL = "UPDATE tournaments SET start_date = ?, version = version + 1 WHERE tournament_id = ? AND version = ?";
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSQL)) {
                updateStmt.setTimestamp(1, timestamp); // Set the current date and time for start_date
                updateStmt.setInt(2, tournament_id); // Set the tournament ID
                updateStmt.setInt(3, currentVersion); // Set the current version for optimistic concurrency control

                int rowsUpdated = updateStmt.executeUpdate();

                if (rowsUpdated == 0) {
                    System.out.println(adminName + " - Optimistic locking failed: The tournament was modified by another transaction.");
                    conn.rollback(); // Undo changes
                } else {
                    conn.commit(); // Commit transaction
                    System.out.println(adminName + " - Tournament updated successfully with new start date!");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
