package dao;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.MuscleRecord;


public class MuscleRecordDAO {
	private static Connection getConnection() throws URISyntaxException, SQLException {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	    URI dbUri = new URI(System.getenv("DATABASE_URL"));

	    String username = dbUri.getUserInfo().split(":")[0];
	    String password = dbUri.getUserInfo().split(":")[1];
	    String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath();

	    return DriverManager.getConnection(dbUrl, username, password);

	}
	
	public static MuscleRecord selectLatestMuscleRecord() {
        String sql = "SELECT * FROM training_records ORDER BY date DESC LIMIT 1";
        MuscleRecord latestRecord = null;

        try (
            Connection con = getConnection();
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()
        ) {
            if (rs.next()) {
                int training_record_id = rs.getInt("training_record_id");
                int user_id = rs.getInt("user_id");
                int training_event_id = rs.getInt("training_event_id");
                Date date = rs.getDate("date");
                int number = rs.getInt("number");
                int time = rs.getInt("time");
                int calories_burned = rs.getInt("calories_burned");

                latestRecord = new MuscleRecord(training_record_id, user_id, training_event_id, date, number, time, calories_burned);
            }
        } catch (SQLException | URISyntaxException e) {
            e.printStackTrace();
        }

        return latestRecord;
    }
}
